Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADA18733E;
	Tue,  7 May 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115102; cv=none; b=UAgiXrob9CjW2pYXs+unwarTTYHXnrF4qy4oTSs8swsy4ouPpLEru65xoKc4i6wRd/iK6guDamB4tkAoD0yv4OigL8idpAahx8y/jvHDD9VVDIA+u5KypgeJ/KAJ20C9Mp34CiERTELtHEHX7zsbB2INDM6sJbhsUk7b8yBCC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115102; c=relaxed/simple;
	bh=z/n9T5ppUUSRMEJ5Mi5N2EZQnWL+K906LwUS78beWj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDeyOww1EnrrOytuFk0cWoMH+0OYt8ZX0yPFIS1iZM1Mvg+eVB92mKWODkMLohjPpbSlWBMOPm6p4vwaDMhKv9W6468sEggxErBfF27IjkmIIpRV4K12ztrR6lM91SC4uo6O+dZWK1Pn36F00/rDd0HDFKfqTwYAi6mhv5slOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd4LdPFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd4LdPFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09AAC2BBFC;
	Tue,  7 May 2024 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715115101;
	bh=z/n9T5ppUUSRMEJ5Mi5N2EZQnWL+K906LwUS78beWj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd4LdPFKe3oIqgyV71D/y1+ZeZ2T9zcbP2X//BfPtTyQ8046hjQhjV03/zzahOOxl
	 D0blwrUJhhVoHvzFg+KvUbIUGkF3gTRqusOJOcDM/Q1GPiLieVT2ZsS2ZV24s1RE/I
	 G6joQ5CyKd9Kj/W3X7QC7QRK1JfjenEEETXnoUep4rm++G4UCj0ghQ3gvqkoL6qQ3O
	 Ma+CGG0o+1Zt20he+L6ZJf5THtuIZH2Ma37bHRzvMcmQXnMq4qrISenf41iOcyKc0k
	 UKpbLlWcgsrDH7VOweK2jAqnpIMS+ECTE3AVL176gKNtbtZLP7B/kpOSCWuXxBP2wy
	 gylmsXfYPsxPA==
Date: Tue, 7 May 2024 17:51:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Clark <james.clark@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>,
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Address/leak sanitizer clean ups
Message-ID: <ZjqUWp9gcIKIy24y@x1>
References: <20240507183545.1236093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>

On Tue, May 07, 2024 at 11:35:37AM -0700, Ian Rogers wrote:
> Remove unnecessary reference counts for structs with no gets.  Add
> reference count checking to comm_str and mem_info.  Fix memory leaks
> and errors detected on "perf mem report" by address sanitizer and leak
> sanitizer.

Applied locally, doing build tests. Will soon go to tmp.perf-tools-next.

- Arnaldo
 
> Ian Rogers (8):
>   perf ui browser: Don't save pointer to stack memory
>   perf annotate: Fix memory leak in annotated_source
>   perf block-info: Remove unused refcount
>   perf cpumap: Remove refcnt from cpu_aggr_map
>   perf comm: Add reference count checking to comm_str
>   perf mem-info: Move mem-info out of mem-events and symbol
>   perf mem-info: Add reference count checking
>   perf hist: Avoid hist_entry_iter mem_info memory leak
> 
>  tools/perf/builtin-c2c.c                      |  13 +-
>  tools/perf/builtin-report.c                   |   3 +-
>  tools/perf/builtin-script.c                   |  12 +-
>  tools/perf/builtin-stat.c                     |  16 +-
>  tools/perf/tests/mem.c                        |  11 +-
>  tools/perf/ui/browser.c                       |   4 +-
>  tools/perf/ui/browser.h                       |   2 +-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/annotate.c                    |   6 +
>  tools/perf/util/block-info.c                  |  22 +-
>  tools/perf/util/block-info.h                  |  15 +-
>  tools/perf/util/comm.c                        | 196 +++++++++++-------
>  tools/perf/util/cpumap.c                      |   2 -
>  tools/perf/util/cpumap.h                      |   2 -
>  tools/perf/util/hist.c                        |  62 +++---
>  tools/perf/util/hist.h                        |   8 +-
>  tools/perf/util/machine.c                     |   7 +-
>  tools/perf/util/mem-events.c                  |  36 ++--
>  tools/perf/util/mem-events.h                  |  29 +--
>  tools/perf/util/mem-info.c                    |  35 ++++
>  tools/perf/util/mem-info.h                    |  54 +++++
>  .../scripting-engines/trace-event-python.c    |  12 +-
>  tools/perf/util/sort.c                        |  69 +++---
>  tools/perf/util/symbol.c                      |  26 +--
>  tools/perf/util/symbol.h                      |  12 --
>  25 files changed, 370 insertions(+), 285 deletions(-)
>  create mode 100644 tools/perf/util/mem-info.c
>  create mode 100644 tools/perf/util/mem-info.h
> 
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
