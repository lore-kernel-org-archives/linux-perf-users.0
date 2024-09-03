Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F6191F62;
	Tue,  3 Sep 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388445; cv=none; b=PpAsqqEbcwKWCzMLQx9fFT9emkaOH+zOA9pz41yMUgUpC9pIhmR6mNANRuNHblbtowoShF+2JoYo38oiizUf/UhQwrLg0agGym9MLDV87J+sZUKWnfcS9dseYqITTJYAUZClizdPMCB2wET8cxIwB7rSWwOP7xSGAmFzSidlbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388445; c=relaxed/simple;
	bh=73gMoltqAGaC0XHtIkA20MKp2ifgz2UtxG2xuBhLKN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H32oMdbQ40bRXCW+fLkvgkoWipbi2FjWseO/C9V0K7msIa8lOwi7ZHEkkw8y/3j7L5xJ7+VUKLZmWWxOk3eriR9lZcUjG/ExQAz6UJ9osqtoghkWbX7FX+RWgoloGrj8Il2Q31tQykLl+vuf+Zbj/fODNDp18EXWMmElt3AwHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHLcQLZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHLcQLZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BFFC4CEC5;
	Tue,  3 Sep 2024 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388445;
	bh=73gMoltqAGaC0XHtIkA20MKp2ifgz2UtxG2xuBhLKN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHLcQLZkvVxb3qGoy6WO/RYu2gP7ftULG67JiNt8BPBZTq2msrG5QLKlsJMkBCdSs
	 wNeoUEzRCD3xlR/GZnorVVbbUmox2vlFYJqKo9Da9h+Sl60K2zZcj0kzBsGRqGD5o5
	 ISypRhsEJE31uwLhQBovhZGA8i/VfAEfO7kOLq9OBiOfom2UEptpKoxMAbWTR4Mzk8
	 gsTVy3/ScqgNRmIKg6viY2PRFuE5DLFJMFKbmv0Q9hPAKpifMHfIxB7+D+zOocstAm
	 /RqbGgANm4YTHm1UHr2S4huTTd3G1H7Tgke6a87HA+FA7i+sSOI0iCAjkJLTDPOqoZ
	 I0TyurJrvIxmg==
Date: Tue, 3 Sep 2024 15:34:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Anne Macedo <retpolanne@posteo.net>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/13] perf inject: Fix build ID injection
Message-ID: <ZtdWmLlZp9HO8wK-@x1>
References: <20240817064442.2152089-1-irogers@google.com>
 <20240817064442.2152089-11-irogers@google.com>
 <ZsOIkMEf3l6e-mdX@x1>
 <CAP-5=fVqkR7Xd8GXw31MPNSsfvkiPVavQjQSieWUpKasHcLVQQ@mail.gmail.com>
 <CAP-5=fX9bmzn51DPHoeGVMbY=LLux2_JKGwFHNek7Je1h8qPBg@mail.gmail.com>
 <ZtYDQVrVIk5zWK16@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtYDQVrVIk5zWK16@google.com>

On Mon, Sep 02, 2024 at 11:26:09AM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Wed, Aug 28, 2024 at 08:15:10AM -0700, Ian Rogers wrote:
> > On Mon, Aug 19, 2024 at 12:54 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 11:01 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Fri, Aug 16, 2024 at 11:44:39PM -0700, Ian Rogers wrote:
> > > > > Build ID injection wasn't inserting a sample ID and aligning events to
> > > > > 64 bytes rather than 8. No sample ID means events are unordered and
> > > > > two different build_id events for the same path, as happens when a
> > > > > file is replaced, can't be differentiated.
> > > > >
> > > > > Add in sample ID insertion for the build_id events alongside some
> > > > > refactoring. The refactoring better aligns the function arguments for
> > > > > different use cases, such as synthesizing build_id events without
> > > > > needing to have a dso. The misc bits are explicitly passed as with
> > > > > callchains the maps/dsos may span user and kernel land, so using
> > > > > sample->cpumode isn't good enough.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/builtin-inject.c        | 170 ++++++++++++++++++++++-------
> > > > >  tools/perf/util/build-id.c         |   6 +-
> > > > >  tools/perf/util/synthetic-events.c |  44 ++++++--
> > > > >  tools/perf/util/synthetic-events.h |  10 +-
> > > > >  4 files changed, 175 insertions(+), 55 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > > > > index a7c859db2e15..84a4bdb5cb0a 100644
> > > > > --- a/tools/perf/builtin-inject.c
> > > > > +++ b/tools/perf/builtin-inject.c
> > > > > @@ -131,6 +131,7 @@ struct perf_inject {
> > > > >       struct perf_file_section secs[HEADER_FEAT_BITS];
> > > > >       struct guest_session    guest_session;
> > > > >       struct strlist          *known_build_ids;
> > > > > +     const struct evsel      *mmap_evsel;
> > > > >  };
> > > > >
> > > > >  struct event_entry {
> > > > > @@ -139,8 +140,13 @@ struct event_entry {
> > > > >       union perf_event event[];
> > > > >  };
> > > > >
> > > > > -static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
> > > > > -                             struct machine *machine, u8 cpumode, u32 flags);
> > > > > +static int dso__inject_build_id(const struct perf_tool *tool,
> > > > > +                             struct perf_sample *sample,
> > > > > +                             struct machine *machine,
> > > > > +                             const struct evsel *evsel,
> > > > > +                             __u16 misc,
> > > > > +                             const char *filename,
> > > > > +                             struct dso *dso, u32 flags);
> > > >
> > > > So in the end the dso was needed, the name of the function remains
> > > > dso__something(), so first arg would be a 'struct dso *'
> > > >
> > > > I processed the patches up to 9/13, so that they can get tested now.
> > >
> > > Maybe we should rename the function? We can get the build ID from
> > > mmap2 events now, not just stored away in the dso by build_id events.
> > > Reordering the arguments isn't a problem, I was just aiming for
> > > consistency between the caller, perf_event__synthesize_build_id and
> > > eventually the call to process that all take the arguments in this
> > > order.
> > 
> > Arnaldo, did you have any more thoughts on this?
> 
> I'm ok to rename it to tool__inject_build_id().

I thought I had this processed, but I stopped at this patch, yeah,
please rebase on top of perf-tools-next with the suggested rename.

- Arnaldo
