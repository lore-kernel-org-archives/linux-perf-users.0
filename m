Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658026E158;
	Wed, 10 Sep 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481890; cv=none; b=in5fA7yhPhIhdnNTPr7LQ7AAX5nSU580wlgTBxukZ76waKrHsdo3NO4mMUJx5z4gPuYNssAwVm5hf1eWy3+GuR3hIpgrzVGGmEg1NsSREn3jVt+ON446Ti6fgUL38mQ4/ZeDdoMB4CzahD5Oy3Ec+wsYzczuI8fFVB2Y98D6Ep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481890; c=relaxed/simple;
	bh=sULEjvL2pp1aXQje+Pg+BRBhTFd7HU/YOc2Kd4lZUiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWIKwua3yIuhKzEDRgq3DIjFaHT8tA7cRp86Vw8QK5CPofviKlM7ZI+WV8FMs20F5wpsD7QaY/ghcOsAVN+fkq2FGThtNpLVxJMX7F5ryRljYEP4QGgXJo/oRpqWzsUG/blnUSwPszSKQwASJgKYCK6yvuRm2g1e183uEwT1Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWXU+8m/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWXU+8m/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458272c00so72946845ad.3;
        Tue, 09 Sep 2025 22:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481888; x=1758086688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwazreHf5k9GgDRW54pld4eDw+UAZx9M09yt/sAPVs=;
        b=YWXU+8m/qrX1BGHOt+Ja3sDxcpkv+5t7LKREVbzcc2mZ37gKTGZeHY/wiyFtOyorz2
         sa+oZsKX+LpGzo5BUUEltq/CsJTLgfYwnGodBedqyw3cyeoHswPJV9yYCWhIxblrpIQ8
         11taO3RwzKkcdcT/L1+RbgiA4WzUMThVVeZRUwe5BkRC5dmPu/q2GVQgZyEY5fsqkGUW
         hedKBk2v6xgVQbOBcinYS2UFhjMl/+p41FHWKPozr9UEc3Khy5czFRJ40S0gos54aJc8
         WNddVo7MB4ZiAsjxVl50ebd2zsUi3CKeTcPOwEgItv0TcOzTLKfSOiyee0f3/sjBwYt6
         Qxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481888; x=1758086688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAwazreHf5k9GgDRW54pld4eDw+UAZx9M09yt/sAPVs=;
        b=jSgMvWXF4j5Z7eZIzXClC6u+vAdmAyPQlve5EmyLNc6zQYqINFD+tBUOGMeigMwVvq
         mOQD0fU7gEopz/zCKiU9Ux4aWbe6sBI6WfDEOjmJ2wi26G4eOQQwtLvV34T5B6D/JBL2
         GnnTKiMSys/yqDgRDzcAjU/PHuhsyF/9U+M2sxI6sANn0sFJZQW2dp8+k0c9CyCoh/4F
         VxouH7JM70JOikgvBShcZERY1+liRBUkV24CYnwU89PebcFu4bKuoAXp53c0zqTzMmoe
         NeQnXNFTc5wMSzpm29fvrUEwuu7D00h8g9FQHD8RXSK43OLvhpYy6j8744jGLSbHm5aL
         ueGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIJFbSrLp7AVxg9ELe6aqnKO/gSgtqlH0iGg1QeoM+jG22F91PMJujsmiDdqyuLYWpcz0NaS3WdSLLUink5HLL@vger.kernel.org, AJvYcCXQ0Khb8NYvqglgNuE41taEGflNq8om7yfyEVB9ZqRV0qHYNTchFfMvG3k6xlimNMW/HdKfvzpYS3cvu/Zrrqm2BfiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YytIEfBI2F6IQOrvRMfq4vtD0FZ0kEbNB8SeBrH+mZ4B8/ZcsGC
	3Sm892LqOITEya8HlTduwUiQ1iu0GhzH62oqY9LklSE+VZ2G7Dnm/AY1
X-Gm-Gg: ASbGncsoCgwNcSceHm4FsYcs6m93b/hsO6IquvFMcDWN9MCKaUt50jOguQUsjE+bTu5
	83gUb1x5Zkrr82JGhsSaqsokuj+umIMkngQ0X+v8EVA8m77xPH0YNPX7JnUdEq1yI1hZaZeT79g
	k4T9C6AOVuseOEdb1oPTaGpwpzQ5bvFuMa5Q3UAZcNewac0BA/oZ9KWmLMCVOu18XEbKb7UigT2
	Z2LmKiFruO271HIPLlD1xsS95L3+4frUNHAtEB4NoH3qEeUnZSzjJ6faQ7zalHGAbVwKKrUuToV
	/owh0Vws7zEqqDocDWoaHu6ZN7KKalfZR6j73kkjvBLuNrNh3NlDJ/RDMrMbd3TM9a++kgagqWz
	L1iU+OJpTLfMMiUIEyKt+wiRzBffExwSXVSV0aJxB2G0A
X-Google-Smtp-Source: AGHT+IH+8Eyb1p9jTA8Z2QSFM1sEbASQ6w81XDWRRY3hnf0Bb9U4vLiZfBxZK+5ARI3U6Wfe8Q2VlA==
X-Received: by 2002:a17:902:ef0c:b0:24a:f79e:e5eb with SMTP id d9443c01a7336-25173118f06mr198312495ad.49.1757481888337;
        Tue, 09 Sep 2025 22:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:24:47 -0700 (PDT)
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
Subject: [PATCH v3 02/19] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Wed, 10 Sep 2025 13:23:11 +0800
Message-ID: <20250910052335.1151048-3-wangjinchao600@gmail.com>
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
 kernel/events/hw_breakpoint.c | 36 +++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..e4787fc814df 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
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
index 58d890fe2100..49d4ce2af94c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
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
index 8ec2cb688903..ef9bab968b2c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,42 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
+ * @bp: the hwbp perf event for this cpu
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of HWBP, just reuse the current
+ * slot on local CPU. So the users must update the other CPUs by themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type to incompatible type of the HWBP.
+ * Return err if attr is invalid or the cpu fails to update debug register
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

