Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF918E1D;
	Tue, 18 Jun 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694621; cv=none; b=pslt61hzJdc4qO8xddqpjOCjUu4Q1aFCXM51eOLtXS97Vxj6GQzUkXvXu7OoG9ddicP1DZpWcrXl/YQ7X9TyioNPwP4GrNU2FPmjJRKa8hcI9bEQureTzT2LrMno+JdlMCrAIr6SKg9DVLeUiuLiEcjQrf3aMHz6zX19Z3acMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694621; c=relaxed/simple;
	bh=lmTv/KAeEkjTzx8D0XnC+oN9HgVt5RqE2kA2Aj0kdao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4ivR8TnWDXtxC06yh4lKXq4y4hgjjci2hQxUl/kYwWxVLZDC3eARlcBdRyxfHlkVLB7KIHbWeRZF7PZmrZ7LS8r0yyyDpktrQsgjkDDrn8iXLpCMaKSWRyt4yUIP0aqV+I4QuCdKZFVJxpY5gyaZHLFgNcNtuh6716r3i4vG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax3erWMnFmfNQHAA--.31460S3;
	Tue, 18 Jun 2024 15:10:14 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxosTSMnFmXgcnAA--.17923S2;
	Tue, 18 Jun 2024 15:10:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hw_breakpoint: Save privilege of access control via ptrace
Date: Tue, 18 Jun 2024 15:10:10 +0800
Message-ID: <20240618071010.11214-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxosTSMnFmXgcnAA--.17923S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1kWFy8XFWkWw4xJw4DZFc_yoW5Zry3pr
	ZxCrn5tw4UGayjgasxtws5Z3y5JwsrWrZxWa4q9w4Fkr13Z393WF97Wr9Iv390grW8ZayF
	qw4qgr4rK3WUXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==

Currently, decode_ctrl_reg() saves the privilege of access control
which is not used anymore, arch_build_bp_info() checks whether bp
virtual address is in kernel space to construct hw->ctrl.privilege,
the process seems not reasonable.

Add a member "bp_priv" in struct perf_event_attr to make a bridge
between ptrace and hardware breakpoint, it can save the privilege
of access control via ptrace for hardware breakpoint.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

This patch is based on 6.10-rc4, cross compile tested only.
This is a try and preparation for later patch on LoongArch.

 arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
 arch/arm64/kernel/ptrace.c        |  2 ++
 include/uapi/linux/perf_event.h   |  1 +
 kernel/events/hw_breakpoint.c     |  1 +
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 722ac45f9f7b..06e34bcdcf92 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -486,15 +486,8 @@ static int arch_build_bp_info(struct perf_event *bp,
 	/* Address */
 	hw->address = attr->bp_addr;
 
-	/*
-	 * Privilege
-	 * Note that we disallow combined EL0/EL1 breakpoints because
-	 * that would complicate the stepping code.
-	 */
-	if (arch_check_bp_in_kernelspace(hw))
-		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
-	else
-		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
+	/* Privilege */
+	hw->ctrl.privilege = attr->bp_priv;
 
 	/* Enabled? */
 	hw->ctrl.enabled = !attr->disabled;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 0d022599eb61..3b37c4a2e0d4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -309,6 +309,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
 	attr.bp_addr	= 0;
 	attr.bp_len	= HW_BREAKPOINT_LEN_4;
 	attr.bp_type	= type;
+	attr.bp_priv	= AARCH64_BREAKPOINT_EL0;
 	attr.disabled	= 1;
 
 	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
@@ -352,6 +353,7 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 	attr->bp_len	= len;
 	attr->bp_type	= type;
 	attr->bp_addr	+= offset;
+	attr->bp_priv	= ctrl.privilege;
 
 	return 0;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..88dcaba421cc 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -467,6 +467,7 @@ struct perf_event_attr {
 		__u32		wakeup_watermark; /* bytes before wakeup   */
 	};
 
+	__u8			bp_priv;
 	__u32			bp_type;
 	union {
 		__u64		bp_addr;
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6c2cb4e4f48d..3ad16b226e4f 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -754,6 +754,7 @@ static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
 	to->bp_addr = from->bp_addr;
 	to->bp_type = from->bp_type;
 	to->bp_len  = from->bp_len;
+	to->bp_priv = from->bp_priv;
 	to->disabled = from->disabled;
 }
 
-- 
2.42.0

