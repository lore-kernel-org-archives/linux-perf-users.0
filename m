Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB82E3009EC
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653939; cv=none; b=STelr4JiVdwTkdrOG94EJ50Bwk7m+x/zghnVzjejmBrbvkzimrJYdHR0HWrJpNbkSzT/dAzw3Z5673Ia5A8RlkbzgtMjCfA01khvTJKm4sMFA7CMc9Jwh5hi7itVu7tiJ9c+7pD+4o1OCmhEWrFfudZKl5vsr0EanjfCA3/VZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653939; c=relaxed/simple;
	bh=gIOnnaQJwb5PHVOw5B64r1U717QrU8ad3YegmX5iF0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvzY0roQtzGoEyOrxp47S2jOwSK5y7Bs1pXe76+B0Tj95xZlRzR8mQ5bqx/mmvTbryj8znWeKftikwCNIGUhriq2tTy9sXuc3UlpCu27Ej8mS41AEUgtA0s7+Bv+iXjxWzX9cmDg2CzU+h3GF6GhTuId6s9m/WzptGbmpTLDxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5526VeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5526VeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4B5C16AAE;
	Mon,  5 Jan 2026 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653939;
	bh=gIOnnaQJwb5PHVOw5B64r1U717QrU8ad3YegmX5iF0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5526VeTbg+YDq0xF+TPpwbuSJXoGpYHgrK77YOGNILRrrAmscgVPoxt7RpnnWcsx
	 GuNXm0g+cyJE8kGCuvsg3oH0ok/PkmkSJ9fDBr8fHJpke0zPxb6jkLQf0icelo1Sqy
	 gxc0x7UlMnizMXDNXD3wQ7HBsMotq0G3iEyK7wNAryV7WSgJ74T+IBZUzwie8Oaqqp
	 DSzy1SMOt7/v0yq1RcsTF4QeIJ57igw/xcOtdYSfx0UuPQDd7JP1F0hD398GTEawWW
	 iVLIO90etT5hIDnApSvHIhkuWLVPP+Ax3fPp3AoYmZ8PQa2BLXK5U+pwU7JXLcjvoO
	 jLHIpwoaTkJJg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH] perf/arm-cmn: Support CMN-600AE
Date: Mon,  5 Jan 2026 22:58:26 +0000
Message-ID: <176763174079.1386255.16352848900159993179.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
References: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Nov 2025 16:39:54 +0000, Robin Murphy wrote:
> The functional safety features of CMN-600AE have little to no impact on
> the PMU relative to the base CMN-600 design, so for simplicity we can
> reasonably just treat it as the same thing. The only obvious difference
> is that the revision numbers aren't aligned, so we may hide some aliases
> for events which do actually exist, but those can still be specified via
> the underlying "type,eventid" format so it's not too big a deal.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Support CMN-600AE
      https://git.kernel.org/will/c/12a94953c37e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
