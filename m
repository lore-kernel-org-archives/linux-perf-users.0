Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755781;
	b=UR2BDZDd/o0CFPumBTNos4YWTmRC59XA9um+BFGog1ToJsvLGuzae05DVALL1YVL7vXp
	 8JXqEqp3xpqem6IWkyy79wc/ScgtgsGRT/Yrno1bD15miMZVpVVAMm7+TLYjYHfZY2mzk
	 gll/V+lhdVg/8bdgKRDgw45dUEbrZMkX3Ofb+xXYetRuKj8uMa5gvM8yx8i/vp3ObbTmW
	 ch7aywrvNGnmU4ZheFXM/RLlv27kgBoIqjv+uQRmJer+p0h8k/lB7zxL/pe7xFp1TarHh
	 zkpKiYyKD1vFhqv0lH4mSOPklVqHrEJu7vJsmCX1Lj8yOjKYXsXQfmxVnw+y20xvFEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=KbI0rhMQhYQfeqR7VyDE1i5BNcfKuKWsIvq9RSQwXvs=;
	b=AfOPDu3ylX40c1Ud6OLPR6IwszT84IpMI0AOZj70seFPpn3HW5PZIzx2yOTzUjBCkCDn
	 pYYR8KIoLNSUTZMCYlfhbt4Y4EsT2B5b/ToUTQZyxDzYmHWxw2yVbxJtOb8eB01abErC5
	 NKMjoWhnDswo505Fg1cQ2Kbu4HENxKctp5Waw5MSrdPxKhutqthmX+di8W+YpbissqhtQ
	 D6cWcINUOshwc6BlqPToC4qQ5YCcC71AQedbkBW2w6LlH7hjTVulWPPoI3WERJIyObjdj
	 8Dep946y1KbFkZSplbggddiWRHrL96T6kFYlnnr3HgFsgnpMK1NVO6QVAfGkJ06rb4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJp4WUs+;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F22606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F22606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJp4WUs+
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b595601695so105607b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 21:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755780; x=1796360580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KbI0rhMQhYQfeqR7VyDE1i5BNcfKuKWsIvq9RSQwXvs=;
        b=WJp4WUs+hOF9VG1QSWQYjioDKs+09y5DNP/Ts9/hhyycT9+bTSkJ0WIEbSqY2m96QF
         b9hxVesImOdMOpJJ6BrQM/nrFm4HsauxpvUq3KZ1GgTpr2PbZUhlc6aC1+YZOfIfi/nk
         qIaYgtqL/5Oz0yaI9cGxu9xPhxxhbbzRWAyICmQXRrLgZJS4Ek1lD2JeXxEXXhyXkUl0
         V39WIPHbI6wVFBagnLWOzp1WR/YsMHem/2tHdo8IBCmUPVyP6yq7fAw2QWm9PipjBmq6
         IYf/H2ni8xxQ8dvyMbivl2oS9K0KQgKqe1yOjxLRI0Yth2XA9ib6z3XxmZbQ1sRrVVJU
         lz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755780; x=1796360580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbI0rhMQhYQfeqR7VyDE1i5BNcfKuKWsIvq9RSQwXvs=;
        b=hkmhBH3CkC8tk5nH94NpQtb7TewmIvaFXomfs6SYhw4Sw+zC43JO1rGpwevlhIJZwQ
         vJaeu2CNubPuMMsTIJi47iXaiFECeXUZAMswKPToRsUfWDz9B8891tP0lDOENmHtet9r
         3RC3Z3wuj0JaI+HKU21Bezn847tC7ZfEtx8r3wI1AeSP1a7o9nRwhOxuKcf9ZmmsPBJq
         LIPoOFeF6KEs7n2rGU6ixgsOGU4CPRPU/rMtmBxCbPQmemHlsdvgoofapMyeYcPLKUvK
         BUesvTW4Y3tcpbyOMxpvMq8XEidvV0AyXILzReWq2Bt+byqucwOFxLdshiNvBzPUbkOY
         GvIQ==
