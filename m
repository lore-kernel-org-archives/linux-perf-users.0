Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5862F7AD5
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792627; cv=none; b=r9G38IJF9NxOiTYPIi19jZxyRd3JuHQppjjdBKctq61RQ9sgXD+uFA/QhMaXD3b9HLHktATvEPOk5fMyGZcdFo0tuTwvYOeN6gKIPJ3GiuVe+lhQChFnwfhXGdL4R17veR3Ye1anKpbYD1fehK08fdCUIwFvUiWzGOMlexSGgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792627; c=relaxed/simple;
	bh=J0fK6zHQukT5AAwp1WNQGcCty1gFWyGS7LkumBAy8ig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/H1eBRd6sadNYqwKfHkbEKSURx3QqSKTmcu2ONNKJK1j0uhdVTIUq14zTOqffhpyCBBl98blpBAQ7xyrHV7tocvlCBDpvlxtSlXYPzWHp9XwSNplZgMoW6BoTRER03yxEErlbkajm0f9YdXo9VEQeZ3S7mRpqKJjbgYZNdxwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGyi+xcx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGyi+xcx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29806bd47b5so8842015ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792624; x=1763397424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouGNoGCEWNf78k//tY5pOloDk6SH5B0un9nqZ5MFRzI=;
        b=XGyi+xcxLZak97Bc7irfqdBIjXPUti3QhMP1P/HrDY1YyjQknLDM/qeJsSmwSalA8m
         7kcurpTZpo0Lnnib56QmC9Pe0ed6b5JO+3XcPBlbk8olz8XfHUOC8N4KHhUWbJVMt4ZP
         tk6xe9xaEH8Lc0f2sDkSN5dvNxdrTvOVOXE13oLZWB62CANuv9dxqPTYMIXC51B3GFpY
         5nFX6quPVJ3pN3yVadtnORz5yJdOeaD/aUt8a0NSQvgcO//wytHpdQz03zhvOG6eFtkL
         E3ZMDAjkEb7maebXG55EbZwgT/oCQ/nytLl4efb7lDjcZPhCcsijtWh900xGmWxTTTzw
         4nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792624; x=1763397424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouGNoGCEWNf78k//tY5pOloDk6SH5B0un9nqZ5MFRzI=;
        b=G2ReDAvHWEEjfkCHHVga89RRFe/+dlumOFwHvNd+yjTMhzwvYrHDvopGRoLj4ZvUT7
         0AGak1wdFZ4Cb+6LXyIVSbePJ7PEmMQb+xo3oHxZwpMa2iR0DPi5B3hz0XQMX7jk6CN4
         BIEM3uhJQ3IFrEStDdqx35ak5PGPEclbOGT+YBNxofZmtmICaVSjAvWN3onakt6WlzkB
         P51mwyza3YUW6buRpjzdYA88zHMcB/0S45OS7QhjRjVGg8EaibJn27LyMywXou76G6hl
         UCOMm7LkHig5QeYAw7XZ7kCQ3NgxX9w83kFQCNCxiDoBLUS66HdyQ/X2QQGxgZv+1E9z
         furA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNV4k7/4VeQa0aa2z/40XZ8iEwQXXtkYOJv6G8k6bRQsKuwDmh8uSCPTVbD1xm+eskNO78n6qwrZdGmmkJncw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XDqBrTJv934QB26BjV8qPCUdJ3xyz4UCIHgzrjZSfO4hjLLe
	fxdGiT1m2qmIV/g8EMDsITA4wmXyHANr7ypxWqgup/+YjuljN1ySZKoT
X-Gm-Gg: ASbGncvRQiHwsQtK68urouWA0tDheYrnG41iPxCMh5Zz+zzPugkY4zCldKaN7k4vss+
	MtpqSwNTDrjPzLzuRSIlvunuLgOHw1yZMek7m2Clpzvfz6jhhckQHFQsGw+D7i2upvEEO07Axcr
	pkV2TbVq3iV1oDyqAhCGff9Is1nSSjCgFLcmXxelP1FEvg/N3zLO2T44/8q0OXEybrlihNo49Wx
	dzhapx/keucLPyS8ADp4pkg7+72av+y/3+uokgCYKGce4YjtNW9Y6u+OOoWEE2XUZC602whpHHk
	Lig8bo0TUotkjwitxRaLhJtPmr1wyQ0jioy8BYjXTnWgukEYu9VDJpYlU5WL80hOCRa3J1JYjvy
	E/u9jhyzDZ160Xevt15oRfLpL9LeBuGB96yPKiuy0rnQgWKnTQj9kKk8n0gfbIXSMub0wwChVUW
	PKDbf6poE59KegkJMqgTbb4w==
X-Google-Smtp-Source: AGHT+IEv35u8inwf//3hNgNcTHKrbkmcMG/RxR47Sb7uiTU4vtvIQ3hgGu7aTHTaitcgX4VFQg+h0Q==
X-Received: by 2002:a17:902:ecc6:b0:294:f1fa:9097 with SMTP id d9443c01a7336-297e56d621cmr108081745ad.34.1762792623885;
        Mon, 10 Nov 2025 08:37:03 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297df996d31sm88101695ad.13.2025.11.10.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:03 -0800 (PST)
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
Subject: [PATCH v8 05/27] mm/ksw: add ksw_config struct and parser
Date: Tue, 11 Nov 2025 00:36:00 +0800
Message-ID: <20251110163634.3686676-6-wangjinchao600@gmail.com>
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

