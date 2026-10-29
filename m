Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793265509;
	b=N0T5e5ovG7QSF7NFBAzuC1+vfwMwUen6r9n1sHibS8hNRtib67bT3+bGoxmSe/+o5T7p
	 GR7or8L38lAkDMfsIV26hkIMzluB1DvEyYXePsoDwgQOOKTzOG0iG0LIHco0Inwg0Rxnq
	 sNEh01m4wCD8EVmnBSDILkr6ped0VN1dNC4PPTVXi/snLs/QOcGYDTAewUp7RdAV1ucCi
	 lgiYLbzzghZuyVehTVg51An1lzMn2FY2AbfDAysKF8lIvQJPTWKdPnD149ZhSt+oVyjRC
	 r1IBUh6StfnM75eXtqIPZQNiD87Kc8PR5jSAY7Sk1MFHmYfaW7VuqDrZnG+yh4BxAog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265509;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=6uY21tdKKM6PLzs79GpUqrjknra5fIvf0Pr+3zgyGpo=;
	b=Z2wxrH+KbBw2erFs9aZZMXtnWzmsgO3TncAoq86ddyi5kyjmiqKbyt+MzxxvFa67/c9T
	 xZkuEUmt1ewQAYD2xQb6kyS3AsxBkhFXaoA1AN2/EdBJlE6JDWpyIYx2n8BWXtSWAmhDu
	 sBEC4dKLvxSSqilozQB2g5NPTjzM915UApPfr9t9gF29ZZ67a2uCkvABT++H6tY3WPUmo
	 +mFO7w3ZdVaD/qgX0qV5uXFeAl+gXYkidrsEDG5PhBTO2okFEUjA3zYSU8xflh2QJU09D
	 j3Nk6s6yY/PgYe7FOiU4csOYaniXEVzJ7J9NV5qMT+Sg30cZKE7brFXSN0cX9yX2JOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outer-limits.org;
	spf=pass smtp.mailfrom=outer-limits.org;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=U+SiWCHG;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="D/EG5u/t";
	arc=fail smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F0606A327;
	Thu, 29 Oct 2026 09:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4F0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=U+SiWCHG;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=D/EG5u/t
ARC-Seal: i=1; a=rsa-sha256; t=1793265498; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wi70JQeCk9ZGa7NZQSelHUv4kR0PtOpL1adtMQnCkvDYtCA47ao6dQ+UDC4G9MgXBD
    sKRqjYiUV1VYwR9ukjoTd6AHR6365ltG4GM84ysnvPrzUcQOhRrvcOm0gmOUCzPuwni2
    0SLtPILKMRELUXRIlwS8bbu2irlRoiAMgwKBkNEQPNekVjyQCur4OTxW5Whil5wdFvtz
    T/b1At33fXsxtR9JplnadCkl454lj7VtRModUO5CDH1XV+5XWgvdRw18zKirBQ5M7g24
    rB3+WWsKuA1uUc5sBx2rzUGINu9B/cr4egs3H8ZVxZYUlZoivWTSMdNXkKoIhzi22dDm
    KVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793265498;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6uY21tdKKM6PLzs79GpUqrjknra5fIvf0Pr+3zgyGpo=;
    b=ZG3VIsh1YACODawcNm+F0hSDx+ZRu8c9eMH7n5sHanw+htMeXZZJ8x+KN+3ROFnuR+
    XQp7dYLDQwyJc7TFkydnZmv4yUxknrR1UMYk9dgTLb3qpDwDYltuAXDSKcIXYkeq4CZf
    DYfmFcVcUdQR65VmS7+pY1e92ImNZFJPzRnWUQ1TKIt081jB+s/L6oHjnMc4iW6cikU3
    9Yxu7yMnHogW3K8jofQGUpkeTWsgh01hENczzqya8m0fBOOYIaeENtuV05ogn4OEp2hO
    hNyJo22Jwklrwo2LTa4v+iwpWfHZvGi2ljpeSv2uPJg4LzahKlzHebT0YboE6jVErWRI
    KcJA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793265498;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6uY21tdKKM6PLzs79GpUqrjknra5fIvf0Pr+3zgyGpo=;
    b=U+SiWCHGRdz3SJUYbi7Nw5TB4hB+GBTMvsR/aIlJf9XpftWwkgem0dxUdZwH0SNs6Y
    VjbZ0RdjEHojrAqBrHAE0U1eMB4nFfw7tPVrVC5z/hc7udmVZR/ZUAWEm5XphxbKwZYc
    O2m6JMXoUe1HQjuGKURE2Kcb9IuMVw8ZgKcrec/U2wmb8aMyr1Rwr0VaXetqedIZbhzc
    kWzWxzpUyzugqKVPiO8nibwR7A9yYxr/ZN+2tE01sqWaF7/Q2OPkzKm1nRoT0MAkvhUJ
    YqRrbOgXuWFNNbPp6eW7crbzzGr4ECi057QxwfB1ZPtjJTa/VuFxscwTJIdXdiLt2Whj
    wAsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793265498;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6uY21tdKKM6PLzs79GpUqrjknra5fIvf0Pr+3zgyGpo=;
    b=D/EG5u/tfPrp05S/0DtQ6lb9loG1GGhRVltA9OozYXQm1N/jHCORrteUCB9M84sdbN
    rNahgwmw6MLd9IsH3PAw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk1Z5IDmIqDY7xpnOs6mGD64frXxHtrE3e66udIGwZnWwLgga9o="
Received: from julian.home
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id J82cde29T9IIvXN
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
Subject: [PATCH v2 1/2] include/linux/unaligned.h: remove deprecated __get_unaligned_cpuX() helpers
Date: Thu, 29 Oct 2026 10:17:35 +0100
Message-ID: <20261029091736.28742-2-julian@outer-limits.org>
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

The __get_unaligned_cpu16/32/64() and __put_unaligned_cpu16/32/64()
helpers are deprecated and all users have been converted to the more
generic get_unaligned() and put_unaligned(). So, remove
linux/unaligned/packed_struct.h, and drop its inclusion from
linux/unaligned.h.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 include/linux/unaligned.h               |  1 -
 include/linux/unaligned/packed_struct.h | 46 -------------------------
 2 files changed, 47 deletions(-)
 delete mode 100644 include/linux/unaligned/packed_struct.h

diff --git a/include/linux/unaligned.h b/include/linux/unaligned.h
index 4a9651017e3c..18c4b0c00e2a 100644
--- a/include/linux/unaligned.h
+++ b/include/linux/unaligned.h
@@ -6,7 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#include <linux/unaligned/packed_struct.h>
 #include <asm/byteorder.h>
 #include <vdso/unaligned.h>
 
diff --git a/include/linux/unaligned/packed_struct.h b/include/linux/unaligned/packed_struct.h
deleted file mode 100644
index f4c8eaf4d012..000000000000
--- a/include/linux/unaligned/packed_struct.h
+++ /dev/null
@@ -1,46 +0,0 @@
-#ifndef _LINUX_UNALIGNED_PACKED_STRUCT_H
-#define _LINUX_UNALIGNED_PACKED_STRUCT_H
-
-#include <linux/types.h>
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
2.53.0

