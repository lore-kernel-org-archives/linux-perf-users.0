Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF0225D6;
	Fri,  9 Aug 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238134; cv=none; b=lXuWXksm2Ny5bQ7lfpoxNCGsMtFbqFURcNTUa0I/f9KhTUiY7jd8xdaOBtTSlE3+taVu0Aauk89SrrQlvqDNXuOJlC5iFSiNuiwMnwaVqABrus9zF0pa7zST8M7eeEm2eysTICkdZmYt86xRAxnmNn4EKoLFhRwQd/9oqp+O+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238134; c=relaxed/simple;
	bh=WDLxd448HftortWiAdBjWMSTzbRSfPU4kr/k4P1TZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5ntoArXLliv+aJwEq8rmAtu0LgxrFCbBqDAmQEfKy+1OFhWLneYBxorWswwId6YxgDpuAOEGW5BPFZ7lYMyj6i1iTDYbhvC7H0YCMelqyUyVBOucPmmZaPbJmU66VmLUS8Ia3XsjRLBLAVTm2pohtEZ/MAtVNxW1xOw1ihfoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHstCtmu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHstCtmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59000C32782;
	Fri,  9 Aug 2024 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723238133;
	bh=WDLxd448HftortWiAdBjWMSTzbRSfPU4kr/k4P1TZyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHstCtmu0TcueqpNSJ8DYR/q9JqgdqfFS0kcfbMES/8FqKK4x+zfM+Is+qbRUFlbL
	 6pUuatyLut4MeIL0vIl5D8amJs24w96rwlNI1snB+QqsCU0DEuicS4dEMcctND1RxX
	 a1BwjdifR1E98tsk/hj6p+vYlGJtimJ+IwKaWbSFOY5DM1PBqIh1eUQtZ4KoChK0rb
	 bRbC+hJK4K/XlFhbLvLjUiHctYANHzSJSXH6if6ykScSoq8nJcQTXijmwwO0UDnF2q
	 EMk/do5xNFx3BNTf7LJySMllN+MF4baJMTNgreTcgXbwRCpFmVBVn8drv92sIH5zF1
	 EAS/gbdRHBIpA==
Date: Fri, 9 Aug 2024 18:15:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf annotate: Fix --group behavior when leader has no
 samples
Message-ID: <ZraG8ryV_qubOt8R@x1>
References: <CAM9d7cjXmaMuidQR10PXrp9khZ4LhDZbLno1rN2JcCncaYyp7Q@mail.gmail.com>
 <20240807061555.1642669-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807061555.1642669-1-namhyung@kernel.org>

On Tue, Aug 06, 2024 at 11:15:55PM -0700, Namhyung Kim wrote:
> When --group option is used, it should display all events together.  But
> the current logic only checks if the first (leader) event has samples or
> not.  Let's check the member events as well.
> 
> Also it missed to put the linked samples from member evsels to the
> output RB-tree so that it can be displayed in the output.

Thanks, re-tested and applied.

- Arnaldo

> For example, take a look at this example.
> 
>   $ ./perf evlist
>   cpu/mem-loads,ldlat=30/P
>   cpu/mem-stores/P
>   dummy:u
> 
> It has three events but 'path_put' function has samples only for
> mem-stores (second) event.
> 
>   $ sudo ./perf annotate --stdio -f path_put
>    Percent |      Source code & Disassembly of kcore for cpu/mem-stores/P (2 samples, percent: local period)
>   ----------------------------------------------------------------------------------------------------------
>            : 0                0xffffffffae600020 <path_put>:
>       0.00 :   ffffffffae600020:       endbr64
>       0.00 :   ffffffffae600024:       nopl    (%rax, %rax)
>      91.22 :   ffffffffae600029:       pushq   %rbx
>       0.00 :   ffffffffae60002a:       movq    %rdi, %rbx
>       0.00 :   ffffffffae60002d:       movq    8(%rdi), %rdi
>       8.78 :   ffffffffae600031:       callq   0xffffffffae614aa0
>       0.00 :   ffffffffae600036:       movq    (%rbx), %rdi
>       0.00 :   ffffffffae600039:       popq    %rbx
>       0.00 :   ffffffffae60003a:       jmp     0xffffffffae620670
>       0.00 :   ffffffffae60003f:       nop
> 
> Therefore, it didn't show up when --group option is used since the
> leader ("mem-loads") event has no samples.  But now it checks both
> events.
> 
> Before:
>   $ sudo ./perf annotate --stdio -f --group path_put
>   (no output)
> 
> After:
>   $ sudo ./perf annotate --stdio -f --group path_put
>    Percent                 |      Source code & Disassembly of kcore for cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P, dummy:u (0 samples, percent: local period)
>   -------------------------------------------------------------------------------------------------------------------------------------------------------------
>                            : 0                0xffffffffae600020 <path_put>:
>       0.00    0.00    0.00 :   ffffffffae600020:       endbr64
>       0.00    0.00    0.00 :   ffffffffae600024:       nopl    (%rax, %rax)
>       0.00   91.22    0.00 :   ffffffffae600029:       pushq   %rbx
>       0.00    0.00    0.00 :   ffffffffae60002a:       movq    %rdi, %rbx
>       0.00    0.00    0.00 :   ffffffffae60002d:       movq    8(%rdi), %rdi
>       0.00    8.78    0.00 :   ffffffffae600031:       callq   0xffffffffae614aa0
>       0.00    0.00    0.00 :   ffffffffae600036:       movq    (%rbx), %rdi
>       0.00    0.00    0.00 :   ffffffffae600039:       popq    %rbx
>       0.00    0.00    0.00 :   ffffffffae60003a:       jmp     0xffffffffae620670
>       0.00    0.00    0.00 :   ffffffffae60003f:       nop
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-annotate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index efcadb7620b8..1bfe41783a7c 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -632,13 +632,23 @@ static int __cmd_annotate(struct perf_annotate *ann)
>  	evlist__for_each_entry(session->evlist, pos) {
>  		struct hists *hists = evsel__hists(pos);
>  		u32 nr_samples = hists->stats.nr_samples;
> +		struct ui_progress prog;
> +		struct evsel *evsel;
>  
> -		if (nr_samples == 0)
> +		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
>  			continue;
>  
> -		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
> +		for_each_group_member(evsel, pos)
> +			nr_samples += evsel__hists(evsel)->stats.nr_samples;
> +
> +		if (nr_samples == 0)
>  			continue;
>  
> +		ui_progress__init(&prog, nr_samples,
> +				  "Sorting group events for output...");
> +		evsel__output_resort(pos, &prog);
> +		ui_progress__finish();
> +
>  		hists__find_annotations(hists, pos, ann);
>  	}
>  
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 
