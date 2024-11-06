Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A53C39;
	Wed,  6 Nov 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879384; cv=none; b=aQv9v/172IFv13RSDhBroVs8r8TPYdobRWW9ywBZPvPY2jbFIdg4TX24hKFHk5JJblXfxLtMlwS0JcP/Mc8WKLco5S89dhtKUGsXIIR8cyaNMo8hYikSRtJYvJndgEe/EVr7JKh+Yj1a61ZNokNq1sf4b0mX3rlSDbsD00Yu6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879384; c=relaxed/simple;
	bh=ND+TXwyAXLSzgJv+fBJ0w+wxxgS/uc12Hw2aAR5o/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZozH9IUOp507NmDgBhi88B2I8FqVw4/l/EUtLMOokbio+OC5L882pN12UMyiLXZAfXsripH7rfTEVZxrHwabTxZnaXQgxsZdlVvGlNhZd6DumXAbJzEY3TWM7xd+UdH2A/iXt13adyLin6KSO76VoR8WO/D0pRXokedrEBZGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvJi9bvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvJi9bvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0952C4CECD;
	Wed,  6 Nov 2024 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730879383;
	bh=ND+TXwyAXLSzgJv+fBJ0w+wxxgS/uc12Hw2aAR5o/BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvJi9bvkrhhRFNearLchLt0vgBcs4Dgt6X/PL+Hz/F5Q/VPpISTHhpSQOwcmXabvp
	 q6ZlRVKR32+2alzAvUkCECIQYUVkowKy+d4XHpiXaOiWUD5I1RZeiToLSq4p1wmWk3
	 QGdkZ8KqZjASOMZONrrj7MUlwza88J0t+yqE+f/ocrw6i7ZLmqRQff4SuLV/asJUIX
	 KVO8bl/vEweKXjr3DIqQGRS14IKisXSqPUz/DeNytGyoBNIXX3n2YyDxCgV/5vfJ63
	 b7QmkznzTWiRemepLlgBCy8y3zG2CwH2ldWRSPre55IR7tT1h8wx4k1b8yVC/N0Qjf
	 vJYDNYgD0daXg==
Date: Tue, 5 Nov 2024 23:49:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/6] Avoid parsing tracepoint format just for id
Message-ID: <Zysfld8NGv1u0ML0@google.com>
References: <20241105212652.401943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105212652.401943-1-irogers@google.com>

On Tue, Nov 05, 2024 at 01:26:46PM -0800, Ian Rogers wrote:
> The tracepoint format isn't needed to open an event, just the id for
> the config value. Refactor the use of evsel->tp_format to use an
> accessor that will lazily construct its value. In evsel__newtp_idx
> read the id so the config value can be set up/used.
> 
> This allows tracepoints to be used without libtraceevent in a number
> of tests. Other functionality is enabled without libtracevent, such as
> mapping a tracepoint id back to its name. There may be some
> performance benefit to code using tracepoints but not using the format
> information.
> 
> v3. Whitespace changes, Arnaldo.
> v2. Add additional error checking/handling in evsel__tp_format.

Can you please collect tags that Arnaldo gave to you in the previous
version, next time?

Thanks,
Namhyung

> 
> Ian Rogers (6):
>   tool api fs: Correctly encode errno for read/write open failures
>   perf trace-event: Constify print arguments
>   perf trace-event: Always build trace-event-info.c
>   perf evsel: Add/use accessor for tp_format
>   perf evsel: Allow evsel__newtp without libtraceevent
>   perf tests: Enable tests disabled due to tracepoint parsing
> 
>  tools/lib/api/fs/fs.c                         |   6 +-
>  tools/perf/builtin-kmem.c                     |  12 +-
>  tools/perf/builtin-kwork.c                    |   3 +-
>  tools/perf/builtin-record.c                   |   2 -
>  tools/perf/builtin-script.c                   |   9 +-
>  tools/perf/builtin-trace.c                    |  79 +++++++++----
>  tools/perf/tests/Build                        |   6 +-
>  tools/perf/tests/builtin-test.c               |   2 -
>  tools/perf/tests/parse-events.c               |  25 +---
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/data-convert-bt.c             |  10 +-
>  tools/perf/util/data-convert-json.c           |   8 +-
>  tools/perf/util/evsel.c                       | 110 +++++++++++++-----
>  tools/perf/util/evsel.h                       |   9 +-
>  tools/perf/util/evsel_fprintf.c               |   4 +-
>  tools/perf/util/parse-events.c                |  16 +--
>  tools/perf/util/perf_event_attr_fprintf.c     |   4 -
>  .../util/scripting-engines/trace-event-perl.c |   3 +-
>  .../scripting-engines/trace-event-python.c    |   3 +-
>  tools/perf/util/sort.c                        |  33 ++++--
>  tools/perf/util/trace-event-parse.c           |   4 +-
>  tools/perf/util/trace-event-scripting.c       |  10 +-
>  tools/perf/util/trace-event.h                 |   4 +-
>  23 files changed, 216 insertions(+), 148 deletions(-)
> 
> -- 
> 2.47.0.199.ga7371fff76-goog
> 
