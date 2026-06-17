Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4683B585D;
	Wed, 17 Jun 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736499; cv=none; b=CPzHRNdkCRgA84/kOel5RjaKZ7ezvjx96wsfK8lS5govyU4b2W3zvbHuHc5FDBRAP1t44OZqh9CJgH0XvSdn4hTbyTmF0vAZHtaf0zNtQ2odtS3bjq+NK9an/0UhMJgDPgTb0qf4QQokkf79eNkMH7xNiPWGyFeLAXfoeqqGr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736499; c=relaxed/simple;
	bh=wP1BX6btHmGJ2M+D73SqoidcRdNUgpSBPt1oZZ9VOTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMTmLc3/N6/nhJUfXTLZUPXZC/C+kNrK1D7icOPv+CRE1XvuUXwMQGJ2euu6DmkgrMM4QdAjcgWt8rlO+tlRQ1SRcG1RvBWfUHhpxULIEfplvoBkuZmJ2giLpilMaHzfwM++lcU2dz8u4lFMTHrTbRyfiBtH4LKMyRO1pEbPhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWvSZoms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWvSZoms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0131F00A3D;
	Wed, 17 Jun 2026 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781736497;
	bh=s+1qK/vw98ssfjYHSAwKJj3wSCZrF9mroy4dK4D3HEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWvSZoms2Jpm8LcO+qmgt3NIUMlaRcZfe6ozuVLm7H5P6T7A2ExIIj44tJV/EgNUd
	 tAFCmMCk+fmK5ADrhR/tA6RHXw+kZWMIsqaemczimUmXJhHUKrBYUCTndIfeUJQVdI
	 nGZlGtFw5oNrDYWkza9YFxFJ6ufqIylOCQzYguRO6qLQF1InmOiJwsaznKhh7+zDt0
	 xdL1Q92Co9bbIVKMXjzE6JFe6QAd+I66jvdgB7A9TSz6bfmKnTbYKQeM/6MXIHlgQ1
	 n7A4mGpH0BFYO2MfmglmcEB/U1ZQ38tMJrmVpvssPYBXU+FzJbqCZPS+f/AM2IzCzs
	 L1G0wFyDnV03Q==
Date: Wed, 17 Jun 2026 15:48:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCHES v3 0/2] perf tools: Add cached probe type detection for
 evsel
Message-ID: <ajMkLzJpXzyeqQh4@google.com>
References: <20260616182546.8892-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616182546.8892-1-acme@kernel.org>

On Tue, Jun 16, 2026 at 03:25:44PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> Checking whether an evsel is a kprobe or uprobe currently requires
> walking the PMU list via evsel__find_pmu() on every call.  This is
> wasteful when the same evsel is checked repeatedly in hot paths like
> trace__fprintf_tp_fields().
> 
> Patch 1 adds evsel__is_kprobe(), evsel__is_uprobe(), and
> evsel__is_probe() helpers that resolve the probe type on first call
> and cache the result in a 3-bit field that fits in existing struct
> padding.
> 
> Detection covers both PMU-based probes (kprobe/uprobe PMU, detected
> by PMU name) and ftrace-based dynamic probes (kprobes/uprobes/fprobes
> created via tracefs, which report as PMU "tracepoint").  Ftrace probes
> are detected by the __probe_ip field that the kernel adds to all
> dynamic probe formats — this is authoritative regardless of the
> group/system name the user chose.
> 
> Patch 2 is the first user: it guards the __probe_ip field name
> comparison in perf trace with evsel__is_probe(), so the strcmp is
> skipped entirely for the common case of non-probe tracepoint events.
> 
> Patch 3 adds inline stubs for evsel__field() and evsel__common_field()
> when libtraceevent is absent.  These were previously declared
> unconditionally but defined only inside #ifdef HAVE_LIBTRACEEVENT,
> which was harmless until patch 1 added a call from always-compiled
> code in evsel.c.
> 
> Build-tested with gcc and clang.
> 
> Changes in v3:
>   - Add patch 3: no-libtraceevent stubs for evsel__field() and
>     evsel__common_field().  Without this, NO_LIBTRACEEVENT=1 builds
>     fail to link because evsel__resolve_probe_type() calls
>     evsel__field() unconditionally (sashiko-bot).
> 
> Changes in v2 (patch 1 only):
>   - Detect ftrace-based dynamic probes (kprobes/uprobes/fprobes created
>     via tracefs) that report PMU "tracepoint" instead of "kprobe"/
>     "uprobe".  Check for the __probe_ip field presence in the tracepoint
>     format.  Without this, evsel__is_probe() returned false for ftrace
>     probes, breaking __probe_ip suppression in perf trace for probes
>     created via 'perf probe' (sashiko-bot).
>   - Widen probe_type bitfield from 2 to 3 bits for PROBE__FTRACE.
> 
> Arnaldo Carvalho de Melo (3):
>   perf evsel: Add lazy-initialized probe type detection helpers
>   perf trace: Guard __probe_ip suppression with evsel__is_probe()
>   perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()

It seems you squashed patch 3 into 1. :)

Thanks,
Namhyung

> 
>  tools/perf/builtin-trace.c |  2 +-
>  tools/perf/util/evsel.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h    | 19 +++++++++++++++++
>  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> 
> Developed with AI assistance (Claude/sashiko), tagged in commits.
