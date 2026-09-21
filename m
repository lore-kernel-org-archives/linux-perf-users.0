Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B103488D8F
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989482; cv=none; b=pkKB8XT1wjxUBOa1HcERvnGPSrG52EslpdTsLO1xOxISXB8ZtDS8cTxToFNt1RlPNIuWYhz1Cj+3eCB/3dM7DnfjznfdvKaHmlvQiuBQdNZckW1VpcreFWsJ9GLOCn/DNFmX/1ptqXR64a2D2p2evIka2i1YuYbxLeTMl2Gh1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989482; c=relaxed/simple;
	bh=l9cbhsR6oIcRYl+I2g1jCIa/WhsXA/dARjMt3kDigl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5wHJJOrk7UvEFhHDyiWklWYOC6SpnnDmbf9T7gu5vCcpF+vS1WZdmcAn6WwOBtulqNix6AZJwLj7u3E4NS5STU/K/tpywYQizwxE6Iar48FfPMRCL7W88owyA+GtNxPvkno3CNs4BEzivT38XlWj3V+JMvhprpjOj0wXuN96ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jenZNvHq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jenZNvHq"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so28144505ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789989480; x=1790594280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jS32Dx5IynGZ/Y/2aGGAGztAdcoBdPlUNApcd4RXZUY=;
        b=jenZNvHqVOq7BaieRqOS48emO4JyrhHQYVA7mvNKIVsRb9xdgaFAuGWgOJ0jtPM/fz
         CDWx2AzGibPiBkf061LwHxisZe3a5er5mhYD5O/SkFdRSrTQqb+AlSC1MeXgsrudt8tZ
         l6WDHrPlKNKPQs2rOrrbq26ULBR5NrniVkaLoyCqASd3DcQlJnmQzTJUtK1irRf9uykt
         yFJhseZWPbkOgJEc9Wk+LIi18irvlwcoDUgo+bYys+cXGDemJseATnaJzPjN5slYCA4b
         zG6l/cBs/OoyR3mN0q3LhlPWvP8uN29mfufGnxdQQYjEM3qnt1eaKONzCK26SMzNZ6IR
         xHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989480; x=1790594280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jS32Dx5IynGZ/Y/2aGGAGztAdcoBdPlUNApcd4RXZUY=;
        b=XLFsyVwalVDG/RvW5gU3VUmD7MzC/X/2eOdyLfgsuYM9rW6RJ4nnZHN63GEDgaS+XQ
         h078K8WM5LkHu5MXBc/r/BBHn/A9nSpG4faN3UvCWWvm0w4b1TSR9ejud/pc1TDhyDkS
         GUOWYqp4gMvaVWVVq0AHE3geeKjk/y0bR+wRL6boyUjWM84bdtmXluU5LNNgfHQYdloU
         rJHxC4++rICWxAd1AQf/r7OlIKQIAM1GoWonau4Bq2uMeSp5xUP4Fh587o+KIsr+N9R9
         NiztAi6zudPOiHffJa7s6zN9oTh/EOIdp9t1Ur5JIS35mUD4eVs0qGxXFiJ8FUGrobYn
         c6NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyyoIy/pR+BNVQgXBcxM8KuRImAHvKD0awVujOJVnHkz9eyhF5mwS1y5Nn8MMYJYXIR94Q6iy43PIntsOv5EKg@vger.kernel.org
X-Gm-Message-State: AFuF++l+SVZ+iNkMToKph+gIZkNWuATHJAA/6NKtj7+aR6HXkAPmJDLR
	8ZoZi09GNfYezVj0ORsYReLr4tqT6PBrZKGuEjs6cpeZZ7Rnt+ZiAwkPPqFyh7y0T98=
X-Gm-Gg: AYBFou0BbPZlGVOOTqA7mxF3DVYpOVLi0G0Po8UYSj9MuGEryYI9TIV3SiAirVYoSYq
	IR+GxiFdsYd7R/PhBfMj/9EaggLxFwr5HJay2rGDsPb8yYnL+a6IHdGPt157FxqqrpC/q9ty3GH
	UtigjYCMs+u3oCtOqE9kxA1+D9AB6remZkCmkIhv0ZqK8Mb6P/B0hxZ6GUJAJRSOTwa11xn9+Zc
	PuKY6wq8MiOlw6EQTM2rMDudFvDTqJEO0bbOzOqEgxxIOeK/6woM2BOQhVB76kePlAFiWcw4ZfA
	aCFxh+WTvcxcRgKtt4KJnu99IijCYuZMFu4UZf7Dj1b4XaWp+8ul0MO3iKsEo4cSHKlJrEnRdzk
	EChGPkzo0nkuRKOnRXYXJYIqecBs7fCwsZDXIMQZ66NzorTIXEmAW0KAtII71LFcgCBGKVPxKxK
	qLeIy9NcXqR8j1wYaKkXtCMbu1z5eHuLdhlvP5jjXIuhdP2PRLTkIz0KjwpFUkX+Y9MT1Fif37G
	UO+cHP0+G1VRgBFT1aoInNA6vNwB+RxTKs=
