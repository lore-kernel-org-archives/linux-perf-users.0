Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35A385D9B
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293641; cv=none; b=EBYRJp1eoz5lMpICbelPTyVaxWZAxosFpV7c8vvZ5QAG6e8axNo89BbkJjDN47Imh7tXJTso3UuaD7lj+L20Kf4GTQxFrkO177OTTTlBuTJcBeHF5TREzWdYeplfH7cXPIV2FLKmaybwN/Jib3DPva4SnKg5+bMd4zw6sM57TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293641; c=relaxed/simple;
	bh=1TWFwrqLLPhi4hOF+lQYiAR8gfx3VWRwxzpCtpmYYnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ4321db1n7ZvI95f1YTm1I1vGctHBXuruXoDDWQ94t+YpochtRD81b36kDzgw23QnvOSdZuwUmYC6+fCr3i7o6j5t7R16HNU3pm/HYw7euV3MiBIa9Am2/osr1qyMWqTEHCku6VB7fG0FP3Pu8ubtUeE/TGDA3gw5HWtEMwJLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CginYwjn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CginYwjn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381216921aaso7762993a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293640; x=1784898440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GlWa8mIQcYhfASTlpT5AvSeo0bnNLaBVHf432AwkEfc=;
        b=CginYwjn34ITNmcQnAuTKlrIxoc+eFRpVQEKNnynWaFvrgPt6LJ2+N2D6oOF4i6tXS
         8Q66nvEBWkifMoBgkbBprsAXDF3vh3Ecfrk+CvR8IqZd5rfsMEZok+uwsh5BnqSxpq9M
         COpQnWnSC/vpMsDjiTw0pCoMwDmcXoNgsOVf08gRfL4KTTVHTBDh2OXEwX6QNy7xhcp5
         /RvJs0dICzmQaF6oes1IQN6Jb/fmcYDClFTiVtPXbyB0JX1xEuHCfwiJRpwNja8/bwhJ
         gUqgEPSKrnTFQXnxo6/T3vAAY99CkZ43SqnNyXHjaP4p9Cy68C52yASkK1Z4ufQ0D/MG
         DSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293640; x=1784898440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GlWa8mIQcYhfASTlpT5AvSeo0bnNLaBVHf432AwkEfc=;
        b=dlOOpSB5HSNE0kKw87FDkjnL/vdshNURDJeTC9lAd/KI9lM+wNsNs9Qr2fUXpb8bCk
         +O8S1B8u5pFUSI14Na3BJzuVuca0dF6lFdHIzshbrVxbnHIqfbmSJWOVoDhDpC1Zkdvg
         HPV7vbXLjCc8t1oivUFZCv6iOIjSFAMuFJCPyGp1hWyWQb5iVN8W65goYoUHPUEh3745
         oXoEqyi4XmbiKats/CDBMKSmAyFDZhn0fDAYkzcvBW8ygGNKY0wDVprapNlgM+dtJEVP
         VkUnJYumadvGYTuoXZiMRJ1THE7gNCJ3E9Hgetrw7k2uOQqTT9hZSvM8hJzPGCz94zgo
         BPwA==
X-Forwarded-Encrypted: i=1; AHgh+RplKKk43Xd8KAUUcMb9PpWs+bfY9qDgFyt1TcGyWstv0/8wL6LMyGyTEuitQJxH3QOKPhVAjuQTnoGWaFYJ+1/E@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNQ9Lzu/aQ1KsvzAo+6Mel5+xsIvbuqDRqPMFCYrL5aVF+U1D
	hyJFORUCoEScvNIbaZlI7dtfiX2WM5ECXj23u0r7B6W3ZS4UkdfnUwHT
X-Gm-Gg: AfdE7cn1kxZORXC0QcjfcbxC+/n2uX4/YKT07V8NY7Wj1xL6ZMVMUzQDHJ5ogLBPaxS
	2jZjmljJnYOAmm2guxrgn5v1U3DrjrFKmjVg6qbJgAcIUmHzSDd+WAnPeqQ+5VP0LOfvFY1OeZN
	f4gh9+9ME70XQ/lLK40hEmXBG7kQvcguLn8M/bBbXfJ1qKz9nMRMwEORBlo+zS7JfhX7ItlLrhw
	3mBufaMfHsaYo+FSEM7CjjBmiQ9cf5K8i2lwdsFd7Ip0RDA9kdMgSmqO1Zp8OnxJM4VIaQyPpok
	+R56O2YxsrdLqzFj5Boanc27YXRjm8WMfj61xD+EW0eapqoomcr5fy3Tj3BSZWRmVgVA4DhBjFM
	ojitm/rU2HWINNXGU7VLGhpmd/5FfZ7ndC26wedFgxzuZNUv65cJq1hdQS2Ey/X/bHksIWN84iL
	1HSk4cXn60LqOq
X-Received: by 2002:a17:90b:2dc1:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-38e4b3e11a5mr2543730a91.7.1784293639476;
        Fri, 17 Jul 2026 06:07:19 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm7709544eec.0.2026.07.17.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:07:18 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 12/13] mm/kwatch: add KUnit tests for the watch expression parser
