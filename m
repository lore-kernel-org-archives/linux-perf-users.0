Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7E1E049C
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990427; cv=none; b=lVp2VshCiAR779fEXtjOB4Hz4klDsCUpmNjSVBo48C4W9NypTwlUdOnlOPQgvdTNlIVgmk/G2UJSjihr1sCbfOIAAZyTjmuq4oX+rFX4TuACh56rkiquyaGqwOJ/hoHVysLlu6ZziLc1bHf/6ASpp4wqEKq6XQhsU+QvQ6l7x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990427; c=relaxed/simple;
	bh=73TsKCNYRlbvdsZEVzgDYau5tX8JS0F6ftCgQh/uVpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aenab17r3f5AW+A2FqGiXzyuXbX6yvw4LLFhD8l8h8Ua5k7MrgvmKfvutn1Q46uIevxJpLDrhAyMMi4v44a2M2sqzxuP2BrzBdxAK/snkOiT+EGMfDP5OX11PS6PxBhglncFAdwbBRspSRnNTUj3eWs9CqjeviL7Lbcs9W+Jayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB64497;
	Thu,  7 Nov 2024 06:40:54 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB613F6A8;
	Thu,  7 Nov 2024 06:40:23 -0800 (PST)
Date: Thu, 7 Nov 2024 14:40:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: namhyung@kernel.org, james.clark@linaro.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V10 RESEND 0/2] arm-cs-trace-disasm.py/perf must
 accommodate non-zero DSO text offset
Message-ID: <20241107144018.GB47850@e132581.arm.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>

Hi Steve,

On Wed, Nov 06, 2024 at 04:51:11PM -0700, Steve Clevenger wrote:

[...]

> Changes in V10:
>   - Removed errant space in patch file 0002. Passed 'git apply --check'
>     at perf-tools-next, 6.11.0-rc6.
>   - Added back missing prefixes.

The subject prefixes in two patches are not quite right.

The subjects would be:

  perf script python: Add map_pgoff to python dictionary
  perf script cs-etm: Adjust objdump start/end range per map pgoff parameter

With above change, you could keep my review tags.

Please use git commands to generate patches ('git commit --amend' and
'git format-patch').  If directly modify the plain patch files and resend
them, I suspect this is the reason that the archieve website messes up
rendering the patch series v9 and v10 [1].

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/cover.1728599785.git.scclevenger@os.amperecomputing.com/T/#t
