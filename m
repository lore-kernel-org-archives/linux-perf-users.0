Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402C12FF72;
	Tue,  9 Jul 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518913; cv=none; b=bfe4+WZ+MzXvsoelce/g0KFdIGaoaxFBPu7WHoUk5H88eK/rAdFrmSIaUAqZteJ2d5dpJJ/rZztp3VrR3xZ7jyzsTeLG4NarIa3UcBMs33SQD/Ftr3BpvSQamDa4KJF7j3CVNzXkEYoQ073mXDV3n05c0+V+EkEZqpT+6xIUkb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518913; c=relaxed/simple;
	bh=wp8lBSzF7UKAvYS4c5rsFNiAZ/uGj+OLNOgegi/v/Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZcVpeTIBYJii08CWEdZpJMx9ohYTat9XHxDS7jYqAwcuBOv/s2UUvWZ6uhscrX/bw71cKH/kObPQ8ZWzSkLNT/K2rQCwPdu6afiAai/Npbae1fJSj1S+4TPrcKNg/ZpIzTHxg2GIq1JDjov5y6j16LQf3fe96hEexO5C3YCNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axjuv9CI1mXWACAA--.6999S3;
	Tue, 09 Jul 2024 17:55:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqsb6CI1mgt1AAA--.17645S4;
	Tue, 09 Jul 2024 17:55:08 +0800 (CST)
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
Subject: [PATCH v3 2/3] arm: hw_breakpoint: Save privilege of access control via ptrace
Date: Tue,  9 Jul 2024 17:55:05 +0800
Message-ID: <20240709095506.9691-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240709095506.9691-1-yangtiezhu@loongson.cn>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxqsb6CI1mgt1AAA--.17645S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF18JryDGr4kur18ZrWrJFc_yoW8uF1Dp3
	sxCw1qqr4DCa10ga9xtrs5Za15C3sFgry2ga4DKw4Yyr1Yvr93GFykGr9I9393tr40q34S
	qwsYvr42qw47XabCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

In the current code, decode_ctrl_reg() saves the privilege of access
control passed by the ptrace user data, but it is not used anymore,
arch_build_bp_info() checks whether bp virtual address is in kernel
space to construct hw->ctrl.privilege, it seems not reasonable.

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

