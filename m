Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A3270542;
	Wed, 10 Sep 2025 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481956; cv=none; b=BJlmaexnn+AsYOrfV/MZbWK6tLdxNEmS+POCgB/QnbWwnYHqtj7NwWxjqQIWdM/Xi3WELeTuoDzyMU4N0+dgQ8EHrC7pnUE8VECpM1ZS1Y9t963M1UmNMCoqBp1jng/uV8ZWQgOiq8QeCanW3hjL7m5U3eYtKI/5n9J6o6e2b3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481956; c=relaxed/simple;
	bh=YB+3r6DZaWoq0w2fIDHea418Mq4qZBHZObo3HzPDBB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBwImQB7aY/a3aWzNKgi37KIch2kBwkzFO/zsu9iQ+RXyROySdjWeWOthHGiQ97gaE1LERVbGqb/WcnlWBDdWBrpPvoFpAtW4mAK4MBicei5CNd4OLd+/EwapbJSsIlaVNdqMsUimneSvriaM1e14LUn4+lS6a0dx8sOodpGlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOcNULfZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOcNULfZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24c784130e6so71284125ad.3;
        Tue, 09 Sep 2025 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481953; x=1758086753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOx6p8YhFEr+hG/yZ9Zg64+RQ0caUuIY8LjmjDVRe3w=;
        b=BOcNULfZQfiWohw0IrkESSgU3GMuj5RjaZN7Rt94Pee/BcIkfPgxMZ5uBdoV2GHxAA
         G77DZRWyMtcMhsEVuD/ZeQTGAG016quDTmx39yvGpnB7Ltv31tTvFmDJsp/cv8Es1N1v
         jHqtDbrtPzHYRkKoMUd19puSwDQGfyNwTvaiCVGiLfBk7z5Q4OaNuRvP8wynn0JEo4lC
         2yjZ69sraRZCpABhJctAb1qXW2F+vbYarzHk6mv3jT529GOtEjxWiT8BkEF/EddwB+c3
         w703CNK/vMiuhZKyVw/F5yCKzMaljBsm/lBymul/apW4Cm9+Z5ooW4+kZg4EoIABxuf0
         fy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481953; x=1758086753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOx6p8YhFEr+hG/yZ9Zg64+RQ0caUuIY8LjmjDVRe3w=;
        b=CGjoBBEAHSxWT7hZJEnbIw/R1JYh9OsXr+3DWy0tF/dYKX29ANkM46kfbfJVKXkGRr
         zDZf/PANaHfvjgdHKRH1hZ/S2dUXkjrRHZ81GrtEq6UI3ZL4FnWuenjA4k447Fiq1Bt8
         pp9OV89lhNxkHYeAcfAVx1OIJVcDNOb3SzhBRiLX+J8cDvy908UStY6Sii8NWcR6JeBj
         HrmC7puQ4AxVtAtVbJil1xjPpVo23NhgHVvFfyyXIYwfUOj0GOwRVbkOdLySBfJaEDWj
         b3wg+6FovbF+7NyTsGSqzCcAjW+9dQ5HVZsDnfBPQUPLGCpKso3bYNi/6++VjzCW+8NF
         ZZXw==
X-Forwarded-Encrypted: i=1; AJvYcCXknbBfQIMTXTLbFaIAo4c1VbCR93HWPjb/l6T8pJ40asaPwN8pTHmb06Di4qTRaJ4L2TG5WpyrnK5URyPO8yPpBXxK@vger.kernel.org, AJvYcCXs+OkMV4wwAFUvTrWnf7c3Fo6I7Fadl7IIbAOm19JuVvDbUvpEqK6jjorYIimBwCemg8cf4ZB1qGR0mI08+tUA@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqSQExzMwX95IrvQjUUZkxo+NBbNZfvq7l4jR8MxEziLtnHuw
	h7s0+PAuzSWRMf6ygGkJCFkAqEBrVYuTOq6duqldQI8/vWOlSmxgKWBq
X-Gm-Gg: ASbGncsTvSOAjAMg3grxv1S+8VoNWmJvOMja15oZENIBLbKKziqFpzEv+Vv2i1O67xI
	bQnA40XKintnZis9MT0DEaiRB2ePTeKVFvapBIHDGuGNnIBP5EFHQoFmMQ1cxE91LZO5jRlBbWS
	EDX000kjxHQEZLCL07/sbuooV97MWTb4MWprItTSfRNBK6JRrK3ZF2WvGEjUKP7qte4AuNCxeMh
	dCi/kvU5exrnEoMc3uA5haYH0FOY7HYpVuNFaKsNWps5YafN7WZU1E+QG0qpMMdcpnXS4i3f9zN
	mhjP4gHpisJ+ISyU5Qf61RbN1IZ28UMjhv5SDZ0shD4NUkoDBuZNP2Fw6wkwCwn7dgwkzAITN5m
	nOYE58c8Pr9KKZ+HXRvxoUok/n5ljUL/fhg==
