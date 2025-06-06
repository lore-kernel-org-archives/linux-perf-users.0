Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FC7FD;
	Fri,  6 Jun 2025 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241087; cv=none; b=u/2PF5tGwwkPkiuLXsYApAIFnBJtUwGbUYzNvVYWKYb9eEqCZ+O5admyE7+6Q6/mz2vpnKw7uJ2ZVAj+0TTT+FgtEYKZ4ykobEu6zPs8bQH+QOyqvqJsqwfAV682PUGT7mC83BUs68dtBNoZF8i8hEvY/s/k8xO53LDljYBrO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241087; c=relaxed/simple;
	bh=Gn1rWUDHkaDrYehF6cHvst+Gi3CjiAFZNXYjFomLsSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBNMJ8SxXbuR8hlpYBvTwvWjxjbDfoROUXbFMIVGxXXAyFitS/XUj+UbIjiLXjRPdzjTaRNhuRwiD6G1B7ltaEeE1kkUs3fyVJiTfjv/VodXPaH4zH3fPfImZeEjm/mdb/b5UQcZBpz+LYI9ZP3WtU30EabzIStu+ne9Xg2yZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZVs/pHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZVs/pHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FCBC4CEEB;
	Fri,  6 Jun 2025 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241086;
	bh=Gn1rWUDHkaDrYehF6cHvst+Gi3CjiAFZNXYjFomLsSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZVs/pHS5AV03Tfhbk5cEmzLpZmV1L9FVifmOWW1Ipu68EaVUbcd79hM3Cz0/I8Jp
	 YmAYyV5tcC7hIflJsTmDUrC0dsOaDvIEPNKuoGzvVxaK7T1y06W15mErnGzodP4VQl
	 xOpZe316r1g/mMX9R8QBnUrMKuITZVydcPi+RE/jqATK7/kES4u8iANZSV5/4AdYQp
	 GbzdUG2bzL4wkl8ufDNDfB/J1dxCNqLpNS0xggEZnbffupRU+TcV+tJyxb2z1lVax1
	 pT0ept3hZx8lsLqPwaJZKeNeg/WT2cZT/rX2ilMyoJcN6mKP793VIGY9uh9UScilYO
	 ZTxxK/Wqm0ksA==
Date: Fri, 6 Jun 2025 17:18:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 v6.16] perf test event_uniquifying: Skip test on
 platforms without 'clockticks' events
Message-ID: <aENM_KGb-x14pHRX@x1>
References: <aEHugAPinlWLuTAS@x1>
 <aEMqwmCmbyAlb1Y1@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMqwmCmbyAlb1Y1@google.com>

On Fri, Jun 06, 2025 at 10:52:02AM -0700, Namhyung Kim wrote:
> On Thu, Jun 05, 2025 at 04:22:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > I'll add this to perf-tools for v6.16, please check.
>  
> Plesae see
> 
> https://lore.kernel.org/linux-perf-users/20250521224513.1104129-1-ctshao@google.com/

Oh, great, I'll drop my fix and get that one instead.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > ---
> > 
> > This test assumes the 'clockticks' event is generally available, which
> > isn't the case, for instance, on AMD systems such as:
> > 
> >   root@number:~# grep -m1 "model name" /proc/cpuinfo
> >   model name	: AMD Ryzen 9 9950X3D 16-Core Processor
> >   root@number:~# perf list clockticks
> > 
> >   List of pre-defined events (to be used in -e or -M):
> > 
> >   root@number:~#
> > 
> > So skip this test when 'clockticks' isn't available.
> > 
> > This should be improved to find other events that are available in
> > multiple PMUs so that the intent of the test is achieved in more
> > platforms.
> > 
> > Fixes: cb422594d62066a5 ("perf test: Add stat uniquifying test")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Chun-Tse Shao <ctshao@google.com>
> > Cc: Dr. David Alan Gilbert <linux@treblig.org>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Levi Yun <yeoreum.yun@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Weilin Wang <weilin.wang@intel.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/tests/shell/stat+event_uniquifying.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > index 5ec35c52b7d9651e..20498b6eadb57702 100755
> > --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > @@ -49,6 +49,12 @@ test_event_uniquifying() {
> >      uniquified_event_array+=("${uniquified_event}")
> >    done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
> >  
> > +  if [ ${#uniquified_event_array[@]} -eq 0 ]; then
> > +    echo "'clocktick' event not available on this machine"
> > +    err=2
> > +    return
> > +  fi
> > +
> >    perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
> >    $perf_command
> >  
> > -- 
> > 2.49.0
> > 
