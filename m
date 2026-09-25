Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261A49EC6D;
	Fri, 25 Sep 2026 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342997; cv=none; b=kzHJakpAtKEvC09UzIViHV6kQjDWtFSd7LpSXB6MJgp8ecjCOsPme9brtEB76g6lmdsBetzPx4oAkJ82hwPL0GNKWbTlzFWzIEevSV043+w1NkCNESv7GYmlhc2wQxIzYNSJIh0QzKxkIX/LfPg7pjkzprtxIcnWlWIIQxdrfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342997; c=relaxed/simple;
	bh=oECEIbIHmtfqbs/HunRkOd9wsQlxU9rUq1qCSf2jnEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/Cicyl/GU2VXu8c+SVgNCHDtLUdsthZTw3jq7MIABgSNq17zeGPpAQqkDoKYgY3nR6Hvro3cNSjmM6FOi3W3WUNAZDnB6AwqS56LgtxDvQhqhdVmFZggQc2Tw+KDlhBXFccnO2n9NmL6fDdMtqlz65IjiRQnAMMOyy+4Sd/7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1qL9oAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1qL9oAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1359C1F000FF;
	Fri, 25 Sep 2026 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342994;
	bh=ouPrNjWoMdbj2BbFa9krmBmsh+H0p/xg/hCRxq6VL2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N1qL9oAs6xho95nY4gwIpMW8gv1dhyaL+hB0AkMJMoKodpXw8lrcL/mzsV2UTKh/W
	 krCMra7bHmCBfJPuEFStId1dsIyaWmaZASOy7BGKqg5/Lv1aNaECk71sso5POf20BB
	 yNR+9NxmK/6SJOFvS1T0tAobzB/8JuV77IltoiGmzN5CbucSAD/VJphqlRmd6tfnZD
	 StuDZ5jlq+6xncTvy9YkwdhtMsDkeJzK9uccYzTcMfiBSSXsARU7TjWg1EVQEygsan
	 Fmjv73eGC8c8xsf+5LVtCOtjH3nEzVpy7FsTETLUIixlTfpCXYb4Gf+JW7d8hu3vRT
	 ZiISOO7DfSgnQ==
Date: Fri, 25 Sep 2026 15:29:51 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Nia Su <nia.su@sifive.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf evlist: Don't restrict uncore events to PMU CPUs
Message-ID: <arZ3T-H6SndL592d@x2>
References: <20260909-perf-evlist-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com>
 <CAP-5=fU2UOT8pZFLOifxHo7U4XsPv9YbYnAitjdvxsB=0AYuoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU2UOT8pZFLOifxHo7U4XsPv9YbYnAitjdvxsB=0AYuoQ@mail.gmail.com>

On Tue, Sep 15, 2026 at 12:42:43PM -0700, Ian Rogers wrote:
> On Wed, Sep 9, 2026 at 7:31 PM Nia Su <nia.su@sifive.com> wrote:
> > The PMU CPU map has different semantics for core and uncore PMUs.
<SNIP>
> > Add evsel->is_pmu_uncore, set once from pmu->is_uncore at parse time,
> > to skip the intersection for uncore PMUs. Core PMUs, and other
> > non-core PMUs such as software events, breakpoints, or tracepoints,
> > continue to be restricted to their PMU CPU map.

> > Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")

> > Assisted-by: Claude Sonnet 5
> > Signed-off-by: Nia Su <nia.su@sifive.com>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
