Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D92848B5;
	Wed, 10 Sep 2025 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482365; cv=none; b=LEzLqgsMS21IF5pYBWFYFCVFVf4Q5Yt88xQ7e/YXYvTAn9EYCJOHKiAyg9qaw+n5qlhInx4i4Kw1qkATv6NsB0e3GRhP+Z/Sb9VZ1/qU/phVGHXzlOZ4TY7fqJPxwLPjtn65WFVkiTmwP1wQShZrD4mgKiG3Bpydtni6cQvT2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482365; c=relaxed/simple;
	bh=DAIKaVDDYFuwdWMBSkq33kfqi+gH/MToaWBh7/fnJJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leZPKYbnEshK/iG8G/3a/YKqZ6eoOxrJcE2mraDDoKSW2IolMXj6WsLRAa5MfOKxtvP6XtufqQpIr+zDlaR7gHWLz5wpoqrbOG8EShAz3HEZYb4GV+MloB4ObU0OW0jFd8NqFY0Gc6WHdMsmEWaD7apSZyIJ/yP7H8mF6PeuHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzra1mIK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzra1mIK"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7724df82cabso7279599b3a.2;
        Tue, 09 Sep 2025 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482363; x=1758087163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XwqTGxkvpDU8btF6MhrnM15w2tp20A0ZzctuT/hXIw=;
        b=fzra1mIKUSt6E2iwMzU2hqnybxKvka/gbbQoAA5q0o6fHYF1fiwClHRsAnmPed/z5x
         BgohvWg5XL8h7errtPDGAnheXN+g0ZKW7G9TaNnQ59OgVCP0eO3faJKVkt8syIi94zX6
         au6a5sjxSo2mao32UUEgKhsEcnloNRyOi4anpEmp0+220f2yF4pvQ76OK+kc4yGE16OQ
         mD07vE5qwuu7ulK/eeFFOEWzCZ4dr2INKP6j6Bq0VfdxuBXImw5Gk9qGU35JgWsCmGeA
         iqPyYP34coTQnMag0LlZs45KbZRhfhoIH5BfDbhyuSLsJ1uvfqaD9aCc9WkG5uWzfNJ1
         r55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482363; x=1758087163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XwqTGxkvpDU8btF6MhrnM15w2tp20A0ZzctuT/hXIw=;
        b=lvrVSi2mwwjyRsQhp9N+Iy7hrKSHfPMr3teeR5sEpCDir62FqMyWTzYg0LC7gYHp4s
         Do4ivyMgo/yHFhVQOMhLis0444hfbBLt1Bm1xXzpm6X0bsnNTe0lMmwshjb+GnswQQ4R
         nAPJNjoqJyxqORmPUBvq46qQI++eWueAXl4vk+9VlDv3bx9c2Z4hXCA+PPizJLhY9XK3
         5Sdn1QccgcFvxFjQMRpbWHtPUsVJcd3W3+Ll3EXT6C3+8tRPD/XZHh50CpuoxjmFD3eg
         igMx0dTQf0Drw+i1cYyymtC42u48jm2g4r7VJrGbeNTniJU5UJOLQNj4ui4RrJSK/6ul
         jLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8+ZhpVcBjJXI230vHdnMIyd9CXhiSFug1DcpAV7QanSMrgvm1wF1nlLMJbK1SwnPoHvbyjnNO9HuLbWXapNH@vger.kernel.org, AJvYcCWaUHcRzb6BcL2rWZXuCOke8VTxLcuYkWm9JgI47E/DPVhf5hIGniLDTeR+Kmw2/fDZMKfNWylbU/kGj0eAuYkMJ851@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+4L9H5r4KC37oGd8iRKcFa5NGf+5WufKDWL63tlbpWBBAJXu
	GVbqc8TdtaA4Gq8VECw1taHR62lkugaBwhdZOF9zT2AwT1GwD5nIKmZT
