Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C222C6E5;
	Fri,  6 Dec 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526210; cv=none; b=dYg7sCIPwI0tsHsmooinzOhqKdBsPeQuxPfqCKzO6V6vWKUsK1etFz0lTFJd9yd+lFVuZ72AqsmHSzIzMWKH93OJSv4eD/Bba7mhchq6YiXI1kdcZ3ZLjDjoFzTW3SIbNsfg0BBMOOauooKa9rF0Rg2uDmhSTXpjv8ndWiYyqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526210; c=relaxed/simple;
	bh=9kLF9zel6/Ciibio6+ZZ/fcVom3lsexhG6tdAEYxewQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2VYFBSR/J0zLw2Jz2Gg+Nmu8YuQKNN737Ly2WnOXLSmmn/pqERjNVB/2prN+cjg+BgkElq8G4hKOF4oPE4V5KJ+J+XQ5Zq6t2LmoGJf5aRjXjN+c60cyR7NFMFvHdiO2tPSS7KFiLIdW4RE2tPlhBkhQ56e1SDUeCbfwKCcA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480C711FB;
	Fri,  6 Dec 2024 15:03:55 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66F53F58B;
	Fri,  6 Dec 2024 15:03:26 -0800 (PST)
Date: Fri, 6 Dec 2024 23:03:21 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
Message-ID: <20241206230321.GA5430@e132581.arm.com>
References: <20241206044035.1062032-1-irogers@google.com>
 <20241206044035.1062032-2-irogers@google.com>
 <20241206102451.GA3418674@e132581.arm.com>
 <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>

Hi Ian,

On Fri, Dec 06, 2024 at 08:25:06AM -0800, Ian Rogers wrote:

[...]

> > This series is fine for me.  Just wandering if we can use a central
> > place to maintain the macro, e.g. lib/perf/include/perf/cpumap.h.  It
> > is pointless to define exactly same macros in different headers.  As
> > least, I think we can unify this except the kwork bpf program?
> >
> > P.s. for dynamically allocating per CPU maps in eBPF program, we can
> > refer to the code samples/bpf/xdp_sample_user.c, but this is another
> > topic.
> 
> Thanks Leo,
> 
> can I take this as an acked-by?

Yeah.  I will give my review tags in the cover letter.

> Wrt a single constant I agree,
> following these changes MAX_NR_CPUS is just used for a warning in
> libperf's cpumap.c. I think we're agreed that getting rid of the
> constant would be best. I also think the cpumap logic is duplicating
> something that libc is providing in cpu_set.
>
> And we have more than one representation in perf for the sake of the
> disk representation:

Thanks for sharing the info.

> Just changing the int to be a s16 would lower the memory overhead,
> which is why I'd kind of like the abstraction to be minimal.

Here I am not clear what for "changing the int to be a s16".  Could you
elaberate a bit for this?

Lastly, I also found multiple files use "MAX_CPUS" rather than
"MAX_NR_CPUS".  Polish them in a new series?

Thanks,
Leo
