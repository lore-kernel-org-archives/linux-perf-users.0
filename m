Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0B483BE9;
	Tue,  4 Aug 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863497; cv=none; b=tZB+8g+mMBYasAqJdpn6WPyWQCgS7oSen4B1abgSJ1+kZkscvZnhFVFdJr1lUzFWszasye4QuDJ9yEPS+YPRCxDg8tnZIm3kLCCwIdpfYDrMzTinhf9UyB1dbaAYpyMwItLVRrnriDFiWhh+z0nOnlCj9SL1iVmY4CRpCJlzfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863497; c=relaxed/simple;
	bh=snErptEN7swa2qfyvgS3TMKj15+lzYb7uwBNWnxs5b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUUgkx3zjpaKbSPTbWZ/NPyDH8YxtSiVHqzUm6zRoBWWy04qKVdvFseVNUGcPIp1iV2sIsoddPJpP5w18QD/XZbkvbnR9DntMZcWsjUDTaIcfjn8tFxwkJY5ua/zyqVGgl1vSHMvRzEs8cWA7DR5PVHdhzxQOrqVaVpm1W26BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U15hPaqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U15hPaqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6761F000E9;
	Tue,  4 Aug 2026 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863486;
	bh=hTC479HM7EHrH2maTiTAeS9hJ7C7HZJRusCjnPicEaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U15hPaqruBCd+lm/EnJ37nSj7UFeNNbVlD+1JhEGVUv7n1MnJApWV44sboijqUJsD
	 w9EZY7bl7e3uTvGAMVS1QkzD85hya6mN99PgsTy2DZ9TB6ORGOdL13cIdXPEY9azcD
	 mRo8D25WnrI9raQBlRUAIjr+1Btyv82wKAmgFFHWiSQmpw4MaIf5AK4NMngpKfw9dy
	 uRt02xaMMQL5CmBEyDslGG49NhnrBXUUhB8Sq3UMI8tUlsCEVaRw26mVJnrS/UMetL
	 hZF/Q79/eHUC9HxycloUPXps3npVBV28+69A5fGXj0NOU9CnnJR7mN8aXIO+2bURVk
	 etzzgloFpf4sw==
Date: Tue, 4 Aug 2026 10:11:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] perf sched latency: Refine outputs, unit scaling,
 and histogram support
Message-ID: <anIdO3ejoRWTF_0V@google.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802210914.199941-1-atomlin@atomlin.com>

On Sun, Aug 02, 2026 at 05:09:10PM -0400, Aaron Tomlin wrote:
> This patch series improves 'perf sched latency' by suppressing misleading
> empty table output, extending pipe mode stream processing, introducing
> dynamic unit auto-scaling for latency and runtime statistics, and adding
> latency histogram visualisation alongside time-span filtering.
> 
> Patch 1 addresses an issue where 'perf sched latency' fell through and
> returned success (0) when perf_session__has_traces() failed due to missing
> tracepoint events in a perf.data file. This caused empty header tables and
> zeroed summary statistics to be rendered. In addition,
> thread__get_runtime() in map_switch_event() is guarded against potential
> NULL pointer dereferences under memory allocation failures.
> 
> Patch 2 extends pipe mode stream support. Because event attributes in pipe
> mode are received dynamically during event processing, session->evlist is
> not populated prior to event processing.
> To handle pipe input correctly:
>     - Missing callbacks (.attr, .tracing_data, .build_id, and .feature) are
>       registered in cmd_sched() so header events are parsed correctly
> 
>     - The handlers array is promoted to file-scope (latency_handlers[]) and
>       evlist__set_tracepoints_handlers() is invoked dynamically inside
>       perf_sched__process_tracepoint_sample() when evsel->handler is NULL
> 
>     - Trace presence checks are performed post-processing when handling
>       pipe data, while non-pipe files continue to abort early upfront
> 
> Patch 3 introduces dynamic auto-scaling for latency and runtime display
> columns (Runtime, Avg delay, Max delay). Previously, all values were
> unconditionally formatted in milliseconds (ms), making microsecond- or
> second-scale latencies difficult to read. Columns are now dynamically
> scaled to the most appropriate unit (ns, us, ms, s), column headers are
> updated, and format specifiers are aligned character-for-character with
> table headers.
> 
> Patch 4 adds three new command-line options to 'perf sched latency':
>     --histogram (-H):
>             Displays an ASCII bar chart of CPU wait latencies between
>             snapshots
>     --hist-mode:
>             Configures the bucketing scheme to either logarithmic (log) or
>             100 us equal-width linear (linear) mode
>     --time:
>             Filters trace event processing to a specified [start,stop] time
>             span

Can you please also add a test case to check the basic functionality?

Thanks,
Namhyung

