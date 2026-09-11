Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAD3E556B
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129055; cv=none; b=H2fmHM0N7IY380igRwlljFB4w4ZtYRBW0cwIqtvHTC0sYie1Nha5ec5Y7Uzj2lYDeaOVI3WgnY4pfn4BoCOj5r7+PIFOvFRDNararDyAwS28RCDM2JLFBRl2x4w8xMWY4WQd2e+szv029NrCGU3K41Ha7EzywFyqmkXKwLNoOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129055; c=relaxed/simple;
	bh=l9cbhsR6oIcRYl+I2g1jCIa/WhsXA/dARjMt3kDigl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPDKXyhHg9YMCGyDqmHPu1q3Z9GmSC4rqpiOxO8GpYBscKmB1UtGYGpZsaJMrRbCMcu8rvk3xfsrxO5u78wUK7ngwQdF3HvrwEzLahoOb9tV2lhRpllGBKWczg+UZLd4U3edE0Ednt4YWNYTb2w0KZoIH5Ex+im7j1KEwFOgYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=deFHXfrN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="deFHXfrN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-869d181419bso772219b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789129053; x=1789733853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jS32Dx5IynGZ/Y/2aGGAGztAdcoBdPlUNApcd4RXZUY=;
        b=deFHXfrNDd+W0AEagd3IbUOzdPvHbE1WDSvVUiQFD83DsNQWYrhG7ADRgo4gkkyJEV
         /kVEqE8jcwOwXIfzQ9OhU3NfSZD/sv8D1WSwaSgVVRxh3c2lYXqFHduM78snx83f8Dyn
         3qC2H3g3hi9TPMjNn7QWaTA9HuzgfSzLKEUGH1GhLZdpNbsnd4I/bHEXPsWGEsrmOP/P
         2rO/2Xq4fi5GXtIgrIIofhTYL80Elm+sJQVs0VOTz+AWSLns2dhtbplMvjpsM7I2/sC3
         phL7pr4Hi0YNnovya96/FvlL1RvbdvdnBmLjweF6he0fnz/rAeDuk9C11DdbQzA7T1my
         9jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789129053; x=1789733853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jS32Dx5IynGZ/Y/2aGGAGztAdcoBdPlUNApcd4RXZUY=;
        b=k9qaZxP0Kqb3xAE14ALbFzb9H63U1/hQdXgQKZmGltvjR2ZpbBKPminaxLZcnay4ux
         zpgtJyIxGciYP/LEhAXgrxAcH763oZJLouZGLPp8TFIEf21CY6jtYnx/d/az1KaAl0rH
         JOs6XLW1NUASy3KWmiiL9NylqaIVz+igyERCUBkEGF0b9PfRVLhzbUomn44z7ifNCwp3
         vzWOA0eXHlFESzY3vfD41ONC7YYcbLqd6V78+BKmoErwc1lWeSaBQvWrjEs/BH4t4g5X
         EVvKVyeJJW/9vNQNKFShD6dm98mSRpNSIHwHMnK2cHJ1si05Hbs4X0NDyMk7+PVRBf3k
         6gIw==
X-Forwarded-Encrypted: i=1; AKwUvBzbOu4jlrniXwapQa7i53iYmnPSdYOmh+Ha+/zw8iOhme16fjVSVc9Pc3vjkRGfwIwh0+5+7BAee8QwfxvSXMDS@vger.kernel.org
X-Gm-Message-State: AFuF++nr1MlW7PYvG5bqOG4WvYAoIo/7j73dPJYXlNkU6XJtgzTG4ZTA
	x5w7HQmoijaTpqoIzfZlQUGKdb7ULpAFW98qrR/AOfXQFhixwch0GLlLPs84P08MIa0=
X-Gm-Gg: AYBFou0MpnvsJiYCh7Xq38WxrH5dqd+cexS94kGPOvJb03gtOFPjx5LG6E6av5MbgjH
	ZMDoQfkD9jbGYhSmjcLqld6ytH3GavF6BDt8xxUNVGHMdu1tGW4tTFZpmQr0HNzuetBuc8eXgFh
	hbDPJ+BtFWwJyqfemKnm91SJCUU6q5VBeWwS9vUrHf4Rle5bS6ToavsproDs8DCsC52V2dBh0Lg
	LpRhVv2PTKHRl8tEANHRJYfNEjS/RZL1F9Mt1ZA0AjcmVS1+FEE5WBlG4Lci7EwItuvGJAs3htu
	/1o/ED9N3vO3V52DqPxRfcqu/er/TKjjGV9hED77yucVkDluIZzKpRTqlsdDAi+rgrE9DC8oOTb
	xlVJMnMPuB/u+WHVegLkd890lQzPEzE1GlivC4XdGgEmdGfBHWq4xSwm7ufnVwa+K54DJO4llR5
	qbtUf4pCn7hQ4FjqBNEgnPgZE9HkUseM2aJgaDtM3NY8uFsAo4RR8MzpettJTyUXG2WM2bBkOfc
	t1yaGJ0tXVF2Li23JGoupxTgWBeGC/YviBrsieVDA==
X-Received: by 2002:a05:6a20:3ca8:b0:3da:bb98:b1f9 with SMTP id adf61e73a8af0-3daed4bba1dmr7680917637.9.1789129052892;
        Fri, 11 Sep 2026 05:17:32 -0700 (PDT)
Received: from FJ7FR2JRQ3 ([2409:8a28:f48:3091:908c:b537:572a:4db0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm3178278eec.8.2026.09.11.05.17.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 05:17:32 -0700 (PDT)
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
Subject: [PATCH v10 6/9] perf: RISC-V: support callchains with SSE delivery
Date: Fri, 11 Sep 2026 20:14:53 +0800
Message-ID: <20260911121456.33223-7-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
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

