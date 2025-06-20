Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BC17A2FC;
	Fri, 20 Jun 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449638; cv=none; b=O8utRztCMwi0zHLGNEgoyOlEQEwkxZ8OmouA7eRQkKZEyz1ZBEjYYzm9+We37iQ/8HQ1rH/PSc+du+35DQhVzSyREmbtNkHAFFMp7ZbVgKSmNnUOEoNO2dF3JXNuNoZnZ5/AyiRR68gyRbIfuolowGXo1LzXp+kArjax054Ypwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449638; c=relaxed/simple;
	bh=COBUkFhuFis35ybRXyRaNujUUt2C9ZJrCBqHexIgiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/ku2cniiFS9TFivJYN3gwRgBUohWmfUE/kbxcdy/O+e+l6rLUaziUkqhHVkh6fJOQJpe/2I3aROcct9BiFJsbZLCCyj+tjR5uv5nt2zr9ldP0RPEeffRMlAYuMaFFzYSUGmIUbK5myt1m4k/3awstNm4EhO0ozf+Z8+mnl3FRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb9+m0QR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb9+m0QR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13AEC4CEE3;
	Fri, 20 Jun 2025 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750449636;
	bh=COBUkFhuFis35ybRXyRaNujUUt2C9ZJrCBqHexIgiuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sb9+m0QRidHrUgp25xCt+1Se4aSukfeGBs6BECq9ywRa6NQk2JXKDJZtYo6Qy4rag
	 vGX02MaOzj1/Kb/CNSIJC0+1UQkvRkvHEUNBZePMGYo8Au772tf9yN1TPKndibTYl2
	 VRgRTEhnFlg4mTXt3g/Z6kF7E1Oa2aiTpbsMFIR05+jloj8GxIR0kx++zjqKIUTysZ
	 RYLoUOpTB3A9PndvvaSG2Oq0QtMr5iaJwBI+/3CdPQrk3DFKpiSz5ErMkqL29iu4X1
	 hlHp2nTnfaeeJalIJQ/TBtfM7i2bEmR5TQjXA7Gkst6UZTTDLHkW28BG7gZB02SULk
	 WF/zPKvtYo88Q==
Date: Fri, 20 Jun 2025 13:00:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1] perf test: Add basic callgraph test to record testing
Message-ID: <aFW94vQb9cbO4-V0@google.com>
References: <20250619002443.100301-1-irogers@google.com>
 <393e7584-7ca1-407e-bd42-4079e5d8d4e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <393e7584-7ca1-407e-bd42-4079e5d8d4e2@linaro.org>

On Thu, Jun 19, 2025 at 09:24:04AM +0100, James Clark wrote:
> 
> 
> On 19/06/2025 1:24 am, Ian Rogers wrote:
> > Give some basic perf record callgraph coverage.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/shell/record.sh | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index 2022a4f739be..603fa6b79b5d 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
> >   . "${shelldir}"/lib/perf_has_symbol.sh
> >   testsym="test_loop"
> > +testsym2="brstack"
> >   skip_test_missing_symbol ${testsym}
> > +skip_test_missing_symbol ${testsym2}
> >   err=0
> >   perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > @@ -359,6 +361,23 @@ test_precise_max() {
> >     fi
> >   }
> > +test_callgraph() {
> > +  echo "Callgraph test"
> > +  if ! perf record -o "${perfdata}" -g perf test -w brstack
> 
> Looking at 2dac1f089 ("perf test: Fix 'perf script' tests on s390"), it
> looks like this won't work there. Although I'm not sure why the fix wasn't
> to change the default -g mode to dwarf on s390 if fp doesn't work at all.
> That wouldn't fix -e cpu-clock being required though.

Maybe we can add a new 'perf check callchain' subcommand to check the
relevant information and display and/or verify them properly.

Thanks,
Namhyung

