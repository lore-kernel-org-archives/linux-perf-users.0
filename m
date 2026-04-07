Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCA3BD258;
	Tue,  7 Apr 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572214; cv=none; b=Llw10X76YmQdcpdFzoWPH7x+MOUpYTYhB94UyFDng+3F4efI/3NEwgaMyvJ99IJAvH19bWSSGSVghI4VMix9rSb3YnajyNF3V7NHNwZo0Kl0+qqhtARWWR0ms0AiT7NI1labxoNyNlOy3m63uFZnmoIfjHgOwUfILXqo/mos9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572214; c=relaxed/simple;
	bh=2mBdtCMg5XJhO2It05OyZWImRJfyjVt9ZDQUn9Uv+L8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glkJ2hhirsXFaTXtaNBg5c2nPmvlVHI8M30muXaorN0p6o8boCTwjJA3/CJ1R23myaC9SPv5z9TqvVXNmYzD5mHKRAPBrl/RWAGWKv0FI3KAG0+3dqvzvD2jBSxil1IrTJqZ12VhEbzQjakXZczs3Ls+p+hQyVxDyXSpfRigmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5rUk0l1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5rUk0l1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C939DC2BCB2;
	Tue,  7 Apr 2026 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572214;
	bh=2mBdtCMg5XJhO2It05OyZWImRJfyjVt9ZDQUn9Uv+L8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P5rUk0l17s8TR/KCexB3phw3iVAAw23OVADZWDCjcg1bB08aGDgI4zPKMy1oLe5bs
	 viE39t/tVnQSD21ApcnfZ0RNMwbq+DSQDctZlMR3sjHAvdllC8fDW1TtCxa2NfGlc1
	 FLtai55m3VKhyc5TnXNphhf7fVspNz1aQm4TF2Bhwgt663SUsvRljb3P63Yv2cImNK
	 mfwkuB8PgNOgQ7n4C96Rrzz6tGPfWMJKDqShG20TTCrOkzCQXXQ/VeiI9B8FRQjSc0
	 Ino1vjGOmwJl9Oheg1jZ2jaPKwlG07F/8IG6MmBQc++Ua/MrvUC574ZL1DfiSevXdk
	 xcCMoGn71QsJQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 07 Apr 2026 09:29:45 -0500
Subject: [PATCH v4 3/6] arm64: hw_breakpoint: Add
 lockdep_assert_irqs_disabled() on install/uninstall
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-arm-debug-8-9-v4-3-a4864e69b0ea@kernel.org>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
In-Reply-To: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15-dev

The breakpoint install/uninstall/restore code depends on interrupts
being disabled. Make this requirement explicit with a
lockdep_assert_irqs_disabled() assertion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/kernel/hw_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index bb39bc759810..a9266dc710b4 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -231,6 +231,8 @@ static int hw_breakpoint_control(struct perf_event *bp,
 	enum dbg_active_el dbg_el = debug_exception_level(info->ctrl.privilege);
 	u32 ctrl;
 
+	lockdep_assert_irqs_disabled();
+
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
 		/* Breakpoint */
 		ctrl_reg = AARCH64_DBG_REG_BCR;

-- 
2.53.0

