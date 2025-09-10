Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D626E158;
	Wed, 10 Sep 2025 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481941; cv=none; b=WFB6LAfU7Xh4RMnBstl8BRQCrv78/XoaYAcpjG+Wlxxil1g2I7gKscaRL98aZz6LrAkPcT0f5T7UaxusdiHUGnheAVVDhOt38rVsuZHHWliy7Ziw34nMgeu2SBGZfkY/VFTsANHbWcc+tP5ixPl4hewFPgS6Y+yq/INGzaFLFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481941; c=relaxed/simple;
	bh=0adOy8meHFR7umTHr/HWxiYI2clquNcH3qm9oR82DUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/RB1QWPVdtyhAvl38z47VJfBnGwBXEermoY0J6gvE/tdPuuAVQ5UwaUBGH+vCDd1CmbHZ7HZb0W5GB4C+qihb6BDtosZGkKvFkdLZpkkP/AT6cLyrlMPbVrpJXNCPFDbfKFfdsYh/eIY8jLn6aGrGjelazqBF1V/ghXW51s0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiqcgR+z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiqcgR+z"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5488c409d1so643249a12.1;
        Tue, 09 Sep 2025 22:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481938; x=1758086738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI10mDfREFn5Rx/uTs3tJDtAseKlBmy4SikYDBaNSc0=;
        b=UiqcgR+z+Odr2V9P7FTta0+WNL7Vw56yc/XFaOT9GgwodWuqTfDzQPKXv44w77ZWpT
         tfgdeffSd9dNNk/QKT5/TMpsOMr1BXh9jgYYwH3Qlg5XzyrlLmiC9HipeQks1N0UPuXX
         c04h4vSEMi0HrMwCAAeJWulMMB+4H6d6LgdWUIF/5U5DFzTt/DozwS46cCuN0duoqQxY
         UMopV6PejvwG0YZgSCU/OCyIxj2HXHzyiPqggo9niohjkuLa5+t0fZzceCC4bXQlS5kZ
         xSur1Qch02/bmF6yCB50ucoo5GPpERZRBMIiPadrbmsAlDdT7t87sYanwE1IpliI8Mhr
         f70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481938; x=1758086738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI10mDfREFn5Rx/uTs3tJDtAseKlBmy4SikYDBaNSc0=;
        b=MhDsC8bORBUDqf0/f8mrrOpDJSWf63MwnFnKH2ymLWuwcaUVGwp2IeNZ6PbVm56w49
         XX1KYb9z3SwNsO89dXImpO+fce1Wh1msx8c1St+4MZzNaoHjdmU1AkfWdNqvc5AU8XbA
         ei4mbMkryaGd33OtBWDLRfipGNDgo1BfyIGqqDb0/bjQ4w8GVm7Kr4lXy5+l21pSNNRP
         WzZk6ie9BsS2FIwo0CW4E0XTddfOudqg8PjofZhA15c2+UQpVbd+o8kSxeHyXk86d13Q
         Ny6meLGUaayS/JSiGaCUcCKUJAe55nAc3cPYp2atTb+FIr22BmpAZ+fzfilA0rM+0eLI
         rSJg==
X-Forwarded-Encrypted: i=1; AJvYcCUVast4s0HW0bdCHR3aWNLyLxBzNP/FVaHjSWJWRP6bGMLaHeM9FWLPKJ8jiIp19QRaty8HqxScUODm25bjkVsr@vger.kernel.org, AJvYcCXXs6sn64ecShVV4vk56mM9sgitCx4+Z3Y5wTaEAM0C1WtgUI8xz100rEtIwYj7Hg94xBiST3G9iLjjt8vJ6UUQocpm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoh3w+R8+VPMkELOUHZuXgYgA0zu2zMBzjTo/0FA86721Akida
	of5Rg8a75MyKuUFYPksQvxLxFPwaG3THa8Oen2pb8R3QIONksrPkooXE
X-Gm-Gg: ASbGncuRhlu1VwDqetbq0pmIbcnmfjofSqL4llcaL0YpDKt8LSDy2T82+Rbv5J/qmhG
	ZRKfW4evl/ANEHsWGftR3qdL8rCOZ1Jlp22cSuPxaESvsEOgbwR2AuSbbgTRuFMx77VN15UVv7r
	Q/isjwkXXWc/7OaQS2FOPjPMrA7JFA+KjyKs8EK8Z7ERiu7qoxQh7Q7nD2iJLQjNISd4Mtk58yX
	arbqy7j3lTOvD6Hoet0MwDoimGyG7oWYodONZEBu7CHYavwSo2gMSFiDjJfqf5DxXsWf4DlP25J
	Q1QUIc3eG3Z7/FVuE4SRLyBxwxaBtO80EMgGYHaBfYxlU7UmjnpZGwi5juwRiOMtBU1S64Uz6uF
	2zSAg9pK5yLiorHLMTYclKvaC8hFvFwTHuQ==
X-Google-Smtp-Source: AGHT+IGA+Aha8Lgq4/YHb8bC+D+e+AQfCwDSLkoSj/ul/ONnfZ4SFI21gPvhy1l9BFhjs6AI1wYwTw==
X-Received: by 2002:a17:903:288:b0:246:cb10:6e2f with SMTP id d9443c01a7336-2516ec6f1c3mr207113305ad.26.1757481937933;
        Tue, 09 Sep 2025 22:25:37 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:25:37 -0700 (PDT)
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
Subject: [PATCH v3 06/19] mm/ksw: add HWBP pre-allocation
Date: Wed, 10 Sep 2025 13:23:15 +0800
Message-ID: <20250910052335.1151048-7-wangjinchao600@gmail.com>
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

Pre-allocate per-CPU hardware breakpoints at init with a dummy address,
which will be retargeted dynamically in kprobe handler.
This avoids allocation in atomic contexts.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 +++
 mm/kstackwatch/watch.c       | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 277b192f80fa..3ea191370970 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -38,4 +38,8 @@ struct ksw_config {
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
 
+/* watch management */
+int ksw_watch_init(void);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..d3399ac840b2 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,56 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
+
+#include "kstackwatch.h"
+
+static struct perf_event *__percpu *watch_events;
+
+static unsigned long watch_holder;
+
+static struct perf_event_attr watch_attr;
+
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch, "panic immediately on corruption catch");
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("config %s\n", ksw_get_config()->config_str);
+	dump_stack();
+	pr_err("=================== KStackWatch End ===================\n");
+
+	if (panic_on_catch)
+		panic("Stack corruption detected");
+}
+
+int ksw_watch_init(void)
+{
+	int ret;
+
+	hw_breakpoint_init(&watch_attr);
+	watch_attr.bp_addr = (unsigned long)&watch_holder;
+	watch_attr.bp_len = sizeof(watch_holder);
+	watch_attr.bp_type = HW_BREAKPOINT_W;
+	watch_events = register_wide_hw_breakpoint(&watch_attr,
+						   ksw_watch_handler,
+						   NULL);
+	if (IS_ERR(watch_events)) {
+		ret = PTR_ERR(watch_events);
+		pr_err("failed to register wide hw breakpoint: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	unregister_wide_hw_breakpoint(watch_events);
+	watch_events = NULL;
+}
-- 
2.43.0

