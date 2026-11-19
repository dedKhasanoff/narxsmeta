# Narxnoma sayti (A5 PDF + QR tekshiruv)

QR tekshiruv manzili: `index.html` dagi `QR_BASE` (hozir https://glvkuiops.netlify.app/). Sayt GitHub Pages'da ham ishlaydi: https://dedkhasanoff.github.io/narxsmeta/

Bitta fayldan iborat statik sayt (`index.html`). Foydalanuvchi mahsulot, soni va narxni kiritadi, sayt summalarni hisoblaydi va A5 formatda PDF beradi. Har bir PDF'da noyob tekshiruv kodi va QR kod bor; QR skaner qilinsa, asl hujjat (mahsulotlar, narxlar, jami) tekshiruv sahifasida ochiladi. Bu hujjatni o'zgartirib soxtalashtirishni qiyinlashtiradi.

Hujjatlar bazasi: Supabase (bepul tarif). Hosting: Cloudflare Pages yoki GitHub Pages (bepul).

## Claude Code uchun vazifa
Foydalanuvchi o'zbek tilida gaplashadi. Quyidagini bajaring, har bir qadamda nima qilayotganingizni qisqa ayting:

1. Foydalanuvchidan so'rang: Supabase'ga allaqachon kirganmi (GitHub orqali)? Loyiha ochilganmi?
2. Supabase loyihasini tayyorlang (brauzer orqali yoki Supabase CLI bilan):
   - Authentication > Providers > Email: **yangi foydalanuvchi ro'yxatdan o'tishini o'chirish** ("Allow new users to sign up" = off).
   - Authentication > Users: foydalanuvchi o'z emaili va parolini yaratsin (parolni foydalanuvchining o'zi kiritadi, siz uni bilmasligingiz kerak). "Auto confirm" yoqilgan bo'lsin.
   - `supabase/schema.sql` ni SQL Editor orqali ishga tushiring.
3. Project URL va **anon/publishable** kalitini oling. `index.html` ichidagi shu qatorni almashtiring:
   `var CFG={url:"SUPABASE_URL_BU_YERGA",key:"SUPABASE_KALIT_BU_YERGA"};`
   - **service_role / secret kalitni HECH QACHON** faylga yozmang yoki commit qilmang.
4. Joylash: `index.html` ni GitHub repo'ga qo'yib GitHub Pages yoqing (yoki Cloudflare Pages'ga yuklang). Tayyor havolani foydalanuvchiga bering.
5. Tekshiring:
   - Saytni oching, "Egasi uchun kirish"da emaili/paroli bilan kiring.
   - Narxnoma tuzib "A5 PDF yuklab olish" bosing: PDF'da QR va 8 belgili kod chiqishi kerak.
   - Saytdagi "Hujjatni tekshirish" bo'limida shu kodni kiriting: hujjat ko'rinishi kerak.
   - Kirmasdan (yashirin oynada) `#check-KOD` havolasini oching: tekshiruv ishlashi, lekin yozish/ro'yxat ishlamasligi kerak.
6. Xavfsizlik tekshiruvi: anon kalit bilan `docs` jadvalidan to'g'ridan-to'g'ri `select` ishlamasligini (RLS) va yangi foydalanuvchi ro'yxatdan o'ta olmasligini tasdiqlang.

## Fayllar
- `index.html` - butun sayt (jsPDF, autotable, qrcode-generator kutubxonalari cdnjs'dan yuklanadi).
- `supabase/schema.sql` - jadval, RLS va `get_doc` funksiyasi.
- `namuna_narxnoma_A5.pdf` - natija qanday ko'rinishini ko'rsatuvchi namuna (QR kodsiz).

## Muhim cheklovlar
- Sayt faqat o'z narxnomalarini (taklif / hisob-kitob) tuzish uchun. Boshqa firma nomidan faktura yoki asl hujjatni o'zgartirib chiqarish uchun ishlatilmaydi.
- QR tekshiruvi faqat shu sayt orqali saqlangan hujjatlarni tasdiqlaydi.
- Mahsulot nomlari va narxlari brauzerda (localStorage) eslab qolinadi, bazada emas.
