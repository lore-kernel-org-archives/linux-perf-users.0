Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE229A331;
	Mon,  7 Jul 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891474; cv=pass; b=mwh0eXtOVh4WhLRZlHGXMPVHRNknaMTiWG5srv9yEfRGJmQlY0Y0Hu5uDQyl0i71juK/1ZMwULLP6vusWhV/CWYxmwTfdB9iOYpOi0wt63nDKQl26tqyfXDgWxcU0OifYEZxdY9j3x6EhUQcU9rx1pTVroGvumpir3xjQs9PU2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891474; c=relaxed/simple;
	bh=RFNsgxe2C6r+SN1MHnmdrNC2twMDtlwKmmZEi0IeFfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN3cSqP3TjCtk23/hO+whH+XxK5B4NNjefETNoABiUVdeGoc/rWhGd2CAmUXO3AU70hx8rXvvK0PwiB7/2mjOOPnnmuFkShz8aEDUsbmjP/ajUT6VggFrYF+NtStm1ASyjOOSC1Gc2wFDsn2ZoLLM2rQbAlkkIn7O6gQJe5sYYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=Gu2llJiI; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=cDJeZ0cq; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="Gu2llJiI";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="cDJeZ0cq"
ARC-Seal: i=1; a=rsa-sha256; t=1751891117; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=d1CqLAMQXRbwKaP24cKZDEfvDxAgCurI/UxqM3rEbgnZc3BxUpUUiWJzYzNT/KiRQs
    7c0L8wBcLENGJn2A+i7a+iKmaOBzQ0JOOYv2j3MUCIdje/I/yyQcA2MFXWlgpf1Ivx9h
    DYIkPBIuaYfUh33Rwht7UUrYTtXt5mmXBuj34tgqyug29uBeV2k0YzNK9UbI8LbfN4Y+
    R3hfzoePpeDHBP+BNyg5NBIEv4sJW4eOtfcoAz7jRGA178jrFH5AFsur128kThxwmoYa
    8GME7GYKzyvi2hr0//9sYZdiAjVCDT5/T04zn5p7tPTrj6PegaCUjTI8l4D8g85YHn6+
    IWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891117;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZFRrdSFaCSnM9EDX8a/HbF+5M4Jjf0Gf8M15CKb/DB0=;
    b=gI26z75+IWV7j7tuWTMlvkC4irToRlDbqbD9OZ/oEieso71muKA93U54ZIx2DGr7jC
    XeYk58DSz5Wiv/B5txkqHsMOGgbKKJndKn4EUCXEnnQpTwz/nNdLgQk7gM1DLpIr1j9r
    bmhprbfk13mQNn4ijyKxi372yJpq0v8dp/pczuv4YZALxYHeHjh9dJVEwBqQN8BWJnK+
    8ObclZwfiKK/tRGxtXDMREvRxhQ+YThZuvucPVtbFENruDgj/8n/q/zipgD7LarFZmSR
    rkT1+LtzSoxhfEuejUkdcZPS2v1u7WzmTAcvdFrbqHUGlHCZvGAcCn1LNn9wIFA+MdUu
    Sexw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891117;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZFRrdSFaCSnM9EDX8a/HbF+5M4Jjf0Gf8M15CKb/DB0=;
    b=Gu2llJiINjP2mOITX2ej9EYgt1CJ+R9HH7p0xQS9Wxtkz7ORjB+yw4RYaQlSycc/np
    m2LVNzcKwW+NvSMerCqJSA5ALKh84YXeb/VLUBUA1LdIAT+s8ywLhqijwykcCFmIBlF8
    eLPolgX+o0XsmSzKvJsFzqeA1blYZcIXceF9zrm++kxJ12A2Zz4UbUg1jQ27QALqoqQ2
    HC1rjyEr98V0pYcs9SR/B9HCjlEuHB5qRsrQwPHfRKhy6wiX4TXIyU+6hXQ3yxFq30yj
    DkIG5yt2kTeE9JJy51891ovH+N1vOA3FBhyAq+Xqxcgj5kc/WnDHEiI2njcf7oiHyew9
    UtIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751891117;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZFRrdSFaCSnM9EDX8a/HbF+5M4Jjf0Gf8M15CKb/DB0=;
    b=cDJeZ0cq4FBuy6ED+iNZNY3muKMkwsgTQ+qQlhOIYW24esaS+GWJ8+5tdW9ZysYjCS
    6pyvZUOHHHS4hT/YU0DA==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J1bd32167CPH717
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Jul 2025 14:25:17 +0200 (CEST)
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
Subject: [PATCH RESEND 4/5] tools: Remove unaligned/packed_struct.h header
Date: Mon,  7 Jul 2025 14:24:59 +0200
Message-Id: <20250707122500.724699-5-julian@outer-limits.org>
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

The functions in this header are deprecated and are not used anymore.
So, remove the header entirely.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 tools/include/linux/unaligned/packed_struct.h | 47 -------------------
 1 file changed, 47 deletions(-)
 delete mode 100644 tools/include/linux/unaligned/packed_struct.h

diff --git a/tools/include/linux/unaligned/packed_struct.h b/tools/include/linux/unaligned/packed_struct.h
deleted file mode 100644
index dbd93c7df2e1..000000000000
--- a/tools/include/linux/unaligned/packed_struct.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_PACKED_STRUCT_H
-#define _LINUX_UNALIGNED_PACKED_STRUCT_H
-
-#include <linux/kernel.h>
-
-struct __una_u16 { u16 x; } __packed;
-struct __una_u32 { u32 x; } __packed;
-struct __una_u64 { u64 x; } __packed;
-
-static inline u16 __get_unaligned_cpu16(const void *p)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *)p;
-	return ptr->x;
-}
-
-static inline u32 __get_unaligned_cpu32(const void *p)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
-	return ptr->x;
-}
-
-static inline u64 __get_unaligned_cpu64(const void *p)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *)p;
-	return ptr->x;
-}
-
-static inline void __put_unaligned_cpu16(u16 val, void *p)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *)p;
-	ptr->x = val;
-}
-
-static inline void __put_unaligned_cpu32(u32 val, void *p)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *)p;
-	ptr->x = val;
-}
-
-static inline void __put_unaligned_cpu64(u64 val, void *p)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *)p;
-	ptr->x = val;
-}
-
-#endif /* _LINUX_UNALIGNED_PACKED_STRUCT_H */
-- 
2.34.1

