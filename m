Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F7214230;
	Fri, 14 Mar 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982514; cv=none; b=KccntXwCaTWmS615Hb9cyCo/hm8OjvBWC+n0LhyR5RwxpJ3k3vTqQB3sQruKEoFjxFOaoakrccPnfKiqDdDosrlUxMVnSsaPo6iYx74jO0gQY28yXP+PysycSQFyUgB1QMGt2DxtYjzu5g3/S61JlhLK65PLIDav0dBJge5z894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982514; c=relaxed/simple;
	bh=vhl18IjHPw/3AHnEoOG25hlLaV4rPR1ZA18lcGudXUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InrLVDlqKgITlBF0wBD1KqogZvUCVmXZAvZX/KXgy5+gD6ieNIrKsYwblbWrbkFepYbnYCQ90moRUq/RXqru6UrkrIWpY/UK7YcyUgCYWmkqPIffvfn9GXx+Bq+Sj+u4gYtNkpGBxDBWBlvOABFdwudupNVsQ61NqlM3MXnu5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3sPZpsl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3sPZpsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23841C4CEE3;
	Fri, 14 Mar 2025 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982514;
	bh=vhl18IjHPw/3AHnEoOG25hlLaV4rPR1ZA18lcGudXUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3sPZpsl/bxbNcIC37Jq9ZzpslkKIzt8lpwVtxTAd/B1i5FG31OfWq7947h1IJrPa
	 Sfx46gUQfn+O07m3b3v/SeGZkFiG1mjeTOnFHWheK32ocP5TRc0DUnmB9Wxc0YBgu5
	 h3+OW/FPkNlwhWpeFiLo3+twehzihXKvGRdbVqVV9yLHYWkzlhKvywqFFYYGXg0lSl
	 rwEKJQtrqcfHZ/eT8h+cRzeTkPAlSpuH7louhzYIecDC0tKxkyqJjyZh7t4+sStO7n
	 8vcmDBQkQKDJaC+vIqWK+ZQ7fFcR/P+sJH1j6g6OAzoCpPpEGPCUCW+8W3w8cYS1iq
	 vdX0Lt5M6d+Qg==
Date: Fri, 14 Mar 2025 17:01:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Howard Chu <howardchu95@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf machine: Factor creating a "live" machine
 out of dwarf-unwind
Message-ID: <Z9SLL50yuiLOGGYI@x1>
References: <20250313052952.871958-1-irogers@google.com>
 <Z9Rk-YdoK-fK_62d@x1>
 <Z9SK96s4PAp680k6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9SK96s4PAp680k6@x1>

On Fri, Mar 14, 2025 at 05:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 14, 2025 at 02:18:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 12, 2025 at 10:29:51PM -0700, Ian Rogers wrote:
> > > Factor out for use in places other than the dwarf unwinding tests for
> > > libunwind.
> > 
> > Testing with another patchset being reviewed/tested, seems to work, if
> > it showed the line number would be even better!
> 
> But it gets the lines, at least in this secoond attempt, after applying
> Namhyungs fix for the previous problem (int16_t):

Nevermind, this time I built with DEBUG=1, so DWARF, probably.

- Arnaldo
 
> root@number:~# perf trace -e landlock_add_rule perf test -w landlock
> perf: Segmentation fault
>     #0 0x6698d0 in dump_stack debug.c:355
>     #1 0x66994c in sighandler_dump_stack debug.c:367
>     #2 0x7f784be95fd0 in __restore_rt libc.so.6[40fd0]
>     #3 0x4d0e56 in trace__find_usable_bpf_prog_entry builtin-trace.c:3882
>     #4 0x4cf3de in trace__init_syscalls_bpf_prog_array_maps builtin-trace.c:4040
>     #5 0x4bf626 in trace__run builtin-trace.c:4477
>     #6 0x4bb7a9 in cmd_trace builtin-trace.c:5741
>     #7 0x4d873f in run_builtin perf.c:351
>     #8 0x4d7df3 in handle_internal_command perf.c:404
>     #9 0x4d860f in run_argv perf.c:451
>     #10 0x4d7a4f in main perf.c:558
>     #11 0x7f784be7f088 in __libc_start_call_main libc.so.6[2a088]
>     #12 0x7f784be7f14b in __libc_start_main@@GLIBC_2.34 libc.so.6[2a14b]
>     #13 0x410ff5 in _start perf[410ff5]
> Segmentation fault (core dumped)
> root@number:~# 
>  
> > I'll continue working on that other case with this applied just before
> > that series and finally will give my Tested-by.
> > 
> > - Arnaldo
> > 
> > root@number:~# perf trace -e landlock_add_rule perf test -w landlock
> > perf: Segmentation fault
> >     #0 0x5be81d in dump_stack perf[5be81d]
> >     #1 0x5be879 in sighandler_dump_stack perf[5be879]
> >     #2 0x7f313d24efd0 in __restore_rt libc.so.6[40fd0]
> >     #3 0x491bc1 in cmd_trace perf[491bc1]
> >     #4 0x497090 in run_builtin perf.c:0
> >     #5 0x4973ab in handle_internal_command perf.c:0
> >     #6 0x413483 in main perf[413483]
> >     #7 0x7f313d238088 in __libc_start_call_main libc.so.6[2a088]
> >     #8 0x7f313d23814b in __libc_start_main@@GLIBC_2.34 libc.so.6[2a14b]
> >     #9 0x413ad5 in _start perf[413ad5]
> > Segmentation fault (core dumped)
> > root@number:~#
