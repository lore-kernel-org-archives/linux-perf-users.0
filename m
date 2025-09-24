Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144E309EF0
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714756; cv=none; b=qf/IQLATsKII/F77WFziyOB0yyUlqm3Sxb1UpJrSTtmJTZolFQZTqSeyg7IaHpjEbw8vk+CPGBvStm62aAVscYQi/FiRg27AS7J8TcTEoGqrMShknC2GQn3yiF9l1mHHNW3slR//Wk6aXNAAnecFLW0S6OgOOcIkDKJqHQUBGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714756; c=relaxed/simple;
	bh=iAqT9ehP+7na6p9OmCJ4sZ82YPBCnKZ9ZITAqnPBA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/JcmfW2VktcjFQjOD1glpQDCA6941oKSHiWRUYPkpa0wwQ1XXnar5G/tYv2F/QxrK0bYq6ixkuIq4fcGGqQT5tToZMH5gWawXFMekiUWQosSyWG0TMezA0f0rghs4JiDxVr8M9MFM40vY9+kQmGXcVbGzFIYvoUDwZrtnq5+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHTYa/k+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHTYa/k+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3930223a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714750; x=1759319550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDvSRov2FamkqE0fpRbb1mATCdcadu0+ybcKu6XxB6c=;
        b=MHTYa/k+6ECs357AhrvtLv3+d+73xCHlewJANdPDeVVBs4baqSQks4VcCRT3od2KlD
         TGstrAuMWBc3jmmoZFx+oae35ZAvAYvywhAtWk2ZbtXMVzz47auOqwqvix62PsKZ5HDB
         36hB/dC9CSViXW+tHKbePe2QIXG4dOi9JiVZHJz9MWiaHSfgRFPGEcCDVSXoiXS71Byt
         r6tXUrrdi1JcuS+HfNnQjpWww13adXmfdXFef4q0uSE58I3Y/7SFYC6nzS6TZRqHcj3M
         kN3ZI6v9QgwY2aUnn4LLb4CoIyCcZIaiHzajCEybkKvMhUz+XWRcCQoiYetvmzfu6JcM
         4uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714750; x=1759319550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDvSRov2FamkqE0fpRbb1mATCdcadu0+ybcKu6XxB6c=;
        b=EFbk70MghMTYqjvI/OTPvAQ32S3Vvtd4Ckm+ZN2XU/04MM2FB1rk1n0E5V20D4RSbY
         JnpMd5iNnTvqhvL30YXT6DdjEH2+PDCfcngdMH0MxxmFiIFH1Ne/zG5KHsBeE7EGtl/M
         wHB8VjV5wi2ABfZzy0aiVUolo5J5aHT270a3GoEeFHCjWN+LOaAJIQpasJ9Ya8mPa03D
         WbS1Ucm/DElOpHaC7iyRtz6/P79id/DOhiu+tqiUOoiGr/e0tBwQrsWrf5JIExyZzCde
         trTRGlmb0ffVmeOMBb76KArIN7rwRX18IF0/VL3xOftUOOi9JBFpxLvBMEMoAwH8B6F/
         d0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8U3KJ8lp00kwQa8oDLzuqVhqsmrig8KZ+HEoK7bP/NrYHbUrd41uzIF7l0lxP5Lf121yKAcrxRCbTFWjzRqDd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xUMp6U8jETUst0njFnoIgBp0NuCVHudPvPKNDTcahBojoNSu
	R7OyvMEvP6E+HMSpOm15x5hrHDA4g2pXHc+U4GCxd9/E4g9L9i54/7BT
X-Gm-Gg: ASbGnctbPUchpx1kKgkXmma7a4Ns9JWasIQBe6vS4a5yUxuq7MxWC2IqS6522geoZIY
	iTFIgMVG0DPr2YA8RmA8/4uYF04rLfLZOms615zN3QWgibDM+6P3phjmvfhlWHzM8x7yIVeWUkt
	YXfowIhHqCygi1ZTkGRrZFbHJmiMqLnGZ1y+1L6eyxWGfM/+kvm3uaKOwjwrS3JmkcojagMR/8f
	HCiFCkSSW9a9xgCfaqOV5mFi/TW/hZxz7OIQ/tTyrtEve6NXCIBSN9eNhPtACtEZ2W+DhypRFbq
	UaIT2Wf1G30nCw62qojZZeaJgLtxFYe+i0GrVI4/CXq5q6ipFdxtwfRg7PrFwy48jU2cPdh4Ray
	URsoZBzAu0xM/EVZaJ+kuVFs2RQ==
X-Google-Smtp-Source: AGHT+IF5ZwoBk0ceUXLZjQvXdKYyDk7CfR+Or0oVbNtL2fgYtH3GTtcS1SuTeoBLjpovsRj6PgtdCw==
X-Received: by 2002:a17:90b:1844:b0:32e:87fa:d95f with SMTP id 98e67ed59e1d1-332a98f6f1fmr6851528a91.32.1758714749765;
        Wed, 24 Sep 2025 04:52:29 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90587sm2190418a91.6.2025.09.24.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:29 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v5 15/23] mm/ksw: manage probe and HWBP lifecycle via procfs
Date: Wed, 24 Sep 2025 19:50:58 +0800
Message-ID: <20250924115124.194940-16-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115124.194940-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow dynamic enabling/disabling of KStackWatch through user input of proc.
With this patch, the entire system becomes functional.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 4a06ddadd9c7..11aa06908ff1 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -13,6 +13,43 @@
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
+	pr_info("start watching: %s\n", ksw_config->user_input);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	ksw_stack_exit();
+	ksw_watch_exit();
+	watching_active = false;
+
+	pr_info("stop watching: %s\n", ksw_config->user_input);
+}
+
 struct param_map {
 	const char *name;       /* long name */
 	const char *short_name; /* short name (2 letters) */
@@ -126,6 +163,9 @@ static ssize_t kstackwatch_proc_write(struct file *file,
 	if (copy_from_user(input, buffer, count))
 		return -EFAULT;
 
+	if (watching_active)
+		ksw_stop_watching();
+
 	input[count] = '\0';
 	strim(input);
 
@@ -140,12 +180,22 @@ static ssize_t kstackwatch_proc_write(struct file *file,
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
-	seq_printf(m, "%s\n", ksw_config->user_input);
+	if (watching_active)
+		seq_printf(m, "%s\n", ksw_config->user_input);
+	else
+		seq_puts(m, "not watching\n");
+
 	return 0;
 }
 
@@ -193,6 +243,9 @@ static int __init kstackwatch_init(void)
 
 static void __exit kstackwatch_exit(void)
 {
+	if (watching_active)
+		ksw_stop_watching();
+
 	remove_proc_entry("kstackwatch", NULL);
 	kfree(ksw_config->func_name);
 	kfree(ksw_config->user_input);
-- 
2.43.0

