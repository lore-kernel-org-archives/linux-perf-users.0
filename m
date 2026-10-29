Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793265509;
	b=jc8+v0vm12WWWboLAFndnZmscTK7yw4EzLAqAexR1e65JpE0aemDQC41b9BxB/z0/KN0
	 SStxSwP3tPE7u3naoQ4GWwwJH7EfuxgQnI5wlRqRDNyKUPz5tZDYsO5yxVfRvfYjqfQtJ
	 DclyIRLml+5lanqyOP4RSTxq34C6NDyU2EZM4yFEcLpgIvSfVye9Fagt7HtPluY+MxZDH
	 qn/SMlbxG1p45yNo/59x62/HQN3HYVHGN+QmtDoeON8fVD7/gpw2T8sCYQ1Yv76sFgKWr
	 WNUTt2XQ/bvR8rWHVkRUsIGjThxKLarAnGgdfPcLDCnOsjW0fsKxtg74zyCOY0QqsyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265509;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=t3IPtcLzPvP015li8smXOKjxvBzu3DaRdAnW4nY7Rn8=;
	b=iUqyiFOnrjz2UowwjKMCC6u/R8bwRBEo1KNf4TypGzob0fu3ecUc8tsmrUlIhsGl0fP/
	 twKI8n1lrDXb32BblpRMnJGrr+ezFVdWjFm++Q+nuzae8e2G5aYXmi5y7BCsT3Xn5n84Q
	 uuerHZQtqkEn6fzYEckpSi1WgSASAK78ujO3qcDH4Bb46lOPmyfElMbDjd3RcWz0ujZY+
	 o85ckqvLth/B3CdBX7BRueuvj/oOQF5sc2aLmxyNmDAYP5zj0KIfS2eBfmyW6yZ/2npVk
	 rDurPldy34l2/8IZ1apix1EBAvoX5sy86r5HzqTvS2n5ohQedUBTdvlfrLjHq2dwBXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outer-limits.org;
	spf=pass smtp.mailfrom=outer-limits.org;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=C99yTF57;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=+4qK1bwg;
	arc=fail smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B2606A32A;
	Thu, 29 Oct 2026 09:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E7B2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=C99yTF57;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=+4qK1bwg
