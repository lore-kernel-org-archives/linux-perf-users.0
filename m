Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A82EEE99;
	Mon, 14 Sep 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350291; cv=none; b=SWUL+Hk7Xx7q0xQ7ruK+y2Mk+zgqAoheV15BKzFYmrBbiHeB8YvwUVadwbjt/0KfeRP3OZR2pa6mIQ+bxdWYdDIa+oTAdjdVDDL0T1YHIAaL++vb0QPh07IijNxWVlFT+5RegGJCcI4u/oc3dC0OHpKW0k/uhxYS0wG57i143RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350291; c=relaxed/simple;
	bh=UgIE77EUCLWR7KplPICHV37zWFPhAbyUEsQtxdv/6NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp8CtiRlrwEaceuUSc5YMJE2GeyBeeHcS9eRS8t2eAw36r7MoQWmw1OlAtVix4LwfklgIFhJm5KCPzH1TCbW5378IDVf3rlof7ko9tZA7s70FmICgdE1AO5bmz1Li8E50Rwjrlu9FfZRwPqpqH9BzgplamBoVP5yJITJ5VJdl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJUwgmCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJUwgmCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287A71F000FF;
	Mon, 14 Sep 2026 01:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350288;
	bh=6fxjQEb5lvfJOlN4SVIoiK5r3tnFpoua9j0O+lrl87A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YJUwgmCxKyxN7FBkL3KSbIzzcv4Yu3sOaCshmsldc6n6SQTtB9VMcreXFKf+shx1H
	 7N6DmI15C7BH837aKJOWbiv+FpEmPJE/S/wwBOGFrDA6J/uhtPqA+Klp19rL+e0MJd
	 2931aCfawGB4ud1BAlcyaLNlZ5xLRtols+uA+pG1Q9oXDqVstrfd8YNnRvYCFmK59e
	 2zX9I9Z0bKevTfGKYJZOG5hTIKsmNnMf2Do21VXfysouewyOTiiUUsiWQZIkW/KjUY
	 X13eY3fNA09byG3l79JwGfH1NV3wZEujDrFLVaDdh3m1/HN+ZlRwshSkac5pe3L9Zw
	 Zx6sWa34P1Qlg==
Date: Sun, 13 Sep 2026 22:44:43 -0300
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
Message-ID: <aqdRi7v_A03mY1tU@x2>
References: <20260602181349.3969429-1-ctshao@google.com>
 <20260602181349.3969429-2-ctshao@google.com>
 <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>
 <aihLa9ezNXXZm9mC@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aihLa9ezNXXZm9mC@x1>

On Tue, Jun 09, 2026 at 02:20:43PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 09, 2026 at 08:58:03AM -0700, Ian Rogers wrote:
> > On Tue, Jun 2, 2026 at 11:13 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > >
> > > It parses fdinfo with PMU type, comparing with the event which failed to
> > > open, and report the processes causing EBUSY error.
> > >
> > > Testing cycles and intel_pt//
> > >
> > >   $ ./perf stat -e cycles &
> > >   [1] 55569
> > >   $ ./perf stat -e intel_pt// &
> > >   [2] 55683
> > >   $ ./perf stat -e intel_pt//
> > >   Error:
> > >   The PMU intel_pt counters are busy and in use by another process.
> > >   Possible processes:
> > >   55683 ./perf stat -e intel_pt//
> > >
> > > Only perf with intel_pt was reported.
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > 
> > Arnaldo, as the kernel piece of this landed (thanks Peter!) could we
> > land the tool part too?
> 
> Thanks for pointing this out to me, I'll do some housekeeping and
> process this.

I think this hasn't landed, I tried to find the userland part of v8 but
didn't manage to, can you please point it to me?

- Arnaldo
