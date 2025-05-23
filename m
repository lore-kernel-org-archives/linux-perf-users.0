Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143C2DCBE1;
	Fri, 23 May 2025 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965347; cv=none; b=CpZd1kfAPKpDl4sP/FCNEjjeE+hyc14m2wVzD7+DYy4x+FyH4LDNm3awJC0U0yysMk9116Y+XazGbtUhyJPVDe3BKVb0nlu//0hnjzhuV6zxDIKd+fnNyw28NjJvKq0z2bt9TlfcV2uT9MJqb6tyXE/9UCL9ryY2XMBEmr09Op0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965347; c=relaxed/simple;
	bh=WLRYBZzVBC+vgSIVR38d+O8tfcmu/HYiOZH436LZdMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hygTkg6LmLYmj+BuHyDBdY9EZjJB0f1IWpkw+VEjXAnILuKPwbEs0hxtESOhzL8lHFwlw24kVwVTq0gaj+zfNpevGHC48ZL8R5EMOnupHLu7eLa/oh8qK4aWknncXhsyM5yr3elWAb3MbbRLJC+hu/QnUOXqUd3kDF0rj9n+JWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkG/ue3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkG/ue3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E9C4CEE4;
	Fri, 23 May 2025 01:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747965346;
	bh=WLRYBZzVBC+vgSIVR38d+O8tfcmu/HYiOZH436LZdMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkG/ue3gp5RlGClgHNH86IC5Gu85n80scKYZoZLCT8yLiTqzfffcTpwelDTmxx9bn
	 poWMxNLh3cXobxjeA6+ibFLYukPB8J8e1iJlkp5bU6acfI46BYJK7KAadoDysStSrI
	 FUf0EKxcK2soG/CRg4jQbtTq0xgHfi5T46dpu/v6Zv4L5BL/0Wd36of3RblV0GovcJ
	 vh4RFejoJkfOP/gyu1HK/pLS2vGwnA2tcivf1QPmeaKWOuZypImxjrNmIONb7H3poz
	 am+70OEhfn4CrY3XTCeHxOf/fVOO0zcwIJ/UTUN8hS3d1rUBmgLlAPzVTtObDS7jpH
	 HsEuLQVlMfH0Q==
Date: Thu, 22 May 2025 22:55:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aC_Vn95vYqcXul03@x1>
References: <20250331172759.115604-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331172759.115604-1-leo.yan@arm.com>

On Mon, Mar 31, 2025 at 06:27:59PM +0100, Leo Yan wrote:
> The test might fail on the Arm64 platform with the error:
> 
>   perf test -vvv "Track with sched_switch"
>   Missing sched_switch events
> 
> The issue is caused by incorrect handling of timestamp comparisons. The
> comparison result, a signed 64-bit value, was being directly cast to an
> int, leading to incorrect sorting for sched events.
> 
> Fix this by explicitly returning 0, 1, or -1 based on whether the result
> is zero, positive, or negative.
> 
> Fixes: d44bc5582972 ("perf tests: Add a test for tracking with sched_switch")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

How can I reproduce this?

Testing on a rpi5, 64-bit debian, this test passes:

root@raspberrypi:~# uname -a
Linux raspberrypi 6.12.25+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.25-1+rpt1 (2025-04-30) aarch64 GNU/Linux
root@raspberrypi:~# perf test -vvv "Track with sched_switch" |& tail -50
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
cycles event
sched_switch: cpu: 3 prev_tid 208750 next_tid 0
sched_switch: cpu: 2 prev_tid 0 next_tid 195941
sched_switch: cpu: 2 prev_tid 195941 next_tid 208748
sched_switch: cpu: 2 prev_tid 208748 next_tid 0
sched_switch: cpu: 3 prev_tid 0 next_tid 208750
sched_switch: cpu: 3 prev_tid 208750 next_tid 34
sched_switch: cpu: 3 prev_tid 34 next_tid 0
sched_switch: cpu: 0 prev_tid 0 next_tid 208750
sched_switch: cpu: 0 prev_tid 208750 next_tid 21
sched_switch: cpu: 0 prev_tid 21 next_tid 0
sched_switch: cpu: 1 prev_tid 0 next_tid 208750
sched_switch: cpu: 1 prev_tid 208750 next_tid 24
sched_switch: cpu: 1 prev_tid 24 next_tid 0
sched_switch: cpu: 2 prev_tid 0 next_tid 208750
sched_switch: cpu: 2 prev_tid 208750 next_tid 29
sched_switch: cpu: 3 prev_tid 0 next_tid 208750
sched_switch: cpu: 2 prev_tid 29 next_tid 0
sched_switch: cpu: 3 prev_tid 208750 next_tid 34
sched_switch: cpu: 3 prev_tid 34 next_tid 0
sched_switch: cpu: 0 prev_tid 0 next_tid 208750
sched_switch: cpu: 1 prev_tid 0 next_tid 208750
sched_switch: cpu: 2 prev_tid 0 next_tid 208750
sched_switch: cpu: 3 prev_tid 0 next_tid 208750
507 events recorded
---- end(0) ----
109: Track with sched_switch                                         : Ok
root@raspberrypi:~#