ARC-Seal: i=1; a=rsa-sha256; t=1793265499; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XKXYiOnTic9YM89geiz1lAU7FqtIXO9HfGyyAcL/+GgkBsR1Uxo2t3dYVh3P69RfXX
    pD7GDN0EnnMpgw1T8mxT0HK7XvZvEbYmZwXyNbXRUGUnt85GNhWx1BJLyVcGXD5AidP7
    Bz+iF8qKPZ7XoDtQPF7R6GQ35lgzxzdCGvOU/jeyCuuacOa9ZR96eRPAO0HRJt3o509F
    jJKj6F7/qOzmOeHAKfJ+AYmF58pPvDxwHMCviLJXaY2xF7MkCXNYHqkZs4EvLDRwTv+i
    z/ns+7sO6jIlJMv8eBfBWXs3cY6mx4/C8haxF+g/ogT2v5UJXS27z7fhXsvl8xHAA1AU
    LUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793265499;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=t3IPtcLzPvP015li8smXOKjxvBzu3DaRdAnW4nY7Rn8=;
    b=l3AlTp+UQUz4aeAL7TBzu/mhLr0hSWjBzQn/rKp3qkDu+rqZ1TQ3PfhLlokgwfRVBZ
    mDJNQA4vZzDyoOiYctZzig6KDTQQe4rGvRFH8avEevXhsm8tfLx/fTvejTGeqhI0ibOr
    JULyCZarqTLRYA5Je3tpION02jh30vdNPSdtyu1Ol10IjE/lne/sEHuC6aQFRw/B84X+
    z6F7Mow4Fxo0Z1bp53HaFlbNSOinVL96Ly4D/gQXv27ClV4m8rrlKTj2P+tK0Oo4pdIW
    XLz8xRgBsDQj4b6mWdOWBWjEI53y9eVkQAUyBVqwajGTtKkYKNIkL7vRsyXSKq35pV9Y
    Pqmg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793265499;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=t3IPtcLzPvP015li8smXOKjxvBzu3DaRdAnW4nY7Rn8=;
    b=C99yTF57EFEuGgZyBa4715Wo7qTwPC6PdMxFp1PA0GFpRcoKNFDoDJgiSxwpB/kz0V
    c8kvgHSyqcZyiMdfgnSfbpIiGSQfoqUkjJqgfMB+aeTqgCHXG216HC9g1D4IutmyPEVa
    X99YdJUqo69ocsm9FQ27HDwns15WXYPzcI+RLSsWEqMH4JWma9Zui6aMbl2PQYsvAcMz
    U+9rAbIERjRimO/bFnBdvw3Q57l4Olk4VXBKQw5LlZg4AOz8H2RbnDLaOu2THstlt+oE
    CnNDDsTrihXF5xqpRuAAG1F7MBVcIJ9bFEOfEbf7UXmwzC5ZjQaV7vPdzJqx2k9BVnRA
    4u/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793265499;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=t3IPtcLzPvP015li8smXOKjxvBzu3DaRdAnW4nY7Rn8=;
    b=+4qK1bwgGw79zvvQpu2fBGLZ0ni3rd4GvCDqFwwHmtio41e+LUOoy8d+ZmNCwcr4QA
    yhFW4mfmvEb9zQALDFCQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk1Z5IDmIqDY7xpnOs6mGD64frXxHtrE3e66udIGwZnWwLgga9o="
Received: from julian.home
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id J82cde29T9IIvXO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Oct 2026 10:18:18 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH v2 2/2] tools/include/linux/jhash.h: replace __get_unaligned_cpu32 in jhash function
Date: Thu, 29 Oct 2026 10:17:36 +0100
Message-ID: <20261029091736.28742-3-julian@outer-limits.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029091736.28742-1-julian@outer-limits.org>
References: <20261029091736.28742-1-julian@outer-limits.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

__get_unaligned_cpu32() is deprecated. So, replace it with the more
generic get_unaligned() and just cast the input parameter, like it was
done for the kernel copy of jhash.h.

linux/unaligned/packed_struct.h used to pull in linux/kernel.h, which
provides the byte order helpers needed by linux/unaligned.h, so include
it explicitly.

With jhash.h converted, the tools copy of packed_struct.h has no users
left, so remove it. Also drop the packed_struct.h and "#pragma GCC
diagnostic" in check-headers.sh.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 tools/include/linux/jhash.h                   |  9 ++--
 tools/include/linux/unaligned/packed_struct.h | 47 -------------------
 tools/perf/check-headers.sh                   |  2 +-
 3 files changed, 6 insertions(+), 52 deletions(-)
 delete mode 100644 tools/include/linux/unaligned/packed_struct.h

diff --git a/tools/include/linux/jhash.h b/tools/include/linux/jhash.h
index af8d0fe1c6ce..df524ee14bcd 100644
--- a/tools/include/linux/jhash.h
+++ b/tools/include/linux/jhash.h
@@ -24,7 +24,8 @@
  * Jozsef
  */
 #include <linux/bitops.h>
-#include <linux/unaligned/packed_struct.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
 
 /* Best hash sizes are of power of two */
 #define jhash_size(n)   ((u32)1<<(n))
@@ -77,9 +78,9 @@ static inline u32 jhash(const void *key, u32 length, u32 initval)
 
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
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..39d9c7182f9b 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -187,7 +187,7 @@ done
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd/ibs.h  '-I "^#include .*/msr-index.h"'
-check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
+check include/linux/unaligned.h '-I "^#include <asm/byteorder.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
-- 
2.53.0

