Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69D26B779
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482412; cv=none; b=uGld/MH9uaSQMr+AyT9CoUV1GzUJmLUuwwzAUFfn22IH47hOKbY0VcNRUuwzngsLniNtNU4h/apWWv4awvqBmwBeM2OZt/3qaf7CJjtCN9by2BfHttx5vWZUdxDYMurVVvk9GJIX0QPhvLpNeLBhO2Jql8JnpmGGIZQuZERsyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482412; c=relaxed/simple;
	bh=TY/ZZj6bG0AIJATrDHUHJIWSY2uar3+Ji9ucd5qqXlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCcJu06q2RwY6yO+3lWgSkjBzgeWlP/4WfY8G76xixz+x2SQEZc31K67+eFm0LIb6lQMY08+HOyT8N+F46OOy1i/eeG6sA2F6DZY1s3Ususx5hFe3L4xr8bwyG3CEuItI2SlAfa4KVcwdS5xWHUm/q6bwXPS51EnK2dN5UG1whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8C+ukqy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8C+ukqy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso5375198b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Sep 2025 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482409; x=1758087209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFJjjziwY/SMZUE7K7JOobhYkWwkFReGMU9dNIU9Js8=;
        b=J8C+ukqyIq0BhHfA0CRagVixaZyo/TWiGScgTvdhMZl2gfsqaji+9+/86kBb3w7nhm
         AsY0Yt8iNQ0Ar182QkDYZdipxHnl6B5wIdcArOkfPxGocmf0O2K6cHpGzzA8HYyjrAd4
         EuE/QNolZhke9inEAV+zsQFeFPQSbfX/9mmT7ODce5V+ZuVUYh3SBOzEwabTg+H4/djt
         EGcQqTQa3/osK/P/FW3tvY+XNgGlgWnmJs6GMs/TyTIYd61LZaeVY6rU3K4NLF9s9mGi
         KyIIbKq6ipiA56y6TJbWmhbP5+9hNsUb9joWGHPQiXPQgQO6Iz+pnFc/bWeNhTFHtY0j
         lDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482409; x=1758087209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFJjjziwY/SMZUE7K7JOobhYkWwkFReGMU9dNIU9Js8=;
        b=EdKWS807RTnWMD391HgABN4iKJbkrLsGNqyhYJ6gdkTr+sGpAnGv1KrNuQGjmFz9+B
         qunZcWCAU3hOPgpjTAb6vxR2i3MoKEnoT2jzlM0a8jJ9fJeyCgKs/sE2iGVrADXnO3rT
         azIc8LBc4NKBnFlPoGddGP3BbyWZeVQz7xhDOkPQxAv6o/I0ZIov2SRvoOtgUiFN+aUi
         h8L9A+GJArRsQuXPZ9QvQjuVEI1qC4RlcmhrUUdx3sdoqfo7NcxF98/PwA8jppLeSoCM
         KmLlqw+hOjrrt9YLAPtsz3MwLztmJjjsnAVaDtNpGNyhbzF4a0Q6/zS1tYZCdibpC3fO
         Gg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGamPdInrQiKPNR+hSF1gQ14+mAhXTVc4sKUQMukFaU0frgzshwmg7eqq21+hIs8bWTRiDsc47Aiz0roDjbTQw@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/o8Gy2J7MAgNCMbTfGV70bK+gIhhaKSyeZ/fjLNIjuWfj8wL
	bvBCxUEzJRclfW7lHZ0iIdJx8erHMvBqj2yGJVBz2xNjKKboJLbLYmB7
X-Gm-Gg: ASbGncvcUh7OKE/DG1e5/T6gFdRdESlsqyeV+HDeKNNJmhZajiIUPhzDhLAzONhKLef
	usVBt/dTbex7kVoyJKC1IuGf/N6TcFApcdnXvlPoQih/Ql5GnvFqtp6ePeJoQxu3ybSWkwsobdw
	45lYajZ/UUZL7tAoDVYSv535Bwt9EeYpyUBma6PGtdUTF37hZI0vPjW3w729KkaQLdRxMDORQyS
	G+/6/RUx+x6e2ZT+c58ssTu6stOk5HhJVffcjTP+6RIBUQseH83+Nze/SKUD+xI9TAdOFvcQyb5
	yZfZ7+ne0iNzl4DFHK2z7L4U4l+yy4SZOL2HHjBK5y9Q6BP7dpNbr3Kc7yR52ROaLKbv8DPQsSg
	soDCmFfXun3oOe/GfWWoTIT970f95PKuS/PpQ7H7OktC9NK0JpTqmrY4tKmoP
