Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7591F463E;
	Thu,  4 Sep 2025 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945346; cv=none; b=XJSuWUgsyyzbIbaoO/ctamBPK6LttzP8xPEQTQo9kTJa3sj42nVpnOgZkEO3m51LjnnTHYVg5Pt8+tMZDvtpvzkwSN+tyKyHt+jNc3Nx5I6CvN0wvwUFgKo3fCDARSWAl0LRwAOf9xL6bOVC55SiPL2g6GGiQVMH5MDCIUWpnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945346; c=relaxed/simple;
	bh=rufIEWmrAKLQ+mfcV5W+4Uljip8z5lF1CAVZ2QbsVZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L97Tz/g9drV9s4Sb+2+3cBPk9i4HrDCGhMr3AQjHwcrl54YK00BrgIBKG2uyESobApM31R004jUSvHj40bdtZn89Vpti8E5I9S4NLSKsXoXAk/OdpmQAbJBTs9q/s8J+qo4oohWz32C9eDkqg4vPMMH2TKqq6zFpAHsVYVePuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qfn2DBT7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qfn2DBT7"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772679eb358so457913b3a.1;
        Wed, 03 Sep 2025 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945344; x=1757550144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06EnX4xNHqiA4W3dBLh6+8AEySVO628YRMoxqtZgpzs=;
        b=Qfn2DBT7tGKU/jMAOByFs5RbHc+5ZuO+R3AAz+o6SHB13T89X8M+FKEoZtUFeOzp1/
         lwhI6+7q4d7hrSmAdQiebpYipXwQySd0Ed7h/8SlB26Qp3ZH/4K9/f1qCRasatzDZLfi
         DT7sws1cF8q5zftglMTt9U/5n9eu1K7NExcA2Q/7HvehV1oUOF9R3UYELk34Ybc5ZtnB
         sI9pWYXe7lgkBOSDIOrFHbqR97BMJDruaXv8Be74K0nmzoaAklFV0ds1zouVby6IX73O
         yFvOcHrl1jIPyyH8j34lBPxKCeGdXzn54Kj7HwiRjHtBGKOTL/XjxNhSUdbiYsTG/YuQ
         k6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945344; x=1757550144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06EnX4xNHqiA4W3dBLh6+8AEySVO628YRMoxqtZgpzs=;
        b=kd76rJNwSk6aK6w8/WnTO0iPK3TfU/aQWeot/HDqkxAp8k61sLiiOWhcvgVTGgEQD2
         SE668FSgYFVvrlelGXAI6qekP+yC3zA1iYvLSgGPDH0ktDWWqU7rguK8NfWLW6BDDdMM
         NVVu/B8b+sjcFzpoNGiy4zbyZtkqbe7P/amIJltOdhCeNJlfQKdWVFfpsMduvheFb3jF
         CEN+1RByftZqTjsCQx3OpllDdw0UYOkioQ0vucwyfzHjyNvtkJAzmwg0qEGLq2P8E79N
         eEXkqzop76DvfvVTImc92BqJOZnVaisjgetSCynpNGL7mSbQNhNdiLcr1yEaRKx8CAfj
         Htug==
X-Forwarded-Encrypted: i=1; AJvYcCWbkDCVsDpo3ixEEZdVjDktqQWAAlYFg2B0CKxm2GHQVO+GiP5/jNsCnpwY+fcffqdBnbxsTHeNP7COrfDK2lQB@vger.kernel.org, AJvYcCX3bLEUuKREjXNUKIfbMiBHl1ppsN/MD6e0ghH6aLO7at4DEQ6fqQ68elPjmBMxZQ9zaQvj5G0/4572UPrI3hMbT+7f@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfix3Q8ivdCUGlzHZeup2RATmK3yBAbM+CJgfiDKqLQ+YFKoD/
	QOmLZcOMY0cyQQ3NlJyXr6jIJEWy0TJ9QBv1/RvSzI4TERJ3GeT/kT2u
