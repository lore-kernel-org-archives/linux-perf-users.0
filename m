Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E5748F;
	Tue, 25 Jun 2024 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291637; cv=none; b=loidJqjGdY2Vt0+yYlAO72Fh24vpO9e8Kx6b/6/FoptMVybibdTrVx13iCter7ZH0jZS1Kv2qxlRSDxFwddhZVfcbX5lfmvSrx9cDilCHmtk1qZgtm4EcbfrvMJMG41cZBrsZuePVtouM8Zk9rCUPtRuOo+CJnfoxQDS5astxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291637; c=relaxed/simple;
	bh=yBjVJClVmj1rBvrYWpgp9Sl3xy6jwZewpiuopf01o1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boUeAemDzLxzla9+xRphilXVqjeHDTU6vOgkm2tldh55yG+8LgPPs1+03b7XTlcG/V7vvv6FGdxJTah1DXWWBhiO8/DbO5u3pL1ojQljeOGzoVAh2O98OpaGMauQyjUbdu1iOFmceUG0m/Oiq/oD1tn767bfUggK83fx1NEPF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgNk1yAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgNk1yAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5CCC4AF07;
	Tue, 25 Jun 2024 05:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719291636;
	bh=yBjVJClVmj1rBvrYWpgp9Sl3xy6jwZewpiuopf01o1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgNk1yAFtOAq0DDV59Hs+tlR0MkMJcc1Qmfemo1xBTlv9EYYm1CYuLFevsXffyH7K
	 I7BPAd6Lo+eQMOOGZTwS58o4Ofjh4W8kzFBqTO3UYj7HuzmcP4UgC5wLWx/BbPfCQW
	 rYy4NN7Q99oINc+1keb+JXRNiK8DXUtTIeJZmfET7R1+/Ku0Eg9kHVC3Ra4lSD7LJ6
	 5IyX/k/JJ/iZMVa1DpiEYQUCtCgyBIcqYq0P5QSltZHllSSq+5ll7mUT0EUnufo2RB
	 AxQYqieDJ47MeVtVFTjHwuthCGYn+kFp9iUiLVGlMGHLsN7ELOEABMfOQe3aP4xuHg
	 mglGiOqrr8/Nw==
Date: Mon, 24 Jun 2024 22:00:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] util: constant -1 with expression of type char and
 allocation failure handling
Message-ID: <ZnpO8TKWSiterMwC@google.com>
References: <20240619183857.4819-2-yskelg@gmail.com>
 <CAP-5=fWm-Tij+vjqOa-18RsiO+1_ytWnKkDvp3vz5hv1O9aMCw@mail.gmail.com>
 <5c1f3b54-da71-47b7-a30c-0011a23195c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c1f3b54-da71-47b7-a30c-0011a23195c8@gmail.com>

Hello,

On Thu, Jun 20, 2024 at 04:10:53AM +0900, Yunseong Kim wrote:
> Hi Ian,
> 
> On 6/20/24 4:03 오전, Ian Rogers wrote:
> > 
> > 
> > On Wed, Jun 19, 2024, 11:39 AM <yskelg@gmail.com
> > <mailto:yskelg@gmail.com>> wrote:
> > 
> >     From: Yunseong Kim <yskelg@gmail.com <mailto:yskelg@gmail.com>>
> > 
> >     This patch resolve this warning.
> > 
> >     tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
> >     -1 with expression of type 'char' is always false
> >      -Werror,-Wtautological-constant-out-of-range-compare
> >      1620 |                 if (c == -1)
> >           |                     ~ ^  ~~
> > 
> >     Add handling on unread_unwind_spec_debug_frame().
> >     This make caller find_proc_info() works well when the allocation
> >     failure.
> > 
> >     Signed-off-by: Yunseong Kim <yskelg@gmail.com <mailto:yskelg@gmail.com>>
> > 
> > 
> > 
> > Both changes look good. Could you make them 2 commits? If so add my: 
> 
> No problem! I'll send it right away.
> 
> Thank you for the code review.
> 
> > Reviewed-by: Ian Rogers <irogers@google.com <mailto:irogers@google.com>>

You forgot to add Ian's Reviewed-by in the next patches.
I can add it to them this time, but please do so next time.

Thanks,
Namhyung

> > 
> > Thanks, 
> > Ian
> > 
> >     ---
> >      tools/perf/util/evsel.c                  | 2 +-
> >      tools/perf/util/unwind-libunwind-local.c | 5 +++++
> >      2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> >     diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >     index 25857894c047..bc603193c477 100644
> >     --- a/tools/perf/util/evsel.c
> >     +++ b/tools/perf/util/evsel.c
> >     @@ -1620,7 +1620,7 @@ static int evsel__read_group(struct evsel
> >     *leader, int cpu_map_idx, int thread)
> > 
> >      static bool read_until_char(struct io *io, char e)
> >      {
> >     -       char c;
> >     +       int c;
> > 
> >             do {
> >                     c = io__get_char(io);
> >     diff --git a/tools/perf/util/unwind-libunwind-local.c
> >     b/tools/perf/util/unwind-libunwind-local.c
> >     index cde267ea3e99..a424eae6d308 100644
> >     --- a/tools/perf/util/unwind-libunwind-local.c
> >     +++ b/tools/perf/util/unwind-libunwind-local.c
> >     @@ -390,6 +390,11 @@ static int read_unwind_spec_debug_frame(struct
> >     dso *dso,
> >                             char *debuglink = malloc(PATH_MAX);
> >                             int ret = 0;
> > 
> >     +                       if (debuglink == NULL) {
> >     +                               pr_err("unwind: Can't read unwind
> >     spec debug frame.\n");
> >     +                               return -ENOMEM;
> >     +                       }
> >     +
> >                             ret = dso__read_binary_type_filename(
> >                                     dso, DSO_BINARY_TYPE__DEBUGLINK,
> >                                     machine->root_dir, debuglink, PATH_MAX);
> >     -- 
> >     2.44.0
> > 
> 
> Warm Regards,
> Yunseong Kim
