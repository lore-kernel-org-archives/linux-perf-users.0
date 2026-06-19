Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690FE3BB13C;
	Fri, 19 Jun 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886978; cv=none; b=Pr2480sNUgTm6ld62kcqMRCZOBrGkRuh2mfPb0O9oTqS4yb9tPTr5sHogTFkqqBRKAO9W2cXIisJPKcO8+41EPXVC8KG4s8C5YQ9sB+yWbpxKwlG1umQb0Tl7Z5lcTKqmy7rOk1L3KvhWwnpUiKb8xa+P44b8cPNMaPkxGu+tbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886978; c=relaxed/simple;
	bh=A1ZuLKdaXGkEwxLzuiLX0xtdgQQrJhKZEc6XbV0TeeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pmk7mFpnuMSyQUAhsUse6YkUYIgGKAp4nZZPIpuUV8V2msj5Jod7LpfSE2YWOJHiosDnamZ5CJRVPxcKO326RxH0s4CPEtiuWWQEOmaW0GbewXmRFF04jWZoIhaSNskjQ8icpUUW/CD61/c2sYH/WXubOjjzIXqGunYo+Xgay18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHd+vfHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHd+vfHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08DF1F00A3A;
	Fri, 19 Jun 2026 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781886976;
	bh=1xhqGNsWnLwZPaj0pcMJoR83OBrixQwsUN/yCO5ZiV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHd+vfHMQzr+0RFkOzXvLyLSntCWYGfUuzo5Ka3pF2zX+r+6hGDvdf/UR8yRaPyJm
	 TTHgQ6uT1Tu8uOFtS4x8nF6/pjkvq9vWkIafHYYeIxuxriW1MqcvqkldYSFnysPI4P
	 NKl2IWHJ7ZgxJnTOXBfZQ+RIDF01SsO4CG0lN7OtlvB1VyIMi+TUrdQz5+S4UBSUNc
	 kJhzNbZCrfmXFYamZGHERF4ujuUx0rGpPV9fRZjtltXVVDqL/bN0BkTQoKENbD4YWg
	 VXvu8QBqNxoHjdUmK04IpaMzeKVV0q/TQPzHyRacO+rlSq1ogVvapdHGLGbUXJktdI
	 RU/ilp4A4+zjQ==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Pratyush Anand <panand@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	clm@meta.com,
	leo.bras@arm.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2] arm64/hw_breakpoint: reject unaligned watchpoints that would truncate BAS
Date: Fri, 19 Jun 2026 17:36:05 +0100
Message-ID: <178188509799.1161904.13699894903976335311.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609-arm64_bas-v2-1-9f34dbbded88@debian.org>
References: <20260609-arm64_bas-v2-1-9f34dbbded88@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 06:15:53 -0700, Breno Leitao wrote:
> hw_breakpoint_arch_parse() positions the BAS bit pattern in
> hw->ctrl.len with
> 
> 	offset = hw->address & alignment_mask;	/* 0..7 */
> 	hw->ctrl.len <<= offset;
> 
> ctrl.len is an 8-bit bitfield (struct arch_hw_breakpoint_ctrl::len is
> u32 :8), so the shift silently drops any bits past bit 7.  For
> non-compat AArch64 watchpoints the offset is unbounded relative to
> ctrl.len: a perf_event_open(PERF_TYPE_BREAKPOINT) caller asking for
> HW_BREAKPOINT_W with bp_addr=page+1 and bp_len=HW_BREAKPOINT_LEN_8
> ends up with 0xff << 1 = 0x1fe, stored as 0xfe.  The kernel programs
> WCR.BAS=0xfe and the hardware watches bytes [1..7] instead of the
> requested [1..8] -- the eighth byte is silently dropped.  The
> syscall still returns success, leaving userspace to discover the
> gap by empirical probing.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/hw_breakpoint: reject unaligned watchpoints that would truncate BAS
      https://git.kernel.org/arm64/c/4cc70f75853b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
