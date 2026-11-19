Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090180;
	b=CnLWkxShpZwWa8vepYJi2r08CX7UZnvWvQ5QCDJHK4GC2cbmjzGou6EhwIeDe1J9Gz8h
	 ePxBUWcKFuqaCQregg60nGytcayTRsZVrduFcs9m9BiWgeWZfiblOas8yagPDcHIOVwH0
	 +/YX0U2wHV9ycMyr01EQjVqMtLygOud/P3IC1qkwSqrUIbi8RC218EBXyn5ZY5jRFapey
	 g51aILtBRcsz3jJcqP+XQwQl8j97fs3qz5YFsIKDLSLENzYADfQYbdmZaq1eSQ/QuGMHl
	 iS34PFWwhKdyUVytEpPJ9VsOcCI8TLOs1MMXmGD5680Mo5sM0COnW6BFokY0VxsqYlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IMQKgMzK5koXpzwpAGfuvI2X9uFekTM0Brh0o9wzQHI=;
	b=YSKDp7JY9JhaFQsMvfXWpd6a3T2aDOXYB2MfHM0AprM4jsvZ+0XZ2gTXVZLSViGrv28T
	 lU2Rs25EGmyHDYQp/2ODnRz78lrQXuflJIdTyNjzmD0pApFhyt9Cy1j9ijMhXYVkO6Wa5
	 4dhJmcoKaq7Rb1bzrGW2x1XSz0oHQ1jpTT8MDJmkNs2ybMW3wP8+08DmC5hj7Y3dn4wp8
	 YgRbP38UWAhEzXElpr4W/iNV49elQufo54yBEKXQ9iSpZLiDdEPh4iqkehpDaEnvJOv8b
	 ICv0K4E2xuwBjZiP0MzoTkJ2G3bCIF0FSQ4eGjfIOUGSmd4RZ2oWP0wF9nqcfRitoZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LM9bUZT8;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D2606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 256D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LM9bUZT8
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-382f4710a17so2923689eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795090179; x=1795694979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMQKgMzK5koXpzwpAGfuvI2X9uFekTM0Brh0o9wzQHI=;
        b=LM9bUZT8k3cGQJUUG7eD43z4pVutnUr27pPDXThESBxF7ZhMDdQUWhvcDgWnH9XxKH
         mchcPcBrOACFSfMTAax9uGAMl/WAwjASV3Ow81p+FYSCxq5MHkXXSTlHHj7GmlZnx1VD
         dtFMe9dqMhyJrWIOXEpz1ERAEf+nSyUbpXUlm0Me8lUKBbDn+pfiGZUhP3r/z1v4qmsX
         wAVTe3e9+H36PDiUul3i2jiL6l9l9g1HcOenQ3o0BwbPmyLLJOLJRuQMFaLgg1fIek+i
         xZZ56Jr2OEosC+Jpuz3NjANLOlP+wJ86nQAgEwllXqamti7QjNw7EJN3HDUb9/EHpvlt
         yfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090179; x=1795694979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMQKgMzK5koXpzwpAGfuvI2X9uFekTM0Brh0o9wzQHI=;
        b=HKanvNzQC6YcYYrNqMpyhyfWso2JUUyS/i2JJCpzacQm5gcESS0e22b0wanpbwQcHa
         DRlMPSJn/zmBfDCeJnMRWdOdLmiW271O6WLkwRo1EydQxcJEiPx5ONvm+cVRKef9Apf7
         Z+U2011YWTHluRB1Fxvua+rnv038xyiG/fuUjAZpBpkT4y+rgKKZqlZeYjmSvI5ZJKe9
         3iTPGQaP7xVL3IxcRNOB2Iisn2ywtd376A5pu0lFyX0b7nL/SizMdDUvHUBmD9AqWSnQ
         1ezgkycTdioMXwPo7IkzDkj62u8tw2D5b0RVtKbc2p7U71uCE1m0Y24Q5krbebRz5UZn
         SiIA==
X-Forwarded-Encrypted: i=1; AL+hErHup0cMDltPToailH1a0JX5zdCfpjwzYj4iWVDx/3X424gPgQioJ+/qSADFd+T/q/7aRrJVguaUlW8XmaVhgIIw@vger.kernel.org
X-Gm-Message-State: APuU4Z8pxm/lFJpGjdbvg1MwFeYKnvJEzoIZq6/7n/oEyC1CDR6eZVNA
	PzEjEy7sxjS95rQ2MEjRHGxyRbMaTt7T2lQgiQ/kxp1ZBbevrlVBTem9ayuuX20PLxE=
