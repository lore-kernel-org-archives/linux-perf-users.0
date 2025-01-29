Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745481917C7;
	Wed, 29 Jan 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188613; cv=none; b=lxzMz1qVKVrQHTHqaxWzkKsJzeElcFHikDdOhcbniKLsV/m/wmf5VuEyDRznWv+aNEy0TfkQ9iumJ2Egse5X0InqfVad5zb8EWjTN09/xTaB0QOTFR0QVg6Q3D/lXgMRfk/DAs2rJLeZeNdXciLjnh+nOl4nV8EB1+UABhLWZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188613; c=relaxed/simple;
	bh=KynBO6SBPmxTKFKxGxSAiRWxnW4naD/h9oswXbTiyDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFYmZbHlFKnCrPSzsZW1lo05U40tdScQCUEB815LUZKgcAwLYzF6KNt9SO1eRKk6Elj2XPeMNgYjRh/Lt0u1PwzZUXPMSFx+5XjauLs04xTNvRxYg8/yDaUFCQt6mbNNxJQFumJFCJa3Dff6X3K2JRxf61RRYMfDzKNc0PLd7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpRRgd0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpRRgd0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58650C4CED1;
	Wed, 29 Jan 2025 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738188612;
	bh=KynBO6SBPmxTKFKxGxSAiRWxnW4naD/h9oswXbTiyDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpRRgd0GMAzjkqMFB6Zk0KICeXTqScxXA0FE+aHyBDTGHpZE7wM+9ZqUi8YyWuZu+
	 pnet5aaDBPOIREhYM78dlXlU4RYW/wMSVjDWKwB3NQe+8ukIcosR+DrmDQI1mdyp2Y
	 ZP1jLR/ItAcxZmJBVZe0o126hrDdZ340YKX6Bq8yxzpoWXR43hLHsYw3MBmz/iSrwu
	 KRrJW85HVZPsj4Ehn20YsOC4fSCEepUdpF9u9Z4RFesj+1WkmdzI3orSbClLo/X4sP
	 +6Dt9bAt96jLhsNmdcGEMXuJ5/aSeEAVJFHVOvLPUT0cvDIgR45p4tmqKVPgoTRUVB
	 WRh06njM9Wf5g==
Date: Wed, 29 Jan 2025 14:10:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Skip Intel TPEBS under hypervisor
Message-ID: <Z5qnQnnkxGjYkTAM@google.com>
References: <20250128043739.256305-1-irogers@google.com>
 <Z5kW69biAERrAFxe@google.com>
 <CAP-5=fUw2v9+Ufai3HQBUB8LcHNDL=88w+J2SZtunn_B4iLGiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUw2v9+Ufai3HQBUB8LcHNDL=88w+J2SZtunn_B4iLGiw@mail.gmail.com>

On Tue, Jan 28, 2025 at 09:59:38AM -0800, Ian Rogers wrote:
> On Tue, Jan 28, 2025 at 9:42 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 08:37:39PM -0800, Ian Rogers wrote:
> > > Intel TPEBS test skips on non-Intel CPUs. On Intel CPUs under a
> > > hypervisor the cache-misses event may not be present. Skip the test
> > > under this condition.
> > >
> > > Refactor the output code to be placed in a file so that on a signal
> > > the file can be dumped. This was necessary to catch the issue above as
> > > the failing perf record command would fail without output.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > v2: Fix lost :R and use :p with record as it is ignored by perf stat.
> > > ---
> > >  .../perf/tests/shell/test_stat_intel_tpebs.sh | 36 +++++++++++--------
> > >  1 file changed, 22 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > index 695dcb93bb5e..a330ecdb7ba5 100755
> > > --- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > @@ -20,31 +20,39 @@ then
> > >    exit 2
> > >  fi
> > >
> > > +stat_output=$(mktemp /tmp/__perf_stat_tpebs_output.XXXXX)
> > > +
> > >  cleanup() {
> > > +  rm -rf "${stat_output}"
> > >    trap - EXIT TERM INT
> > >  }
> > >
> > >  trap_cleanup() {
> > >    echo "Unexpected signal in ${FUNCNAME[1]}"
> > > +  cat "${stat_output}"
> > >    cleanup
> > >    exit 1
> > >  }
> > >  trap trap_cleanup EXIT TERM INT
> > >
> > > -# Use this event for testing because it should exist in all platforms
> > > -event=cache-misses:R
> > > -
> > > -# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
> > > -alt_name=/cache-misses/R
> > > +# Event to be used in tests
> > > +event=cache-misses
> > >
> > > -# Without this cmd option, default value or zero is returned
> > > -#echo "Testing without --record-tpebs"
> > > -#result=$(perf stat -e "$event" true 2>&1)
> > > -#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
> > > +if ! perf record -e "${event}:p" -a -o /dev/null sleep 0.01 > "${stat_output}" 2>&1
> >
> > Shouldn't it simply be
> >
> >   if ! perf list hw | grep -q cache-misses
> 
> No, because that would succeed even if precise events weren't supported.

Oh I see.

> 
> > ?  Doesn't it work on hybrid?
> 
> Untested, but I don't see a difference between grepping an event from
> a file to using a match in a bash line. Neither specify a PMU so it is
> unclear to me why you'd think this would break.

No specific reason.  I thought checking `perf list` would be more
intuitive and then started to think there should be a reason.

Thanks,
Namhyung

