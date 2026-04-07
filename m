Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F025A2B5;
	Tue,  7 Apr 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572212; cv=none; b=bAKY0iY0oXKOWbO9JEZDwsFB4vTd0MMvxrtm+x/op+w29/8izjFhLax2v+IQLSS/A3zePsijYOFdsiFa2VAxHyeomVhuXa0AwG67n9QafcenJ/QgxW67JnTYvkdp2Jy/YPkleoH/CravaReDTjWc3MH8GHWzlOYQcdKRqKjgtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572212; c=relaxed/simple;
	bh=zXlPjSjJdZ1ja9eNaaYsLbU6jHV6bkXu/LbF2O2Rslk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jO76tDAaMJ4EB02Za2worB7mYo0mtgc5k3ubvT+vL3arR16W7/eWIHHofk97jGQ6Vzy8ji6TARNV60xQNg3udehAN1rkkNLjYDGVcrT33Z97wSr1FRbaO65qxIIv5uDO3MXETNNlTmvhKu5WLRjLLirCWRFHaY9LagIgfz8UIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRPEz+/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRPEz+/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D43C116C6;
	Tue,  7 Apr 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572212;
	bh=zXlPjSjJdZ1ja9eNaaYsLbU6jHV6bkXu/LbF2O2Rslk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SRPEz+/S9/dK0A8JDQ5OuY1+2hVd/bEf8LIdeTo7yHf322NXXtQM1BkEBJRBU6diL
	 sqNBr7Q12MAkwoYlQv6IXEBdjZYQ9i/gFuGZ0C9w+0uLaeDzKsdSwhMLBtc9a/9w3C
	 C58O4MbwdDhqHYhs0gWMDXWdiUhEEhsdkeRnqRfM0L2+Ei2U5zY9keavYeAgwikSks
	 /CMaDawUPm6w3swEDWL05/694l8lod7hNgg+bQ2OOpqPzacLlylJjLtqmNTUfU4T3G
	 AZSvD76WdsKm/aciB9ija91/NZUydkwXgzY35IOCVMfhbTOT/Jm31wR2v+DoVjO0iS
	 2OejfP+JtlXQw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 07 Apr 2026 09:29:44 -0500
Subject: [PATCH v4 2/6] arm64: hw_breakpoint: Add additional kprobe
 excluded functions
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-arm-debug-8-9-v4-2-a4864e69b0ea@kernel.org>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
In-Reply-To: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15-dev

Everything that either runs during exceptions or touches the
breakpoint/watchpoint registers should be excluded from kprobes and
breakpoints.

The static functions are may or may not end up in the no kprobe section
depending on whether the compiler inlines them or not. They are likely
inlined, but make it explicit to ensure that they always are.
Unfortunately, it is not possible to leave the inlining decision up to
the compiler and place code within the no kprobes section.

Parts of what hw_breakpoint_control() calls are excluded already. Just
exclude all of it to be safe.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/kernel/hw_breakpoint.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 38fbd67b2a6e..bb39bc759810 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -187,9 +187,9 @@ static int is_compat_bp(struct perf_event *bp)
  *	-ENOSPC if no slot is available/matches
  *	-EINVAL on wrong operations parameter
  */
-static int hw_breakpoint_slot_setup(struct perf_event **slots, int max_slots,
-				    struct perf_event *bp,
-				    enum hw_breakpoint_ops ops)
+static nokprobe_inline int
+hw_breakpoint_slot_setup(struct perf_event **slots, int max_slots,
+			 struct perf_event *bp, enum hw_breakpoint_ops ops)
 {
 	int i;
 	struct perf_event **slot;
@@ -283,6 +283,7 @@ static int hw_breakpoint_control(struct perf_event *bp,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(hw_breakpoint_control);
 
 /*
  * Install a perf counter breakpoint.
@@ -718,8 +719,8 @@ NOKPROBE_SYMBOL(do_breakpoint);
  * The function returns the distance of the address from the bytes watched by
  * the watchpoint. In case of an exact match, it returns 0.
  */
-static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
-					struct arch_hw_breakpoint_ctrl *ctrl)
+static nokprobe_inline u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
+							struct arch_hw_breakpoint_ctrl *ctrl)
 {
 	u64 wp_low, wp_high;
 	u32 lens, lene;
@@ -739,8 +740,8 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 		return 0;
 }
 
-static int watchpoint_report(struct perf_event *wp, unsigned long addr,
-			     struct pt_regs *regs)
+static nokprobe_inline int watchpoint_report(struct perf_event *wp, unsigned long addr,
+					     struct pt_regs *regs)
 {
 	int step = is_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);

-- 
2.53.0

