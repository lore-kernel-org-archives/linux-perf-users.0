Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837A30DECA;
	Tue, 13 Jan 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336430; cv=none; b=junhjbVbqYS1X6AB72pDWvYb0hldyK6vfql3Za/4i9TIp3GzBERXt72Mp2xrFwNbEw1ePFYXV4AGq+qIWF8dNS7zBW4ZW1tk3ThoUuGCslQe7tCzE5dRTsrzZfQp7YzaWasxJLiRHKj8X01COvFznXU+GkkrQMPXebkV7Ci3yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336430; c=relaxed/simple;
	bh=3aT+kpbubWgFMw/ZgtUdcRfDKHUmGwhJqnka9NbulE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO9qX6Q/gGkjpNOiEM7XYQ44Cye2aaqSdZBE5GsxfcIyyrHjJnsy0aucxg/vHaeZBqGJZkI4KAUgbP3C4knRafL9WN1PSQ6Rp7ZruciRq2Itz+Vonivz4E4ka6RtDdjZPEoHztfH8tZU6a7gVNF0KA1qDX49qAnneVlQPaBK3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABZmwDqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABZmwDqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926DAC19423;
	Tue, 13 Jan 2026 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768336428;
	bh=3aT+kpbubWgFMw/ZgtUdcRfDKHUmGwhJqnka9NbulE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABZmwDqtugglqef1nApU9lj+aiPMWVJmIg+45UsVxdk/BLz7LQc6QzG1j1D9xfo/L
	 F64sPGoQtX3vpxcZlaR0Osv5NrXs7cY9vr74kPs4wCJ/6reVWUZnSkXd2y9H0sSNZT
	 AebcN6veyGc3UPDQkeZkG+hHogIi3ot870muUXwMMfl1to6l+PDMirurjDWkE4FMEs
	 0i/TLqlcueOiZFpXjGxGbVbI1TY8ZLiIqcU+li09LXpPyWYoaHQLBPdCwgjLCCDqiB
	 HawcvtMe5M8NNKJlRPc1RNj4BtO7259ovBnDCzXGoe+apfTqto1dUGItiZwm3Qx37V
	 z9XTbuWKhuYsQ==
Date: Tue, 13 Jan 2026 17:33:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Dump callchain context marker names
Message-ID: <aWasKG0TD5dnpDSK@x1>
References: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>
 <CAP-5=fUmbpDb0S33qb82Wvh2PjSGOWYYFi-70FZSWD6L7TuwLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUmbpDb0S33qb82Wvh2PjSGOWYYFi-70FZSWD6L7TuwLw@mail.gmail.com>

On Fri, Jan 02, 2026 at 04:18:37AM -0800, Ian Rogers wrote:
> On Fri, Jan 2, 2026 at 4:16 AM James Clark <james.clark@linaro.org> wrote:
> >
> > These are hard to interpret in the raw output because they are printed
> > as hex but are defined in perf_event.h as decimal. Make it much easier
> > to read the raw callchains by just printing their names.
> >
> > For example:
> >
> >   $ perf report -D
> >
> >   1798195372321 0x4638 [0xb0]: PERF_RECORD_SAMPLE(IP, 0x4002): 44922/44922: 0x7c8046dd3400 period: 120218 addr: 0
> >   ... FP chain: nr:12
> >   .....  0: fffffffffffffe00 (PERF_CONTEXT_USER)
> >   .....  1: 00007c8046dd3400
> >   .....  2: 00007c8046db86d3
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
