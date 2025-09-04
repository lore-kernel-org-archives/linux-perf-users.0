Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4A1F463E;
	Thu,  4 Sep 2025 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945355; cv=none; b=gM/YH3OJwxI3/Ns5zq3+R9oWt/f5RL91HFSVJSiqhFOZG/cIK3g+m5tvG/Cq61h/BZ4DnixKcG+4+2kch0z0N8tmOqIjFwWz/ZKisj82ebxv8Sygm2Hyiy0tP/cuYgiOeayek6LdAhnDPaTeKVEhzllrPARl+Tdrkez/MNghuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945355; c=relaxed/simple;
	bh=4PtaQ74SJJPVLMYDACBxzq/zXR+p3d86HHwkF6eNxxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/wuLWUM9C/cjMf2013FSGBQHLfbsEEDKJrel/bw5ze+A5mkRWMyyYfLerp0cL/Xn5FXyAS1cxRv5xVhGlPdDbFDK6BotKuxLp6MLIv6h0CWRyTiCGYEc/fygkYaYcgy1ua2AcerkMt2x8vgIEReAxyBgrM+73EAPpErIjmZkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdC6EDhV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdC6EDhV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7723bf02181so393299b3a.1;
        Wed, 03 Sep 2025 17:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945353; x=1757550153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQYOiNSD0BVFYt8LJn6Fepybq7p8FLHlj9qtf7JwQoI=;
        b=CdC6EDhVaq8dKEnHrDsIaN5HLCEXFcNu+/mlDdxX+oSuuUQLvJtIJuQei/erOwbhK5
         2vJOR6wk72/0HDLjYp2+ePrLXhHMVfIkU7pU/2tmZcb+JwkBifxV7Em8v4i1CPARGQKG
         vi7cv+psHTEzFnVWMFp+5DFnhWEUiWCIuGvcsH3FmaLusoPtW6bnR980BmhhyUJH23Lh
         D6wSxM/3u+VMMa9bVAqfx9v0W1zLMcKawAIDVIfNFFeGQqqhdQAdXsO2KSBS/n4ROSiT
         fYTcQ8lyVRBRTmDJqLGzIwbo6s0hBKiuzXXdWRBBorLAGxeaMVMHTWm3FL6WGreAzfQl
         NksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945353; x=1757550153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQYOiNSD0BVFYt8LJn6Fepybq7p8FLHlj9qtf7JwQoI=;
        b=SuF4qzJsr7r+65fCWlRTu/ePnHL7kVnNW0XZ5k4Mm/S1isiolp+VcUXdwga8MYVuZo
         aCFmtUZHhwHf+nw8UyM3dtovAsA082sSTeVeqnfHBIj+uF30i9TYeGqcTtNCTuxqpJRn
         d2RstZ+/7KQV56EiT9HoSUpLAPbqSovfegYPt+PY6r/4tkzlOesxrv5R0/xUL1QoYclO
         HtbiD9pky3PPHK39FmXFkpif2hQMfDI9xptzWSphhlNOjg2Fu90V/Opsx2SaHBB62yxm
         ykqU6bEuQNEdPljV46OPLBeSiwIjStFJvIxOYbVbUFgoqhiCqDMkaE4oJ6dFJKnULzXo
         I/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV2W39VzQCfFOIWuwDgrsLlwh2tKXgT0rAfUfsowxoD5gZgKhNGWWGWIRLn5ema0jaC81epys7iJdrcjn/Jr+vv@vger.kernel.org, AJvYcCWyJSa45qTnOn0kVW1pRs+DKbLDDmNn20ywp9HkLAxlS5wSkkTC33d0wAWlnkpPDljsxfQO0psuvN/cKehLHO0gkun1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65vsrDidC4aoVV4dIXAgUcI2/oykDqXYKam65AHq9cTN389rf
	IHY8LtW64M9jM+4Va+GEL33JEIjp0blo9T8QKFsqVADhbK/x5A3WW6HS
X-Gm-Gg: ASbGncvd2sU7g7Y+RL/5LOEi2dqIqcbyDcCN2MiVg/kRkuRXy8p0KykbsT0PHUZnvlT
	AdL8CiyyEFAp0sFowkcdSbp7xWmRGYXm6HrFsvxRALYJUWj8kh9o8mpq3cVoJxchQVZb4z963J4
	4ydnHiQSo4S7RWqUnL8s9fVqhLKBu2HxtRuhUPjeiigkJbNMH2nOJWPE0IL7uNLErNPbrsezUhS
	69dhd6IDw4XVepJuEz9sonkM/etgFJqP1nTJWX368MMqzEoLKDpXpgvEuJa96qfWLxR5Zp7/cLy
	lzo/9a5qfZq+I+Ja5DFzNZivXJozugnLbUMow0aepJWEX7AyjJnyDqZs3nStzvsAUe4jA6//OBi
	NTlJisXawCgjmVkJ+zXOGqiRus0J3bWDRPSvaVyDJMalz6vYT8Cp41p4EX1U8FI4=
X-Google-Smtp-Source: AGHT+IFnjpaYI5g8ja51Lvpi7nBlJrRrUarHPHHsCIaBV04TNusHvcfyUMtMGsdyArLqGzZZyKE3fA==
X-Received: by 2002:a05:6a20:918a:b0:240:1132:6f0 with SMTP id adf61e73a8af0-243d6f3801dmr25287454637.43.1756945353145;
        Wed, 03 Sep 2025 17:22:33 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:32 -0700 (PDT)
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
Subject: [PATCH v2 05/18] x86/hw_breakpoint: introduce arch_reinstall_hw_breakpoint() for atomic context
Date: Thu,  4 Sep 2025 08:21:02 +0800
Message-ID: <20250904002126.1514566-6-wangjinchao600@gmail.com>
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