X-Google-Smtp-Source: AGHT+IE+2ZvUwlvbAD3bNh5YTXYd3TWYyXRPD2VsUudLsG3CxrebrDDY5hB3nLhTzBib0WtkqPJfKw==
X-Received: by 2002:a17:902:ebc6:b0:246:255a:1913 with SMTP id d9443c01a7336-25171cbfd65mr173971245ad.39.1757481952659;
        Tue, 09 Sep 2025 22:25:52 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:25:52 -0700 (PDT)
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
Subject: [PATCH v3 07/19] mm/ksw: add atomic watch on/off operations
Date: Wed, 10 Sep 2025 13:23:16 +0800
Message-ID: <20250910052335.1151048-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to atomically turn the hardware watch on and off without
allocation overhead.

The watch is pre-allocated and later retargeted.
The current CPU is updated directly, while other CPUs are updated
asynchronously via smp_call_function_single_async().

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 +
 mm/kstackwatch/watch.c       | 95 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 3ea191370970..2fa377843f17 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -41,5 +41,7 @@ const struct ksw_config *ksw_get_config(void);
 /* watch management */
 int ksw_watch_init(void);
 void ksw_watch_exit(void);
+int ksw_watch_on(u64 watch_addr, u64 watch_len);
+void ksw_watch_off(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index d3399ac840b2..e02ffc3231ad 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -3,16 +3,23 @@
 
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
+#include <linux/preempt.h>
 #include <linux/printk.h>
 
 #include "kstackwatch.h"
 
 static struct perf_event *__percpu *watch_events;
+static DEFINE_SPINLOCK(watch_lock);
 
 static unsigned long watch_holder;
 
 static struct perf_event_attr watch_attr;
 
+static void ksw_watch_on_local_cpu(void *info);
+
+static DEFINE_PER_CPU(call_single_data_t,
+		      watch_csd) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
+
 bool panic_on_catch;
 module_param(panic_on_catch, bool, 0644);
 MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
@@ -29,6 +36,94 @@ static void ksw_watch_handler(struct perf_event *bp,
 		panic("Stack corruption detected");
 }
 
+static void ksw_watch_on_local_cpu(void *data)
+{
+	struct perf_event *bp;
+	int cpu;
+	int ret;
+
+	preempt_disable();
+	cpu = raw_smp_processor_id();
+	bp = *per_cpu_ptr(watch_events, cpu);
+	if (!bp) {
+		preempt_enable();
+		return;
+	}
+
+	ret = modify_wide_hw_breakpoint_local(bp, &watch_attr);
+	preempt_enable();
+
+	if (ret) {
+		pr_err("failed to reinstall HWBP on CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+
+	if (watch_attr.bp_addr == (unsigned long)&watch_holder) {
+		pr_debug("watch off CPU %d\n", cpu);
+	} else {
+		pr_debug("watch on CPU %d at 0x%llx (len %llu)\n", cpu,
+			 watch_attr.bp_addr, watch_attr.bp_len);
+	}
+}
+
+int ksw_watch_on(u64 watch_addr, u64 watch_len)
+{
+	unsigned long flags;
+	int cpu;
+	call_single_data_t *csd;
+
+	if (!watch_addr) {
+		pr_err("watch with invalid address\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&watch_lock, flags);
+
+	/*
+	 * enforce singleton watch:
+	 *   - if a watch is already active (bp_addr != &watch_holder),
+	 *   - and not asking to reset it   (watch_addr != &watch_holder)
+	 * then reject with -EBUSY.
+	 */
+	if (watch_attr.bp_addr != (unsigned long)&watch_holder &&
+	    watch_addr != (unsigned long)&watch_holder) {
+		spin_unlock_irqrestore(&watch_lock, flags);
+		return -EBUSY;
+	}
+
+	watch_attr.bp_addr = watch_addr;
+	watch_attr.bp_len = watch_len;
+
+	/* ensure watchpoint update is visible to other CPUs before IPI */
+	smp_wmb();
+
+	spin_unlock_irqrestore(&watch_lock, flags);
+
+	if (watch_addr == (unsigned long)&watch_holder)
+		pr_debug("watch off starting\n");
+	else
+		pr_debug("watch on starting\n");
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		if (cpu == raw_smp_processor_id()) {
+			ksw_watch_on_local_cpu(NULL);
+		} else {
+			csd = &per_cpu(watch_csd, cpu);
+			smp_call_function_single_async(cpu, csd);
+		}
+	}
+	cpus_read_unlock();
+
+	return 0;
+}
+
+void ksw_watch_off(void)
+{
+	ksw_watch_on((unsigned long)&watch_holder, sizeof(watch_holder));
+}
+
 int ksw_watch_init(void)
 {
 	int ret;
-- 
2.43.0

