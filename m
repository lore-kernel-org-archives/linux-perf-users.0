Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479417;
	b=fm8oZMJerxO7SDljfjgO7QS6CcewAgy8ANILlw4c9oqyRGsDhZ+WVfa5r/1zWwZgEufK
	 xgc38oKAvPKGSB5uh/DhMEiP8drNcyFRehyfy2e+8s7Mt7k7NcrYEYzYvVIgj/J7x4Z6L
	 CXe7Jlus8rX1lILUXmXPAUKqSwxc9SMerxspp2GgXRZ4W+c2wspNLS3JMIhMgTlQ/n7nj
	 xj2uvuE8ET4DQwGKA9sISWpEM+aLyErae+iebQn9vK35wCBZMvSZFvQW70dZhhKtWqtKI
	 0n0Vr7W0OpSAQwdfoHvHAu1uxnb9l874uVseSso9+8dYRs+WwloWGCaoqxVXEw/EPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479417;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JDtSVUbf3tqyj4+i9LAIXOSXv1RsCSEn45NdGRlqlrc=;
	b=K7KLjKdK28tZBxJy5gzU3PBR6b/TmD8aznWoMnAcaxknHSo5VdkJaHR5ejxP5sNNxdM7
	 HBC/lMBcBF1u5RJJci7kSOtToANigOdgd8ij+riVl181toABFZyZ4khXu02SRGDFBQROn
	 RknQwWdfF4dAVOHwjZUNpIlc/aZTgrN77IqKlS8w7ntM04q2z8rQn0Sm7Sr279E+92z9r
	 lQEMxm0nhL/OnjtXf/gWgOys2SbnnvUHgY874JY99nzMpPmVOhwkqmS4Ri9a88T6Uy7F2
	 pB1J8j6EL5umRdFEXOCe8ZbhyGj+eEQb+TWnKkuX2SrfvBTz89mWex3QTwkkpeP6y6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX2hpLNv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292F606A31E;
	Tue, 24 Nov 2026 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX2hpLNv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1901F000C4;
	Tue, 24 Nov 2026 00:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479417;
	bh=JDtSVUbf3tqyj4+i9LAIXOSXv1RsCSEn45NdGRlqlrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KX2hpLNvnGSfow3AdUJUlst5GUxY2Hia6wnyP9MkHUSTwUlKq29frwP+FjR/Svg/c
	 fUQmK3jI4nZuVe2uvppteSAt57xOSR8w60tg+LVZQIceMxDu657AuO1lLC6GA7C0xP
	 3vDjtTmqe8mVuqID4rSxEoyD2A0Yx/Ej4v/mZlpf/FBbYoSt4eTinKU+8AcY4SDhfM
	 islbDL8T98iDp6BBqM8ZFzeIToVQESDb/lCjLrxwBYCXmmKh77z2Z6OUBZra3WBM6O
	 EdZvdOb40H1fIHZJor955OLnUCRQ6BZOno8TimAEwQbc1g+EDJw0nVUWKRDOE3Nyuf
	 /9BV4iUCSxvAA==
Date: Mon, 23 Nov 2026 16:16:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Song Liu <songliubraving@fb.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>
Subject: Re: [PATCH v1 06/13] perf pmu: Don't treat tool PMU as a kernel
 software PMU for event grouping
Message-ID: <awTXdgY38s2bijW5@google.com>
References: <20261123071913.653315-1-irogers@google.com>
 <20261123071913.653315-7-irogers@google.com>
 <179547553247.235629.15166017818384644106@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179547553247.235629.15166017818384644106@gmail.com>

Hello,

