Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D84477F6
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036339; cv=none; b=BmlkxhoyhRo/TDA6lfmfezv/hG4h5OF0kH0KnHUS/qCU+a1wvzUie25TAdlqMf82yVXdDtXluHzXVmcZESFisKmnF+VO/j2RE8H2Q83kJ/oI5w11l4//McOIqKfx4HW7hn8uVdRqrgJeosqNrnYrLjC8ZG77xXg8K3jDqVQ8EFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036339; c=relaxed/simple;
	bh=mG5C8oXkq48G8bGbyBOAxX0k4Ez+x2CE/InE2h9NZQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuYvJMzhxgLMjWSpimKsnw8GTnOxzV2gGJUVrsTAzIOJhVTOlI88ZhXOw5yM2fcozQg0LzcSySS3o4uh9vLQv2j+Rfc4ET1RFoLnV/3EJjp5Ebru9ITfs/v/w5EdMrzK0R1T0uOTuimXJ/e54zBcSnQWlOeLVQa4r+dXLVEbwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBXtthla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBXtthla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8F51F000E9;
	Thu,  6 Aug 2026 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036337;
	bh=qs4zXt52yPprogidGbqcBFljl+XDCyeTQeEFyOiMma4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBXtthlavXY8ceSZ8duo8BEz3UTtrn7dI/0y6bxESSmRSKo1HkKCKlaCu3A9WirHR
	 RCaf07lsAHagUamSPUErIlIquo4ZS0MMUGAhhsrEdwSe7kSl60cywOLbQ+7LnNQM6b
	 roJKUc/LVltRJTsukumd1TH6O2LQCIfR1JsNswTfYXonHTfAH7xQi15e6XabbDob1J
	 P3AZ6QMnzes+eywPTwI3FydlGPtx8xKlayAGqMiYhiY0ASZoNw6qLAc1bkgaP9ZGHm
	 90CJ02MeY3jz5JrasF5ZxvkF7i0ZmH/CQp3uMRJ4OIB/9mB2doG65pVgC9sxtNzW8y
	 r40+Xvi4iQh7A==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com
Subject: Re: [PATCH v2] perf/arm_cspmu: Support 64-bit programmers' model
Date: Thu,  6 Aug 2026 18:11:44 +0100
Message-ID: <178601658928.385816.2976546188979360844.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bde4469c918494e8fa04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com>
References: <2bde4469c918494e8fa04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Jul 2026 16:22:58 +0100, Robin Murphy wrote:
> The 64-bit Programmers' model extension, now named FEAT_CSPMU_EXT64,
> makes all the non-counter registers 64-bit as well, of which we most
> need to care PMEVFILTR<n>, PMEVTYPER<n>, and PMCR since it changes
> location. Our event config fields are ready for this internally, but
> we need a few more tweaks to propagate 64-bit values properly from
> end to end.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf/arm_cspmu: Support 64-bit programmers' model
      https://git.kernel.org/arm64/c/807b9ecead03

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
