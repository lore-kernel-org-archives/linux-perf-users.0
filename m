Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6EE55A
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797584; cv=none; b=Vsa+RMRxicl4QnbWvAmJNiVDh+VhwzhJQl1AIfSFvKexA+FyhCfnLSD8p8R9bUDV80LKVTaNfYo4ZAFAM2w+QBZVHr350uprrcvpIA8lSwU9BpUjTokJx8JymsA0vScQF2200JO3+DYxnyeCSOvHml0NyEESa1/jPu5ooOkoekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797584; c=relaxed/simple;
	bh=nEbC35nGg0sLq1jCNuVold66EvLB5o+HcbrN4sb91UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCjNABvKHf3QM9J845Lcx4W+MkQwCVBBx0QeVMeQDBXy1DhIDPDvgUwDXX2xKfRKtGO1Fw7GHHTGvZpn8vKSvpZT42Pdgdc9S34DxeQ02swG4Y8JAcAwtNJbburFEvUngWsnS1L/+l6lbGXKXoq7n/4nlLOQ30NivaLWfWQYIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adtZFZEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adtZFZEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A275C19421;
	Fri, 10 Apr 2026 05:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775797583;
	bh=nEbC35nGg0sLq1jCNuVold66EvLB5o+HcbrN4sb91UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adtZFZEt8Ujgv+HPfHd9xHNJcIpPoLWTZA7SFMl5BhJ/cU43pbjVBudcmfLB3V9C4
	 +e5Hl+89Mf9p9N2MLzRp2T+o8gaRE9daWev3wRjwvbH/R0lYSvN1JFkms5jrnoP04k
	 C6MB/vzJojt1nNW+YzvOEgjy4XHOFg2/K9MBPzjOfD1hN6MXInT+EaPDmv285RoH1F
	 aR965aZiD3G/2gD6oR8kENDcmgqE8Jivdh0kgcE5ctmHqJsk5wHvhzWFq+ulL8rbzH
	 yEJMPXdZiAAWsQ+8rODZHYaPoum4Ukk9gnAqOBn4pc4b1JDimGHwOoZ63ak0RCLv1N
	 TebctHQvCUPTg==
Date: Thu, 9 Apr 2026 22:06:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/4] perf arm_spe: Extend SIMD operations
Message-ID: <adiFTnDndgpFwyl3@google.com>
References: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>

Hi Leo,

On Wed, Apr 08, 2026 at 10:42:30AM +0100, Leo Yan wrote:
> This series extends SIMD flag for Arm SPE and updated the document.
> 
> Since I failed to get perf core maintainer's review for uAPI header
> updating for data source fields (since last year's Sepetember), this
> series I dropped uAPI changes and sent only SIMD flag changes, hope
> it is easier for perf tool maintainer's picking up.

Sure, I believe these SIMD flags are independent from the kernel and
uAPI changes as they are from ARM SPE formats directly.

> 
> Anyway, uAPI patches will be sent out separately.
> 
> This version is rebased onto the latest perf-tools-next branch.

Thanks for your work,
Namhyung

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v5:
> - Dropped uAPI header changes for data source fields updating.
> - Link to v4: https://lore.kernel.org/r/20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com
> 
> Changes in v4 (resend):
> - Updated for Ian and James' review tags.
> - Link to v4: https://lore.kernel.org/r/20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com
> 
> Changes in v4:
> - Updated for Ian and James' review tags.
> - Rebased on the latest perf-tools-next branch.
> - Link to v3: https://lore.kernel.org/r/20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com
> 
> Changes in v3:
> - Rebased on the latest perf-tools-next branch.
> - Link to v2: https://lore.kernel.org/r/20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com
> 
> Changes in v2:
> - Refined to use enums for 2nd operation types. (James)
> - Avoided adjustment bit positions for operations. (James)
> - Used enum for extended operation type in uapi header and defined
>   individual bit field for operation details in uaip header. (James)
> - Refined SIMD flag definitions. (James)
> - Extracted a separate commit for updating tool's header. (James/Arnaldo)
> - Minor improvement for printing memory events.
> - Rebased on the latest perf-tools-next branch.
> - Link to v1: https://lore.kernel.org/r/20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com
> 
> ---
> Leo Yan (4):
>       perf sort: Support sort ASE and SME
>       perf sort: Sort disabled and full predicated flags
>       perf report: Update document for SIMD flags
>       perf arm_spe: Improve SIMD flags setting
> 
>  tools/perf/Documentation/perf-report.txt |  5 ++++-
>  tools/perf/util/arm-spe.c                | 26 ++++++++++++++++++++------
>  tools/perf/util/sample.h                 | 21 ++++++++++++++++-----
>  tools/perf/util/sort.c                   | 21 +++++++++++++++------
>  4 files changed, 55 insertions(+), 18 deletions(-)
> ---
> base-commit: dc647eb00969cd213c84d6caee90c480317e857d
> change-id: 20250820-perf_support_arm_spev1-3-b6efd6fc77b2
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