X-Gm-Gg: ASbGncvLjUUUoCYwHvqTVhoGzNsLVG7kkOlmSbhElCmE3ygbeUJDHZ8fni61qfEjR73
	8HAdfbBysf3doYSa4QM2Va2bWXW7YKdmqjXtetckMW0+UuUOzgLOCe90dUSAxZz2QemzxDavKAr
	sgqySt8ilsN1BWZp0E0QwWaIQqAIIPohP/MspOH23C+btofA4Qr6Q3JOzLznKB7v6S3sZxt3zVa
	b/Wot5KlYcs8MP0SO0v7SIxsgPkap7I1F8MRS3H2/mqsnU97PNmf+ZO1cedffjru71OkmKI6Sku
	TbWFMVW2pLz8qW4FqtlRr1oo1Gq/zUv1JWD/uVK/3rOkQ40NUhpn/hEDgRBRIGiCWiuac+5Qg1v
	I/JTIXKsFjsMI7dlvJs7GQO+9SX7iFqeNXw9xrThoWinUiCmilj7jTq3XzHQ7
X-Google-Smtp-Source: AGHT+IFFWwOXHMwIG1yOKL/FCHbxderarjrTNpzkVRvWwcGe50/YwQcLyKjZj1NSxsqGAAEDD2Uygw==
X-Received: by 2002:a05:6a20:3d83:b0:250:429b:9e56 with SMTP id adf61e73a8af0-2533e9476eamr22673752637.8.1757482362704;
        Tue, 09 Sep 2025 22:32:42 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:32:42 -0700 (PDT)
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
Subject: [PATCH v3 12/19] mm/ksw: manage start/stop of stack watching
Date: Wed, 10 Sep 2025 13:31:10 +0800
Message-ID: <20250910053147.1152253-4-wangjinchao600@gmail.com>
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

Introduce helper functions to start and stop watching the configured
function. These handle initialization/cleanup of both stack and watch
components, and maintain a `watching_active` flag to track current state.

Ensure procfs write triggers proper stop/start sequence, and show handler
indicates watching status.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 8e1dca45003e..9ef969f28e29 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -17,6 +17,43 @@ MODULE_LICENSE("GPL");
 static struct ksw_config *ksw_config;
 static atomic_t config_file_busy = ATOMIC_INIT(0);
 
+static bool watching_active;
+
+static int ksw_start_watching(void)
+{
+	int ret;
+
+	/*
+	 * Watch init will preallocate the HWBP,
+	 * so it must happen before stack init
+	 */
+	ret = ksw_watch_init();
+	if (ret) {
+		pr_err("ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init();
+	if (ret) {
+		pr_err("ksw_stack_init ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
+	watching_active = true;
+
+	pr_info("start watching: %s\n", ksw_config->config_str);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	ksw_stack_exit();
+	ksw_watch_exit();
+	watching_active = false;
+
+	pr_info("stop watching: %s\n", ksw_config->config_str);
+}
+
 /*
  * Format of the configuration string:
  *    function+ip_offset[+depth] [local_var_offset:local_var_len]
@@ -109,6 +146,9 @@ static ssize_t kstackwatch_proc_write(struct file *file,
 	if (copy_from_user(input, buffer, count))
 		return -EFAULT;
 
+	if (watching_active)
+		ksw_stop_watching();
+
 	input[count] = '\0';
 	strim(input);
 
@@ -123,12 +163,22 @@ static ssize_t kstackwatch_proc_write(struct file *file,
 		return ret;
 	}
 
+	ret = ksw_start_watching();
+	if (ret) {
+		pr_err("Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
 	return count;
 }
 
 static int kstackwatch_proc_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "%s\n", ksw_config->config_str);
+	if (watching_active)
+		seq_printf(m, "%s\n", ksw_config->config_str);
+	else
+		seq_puts(m, "not watching\n");
+
 	return 0;
 }
 
@@ -176,6 +226,9 @@ static int __init kstackwatch_init(void)
 
 static void __exit kstackwatch_exit(void)
 {
+	if (watching_active)
+		ksw_stop_watching();
+
 	remove_proc_entry("kstackwatch", NULL);
 	kfree(ksw_config);
 
-- 
2.43.0

