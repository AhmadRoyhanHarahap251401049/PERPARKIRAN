program perparkiran;
uses crt;

type
    TWaktu = record
    jam, menit: integer;
end;

    TTransaksi = record
    plat: string[10];
    jenis: integer;   
    masuk, keluar: TWaktu;
    durasiJam: integer;
    biaya: real;
end;

    PTransaksi = ^TTransaksi;

var
    tarif: array[1..2] of real;   
    lanjut: char;
    p: PTransaksi;

function menit(w: TWaktu): integer;
begin
    menit := w.jam*60 + w.menit;
end;

function durasiJam(masuk, keluar: TWaktu): integer;
var m1,m2: integer;
begin
    m1 := menit(masuk);
    m2 := menit(keluar);
    if m2 < m1 then m2 := m2 + 24*60;   
    durasiJam := (m2 - m1 + 59) div 60; 
end;

function hitungBiaya(jenis, jam: integer): real;
begin
  hitungBiaya := tarif[jenis] * jam;
end;

procedure inputWaktu(var w: TWaktu; info: string);
begin
    write(info,' jam (0-23): '); readln(w.jam);
    write(info,' menit (0-59): '); readln(w.menit);
end;

procedure inputTransaksi(p: PTransaksi);
begin
    writeln('=== Input Data Parkir ===');
    write('Plat nomor: '); readln(p^.plat);

repeat
    write('Jenis kendaraan (1=Motor,2=Mobil): ');
    readln(p^.jenis);
until (p^.jenis=1) or (p^.jenis=2);

    inputWaktu(p^.masuk,'Masuk');
    inputWaktu(p^.keluar,'Keluar');
    p^.durasiJam := durasiJam(p^.masuk,p^.keluar);
    p^.biaya := hitungBiaya(p^.jenis,p^.durasiJam);
end;


procedure cetakStruk(p: TTransaksi);
begin
    writeln('--- STRUK PARKIR ---');
    writeln('Plat   : ',p.plat);
    if p.jenis=1 then writeln('Jenis  : Motor')
    else writeln('Jenis  : Mobil');
    writeln('Durasi : ',p.durasiJam,' jam');
    writeln('Biaya  : Rp',p.biaya:0:0);
    writeln('---------------------');
end;

begin
    clrscr;
        tarif[1] := 2000; 
        tarif[2] := 4000; 
        writeln('Kalkulator Biaya Parkir Dinamis');
        writeln('Tarif: Motor=Rp',tarif[1]:0:0,'/jam, Mobil=Rp',tarif[2]:0:0,'/jam');
        writeln;

repeat
    new(p);
    inputTransaksi(p);

    if p^.durasiJam=0 then
        writeln('Durasi 0 jam, gratis.')
    else
    cetakStruk(p^);
    dispose(p);

    write('Hitung transaksi lain? (Y/T): ');
    readln(lanjut);
    lanjut := upcase(lanjut);
until lanjut <> 'Y';

    writeln('Terima kasih. Program selesai.');
end.