Add struct ksw_config and ksw_parse_config() to parse user string.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |  33 +++++++++++
 mm/kstackwatch/kernel.c     | 114 ++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index 0273ef478a26..dd00c4c8922e 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -2,4 +2,37 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/types.h>
+
+#define MAX_CONFIG_STR_LEN 128
+
+struct ksw_config {
+	char *func_name;
+	u16 depth;
+
+	/*
+	 * watched variable info:
+	 * - func_offset : instruction offset in the function, typically the
+	 *                 assignment of the watched variable, where ksw
+	 *                 registers a kprobe post-handler.
+	 * - sp_offset   : offset from stack pointer at func_offset. Usually 0.
+	 * - watch_len   : size of the watched variable (1, 2, 4, or 8 bytes).
+	 */
+	u16 func_offset;
+	u16 sp_offset;
+	u16 watch_len;
+
+	/* max number of hwbps that can be used */
+	u16 max_watch;
+
+	/* search canary as watch target automatically */
+	u16 auto_canary;
+
+	/* panic on watchpoint hit */
+	u16 panic_hit;
+
+	/* save to show */
+	char *user_input;
+};
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 78f1d019225f..50104e78cf3d 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,16 +1,130 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kstackwatch.h>
+#include <linux/kstrtox.h>
+#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/string.h>
+
+static struct ksw_config *ksw_config;
+
+struct param_map {
+	const char *name;       /* long name */
+	const char *short_name; /* short name (2 letters) */
+	size_t offset;          /* offsetof(struct ksw_config, field) */
+	bool is_string;         /* true for string */
+};
+
+/* macro generates both long and short name automatically */
+#define PMAP(field, short, is_str) \
+	{ #field, #short, offsetof(struct ksw_config, field), is_str }
+
+static const struct param_map ksw_params[] = {
+	PMAP(func_name,   fn, true),
+	PMAP(func_offset, fo, false),
+	PMAP(depth,       dp, false),
+	PMAP(max_watch,   mw, false),
+	PMAP(sp_offset,   so, false),
+	PMAP(watch_len,   wl, false),
+	PMAP(auto_canary, ac, false),
+	PMAP(panic_hit,   ph, false),
+};
+
+static int ksw_parse_param(struct ksw_config *config, const char *key,
+			   const char *val)
+{
+	const struct param_map *pm = NULL;
+	int ret;
+
+	for (int i = 0; i < ARRAY_SIZE(ksw_params); i++) {
+		if (strcmp(key, ksw_params[i].name) == 0 ||
+		    strcmp(key, ksw_params[i].short_name) == 0) {
+			pm = &ksw_params[i];
+			break;
+		}
+	}
+
+	if (!pm)
+		return -EINVAL;
+
+	if (pm->is_string) {
+		char **dst = (char **)((char *)config + pm->offset);
+		*dst = kstrdup(val, GFP_KERNEL);
+		if (!*dst)
+			return -ENOMEM;
+	} else {
+		ret = kstrtou16(val, 0, (u16 *)((char *)config + pm->offset));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Configuration string format:
+ *    param_name=<value> [param_name=<value> ...]
+ *
+ * Required parameters:
+ * - func_name  |fn (str) : target function name
+ * - func_offset|fo (u16) : instruction pointer offset
+ *
+ * Optional parameters:
+ * - depth      |dp (u16) : recursion depth
+ * - max_watch  |mw (u16) : maximum number of watchpoints
+ * - sp_offset  |so (u16) : offset from stack pointer at func_offset
+ * - watch_len  |wl (u16) : watch length (1,2,4,8)
+ */
+static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+{
+	char *part, *key, *val;
+	int ret;
+
+	kfree(config->func_name);
+	kfree(config->user_input);
+	memset(ksw_config, 0, sizeof(*ksw_config));
+
+	buf = strim(buf);
+	config->user_input = kstrdup(buf, GFP_KERNEL);
+	if (!config->user_input)
+		return -ENOMEM;
+
+	while ((part = strsep(&buf, " \t\n")) != NULL) {
+		if (*part == '\0')
+			continue;
+
+		key = strsep(&part, "=");
+		val = part;
+		if (!key || !val)
+			continue;
+		ret = ksw_parse_param(config, key, val);
+		if (ret)
+			pr_warn("unsupported param %s=%s", key, val);
+	}
+
+	if (!config->func_name) {
+		pr_err("Missing required parameters: function or func_offset\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 static int __init kstackwatch_init(void)
 {
+	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
+	if (!ksw_config)
+		return -ENOMEM;
+
 	pr_info("module loaded\n");
 	return 0;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	kfree(ksw_config);
+
 	pr_info("module unloaded\n");
 }
 
-- 
2.43.0

