Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53D233D7D;
	Sat,  9 Nov 2024 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731134758; cv=none; b=DcO9EhQyLbFrdlKZz3hlbVtfg9b9TWDcnByDOYxuo48vU+278rqb3m0I66vcp8HWki+2Mx1AK3x5LjiijwONRO0ihQww/og5DYlOemVSmWn5gdTijvQMW8oEN9/1EH6nHYIue5SobxIE/sznf7FSZSCvTfnmBNqXOfYkbVVUlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731134758; c=relaxed/simple;
	bh=/2j+lWnKPGb0XCEcsiubcIvwP7dtYhvVDtA61Lbj/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdTP0Kr6AHuv8XikRbrbd3hgefvy7vn5i5LfDUWcBotZ9kv07HJoxiSrf1E7dT2xBMjsHuG/4OkWgFi9xWx4WeDtF++NrZMdRHkQzG2wj3ljaJ3yPLjQvzsHoPpOdvMcz1ylfOB2stfeEMf711xTbvkfucJmrNwaeonm/iCPeMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXBye0DG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXBye0DG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6F7C4CEC6;
	Sat,  9 Nov 2024 06:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731134758;
	bh=/2j+lWnKPGb0XCEcsiubcIvwP7dtYhvVDtA61Lbj/aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXBye0DGZXYNZVfOxxd1ukijAp5CmK7ZEWSfahHPf5CLTD0zYM8k4hO8In04w5F0s
	 V52mIRGBbVJO+dVhBjCg/GNL5KbS6GpZxIESIYYnn2ZMORejJBvAt3MtTgLaNk5olN
	 ZZvoEnX8CM4B1oZW6kyg3ibBdoeKhb3GV8FQ04EPzRNXFocBcxaGathoIMPhovAWzV
	 LPYa7ka+p+FuJyQ6BgdHmzjfw2/g3eNd6QpLroJmWM7LsxlUZoK3ghsDMlnG//cSV1
	 dJSW8M8BhwHwKIVfre0ZMElUJs5JS1JlRExEId0FDa49BFNr1k3z4dDK8Z6gDpV3+1
	 LQVKwCmlm7uKQ==
Date: Fri, 8 Nov 2024 22:45:54 -0800
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
Subject: Re: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
Message-ID: <Zy8FIt2OMa5-GymZ@google.com>
References: <20241108184751.359237-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108184751.359237-1-irogers@google.com>

On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
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
> v4. Rebase due to conflict with 9ac98662dbd3 ("perf: event: Remove deadcode")
> v3. Whitespace changes, Arnaldo.
> v2. Add additional error checking/handling in evsel__tp_format.
> 
> Ian Rogers (6):
>   tool api fs: Correctly encode errno for read/write open failures
>   perf trace-event: Constify print arguments
>   perf trace-event: Always build trace-event-info.c
>   perf evsel: Add/use accessor for tp_format
>   perf evsel: Allow evsel__newtp without libtraceevent
>   perf tests: Enable tests disabled due to tracepoint parsing

After applying this series, I'm seeing some test failures.  But I don't
understand why it affects non-tracepoint events though.

  $ sudo ./perf test -v pipe
  --- start ---
  test child forked, pid 3036123
   1bde35-1bdecc l noploop
  perf does have symbol 'noploop'
  
  Record+report pipe test
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.210 MB - ]
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.517 MB - ]
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.516 MB - ]
  Record+report pipe test [Success]
  
  Inject -B build-ids test
  0xa5c [0x17a4]: failed to process type: 80
  Error:
  failed to process sample
  Inject build-ids test [Failed - cannot find noploop function in pipe #1]
  
  Inject -b build-ids test
  0xa5c [0x17a4]: failed to process type: 80
  Error:
  failed to process sample
  Inject build-ids test [Failed - cannot find noploop function in pipe #1]
  
  Inject --buildid-all build-ids test
  0xa5c [0x17a4]: failed to process type: 80
  Error:
  failed to process sample
  Inject build-ids test [Failed - cannot find noploop function in pipe #1]
  
  Inject --mmap2-buildid-all build-ids test
  0xa5c [0x17a4]: failed to process type: 80
  Error:
  failed to process sample
  Inject build-ids test [Failed - cannot find noploop function in pipe #1]
  ---- end(-1) ----
   84: perf pipe recording and injection test                          : FAILED!
  
  $ sudo ./perf test -v Zstd
  --- start ---
  test child forked, pid 3036097
  Collecting compressed record file:
  500+0 records in
  500+0 records out
  256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, compressed (original 0.004 MB, ratio is 3.324) ]
  Checking compressed events stats:
  Couldn't decompress data
  0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permitted]
  Error:
  failed to process sample
  ---- end(-1) ----
   86: Zstd perf.data compression/decompression                        : FAILED!

Thanks,
Namhyung


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
>  tools/perf/util/trace-event-parse.c           |   2 +-
>  tools/perf/util/trace-event-scripting.c       |  10 +-
>  tools/perf/util/trace-event.h                 |   2 +-
>  23 files changed, 214 insertions(+), 146 deletions(-)
> 
> -- 
> 2.47.0.277.g8800431eea-goog
> 
