Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422B14E2E4;
	Fri, 21 Jun 2024 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955559; cv=none; b=erlqNHXxs9TtXNb+c76r1PVo1oH5GV3ZpMcoSXBa0g9vplJMetJXC4L9cjIXt0MD1Tmnvo63GeVrhlDceFJ/I2/V4osqn1VwB7ca+tel/jY8Wgk5kEPFx38ADuF5HhQjmHOM86Ti9pcYc1K9b+dh4V0tNooCX3KfAQm9l0HchTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955559; c=relaxed/simple;
	bh=F2cVgjrXCbwRCF4R9vYLdMvZMxEHN/Q7drWoe4lk+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN8UlFhidaJFgNB85JrVf8J00eUsnDnoH4WMlLqcJMQrEx3on1J2IN4ikhm2hJiOWpmGUxp5jk8gaIta2yknBzr4zjWvB6mbwCiTeEppkN2x/V+bOxpvISudoPbGMPpqIxafoYMUchFkQU9FbEB9jf0ZfuGCoDLpRgj9WSNSU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bxb+shLnVmnMsIAA--.35252S3;
	Fri, 21 Jun 2024 15:39:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMcfLnVmIjgrAA--.39322S4;
	Fri, 21 Jun 2024 15:39:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm: hw_breakpoint: Save privilege of access control via ptrace
Date: Fri, 21 Jun 2024 15:39:09 +0800
Message-ID: <20240621073910.8465-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240621073910.8465-1-yangtiezhu@loongson.cn>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPMcfLnVmIjgrAA--.39322S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWrKryxGw4rKw45ZrWUtrc_yoW8uryrp3
	sxCw1qqr4DCa10ga9xtrs5ZanxGwnFgry7Wa4DKw4Yyr1Yvr93GFykGr9I9393tr40q34S
	q39Yqr4aqw17WabCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

Currently, decode_ctrl_reg() saves the privilege of access control
which is not used anymore, arch_build_bp_info() checks whether bp
virtual address is in kernel space to construct hw->ctrl.privilege,
the process seems not reasonable.

The value of ctrl->privilege saved in decode_ctrl_reg() can be used
in arch_build_bp_info(), there is no need to check bp virtual address
to assign value for hw->ctrl.privilege, just make use of "bp_priv" in
the struct perf_event_attr to save the privilege of access control via
ptrace for hardware breakpoint.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/arm/kernel/hw_breakpoint.c | 4 +---
 arch/arm/kernel/ptrace.c        | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index a12efd0f43e8..7720d39473d9 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -568,9 +568,7 @@ static int arch_build_bp_info(struct perf_event *bp,
 	hw->address = attr->bp_addr;
 
 	/* Privilege */
-	hw->ctrl.privilege = ARM_BREAKPOINT_USER;
-	if (arch_check_bp_in_kernelspace(hw))
-		hw->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
+	hw->ctrl.privilege = attr->bp_priv;
 
 	/* Enabled? */
 	hw->ctrl.enabled = !attr->disabled;
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..0d6d6b2a57a0 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -422,6 +422,7 @@ static struct perf_event *ptrace_hbp_create(struct task_struct *tsk, int type)
 	attr.bp_addr	= 0;
 	attr.bp_len	= HW_BREAKPOINT_LEN_4;
 	attr.bp_type	= type;
+	attr.bp_priv	= ARM_BREAKPOINT_USER;
 	attr.disabled	= 1;
 
 	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
@@ -530,6 +531,7 @@ static int ptrace_sethbpregs(struct task_struct *tsk, long num,
 
 		attr.bp_len	= gen_len;
 		attr.bp_type	= gen_type;
+		attr.bp_priv	= ctrl.privilege;
 		attr.disabled	= !ctrl.enabled;
 	}
 
-- 
2.42.0

