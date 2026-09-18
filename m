Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F54EDCB9
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734499; cv=none; b=l9mZAr2D82vRJKCHlwyIsaUEIexsbZXZ7D+9fFCrpvtOWA1/xJ86yfbPZRBS5Rm+qo4FZKRoCxOxuGrm2VAGR6vUdWgvyYzviPFuSa2x4coFJkGV6Zf7Y+c3Wu3+y9V8SnuKeoF6+H+T4YeW58qP4kNJpHoLsz4oc2175SSSURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734499; c=relaxed/simple;
	bh=uaV5EkgKls8qPcjL4L22LiSDEksQ7+zAki/28EBlDj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwz89s4M5k2sMmvX3aq4tUxSfktmKvLiR7Y5qrd7jtaqrdk1oHdv6mgXN0MU+PNwvx0X6q5KL67hlnlpBZ5PlLprBTqr65MiXQK7krfhQ789Kna3XQqGbqV+3FWm9/tjT+PT8J4XmgyO3dWPnvIvasddBjAISC7/uAxQzQ92xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGI2f3IA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGI2f3IA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500341F00893;
	Fri, 18 Sep 2026 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789734498;
	bh=O0DjbgPT1N8oxtOkpX9QxlwHTjU0mZUCvcoBnTkW0bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGI2f3IAM7IFJlqScFS3TMwMeOFML5qxTg+q1ZSZBewCqW+ksOQ0KJlXdrbwv2G0w
	 8p+iX2J/ANEoJBaZ9MxsbJnuvscy9Axfa4cIrFrH2SQThLMH2GeqeArPs9AA/bl5E2
	 AIc5Vo3cCZvM3m5vScZ2I8D4kF1+SKZK9GMuBjiJSc2OAKhDBxDHvVqIxfreUYYLhZ
	 ckFopJDy3hZS0qwKSoEbohAYrIuWvzrJqIfycSxDX2GojNTS6mzRUs5KnhwMUauI9w
	 B8L/hCsAjcsQranEKFYunRNk5l3e0ZXN+Z561jellRb8US5iTL7kAk57CMhihlyBMo
	 +UCVSXrjGVOvA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ilkka@os.amperecomputing.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-cmn: Fix multi-filter encoding
Date: Fri, 18 Sep 2026 13:28:06 +0100
Message-ID: <178972989482.2319500.7665226811462988207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
References: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 13:24:22 +0100, Robin Murphy wrote:
> The current special-case for EVICT_STATE_SEL filtering effectively
> assigns the "filter" and "filter2" controls in the opposite order from
> how the CMN S3 r2 TRM states "Filtering is programmed in pmu_hbt_lbt_sel
> and pmu_evict_state_sel". On reflection, not only does this seem
> unnecessarily non-obvious to users, but it's also likely to be a problem
> for scaling to a full multi-filter abstraction in future. There is a
> logical order to filters based on their bitfield positions in the
> pmu_event_sel register, which the TRM descriptions allude to, and the
> cmn_filter_select enum already (almost) follows, so let's fix the UABI
> to follow suit while it's still unreleased.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Fix multi-filter encoding
      https://git.kernel.org/arm64/c/406aa2b186d3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
