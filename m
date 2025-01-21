Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355FC187FE4;
	Tue, 21 Jan 2025 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480136; cv=none; b=uJY+khMJv6MDRGHxrNBeSy1iR9If5YbPfm0hEf1ghkFbP1OIRCcsOQiaM+bg8fYNjnStzgt+hnmChAq2hVkJSL+kySADhWtrYzWTah3i83feHXM0n3/g7/i5ScONfcg/3q3hUBpQPricdZs+hSlGz8N5ruXqaiPhCx5zlN+hlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480136; c=relaxed/simple;
	bh=mC/iT8g5fvrhcz+i+2BWMfLIo8yMAh3iyJaeo3cRojs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+nX+EeAf11cUydsocmapNCWFhSORLmH209xJrA/gBoTAaHR8h/WYd9rgQ97NDDcGxdXGmkdTcS2XgWMr3g59lD6UWMIrpAI+0scXXGm7Lyb0p0BQrP7N6tL6S+09MlyuxrL0PkL0jcsrxz3YES2OrLxhZsR/AWOO+/SP48K2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE6B8106F;
	Tue, 21 Jan 2025 09:22:41 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3E33F66E;
	Tue, 21 Jan 2025 09:22:12 -0800 (PST)
Date: Tue, 21 Jan 2025 17:22:02 +0000
From: Leo Yan <leo.yan@arm.com>
To: "mark.barnett@arm.com" <mark.barnett@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] perf: Record sample last_period before updating
Message-ID: <20250121172202.GB416913@e132581.arm.com>
References: <20250106120156.227273-1-mark.barnett@arm.com>
 <20250106120156.227273-6-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106120156.227273-6-mark.barnett@arm.com>

On Mon, Jan 06, 2025 at 12:01:56PM +0000, mark.barnett@arm.com wrote:
> From: Mark Barnett <mark.barnett@arm.com>
> 
> This change alters the PowerPC and x86 driver implementations to record
> the last sample period before the event is updated for the next period.
> 
> A common pattern in PMU driver implementations is to have a
> "*_event_set_period" function which takes care of updating the various
> period-related fields in a perf_event structure. In most cases, the
> drivers choose to call this function after initializing a sample data
> structure with perf_sample_data_init. The x86 and PowerPC drivers
> deviate from this, choosing to update the period before initializing the
> sample data. When using an event with an alternate sample period, this
> causes an incorrect period to be written to the sample data that gets
> reported to userspace.

I found conflict when I applied this patch on linux-next [1], with the
commit below:

commit faac6f105ef169e2e5678c14e1ffebf2a7d780b6
Author: Yabin Cui <yabinc@google.com>
Date:   Wed May 15 12:36:09 2024 -0700

    perf/core: Check sample_type in perf_sample_save_brstack

    Check sample_type in perf_sample_save_brstack() to prevent
    saving branch stack data when it isn't required.

    Suggested-by: Namhyung Kim <namhyung@kernel.org>
    Signed-off-by: Yabin Cui <yabinc@google.com>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Reviewed-by: Ian Rogers <irogers@google.com>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/r/20240515193610.2350456-4-yabinc@google.com


Please consider to rebase the patch to fix conflict in next spin.

Thanks,
Leo

[1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
