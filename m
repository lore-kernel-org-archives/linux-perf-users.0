Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455D26FDB2;
	Wed, 10 Sep 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481878; cv=none; b=VDnplLo2KAiB1e4bURfEv3bGR5NQBTe2XSYxk7JpYuLJUNbklDfuw9GG/btMWF0tZoVVq8BP9T0Q50Q+8XKtzaXzZrkHQKyrTgsco66+eVTHMn5WOhPaOnx7vkHEofBf62zpCekQYOwxpDFRYysYwa4aimG91EAVNGtweByXc+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481878; c=relaxed/simple;
	bh=4PtaQ74SJJPVLMYDACBxzq/zXR+p3d86HHwkF6eNxxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9hpUtWprh1t8zpsRGd1ZC2DkaMmnnq81BohPTuKnFAR/SLcijI702qFIexjZLz+Lb+ylKmiGxJJ6PXdJq1uwijgMlhk3RLxcmIfWuoNmzJUCMDNxuYGOnwfikib62M/QeQmc5s4dR4IEnjRRCnrj4vtE+UqTDkaWtrxJRmWXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6Lku7bx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Lku7bx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b520c9c291dso4255255a12.1;
        Tue, 09 Sep 2025 22:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481876; x=1758086676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQYOiNSD0BVFYt8LJn6Fepybq7p8FLHlj9qtf7JwQoI=;
        b=l6Lku7bxJgP7RoJAzAgB+Bn1zk4C5f3s69aJOuLrJmZYbteEHOhF+JymIUvgjOp8M6
         UbTFhFB/1+6kog+aWPQusaP6eqAk48gDuDEvYM2a1pQysmxLPc3o2gRsvtABGFYXeXLx
         yp9QKUm2Mpyw0R4aTBieM8iiCxzeVL9RST6tlskutvKz2Uqd2JCbXgycskRsyXowMf9i
         ltrMIDkYsjxkQ/cEbhizyacF0ru5hIHUjessDbeUVME7DxPd8/kVxqMiBqx9GNnjiGeu
         TIVS+7LcOFJArFq2Ggxv+1HqINfIGigoKywaikmEVXF6MS3Ste81CTRUrbwOXAeLlnnG
         9NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481876; x=1758086676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQYOiNSD0BVFYt8LJn6Fepybq7p8FLHlj9qtf7JwQoI=;
        b=j1Mrlur50PhIrf1XuqwRzTF2dg87mpwnL9bM7KCucXWiBgsmE2LUyc/60/Aa/0Q2E5
         D1SpBiF1v45v7hfCvL1lL9Dw0maNKduzwC2A66E5aTyChwu29eeuak7R5hJlkBDJJq4c
         d+AWRwcX2Q2x2BqsQkGTHZplCfYsAqjBV5PnPxlCQZogm/FbyytHgSfC/k925WLBCvyR
         N6IJ3UbaRFsbNYzNV38Xivok7cew1SrCD+VDBLAzAHqlpb9/NicdWvnAixBQ71S/AFN4
         sVM50MVM92quuPINFSRQvCv1ZdeGqwHKIvUtACsynVFszBDMYt/TVaTXXLrjDim8YF0p
         wrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUjyn/Jk9h5R6BriBueytsOK3cafffQWJDVdB66SB8vVJzJ+PtV5R4Y4g9UTUZOIB9AL6mHVYD7G5aIwr0TuSr@vger.kernel.org, AJvYcCX4zMSmC57Xq4EouNy1XFT/F0gItMgpt/j1GwGj3j1qRhNhCGqtZ2zN6SvfQOk9N9evqEuGF8mecyqUNsYDSiuDcfmT@vger.kernel.org
X-Gm-Message-State: AOJu0YySIal2PM6UB2zI4X1kZCU09tQl9wGmbioFJ1JXQVxpMVGgShFN
	4CZXg6MBZuML1XJ3p0nqLxzdIKQ5HPUu9bYbl9fhFgyXslKHnVivH7I55H+OealAky8Skw==
X-Gm-Gg: ASbGncuD1Di7QUzFuqMG58kQdYiKW/fcJpNuN4homSDuyVPY7bIheMI8o1FVOj7Aiwq
	3D+WlRvDOtfo/D1Vp+elxe61rF9bXAXbd+heRvrTf5lDt5icet34KpMEXu9POzkHctJTeXLDM8K
	dsrBTa9XRfrA0KwVmPuHOU46ueel30TIqfOS2IzDK0LsI83V97cLhJ5arhiqEGWVA/bCi6wZRrZ
	3zqZ8/YmC4/GS5og5NaBP9eMTlcjb+jTKxsnEU+3llruwqUYyfTS7P811uGs+gxvU4wyu2fkAfa
	6cYOZrLxYnIKpj6UDunhkUbWARse6wZxxRO+uSGumMkyRnj2L8nyI/OyiXNisMDMYADcMI1m6/q
	YsFUXzBonW7dRqMg17mFy9i8jrx5vWHhIJg==
X-Google-Smtp-Source: AGHT+IGrE4fctqYtjowG9QSXjEAoPEpi/FvbZq/u2mOblf0m/w0KO47bW05N3FgRHvP8LO7tJLRT9g==
X-Received: by 2002:a17:902:d4ce:b0:24c:7bc6:7ad7 with SMTP id d9443c01a7336-2516ef53bb8mr204775165ad.3.1757481876261;
        Tue, 09 Sep 2025 22:24:36 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:24:35 -0700 (PDT)
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
Subject: [PATCH v3 01/19] x86/hw_breakpoint: introduce arch_reinstall_hw_breakpoint() for atomic context
Date: Wed, 10 Sep 2025 13:23:10 +0800
Message-ID: <20250910052335.1151048-2-wangjinchao600@gmail.com>
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

Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
parameters (address, length, type) without freeing and reallocating the
debug register slot.

This allows atomic updates in contexts where memory allocation is not
permitted, such as kprobe handlers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |  1 +
 arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..bb7c70ad22fe 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..89135229ed21 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+/*
+ * Reinstall a hardware breakpoint on the current CPU.
+ *
+ * This function is used to re-establish a perf counter hardware breakpoint.
+ * It finds the debug address register slot previously allocated for the
+ * breakpoint and re-enables it by writing the address to the debug register
+ * and setting the corresponding bits in the debug control register (DR7).
+ *
+ * It is expected that the breakpoint's event context lock is already held
+ * and interrupts are disabled, ensuring atomicity and safety from other
+ * event handlers.
+ */
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long *dr7;
+	int i;
+
+	lockdep_assert_irqs_disabled();
+
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
+		return -EINVAL;
+
+	set_debugreg(info->address, i);
+	__this_cpu_write(cpu_debugreg[i], info->address);
+
+	dr7 = this_cpu_ptr(&cpu_dr7);
+	*dr7 |= encode_dr7(i, info->len, info->type);
+
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	set_debugreg(*dr7, 7);
+	if (info->mask)
+		amd_set_dr_addr_mask(info->mask, i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *
-- 
2.43.0

