Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085849CF40
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304482; cv=none; b=g6k/POlJHl/+IqPlwth/B0ocPWqHOOTWGMW1SgVZmIh0SpOmLoFP4h4SZo7xu7MeZQ3TfSQcI6WTjPV7hUsb9qNKNhrBdA8hLbX6oGZ9q7+GXVBCmZEY5+6UCRGv7SpOGeBaGGSlQLtKdLLz/Cl8FX2z2CO0/dEEqiU07Zvjtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304482; c=relaxed/simple;
	bh=S2uUX2Fk8n+vP/qgMl3qIzP8JEsoknNWZdUieCr5bPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hia78SH5JiEHEuQeVc65Ak3L4gbBmH1ddULKMOYuyi0ZguGxs3eL3/nqyk2zZ59GFh57bazBhldRL+yjX2b4TO8m20YbiqmLHahhvDMZ+4UwoooODn2VQ4BQ7nYqCVi65xDJQBYXs4FQZHeZETm2ebIz8wCJFopZ25Y9RYsMeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkVOq88z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkVOq88z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49ff680331aso31945465e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791304479; x=1791909279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRTKpE752UBxEVvsukPxz0g+FDjlA3TSMkGVEa1/WS8=;
        b=VkVOq88zM1h4RUc4VFxjbTRDqiwnC5HOm9haZpRRlWlXUQ8Y9A9y9jUxeisIcHiTv7
         yoqn79hpBLhh/+JJPxrtS1vPIg0scDNsDltgiij94yPreU/2hZlrIGevhQMhECsYaXol
         8pzb7Ic7ZK1m44FUT4h8oks27BxpzbVfZoKCoZJCC6/cUCpWT0AQBrFbaKnOd/bJyCtB
         P8BHhgUtLlaoqGOl0CNIE/N4iHIpcN6J1yV5vAadXFdXkI/1EVM/bfN2hertW3FeU8Kv
         54zVd97JiK7Pl4Y7RfjhynTgRTQLpY3NlSzcol12mNb4KVz0QW6pRMn38G+B9gAd9Y2y
         DT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791304479; x=1791909279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRTKpE752UBxEVvsukPxz0g+FDjlA3TSMkGVEa1/WS8=;
        b=UlMcTj1nhW1/5LB0/MaSOqnEBxbOq6uLeEHDutnXKHasw57jbMBmepeIQnqyrUEwMN
         F5zTDkUxuYoe4LrybiMczgbYpMC0nav770QYmn2nqwQGinAgVSqTlkofQQboDvxdAKlV
         x5siwRUwsYl2uoO/9lkSohfGxDV4NRL8gaQEXPQt8KvUOhF4Gd0G3z6Lv9p8wZ0b47CP
         X76sjzeofUVRXbdcUGGQbdMVxSm26koRZqpcfbr6I3GQELblPDwEOAGZ5L9TFs5IX4S7
         7DzXOzhm6oKqHcBZY3q8SlERi+SEe5YyMUnAKWGgcuhfTK06/MNqtvasHsO0oj6bL46+
         e7FQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoxR8RongVRE8npOGpc3OpuAGHALjKkbmak9PqoVnQHjg0vAlmwcp/a/JxsQEvnLUvV+GKrAvTvGDR5OSwggCv@vger.kernel.org
X-Gm-Message-State: AFuF++nvPFVIoonT3iFs/vc2kPjogFWN5cO+7Ka1hMJE+mYEQzjVKNs1
	n+UyA33BU/Rr7xUe4JxUEBjLhZnrqcxme8uDz6aByyna4tfXcM+k87/+7ydK2W8DdJc=
X-Gm-Gg: AYBFou1kIgfVZZzeunH4Yfh/HD8s4OtH+0cb03FTGA3ukzDSQEX0cnI70Q0ilitS0uT
	a9TA2iaWtYpPTWuwI4CJAhCP5oG/HsHeMNrvEa89Hv8spLafvgGPnYL5myK/8g/4gOj/JPN4ahi
	SwByx4BMjL1JvK3MplPEXnxhLyi+RcACmUbW7KVRd6IdUkO4Z4F3zihISwevu13wGhbrNtJ76fe
	W2vdfDCciIG06kaOz+yakzPqil3xq/jus7Q7VawyXZ7RrfYGjRFaQoXZMglyNl5egCIKpa3vupN
	g+nVo5vMPjcg2o2i+snjhSAtnihOHPTCNkH3ji1gnm5xsd3RYeCKo/I4fRiaZM5DwOPtVQao3SN
	+zqilM67iMBtS0i0xZXaHar1GuDju94yEQUir8YqH96YHpyP0cxuhY+dhl5zSG8l/8t6eMdeHin
	f/OOvv51IOpOVNs7gysxO+atWKjI6YQ4naFzEfpdujGcAsUpGSK/Equ7m1LVe+Zb+MRrL5LFteT
	WhEf8uHULpz
