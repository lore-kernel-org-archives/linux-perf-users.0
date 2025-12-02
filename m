Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266F220F47;
	Tue,  2 Dec 2025 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719982; cv=none; b=mVWpZpT5Ealpcotxnj8yGkyMmCBzK4HYxmU9OgoUSVbk0OTrguplDl7LPF+80T3biFaOQyHqTui0WsIAVYjIfVUDQ958pfFmEoYC+AS+oBgJ52JNljHgf5xino1YvCjqvWhej0mMfhWk7MwLnQwTIpkAbI1JKVWPdh4jT+e3b6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719982; c=relaxed/simple;
	bh=+mkHOBRqjlZVMSYlPmydwxTdYu3/WXOspt4LmdyfJZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us1hAo6zCOQ+tWVh/LL1J7G8GN1gtZuUnu7nCvNQjmpTxZxlZLZIn2Rv+ivSBUXwCpyLi+qsbuvZog2d7PP9sVOF8vBa4LFMiQu54fp0riZaWdamp823FN3S5nnsWH1fYYo3+YfTWLV/ewFFVG7BSlRJ3dRLYxvsJdrCh6fU+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVTWQ2SY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVTWQ2SY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3EBC4CEF1;
	Tue,  2 Dec 2025 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719981;
	bh=+mkHOBRqjlZVMSYlPmydwxTdYu3/WXOspt4LmdyfJZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVTWQ2SYUxYLlTlGkk6/scArz6W2rQqgcwb0FS6r8NMeFZd3lZp2Leqac1X6jdtyU
	 29FEbeiun7zCXhP7Uvh3TZsrCi9CpHvuVssRTvRvPRIuJENtBskPr2eFbjfCxtiCpv
	 dinT5dZ7pGtAdeE5Q+i5NYIsF3jpEnuMVaW1kWCM4bqq+k5BweRv+64ANfPVge93hM
	 oM3/Wa+napPubWx+MtGSPJsgo5VrWyU38j/jrJg6AJaXieHHnm9lK0SD/ajkrlS/sa
	 PfWwSatSqYxwauTuHiNFrG9Uu4gnV/FFO3m9MmcyjiK74IowIT8EBSCa1eDljwpC7Z
	 NLjPnAfPeo98w==
Date: Tue, 2 Dec 2025 15:59:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Fix hybrid testing of event fallback test
Message-ID: <aS99alDNvym9q1Ir@google.com>
References: <20251201231136.293248-1-irogers@google.com>
 <aS9dDvCWO9BdMmna@google.com>
 <CAP-5=fX8MgFXtYtxtYpDsVb5SHjxELPCRNcySJcNVEtC1pOieA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX8MgFXtYtxtYpDsVb5SHjxELPCRNcySJcNVEtC1pOieA@mail.gmail.com>

On Tue, Dec 02, 2025 at 03:05:12PM -0800, Ian Rogers wrote:
> On Tue, Dec 2, 2025 at 1:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Dec 01, 2025 at 03:11:36PM -0800, Ian Rogers wrote:
> > > The mem-loads-aux event exists on hybrid systems but the "cpu" PMU
> > > does not. This causes an event parsing error which erroneously makes
> > > the test look like it is failing. Avoid naming the PMU to avoid
> > > this. Rather than cleaning up perf.data in the directory the test is
> > > run, explicitly send the 'perf record' output to /dev/null and avoid
> > > any cleanup scripts.
> > >
> > > Fixes: fc9c17b22352 ("perf test: Add a perf event fallback test")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  .../tests/shell/test_event_open_fallback.sh   | 19 ++-----------------
> > >  1 file changed, 2 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
> > > index 9c411153c01b..9420a7557c13 100755
> > > --- a/tools/perf/tests/shell/test_event_open_fallback.sh
> > > +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> > > @@ -6,24 +6,9 @@ skip_cnt=0
> > >  ok_cnt=0
> > >  err_cnt=0
> > >
> > > -cleanup()
> > > -{
> > > -     rm -f perf.data
> > > -     rm -f perf.data.old
> > > -     trap - EXIT TERM INT
> > > -}
> > > -
> > > -trap_cleanup()
> > > -{
> > > -     cleanup
> > > -     exit 1
> > > -}
> > > -
> > > -trap trap_cleanup EXIT TERM INT
> > > -
> > >  perf_record()
> > >  {
> > > -     perf record "$@" -- true 1>/dev/null 2>&1
> > > +     perf record -o /dev/null "$@" -- true 1>/dev/null 2>&1
> > >  }
> > >
> > >  test_decrease_precise_ip()
> > > @@ -49,7 +34,7 @@ test_decrease_precise_ip_complicated()
> > >
> > >       perf list pmu | grep -q 'mem-loads-aux' || return 2
> > >
> > > -     if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
> > > +     if ! perf_record -e '{mem-loads-aux:S,mem-loads:PS}'; then
> >
> > I think we need to either keep the trap handler or convert all perf
> > record commands including this to use -o /dev/null.
> 
> So all the perf record commands use "-o /dev/null" as perf record is
> always run using the "perf_record" function (ie the one updated here)
> :-)

Oh.. I missed that.  LGTM!

Thanks,
Namhyung

> >
> >
> > >               return 1
> > >       fi
> > >       return 0
> > > --
> > > 2.52.0.158.g65b55ccf14-goog
> > >
