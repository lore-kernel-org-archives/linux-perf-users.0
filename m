Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254912C46B;
	Fri, 10 May 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349132; cv=none; b=E4EMfDtej/wmmnWAeRw/aYbTSsOImzH/nPgLaRSGQbbVGN9wos+Pso9Iu8Faf7jPXpMYEmnKj23xSRzyW0HDPOsaogo93tqy6lBbCPrOKn2XrptmHI34AEUCDhJ3Gp7CrWxOzmVs+3iiTaZT5Y1KepgAd+QqxyGVki+H2XuUTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349132; c=relaxed/simple;
	bh=ry3Mqd5CmjJo1OW6t11otMfSZLHdOycNCf2A3sVc5zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImMpl2HbJFde06gs1k8K5EsWeuTZG8ibRi0h+J+x8J3HM+53y7QG+pghzs9XzlyqcVEqz4fmOUvESXngzIuHd+aLQdqrcyH/tC/C4+uQK73aHr/lVinR5QZ00gPiXUM5RPbiiZwlTe9VdjONTlwK5fjbdIuD3+43ULrFqdcJNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk41rZJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk41rZJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F5C113CC;
	Fri, 10 May 2024 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349131;
	bh=ry3Mqd5CmjJo1OW6t11otMfSZLHdOycNCf2A3sVc5zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk41rZJK3VuvbLw/K4mbJGEYZcZtQRKx+pJgrCgPbdgRvxSpLjtJ9yZ/qX7m9yWxN
	 wZdKh1fDhReCZ2KLxtUH+AnNjlDSX3fFWnvgd0kIZr3YlT5ru2auVr4/t/afrLhskG
	 yh/SgnmDejtZKH7QezfTnVkxqwo/OJyb+hxqGiwxDlcalJx2jgk3uaqO4IZ7DzTYap
	 Z6lLZmK6obYPZJCe8ud0Lu+3IKzT/wb7wJZ1TIfCbYPERxRKgcaVv5dE0cPlaVCpF1
	 KPZhuyUCxl8vm+16EivgnHHnF5/zX/BIxxck7FrznZNvVAoU3pNX9R4pbNK1R0aVK5
	 mmIlM3k9qpIFg==
Date: Fri, 10 May 2024 10:52:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] perf probe: Allow names to start with digits
Message-ID: <Zj4miD9TguH5FrjL@x1>
References: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>

On Fri, May 10, 2024 at 07:24:29AM +0900, Dominique Martinet wrote:
> This is a rebase of the patch orginally sent almost two years ago here:
> https://lkml.kernel.org/r/20220612061508.1449636-1-asmadeus@codewreck.org
> 
> At the time I was asked to add tests, and Jiri whipped up something to
> make the test pass even for probes that don't exist on most systems but
> that ended up never being formatted or sent... I asked what happened of
> it and got asked to send it myself, but obviously also totally forget
> about it myself until I needed it again now.
> 
> I've taken the diff from that thread, adapted it a little bit to the
> current master branch and checked things still fall in place -- I didn't
> see any obvious problem.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Thanks!
> 
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: Liang, Kan <kan.liang@linux.intel.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> Changes in v4:
> - add missing ifdef LIBTRACEEVENT for new test case
> Note build-test still failed on my setup due to some bpf/cgroup problem,
> which is more likely a setup problem but means I couldn't verify build
> all the way:
> util/bpf_skel/bperf_cgroup.bpf.c:71:10: error: incomplete definition of type 'struct cgroup'
> - Link to v3: https://lore.kernel.org/r/20240509-perf_digit-v3-0-9036bf7898da@codewreck.org
> 
> Changes in v3:
> - fix evsel__newtp_idx typo in commit 1's message
> - rebase onto perf-tools-next
> - add trailers
> - Link to v2: https://lore.kernel.org/r/20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org
> 
> Changes in v2:
> - update Jiri's email in commit tags
> - (not a change, but after being brain-dead and Ian helpful
> reply I'm confirming patch 3/3 works as expected)
> - Link to v1: https://lore.kernel.org/r/20240407-perf_digit-v1-0-57ec37c63394@codewreck.org
> 
> ---
> Dominique Martinet (3):
>       perf parse-events: pass parse_state to add_tracepoint
>       perf parse-events: Add new 'fake_tp' parameter for tests
>       perf parse: Allow names to start with digits
> 
>  tools/perf/tests/parse-events.c | 13 +++++++++++--
>  tools/perf/tests/pmu-events.c   |  2 +-
>  tools/perf/util/evlist.c        |  3 ++-
>  tools/perf/util/evsel.c         | 20 +++++++++++++-------
>  tools/perf/util/evsel.h         |  4 ++--
>  tools/perf/util/metricgroup.c   |  3 ++-
>  tools/perf/util/parse-events.c  | 38 +++++++++++++++++++++++---------------
>  tools/perf/util/parse-events.h  |  9 ++++++---
>  tools/perf/util/parse-events.l  |  4 ++--
>  tools/perf/util/parse-events.y  |  2 +-
>  10 files changed, 63 insertions(+), 35 deletions(-)
> ---
> base-commit: 187c219b57eaf3e1b7a3cab2c6a8b7909bdbf4a9
> change-id: 20240407-perf_digit-72445b5edb62
> 
> Best regards,
> -- 
> Dominique Martinet | Asmadeus