X-Received: by 2002:a17:903:1112:b0:2dd:c053:c20a with SMTP id d9443c01a7336-2ddc053c2a1mr103690755ad.38.1789989479599;
        Mon, 21 Sep 2026 04:17:59 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([240e:694:e20:401::8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba651sm31831125ad.53.2026.09.21.04.17.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 04:17:59 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup@brainfault.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuanzhu <yuanzhu@bytedance.com>,
	Yicong Yang <yang.yicong@picoheart.com>,
	Susheng Yang <yang.susheng@zte.com.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v10 RESEND 6/9] perf: RISC-V: support callchains with SSE delivery
Date: Mon, 21 Sep 2026 19:15:03 +0800
Message-ID: <270f3bcd3a9933c8be59492ae4d7c6ff2414d7d7.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMU overflow delivery through SSE enters Linux with a synthetic supervisor
context on a dedicated event stack. The perf unwinder must use the context
interrupted by the overflow rather than treating the SSE handler frame as
the sampled frame.

Use the interrupted pt_regs published by the RISC-V SSE entry path. Walk a
kernel callchain only when the interrupted PC, SP, and frame pointer are
consistent with the current task stack. For sensitive entry windows and
IRQ stacks whose bounds cannot be proven, retain the interrupted PC without
following an unsafe frame chain.

User callchains continue through the existing nofault RISC-V user unwinder.
If hstatus.SPV says the interrupted context was a guest, do not interpret
the guest stack through the host address space.

DWARF callchains additionally copy a raw user stack. The generic
arch_perf_out_copy_user() implementation can take an exception-table
handled fault when a source page is not resident. Repeated nested faults
from the SSE handler can corrupt the interrupted kernel context under load.

Provide an SSE-specific RISC-V copy path. Verify that the active page table
belongs to current, use fast-only GUP to acquire each resident source page
without falling back to a faulting slow path, and copy through the kernel
mapping while holding the page reference. Stop at the first unavailable
page and preserve perf's existing truncated-user-stack semantics. Keep the
generic in-atomic user copy unchanged outside an SSE handler.

Susheng Yang reported this failure with perf callchain workloads.

Reported-by: Susheng Yang <yang.susheng@zte.com.cn>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/perf_event.h |  10 ++
 arch/riscv/kernel/perf_callchain.c  | 142 ++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index bcc928fd3785..ddc404794751 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -18,6 +18,16 @@
 	(regs)->sp = current_stack_pointer; \
 	(regs)->status = SR_PP; \
 }
+
+#ifdef CONFIG_RISCV_SBI_SSE
+/*
+ * Raw user-stack sampling can run in the NMI-like SSE context. Route it
+ * through an implementation that does not fault on a non-resident page.
+ */
+unsigned long riscv_perf_out_copy_user(void *dst, const void *src,
+				       unsigned long n);
+#define arch_perf_out_copy_user riscv_perf_out_copy_user
+#endif
 #endif
 
 #endif /* _ASM_RISCV_PERF_EVENT_H */
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index b465bc9eb870..ec75689c7aec 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -1,9 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
 
+#include <linux/kallsyms.h>
+#include <linux/mm.h>
 #include <linux/perf_event.h>
+#include <linux/sched/task_stack.h>
+#include <linux/thread_info.h>
 #include <linux/uaccess.h>
 
+#include <asm/csr.h>
+#include <asm/sse.h>
 #include <asm/stacktrace.h>
 
 static bool fill_callchain(void *entry, unsigned long pc)
@@ -11,6 +17,128 @@ static bool fill_callchain(void *entry, unsigned long pc)
 	return perf_callchain_store(entry, pc) == 0;
 }
 
