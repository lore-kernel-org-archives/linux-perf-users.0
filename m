Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE431E22FC;
	Mon,  7 Jul 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891835; cv=pass; b=J46aoot1O8vy8LOOOAJwDP9Egz6ibNqEsdQ+x7pyXHYOvTn1mdOufnhrjs87vx+8El3KvIS/z7USzXkX5tYUhY/IrdMs+DOqfwiP9yCNa2WbowE6qHt6WN3oGqSZWb8rphORlRLMviDI/KToiB//Z6enxpZbqR0nu3c9LFcvLmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891835; c=relaxed/simple;
	bh=zfPixgraChrKlrOtDN03mFy1u9SB7MFeA7PL4QVarWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6dfHD6QxBpUzuUUTuuO+oaQ3Asv1jJSKs172SMHDtGqPHlPVpAVFIdP3tZeC9EO1HMgFrMUIn4eIkVe2mGetoParFCPXDQl1d5YOWYh7Er4sYeqctUZ6mtLYVirpiuLZGx43q+RmXJE1CuFnyrgLoH3kGIHcKt2+KMpnlKnV4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=evVnL+mX; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=N0P372Jm; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="evVnL+mX";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="N0P372Jm"
ARC-Seal: i=1; a=rsa-sha256; t=1751891116; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kl3PZe0NybvuaA5ZM+B6CtV0aojTZ6ao89Ksjw6r2CjrtmrePS/BA2PNWDj2a3dbDJ
    ILAgvUZ2um+EbD/hIagF9ge5bUsdUNcj7h7HF3iJHicZjZZJEmoSXzLugy71fAKNSCHT
    YDFJhtgLVKyM2z0K5Z0NLllNJSOSQi+8zbyr3lC2EIhZ8ZY6vx8Q7IiPjUb2vJ+y7o4B
    nUMwjq6ZlRd+aVp22lhcdY/8ybV3KJ6C4KfMgB2FJRj9vmapnI9OrzEEv8eU/IkK6FLb
    LeTfKjYcSykmFouMqng6T6ixUjDYZdSo04t8U39eK6fZ2mvVG8I2psFJJsx5a3Xr9uAK
    rZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891116;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mCZv9h5y7Ee5tNYV9yYrClTj5aivwr6YfqNK0mRGc2E=;
    b=iOzdbGNhPYfRZoJvyJNEocVbfZ1pnITVdH+ObT0IP/v4jIpyKJTelOjuqDq1q83cmt
    ASHkG9oScWFVPpY4WZHqGuskdvL6aLRpC5PFKSVBqywD3Fv+1LzUMvrplJkCHtLgsIeY
    5yT56qoZv4Jvdpr1Z3XgS9mvMmjcYj0sW5z4cCCPHXea1Ey2qE20eeZHhBuGifuofNJ9
    A5Z8OPIEBek/cuWgeUZAe5AETYJIvXuO792VYNj94l04IOKskmuGEV+QGE5qa+xF/KWU
    h5Iy05CjIl683yE3si8CaNwQKLwVU+nWnv+haHebQrYrDHJ8k9hQhwYR/hCELEMEgtAN
    1tiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891116;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mCZv9h5y7Ee5tNYV9yYrClTj5aivwr6YfqNK0mRGc2E=;
    b=evVnL+mXxc9FNpdYj/IQXur8cUPgwbH9AOqHm6SF+O/m3IgpdAMPjm9xtHhsF6YGx0
    kZ8R4P6h7ZsdgEqqclMN7e/56w3RYt3HLk2Rufg9oMmDk4RVbAxO2c9bbSYcCuf2nueF
    Xq/JqgVyXiSvsPlkDV7NxrodFsxW99rBVc3LKqyNNoTAB0KP9ilWr0SrPpbmA11R6CdO
    xF/pYDmxbNebZKAuUv+2LKp7aWPHAd3tM0TxnP5XclavFX7QWjpq4YAbdy9zlaoVf97y
    fcUZWuKfecXuxOns0/OdrxTE/LZIs7b+ZfbjartqTgqCwpulLF3j+Xrtu8o8tGe3rUGB
    TAWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751891116;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mCZv9h5y7Ee5tNYV9yYrClTj5aivwr6YfqNK0mRGc2E=;
    b=N0P372JmlCK4QhKEqhLfOy3Hvjm/5kYPAPMR0HbT53U8CV0aZVnEBmj75r9AFfUl+v
    yshwLMQvugAX36M88zBg==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J1bd32167CPF713
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Jul 2025 14:25:15 +0200 (CEST)
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
Subject: [PATCH RESEND 2/5] Remove unaligned/packed_struct.h header
Date: Mon,  7 Jul 2025 14:24:57 +0200
Message-Id: <20250707122500.724699-3-julian@outer-limits.org>
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
2.34.1