X-Received: by 2002:a05:600c:3b1a:b0:4a0:251f:dabd with SMTP id 5b1f17b1804b1-4a1680f17f8mr174885775e9.16.1791304479057;
        Tue, 06 Oct 2026 09:34:39 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm78918555e9.3.2026.10.06.09.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:34:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 Oct 2026 17:34:12 +0100
Subject: [PATCH v5 1/2] perf tests: mmap-basic: Only test userspace reading
 on supported platforms
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-rdpmc-detection-logic-v5-1-b25c9d49baa1@linaro.org>
References: <20261006-rdpmc-detection-logic-v5-0-b25c9d49baa1@linaro.org>
In-Reply-To: <20261006-rdpmc-detection-logic-v5-0-b25c9d49baa1@linaro.org>
To: Ian Rogers <irogers@google.com>, Michael Petlan <mpetlan@redhat.com>, 
 Qiao Zhao <qzhao@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

mmap_user_read_instr() and mmap_user_read_instr_disabled() are the same
test for platforms that libperf doesn't support userspace counter
reading for. Only run the 'enabled' test for platforms that do support
it in order to simplify it in the next commit and not run the same test
twice. The test can then assert stronger guarantees and have fewer edge
cases to handle as we know it only runs in places where
'rdmpc_supported' will be true.

"unsupported" hasn't been a relevant skip reason since
commit 588d22b40480 ("perf test: Expand user space event reading (rdpmc)
tests") added the UNKNOWN fallback for unsupported platforms. Remove it
and leave only "permissions".

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/mmap-basic.c | 51 ++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 5cec7644952c..208cd889f23d 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -378,13 +378,13 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 	return ret;
 }
 
-static int test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
+static int __maybe_unused test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
 				      int subtest __maybe_unused)
 {
 	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS, USER_READ_ENABLED);
 }
 
-static int test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
+static int __maybe_unused test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
 				       int subtest __maybe_unused)
 {
 	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES, USER_READ_ENABLED);
@@ -406,42 +406,29 @@ static struct test_case tests__basic_mmap[] = {
 	TEST_CASE_REASON("Read samples using the mmap interface",
 			 basic_mmap,
 			 "permissions"),
-	TEST_CASE_REASON_EXCLUSIVE("User space counter reading of instructions",
-			 mmap_user_read_instr,
+
 #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
 			 (defined(__riscv) && __riscv_xlen == 64)
-			 "permissions"
-#else
-			 "unsupported"
-#endif
-		),
+	/*
+	 * libperf only supports userspace read for these platforms, see
+	 * tools/lib/perf/mmap.c
+	 */
+	TEST_CASE_REASON_EXCLUSIVE("User space counter reading of instructions",
+				   mmap_user_read_instr,
+				   "permissions"),
 	TEST_CASE_REASON_EXCLUSIVE("User space counter reading of cycles",
-			 mmap_user_read_cycles,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
-			 (defined(__riscv) && __riscv_xlen == 64)
-			 "permissions"
-#else
-			 "unsupported"
+				   mmap_user_read_cycles,
+				   "permissions"),
 #endif
-		),
+
+	/* Counter read via userpage fallback is supported on all platforms */
 	TEST_CASE_REASON_EXCLUSIVE("User space counter disabling instructions",
-			 mmap_user_read_instr_disabled,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
-			 (defined(__riscv) && __riscv_xlen == 64)
-			 "permissions"
-#else
-			 "unsupported"
-#endif
-		),
+				   mmap_user_read_instr_disabled,
+				   "permissions"),
 	TEST_CASE_REASON_EXCLUSIVE("User space counter disabling cycles",
-			 mmap_user_read_cycles_disabled,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
-			 (defined(__riscv) && __riscv_xlen == 64)
-			 "permissions"
-#else
-			 "unsupported"
-#endif
-		),
+				   mmap_user_read_cycles_disabled,
+				   "permissions"),
+
 	{	.name = NULL, }
 };
 

-- 
2.43.0

