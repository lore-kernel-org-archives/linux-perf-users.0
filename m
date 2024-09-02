Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360F19CC0C;
	Mon,  2 Sep 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301627; cv=none; b=ukQonmZRYHqI75l6yWx8Ti527F7n/rWssH0lUdCJaCbvyiuV59PTSyTEO30mO64rmDOwcrHmiwH0SrKQH23S9ItOnGdkxba/hHc8ymyJXebrW+Di2CKMFX0ZSGJxkpVB3HZ99Dq/R+OsAjIfU+8YZDFV4G1UCEG9Fs0SmYwFK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301627; c=relaxed/simple;
	bh=+GQtJqRYkvNY82ROtDZoMSPZ3IkE/UiyNuyLQiJxBZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUnupUy/GYNRCfUlE1BRGeNz0DQsUOXmpQMe9tli3iBrIjDkFAdErokfh+TAn2phSsyGNP33XHKqDTEVJMQhSqQLtOqXoejl2HhXmfeL6zr0+jjE9FbMWFs0tjXwd8CAaQ+Kp7qwKbOavEkNguYO81Ozd7RXscX0oCd+GHQJOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaGYBIST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaGYBIST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD53C4CEC2;
	Mon,  2 Sep 2024 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301626;
	bh=+GQtJqRYkvNY82ROtDZoMSPZ3IkE/UiyNuyLQiJxBZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaGYBISTMqt6rBTz+VMI2Xicm9Sec+smM/CZxxKXhIA+PqTe0zuWvVwOqu1vbOFb4
	 ed3YZ5uzkqxsmC+0o/yGGKIKnOVMPSb2xJ6aOO+xNpF9pVfQ9rSQs0Uz3rcmyF56ZL
	 P46KhqUzQdGeN+Z+C+iwfU7Vme9PjEp3nqrJBq5ydg6/84ETumC0m1K7Ak7kCYFJ4a
	 EUVarvtkCYe9msmq0h3yG3OsgivkG9/R26W2twDWS0CVrqPetPnJZUSAIRDKQLsqh1
	 +N1JTd9cA9RQ99IRmHjnKi5jVU4xJhMois+jyORHNOOu05IEzNNZHxAyqcqjef5n17
	 DUqGLaGeionxQ==
Date: Mon, 2 Sep 2024 11:27:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Anne Macedo <retpolanne@posteo.net>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13] perf inject improvements
Message-ID: <ZtYDeE5kTy4KrRC5@google.com>
References: <20240817064442.2152089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>

On Fri, Aug 16, 2024 at 11:44:29PM -0700, Ian Rogers wrote:
> Fix the existing build id injection by adding sample IDs on to the
> synthesized events. This correctly orders the events and addresses
> issues such as a profiled executable being replaced during its
> execution.
> 
> Add a new --mmap2-buildid-all option that rewrites all mmap events as
> mmap2 events containing build IDs. This removes the need for build_id
> events.
> 
> Add a new -B option that like --mmap2-buildid-all synthesizes mmap2
> with build id events. With -B the behavior is to do it lazily, so only
> when a sample references the particular map. With system wide
> profiling that synthesizes mmap events for all running processes the
> perf.data file savings can be greater than 50%.
> 
> Reduce the memory footprint of perf inject by avoiding creating
> symbols in the callchain, the symbols aren't used during perf inject
> and necessitate the loading of dsos.
> 
> Ian Rogers (13):
>   perf synthetic-events: Avoid unnecessary memset
>   perf map: API clean up
>   perf jit: Constify filename argument
>   perf dso: Constify dso_id
>   perf evsel: Constify evsel__id_hdr_size argument
>   perf test: Expand pipe/inject test
>   perf inject: Combine build_ids and build_id_all into enum
>   perf inject: Combine different mmap and mmap2 functions
>   perf inject: Combine mmap and mmap2 handling
>   perf inject: Fix build ID injection
>   perf inject: Add new mmap2-buildid-all option
>   perf inject: Lazy build-id mmap2 event insertion
>   perf callchain: Allow symbols to be optional when resolving a
>     callchain

For the remaining bits,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/builtin-inject.c         | 532 ++++++++++++++++++----------
>  tools/perf/builtin-top.c            |   2 +-
>  tools/perf/tests/shell/pipe_test.sh | 103 ++++--
>  tools/perf/tests/vmlinux-kallsyms.c |   4 +-
>  tools/perf/util/build-id.c          |   6 +-
>  tools/perf/util/callchain.c         |   8 +-
>  tools/perf/util/callchain.h         |   2 +-
>  tools/perf/util/dso.c               |   4 +-
>  tools/perf/util/dso.h               |   4 +-
>  tools/perf/util/dsos.c              |  12 +-
>  tools/perf/util/dsos.h              |   2 +-
>  tools/perf/util/evsel.c             |   2 +-
>  tools/perf/util/evsel.h             |   2 +-
>  tools/perf/util/jit.h               |   3 +-
>  tools/perf/util/jitdump.c           |   6 +-
>  tools/perf/util/machine.c           |  95 ++---
>  tools/perf/util/machine.h           |  36 +-
>  tools/perf/util/map.c               |  25 +-
>  tools/perf/util/map.h               |  22 +-
>  tools/perf/util/synthetic-events.c  | 103 +++++-
>  tools/perf/util/synthetic-events.h  |  21 +-
>  21 files changed, 682 insertions(+), 312 deletions(-)
> 
> -- 
> 2.46.0.184.g6999bdac58-goog
> 
