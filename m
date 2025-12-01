Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895730BF4E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611688; cv=none; b=tUDPaeUyjuCs62hsmuKN7KuhH94bv9Z91NxI5Y4VvVwVMXpZdqXCDTJxBu+EJMAT1cpMH6cSwOA6Erp5e04DzuAcRRhOM7+6/ABPbxqcPOkTEZ15AZvpFHfVGKmeDQvwdslg7Hu3bZ2TN+pr8mUrmg2pSqcqnV7kPkmK+YOFu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611688; c=relaxed/simple;
	bh=UApK1oU1YHg2wF5jC/yjyZJfjfFdpdXm/w6+nATxEnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3sd1hAsYXaW4rFhYTne8raiWpX2v80oJkBHIa/XJ8uyi/rLxh3s1tR3rEglKD9jxJrkSsoyUGzBUEVVOLIJkT259kGN4qhMMxlhZSOToYLBFyir+aWWA94+0+EjibMqC3U6LVHAApz3K8KgeqcMzUw5HV+++tjEbKyz3W77HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8QJosOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8QJosOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7D3C4CEF1;
	Mon,  1 Dec 2025 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764611688;
	bh=UApK1oU1YHg2wF5jC/yjyZJfjfFdpdXm/w6+nATxEnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8QJosOoqSwNtPI/AMeMgWUQPgo61YnBMfGBtRsRyUn8/Ya9QbfdNTbMaaUK0qr1P
	 SYcipLwMK7zcSrjTOxwnK+R4gf5xYIYuRXH/VKqndt3CS9iAdcKFUKZ4I3gTvrrWnt
	 5u8PHpZDtIRL9uldjH3XaimZSOVR0tbbvifOgiNjseuG7MzncbVx0fJH9TyNNrrv+R
	 HXfO7hL1ua4W1TIci0UyUnbwLYp+TXK6bxTCjfzHUtY4P7FOVzv61v0JFParUFj1vc
	 X2W8Oq48Z/DEfOzgEVkgbQwYpouLgAqbUUWcfqhwIjDHvTEgJFnA0qzGWEPzL5mwZx
	 dqPTqvbUXUodA==
Date: Mon, 1 Dec 2025 18:54:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] Fix (well, work around) perf stat --null segfault
Message-ID: <aS3WXn4nz9GE87bM@gmail.com>
References: <aSwt7yzFjVJCEmVp@gmail.com>
 <CAP-5=fXK8HORZaFUxydEatLV1xXQTcLLBnEMeveJYDHDQPkf_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXK8HORZaFUxydEatLV1xXQTcLLBnEMeveJYDHDQPkf_w@mail.gmail.com>


* Ian Rogers <irogers@google.com> wrote:

> Agreed on the trainwreck :-) So NULL is a valid CPU map value. It
> means no CPUs, but magically no CPUs can also be converted in the code
> to become the "any" CPU value of -1. So iterating the perf_cpu_map of
> NULL will yield a single CPU of -1 :-( This behavior existed before my
> time working on the code, I've tried to make the expectation in the
> using code clearer, does the user want the magic "any" CPU behavior?
> "any" CPU is distinct from every/all CPUs which would be something
> like CPUs 0-127, and then does "all" include online and offline CPUs?
> This is something that's been discussed and I think things can be
> better, I'd rather the code was explicit whenever terms like "all",
> "online" and "any" were being used - it is very easy to confuse "all"
> and "any". I've been trying to adjust the code and make it more
> sensible with changes like:
> https://lore.kernel.org/all/20240202234057.2085863-1-irogers@google.com/
> but I agree with you that things are a mess here. At least we
> shouldn't be leaking memory (due to the reference count checking) and
> we shouldn't confuse indices and CPU numbers (due to the introduction
> of a wrapper type), problems that were pervasive and broke things like
> uncore counters frequently before.
> 
> Fwiw, part of me thinks we should change the perf_cpu_map to be a
> cpu_set_t, the "any" case could be an additional boolean in the
> struct. Perhaps we can just auto change "all" to "any" as is somewhat
> done here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/evlist.c?h=perf-tools-next#n92
> Then perf_cpu_map can be a cpu_set_t and I think life will be clearer.

Yeah, so when I looked at the data structure a few 
minutes ago:

	/**
	 * A sized, reference counted, sorted array of integers representing CPU
	 * numbers. This is commonly used to capture which CPUs a PMU is associated
	 * with. The indices into the cpumap are frequently used as they avoid having
	 * gaps if CPU numbers were used. For events associated with a pid, rather than
	 * a CPU, a single dummy map with an entry of -1 is used.
	 */
	DECLARE_RC_STRUCT(perf_cpu_map) {
		refcount_t	refcnt;
		/** Length of the map array. */
		int		nr;
		/** The CPU values. */
		struct perf_cpu	map[];
	};


My first thought was "Why isn't this a bitmask?". :-)

The thing is, even with 8192 CPUs, the mask size is 1K. 
That's still not catastrophic compared to the nightmare 
of managing a [8192] array...

And I would keep such core data structures as simple as 
possible: a single continuous bitmask. No sparse 
support, no NULL tricks. Just an always-present 
bitmask, and maybe an any/all modifier flag if the ABIs 
strongly suggest so.

The closer a data structure is to the core concepts of 
a tool, the more important its robust KISS properties 
are - at almost any runtime cost. </handwaving> :)

> Fwiw, even on the kernel side this is borked as I tried to explain in
> this RFC with 0 follow ups:
> https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/

So that's a neat patch and kudos on the ASCII graphics. :-)

I'd suggest a re-send.

> Imagine the case of an event opened with 1 CPU and a TID. The filter
> will mean the counter only counts on the 1 CPU but the enabled and
> running time will mean the counter will be scaled (on your system) 128
> times!
> All of this matters when you consider different events opened in the
> same evlist and there being combined perf_cpu_maps like the evlist's
> all_cpus value.

> > -       nr = perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
> > +       if (evsel_list->core.all_cpus)
> > +               nr = perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
> > +       else
> > +               nr = 0;
> 
> So I think the better fix is to make max handle a NULL perf_cpu_map.
> That will yield "any" CPU of -1 ( :-( ) and then the -1 + 1 will give
> an empty aggregation map.
> 
> I'll write this up, add the test and see if I can spot similar issues
> wrt NULL in the vicinity in the perf_cpu_map code.

Thank you! In the short run I'd prefer whichever fix 
can restore perf stat --null functionality the fastest. ;-)

Thanks,

	Ingo
