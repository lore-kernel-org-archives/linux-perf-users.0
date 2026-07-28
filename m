Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636343FD13;
	Tue, 28 Jul 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260857; cv=none; b=UlpPep5gztg90oMkL1PTY08lvDnjy4PHOoVMvMo7DF6TicCPhKzBQrc7PWVwxuiFikGDjSwhCWJ2iZ6X1glFpBM6Ypsz8HLkVqeYX4kOCU4lSHKFNwBO4xZvNfI7LHt11fvn5EYMhiQhZUsjzM7A4jj7BonHK32evyFXDWdO320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260857; c=relaxed/simple;
	bh=3I54izyt0Wxorg8g4iGL8+ZzBmWz1hKAcTYN5y50nb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr68T4Pz3YU0K/hn4Mk+1+wvIKi+zzfseRHQnkpGtCeFJGzVtjS18fmKg08v7/X678ZaNdAOS6BDqvvMFyZB0EOD5TpSaeqw7b1sGOAUtpqKtKm11mnDuDpKLBsLqOh83z1FKYFUzyr8l8L1Ra+ascGIvzhD9dfWgK6wSJeJpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvzdlxSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvzdlxSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F61C1F000E9;
	Tue, 28 Jul 2026 17:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260855;
	bh=T40JWmaAzvFumyUl0UkfaQn4LPI5KSGw0V+DcT6+9FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AvzdlxSdEXp+a4Gllw9Rn/LmR9BfTniIPn119UkwJ61V8MftqtjHA3gFZ8ucnXHWj
	 UKCvwiEygIEFVGY9khT5/oRYjHYdR/4PwhJYznRM8oxLXGV7EKQl2Xj8OzsPwMw/hi
	 NMKwmD5cyelr8UCv8PWxhSjgUbzntrwWgZEhttgW+96Pg0/KZZQMeYEofpq8tAPIkZ
	 kekvjnQuj7MioFqe1XaeeLPK+F83l9OAWkdugzswvXuXWG25BykJY/2byiNUkbkXXa
	 Ao94WAao0+UuSGuzxISfhSq0SLyK/a9/YnUrpYHA6s/Qg9ajtINy0LOAa4dtZVkUSM
	 Jj8GVl0paC4UQ==
Date: Tue, 28 Jul 2026 10:47:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alessio Podda <aleph.pi.gh@gmail.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>
Subject: Re: [PATCH v2] perf unwind-libdw: Fix unwinding of multi-threaded
 processes
Message-ID: <amjrNfiS8qsMyF9O@google.com>
References: <CAP-5=fVpWMOg8PE_b9or5PHwLBY0H1UNOZRxUXR-5=qwEW2M0g@mail.gmail.com>
 <20260724154057.896074-1-aleph.pi.gh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724154057.896074-1-aleph.pi.gh@gmail.com>

On Fri, Jul 24, 2026 at 05:40:57PM +0200, Alessio Podda wrote:
> The libdw callback API has two levels: dwfl_getthread_frames() first finds
> the requested thread using the next_thread() or get_thread() callback and
> then walks its stack.
> 
> Since perf only has a snapshot of the stack of a single thread, it
> provides a stubbed-out API that always returns the pid the Dwfl was
> attached with (i.e. whatever was passed to dwfl_attach_state()), rather
> than the actual sampled thread's TID.
> 
> Commit 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF
> after every unwind") changed libdw unwinding from recreating the Dwfl
> object for each sample to caching it in struct maps, which is shared by
> every thread in the process. It left next_thread() unchanged.
> 
> Since the pid passed to dwfl_attach_state() is only set at creation, only
> the thread of the first sample is ever found. As a result,
> dwfl_getthread_frames() fails with ESRCH when asked to unwind a sample
> from another thread.
> 
> Make next_thread() return the current sample's TID, provide get_thread()
> so libdw can find it directly, and pass the process PID expected by
> dwfl_attach_state(). This allows libdw to unwind samples from every thread
> in a multi-threaded process.
> 
> Add a shell regression test that records a four-thread workload and
> verifies that libdw recovers the worker callchain for every worker TID.
> 
> Fixes: 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every unwind")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Alessio Podda <aleph.pi.gh@gmail.com>
> ---
> Changes in v2:
> - Add a shell regression test for multi-threaded libdw unwinding.
> - Include <assert.h> directly instead of relying on a transitive include.

Ian, are you ok with this now?

