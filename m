Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D043235059;
	Fri,  9 May 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807463; cv=none; b=KiAhinTbH3luKigCHIPjEm2cwDtqZqxnp+ZmO4JbPxDh3uBLpOVhV0AGaWLolUGOVuQGLg8FpSOZYmD2b4ruUbyZwqX1nnWrnicxP0Usjx2l2hEoPhRihj6FfMCKml1X0L9HjLpUv9Jt3QgMyoYqYCAfVAWYjfLIcbshOzSsJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807463; c=relaxed/simple;
	bh=/FSy4Y5u8yi3L51i2Mvhg2Nfe0hzragk32vSsyBE6/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLGazH3AFgWRl/kg12WOXbLk+Mmk6lu9D6EoAa0BjWu1q9aBs+NAVZizzXPPszFCqHDr1ezOEUrCZjXfeVhUCzMtJtD1kPE5/JOS86738ARDKpwnDoa3tAHY00OH3fedXgAgiBKRyLAE0A4xoy3U7sMv3s8AzsbxI84V/C+6YGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1xovz5D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1xovz5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E52C4CEEE;
	Fri,  9 May 2025 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807462;
	bh=/FSy4Y5u8yi3L51i2Mvhg2Nfe0hzragk32vSsyBE6/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1xovz5DW5Nhz241NhCdaXIQHQq8dLSs/NOrOUjUuFRCh3+socScZYGxmY+5+2hVp
	 +iWmK6UjcQbbY/IDfaix96KBqyuFfSVec4ex1pGc3xDBlknjy/csfhxlmpEKYdmD/Y
	 Y94hucb7yOecxhLgV4+glBISwW4jUOeRt1P4e/MXuQK6E5Sz4HghH5DAzxDKx06yIS
	 u5ibSWiXjcmC68Cmy3/wc0hddNEYMy6EsFWm43/oFy2qyg5Bb047AkJcr+KMMpQNyV
	 N0NadlwvBv1u6AdAGNwJ6TKpSpvnKRhB6rW86e8PJR4uG7BhCe3sHTweQxi/hgoAuR
	 dO7Fl1RqouaxQ==
Date: Fri, 9 May 2025 09:17:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [RFC/PATCHSET 00/11] perf mem: Add new output fields for data
 source (v1)
Message-ID: <aB4qpAc2GThyGaqg@google.com>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <33984b44-ae3d-4fbd-b918-07289a3f1d8a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33984b44-ae3d-4fbd-b918-07289a3f1d8a@amd.com>

Hi Ravi,

On Thu, May 08, 2025 at 09:42:41AM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> I feel the overall idea is good. Running few simple perf-mem commands
> on AMD works fine too. Few general feedback below.

Thanks for your review!

> 
> > The name of some new fields are the same as the corresponding sort
> > keys (mem, op, snoop) so I had to change the order whether it's
> > applied as an output field or a sort key.  Maybe it's better to name
> > them differently but I couldn't come up with better ideas.
> 
> 1) These semantic changes of the field name seems counter intuitive
>    (to me). Example:
> 
>    -F mem:
> 
>      Without patch:
> 
>      $ perf mem report -F overhead,sample,mem --stdio
>      # Overhead       Samples  Memory access
>          39.29%             1  L3 hit
>          37.50%            21  N/A
>          23.21%            13  L1 hit
> 
>      With patch:
> 
>      $ perf mem report -F overhead,sample,mem --stdio
>      #                          Memory
>      # Overhead       Samples    Other
>         100.00%            35   100.0%

Yep, that's because I split the 'mem' part to 'cache' and 'mem' because
he_mem_stat can handle up to 8 entries.  As your samples hit mostly in
the caches, you'd get the similar result when you run:

  $ perf mem report -F overhead,sample,cache --stdio

> 
>    -F 'snoop':
> 
>      Without patch:
> 
>      $ perf mem report -F overhead,sample,snoop --stdio
>      # Overhead       Samples  Snoop
>          60.71%            34  N/A
>          39.29%             1  HitM
>    
>      With patchset:
> 
>      $ perf mem report -F overhead,sample,snoop --stdio
>      #                         --- Snoop ----
>      # Overhead       Samples     HitM  Other
>         100.00%            35    39.3%  60.7%

This matches to 'Overhead' distribution without patch, right?

> 
> 2) It was not intuitive (to me:)) that perf-mem overhead is calculated
>    using sample->weight by overwriting sample->period. I also don't see
>    it documented anywhere (or did I miss it?)

I don't see the documentation and I also find it confusing.  Sometimes I
think the weight is better but sometimes not. :(  At least we could add
and option to control that (like --use-weight ?).

Also we now have 'weight' output field so users can see it, althought it
shows averages.

> 
>    perf report:
> 
>      $ perf report -F overhead,sample,period,dso --stdio
>      # Overhead  Samples   Period  Shared Object
>          80.00%       28  2800000  [kernel.kallsyms]
>           5.71%        2   200000  ld-linux-x86-64.so.2
>           5.71%        2   200000  libc.so.6
>           5.71%        2   200000  ls
>           2.86%        1   100000  libpcre2-8.so.0.11.2
> 
>    perf mem report:
> 
>      $ perf mem report -F overhead,sample,period,dso --stdio
>      # Overhead  Samples   Period  Shared Object
>          87.50%       28       49  [kernel.kallsyms]
>           3.57%        2        2  ld-linux-x86-64.so.2
>           3.57%        2        2  libc.so.6
>           3.57%        2        2  ls
>           1.79%        1        1  libpcre2-8.so.0.11.2
> 
> 3) Similarly, it was not intuitive (again, to me:)) that -F op/snoop/dtlb
>    percentages are calculated based on sample->weight.

Hmm.. ok.  Maybe better to use the original period for percentage
breakdown in the new output fields.  For examples, in the above result
you have 13 samples for L1 and 1 sample for L3 but the weight of L3
access is bigger.  But I guess users probably want to see L1 access was
dominant.

> 
> 4) I've similar recommended perf-mem command in perf-amd-ibs man page.
>    Can you please update alternate command there.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-amd-ibs.txt?h=v6.15-rc5#n167

Sure will do.

Thanks,
Namhyung

> 
> Please correct me if I'm missing anything.
> 
> Thanks,
> Ravi
