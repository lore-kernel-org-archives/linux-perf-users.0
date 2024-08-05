Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF97166F3B;
	Mon,  5 Aug 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886003; cv=none; b=jutlA/0yWtjXrHIN59h0tTEyZBDgAuk1k1EcsLYcFfkZa+x9yL1IzeGO4siVk4M556SDXU/pW9+yA8SL60hMKI6w4K/yo9O1ZF/7xIgYfZ5XF8w8/LjiKqhB2uvgiu62f7Jb6D827NCSNFuqezlKlAle+J9jZwjPrXoJdUaWV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886003; c=relaxed/simple;
	bh=xc5xYC3391kLsTitKoNAcGxQDu731JrNLvNU6OAF4J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbXp8sQGVBt933x/Z/J4GQBEOuMMLzRFJMQgeXe4dljPscndwAWxZ+2R1caWgDaFE6vIlYl8LxsXoe929kcJYdMHDslmTWM9I/Kb07gFywFk5O8RYCQ42RrzyfpYP9cwb114Q9lGin8qJShnXL3yygHUMZz/NQ9L4Ib1eaS9qNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNRak7mA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNRak7mA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B931C32782;
	Mon,  5 Aug 2024 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722886003;
	bh=xc5xYC3391kLsTitKoNAcGxQDu731JrNLvNU6OAF4J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNRak7mAOqaoHyvLxpI0ZJya9R970Ye089nBGHqr3eMlWsJ87LPjNQS4rYGYU3ue3
	 sMV9f689HsX44zrBkMUry7NYY+nKA69DgRr7adJo32WgAtQ01ledbBh1veENxd0jTp
	 vyiJfujvELR+vbENzNaG7qZfs7Yng2NLep/OrPMiDuKi0hd0H5sd4H/O7J66kZU8Nz
	 OQeESG3QrFKet8DtmH33DhRJQ76eDqBxXhWxy6fbjCbdxsFcwvAHGzt9gOcAtnkHSX
	 n6gzgi1l1HPmxL8ukD5AD3vG6++PrylaU5OJZoAJdPMRbVGqnZRdgqZOwG2uyZ/fP9
	 zE8/9XRsbc2gw==
Date: Mon, 5 Aug 2024 16:26:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/5] perf annotate: Add --skip-empty option (v1)
Message-ID: <ZrEnbzIJaUUU-rDb@x1>
References: <20240803211332.1107222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803211332.1107222-1-namhyung@kernel.org>

On Sat, Aug 03, 2024 at 02:13:27PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is to make perf annotate has the same behavior as perf report.
> Especially in the TUI browser, we want to maintain the same experience
> when it comes to display dummy events from perf report.
> 
>   $ perf mem record -a -- perf test -w noploop
> 
>   $ perf evlist
>   cpu/mem-loads,ldlat=30/P
>   cpu/mem-stores/P
>   dummy:u

Thanks, tested and applied to tmp.perf-tools-next will go to
perf-tools-next later.

- Arnaldo
 
> Just using perf annotate with --group will show the all 3 events.
> 
>   $ perf annotate --group --stdio | head
>    Percent                 |    Source code & Disassembly of ...
>   --------------------------------------------------------------
>                            : 0     0xe060 <_dl_relocate_object>:
>       0.00    0.00    0.00 :    e060:       pushq   %rbp
>       0.00    0.00    0.00 :    e061:       movq    %rsp, %rbp
>       0.00    0.00    0.00 :    e064:       pushq   %r15
>       0.00    0.00    0.00 :    e066:       movq    %rdi, %r15
>       0.00    0.00    0.00 :    e069:       pushq   %r14
>       0.00    0.00    0.00 :    e06b:       pushq   %r13
>       0.00    0.00    0.00 :    e06d:       movl    %edx, %r13d
> 
> Now with --skip-empty, it'll hide the last dummy event.
> 
>   $ perf annotate --group --stdio --skip-empty | head
>    Percent         |    Source code & Disassembly of ...
>   ------------------------------------------------------
>                    : 0     0xe060 <_dl_relocate_object>:
>       0.00    0.00 :    e060:       pushq   %rbp
>       0.00    0.00 :    e061:       movq    %rsp, %rbp
>       0.00    0.00 :    e064:       pushq   %r15
>       0.00    0.00 :    e066:       movq    %rdi, %r15
>       0.00    0.00 :    e069:       pushq   %r14
>       0.00    0.00 :    e06b:       pushq   %r13
>       0.00    0.00 :    e06d:       movl    %edx, %r13d
> 
> The code is available in 'perf/annotate-skip-v1' branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (5):
>   perf annotate: Use al->data_nr if possible
>   perf annotate: Set notes->src->nr_events early
>   perf annotate: Use annotation__pcnt_width() consistently
>   perf annotate: Set al->data_nr using the notes->src->nr_events
>   perf annotate: Add --skip-empty option
> 
>  tools/perf/Documentation/perf-annotate.txt |  3 ++
>  tools/perf/builtin-annotate.c              |  2 +
>  tools/perf/util/annotate.c                 | 47 +++++++++++++---------
>  tools/perf/util/annotate.h                 |  2 +-
>  tools/perf/util/disasm.c                   |  6 +--
>  5 files changed, 35 insertions(+), 25 deletions(-)
> 
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 
