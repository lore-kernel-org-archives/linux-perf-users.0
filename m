Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD8212F14;
	Wed,  2 Oct 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893797; cv=none; b=iCuTiP0dhvS3cS65voE4Tx5Ial0OHqJalZXE6Ra46hgCSnUnUAmwnI63qo8qeFZ6NQ5AXmlgp/mID298GRgu4F3AuAfZzE5IsGtpQcxnzTDcn4oUoAmyCRPw1XGiAngcz0akzXpqlB4QdrrfIggGW7Y1nBzAQArlK2SmjXbpBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893797; c=relaxed/simple;
	bh=oW3A1uipfKdQwVUcodhMm8jzv9QSE358f8lnmmMeKdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvxWU0AnECl0Z/ARREiWyVnY/IZJur1wKGx4lrFfAoeqRIOiew7x+RXOjPe6BNM2BkhgVSFJWdV1FP+CnQ+5xgQkhPFBMD4jSotwLq0aijOV/FI27N/nUlAeIB240xPL7TXNR+NzMbcFlaMeTsnR03zfx9cGkdhjmSdRPPWoX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYqy/MbC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYqy/MbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFABC4CECD;
	Wed,  2 Oct 2024 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727893797;
	bh=oW3A1uipfKdQwVUcodhMm8jzv9QSE358f8lnmmMeKdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYqy/MbCPRfwpGP1dfVrrw2vTieGSu/TyWZ1W3fobkJMKcPFGG0q7nOwl+H3LxPfm
	 yY3K84ALR6qWyDq5MphEZ/tdHnswDj1Ib1oeO+G7Q48apZNsVLjoLs3DzyvP4HNnnq
	 rBQbpLcwYYXg1wfBun/tkKIXb96AjRHqeqXnNigZizoQtibc5/u2epfX2oHwXK6ZwS
	 bRehon91wVIAeK11NeR/lZoySmb1uBHV7WdiF0YBLkI2zgea2yPPAZyrEeItJUD9hC
	 rMT2F4NtCx/Tzr0Gs/nD4OPdm0k2SVAsdauzidE+bG89mywhl1aSowwVnqGo/DCHL0
	 Mfb1g+TtYbRQQ==
Date: Wed, 2 Oct 2024 11:29:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v4)
Message-ID: <Zv2RIr8I04f8dEP2@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <b894eed7-15e0-4ec4-a9d6-07fe86326396@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b894eed7-15e0-4ec4-a9d6-07fe86326396@linaro.org>

On Wed, Oct 02, 2024 at 10:49:36AM +0100, James Clark wrote:
> 
> 
> On 01/10/2024 1:20 am, Namhyung Kim wrote:
> > Hello,
> > 
> > I found perf tools set exclude_guest bit inconsistently.  It used to
> > set the bit but now the default event for perf record doesn't.  So I'm
> > wondering why we want the bit in the first place.
> > 
> > Actually it's not good for PMUs don't support any exclusion like AMD
> > IBS because it disables new features after the exclude_guest due to
> > the missing feature detection logic.
> > 
> > v4 changes)
> > 
> >   * handle EOPNOTSUPP error in compatible way  (Kan)
> >   * drop --exclude-guest option in perf stat
> >   * not to separate exclude_hv fallback
> >   * rename to exclude_GH_default  (Kan)
> >   * drop the RFC from the subject
> > 
> > v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/
> > 
> >   * move exclude_guest fallback to the front
> >   * fix precise_max handling on AMD
> >   * simplify the default event for perf record
> > 
> > v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/
> > 
> >   * update the missing feature detection logic
> >   * separate exclude_hv fallback
> >   * add new fallback for exclude_guest
> > 
> > v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
> > 
> > AFAIK it doesn't matter for the most cases but perf kvm.  If users
> > need to set the bit, they can still use :H modifier.  For vPMU pass-
> > through or Apple M1, it'd add the exclude_guest during the fallback
> > logic.
> > 
> > Also the kernel feature detection logic should be separated from the
> > exclude bit tests since it depends on the PMU implementation rather
> > than the core kernel features.  So I changed it to use a software
> > event for the detection and factor out some hw-specific checks.
> > 
> > The code is available at 'perf/exclude-v4' branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> 
> Looks like you need to allow for :H in the perf stat test on M1 now:
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 5a2ca2bcf94d..77cb95859649 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -161,7 +161,7 @@ test_hybrid() {
>    fi
> 
>    # Run default Perf stat
> -  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles " |
> wc -l)
> +  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles |  cycles:H  " | wc -l)

Ok, what about "u"?  Probably it can be

  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/(uH)*|  cycles(:[uH])* " | wc -l)

> 
>    if [ "$pmus" -ne "$cycles_events" ]
>    then
> 
> Other than that:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks for the review!
Namhyung

> 
> > Namhyung Kim (8):
> >    perf tools: Add fallback for exclude_guest
> >    perf tools: Don't set attr.exclude_guest by default
> >    perf tools: Simplify evsel__add_modifier()
> >    perf tools: Do not set exclude_guest for precise_ip
> >    perf tools: Detect missing kernel features properly
> >    perf tools: Move x86__is_amd_cpu() to util/env.c
> >    perf tools: Check fallback error and order
> >    perf record: Just use "cycles:P" as the default event
> > 
> >   tools/perf/arch/x86/util/Build              |   1 -
> >   tools/perf/arch/x86/util/env.c              |  19 -
> >   tools/perf/arch/x86/util/env.h              |   7 -
> >   tools/perf/arch/x86/util/pmu.c              |   2 +-
> >   tools/perf/builtin-kvm.c                    |   1 +
> >   tools/perf/builtin-record.c                 |   4 +-
> >   tools/perf/builtin-stat.c                   |  18 +-
> >   tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
> >   tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
> >   tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
> >   tools/perf/tests/parse-events.c             |  30 +-
> >   tools/perf/util/env.c                       |  24 ++
> >   tools/perf/util/env.h                       |   4 +
> >   tools/perf/util/evsel.c                     | 394 ++++++++++++++------
> >   tools/perf/util/evsel.h                     |   1 -
> >   tools/perf/util/parse-events.c              |   6 +-
> >   tools/perf/util/util.c                      |  10 +-
> >   tools/perf/util/util.h                      |   3 +
> >   18 files changed, 364 insertions(+), 166 deletions(-)
> >   delete mode 100644 tools/perf/arch/x86/util/env.c
> >   delete mode 100644 tools/perf/arch/x86/util/env.h
> > 
> 
