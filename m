Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEB3148C5
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792648; cv=none; b=F2PhPeZDeHlWjOjWQG/34gnsFSA4AHjNLk3b/UT+w5xQeR5722yIcHC2rK8Iyo4sxabDdqEYiBjOezrw1Aret5Sy/uNIrq5nMUfgt+nj57DmDG8HXoxW/v30u/QJX44IVFOUdLJx6MCsMJVbSp5tvVk0B0YkDVLpYA0FivQgvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792648; c=relaxed/simple;
	bh=g1wEhkOGJQ86eJMHw7XszrU/CWcE9VZPoVm5H+XJaoM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+VBJbQ71HhKWzcyoR+kRLU0GlQfXIZQLjOaI9237P3eq19/WYr7nsFRyg2dCWVCrP7f60q+QnPXmLVrx3/LdRA8/UU1Ps3PY8rO3pjUB944pwkQuku8KoT5hCU1gKCMCh5udvQSp/Qp1egXudTG1quChrcGbor1TeylWab5f8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/ccWJ/u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/ccWJ/u"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298144fb9bcso11585685ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792642; x=1763397442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLWfzYX4fFMPPLWMDyPb3KZEfyFxyFdWrCERfTSFQ90=;
        b=V/ccWJ/utRobCre/Wz8e8tqbqycDisjP2q87TSxtuMthhKPQTlu72MM666VB7dt95R
         DWQdUBORZ7JcxOtEySRkd4jisgm9Ju6tflUABM5MjOr3ed8oO7kOqRn3fAO4WltThERS
         ta1qbnUkWkgpoyTSGTSInWj1vh6xSOx3dwX9s4fmAgF9cKcbf3bCKGbM5h3cXNiLQhVi
         385RRvWom1Mv9QZIpo5HqR7bJYazQyMIzPa4hFWU6Sd0F5O+9rbvTGHnsxVUDGKUpaWI
         rZM8jnRZpLRPlgMkXWYN8sJyA2O4G1QYyn1EAjbfBIoJrYLSGj2FkgjtLf8p80VhE71p
         UA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792642; x=1763397442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pLWfzYX4fFMPPLWMDyPb3KZEfyFxyFdWrCERfTSFQ90=;
        b=xPFXPhD3UJ2/WFHsY7i1jGDzzz0RpGTVq/1SGcwDGFfT7f9LB4S3VeSZzrLOvejJ7h
         aynrO/1cdxYzxeK9G1BcuXye28uVVE4D9e5e4ZjxDTli29OiSB9XIHiuSi+QF09G55iJ
         5Cq6+nCixfF1A7QvkhNqIPvzGH2o+8tu0qKNSSQC/zfUD2hH8bbrsoaye3i+m3F5L41a
         rNr3bX8cfa4Ze4Bh6LsOc6jnwb1sFNISZnIVSKQQfQoCgobmQiwqu/rUp9hgC8OCDS8F
         P3SQ89aWmi4VXhmj00DTB4XFZowocwPUJ+/nloAhkQBDurMZxu7IZlex3SoFaxDIB9uT
         gp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/yrwsSG5rdWAZ37wK3cH3YMoajzltIxxj1CZu6BVJ34jFH6R04xyvknqPMjLJ4CuvnXW23IUDFVh6pO2nnaBW@vger.kernel.org
X-Gm-Message-State: AOJu0YziXDzcjx24yTcJoDRKGRx2FHglfiLLQ+N0OaKOjmYYOojZM/jB
	qYfW82ceQyelGWvXeTTWEVytc6QP/RbvQRfHqCR4lk9YWHhxKFf9yQGJ