On Mon, Nov 23, 2026 at 11:12:12PM +0000, TAKANO Mitsuhiro wrote:
> Hi Ian,
> 
> 06/13 keeps a group that mixes a tool event with a kernel event from
> reaching the BUG_ON and the group read; I am not disputing that.  What I
> want settled is whether such a group should be split or refused.
> 
> The 06/13 commit message says:
> 
> > Return false for PERF_PMU_TYPE_TOOL in perf_pmu__is_software(), matching
> > hwmon and drm PMUs, and ensure evsel__compute_group_pmu_name() only
> > substitutes perf_event_open PMU names for software and AUX events [...]
> 
> I took the other approach: perf stat refuses a group that mixes a tool
> event with a kernel event (one that perf_event_open() opens), unless the
> group is weak and its leader is user_time or system_time.  With that patch,
> perf stat rejects -e '{user_time,cycles}' with "A tool event cannot be
> grouped with kernel events: user_time" and exits with status 22, instead of
> printing a value for the tool event and "<not supported>" for the rest.
> This is v4 of "perf stat: Refuse a group mixing tool and kernel events":
> 
>   https://lore.kernel.org/all/20261122085947.3107661-1-takano32@gmail.com/
> 
> In v4's test, the -a case expects a refusal that the cpu-map split in
> evlist__check_cpu_maps() makes impossible on a machine with more than one
> core PMU.  Only the test needs to change; the refusal code does not.  I
> will post v5 with that fix.
> 
> The parser's split for events of another software PMU, and the split -a
> causes in evlist__check_cpu_maps(), are not what this is about, and I am
> not asking to change either.  The -e '{user_time,cycles}' case is not a
> regression: perf stat opens it as one group today, the kernel rejects the
> cycles member with EBADF, and cycles prints "<not supported>".  06/13 would
> count both, as two groups.  I would rather be told the group is refused,
> with a hint at the form that does work
> (-e '{cycles,instructions},user_time'), than have perf choose a grouping
> for me.  That is a preference about what the braces mean, not a claim that
> 06/13 is broken, and it is yours to weigh.  A warning would tell the user
> what happened, but the two groups would still start and stop separately,
> which is the part I cannot square with the braces.  If a warning is what
> you have in mind, say so and I will take the refusal off the table.
> 
> With 06/13 as posted, the tool event keeps its own PMU name, so the group is
> already split by the time perf stat's check runs.  Moving my check before
> the parser regroups the events would refuse a group over members that -a
> would have taken out of it, so the check has to come after both the regroup
> and the split in evlist__check_cpu_maps().  If 06/13 keeps both changes --
> the one in perf_pmu__is_software() and the one in
> evsel__compute_group_pmu_name() -- the groups my test expects to be refused
> would be accepted instead.
> 
> The refusal does not reintroduce the fd == -1 case 06/13 guards against:
> the check runs before perf_event_open(), so a group it refuses never reaches
> get_group_fd().
> 
> On v3 of Hang's patch, which I posted for him, Namhyung wrote (2026-11-20,
> <awC_aZXD5FBGu4mO@google.com>):
> 
> > I think grouping with tool events would cause more headaches.  Probably
> > the simplest fix is to prohibit grouping.
> 
> Namhyung, by "prohibit grouping", did you mean that perf stat should refuse
> such a group, or that it should count each event on its own and print a
> value for it?  06/13 does the second.  When I wrote v4 I read you as asking
> for the first, and v4 refuses exactly those groups; a group of tool events
> alone, such as -e '{user_time,system_time}', is still accepted.

Right, but there's no reason to group tool events IIUC.

I was afraid that events like '{user_time,instructions,system_time,cycles}'
can complicate parsing and evlist handling.  As they cannot be a group,
it'd be easier to reject them with a message instead of adding seemingly
unnecessary complexity.

Thanks,
Namhyung

> 
> 07/13 ("perf evlist: Enable tool PMU events when starting a workload")
> fixes the enable_on_exec case my patch does not touch; I would like to see
> it land regardless of how this is settled.
> 
> So which should it be: the split in 06/13, or the refusal in v4?  If the
> split wins, I will withdraw v4.  If the refusal wins, 06/13 would have to
> leave the PERF_PMU_TYPE_TOOL case alone in perf_pmu__is_software() and drop
> the PERF_PMU_KIND checks in evsel__compute_group_pmu_name().
> 
> If you would rather leave it to Namhyung, I will go with whatever he says.
> I am asking you because 06/13 is your patch.
> 
> Thanks,
> TAKANO Mitsuhiro
> 
