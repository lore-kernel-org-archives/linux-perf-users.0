Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81414334692
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797833; cv=none; b=Ce0OsBpfBlu2zgihOkFNXjOsuSZf4sXOigblR2LG2/4XieDHbqMssAziRd49XYFe+VOOIlSKsxaTmS0/xJPXOG3d1eGHetjZoo9C5ssqeEbtP3jLCKV/YSWPwLH/JDcqw5whf8YttY9RoBStNIN1Ecl0uV/pLK0pZ5dOKMDeJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797833; c=relaxed/simple;
	bh=fJ7v0Jhvk3LlyZE3av0sez+GL2CuEUcfvz33Z3lQ5nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mksWvXH7OKrchFG/X3rcKNoFqx/DwsMxgB14oQr2nglaa6sim3lWV7MVejHwtICvqpsdjP10chc6ScUMe6MPC076xjvHKmsdqo15m8WEvychdlKCF9qsz/09TkWjrKr6wr1Ux9r8Mu9bqTz1xpSxsoB0k92pW7FTxqZqGaYT1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw8D1mu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw8D1mu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6C3C19421;
	Fri, 10 Apr 2026 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775797833;
	bh=fJ7v0Jhvk3LlyZE3av0sez+GL2CuEUcfvz33Z3lQ5nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nw8D1mu8rQkAZrj92tK/gsFrIws1UtWgBqPKeQBzjx3Up5YQMFlCWzsVmg8dvgLoh
	 jd2LrFR24Z63p6cOktfLjLronZfIcyPOjZN1JuF3D7QQ0ruzGaon0a4YGOtzEUnOWj
	 KS7nCdU42Eb7RELmhOb8oYKI7x/3ydQFR26CkgNL7so/ejxTtkhTmI1oHLsw6vToYG
	 /FPWGLcF7E3kIpYyihRUFyHDsQjDsrRqLnzAZ8FKLJI/0Uw2+ufEkuyZMHO+iU4rWp
	 pBNfPRLei0wTMHhxcxQtHv3tqgO6miMVcHFqt7+7vAwX0CR2/w1suBtXZI2Ha0Yuze
	 UXK8ob8mOYuFQ==
Date: Thu, 9 Apr 2026 22:10:31 -0700
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
Message-ID: <adiGR-A-N1tMzxTE@google.com>
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

On Wed, Apr 08, 2026 at 10:42:30AM +0100, Leo Yan wrote:
> This series extends SIMD flag for Arm SPE and updated the document.
> 
> Since I failed to get perf core maintainer's review for uAPI header
> updating for data source fields (since last year's Sepetember), this
> series I dropped uAPI changes and sent only SIMD flag changes, hope
> it is easier for perf tool maintainer's picking up.
> 
> Anyway, uAPI patches will be sent out separately.
> 
> This version is rebased onto the latest perf-tools-next branch.

Unfortunately it doesn't apply due to a recent change.  Can you please
rebase it once again?

Thanks,
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