X-Gm-Gg: AZFdTZf3kWtlCNmowovEkmLN0tiSekP5+vQVRu2/F9PMUdoda/9hDP+0EUO1/iJN0iR
	fjdtGS40Z323icaeoWY7rCeOa/O03MytfRwx1ayVEdRXLfmlC4Dan6qc6nU6AZM5P2Sjr2tI9Hd
	tR8A3c8fxpWh9DR7fAfYqKevJaEzS3iMtTtQBS6EyknskQ3T3huF1bzyVNFfAO+F+w5HrAWi9Z6
	JuM6I3BtqqU0nseahM8tTS539aFZOK55XqKc0rh4p6TN9Pk7QzaEmaiWBiEik5sPzXkhFbk5Jkg
	6ea6KNXWIKeSgxybqnQ0dS7JkNJu4DVNztYlSHcOD3OO1yePgAamsaKDdYCU2r4MmDQ1pbBFW28
	CY3RfpmrcYXyOJD6bJrL/1il9TUY9wcK4Niu0sd2si6lFMGJFUpcQofX0KSz2HNcCn0rAZkgaVR
	GdS7bOc4yTjKd6n/5HKNBcep9ZcS4ni6lqn+7xysKqNKHzJ41Zyos2mg2OoueM7Ya5ldHJhz1c2
	+z72CNy5zhnLyaCzbu5mCs2jGZE82B5jxwfir4pPsyowUi0wokFKWXSffqcmD2NhQfka0Zio4+b
	hLkPLpuPxJfDRkbgXOfFgThtd9tbu8WV9LCg9UdqdTcmLSPihzyuZKHAEwUC3mN0hQvf6I3/WJe
	6R6NnRmo=
X-Received: by 2002:a05:7300:b594:b0:381:5fe2:8008 with SMTP id 5a478bee46e88-38281eebbb1mr6614536eec.39.1795090179031;
        Thu, 19 Nov 2026 04:09:39 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17604650eec.26.2026.11.19.04.09.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 04:09:38 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	himanshu.chauhan@oss.qualcomm.com,
	conor@kernel.org,
	anup.patel@oss.qualcomm.com
Cc: clement.leger@linux.dev,
	cuiyunhui@bytedance.com,
	atish.patra@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	will@kernel.org,
	tglx@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	shuah@kernel.org,
	yuanzhu@bytedance.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangzhanpeng.jasper@bytedance.com
Subject: [PATCH v13 05/11] riscv: mm: avoid enabling interrupts for nofault page faults
Date: Thu, 19 Nov 2026 20:08:29 +0800
Message-ID: <20261119120824.13969-18-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V enables interrupts in handle_page_fault() before checking whether
the fault occurred with fault handling disabled. A nofault access from an
atomic context can therefore run tracepoints and open an interrupt window
before reaching the exception-table fixup.

Handle an exception-table entry before entering the generic fault path when
fault handling is disabled. Also keep interrupts disabled until such a
fault has been resolved.

On 32-bit RISC-V the vmalloc mapping must still be synchronised into the
current page table before that fixup runs: otherwise a nofault access to a
not-yet-synced vmalloc address would take the exception-table fixup and
fail spuriously instead of being resolved. Order the vmalloc
synchronisation ahead of the nofault fixup. That synchronisation only
copies an already-established kernel mapping, takes no locks and waits for
no I/O, so it is safe in the nofault path; if the mapping does not exist it
falls through to the existing no_context() error handling. This early
return skips the page-fault tracepoints, as before.

This makes RISC-V consistent with the expectation that an in-atomic
nofault access does not enter the normal fault-handling path. It also
removes one source of re-entry when perf sampling is delivered through an
SBI Supervisor Software Event (SSE).

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/mm/fault.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..3934248f7a27 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -294,19 +294,23 @@ void handle_page_fault(struct pt_regs *regs)
 	if (kprobe_page_fault(regs, cause))
 		return;
 
-	if (user_mode(regs))
-		trace_page_fault_user(addr, regs, cause);
-	else
-		trace_page_fault_kernel(addr, regs, cause);
-
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
 	 *
+	 * This only synchronises an already-established kernel vmalloc mapping
+	 * into the current page table; it neither allocates memory nor waits for
+	 * I/O, so it is safe in the nofault path. It must run before the
+	 * exception-table fixup below: otherwise a nofault access to a
+	 * not-yet-synced vmalloc address would take the fixup and fail
+	 * spuriously instead of being resolved. If the mapping does not exist,
+	 * vmalloc_fault() falls through to no_context() error handling.
+	 *
 	 * NOTE! We MUST NOT take any locks for this case. We may
 	 * be in an interrupt or a critical region, and should
 	 * only copy the information from the master page table,
-	 * nothing more.
+	 * nothing more. This path returns early and therefore skips the
+	 * trace_page_fault_*() tracepoints below.
 	 */
 	if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
 	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
@@ -314,8 +318,20 @@ void handle_page_fault(struct pt_regs *regs)
 		return;
 	}
 
-	/* Enable interrupts if they were enabled in the parent context. */
-	if (!regs_irqs_disabled(regs))
+	/*
+	 * Nofault accesses must be resolved through the exception table before
+	 * entering the generic fault path or enabling interrupts.
+	 */
+	if (unlikely(faulthandler_disabled()) && fixup_exception(regs))
+		return;
+
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, cause);
+	else
+		trace_page_fault_kernel(addr, regs, cause);
+
+	/* Do not open an interrupt window before a nofault fixup completes. */
+	if (!regs_irqs_disabled(regs) && !faulthandler_disabled())
 		local_irq_enable();
 
 	/*
-- 
2.50.1 (Apple Git-155)

