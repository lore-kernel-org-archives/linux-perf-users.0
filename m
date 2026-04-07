Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3C3BADB2;
	Tue,  7 Apr 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572211; cv=none; b=VAEHLEUX2lUqM+odqUML2WU/wK15iAh2IDIEFXaC5OWEIqnwVyuU4q1NOBjTuwW+SFewjqTq86I1r3VR+9VOV3FQCHroHvc/A9m787m0xQyn5ZBsJFUYZTcWO4V/g3jWv/sDO4Z+bce9k5Vb2+Vvo5kRgmtroY+1yjKn5MyAClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572211; c=relaxed/simple;
	bh=H/ZjhYgrW3VND0oifQK7yUnQ24qHMPGKHi0BUoEY5sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpCvh10qD7m2IheSAHkO7lYFz3F+WeqJejuHi558CkVi2CVHSYWcHeax4VF/lnZjv8M4u9fEURqXyXch4z8bWOZEhLwQD+YKrvc2Tfhg7HtHjgvJvZjBhjTfzo0j/gDzjvAummGymW/LJF562ldA5v/yNeL3x3KBe0o4jCEyu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvCt7trh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvCt7trh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D1AC2BCB0;
	Tue,  7 Apr 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572211;
	bh=H/ZjhYgrW3VND0oifQK7yUnQ24qHMPGKHi0BUoEY5sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LvCt7trhYrin7vmw0KGlxThv1JqXPC/SnLO0rfKa8S1mowBnzeXYbGqNm+DGZDIPm
	 Ve+KHt7WItbaxsfYzUsa6aVYZw8eMMZYEM7p/t86J88d+81PryhHYYUzpz84r3DqKb
	 6lyviNyMOSHm4QrUDAhsaAqeDpx0R1kfs5RohacPgzLpQ4szxwJX05DuAZIxDQTfbn
	 KMG0XZhgn9y+5R94Tmw2lrWVdH00wkMbO9Iltfgg+x72Ny6RrYmb2sB11vAzkRdab0
	 0p9I3pwQ72lkrxInh1wj80M+GVT/mesFaizqDmEJlGlWs8DfR0uf2wHtOYbWa2SBI9
	 hZXx36JxqEvyA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 07 Apr 2026 09:29:43 -0500
Subject: [PATCH v4 1/6] arm64: hw_breakpoint: Disallow breakpoints in no
 kprobe code
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-arm-debug-8-9-v4-1-a4864e69b0ea@kernel.org>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
In-Reply-To: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15-dev

Taking debug exceptions while manipulating the breakpoints is likely to
be unsafe. The setting kprobes in the breakpoint code is already
forbidden, but the setting of h/w breakpoints is not. Copy what x86 does
and exclude breakpoints that fall within the kprobe section.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/kernel/hw_breakpoint.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index ab76b36dce82..38fbd67b2a6e 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -418,6 +418,16 @@ static int arch_build_bp_info(struct perf_event *bp,
 	/* Type */
 	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
+		/*
+		 * We don't allow kernel breakpoints in places that are not
+		 * acceptable for kprobes.  On non-kprobes kernels, we don't
+		 * allow kernel breakpoints at all.
+		 */
+		if (attr->bp_addr >= TASK_SIZE_MAX) {
+			if (within_kprobe_blacklist(attr->bp_addr))
+				return -EINVAL;
+		}
+
 		hw->ctrl.type = ARM_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:

-- 
2.53.0

