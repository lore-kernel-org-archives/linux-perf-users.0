Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6642D3A93;
	Mon, 14 Sep 2026 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348385; cv=none; b=komOSxy1I+PP72lTSev918yQ24rERgb9rUSsKqYWxA6mgO2qpupXhc5bmbEI3Zc6P92ChP8ZsWf70LeaGVxQdAESaFbWZxRS09h3TPkkxcES1hde9FdsOpXFBuvDQ9IDh36kTOddYOCsEXfGH8qOZdkzNN4IAlESV4K2c1QhsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348385; c=relaxed/simple;
	bh=igCtFqliQnp/gR5uMJXNZJLWhekJJhWEy63N0y7KNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpWFrMFBh3wfEFmaB3IPSmDKyXS/q7PvC1nUe6cgEFvjFLwET80/UTQK/GpVJ8HzXMajwzOH0jNGR7+EJyJmAmzW1KBSRDaEYYo4Z+ji+0qmLi90qyOqAm2/5t/AIt7CW1nLwAVtXr1Nqjjt8ASu87ljiWX5u6U0G0aBljFNKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyKgo6VB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyKgo6VB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243521F000FF;
	Mon, 14 Sep 2026 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789348383;
	bh=S4ijoOjoBG1kX0MqJZWEgFLU5EKm1paRbUc8bRlvdk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CyKgo6VB09D3y+VTVGYgbuzn6oAD8oIBE8S2KhK7S+mlSQiC1h8dfAZmE5DZBPMgK
	 2IYgT2Bh/8gR5vNSIV/CF/1xQaa3owyUf3Q7LAKqWNWfyTOe2QMP925LKXNylPoCFA
	 8wAG/ujqldPeDinyiJV/j93HnXEj6g/aHX0GxA8sa+UGsFB5kbCWdgqdhP0U9OwX1a
	 70axJWpIo997MHmzPGsVXZ40nLcJajaaENbauYYCU3STkWHTR7mWjZAUdDcR8Ag9sx
	 qFSMa/arZUv8Q+nPVV6f1KNjb3EDHdCl/QOzPHacxsxrG7ebaN+if2wC3q1o3Zj3Qr
	 +3WIgOtXFPXgQ==
Date: Sun, 13 Sep 2026 18:13:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v8 0/6] perf: Add support for memory region/range
 reporting
Message-ID: <aqdKHTTfPHf8UjHA@google.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910194324.98002-1-thomas.falcon@intel.com>

Hello,

On Thu, Sep 10, 2026 at 02:43:18PM -0500, Thomas Falcon wrote:
> Add support for two memory-related reporting features in the perf tool:
> 
> 1. Memory region reporting in perf-c2c and perf-script subcommands.
> 2. Memory range data in perf.data file header and perf-c2c subcommand.
> 
> Memory region reporting was introduced as part of support for the
> Off-module Response facility (OMR) [1], which provides a new data
> source encoding supporting "up to 8 fine-grained memory regions in
> addition to the cache region, offering more detailed insights into
> memory access regions."
> 
> Memory Range support was introduced with the addition of the ACPI Memory
> Range and Region Mapping (MRRM) [2] table. It provides a base address plus
> a length value for each memory range, as well as NUMA node and local and
> remote "region ID's" so that "platform firmware can indicate the type of
> memory for each range."[3]
> 
> Include a change allowing PERF_MEM_LVLNUM_L0 to be printed in
> perf-mem output as well.

Thanks for working on this.  I think we need v9 for the patch 4 update,
but it mostly looks good to me.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
> [2]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.com/
> [3]: MRRM definition allow for future expansion for the OS to assign
> these region IDs.
> 
> v8:
> -- Updated developer tags and commit messages with real example output
>    from perf script and perf c2c
> 
> v7:
> -- perf-c2c: fix output_str allocation error handling that introduces a
>    memory leak (Sashiko)
> 
> v6: 
> -- Rebase on 7.3-rc1
> 
> v5:
> -- perf-c2c: make the cacheline header span and ui_quirks() width
>    fixup depend on memory-region availability (Namhyung Kim)
> 
> v4:
> -- perf-script: gate the Region field on the HEADER_MEMORY_RANGES feature
>    bit via perf_session instead of a global flag, with a pipe-mode fallback
> -- perf-c2c: fix output_str allocation error handling
> -- perf header: Fix typo in region id bounds checking which made region 255
>    invalid
> 
> v3:
> -- included missing ff-size check in process_memory_ranges
> -- make memory region reporting in perf c2c-and perf-script conditional
>    on feature bit, requiring some patch reordering (Namhyung Kim)
> -- used open/openat to read memory range sysfs files in memory_range__read()
>    (Namhyung Kim)
> -- Removed path name and file name buffers in memory_range__read(),
>    instead pass path name from as a parameter from memory_range__parse()
>    (Namhyung Kim)
> -- use calloc instead of zalloc in memory_range__parse() and
>    process_memory_ranges() (Namhyung Kim)
> -- Removed redundant check for existance of memory range directory in
>    memory_range__read() (Namhyung Kim)
> -- Included output examples of memory ranges in perf header and perf-c2c
>    in commit message (Namhyung Kim)
> 
> v2:
> -- Added missing newline in WARN_ONCE message in c2c_he__set_mem_region()
> -- increased buffers passed to perf_script__meminfo_scnprintf() from 150
>    to 200 bytes to avoid silent truncation
> -- Added check for NULL return of sysfs__mountpoint() when parsing
>    memory ranges in sysfs
> -- increased MAX_MEMORY_RANGES sanity check from 64 to 256 based on
>    ACPI MRRM table implementation in Linux kernel
> -- added comment for MAX_MEMORY_RANGES to clarify that it is a sanity check
>    for malformed perf.data files
> -- removed a line of code was removed from util/env.h but was added back in
>    v1 due to bad rebase
> 
> Dapeng Mi (3):
>   perf mem: Add support for printing PERF_MEM_LVLNUM_L0
>   perf tools: Show memory region in perf-c2c subcommand
>   perf tools: Show memory region in perf-script subcommand
> 
> Thomas Falcon (3):
>   perf mem: Fix size tracking for mem_lvl's in
>     perf_script__meminfo_scnprintf()
>   perf header: Support memory ranges
>   perf c2c: print memory region data with stdio output
> 
>  tools/perf/Documentation/perf-record.txt      |   2 +-
>  .../Documentation/perf.data-file-format.txt   |  13 ++
>  tools/perf/builtin-c2c.c                      | 128 ++++++++++-
>  tools/perf/builtin-inject.c                   |   1 +
>  tools/perf/builtin-script.c                   |  13 +-
>  tools/perf/util/bpf-filter.l                  |   1 +
>  tools/perf/util/c2c.h                         |   1 +
>  tools/perf/util/env.c                         |   1 +
>  tools/perf/util/env.h                         |  10 +
>  tools/perf/util/header.c                      | 203 ++++++++++++++++++
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/mem-events.c                  |  93 +++++++-
>  tools/perf/util/mem-events.h                  |   5 +-
>  .../scripting-engines/trace-event-python.c    |   5 +-
>  14 files changed, 454 insertions(+), 23 deletions(-)
> 
> -- 
> 2.43.0
> 