X-Gm-Gg: ASbGncu7G27gz5awP1zPUi5YVwwm0L4igp7gR9n4g1pkqLEeFhaBDcE6BNIQFTB0Icl
	TngOAH0YkWTgdAMkTZrm6xqt+u+f8ix2xE94ZinTEsRlfjgL1h1dD56t2QHMkRJQQSs0gd10Olp
	deSrFOOhVO64zA/iX8lq/Lb26s0PcbCDzREItLqjx8p0/YHF/06eMHzW+JeIGMzs/0o0Hoz4RxB
	Or85kfiqQczNezyDbWHxpi7Yqip4jbkSMtP2UL92QTp1yjunhYeIZdgSVLnBciL5lkVgtWjR9SZ
	t02jQPLgt2wbw17WEb4wzpa4xHO6eIIC0MZZV1OqTw5pWwT9CaM54Sr0nTBBHuRisNLYvtROH40
	33APKsZgilEHmuh0Jv/wbTrz4hiKB67c/CzLkKClWcktt1J8A63FMzjMn5drqReo=
X-Google-Smtp-Source: AGHT+IEA5bFflP+ewlk1s4zRmV7WjxdLsMy01rCTDV7VoKPhFZJggfHFuKygnu201Hh4P+tgmpwDhg==
X-Received: by 2002:a05:6a00:b84:b0:772:1a18:b8d0 with SMTP id d2e1a72fcca58-7723e3d1d5bmr16156720b3a.30.1756945344084;
        Wed, 03 Sep 2025 17:22:24 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:23 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 04/18] mm/ksw: add HWBP pre-allocation support
Date: Thu,  4 Sep 2025 08:21:01 +0800
Message-ID: <20250904002126.1514566-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-allocate per-CPU hardware breakpoints at init with a dummy address,
which will be retargeted dynamically in kprobe handler. This avoids
allocation in atomic contexts.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  6 ++++
 mm/kstackwatch/watch.c       | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index b5f1835586c1..2318779bde70 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -36,4 +36,10 @@ struct ksw_config {
 	char config_str[MAX_CONFIG_STR_LEN];
 };
 
+extern bool panic_on_catch;
+
+/* watch management */
+int ksw_watch_init(struct ksw_config *config);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..e7ed88700b49 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,63 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/hw_breakpoint.h>
+#include <linux/kern_levels.h>
+#include <linux/kprobes.h>
+#include <linux/printk.h>
+#include <linux/perf_event.h>
+#include <linux/sched/debug.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stacktrace.h>
+
+#include "kstackwatch.h"
+
+#define MAX_STACK_ENTRIES 64
+
+struct perf_event *__percpu *watch_events;
+struct ksw_config *watch_config;
+
+static unsigned long long watch_holder;
+
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("KSW: config %s\n", watch_config->config_str);
+	show_regs(regs);
+	pr_err("=================== KStackWatch End ==================\n");
+
+	if (panic_on_catch)
+		panic("KSW: Stack corruption detected");
+}
+
+int ksw_watch_init(struct ksw_config *config)
+{
+	struct perf_event_attr attr;
+
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = (unsigned long)&watch_holder;
+	attr.bp_len = HW_BREAKPOINT_LEN_8;
+	attr.bp_type = HW_BREAKPOINT_W;
+	watch_events =
+		register_wide_hw_breakpoint(&attr, ksw_watch_handler, NULL);
+	if (IS_ERR((void *)watch_events)) {
+		int ret = PTR_ERR((void *)watch_events);
+
+		pr_err("KSW: failed to register wide hw breakpoint: %d\n", ret);
+		return ret;
+	}
+
+	watch_config = config;
+	pr_info("KSW: watch inited\n");
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	unregister_wide_hw_breakpoint(watch_events);
+	watch_events = NULL;
+
+	pr_info("KSW: watch exited\n");
+}
-- 
2.43.0