+#ifdef CONFIG_RISCV_SBI_SSE
+static bool sse_addr_on_task_stack(unsigned long addr, unsigned long size)
+{
+	unsigned long end = addr + size;
+	unsigned long stack;
+
+	if (end < addr)
+		return false;
+
+	stack = (unsigned long)task_stack_page(current);
+	if (addr >= stack && end <= stack + THREAD_SIZE)
+		return true;
+
+	return false;
+}
+
+static bool sse_kernel_regs_safe(struct pt_regs *regs)
+{
+	unsigned long fp = frame_pointer(regs);
+	unsigned long pc = instruction_pointer(regs);
+	unsigned long sp = user_stack_pointer(regs);
+
+	if (!__kernel_text_address(pc))
+		return false;
+	if (!sse_addr_on_task_stack(sp, sizeof(unsigned long)))
+		return false;
+	if (fp < sizeof(struct stackframe))
+		return false;
+
+	return sse_addr_on_task_stack(fp - sizeof(struct stackframe),
+				      sizeof(struct stackframe));
+}
+
+static bool sse_callchain_is_guest(const struct riscv_sse_interrupted_context *context)
+{
+	return context && (context->hstatus & HSTATUS_SPV);
+}
+
+static bool sse_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+				 struct pt_regs *regs)
+{
+	const struct riscv_sse_interrupted_context *context;
+	unsigned long pc;
+
+	context = riscv_sse_get_interrupted_context();
+	if (!context || context->regs != regs)
+		return false;
+
+	/* A guest stack cannot be walked using the host kernel address space. */
+	if (sse_callchain_is_guest(context))
+		return true;
+
+	if (user_mode(regs))
+		return true;
+
+	if (sse_kernel_regs_safe(regs)) {
+		walk_stackframe(NULL, regs, fill_callchain, entry);
+		return true;
+	}
+
+	/*
+	 * Keep the sample useful for sensitive entry paths and IRQ stacks. The
+	 * generic walker does not take explicit IRQ stack bounds, and its
+	 * THREAD_SIZE alignment assumption fails for non-vmapped IRQ stacks.
+	 * Conservatively avoid walking IRQ stacks in every configuration.
+	 */
+	pc = instruction_pointer(regs);
+	if (__kernel_text_address(pc))
+		perf_callchain_store(entry, pc);
+
+	return true;
+}
+
+unsigned long riscv_perf_out_copy_user(void *dst, const void *src,
+				       unsigned long n)
+{
+	unsigned long addr = (unsigned long)src;
+	unsigned long copied = 0;
+
+	/* Keep the generic fast path unchanged outside an SSE handler. */
+	if (!riscv_sse_get_interrupted_context()) {
+		unsigned long ret;
+
+		pagefault_disable();
+		ret = __copy_from_user_inatomic(dst, src, n);
+		pagefault_enable();
+		return ret;
+	}
+
+	if (!access_ok(src, n))
+		return n;
+
+	/* Do not sample user memory through an unrelated active page table. */
+	if (!current->mm ||
+	    (csr_read(CSR_SATP) & SATP_PPN) != virt_to_pfn(current->mm->pgd))
+		return n;
+
+	while (copied < n) {
+		unsigned long offset = offset_in_page(addr);
+		unsigned long chunk = min(n - copied, PAGE_SIZE - offset);
+		struct page *page;
+
+		/*
+		 * Fast-only GUP cannot fault. This follows perf_virt_to_phys():
+		 * local interrupts remain disabled throughout SSE processing, so a
+		 * concurrent unmap cannot complete its TLB teardown before this
+		 * temporary reference is put.
+		 */
+		if (!get_user_page_fast_only(addr, 0, &page))
+			break;
+
+		memcpy((char *)dst + copied,
+		       (char *)page_address(page) + offset, chunk);
+		put_page(page);
+		addr += chunk;
+		copied += chunk;
+	}
+
+	return n - copied;
+}
+#endif
+
 /*
  * This will be called when the target is in user mode
  * This function will only be called when we use
@@ -28,6 +156,15 @@ static bool fill_callchain(void *entry, unsigned long pc)
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
+#ifdef CONFIG_RISCV_SBI_SSE
+	const struct riscv_sse_interrupted_context *context;
+
+	context = riscv_sse_get_interrupted_context();
+	/* A guest stack cannot be walked using the host address space. */
+	if (sse_callchain_is_guest(context))
+		return;
+#endif
+
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
 		return;
@@ -39,6 +176,11 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
+#ifdef CONFIG_RISCV_SBI_SSE
+	if (sse_callchain_kernel(entry, regs))
+		return;
+#endif
+
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
 		return;
-- 
2.50.1 (Apple Git-155)

