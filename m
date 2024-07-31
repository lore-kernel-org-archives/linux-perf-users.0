Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21819412E;
	Wed, 31 Jul 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431109; cv=none; b=DeGJKRbsHm036xhfX7WPeQK9FGk8i3HB7JjolZhtKza5M1a8695ABLDTPfmTDNIhNyl4bucAOaY9vxCLQQuf38Fd4F63k1LhoDP3YxidNEhgtTogtflIpGS2MG7WCIk/A2FZAPL8SVyKlfOri6Y7FM36EUq2rW+xwc372k3UzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431109; c=relaxed/simple;
	bh=Bb5kar3EPq92Yio8XCLGLpM1QcIGYB4KLVpPWavh//I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwCFKYcSqAcTVCICXvgMUuDzc+HxD/bwY8DH+cgAUFsBVy/O1C9R6OOiJHSEo12cfbNlznmoeyxaKu5Mh7oLl3c087GLFFQQcbuZxX7Uyr42eTU1aLvAgv6xH2tBL7GOkFTjLwLPWtYDtTNIj2pFVyn0F41wr6Z6PJSjzOcvMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6h12J2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6h12J2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092E7C116B1;
	Wed, 31 Jul 2024 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722431108;
	bh=Bb5kar3EPq92Yio8XCLGLpM1QcIGYB4KLVpPWavh//I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6h12J2q8d8EH1hi4OpXZfF2MrRe3hQmeu8uHByJpF63KBi+VHzs/8YrYL7ANFxcg
	 qC7jEU4yVSG6rOklHusaC3WDL4R7MYoAT1HT/ywM3JyEwtcpUojCsC9vh8TaYCdC/C
	 4IowJIuBPNY7S2BjY1wXZQWr83l95jrmJXZJu/Pob9fMixX6R4D+Dsm4MVEUgjlVx0
	 hVWSgl1Qu/14JTYicEY3y+0Jv6cf7zn2Y8APff6GkI1tl9KmvlBOIKieqKh1pzu0yV
	 vjvyJ6p1tc2t8KA4gmwWkDF81H9LfV1r9L1ed2mThKU9R8t5xCDiKVSw9A+CTQ29iT
	 4fTtuk7AKawkQ==
Date: Wed, 31 Jul 2024 10:05:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	philip.li@intel.com, oliver.sang@intel.com,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 0/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <Zqo2gfaQ96WkrZMH@x1>
References: <20240730191744.3097329-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730191744.3097329-1-irogers@google.com>

On Tue, Jul 30, 2024 at 12:17:42PM -0700, Ian Rogers wrote:
> Rebase of v2 patch set on tmp.perf-tools-next.
> https://lore.kernel.org/lkml/20240525013021.436430-1-irogers@google.com/
> 
> Review was delayed because of an Intel automatic testing issue,
> confirmed not an issue here:
> https://lore.kernel.org/lkml/ZqhGNm+WDcsNx05e@xsang-OptiPlex-9020/

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
> v3: Rebase and add John Garry's reviewed-by tag.
> v2: Add not found constant.
 
> Ian Rogers (2):
>   perf jevents: Use name for special find value
>   perf jevents: Autogenerate empty-pmu-events.c
> 
>  tools/perf/Makefile.perf                 |   2 +
>  tools/perf/pmu-events/Build              |  12 +-
>  tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++---------
>  tools/perf/pmu-events/jevents.py         |  12 +-
>  tools/perf/pmu-events/pmu-events.h       |   9 +
>  5 files changed, 574 insertions(+), 355 deletions(-)
> 
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
