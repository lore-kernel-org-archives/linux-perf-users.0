Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4512E0904
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007441; cv=none; b=hp/fUHnzsQ3VcsQyP1WGNb3lpjYdiqtwc2dE9ouIIrjzKiBoO9XzZ8PF2bgQ6NkxjsTKHXWc9E+UxMDKrmuCb1h5l5Ud92sYFoUUsamz/jW3IZTCgw+wb9tGCVd+LRIspm/vd3xSGaFY33gLYvMOctQeHxxGZXgRQ0s9h1C7iHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007441; c=relaxed/simple;
	bh=nX8M+4wLqDNsj44hk02fNEaF/gPIR5p8f+vD+YBgTKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGs6Romd85K/B5WWhy5ub+57Nnxqmt1orvjtmSibf4kQAefxT/shjA1tDUNBs/c96Z4S1HUYVbpA7FHuTGbbqDBNoEVmiLXqBM7+r5pwVwkE1TuJDQWR70jKEjv7fXWgruMp9R0Uv+X0GCa9UvydWVYm5NYmE+TBYHgp0DlKELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0aar/KY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0aar/KY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so711446a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007439; x=1760612239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjBqC5OmraL0dv+F2ewe7IKGLAdUyg9AVVWKAy3m9Vc=;
        b=S0aar/KYRoKLFek7zhZ83xVSoBqtfMdEu6sFznYU2RZiap+v6i85AXy/FKDIGZXGtY
         9Wl11MoPeTccbF87ecu6YUoQzbhWN27sgy0pnR2jDxZSV9MUx4vIKEQK+7QaWvjuFwgm
         xRExP38vZiLn+Qlo+WBLVMPrdJ2CZ7d0NSfBLkuPcibOcidTevsmobgkxX6FCqgq0Alk
         /9tqyBcE6r8cFzEbLcId1nB67cWsLWdnkLBHvywqnoaCw2QqQxtCbCdm+WmxBuvrrhMc
         rvBJoASjdZJ27VDP+Db0pkREJWokNGoX+QJ8ACUF8lJuHPLKodZgrtvlJQRMCFgSXQlQ
         FCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007439; x=1760612239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjBqC5OmraL0dv+F2ewe7IKGLAdUyg9AVVWKAy3m9Vc=;
        b=IMUkb7qDYKMMRP1pQXvHs4c44AtMNtXsVEsgFC41DU2LaiwaNA3cVS3lpnPRmjXtKn
         YFlkql5HwZXIdL2qT5NUs18aiN3dJPrEo5OHc4Nba/1nYn5AQya1ByJfRIGJ50CubR4a
         mjH8ITeERsv6135zrROKefxo0wMwScpKRI+WVcxkJt4umpuiskhpEs7Gu8RvGabrfbtY
         Ec74J3MTqsZs1WArSExAVuNjKfCygT9Msvjt/UAJpb+s6+hD+DXA9afViJGLQlZoBo3r
         ijR/HWCQEeQGR3nVncEZnVIBSSZ1TEcFazgwrZNEs2HukzmDw48RqvsuPfSsprlKwPnU
         FNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU//i3QmQ1voJo7Pe/3o8kSjBuG44WOSP/JEVCcaBaF5dj7X7aV63WcfyjMT0bf3QmeCDzTUk07Zjy5iob0/xkg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gwcTEB8/LcLJiu1If/+EfL2wSld4RzUspQhuEcMEATq64rpE
	qlW4qqy/K7JofPrUJsa9ZO3pDYs9HlgPiyWgGycq9uRJAfA4jPEIh5Ax
X-Gm-Gg: ASbGncsVpurhfrKJmF8NfA/QdGMNwpPu9QNe9KGoVEGJkrWPOe7Lq9E9uZ8xpjlR2I6
	xVIUGTihxXWsXCCwmDFAEFhex++SgXzLDArsXEGHSmmxfFsXHCfiYM8sN0dX1MpBGcGsvITIlTx
	E+gA43R3oFRUrp8fhyx07Id5u3p8/2jCKLlUIhdXxq0hgHBWNN7nyOhRfqrwM/fKbeRu5iEKQzl
	VMl/hip3UX47sg8yIl6uq3I3av4biQTurPkVxjJII/0BLzv3zP+aScP/TrtntREs5wGQPDuWspt
	xPTWd+UJZlzP3k/2lIk6q8VVdZXMHdFQggl7QqaP+99vajl/51jsyaJKpBVH9MDkZETNn1WvwRA
	dip1GQ4nFkHmbp2ur4x0Oy5iujMlSmMt521/qMccYHmCEMDucsL5x6G+YB4EE
X-Google-Smtp-Source: AGHT+IEogDfWqn0ZNEJ5cmEpJkuR1sQjiPvyx+m6nnseZ691SX5q+dGPfB0lT/XnvNq5vU0yxLx4cw==
X-Received: by 2002:a17:90b:1e4b:b0:330:72fb:ac13 with SMTP id 98e67ed59e1d1-33b51125511mr8955062a91.5.1760007438929;
        Thu, 09 Oct 2025 03:57:18 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62dd50c879sm17747604a12.17.2025.10.09.03.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:18 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
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
Subject: [PATCH v7 03/23] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Thu,  9 Oct 2025 18:55:39 +0800
Message-ID: <20251009105650.168917-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add modify_wide_hw_breakpoint_local() arch-wide interface which allows
hwbp users to update watch address on-line. This is available if the
arch supports CONFIG_HAVE_REINSTALL_HW_BREAKPOINT.
Note that this allows to change the type only for compatible types,
because it does not release and reserve the hwbp slot based on type.
For instance, you can not change HW_BREAKPOINT_W to HW_BREAKPOINT_X.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig                  | 10 ++++++++++
 arch/x86/Kconfig              |  1 +
 include/linux/hw_breakpoint.h |  6 ++++++
 kernel/events/hw_breakpoint.c | 37 +++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ebe08b9186ad..bb4e4907c95c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -456,6 +456,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_REINSTALL_HW_BREAKPOINT
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them are able to update the breakpoint configuration
+	  without release and reserve the hardware breakpoint register.
+	  What configuration is able to update depends on hardware and
+	  software implementation.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d034a987c6e..ef5b31158271 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -245,6 +245,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..ea373f2587f8 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+extern int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+					   struct perf_event_attr *attr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				struct perf_event_attr *attr) { return -ENOSYS; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..5ee1522a99c9 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,43 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local CPU
+ * @bp: the hwbp perf event for this CPU
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of a HWBP; it just reuses the
+ * current slot on local CPU. So the users must update the other CPUs by
+ * themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type to incompatible type of the HWBP.
+ * Return err if attr is invalid or the CPU fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	int ret;
+
+	if (find_slot_idx(bp->attr.bp_type) != find_slot_idx(attr->bp_type))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
+	if (ret)
+		return ret;
+
+	return arch_reinstall_hw_breakpoint(bp);
+}
+#else
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_wide_hw_breakpoint_local);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *
-- 
2.43.0