X-Forwarded-Encrypted: i=1; AL+hErHY7+L6xjZnvpIlZZVMoOc7wn2faGg4RZTae6A8+HQDeQvqHMKe/q3rmrVKVn6k+U4HTRGTo+VTkKiYq67b/KEu@vger.kernel.org
X-Gm-Message-State: APuU4Z+fTmGzCNE98fs1KpNO7KazjQvheG8kgiisas7X+kP+z77btDjP
	sWoA37vR94/K4RbvA5GjBggjZ9LWERcB4nELPdvtfRJNxMblgfuJz0ad
X-Gm-Gg: AZFdTZePpsC1c3yUApxTrSsY4b7kUWl4TzyMXx0lHy8qSisMIscyQsK44lg0wjga2ZB
	jONNht93YWU3Wriafw4H3fDTTt1s48KxSEzBR2cJPZJv0+FFwvCoTS5w1eLIszKhzek04OcDCsh
	6k/X8wT0+WNW7i53iv7dFtm6kB0i1qETsCLD0w0vVD/L8r3p0mWgXkqYDcMy770VMmyJzHUqZpv
	qcR0MrnzWjaC90YiIZ1xHois9Ggeoi7nowQ9MQL415p1snuGebirHTj/GSx02Qc+z/D9ZKtjGaV
	ILXvdWEg+wukXJy3b04PCR8ANSPFoCOwKQdhIiRaL1iNXblEsZuSm5xx1kY58ChhXQTvfC71Hto
	2BNXIzsa/PQ2eU4+miEDLqOyaNdYLaUrzNYoK/MhOJdHqr25F3yhpdRmWIzGy+MIieHKQRMhEDo
	wV8o/mVi1O0qFHuw8IFjpf2RnAnH3sUWEs4r8XPeHIT4mnfd906CJNqxaz4AitMv5gS88XAD181
	rvDZH3MwFCPdlCUnycAGfpJ4AQSALIxC0MmnOeuTSXrUcixI3G0IhNc0KyugYCl2vi+qhJVF4ZQ
	S8CiOzZMAshzsKzvxWqtb1MaMvyQmOBANxDsy/HD1MlMd9jwL/OnlIgBaUlMC5qCi/GNX+lHfOG
	Vm+cCF2ACvZv/sNBec7YVrxlPfqMZmXY8J33LGfhB5aM=
X-Received: by 2002:a05:690c:4d4a:b0:8b3:ba8c:2e77 with SMTP id 00721157ae682-8b52047e4a7mr72735317b3.33.1795755779922;
        Thu, 26 Nov 2026 21:02:59 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52033c2d4sm90735777b3.36.2026.11.26.21.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:02:59 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 27 Nov 2026 00:02:54 -0500
Subject: [PATCH 1/7] parisc: perf: swap the PCX-U and PCX-W RDR tables
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-parisc-perf-pa8800-v1-1-4f3f077010ce@gmail.com>
References: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
In-Reply-To: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=WSGfmKS9u083kTuUTG6vl0t/7ZIxmbwyYW67G7uEfhw=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5+f61/3F/bFL7Url2tmbx8W+b/25RCHH7VZQi/zry6
 xmjCU6bOz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOYa0waG/9lSdd5O2T
 e3Rn1bm3Fk/1fbsyn1/C0Cnn9vytfcjjcIMGJkWKT5/aDzWgfxg3aP3E9t5t718uiyCfq/GetMj
 n+YEeL5mR8A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf_rdr_tbl_W holds the PCX-U (PA-8000/PA-8200) RDR widths and
