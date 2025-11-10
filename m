Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25031329D
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792655; cv=none; b=cY0TmXWeVlzAPYtiyRG2zfbVJXJzWi1nChHwZ6LlZqCDZUNC5Vp3NGH7wMxgSybR5Y2j6Y4WuNaHd7Ux3c5IYxtjOZsTOJ/RQgf8krTS4rCkP4cCy9G5RANoDp0pWEMZxZuOxVKEn9Qaxq+RI1iscir/7DTiUA5Q5MErvVaPBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792655; c=relaxed/simple;
	bh=/b/zOktEwqAjI5HJj6uEpLQ11BHnYeMx0oURGuRUTjs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfFzoIovPkTO8Ounwqx2mxbijlY+fKz/7GJcuB8nN/6T2RmgnhYLbrO/QDlL+CPDI9Jrg0UUgpd8rYFYKF60Mf28MeMpOEL7tjpnW6qCKmGtyKLsOFlO/M9fQtCXAIRgupUK381GBCAH/Fzot12Fa6aMkolqFtQToiejC1xk8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1SLqfyD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1SLqfyD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297dc3e299bso22253915ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792650; x=1763397450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmTHCnPEb0OVb2q4c4fHcn++Nk34I0DPY6dUiFoe4Xs=;
        b=Y1SLqfyDfR8ppi0EnhB5ihICf/DW8etj06fLjMr71E7TRvRl2e2hEpaly2M5h5KEYb
         +30JYjqd6vMFwoX6PLbUgi4uiVEBLehaoK++cGI0AF+7ptsbbCN5DIL2wRTIyfY31xj8
         zRSi1+Zw5Rg/Jc9DW6cXZOe0qOjpVijNAKDgElrCirdv4w28YiVkB+H/8x2eh6nHc1Br
         +1MIm7SvPnJTrTFjwzp/FUERRF6HopdhqqRcrMDxJa9X0WGxd1HdcyBXo8s6YgrWMVMB
         a6e0K2286aeD036eGmVxme/1fILqXivvLNDXy/BoZxfaiPntVpPoeVD3MQotC1wXu9E/
         t5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792650; x=1763397450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmTHCnPEb0OVb2q4c4fHcn++Nk34I0DPY6dUiFoe4Xs=;
        b=qQg8RpVhjHYB7IKcSQ6YRtxQrPoAwJVSdstQqlfOL6Cj1DFkmoM/am+WcKZrCijiQO
         ugcPpAmtv77QxPS7xAbaJBWUYcCHUSukmtMPcVo0HMC9hI+6eJB0Ivv7raMihuNjkNK4
         p49TW8L8RFVBQT8E8BUDbjGE8LqLdgg6QPCzb4Cd16Msfef9z37BZRIwMo8p5c9nUciR
         CVdnMIHqy4FWvyknTi8AhjSVz2hO4PkiQVuyl/bPD3i65/sZgDWUEGpyDphij1ohhpqF
         ZRpzLIXmzZjQ7gj2KVAzSU6KUyL//JBlbjRiciANf6hby5XNIxumyKnMC8+IK/+dUN48
         OFog==
X-Forwarded-Encrypted: i=1; AJvYcCWYAoPFONV/jKA/XkjXIc3Ys4jEBD1lvoe/waGrhyCgUhQnk1VF5GKNnY4W/NYoOap1Tud//8gsHq7//hsXnR1p@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHubSk9F+nkBc6AVzNZquX2xKL58SNHM1Fq5aSTTfYsH+756C
	Id1TulQrBOxQ0Ef1xUpvmdr8TOU/1xwGrOv06W/gyuEn3R54gV/owFh9
X-Gm-Gg: ASbGncurhFjqTCHTVY9HGJMnXo2eIy6hOaAJIgPMKtlTFd/xkufSFFQ5V+sr/gKfAxd
	OYSF+tavl9Z5RZ8uKMtuLPjohk7VmsBW8TmfqhwoxPyZhew8EFs+Sfcbk68PU2JfMxxPbDJ8yDH
	ii81E1qVTqXwVX8UDC0jXR3FyBvRdy3Dnu8b6JdybGjD1gl9y1nSKQslC3tDOOK7yPp6es6cVCO
	Q/6xFnMFe0bkxnJR0hPREbyQyDmRGbQNN/ezduQcwUn67727Q0omT3etEVAbywBky9tVLDLManq
	COk4g3A41M94dDONc4fTEGYynl9+horC9DzhoC65pXKw48kMnt9NuBaZ0vsWhcUxxUwhjHX/Avf
	KSlCpDkgZjaEW7Udnp9a6unoYqToybhtnWIYYat5sRJHB0Jh1dsf9zCG6CFJrXuw++RyXh/Whl5
	73Wtlb9/2Uw+Ib28C1VHNhdw==
X-Google-Smtp-Source: AGHT+IFq15Zr3Z90Q0MMFQV+lAVCnrHviaSI2/PKIFU3mj11pJDvw+OMCcvtXWZk8em43woe/8IelQ==
X-Received: by 2002:a17:903:944:b0:296:3f23:b910 with SMTP id d9443c01a7336-297e5619f92mr100007215ad.9.1762792650184;
        Mon, 10 Nov 2025 08:37:30 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm154506025ad.7.2025.11.10.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:29 -0800 (PST)
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
Subject: [PATCH v8 11/27] sched/ksw: add per-task context
Date: Tue, 11 Nov 2025 00:36:06 +0800
Message-ID: <20251110163634.3686676-12-wangjinchao600@gmail.com>
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

Introduce struct ksw_ctx to enable lockless per-task state
tracking. This is required because KStackWatch operates in NMI context
(via kprobe handler) where traditional locking is unsafe.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch_types.h | 14 ++++++++++++++
 include/linux/sched.h             |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/linux/kstackwatch_types.h

diff --git a/include/linux/kstackwatch_types.h b/include/linux/kstackwatch_types.h
new file mode 100644
index 000000000000..8c4e9b0f0c6a
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACKWATCH_TYPES_H
+#define _LINUX_KSTACKWATCH_TYPES_H
+#include <linux/types.h>
+
+struct ksw_watchpoint;
+struct ksw_ctx {
+	struct ksw_watchpoint *wp;
+	ulong sp;
+	u16 depth;
+	u16 generation;
+};
+
+#endif /* _LINUX_KSTACKWATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878de25c..db49325428b3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -22,6 +22,7 @@
 #include <linux/sem_types.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
+#include <linux/kstackwatch_types.h>
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
@@ -1487,6 +1488,10 @@ struct task_struct {
 	struct kmsan_ctx		kmsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KSTACKWATCH)
+	struct ksw_ctx		ksw_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0

