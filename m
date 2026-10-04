Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121141B8CA;
	Sun,  4 Oct 2026 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151783; cv=none; b=Hyb7nUmGmOpY+759pNaE07J+SmRkMQ7iYWN9USZdWaBjkboH2feqvm+A/rEo0Sch6VGFMPt9cNoCcDUOtfqXGanAVCl9xJXhLfDFUzNnzkOLb8RdEUsMyTEaHizGm48vy0R8UZnr2k1ouSqiw8Xz4rl8spdI/ZNHiiEIpyJJAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151783; c=relaxed/simple;
	bh=jMF5nERqMMPmzGx4Vvg3Zz41yHTBcvxjCq3ZQ0ns+bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PK+IY1BJ0TYxTPXMWtT8g3sdZn2R7iBfoZ99G3Wp12BF/FRghCBxOdUajEIUrvQNRrr4/IE9PRxB8Ygt5TYdjMzRKgzcoQKMlBhcnJIL4atOJeHamFKHZAhahJNFHSb78gX9leMNJf9ouKxnx4z4662I1Ysn9k6yqBuAmPSlhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU+R/k2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU+R/k2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4491F0089A;
	Sun,  4 Oct 2026 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151781;
	bh=nmHpsPp9iLBwKSLkzgRZINeT3/eG4Q/SLR9a6Ub540M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DU+R/k2iTEDi8OdYsB51Epn3Jf2n83BpJfVD5Rpv1WKNRx+d1kc2R1JTqIy0+KwjO
	 239RIN5YZ80bVXlpmcwTgFnSA6v2sk21jub++3xAau7HDdm8gHh5zudtog84rCOBnw
	 gcmAJK8qGA1ObwA69DI7d8uHsfCrnFMPATmmS28Qk9qk30DJ/MSyZXKPxmEAKz6Ws+
	 SWZVFYD3ldgQE5dKlhvil2146DnwqJfLNKC1RvxjyJyQC3nTsdB/vlLJEnjUW1uaRz
	 QQDgZnZ5ytF27NALGb1Xg+NRgqKCwNN61GBxwCj4Lgm3odwGeE9OzsRA4OpBJXmUKd
	 pox0Vh5J0lAgg==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Myria Sarvay <myrialsarvay@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH] drivers/perf: apple_m1: Add macOS 27 M2 Event
Date: Sun,  4 Oct 2026 23:09:17 +0100
Message-ID: <179114879411.1633099.5402206319757216770.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912-m2-9f-pmu-name-v1-1-da682557453c@gmail.com>
References: <20260912-m2-9f-pmu-name-v1-1-da682557453c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 18:03:35 +1000, Myria Sarvay wrote:
> This patch adds another known PMU event that can be found under
> /usr/share/kpep on macOS 27 for M2 macs. INST_SIMD_ALU_VEC purports to
> count "Retired non-load/store vector Advanced SIMD instructions", and as
> we already noted, can only be registered on counter 7. Though this event
> only shows up on the M2 kpep records, it can be set on M1 CPUs, and
> records something.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] drivers/perf: apple_m1: Add macOS 27 M2 Event
      https://git.kernel.org/arm64/c/652ab8ee0d27

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
