Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76492168C0C;
	Fri, 21 Jun 2024 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955559; cv=none; b=c+d3nndwyqK8J2Vmz0UP4BVI1bepglAUzoa/R5LJu5O0wpeYSqV7YRV3lj7p4WDtiKvkYQ3+yCUdTcwM7fsk940QprmugU7q1hT2WQm5Angt/ZAWwcEqOXt4+n+Wet5AvC2+IswtNfXTIgEmiIQpckxC8cDKD040MguvqA1Lnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955559; c=relaxed/simple;
	bh=AgbCloEhLB70th5tEMMLLCOiv5cdF6/6Y7e053I2kt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQJU/cH/z7BqNhzQA9VKh9eHXTeKaqYPNgsXt5IyhrfJe3+nWpoWc9QtvnmvIbrgqOmm4KWF6ZQooqGDPj82oFydDpjRfxHtNif01BbTgVlgWSgB9uDaGpihtLw+x+bcdXeXFH0mcOVKehbOG6xiP5I0pE2mGKFLMS8efPDoNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx7eoiLnVmo8sIAA--.35912S3;
	Fri, 21 Jun 2024 15:39:14 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMcfLnVmIjgrAA--.39322S5;
	Fri, 21 Jun 2024 15:39:13 +0800 (CST)
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
Subject: [PATCH v2 3/3] arm64: hw_breakpoint: Save privilege of access control via ptrace
Date: Fri, 21 Jun 2024 15:39:10 +0800
Message-ID: <20240621073910.8465-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:AQAAf8DxPMcfLnVmIjgrAA--.39322S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWrKryxGw4rKw45ZrWUtrc_yoW8tFWrpr
	ZxAw1qqw4UGa1UGa9Iqws3Zan8GwsFgryUWryqk3ySkr15Zw1fWr95GrnxurZ3JrW8X3yF
	vrZ8Xr15J3W7Z3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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
 arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
 arch/arm64/kernel/ptrace.c        |  2 ++
 2 files changed, 4 insertions(+), 9 deletions(-)

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
-- 
2.42.0