Date: Fri, 17 Jul 2026 09:07:02 -0400
Message-ID: <20260717130702.1903917-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover base anchors (stack, argN, absolute address), positive and
negative offsets, dereference chains, and rejection of malformed
expressions (missing offsets, bad argument index, junk offsets).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/.kunitconfig |   9 +++
 mm/kwatch/Kconfig      |  12 ++++
 mm/kwatch/Makefile     |   1 +
 mm/kwatch/deref_test.c | 146 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 mm/kwatch/.kunitconfig
 create mode 100644 mm/kwatch/deref_test.c

diff --git a/mm/kwatch/.kunitconfig b/mm/kwatch/.kunitconfig
new file mode 100644
index 000000000000..7e977ddf0da1
--- /dev/null
+++ b/mm/kwatch/.kunitconfig
@@ -0,0 +1,9 @@
+CONFIG_KUNIT=y
+CONFIG_KWATCH=y
+CONFIG_KWATCH_KUNIT_TEST=y
+CONFIG_PERF_EVENTS=y
+CONFIG_HAVE_HW_BREAKPOINT=y
+CONFIG_HAVE_REINSTALL_HW_BREAKPOINT=y
+CONFIG_KPROBES=y
+CONFIG_KRETPROBES=y
+CONFIG_PRINTK=y
diff --git a/mm/kwatch/Kconfig b/mm/kwatch/Kconfig
index 9daf6d4463ef..6ec9aa448ece 100644
--- a/mm/kwatch/Kconfig
+++ b/mm/kwatch/Kconfig
@@ -14,3 +14,15 @@ config KWATCH
 	  exact instruction causing the illegal access.
 
 	  If unsure, say N.
+
+config KWATCH_KUNIT_TEST
+	bool "KUnit tests for KWatch" if !KUNIT_ALL_TESTS
+	# Built into the kwatch module, so it must be y; a bool cannot be
+	# enabled when KWATCH is a module (KWATCH=m would force it off).
+	depends on KWATCH=y && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the KWatch kernel module.
+	  This suite tests the core parsing logic, the pointer-chasing
+	  finite state machine, and edge cases involving complex watchpoint
+	  expressions. If unsure, say N.
diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index 02d7917602f1..1d223d73b461 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
 kwatch-y := core.o deref.o task_ctx.o hwbp.o probe.o anchor.o
+kwatch-$(CONFIG_KWATCH_KUNIT_TEST) += deref_test.o
diff --git a/mm/kwatch/deref_test.c b/mm/kwatch/deref_test.c
new file mode 100644
index 000000000000..35919dd24d92
--- /dev/null
+++ b/mm/kwatch/deref_test.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include "kwatch.h"
+#include <linux/string.h>
+
+static void kwatch_test_parse_deref_chain(struct kunit *test)
+{
+	struct kwatch_config cfg;
+	int ret;
+
+	// Test 1: stack
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "stack");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_STACK);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+
+	// Test 2: arg1
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG1);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+
+	// Test 3: arg6+8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg6+8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG6);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
+
+	// Test 4: arg2-16
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg2-16");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG2);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], -16);
+
+	// Test 5: arg3->8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg3->8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG3);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 8);
+
+	// Test 6: arg4+8->16
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg4+8->16");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG4);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 16);
+
+	// Test 7: arg5-8->-16
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg5-8->-16");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG5);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], -8);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], -16);
+
+	// Test 8: stack->0->8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "stack->0->8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_STACK);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 3);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[2], 8);
+
+	// Test 9: arg1->+8
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1->+8");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ARG1);
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 2);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 0);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[1], 8);
+
+	// Test 9.1: arg1-> (implicit 0 should fail)
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1->");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 9.2: stack->->8 (implicit 0 should fail)
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "stack->->8");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 10: Invalid base
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "invalid_base");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 11: Invalid offset
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg1+abc");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 12: Invalid arg
+	memset(&cfg, 0, sizeof(cfg));
+	ret = kwatch_deref_parse(&cfg, "arg7");
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	// Test 13: Absolute address. Use a width-appropriate literal: a 64-bit
+	// address would overflow unsigned long and fail kstrtoul() on 32-bit.
+	memset(&cfg, 0, sizeof(cfg));
+#if BITS_PER_LONG == 64
+	ret = kwatch_deref_parse(&cfg, "0xffffffff81000000+8");
+#else
+	ret = kwatch_deref_parse(&cfg, "0xc1000000+8");
+#endif
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ABS_ADDR);
+#if BITS_PER_LONG == 64
+	KUNIT_EXPECT_EQ(test, cfg.sym_addr, 0xffffffff81000000UL);
+#else
+	KUNIT_EXPECT_EQ(test, cfg.sym_addr, 0xc1000000UL);
+#endif
+	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
+	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
+}
+
+static struct kunit_case kwatch_deref_test_cases[] = {
+	KUNIT_CASE(kwatch_test_parse_deref_chain),
+	{}
+};
+
+static struct kunit_suite kwatch_deref_test_suite = {
+	.name = "kwatch_deref",
+	.test_cases = kwatch_deref_test_cases,
+};
+
+kunit_test_suite(kwatch_deref_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the KWatch watch expression parser");
+MODULE_LICENSE("GPL");
-- 
2.53.0

