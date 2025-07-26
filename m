Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5519E96D;
	Sat, 26 Jul 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753572149; cv=none; b=hom/jf4xqWO4B+GHADs/6VtUirqkVXJ3xl+3+52KuWkInXC7ORRekJwv7sHMCZirpA64iM3u2WBL3NTMa9LmXGQryFi6d++qI0pjeRwLe7hkZO81oBSv8jVABtF1rXYkh80x+CAN6ZXX1F13uO3Tg5SyU1jGiA8eOHEZezSMqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753572149; c=relaxed/simple;
	bh=0xz4RV+d6qHkPDE8kgCZEqbuOIdYYMj9qTjUz/61hJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOQnBU11d/mxuR6PvBO8g/c5XnmeCqVeNONOP6y0wHivqDfZyE9sP0a16qygKb/ZX6GUztThw+hQwjEsfgmx7WZ1vwNkxk38eeSZrAodDpg1/A0+X7Q81QI665UWvLdJ5V6z6yDU/Sp7fsVzUzORBysu4WIfnHt2JLrjE/6+7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6Mufqvy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6Mufqvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38E5C4CEED;
	Sat, 26 Jul 2025 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753572148;
	bh=0xz4RV+d6qHkPDE8kgCZEqbuOIdYYMj9qTjUz/61hJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6MufqvyvfvRrGuFO+bWMj48Uxd46D4ByNPrs7sSvw1MLYqpHDqzX6KvHK7MoehA0
	 xwiABhThS0fb6r4NCLBMe/DDPK3VshBWHInhr9rVUqKbjOURDUHZ9mOMQCY3Ouzzgy
	 qNE8shkGCL/wcUmJ5OikzA2kXcG0zVClmLI0UXywSvRcTa3/txssO6j+Tgt351ZdQ6
	 pTyFag/KFxvBlOGBHFPmibv6UD8JyjM1cus+2Fw9zA8/NMH6gmkiqqef0DXeYvMHad
	 FwaOmYsDJFBeHLLO67AwSyp4KoX38yOUEoCoXyjTM83gc/8OCkMib3S1bf0eRjiF/C
	 4LtY0Drz8TOtg==
Date: Sat, 26 Jul 2025 16:22:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 00/16] New perf ilist app
Message-ID: <aIVjMrRLkL5Z5Xnm@google.com>
References: <20250725185202.68671-1-irogers@google.com>
 <aIVg3X5ByiTPkXRA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIVg3X5ByiTPkXRA@google.com>

On Sat, Jul 26, 2025 at 04:12:29PM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Fri, Jul 25, 2025 at 11:51:46AM -0700, Ian Rogers wrote:
> > This patch series builds up to the addition of a new ilist app written
> > in python using textual [1] for the UI. The app presents perf PMUs and
> > events, displays the event information as in `perf list` while at the
> > bottom of the console showing recent activity of the event in total
> > and across all CPUs. It also displays metrics, placed in a tree
> > through their metric group, again with counts being displayed in the
> > bottom panel.
> > 
> > The first ground work patches of fixes, cleanup and refactoring were
> > separated into their own series here:
> > https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/
> > 
> > The second part of the patches adds event json for the software PMU
> > and makes the tracepoint PMU support iteration of events and the
> > like. Without these improvements the tracepoint and software PMUs will
> > appear to have no events in the ilist app. As the software PMU moves
> > parsing to json, the legacy hard coded parsing is removed. This has
> > proven controversial for hardware events and so that cleanup isn't
> > done here.
> 
> Even software PMU can be controversial. :)  But I think we can try this
> first.  Basically this will change the output `perf list` and the event
> parsing behavior.
> 
> For example, `perf list sw` will look like:
> 
> software:
>   alignment-faults
>        [Number of kernel handled memory alignment faults. Unit: software]
>   bpf-output
>        [An event used by BPF programs to write to the perf ring buffer. Unit: software]
>   cgroup-switches
>        [Number of context switches to a task in a different cgroup. Unit: software]
>   context-switches
>        [Number of context switches [This event is an alias of cs]. Unit: software]
>   cpu-clock
>        [Per-CPU high-resolution timer based event. Unit: software]
>   cpu-migrations
>        [Number of times a process has migrated to a new CPU [This event is an alias of migrations]. Unit: software]
>   cs
>        [Number of context switches [This event is an alias of context-switches]. Unit: software]
>   dummy
>        [A placeholder event that doesn't count anything. Unit: software]
>   ...
> 
> Let's add this change and see if people complain..
> 
> Btw, I think the alias can be one-way.  IOW 'context-switches' is a
> software event and 'cs' is an alias to it, not vice versa.  I'll make
> the change.

Hmm.. this needs to rebuild the string index and causes a build error.
I'll just leave it as is and we can update it later.

Thanks,
Namhyung

