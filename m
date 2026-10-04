Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3C41D21E;
	Sun,  4 Oct 2026 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151774; cv=none; b=EbnrqJd+e+JkqN6/kFDK6VmJFlOJkkKpL10EciEwWJRL13WiqYceWzbezAhnNWncyTmW94mmsFizqQVUyqFuoyIuVn8g5TP/B914qCvk6123JTLpZLegLeWY/uxJK7Mai3qE+Nmpe7oHk/wkeQbvsygL4rpjjIWnbkEn6dD7pJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151774; c=relaxed/simple;
	bh=B8jxocMBeOJgsAxHKr9qwO6fljG0XPiuQ4F0uHFwhf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tweHmluSnzU4CrtSme6Z2P+Mr+Bpi+NhH+n0MNdkjR+dG9/UoKHPT5CGk3O/h8Gm+7r7zAgAyzVZQhqADZqzqcZn/65I2Y8eh0h766rPsAbnXVuMdaAeG6YWIPGVsZucS5+ssqkVD8fu3JwONQZuZEdwawRNS/5mxi/djNyLWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFdTWR69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFdTWR69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F521F00898;
	Sun,  4 Oct 2026 22:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151772;
	bh=LrX5lgQv29VbsZUj0pN0WYSmr+mTAH9e3Fbayxufbug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFdTWR69oTe5m8F65d3SSevl6sy1iFJM7cuaOezCaDEDAjqjhsRmX84ljGVzVQLuT
	 P0LAiGcWA6LgABMW2P5hAdUOQE9HuLkQnq16s1sFVriJLmYdGDaEDv0YLyencuqk/i
	 cCZS1Gw2c+8EK/8REDV5qgXZGLd4Ikowfk7/XFEC725Sva6gN6wIkwlfeIU+hEfK/v
	 k0FL4x/77UoWCi2FDeqTC4LGeZwEwtBLuz5H+audTepyCqciHk0VovWcT7Rp+iRYXC
	 qUwSUXKAmpykG3bDktZIvQehypmd+ZBZ7C+MNcAZlqAAjqKNavkUGeCqh70bCImgXK
	 3s1hHqrAXGZJQ==
From: Will Deacon <will@kernel.org>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jic23@kernel.org,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH v4 00/11] perf/cxlpmu: Misc sashiko raised issues fixes
Date: Sun,  4 Oct 2026 23:09:14 +0100
Message-ID: <179113338601.1493167.6241273025938651423.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Aug 2026 08:59:00 -0700, Dave Jiang wrote:
> [resend, mangled linux-cxl mailing addr]
> 
> Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
> the sashiko raised issues and then continued multiple internal review
> iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
> but the fixes look reasonable to me AFAICT.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[01/11] perf/cxl: Program the requested event group on configurable counters
        https://git.kernel.org/arm64/c/b22dcc114298
[02/11] perf/cxl: Clear stale event fields before reprogramming a counter
        https://git.kernel.org/arm64/c/7406d6cf76b1
[03/11] perf/cxl: Fix the counter overflow delta fixup
        https://git.kernel.org/arm64/c/0326269ed735
[04/11] perf/cxl: Accept an overflow interrupt on MSI message number 0
        https://git.kernel.org/arm64/c/af06fba45746
[05/11] perf/cxl: Split the MSI vector out of info->irq
        https://git.kernel.org/arm64/c/97fe5d94b7ce
[06/11] cxl/pci: Add the PMUs after configuring events
        https://git.kernel.org/arm64/c/28b2b667f48f
[07/11] perf/cxl: Don't share the overflow interrupt, and keep it pinned
        https://git.kernel.org/arm64/c/b899fd3487b0
[08/11] perf/cxl: Unfreeze counters after handling an overflow interrupt
        https://git.kernel.org/arm64/c/2e4fe234c72d
[09/11] perf/cxl: Validate the hardware-reported counter width
        https://git.kernel.org/arm64/c/1c5499e67303
[10/11] perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
        https://git.kernel.org/arm64/c/984920c893f0
[11/11] perf/cxl: Clear stale overflow status before using a counter
        https://git.kernel.org/arm64/c/05d82cf377f7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