X-Gm-Gg: ASbGncvX6p8QE3T7xaZHXDWh9UrkH+SipQG/NcKqidH7ZMM/+Sv6x0eZcM+rG+K9LoW
	7EntxjuT98k3WYhvDuBda9uIgOXQGGP/nYTsF1Xwzc2hiwPScAMBS2Qe+m3P6D2woC917m/pVCb
	HgjXRs5fV+a0s19MCI3TsMrgBGBdZnRhJ8uelg4GCi1Xx899XilUC94UU3KSm9zOW0/GUj3FMz7
	cybOuZH94IyyLGZL5Rr+fnwwMqP9sS8MhYCBzZyF0uLHSxIEWqLsay/1EsJVU4Hv3VZd7BbH6EN
	OibbQ0kwE97WipzfZKhIHcxfPIov1DdsunAj+X/pmiJpf1IHgeQEyFLTnm71TNq15ukCOUzYtON
	brKlMn+A7KmYAjeFJv8feZu25EGSGt24F+g7ZPAmyyHQsTL24uBITxKJbvPMfYmC0u3vQ7N7Rzv
	XM/GtPD+4PIl0=
X-Google-Smtp-Source: AGHT+IG/cFQI/lmXu5Y2kAApFRNeOGqv88LbladeQ9d14Tfk1RPsTiArc8xlLuvBlu4N/APLeeqQog==
X-Received: by 2002:a17:902:f791:b0:297:e267:c4c1 with SMTP id d9443c01a7336-297e5718125mr109122315ad.55.1762792641884;
        Mon, 10 Nov 2025 08:37:21 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740b5sm154589925ad.70.2025.11.10.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:21 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 09/27] mm/ksw: ignore false positives from exit trampolines
Date: Tue, 11 Nov 2025 00:36:04 +0800
Message-ID: <20251110163634.3686676-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because trampolines run after the watched function returns but before the
exit_handler is called, and in the original stack frame, so the trampoline
code may overwrite the watched stack address.

These false positives should be ignored. is_ftrace_trampoline() does
not cover all trampolines, so add a local check to handle the remaining
cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 3817a172dc25..f922b4164be5 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/ftrace.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/irqflags.h>
 #include <linux/kstackwatch.h>
@@ -14,10 +15,46 @@ static DEFINE_MUTEX(all_wp_mutex);
 
 static ulong holder;
 
+#define TRAMPOLINE_NAME "return_to_handler"
+#define TRAMPOLINE_DEPTH 16
+
+/* Resolved once, then reused */
+static unsigned long tramp_start, tramp_end;
+
+static void ksw_watch_resolve_trampoline(void)
+{
+	unsigned long sz, off;
+
+	if (likely(tramp_start && tramp_end))
+		return;
+
+	tramp_start = kallsyms_lookup_name(TRAMPOLINE_NAME);
+	if (tramp_start && kallsyms_lookup_size_offset(tramp_start, &sz, &off))
+		tramp_end = tramp_start + sz;
+}
+
+static bool ksw_watch_in_trampoline(unsigned long ip)
+{
+	if (tramp_start && tramp_end && ip >= tramp_start && ip < tramp_end)
+		return true;
+	return false;
+}
 static void ksw_watch_handler(struct perf_event *bp,
 			      struct perf_sample_data *data,
 			      struct pt_regs *regs)
 {
+	unsigned long entries[TRAMPOLINE_DEPTH];
+	int i, nr = 0;
+
+	nr = stack_trace_save_regs(regs, entries, TRAMPOLINE_DEPTH, 0);
+	for (i = 0; i < nr; i++) {
+		//ignore trampoline
+		if (is_ftrace_trampoline(entries[i]))
+			return;
+		if (ksw_watch_in_trampoline(entries[i]))
+			return;
+	}
+
 	pr_err("========== KStackWatch: Caught stack corruption =======\n");
 	pr_err("config %s\n", ksw_get_config()->user_input);
 	dump_stack();
@@ -164,6 +201,7 @@ int ksw_watch_init(void)
 {
 	int ret;
 
+	ksw_watch_resolve_trampoline();
 	ret = ksw_watch_alloc();
 	if (ret <= 0)
 		return -EBUSY;
-- 
2.43.0

