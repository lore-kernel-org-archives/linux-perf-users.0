Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010321E3BA;
	Wed, 16 Oct 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054163; cv=none; b=otVrAgWL8jYaK9iLbxxp6vrFPuhiTWHf8aLURqUliEtwoseYgzAxPGSrmxEQ4nNlA2ecGz2FIjcL9W62m0A7TS1366rAdmU7eMQxm26uS7sJ9ZPev1N8UECGwBGzg5l0+UHWkHvDij7zLLmfeormd3xPEoWIvgYbsZFJvLbb678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054163; c=relaxed/simple;
	bh=zZaMeaErdfILwxxiFfer6OZc+6aml4CEcwIkILG7P6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9LVfmGtcMtVqkKtworC+mcskfolV21US0ZPgqkyFMkAmCEgbkrkBhESsqQE/ySdEobO9olhVcAAuvNxkaHhkwfF397sAyz1L1NwJx/D7i248CWL2CMen5v29Tl/6Ra4KSu4rkLwiiAsgY4B6jplB/NTUVhAWji7MDUGhF8LFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hshYHh0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hshYHh0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABBBC4CECF;
	Wed, 16 Oct 2024 04:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729054163;
	bh=zZaMeaErdfILwxxiFfer6OZc+6aml4CEcwIkILG7P6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hshYHh0k2kynF3u8ISBUgegAGrcqfK2mwuET+WTDrkcnC9eg7byJ8/Q5aIoOG1aRi
	 kx6vNNk2n7bIzzg5E8vqhYhvg8kEEEfzqq2uE8TeABtxMvRk56JqGbtIUkSvKMIu7y
	 dhG5MKdzf8O7zkteUBJ37wBOFQsKYr3LdGik0DMZmTv9e9F8E3UA2ohqj9dqh3ghCJ
	 GRU9RIE94tqcn1k37EJsRMURhyn03zzrXZSSGGQV2NhLGWu+UJxrYUMGdCba84u4oS
	 ycfIKjUzQdU8+iOjR9KFAuW+nH/2SOeTCrhxPAi13Q8h4AAZU9CmgoHcP938OjIdN/
	 VLSm+ywhtgCCw==
Date: Tue, 15 Oct 2024 21:49:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 5/8] perf tools: Detect missing kernel features properly
Message-ID: <Zw9F0Ae_sWCVIEvu@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-6-namhyung@kernel.org>
 <97fd7f8c-8593-4018-a1a0-f85e8e4957aa@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97fd7f8c-8593-4018-a1a0-f85e8e4957aa@amd.com>

On Tue, Oct 15, 2024 at 09:49:52AM +0530, Ravi Bangoria wrote:
> > -	} else if (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) {
> > -		if (evsel->pmu == NULL)
> > -			evsel->pmu = evsel__find_pmu(evsel);
> > -
> > -		if (evsel->pmu)
> > -			evsel->pmu->missing_features.exclude_guest = true;
> > -		else {
> > -			/* we cannot find PMU, disable attrs now */
> > -			evsel->core.attr.exclude_host = false;
> > -			evsel->core.attr.exclude_guest = false;
> > -		}
> >  
> > -		if (evsel->exclude_GH) {
> > -			pr_debug2_peo("PMU has no exclude_host/guest support, bailing out\n");
> > -			return false;
> > -		}
> > -		if (!perf_missing_features.exclude_guest) {
> > -			perf_missing_features.exclude_guest = true;
> > -			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > -		}
> 
> Shall we get rid of:
> 
>   perf_missing_features.exclude_guest
>   pmu->missing_features.exclude_guest
> 
> they don't seem to be used anywhere after the patch.

Hmm.. it's my bad.  I think we should keep it for ancient kernels.

Thanks,
Namhyung

