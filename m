Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F92267714;
	Sat,  6 Dec 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765013714; cv=none; b=uk+e5DQh8APtZYp2xb0JjG8Aj3sfyXTocuoww3Nbu93G4AvofB4aMn/jLFhx771Pdom4mU9imScBjc9rPyz4mhaJr8hG6kCw96XFL3/srZgJbjHAYB24j043/PEzA0md8e/pAsGjzoMbU4TSdp/Cn6+4nHmy8f+cCZYxlVi2wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765013714; c=relaxed/simple;
	bh=EAi1jAEMwd7Q9sMhS/y3hdNUpwWkw5KXsfpzt2bs8eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ1NFw0WteYyxmoCfztFDlJhiHa7QQbP79ezDQSDyOtnO72KnePuJH8GgpZITa3z1nVz9lCrjFlY6MU2l8AOZGlNepc1DxhksOoKqJlnU8utt8p3/vJJhiwZ+G2Ojk1xF7OS9k0kDs3xmuVI0tNLHHiY44Jt6yAFKibijbaSC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeypfUKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeypfUKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D6DC4CEF5;
	Sat,  6 Dec 2025 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765013714;
	bh=EAi1jAEMwd7Q9sMhS/y3hdNUpwWkw5KXsfpzt2bs8eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeypfUKONqL5jYEpyhzJ/8Ozf/BqbsrA8w/T7RgkwqX5OveF9KA5pfFKiJ9vbMse2
	 OG03s3NslPoAwTnC21ZLoQj4RSWSmZ+aY5ZJqEgZADKzmI1/fB6lNvSclbWaOf/O7n
	 CvTTuf9z7hxgHn+6x4H6zqKhSnOasxf+v6uQ5pqfcrpLX6P8J67yUZpc6urSKhz1dC
	 Kxj3MgykPgxJvPjgxHPZyaEwZp0jTxuSQkian8/h7isuQLyD+I9QTj7fBk1kRRKA2C
	 6uGEjiul7j/YAkyMkSbILzxfCePXPsXNsb9725gMReT6hDXbgSFQXvcNZsfjEHCCCG
	 1PebREALjzdVg==
Date: Sat, 6 Dec 2025 10:35:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related
 fixes/tests
Message-ID: <aTP4zSy87wEZlbsO@gmail.com>
References: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203214706.112174-1-irogers@google.com>

* Ian Rogers <irogers@google.com> wrote:

> Ingo reported [1] that `perf stat --null` was segfaulting. Fix the
> underlying issue and add a test to the "perf stat tests". Do some
> related fixing/cleanup in the perf util cpumap code.
>
> Thomas reported an issue fixed by the same patches [2] but caused by
> giving perf stat an offline CPU. Add test coverage for that and
> improve the "error" message that reports "success".
>
> Ingo further pointed at broken signal handling in repeat mode [3]. I
> observed we weren't giving the best exit code, 0 rather than the
> expected 128+<signal number>. Add a patch fixing this.
>
> [1] https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
> [2] https://lore.kernel.org/linux-perf-users/94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com/
> [3] https://lore.kernel.org/lkml/aS5wjmbAM9ka3M2g@gmail.com/
>
> Ian Rogers (7):
>   perf stat: Allow no events to open if this is a "--null" run
>   libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
>   perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
>   perf tests stat: Add "--null" coverage
>   perf stat: When no events, don't report an error if there is none
>   perf tests stat: Add test for error for an offline CPU
>   perf stat: Improve handling of termination by signal
>
>  tools/lib/perf/cpumap.c        | 10 +++++----
>  tools/perf/builtin-stat.c      | 29 ++++++++++++++++++-------
>  tools/perf/tests/shell/stat.sh | 39 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/cpumap.c       |  9 ++++++--
>  4 files changed, 73 insertions(+), 14 deletions(-)

A belated:

  Tested-by: Ingo Molnar <mingo@kernel.org>

And thank you a lot for doing these QoL fixes!

	Ingo
