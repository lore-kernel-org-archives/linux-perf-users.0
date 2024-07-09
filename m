Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61C153820;
	Tue,  9 Jul 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518913; cv=none; b=lgBIrsnzmr0vHjlUzbtrh17yBLa4qXE0/SPDzI4zTCg0Ay+FjuiN78ijnKQ/iIQtCATHqsMEzBKsShm2vy2SM1uchz+eI6FBHnMNZMLeuQzwHQPoIFyK/NV8FUTgCEXlp5f9J7dZBkpXQOuHVlA6zioCbOWxkAjIv+30KeS6Cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518913; c=relaxed/simple;
	bh=eax1Aaob4BNuHp+SZvgWyc+FoEJ7G16Gq6WLfGlD/Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1fw8G1655u75NvSuOwKuMliYMmN8Rku9eLI10CL7t6b1V6IflK8Gr3s3urIiPlQsgGNIR/pYGw83ift+TGm42w21poK2Ezu47eZRaOuEa0WJXcMAZ2xHQjuPQryVN5SpesbzM+xPSpKvLAGyKCtbgwOyfA4t9jRyU2gR3KG9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxruv9CI1mZGACAA--.7073S3;
	Tue, 09 Jul 2024 17:55:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqsb6CI1mgt1AAA--.17645S5;
	Tue, 09 Jul 2024 17:55:09 +0800 (CST)
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
Subject: [PATCH v3 3/3] arm64: hw_breakpoint: Save privilege of access control via ptrace
Date: Tue,  9 Jul 2024 17:55:06 +0800
Message-ID: <20240709095506.9691-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:AQAAf8Cxqsb6CI1mgt1AAA--.17645S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF18JryDGr4kur18ZrWrJFc_yoW8tw4Dpr
	ZxAw1qqw4UGa1UGayaqws3Zan8GwsFgryUXryDG3ySkr15Zr1fWrykGrnxurZ3JrW0q3y0
	v3yDXr15Wa17X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

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

