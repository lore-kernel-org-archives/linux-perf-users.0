Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64692BE62C;
	Mon, 25 Aug 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159148; cv=none; b=fBsc4bAa0SeDzJgDnucTn5xcTYXZthbLMbE0Yi2uD90HUbVXFXaZYmBFxP9lfQHw3md8pnuNeBlfFJTMhY3189HvebIcHjWriyo1qR6VFQVVE3zcZWlI+xQrnBhDFxe5/luoCmjMNjENF405lxQvXv5VCLx8z1Y9IhLIajnlmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159148; c=relaxed/simple;
	bh=tN98BMYgIunDMpO3igY5wDeEoG5Z4FNdrUFxdTBmyfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiq0vQDPBwMZ1rLNZuRyn+8IgAjahqS9j+ohLpElOVZZOj1jHfFuF0BIANmGG7OL1v7842tPIKE/AKVS5fPczxRXUSdMc23RV0Ml1TsdCzvhN8Z3vvNl0qeCk/IaGdab+SIF1vjfz1D3ATuVRvpHCX3Af4aFMm2FBBvlx7zxae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd8NVWmu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd8NVWmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FDAC4CEED;
	Mon, 25 Aug 2025 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159148;
	bh=tN98BMYgIunDMpO3igY5wDeEoG5Z4FNdrUFxdTBmyfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fd8NVWmujbvT1oso4QBUsqB3OanAtvi8+ma4omzKMLzA+/6XQhS+sllGgoaYu5i1O
	 tZ4xoi7PxddI9n6zHXibLPclbNNYBQ/7UNIQIZ77OoXE0mYu/vdqYy8XBwLxIjKHRs
	 Cou08UdKFZt95864zFLxZ7MmffnmM5mr6YPckB4Ku3unSNEJoJ1gATj+ZZqq7rCutM
	 KiOLH4SrFkpFv5oLXjT5BxCfzhOpfwCOXeYuNExNHtWdwh6S28RhXdrvGR15cKFbSN
	 Iv40gVb8qg8Hsc1k2/0tW1XLzWnp4UZpzoKr2rrFOF8zGprmnenqW44ddlPFE6bdYy
	 DAn0NSNfy3HVg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 02/11] tools headers: Sync linux/bits.h with the kernel source
Date: Mon, 25 Aug 2025 14:58:54 -0700
Message-ID: <20250825215904.2594216-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  104ea1c84b91c9f4 bits: unify the non-asm GENMASK*()
  6d4471252ccc1722 bits: split the definition of the asm and non-asm GENMASK*()

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/bits.h include/linux/bits.h

Please see tools/include/uapi/README for further details.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/linux/bits.h | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7ad0562191153471..a40cc861b3a7c60f 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -2,10 +2,8 @@
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
 
-#include <linux/const.h>
 #include <vdso/bits.h>
 #include <uapi/linux/bits.h>
-#include <asm/bitsperlong.h>
 
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
@@ -50,10 +48,14 @@
 	     (type_max(t) << (l) &				\
 	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
 
+#define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
+#define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
+
 #define GENMASK_U8(h, l)	GENMASK_TYPE(u8, h, l)
 #define GENMASK_U16(h, l)	GENMASK_TYPE(u16, h, l)
 #define GENMASK_U32(h, l)	GENMASK_TYPE(u32, h, l)
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
+#define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
 /*
  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
@@ -79,28 +81,9 @@
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
-#define GENMASK_INPUT_CHECK(h, l) 0
+#define GENMASK(h, l)		__GENMASK(h, l)
+#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
 #endif /* !defined(__ASSEMBLY__) */
 
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
-
-#if !defined(__ASSEMBLY__)
-/*
- * Missing asm support
- *
- * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __int128' data
- * type instead of direct representation of 128 bit constants
- * such as long and unsigned long. The fundamental problem is
- * that a 128 bit constant will get silently truncated by the
- * gcc compiler.
- */
-#define GENMASK_U128(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
-#endif
-
 #endif	/* __LINUX_BITS_H */
-- 
2.51.0.261.g7ce5a0a67e-goog

