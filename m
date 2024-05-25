Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3610F1;
	Sat, 25 May 2024 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716602111; cv=none; b=HLv5LqADOtFJfA8i/hpga6GXbIUrQOJ99DkIzaqHjicyfGx+5G8FBOuhxGVW3AdrW+7uLK//X0viM90imA4k75xMF5Bx4IexlbwBWVe60EzKnDkqwWV8lJ6uizbcAcaFNmzbavDf3fF0sxGxIi5TSTZKTXPdCIkitOUqZAdTBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716602111; c=relaxed/simple;
	bh=a54UVgoaDej+I+wxWPyBO0VxFtBuKYRSZeAMl3H8y04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BokQ1lq+fea574QUz/YqKjRUwLjrirKuMj/TDMl9i+nQrfLi8Oba39SJkg8FhbQQ+Ozmh4Ybkjr8K82owt3lnzDoXVkkxvmo6UaoLRLOlpa1ZhQ+VF+m7HkXfyW845mucLNOS5hH8MU8X63B6V9wlyP9iIP/S3VZPshXf8fL/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOJUjO+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOJUjO+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6FFC2BBFC;
	Sat, 25 May 2024 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716602110;
	bh=a54UVgoaDej+I+wxWPyBO0VxFtBuKYRSZeAMl3H8y04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOJUjO+7lDDTIzsOdM6TYaN6cEgwoP5OY9I4lpvIf/phoZV5aae3SqBjfEaI59x7l
	 CBV2wMbI46EOUz/Q5IFANwdSpaCjxPSGfZR0oKz5dNoOgOaaAui9JziUvT6Y4stdLR
	 WKl3bMOzVTNkIpZlz+9gX9XYgkEUwugKuD86bOKumeQ7oae/olE95M811DtH52Lit7
	 Z6667/BGxvAefbOmDf31Gu1kw+4HqiipvQAbefoNGNz7B3g5gfHJvogqRa+AJeby1Q
	 LnE5gl2jb7awMavm1t9AfF3J9/0eiLrkPE4M3mhJHu3G1wN68dHd32dtYpAGfckk7F
	 a8JxEGxTh+OYw==
Date: Fri, 24 May 2024 22:55:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leo Yan <leo.yan@linux.dev>, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anne Macedo <retpolanne@posteo.net>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Ethan Adams <j.ethan.adams@gmail.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
Message-ID: <ZlFE-wbwStOqt8Ra@x1>
References: <20240521192614.3937942-1-acme@kernel.org>
 <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>

On Fri, May 24, 2024 at 06:31:52PM -0700, Linus Torvalds wrote:
> On Tue, 21 May 2024 at 12:26, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > perf tools fixes and improvements for v6.10:
> 
> This actually broke 'perf' completely for me on arm64.
> 
> With a 6.9 version of 'perf', I can do this:
> 
>     perf record -e cycles:pp make -j199
> 
> and it all works fine.
> 
> With the current -git version, when I do the same, I instead get
> 
>   Error:
>   cycles:pp: PMU Hardware doesn't support
> sampling/overflow-interrupts. Try 'perf stat'
> 
> and after trying desperately to chase down what went wrong on the
> kernel side, I finally figured out that it wasn't a kernel change at
> all, it was the tooling that had changed.
> 
> I did a 'git bisect', and it says
> 
>   617824a7f0f73e4de325cf8add58e55b28c12493 is the first bad commit
>   commit 617824a7f0f73e4de325cf8add58e55b28c12493
>   Author: Ian Rogers <irogers@google.com>
>   Date:   Mon Apr 15 23:15:25 2024 -0700
> 
>       perf parse-events: Prefer sysfs/JSON hardware events over legacy
> 
> and very clearly this does *NOT* work at all for me.
> 
> I didn't notice until now, simply because I had been busy with the
> merge window, so I hadn't been doing any profiles, but the merge
> window is calming down and the end is nigh, and I just wasted more
> time than I care to admit trying to figure out what went wrong in the
> kernel.
> 
> And no, I don't speak JSON, and I have *no* idea what the legacy
> events are. Plus I'm not very familiar with the arm64 profiling etc
> anyway, so I'm just a clueless user here.
> 
> I *can* confirm that just reverting that commit makes that trivial
> "perf record" work for me. So the bisect was good, and it reverts
> cleanly, but I don't know _why_ my arm64 setup hates it so much.

That is a good data point, we probably could go with the revert, but I
think Ian submitted a few patches fixing this issue that came up close
to LSFMM/BPF and the merge window, so didn't have time to sit on
linux-next for a while, I'm looking those up now.

ARM64 eyes on this would also be good. Adding Mark Rutland and Leo Yan
to the CC list, maybe they can help us here with the best course of
action.

- Arnaldo
