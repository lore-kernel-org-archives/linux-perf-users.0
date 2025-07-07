Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9519F41C;
	Mon,  7 Jul 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891292; cv=pass; b=TAA5V77F3XvJ0SRtdnfJSRH1d+CA0Sf91jZ0sUjMdtLMaOGHR/HcURyjXUbejyOLFosLCEHig2zMqII8TQLf9gS8QcdX4pJ8scJFyIeSXFNRnqQKWOFNCBpuEvH1jFRiMoX//atIj895eQrvNBswYGxHiAfYtzoZyD5nEktuRHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891292; c=relaxed/simple;
	bh=iF6svWQxjhfH01K5GB6VJBFDspeZkf1NcAWZPZoRlP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3tHvW+Oag1rMyAvUQwG50fVBevlo6nZzjTwX3mPKxH2uq4fHBjqQk7gbJqmN4+PBNdPrtT7ubzQlXHWhLYwIyzVHgYSGqWiwYO23hIrFaSc/TxCfpM/PslRlpSBOi9XcK4Bj4Hikdb0h2+eel3+0GItqYoBOvm02wzJuG4ZFcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=Bdkg20iO; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=OrFmtsad; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="Bdkg20iO";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="OrFmtsad"
ARC-Seal: i=1; a=rsa-sha256; t=1751891116; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CmyLSpV0f0A6u/wPTg6M/HJeDLkeGstf09O8ADNSEsshTnZvhZ1EHsDlrWd2RAnie/
    RxHB3d+oyBcHxTBzi/GErimzZjZlFQ/aB17PC4vA3vtoihKDxIORIg0pPnMhLoJFLUAt
    NRD3v2prdkHJ153gCmf1F4u1bS3Zuu2MorpgutLfNG9Pn0g6QmhIRxkGbhPaf0oeUbEj
    H9SveKs1HtGcD2wCcbbuRiI5oEWS3rOqZoQ0DBh9MpyjZ6QmvPtqhZqA6ppvqarup0EU
    0P8F9+EfvmKjf/P+XNBUn4eSu1MasLgOHzp+Z2/8myYUljN0cpmFe9ypk/+UIy8rHIyB
    F6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891116;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EVp3iPa/GUn3mF6v3cUjP293u2lfu/v36mq2O4KGlBE=;
    b=e8ZfLwhqKedh8v9UYoDqmSibGHqx2gySksYO0pMy8kraNTwW8uohoButlB3VEkLW+k
    AHZgKWide+uHWQ9iu49dEZEY0oiF9s1WaHjxv3d3FRX0AKBgEUm8X/h6eMiwc9S3ZOM2
    /+8PW2Dsp3JWKstKK5WoxkJCes66V2OTJweMmn7LdHPPdra9X7OqomuosOGUITK0OMhi
    zekh2Z/RkyklRbTuWviRea22qC57eckckmoEoLCgBL/CmT02sL+kCmxGtfn2qwaIDCEw
    RIEFwgAnPrjUWPjciFAtDWDg5SazxPoxRDiDv697levVvWJGBjwkPiQDes+L9o8AW1AZ
    nF4Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891116;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EVp3iPa/GUn3mF6v3cUjP293u2lfu/v36mq2O4KGlBE=;
    b=Bdkg20iOdKsh1NuxcCxBADqfLmfPnnZlCNYV15wzsPE/+8ReAA3yawiafx2GzNHXvo
    d7so43mN4zr/e9YikLUdMcrgv4CCzWY/J1RyLAQf51NkojQveiS0fnFJq9HRvV+d61O7
    GcEKUs0sl5orwd+JEi/eQ5bMHQdsC1ltR30h1z1vEQclo9XcjqSGmEaRvU8lrTaFpJoy
    RQToWb+Y8Vzy4g7dUQEYyftFMBsALkeBb4Jwf2Z5nXMYTbDMrAt2kXT5D2fN72RFVlHe
    +lp4CYqXLBIIVSWx+z2FNc3y0aF6hG+YMfHYXa/c6Sq+KrZqLYhxTPBdy/qV9ik/2rf3
    G2Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751891116;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EVp3iPa/GUn3mF6v3cUjP293u2lfu/v36mq2O4KGlBE=;
    b=OrFmtsadi6gzppAd9HFMYY5G/jlF3mEbloSVhHcHblVuMZw8bazkGTz17TiOwhrAGb
    xt6O4H3MPNxXQR2yyUDg==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J1bd32167CPG714
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Jul 2025 14:25:16 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH RESEND 3/5] tools: Replace __get_unaligned_cpu32 in jhash function
Date: Mon,  7 Jul 2025 14:24:58 +0200
Message-Id: <20250707122500.724699-4-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707122500.724699-1-julian@outer-limits.org>
References: <20250707122500.724699-1-julian@outer-limits.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The __get_unaligned_cpu32 function is deprecated. So, replace it with
the more generic get_unaligned and just cast the input parameter.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 tools/include/linux/jhash.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/include/linux/jhash.h b/tools/include/linux/jhash.h
index af8d0fe1c6ce..5ff3c8275281 100644
--- a/tools/include/linux/jhash.h
+++ b/tools/include/linux/jhash.h
@@ -24,7 +24,7 @@
  * Jozsef
  */
 #include <linux/bitops.h>
-#include <linux/unaligned/packed_struct.h>
+#include <linux/unaligned.h>
 
 /* Best hash sizes are of power of two */
 #define jhash_size(n)   ((u32)1<<(n))
@@ -77,9 +77,9 @@ static inline u32 jhash(const void *key, u32 length, u32 initval)
 
 	/* All but the last block: affect some 32 bits of (a,b,c) */
 	while (length > 12) {
-		a += __get_unaligned_cpu32(k);
-		b += __get_unaligned_cpu32(k + 4);
-		c += __get_unaligned_cpu32(k + 8);
+		a += get_unaligned((u32 *)k);
+		b += get_unaligned((u32 *)(k + 4));
+		c += get_unaligned((u32 *)(k + 8));
 		__jhash_mix(a, b, c);
 		length -= 12;
 		k += 12;
-- 
2.34.1

