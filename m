Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9763A3828;
	Thu, 30 Apr 2026 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542029; cv=none; b=d9F2bj/k9dm+KumTppnnNPCgNmEMakBJVCmv69KHgBdAlKB2upHgq3gOeWPZluDhWEs8eZYj9OYJD0cCmpqpZeTqTS/PC4zGpvTz5kPvD8ugr379A2p38rgGseOzMXouMJKLETyxh6RuTAAF2tdZxte2nWAD0EPvIqb09yuqHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542029; c=relaxed/simple;
	bh=viMJdaQKnJpPSLVttk1P5mppEN4n7BVIiNF65MS4KBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EfPDR3Jra1qTOkrbGRI+6NtjYehkt8CZwl4sU+H5xmecjhx92122V7Dz7u0f7kjqW4DDf54mGfDg5FJBoxrHqL5Z2PeHa3VBXI14l3tTi7LDfLD8VsI/rCrKmnYmCWBEY3my7drex6ubTIeJSeHxea6Fl1M6+baSAU3nsM729S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AAx9dq4/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AAx9dq4/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Gyc9RYbLfZX65HhctB5vMYt8uQboQJxO3yiTxtN7nVc=; b=AAx9dq4/SZQziuBwrwOmmdJbxp
	WRPQfpFQ8PYiuEV8Bn/0WGFbaOxsUv7Jb2PYlLCdSKmnEWBDE4S6X+LTGj2AEobcwFnbQvcMC2Ubi
	AeIXU/AzRwvxchEbVhh3Yaje9kLuVsunHvK6/xe4IqzGE678nbEnMmHfL58OU3P0h/HABQZSZY89w
	Y7k6WdurgpGDWQv56SrlBPhW+Ob+6aDAbDIBxeLeommwRAENi8GHQAIpUe9rY1I7mZ6qUsmNyGlsx
	LgMU+s6iRXzMxqsRNuUsRDZN4VYBhEtA/n+NyARJ0LCAsVIgAty4pgU2ItjXMmvHsLep/vqD5/4nw
	2g3pRPfQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wINsd-007hPV-0T;
	Thu, 30 Apr 2026 09:40:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 30 Apr 2026 02:40:10 -0700
Subject: [PATCH] arm64/hw_breakpoint: reject unaligned watchpoints that
 would truncate BAS
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-arm64_bas-v1-1-c6ab2b15aec0@debian.org>
X-B4-Tracking: v=1; b=H4sIAHkj82kC/yXMTQqDMBAG0KsM39pAmkhSchURiTptR/CHjC0F8
 e6l7fJt3gHlIqxIdKDwS1TWBYkuFWF45OXORkYkgrMu2Npbk8sc6q7PamJkH8ert84FVISt8E3
 ev6tp/9ZnP/GwfwOc5weJ7VNNbQAAAA==
X-Change-ID: 20260430-arm64_bas-77e37d830226
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Pratyush Anand <panand@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, clm@meta.com, leo.bras@arm.com, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=leitao@debian.org;
 h=from:subject:message-id; bh=viMJdaQKnJpPSLVttk1P5mppEN4n7BVIiNF65MS4KBQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp8yODgMluI4SVJ+b0hRU85ToWOMb60uHOcdbRX
 mV0f24qDOWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafMjgwAKCRA1o5Of/Hh3
 bQUWEACUa+h8kB1BCjISTYNwwF38x0gwdjSbanCGawZOBdilCnSz6qkBw4weQTOBJh0HlnLdAFc
 ZXshD7npAibp9z1LWgBGN9kqwQ7IfNIW2cchqb+zKih+0Slhv86R1QlrzYOS5C16lrCqmDdQG+H
 4BqE0dty04wnagUBY3zVLP8LFmxHpaE7256D/Xj6zHsiOvlzqjcu/aZOY5BEf0pbqqY9r6LUles
 UvWnLzNHYoSJrXoaBoKVI+z9v0vpWZXEfW3ZqvzqZQD0Ls8dbcDnSJ0XUxUcIiIHAsBVGiOxvfD
 3APyM7dmpdICI59nv0G7KaS92/ZcNSjZxmFysWi3Yrm7O1ra+haqVWNtJ5NIjquScWRDcju525r
 foXlAzDsgkZQ2DuIpeI1XRQE6NtUw2wvuFAcy3UvK2T6HzEvZf2BoKP/agglDCI2o6kAeXPKckK
 ETONskEo5jPFIglrDSwcYrRvRt+NgMC3IwjrC19uhA7h7CZjZngb61CDYLl5QfLOw/7IZIDNYhs
 1i/ckKZcAdg4OrG4NhXsQGxeNwS/3MIb3pYbmuWn4Xxp9G5R89rR3ovODH7eoN0+Z/gEq6+mRVp
 nDv8GSpshl9+f3zn0448E6UogyCzNasLj2b8W6YxmJk7Y4ouLPuD7dPNyWlSvqDmGr+8RUO+dOd
 neKV8W3Jv0RQGYw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

