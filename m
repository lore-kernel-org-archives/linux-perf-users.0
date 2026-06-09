Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA54748B38A;
	Tue,  9 Jun 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025648; cv=none; b=H9kKXd5dPvdE4ozR9dnhDNGyBgc4fyeMb8W1ymLnHr+MeX9lzxTrUgMAhTNXx1Yl/2cneE6sMmuk2XZABEbQRu+RuXB6MliHEvJSwYO9D8Y9hPmPrKqRJ/B3vCIKe4KllHLiVgzFpH1LdesNFbE+WQd8CxqoQ5otpyW55uTLbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025648; c=relaxed/simple;
	bh=ImVPaj0F4qTX/liHNYXOGJ0NqrIRrly9piARqYYgYm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzIlGLkj1gQ0Zsarm191S8yeenAReldR/URvQgLNMoRZwxaBCjlIs1wa3p/V0RTcCVsT7A9WSfzY6h393/FoQ057aYLkZk5VIVEjNAYeBapqEAigfP3NKomvX6UXmcrbcYWX309g7TtcqAJUtcxMkCSYHZVoKWupVdU884DUReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQzEpveP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQzEpveP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89831F00898;
	Tue,  9 Jun 2026 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781025646;
	bh=Vf7rppeqg4XAWT3NFOVhieS+Y07eza3pnTrSE7q2dj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQzEpvePvF6HZV1fMU21YY2FpA2MGrgdB1au7SB8/2Azn33qjhYEJsVuL/xTAHBYv
	 5SkJM6k4lzYnxt4Hiwqhj7YeqbsoY2dreVCBkDVYcEFm+avEL9SnCSAXfb2O0Ek9Ci
	 JXrYks2xnf13h+q8FqkBPWzo7/lxHjquMxf/WJvBE7gD5jvsZqrSS1Xo+GC0DiRS8q
	 lote1d2vr3U2sBEusHpUh16V5Be/AE0wU8HF2A9GmUOWtknrgd2M/q68luURl/NYJb
	 p+TgQ+rwYo19uw6YoDfXgKvbkJPP8AqK0pBT/1UKNeWus9/wXQ2f91cs6JZzCERurK
	 T2q1ofCbADVxg==
Date: Tue, 9 Jun 2026 14:20:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 2/2] perf evsel: Find process with busy PMUs for EBUSY
Message-ID: <aihLa9ezNXXZm9mC@x1>
References: <20260602181349.3969429-1-ctshao@google.com>
 <20260602181349.3969429-2-ctshao@google.com>
 <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>

On Tue, Jun 09, 2026 at 08:58:03AM -0700, Ian Rogers wrote:
> On Tue, Jun 2, 2026 at 11:13 AM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > It parses fdinfo with PMU type, comparing with the event which failed to
> > open, and report the processes causing EBUSY error.
> >
> > Testing cycles and intel_pt//
> >
> >   $ ./perf stat -e cycles &
> >   [1] 55569
> >   $ ./perf stat -e intel_pt// &
> >   [2] 55683
> >   $ ./perf stat -e intel_pt//
> >   Error:
> >   The PMU intel_pt counters are busy and in use by another process.
> >   Possible processes:
> >   55683 ./perf stat -e intel_pt//
> >
> > Only perf with intel_pt was reported.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> 
> Arnaldo, as the kernel piece of this landed (thanks Peter!) could we
> land the tool part too?

Thanks for pointing this out to me, I'll do some housekeeping and
process this.

- Arnaldo
