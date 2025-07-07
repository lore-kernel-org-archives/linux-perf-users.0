Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A96AD21;
	Mon,  7 Jul 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891470; cv=pass; b=kGE8V7PKDGaMf94vr25fUtNXndKDwpSI1Dt2GBK46WgrUn+fo1bBoh3ywCJ5HFGHSRV1ze9EC86+L1uQDBODso1JrAkCgkpb67WFjcLd98zSov07N8JEotFVANqnWA1WBCYXouzFXGzjZDW5bFwtz5uaQQk3xC7958f53BfiYb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891470; c=relaxed/simple;
	bh=3686iIqcrD1v0rIwnE5BDEhqKpyTR1lXHiLv92Viv20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izqtcYrQSUZSwihSrI8N3t3U9eGtJ6zG1Mchj3ElucN3O07QLUdJ3M49Hn711+hxP38jiB95fM0N3FIAETUjKi7+J0NsBUKhEUtxBRyFVOVfqQHDKe1UUM6O7JDMHcs7GC/G4nz3uK0SyIo80B9S2oBH3v7/913hSdoYonNRgYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=Ui4jOvCk; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=TqsNTytV; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="Ui4jOvCk";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="TqsNTytV"
ARC-Seal: i=1; a=rsa-sha256; t=1751891115; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DqaubCnZMp6bLgDWtNIBiLcD1MyeJM/9H/6m7WhnkCl0ciZtjU9vpJyv+sgKx/a81G
    H8Dp2ggI+IdYXLaf9Woi/APm9pSK52d7Qzy4m0RHhOwGMMpoaamMOfDX0H1vH0ceIYHV
    xP9NG6WuH+9Ws4CgG5hiphfDgz56OOEmmeFjdpH+IgodkatKsZqrEGQ0VNTu6In5l0fJ
    Df6dx3AQtmruvqEL/wrz6fzVX8p92pHYArfPpcrtz3YwAPnTgb/wn+/8A+N8EN9FKeYz
    OK8vHgRy2uNADECA+YyY5RD76mdHQ2mfTDUpynYrfeqz44/L8frbQu7Ie7WFxM3XtOhJ
    4WIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891115;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Uw2joeTt8PfL+vQ6RmT2S3am/XAVy6q4yrugxQwId/U=;
    b=AJUcd/noiOUPy7rO03KbgRvuab+zfnZjp0kfrAmomtYkmk3Dv3En6jl50sm7eLyTNL
    rn9wZA2fjizScgVeAOOfmuPmrDk+4t0dz9wVJFMyurnFOPJX8VZHDUMsPmwxIWtxbIfA
    3ip1psMQm7SMeLxyrXmwQyVYTRXzoRMVIoav0jlMu+B0L0tvV6DKcwLb84RdlBpUPwLB
    EAScTyAB4q6Iv6oA+3dXIoBKWha9tpooYAN/YXjueUs0TPCe5OlgAmhOTOPI2bw9Xffa
    V+H96+rkEMJbxSH611topiHOYar4UQApQRhyjIEq5IQKwCjzIp2t/uu/4wriv8+onquD
    xjgg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891115;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Uw2joeTt8PfL+vQ6RmT2S3am/XAVy6q4yrugxQwId/U=;
    b=Ui4jOvCke4ATdPbLMoTR60JHZOy5UcmnkHiMNgHSrBXELOa6CmeWROtlp+F7E/TS+L
    0k/ASo7Sg9SPAN0BPTN8cZPMKEZ9r0OwKBXRk5kOddvxpHsdHjccXgCZZO1ONqwtnDMe
    8TeBIbxUJYouKP0+i4eXpAk7Q9asu7A+eth6HSD3r/aVTNn80Uf3DflBSy9cTEdwu3u2
    gYmOeAOoLjXV5U7UYfZ5rj3HcDGFneugWeZmTxUD2ZNAErvAs3yTz73WpvNLzcfHb+i1
    wsUh1vakzS81TPk9Qc1xaX0l8cfe7o9zandcMcxaKpHpyfjeNZVW3W+FDKCj/YagUjMt
    yOPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751891115;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Uw2joeTt8PfL+vQ6RmT2S3am/XAVy6q4yrugxQwId/U=;
    b=TqsNTytV284J+D3b5tLesOQZIwJp9fq6hZVj39JpNaoJFUVIp5GRGnhPnkBLD0WUnj
    8iF/5U6fTA8btC3pFrAg==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J1bd32167CPE712
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Jul 2025 14:25:14 +0200 (CEST)
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
Subject: [PATCH RESEND 1/5] Replace __get_unaligned_cpu32 in jhash function
Date: Mon,  7 Jul 2025 14:24:56 +0200
Message-Id: <20250707122500.724699-2-julian@outer-limits.org>
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
 include/linux/jhash.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/jhash.h b/include/linux/jhash.h
index fa26a2dd3b52..7c1c1821c694 100644
--- a/include/linux/jhash.h
+++ b/include/linux/jhash.h
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

