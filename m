Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C74259C;
	Fri, 21 Jun 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955559; cv=none; b=dGPhrZQ67SB5WNQr+U1Kt/OZckTusII2s3Tv5UXrzZWUI0Uwrx1Rh0jFBlDCIpg3tSfPjemArXd+l6PQdHX89Un7q35TG63uD9ShF0IkGie16gcdgczKP+h0FUyTzc0CI0Cr1LpZ2YhVaxgvtMqk5+6nr8rD4VUD5PwxHsPvw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955559; c=relaxed/simple;
	bh=ppG0XSkNgecIfzGrMB63byd0fkNXG6e93Jv4TzajFg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQEBPR+qbDFQbu62LQNJRkij96icIP/OaCIhOOWLFscz2IRtJaAwNkGoD31X5IQAWwv7/M2gtvqPGguXKRClT7FNoWXhjqXaXzpgLlsD3H04Gb76lBoRDxI1zzm21WBlWF6QMLA3ZFJ5hpzT0xPcErlh/+zl/o5vRe69KXbvDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxFPAgLnVmjssIAA--.35648S3;
	Fri, 21 Jun 2024 15:39:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMcfLnVmIjgrAA--.39322S2;
	Fri, 21 Jun 2024 15:39:11 +0800 (CST)
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
Subject: [PATCH v2 0/3] hw_breakpoint: Save privilege of access control via ptrace
Date: Fri, 21 Jun 2024 15:39:07 +0800
Message-ID: <20240621073910.8465-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPMcfLnVmIjgrAA--.39322S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFy5XF48ZF18WFykXrW7KFX_yoWktwc_WF
	yIya4DKw109r1Fya45tw1fZF93Kw4Y9rn0vw1vgrZxGF9ava4ruws5AF95u347XF4avrWD
	Xw15Ww1qvrnIgosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

Hi all,

Thank you very much for your feedbacks in the v1 patch.
This series is based on 6.10-rc4, cross compile tested only.

As far as I can tell, these changes are not relevant with tools/perf,
on some archs such as ARM, ARM64 and LoongArch which have privilege
level of breakpoint, the initial aim is to make use of the value of
ctrl->privilege saved in decode_ctrl_reg() and then remove the check
whether bp virtual address is in kernel space to assign value for
hw->ctrl.privilege in arch_build_bp_info().

v2:
  -- Put the new member "bp_priv" at the end of the uapi
     struct perf_event_attr and add PERF_ATTR_SIZE_VER9.
  -- Update the commit message to make the goal clear.

Tiezhu Yang (3):
  perf: Add perf_event_attr::bp_priv
  arm: hw_breakpoint: Save privilege of access control via ptrace
  arm64: hw_breakpoint: Save privilege of access control via ptrace

 arch/arm/kernel/hw_breakpoint.c   |  4 +---
 arch/arm/kernel/ptrace.c          |  2 ++
 arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
 arch/arm64/kernel/ptrace.c        |  2 ++
 include/uapi/linux/perf_event.h   |  3 +++
 kernel/events/hw_breakpoint.c     |  1 +
 6 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.42.0

