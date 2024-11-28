Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCA145323;
	Thu, 28 Nov 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732824899; cv=none; b=N1jxEP/F9PU3WlHbIp7dwbIdSTSJBu5ooyhijWnrlS8vzH+rBbM0Xm86R8POIBtntLXfAlGumWkjEDvQGLtDXC0rp3xFi2+e/LH6H5I1qx0ZvSXlJNG67TNHmGkBzpCOmySoGe4KcBSQ3gX00DJBElX/vstjyszOXeJy5KIC97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732824899; c=relaxed/simple;
	bh=tI+JVpAQUt0m0tYcgKDep0iXAw2bTIA9tCjj3R9bNO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezCvOy6JPGufkxNM4eLtmGrBeOQcmYZYBxH3re/nbgqsLKTZ6L6lmRCEpaHV641zXwAUa8mP/+kFRsllHINxGRRjCdnF4fNtmfNr7tESK1zmjAArBRqSWQWU665JO1IZtNnnAOp9j+gbWNSIyqPsdRy3+CRHcIENjcK9P9hWdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+o5oymb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+o5oymb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE18AC4CECE;
	Thu, 28 Nov 2024 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732824897;
	bh=tI+JVpAQUt0m0tYcgKDep0iXAw2bTIA9tCjj3R9bNO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+o5oymbNAtvn0TcQNrA77Ig7Jj6quqgyWDE+1BuFHkWv37B2hprbWWgUQJe/3vus
	 S1ztMyNxDq4aGlZDljzxFYHEqiRwmzWtgDirl6hOyrGbKON44UdwmIRgbXVhptIWaL
	 FXPZQ2RBOUIWlrs3xkagzo/qtKDAaq+I+QqUMZZxvrpjulQmVOmAMl+aSfXNnHKu4t
	 1sOSm71skmAs/+FEfx+kVJZW1deHPD2TmhIS80yneBq4+DZ5Dtnzx0T3+7OhL0Btxo
	 qbQSXTAGYtYvoZTgrGuRv5iZVk1uGMLjqoGUhGWovrvWxDrWphIXF/F5gIwZmkDJs4
	 eOSHbju1CCebQ==
Date: Thu, 28 Nov 2024 17:14:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/12] perf record: Add event action support
Message-ID: <Z0jPPRA8JXSrwyaC@x1>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133553.823722-1-yangjihong@bytedance.com>

On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
> In perf-record, when an event is triggered, default behavior is to
> save sample data to perf.data. Sometimes, we may just want to do
> some lightweight actions, such as printing a log.

> Based on this requirement, add the --action option to the event to
> specify the behavior when the event occurs.

'perf record' is centered on saving data to disk without processing
events, while it has sideband events for some needs, like processing BPF
related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
and UNLOAD), doing things in a "live" way as your patchkit does seems
more appropriate to do in 'perf trace' :-)

I'll take a look at the rest of the patch series.

- Arnaldo
 
> This patchset uses bpf prog to attach to tracepoint event, and save sample
> to bpf perf_event ringbuffer in handler. perf-tool read the data and run actions.
> 
> Currently only one call is supported, that is, print(),
> and some commonly used builtin variables are also supported.
> 
> For example:
> 
>   # perf record -e sched:sched_switch --action 'print("[%03d][%llu]comm=%s, pid=%d, tid=%d\n", cpu, time, comm, pid, tid)' true
>   [003][795464100275136]comm=perf, pid=141580, tid=141580
>   [003][795464100278234]comm=swapper/3, pid=0, tid=0
>   [003][795464100288984]comm=perf, pid=141580, tid=141580
>   [003][795464100457865]comm=swapper/3, pid=0, tid=0
>   [003][795464100485547]comm=perf, pid=141580, tid=141580
>   [003][795464100491398]comm=kworker/u36:1, pid=139834, tid=139834
>   [003][795464100493647]comm=perf, pid=141580, tid=141580
>   [003][795464100494967]comm=kworker/u36:1, pid=139834, tid=139834
>   [003][795464100498146]comm=perf, pid=141580, tid=141580
>   ...
> 
>   # perf record -e cycles --action 'print("test\n");' true
>   bpf record action only supports specifying for tracepoint tracer
> 
>   # perf record -e sched:sched_switch --action 'print("[%llu]comm=%s, cpu=%d, pid=%d, tid=%d\n", time, comm, cpu, pid)' true
>   print() arguments number for format string mismatch: 5 expected, 4 provided
>   parse action option failed
> 
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
> 
>           --action <action>
>                             event action
> 
>   # perf record -e sched:sched_switch --action 'print("test\n");' true
>   test
>   test
>   test
>   test
>   test
>   test
>   test
>   test
>   test
>   test
>   ...
> 
> This patchset implements simple features and can be extended as needed.
> 
> TODO LIST:
> 1. Support common operations such as logical operations and bit operations
> 2. Support other calls such as dumpstack(), count()
> 3. Support specify actions for kprobe events
> 4. For builds that disable bpf_skel, support real-time parsing of perf record mmap ringbuffer data (similar to perf top)
> 5. Link libllvm to support dynamic generation of bpf progs
> 
> Yang Jihong (12):
>   perf record: Add event action support
>   perf event action: Add parsing const expr support
>   perf event action: Add parsing const integer expr support
>   perf event action: Add parsing const string expr support
>   perf event action: Add parsing call expr support
>   perf event action: Add parsing print() call expr support
>   perf event action: Add parsing builtin expr support
>   perf event action: Add parsing builtin cpu expr support
>   perf event action: Add parsing builtin pid expr support
>   perf event action: Add parsing builtin tid expr support
>   perf event action: Add parsing builtin comm expr support
>   perf event action: Add parsing builtin time expr support
> 
>  tools/perf/Documentation/perf-record.txt     |   8 +
>  tools/perf/Makefile.perf                     |   1 +
>  tools/perf/builtin-record.c                  |  31 +
>  tools/perf/util/Build                        |  18 +
>  tools/perf/util/bpf_skel/bpf_record_action.h |  24 +
>  tools/perf/util/bpf_skel/record_action.bpf.c | 151 ++++
>  tools/perf/util/parse-action.c               | 729 +++++++++++++++++++
>  tools/perf/util/parse-action.h               |  98 +++
>  tools/perf/util/parse-action.l               | 190 +++++
>  tools/perf/util/parse-action.y               | 156 ++++
>  tools/perf/util/record_action.c              | 380 ++++++++++
>  tools/perf/util/record_action.h              |  30 +
>  12 files changed, 1816 insertions(+)
>  create mode 100644 tools/perf/util/bpf_skel/bpf_record_action.h
>  create mode 100644 tools/perf/util/bpf_skel/record_action.bpf.c
>  create mode 100644 tools/perf/util/parse-action.c
>  create mode 100644 tools/perf/util/parse-action.h
>  create mode 100644 tools/perf/util/parse-action.l
>  create mode 100644 tools/perf/util/parse-action.y
>  create mode 100644 tools/perf/util/record_action.c
>  create mode 100644 tools/perf/util/record_action.h
> 
> -- 
> 2.25.1