> 
> Changes since v6:
> 
>  - Fixed O(N) hot-path traversal overhead in
>    perf_sched__process_tracepoint_sample() for unhandled tracepoints by
>    assigning a dummy ignore handler (process_sched_ignore)
> 
>  - Replaced evlist__set_tracepoints_handlers() in sample processing with a
>    per-evsel lookup to prevent -EEXIST early aborts and avoid dropping
>    late-arriving pipe events
> 
>  - Updated commit message for the pipe mode patch to reflect the
>    single-pass handler assignment logic
> 
>  - Link to v6: https://lore.kernel.org/lkml/20260801234008.176724-1-atomlin@atomlin.com/
> 
> Changes since v5:
> 
>  - Split pipe mode trace sample handling from Patch 1 into a standalone
>    patch (Namhyung Kim)
> 
>  - Added a Fixes: tag to the pipe mode patch referencing commit
>    27295592c22e ("perf session: Share the common trace sample_check routine
>    as perf_session__has_traces")
> 
>  - Updated commit log with before and after illustrations of table header
>    formatting
> 
>  - Link to v5: https://lore.kernel.org/lkml/20260730185416.97166-1-atomlin@atomlin.com/
> 
> Changes since v4:
> 
>  - Added the missing .feature callback to sched.tool in cmd_sched()
> 
>  - Fixed memory leak by reusing uncompleted work atoms when sched_in events
>    are skipped or lost
> 
>  - Promoted the handlers array to file-scope (i.e., latency_handlers[]) and
>    added a dynamic lookup via evlist__set_tracepoints_handlers() inside
>    perf_sched__process_tracepoint_sample() whenever a sample arrives with
>    an unattached handler (i.e., evsel->handler == NULL)
> 
>  - Prevented double-counting wakeups (i.e., ignore sched:sched_wakeup)
>    in pipe mode and non-pipe modes
> 
>  - Added missing trailing pipe in output_lat_thread's new auto-scaling
>    format string
> 
>  - Stripped redundant prefix strings from each row's format string to
>    produce a clean, tabular output
> 
>  - Link to v4: https://lore.kernel.org/lkml/20260729144451.38286-1-atomlin@atomlin.com/
> 
> Changes since v3:
> 
>  - Registered Missing Callbacks. In perf_tool__init configuration inside
>    cmd_sched(), added the .attr, .tracing_data, and .build_id callbacks.
>    Without these callbacks, pipe mode drops header attributes entirely,
>    preventing tracepoints from being populated in session->evlist
> 
>  - Introduced an explicit post-processing pipe check. This ensures that
>    pipe mode aborts correctly and does not produce superfluous empty
>    latency tables when no trace samples are available
> 
>  - Prevented potential NULL pointer dereference. Added a NULL check for
>    thread__get_runtime() in map_switch_event() under memory allocation
>    failures
> 
>  - Fixed column alignment. Modified format specifiers to align
>    character-for-character with header column widths across all rows
> 
>  - Adjusted header label padding. Updated header label padding and column
>    width delimiters in perf_sched__lat() to match the exact field format
>    specifiers printed in output_lat_thread()
> 
>  - Fixed swapper histogram inclusion. Excluded "swapper" (i.e.,
>    CPU-specific idle thread) from global_hist buckets
> 
>  - Preserved task state machine across --time bounds. Moved time-window
>    filtering inside add_sched_in_event() to gate latency statistics
>    recording without breaking wakeup state tracking across time interval
>    boundaries
> 
>  - Link to v3: https://lore.kernel.org/lkml/20260726032533.712462-1-atomlin@atomlin.com/
> 
> Changes since v2:
> 
>  - Ensured vertical pipe separators align across all latency table columns
> 
>  - Excluded "swapper" (idle thread) latency samples from global_hist
> 
>  - Preserved task state machine transitions across --time boundaries
> 
>  - Suppressed empty table headers, total lines, and histogram graphs when
>    no matching trace samples exist (e.g., when --time, --CPU, or --pids
>    exclude all samples), outputting "No matching trace samples found."
>    instead
> 
>  - Linked to v2: https://lore.kernel.org/lkml/20260725173341.679782-1-atomlin@atomlin.com/
> 
> Changes since v1:
> 
>  - Fixed integer overflow in latency_bucket() (Ian Rogers)
> 
>  - Linked to v1: https://lore.kernel.org/lkml/20260724142901.634761-1-atomlin@atomlin.com/
> 
> Aaron Tomlin (4):
>   perf sched: Suppress latency table output when trace samples are
>     missing
>   perf sched: Handle missing trace samples in pipe mode
>   perf sched latency: Auto-scale latency and runtime display units
>   perf sched latency: Add histogram and time interval options
> 
>  tools/perf/Documentation/perf-sched.txt |   6 +
>  tools/perf/builtin-sched.c              | 338 +++++++++++++++++++++---
>  2 files changed, 301 insertions(+), 43 deletions(-)
> 
> -- 
> 2.55.0
> 
