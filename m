Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CC1A5B8D
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454410; cv=none; b=Gemg+oXAwqnQBz7H6tY8V30PVczE8UmG5ntlNWudKndcM/Baag5qGO4LNqfrgjiHnA6S9NhZMaXLUfOwtyzBsuWeESNMCtiYP8tzesks4LsCmrjPzP9/w8YMl1FPUhuvzzOZqgi3YV8tiWxtZFaW1ycWVLOAFZloPcfW0ropFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454410; c=relaxed/simple;
	bh=Mv1Ar8R5JGnQ92HRsQRiNXS9TdtatVcUFiUSlNTlVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIsBVcNa1NYy4GHpWga9JRYwQwbV+0GtZGK67fCbTDcxuUfvfN7r1Tq7S/mrFXbS6oSw8dcE2/Xpk8IQ93f3DJdFW8GSiCJFfkIjhbSL8mHwYuWG4AGFbD1J8+qp4PmIK3GVLpetxdMZh5JqIoE35LH8zLewPzpvupeQjspFChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0213A1BCB;
	Fri, 29 Aug 2025 00:59:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E16DC3F694;
	Fri, 29 Aug 2025 01:00:06 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:00:05 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	German Gomez <german.gomez@arm.com>,
	Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 00/15] perf arm-spe: Support new events in FEAT_SPEv1p4
Message-ID: <20250829080005.GE745921@e132581.arm.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>

Hi Will,

On Thu, Jul 31, 2025 at 02:25:35PM +0100, Leo Yan wrote:
> This series adds support for new event types introduced in Arm SPE v1.4.
> 
> The first two patches modify the SPE driver to expose 'event_filter'
> entry in SysFS caps folder. These patches are part of James' series
> "[PATCH v5 00/12] perf: arm_spe: Armv8.8 SPE features" [1]. In case this
> series will be merged independently of James' series, these patches have
> have been included here.

Could you review the first two patches in this series for Arm SPE driver
change?

I verified this series can be applied cleanly on the Linux master
branch with the latest commit:

  07d9df80082b ("Merge tag 'perf-tools-fixes-for-v6.17-2025-08-27' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")

Thanks,
Leo


> [1] https://lore.kernel.org/linux-arm-kernel/20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org/