X-Google-Smtp-Source: AGHT+IFSzMJtTgRp6G6+ynwQIuI7wFxwrcxpY0ttE5gtXrdyaN2igD3J3QxBSKtHfOz9fDuR2ISq9Q==
X-Received: by 2002:a05:6a00:3c8a:b0:772:4d52:ce5a with SMTP id d2e1a72fcca58-7742de4244cmr15474546b3a.26.1757482409245;
        Tue, 09 Sep 2025 22:33:29 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:33:28 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 16/19] mm/ksw: add silent corruption test case
Date: Wed, 10 Sep 2025 13:31:14 +0800
Message-ID: <20250910053147.1152253-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053147.1152253-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910053147.1152253-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new test scenario to simulate silent stack corruption:

- silent_corruption_buggy():
  exposes a local variable address globally without resetting it.
- silent_corruption_unwitting():
  reads the exposed pointer and modifies the memory, simulating a routine
  that unknowingly writes to another stack frame.
- silent_corruption_victim():
  demonstrates the effect of silent corruption on unrelated local variables.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 93 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index ab1a3f92b5e8..b10465381089 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -20,6 +20,9 @@ static struct proc_dir_entry *test_proc;
 #define BUFFER_SIZE 4
 #define MAX_DEPTH 6
 
+/* global variables for Silent corruption test */
+static u64 *g_corrupt_ptr;
+
 /*
  * Test Case 0: Write to the canary position directly (Canary Test)
  * use a u64 buffer array to ensure the canary will be placed
@@ -61,6 +64,89 @@ static void canary_test_overflow(void)
 	pr_info("canary overflow test completed\n");
 }
 
+static void do_something(int min_ms, int max_ms)
+{
+	u32 rand;
+
+	get_random_bytes(&rand, sizeof(rand));
+	rand = min_ms + rand % (max_ms - min_ms + 1);
+	msleep(rand);
+}
+
+static void silent_corruption_buggy(int i)
+{
+	u64 local_var;
+
+	pr_info("starting %s\n", __func__);
+
+	pr_info("%s %d local_var addr: 0x%lx\n", __func__, i,
+		(unsigned long)&local_var);
+	WRITE_ONCE(g_corrupt_ptr, &local_var);
+	do_something(0, 300);
+	//buggy: return without resetting g_corrupt_ptr
+}
+
+static int silent_corruption_unwitting(void *data)
+{
+	u64 *local_ptr;
+
+	pr_debug("starting %s\n", __func__);
+
+	do {
+		local_ptr = READ_ONCE(g_corrupt_ptr);
+		do_something(0, 300);
+	} while (!local_ptr);
+
+	local_ptr[0] = 0;
+
+	return 0;
+}
+
+static void silent_corruption_victim(int i)
+{
+	u64 local_var;
+
+	pr_debug("starting %s %dth\n", __func__, i);
+
+	/* local_var random in [0xff0000, 0x100ffff] */
+	get_random_bytes(&local_var, sizeof(local_var));
+	local_var = 0xff0000 + local_var & 0xffff;
+
+	pr_debug("%s local_var addr: 0x%lx\n", __func__,
+		 (unsigned long)&local_var);
+
+	do_something(0, 100);
+
+	if (local_var >= 0xff0000 && local_var <= 0xffffff)
+		pr_info("%s %d happy with 0x%llx\n", __func__, i, local_var);
+	else
+		pr_info("%s %d unhappy with 0x%llx\n", __func__, i, local_var);
+}
+
+/*
+ * Test Case 2: Silent Corruption
+ * buggy() does not protect its local var correctly
+ * unwitting() simply does its intended work
+ * victim() is unaware know what happened
+ */
+static void silent_corruption_test(void)
+{
+	struct task_struct *unwitting;
+
+	pr_info("starting %s\n", __func__);
+	WRITE_ONCE(g_corrupt_ptr, NULL);
+
+	unwitting = kthread_run(silent_corruption_unwitting, NULL, "unwitting");
+	if (IS_ERR(unwitting)) {
+		pr_err("failed to create thread2\n");
+		return;
+	}
+
+	silent_corruption_buggy(0);
+	for (int i = 0; i < 10; i++)
+		silent_corruption_victim(i);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -88,6 +174,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering canary overflow test\n");
 			canary_test_overflow();
 			break;
+		case 2:
+			pr_info("triggering silent corruption test\n");
+			silent_corruption_test();
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -108,7 +198,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"==================================\n"
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
-		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