perf_rdr_tbl_U holds the PCX-W (PA-8500/PA-8600) widths, and it has been
that way since the driver was added. The driver's own code and data
show it:

 - The CUDA (PCX-W) counter read takes four 32-bit counters, two
   doublewords, from RDR15. perf_rdr_tbl_W says RDR15 is 8 bits wide;
   perf_rdr_tbl_U says 128.

 - The ONYX (PCX-U) counter read takes the counters from bits 1398 to
   1529 of RDR16, which needs RDR16 to be 1530 bits wide as in
   perf_rdr_tbl_W. perf_rdr_tbl_U says 1494.

 - perf_rdr_shift_in_W does nothing for RDR3, RDR7, RDR8, RDR9, RDR12
   and RDR19, which are absent in perf_rdr_tbl_U. perf_rdr_tbl_W gives
   RDR3, RDR7, RDR9 and RDR12 non-zero widths.

 - The ONYX images write RDR7, which is absent in perf_rdr_tbl_U, and the
   CUDA images write RDR15, which is 8 bits in perf_rdr_tbl_W.

 - The images are laid out for the swapped tables. RDR data is
   left-justified, so the bits past each RDR's width are zero. Read
   with perf_rdr_tbl_U, none of the 22 cuda_images sets a bit past the
   width of any RDR; read with perf_rdr_tbl_W, every image does in about
   two thirds of its RDRs. The same holds the other way round for the 44
   onyx_images. With the swapped tables both image families end in the
   same 9 Runway doublewords, and the CUDA images' Runway STATUS word
   then carries bits inside the 0x0013000000000000 mask that
   perf_write_image() applies.

 - The PA-8500/PA-8600 PDC firmware (from HP-UX 11.11 patch PHSS_25983)
   has an RDR description table whose widths equal perf_rdr_tbl_U in
   every entry.

As a result every CUDA image write shifts each RDR by the wrong amount
and loads RDR16 one doubleword early, the CUDA counter read returns 8
bits, and on PCX-U RDR7 is never written and the counters are taken
from a misaligned RDR16.

Swap the two tables' names, and correct the RDR20/21 and RDR22/23 widths
in the perf_bitmasks comments. The RDR20/21 mask already covers 158
bits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/perf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index 5e10f98ce7b5..8f9ae67270bd 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -67,8 +67,8 @@ static const int perf_rdrs_W[] =
 static const int perf_rdrs_U[] =
 	{ 0, 1, 4, 5, 6, 7, 16, 17, 18, 20, 21, 22, 23, 24, 25, -1 };
 
-/* RDR register descriptions for PCX-W */
-static const struct rdr_tbl_ent perf_rdr_tbl_W[] = {
+/* RDR register descriptions for PCX-U */
+static const struct rdr_tbl_ent perf_rdr_tbl_U[] = {
 	{ 19,	1,	8 },   /* RDR 0 */
 	{ 16,	1,	16 },  /* RDR 1 */
 	{ 72,	2,	0 },   /* RDR 2 */
@@ -103,8 +103,8 @@ static const struct rdr_tbl_ent perf_rdr_tbl_W[] = {
 	{ 16,	1,	0 },   /* RDR 31 */
 };
 
-/* RDR register descriptions for PCX-U */
-static const struct rdr_tbl_ent perf_rdr_tbl_U[] = {
+/* RDR register descriptions for PCX-W */
+static const struct rdr_tbl_ent perf_rdr_tbl_W[] = {
 	{ 19,	1,	8 },              /* RDR 0 */
 	{ 32,	1,	16 },             /* RDR 1 */
 	{ 20,	1,	0 },              /* RDR 2 */
@@ -147,10 +147,10 @@ static const uint64_t perf_bitmasks[] = {
 	0x0000000000000000ul,     /* first dbl word must be zero */
 	0xfdffe00000000000ul,     /* RDR0 bitmask */
 	0x003f000000000000ul,     /* RDR1 bitmask */
-	0x00fffffffffffffful,     /* RDR20-RDR21 bitmask (152 bits) */
+	0x00fffffffffffffful,     /* RDR20-RDR21 bitmask (158 bits) */
 	0xfffffffffffffffful,
 	0xfffffffc00000000ul,
-	0xfffffffffffffffful,     /* RDR22-RDR23 bitmask (233 bits) */
+	0xfffffffffffffffful,     /* RDR22-RDR23 bitmask (194 bits) */
 	0xfffffffffffffffful,
 	0xfffffffffffffffcul,
 	0xff00000000000000ul

-- 
2.56.1