hw_breakpoint_arch_parse() positions the BAS bit pattern in
hw->ctrl.len with

	offset = hw->address & alignment_mask;	/* 0..7 */
	hw->ctrl.len <<= offset;

ctrl.len is an 8-bit bitfield (struct arch_hw_breakpoint_ctrl::len is
u32 :8), so the shift silently drops any bits past bit 7.  For
non-compat AArch64 watchpoints the offset is unbounded relative to
ctrl.len: a perf_event_open(PERF_TYPE_BREAKPOINT) caller asking for
HW_BREAKPOINT_W with bp_addr=page+1 and bp_len=HW_BREAKPOINT_LEN_8
ends up with 0xff << 1 = 0x1fe, stored as 0xfe.  The kernel programs
WCR.BAS=0xfe and the hardware watches bytes [1..7] instead of the
requested [1..8] -- the eighth byte is silently dropped.  The
syscall still returns success, leaving userspace to discover the
gap by empirical probing.

The same class affects HW_BREAKPOINT_LEN_{2,4} when offset pushes the
high BAS bit past bit 7 (e.g. LEN_4 with offset=5 yields 0xe0
instead of 0x1e0).  No memory-safety impact -- the value is masked
into 8 bits before encoding -- but debuggers and perf users observe
missed events on bytes they thought they were watching.

The AArch32 branch immediately above already rejects unrepresentable
(offset, len) combinations via an explicit switch.  Mirror that for
the non-compat branch by checking that the shifted pattern fits in
the BAS field, returning -EINVAL when it does not.

Reproducer:

  struct perf_event_attr a = {
      .type = PERF_TYPE_BREAKPOINT, .size = sizeof(a),
      .bp_type = HW_BREAKPOINT_W,
      .bp_addr = (uintptr_t)(buf + 1),
      .bp_len = HW_BREAKPOINT_LEN_8,
      .exclude_kernel = 1, .exclude_hv = 1,
  };
  int fd = perf_event_open(&a, 0, -1, -1, 0);
  /* before this fix: succeeds, watches 7 bytes (buf+1..buf+7)   */
  /* after  this fix: fails with EINVAL                          */

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: b08fb180bb88 ("arm64: Allow hw watchpoint at varied offset from base address")
---
 arch/arm64/kernel/hw_breakpoint.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index ab76b36dce820..b8a1402119f3a 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -559,6 +559,15 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 		else
 			alignment_mask = 0x7;
 		offset = hw->address & alignment_mask;
+
+		/*
+		 * BAS is an 8-bit field in WCR/BCR; the shift below would
+		 * silently drop the high bits of ctrl.len when offset + len
+		 * exceeds 8, programming hardware to watch fewer bytes than
+		 * the user requested.
+		 */
+		if (((u32)hw->ctrl.len << offset) > 0xff)
+			return -EINVAL;
 	}
 
 	hw->address &= ~alignment_mask;

---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260430-arm64_bas-77e37d830226

Best regards,
--  
Breno Leitao <leitao@debian.org>