Thanks,
Namhyung

> 
>  .../shell/test_dwarf_unwind_multithreaded.sh  | 65 +++++++++++++++++++
>  tools/perf/util/unwind-libdw.c                | 24 ++++++-
>  2 files changed, 86 insertions(+), 3 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh
> 
> diff --git a/tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh b/tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh
> new file mode 100755
> index 000000000000..49e6e3af771f
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Test libdw unwinding of multi-threaded processes (exclusive)
> +
> +set -e
> +
> +if ! perf check feature -q libdw-dwarf-unwind; then
> +	echo "Skip: libdw DWARF unwinding is not available"
> +	exit 2
> +fi
> +
> +tmpdir=$(mktemp -d /tmp/perf-test-dwarf-unwind-multithreaded.XXXXXX)
> +perf_data="$tmpdir/perf.data"
> +perf_script="$tmpdir/perf-script.txt"
> +nr_threads=4
> +nr_worker_threads=$((nr_threads - 1))
> +
> +cleanup()
> +{
> +	trap - EXIT TERM INT
> +	rm -rf "$tmpdir"
> +}
> +
> +trap cleanup EXIT TERM INT
> +
> +if ! perf record -q -e task-clock:u -F 99 --call-graph dwarf,8192 \
> +	-o "$perf_data" -- perf test -w thloop 2 "$nr_threads"
> +then
> +	echo "Skip: failed to record task-clock:u"
> +	exit 2
> +fi
> +
> +if ! perf script --unwind-style=libdw \
> +	-F comm,pid,tid,event,ip,sym -i "$perf_data" > "$perf_script"
> +then
> +	echo "Error: failed to process the recording with libdw" >&2
> +	exit 1
> +fi
> +
> +nr_unwound_threads=$(
> +	awk '
> +		BEGIN { RS = "" }
> +
> +		# thfunc is the worker-only caller of test_loop. Finding it proves
> +		# that libdw unwound beyond the sampled leaf for this worker TID.
> +		/thfunc/ {
> +			split($2, id, "/")
> +			seen[id[2]] = 1
> +		}
> +
> +		END {
> +			for (tid in seen)
> +				nr_tids++
> +			print nr_tids + 0
> +		}
> +	' "$perf_script"
> +)
> +
> +if [ "$nr_unwound_threads" -ne "$nr_worker_threads" ]; then
> +	echo "Error: expected callchains for $nr_worker_threads worker TIDs," \
> +		"found $nr_unwound_threads" >&2
> +	exit 1
> +fi
> +
> +exit 0
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index 7f35042be567..63a5c2253174 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <assert.h>
>  #include <linux/compiler.h>
>  #include <elfutils/libdw.h>
>  #include <elfutils/libdwfl.h>
> @@ -173,14 +174,30 @@ static int entry(u64 ip, struct unwind_info *ui)
>  	return 0;
>  }
>  
> -static pid_t next_thread(Dwfl *dwfl, void *arg, void **thread_argp)
> +static pid_t next_thread(Dwfl *dwfl __maybe_unused, void *arg, void **thread_argp)
>  {
> +	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
> +
>  	/* We want only single thread to be processed. */
>  	if (*thread_argp != NULL)
>  		return 0;
>  
> +	assert(dwfl_ui_ti->ui != NULL);
>  	*thread_argp = arg;
> -	return dwfl_pid(dwfl);
> +	return thread__tid(dwfl_ui_ti->ui->thread);
> +}
> +
> +static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
> +		       void **thread_argp)
> +{
> +	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
> +
> +	assert(dwfl_ui_ti->ui != NULL);
> +	if (tid != thread__tid(dwfl_ui_ti->ui->thread))
> +		return false;
> +
> +	*thread_argp = arg;
> +	return true;
>  }
>  
>  static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
> @@ -306,6 +323,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  
>  static const Dwfl_Thread_Callbacks callbacks = {
>  	.next_thread           = next_thread,
> +	.get_thread            = get_thread,
>  	.memory_read           = memory_read,
>  	.set_initial_registers = libdw_set_initial_registers,
>  };
> @@ -400,7 +418,7 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
>  	if (err)
>  		goto out;
>  
> -	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__tid(thread), &callbacks,
> +	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__pid(thread), &callbacks,
>  			  /* Dwfl thread function argument*/dwfl_ui_ti);
>  	// Ignore thread already attached error.
>  
> 
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> -- 
> 2.55.0
