Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AFA4315F;
	Wed, 23 Apr 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415204; cv=none; b=bf2BLBR0mqm4DqSSgOtvxUBBB5UiZhOq7MHFPKXVJxS1v2py2D9D3Guef5Pr2B3cxMjDndixb04k8RPh1PEM4g44diN0WVwRn/BLzgdcgy7H+crDZmLeuEpU0MtEVFpbH8/3n4+9+j/1EGAniEwRewJqwwWs5UaolzCAvEyDehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415204; c=relaxed/simple;
	bh=VhWoNd6QDgqzPaFDzKXzz8wt8AdcVP4ZGz7YZmxeeKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jsi10suw9j2pVs/L36a0E1g1NOWc9C/sX/a60xK07lvODn6SbFOTW7EBPmogjowkMAxY1lQfKcBwGQYfaC5FIgDffqnZac36FY879arlt45/qX72z6LuPGH5ezijMXPYBRniFhijFy+8udk3EFWkd6+iUrtZmLg20L4tptQFtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhv9eXCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhv9eXCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1DDC4CEE2;
	Wed, 23 Apr 2025 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745415203;
	bh=VhWoNd6QDgqzPaFDzKXzz8wt8AdcVP4ZGz7YZmxeeKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lhv9eXCAUwFGvkecgZ/eXjJ8bnIqiwFBvuGfgk2GFw95jkXdOvlGDcGExkfZMNYsz
	 MWvWRyDJ5sWBaqUw0eBxIUgEt/9jMR2rL+AeQlkRyCzRuQPnVGxWYtG0PERSHWEpXC
	 KpDfGrpzfjnp6HQ2ovpMeUQwRLs1gL9hRnjqlycOf2g0/vobi4OezLLds31Ai8uk2b
	 WPhE+7tUHrcir6ybEQzRfYnmxq3DmYxw3zrxf3nkSkO2MkM1W8SnPmWQEhK9GqBbzp
	 R1nLlXMtPC5TSNrYKI6U9Nw1A1Px1mrAbkU3uMgVcYIAHTA/E658gjztNdVOkMy2s9
	 9fZsDIFNEnNPw==
Date: Wed, 23 Apr 2025 10:33:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH v5 00/16] Intel TPEBS min/max/mean/last support
Message-ID: <aAjsIGKS6e3MfI60@x1>
References: <20250414174134.3095492-1-irogers@google.com>
 <cfa0aa31-3fe7-4174-8cce-89e8aadbcd07@linux.intel.com>
 <CAP-5=fVo_yGgEwndavWaNAQRg=1MR121PQ-KwOW0HsUWGBLLnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVo_yGgEwndavWaNAQRg=1MR121PQ-KwOW0HsUWGBLLnA@mail.gmail.com>

On Mon, Apr 21, 2025 at 11:13:49AM -0700, Ian Rogers wrote:
> On Mon, Apr 14, 2025 at 12:08 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > On 2025-04-14 1:41 p.m., Ian Rogers wrote:
> > > Ian Rogers (16):
> > >   perf intel-tpebs: Cleanup header
> > >   perf intel-tpebs: Simplify tpebs_cmd
> > >   perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
> > >   perf intel-tpebs: Separate evsel__tpebs_prepare out of
> > >     evsel__tpebs_open
> > >   perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
> > >   perf intel-tpebs: Reduce scope of tpebs_events_size
> > >   perf intel-tpebs: Inline get_perf_record_args
> > >   perf intel-tpebs: Ensure events are opened, factor out finding
> > >   perf intel-tpebs: Refactor tpebs_results list
> > >   perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
> > >   perf intel-tpebs: Add mutex for tpebs_results
> > >   perf intel-tpebs: Don't close record on read
> > >   perf intel-tpebs: Use stats for retirement latency statistics
> > >   perf stat: Add mean, min, max and last --tpebs-mode options
> > >   perf pmu-events: Add retirement latency to JSON events inside of perf
> > >   perf record: Retirement latency cleanup in evsel__config

> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
 
> Ping.
 
> It would be great if we could land:
> https://lore.kernel.org/lkml/CAP-5=fWxuKHLZJjd2NVWjA7ktCX6X3yQBsH2kh+eTTaNcSqbTg@mail.gmail.com/T/#m1bba00c3a699397b54e1a77da9b9ff392b435e4d
> and then land this series.

Applied that and then this one,

Thanks,

- Arnaldo
