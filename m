Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB175C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D4E61164
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhFVSee (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFVSee (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 14:34:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA8DD60249;
        Tue, 22 Jun 2021 18:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624386738;
        bh=B9NANQ0smxi+X8dxYT8cE0Zj87YRL+v9KXLf3n2tZZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWwSfP+1GduI+HMp+VAALExoZG8O1yA3UkuPNHQT8m0MsZ0QUcBCASlgz0xaSx3jq
         Xpvl7X+WAM24LbTviZbiXzkTiSJYnuAh22/lEaikX1LbO4U8Sj4J88LJ0g42ux1brw
         rpeQ6p3ko23+IfL0rlDjYkXFnyMrIz1yQM1YK3yE7qLJcGtGv8PG+E7jrhsWDK4T4s
         p/ZsSZiC4Q9++IKE/UiOvlLWFIw2S4I+uXprgJ2bvWC60TEUP/acCVtBRL0qJ2H2Gc
         DkWXzSIAO/oRx63tW0wxKJCOfAhUwEB9sKIrN/UgBQzP001Z+WDbtClQekdiCN35M7
         7Bo80pdStB/kA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2F1640B1A; Tue, 22 Jun 2021 15:32:15 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:32:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/11] perf script: Add API for filtering via
 dynamically loaded shared object
Message-ID: <YNIsr412oJu2qGpA@kernel.org>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
 <20210621150514.32159-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210621150514.32159-5-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 21, 2021 at 06:05:07PM +0300, Adrian Hunter escreveu:
> In some cases, users want to filter very large amounts of data (e.g. from
> AUX area tracing like Intel PT) looking for something specific. While
> scripting such as Python can be used, Python is 10 to 20 times slower than
> C. So define a C API so that custom filters can be written and loaded.

Statically linking with perf would be even faster 8-) But yeah, I think
its something useful, some notes below

A first question, can this be combined with pre-existing filters? I.e.

  perf script -C 0 --dlfilter file.so

?

Also in the docs we can state that after these custom filters get
polished and mature, it would be interesting to send them to be merged
upstream, where they could even be statically linked with perf, if a
profile session with it linked statically proves that.

Having a collection of such filters upstream we could then have
a similar interface as for the script collection to describe filters,
i.e. the .so file would have to have a description and perhaps a man
page:

⬢[acme@toolbox perf]$ perf script -l
List of available trace scripts:
  compaction-times [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-regex] display time taken by mm compaction
  event_analyzing_sample               analyze all perf samples
  export-to-postgresql [database name] [columns] [calls] export perf data to a postgresql database
  export-to-sqlite [database name] [columns] [calls] export perf data to a sqlite3 database
  failed-syscalls-by-pid [comm]        system-wide failed syscalls, by pid
  flamegraph                           create flame graphs
  futex-contention                     futext contention measurement
  intel-pt-events                      print Intel PT Events including Power Events and PTWRITE
  mem-phys-addr                        resolve physical address samples
  net_dropmonitor                      display a table of dropped frames
  netdev-times [tx] [rx] [dev=] [debug] display a process of packet and processing time
  powerpc-hcalls
  sched-migration                      sched migration overview
  sctop [comm] [interval]              syscall top
  stackcollapse                        produce callgraphs in short form for scripting use
  syscall-counts-by-pid [comm]         system-wide syscall counts, by pid
  syscall-counts [comm]                system-wide syscall counts
  failed-syscalls [comm]               system-wide failed syscalls
  rw-by-file <comm>                    r/w activity for a program, by file
  rw-by-pid                            system-wide r/w activity
  rwtop [interval]                     system-wide r/w top
  wakeup-latency                       system-wide min/max/avg wakeup latency
⬢[acme@toolbox perf]$

I.e. some 'perf script --list-dlfilters'
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-dlfilter.txt | 214 +++++++++++++
>  tools/perf/Documentation/perf-script.txt   |   7 +-
>  tools/perf/builtin-script.c                |  25 +-
>  tools/perf/util/Build                      |   1 +
>  tools/perf/util/dlfilter.c                 | 330 +++++++++++++++++++++
>  tools/perf/util/dlfilter.h                 |  74 +++++
>  tools/perf/util/perf_dlfilter.h            | 120 ++++++++
>  7 files changed, 769 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-dlfilter.txt
>  create mode 100644 tools/perf/util/dlfilter.c
>  create mode 100644 tools/perf/util/dlfilter.h
>  create mode 100644 tools/perf/util/perf_dlfilter.h
> 
> diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
> new file mode 100644
> index 000000000000..d8f80998790f
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-dlfilter.txt
> @@ -0,0 +1,214 @@
> +perf-dlfilter(1)
> +================
> +
> +NAME
> +----
> +perf-dlfilter - Filter sample events using a dynamically loaded shared
> +object file
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf script' [--dlfilter file.so ]
> +
> +DESCRIPTION
> +-----------
> +
> +This option is used to process data through a custom filter provided by a
> +dynamically loaded shared object file.
> +
> +API
> +---
> +
> +The API for filtering consists of the following:
> +
> +[source,c]
> +----
> +#include <perf/perf_dlfilter.h>
> +
> +const struct perf_dlfilter_fns perf_dlfilter_fns;
> +
> +int start(void **data);
> +int stop(void *data);
> +int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
> +----
> +
> +If implemented, 'start' will be called at the beginning, before any
> +calls to 'filter_event' . Return 0 to indicate success,
> +or return a negative error code. '*data' can be assigned for use by other
> +functions.
> +
> +If implemented, 'stop' will be called at the end, after any calls to
> +'filter_event'. Return 0 to indicate success, or
> +return a negative error code. 'data' is set by 'start'.
> +
> +If implemented, 'filter_event' will be called for each sample event.
> +Return 0 to keep the sample event, 1 to filter it out, or return a negative
> +error code. 'data' is set by 'start'. 'ctx' is needed for calls to
> +'perf_dlfilter_fns'.
> +
> +The perf_dlfilter_sample structure
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +'filter_event' is passed a perf_dlfilter_sample
> +structure, which contains the following fields:
> +[source,c]
> +----
> +/*
> + * perf sample event information (as per perf script and <linux/perf_event.h>)
> + */
> +struct perf_dlfilter_sample {
> +	__u32 size; /* Size of this structure (for compatibility checking) */

There is a 4-byte hole here, 

> +	__u64 ip;
> +	__s32 pid;
> +	__s32 tid;
> +	__u64 time;
> +	__u64 addr;
> +	__u64 id;
> +	__u64 stream_id;
> +	__u64 period;
> +	__u64 weight;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> +	__u16 ins_lat;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> +	__u16 p_stage_cyc;	/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */

Another

Can you move these last two __u16 to right after the 'size' field?

> +	__u64 transaction;	/* Refer PERF_SAMPLE_TRANSACTION in <linux/perf_event.h> */
> +	__u64 insn_cnt;	/* For instructions-per-cycle (IPC) */
> +	__u64 cyc_cnt;		/* For instructions-per-cycle (IPC) */
> +	__s32 cpu;
> +	__u32 flags;		/* Refer PERF_DLFILTER_FLAG_* above */
> +	__u64 data_src;		/* Refer PERF_SAMPLE_DATA_SRC in <linux/perf_event.h> */
> +	__u64 phys_addr;	/* Refer PERF_SAMPLE_PHYS_ADDR in <linux/perf_event.h> */
> +	__u64 data_page_size;	/* Refer PERF_SAMPLE_DATA_PAGE_SIZE in <linux/perf_event.h> */
> +	__u64 code_page_size;	/* Refer PERF_SAMPLE_CODE_PAGE_SIZE in <linux/perf_event.h> */
> +	__u64 cgroup;		/* Refer PERF_SAMPLE_CGROUP in <linux/perf_event.h> */
> +	__u8  cpumode;		/* Refer CPUMODE_MASK etc in <linux/perf_event.h> */
> +	__u8  addr_correlates_sym; /* True => resolve_addr() can be called */
> +	__u16 misc;		/* Refer perf_event_header in <linux/perf_event.h> */
> +	__u32 raw_size;		/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
> +	const void *raw_data;	/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
> +	__u64 brstack_nr;	/* Number of brstack entries */
> +	const struct perf_branch_entry *brstack; /* Refer <linux/perf_event.h> */
> +	__u64 raw_callchain_nr;	/* Number of raw_callchain entries */
> +	const __u64 *raw_callchain; /* Refer <linux/perf_event.h> */
> +	const char *event;
> +};
> +----
> +
> +The perf_dlfilter_fns structure
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The 'perf_dlfilter_fns' structure is populated with function pointers when the
> +file is loaded. The functions can be called by 'filter_event'.
> +
> +[source,c]
> +----
> +struct perf_dlfilter_fns {
> +	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
> +	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
> +	void *(*reserved[126])(void *);
> +};
> +----
> +
> +'resolve_ip' returns information about ip.
> +
> +'resolve_addr' returns information about addr (if addr_correlates_sym).
> +
> +The perf_dlfilter_al structure
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The 'perf_dlfilter_al' structure contains information about an address.
> +
> +[source,c]
> +----
> +/*
> + * Address location (as per perf script)
> + */
> +struct perf_dlfilter_al {
> +	__u32 size; /* Size of this structure (for compatibility checking) */
> +	__u32 symoff;
> +	const char *sym;
> +	__u64 addr; /* Mapped address (from dso) */
> +	__u64 sym_start;
> +	__u64 sym_end;
> +	const char *dso;
> +	__u8  sym_binding; /* STB_LOCAL, STB_GLOBAL or STB_WEAK, refer <elf.h> */
> +	__u8  is_64_bit; /* Only valid if dso is not NULL */
> +	__u8  is_kernel_ip; /* True if in kernel space */
> +	__u32 buildid_size;
> +	__u8 *buildid;
> +	/* Below members are only populated by resolve_ip() */
> +	__u8 filtered; /* true if this sample event will be filtered out */
> +	const char *comm;
> +};
> +----
> +
> +perf_dlfilter_sample flags
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The 'flags' member of 'perf_dlfilter_sample' corresponds with the flags field
> +of perf script. The bits of the flags are as follows:
> +
> +[source,c]
> +----
> +/* Definitions for perf_dlfilter_sample flags */
> +enum {
> +	PERF_DLFILTER_FLAG_BRANCH	= 1ULL << 0,
> +	PERF_DLFILTER_FLAG_CALL		= 1ULL << 1,
> +	PERF_DLFILTER_FLAG_RETURN	= 1ULL << 2,
> +	PERF_DLFILTER_FLAG_CONDITIONAL	= 1ULL << 3,
> +	PERF_DLFILTER_FLAG_SYSCALLRET	= 1ULL << 4,
> +	PERF_DLFILTER_FLAG_ASYNC	= 1ULL << 5,
> +	PERF_DLFILTER_FLAG_INTERRUPT	= 1ULL << 6,
> +	PERF_DLFILTER_FLAG_TX_ABORT	= 1ULL << 7,
> +	PERF_DLFILTER_FLAG_TRACE_BEGIN	= 1ULL << 8,
> +	PERF_DLFILTER_FLAG_TRACE_END	= 1ULL << 9,
> +	PERF_DLFILTER_FLAG_IN_TX	= 1ULL << 10,
> +	PERF_DLFILTER_FLAG_VMENTRY	= 1ULL << 11,
> +	PERF_DLFILTER_FLAG_VMEXIT	= 1ULL << 12,
> +};
> +----
> +
> +EXAMPLE
> +-------
> +
> +Filter out everything except branches from "foo" to "bar":
> +
> +[source,c]
> +----
> +#include <perf/perf_dlfilter.h>
> +#include <string.h>
> +
> +const struct perf_dlfilter_fns perf_dlfilter_fns;
> +
> +int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
> +{
> +	const struct perf_dlfilter_al *al;
> +	const struct perf_dlfilter_al *addr_al;
> +
> +	if (!sample->ip || !sample->addr_correlates_sym)
> +		return 1;
> +
> +	al = perf_dlfilter_fns.resolve_ip(ctx);
> +	if (!al || !al->sym || strcmp(al->sym, "foo"))
> +		return 1;
> +
> +	addr_al = perf_dlfilter_fns.resolve_addr(ctx);
> +	if (!addr_al || !addr_al->sym || strcmp(addr_al->sym, "bar"))
> +		return 1;
> +
> +	return 0;
> +}
> +----
> +
> +To build the shared object, assuming perf has been installed for the local user
> +i.e. perf_dlfilter.h is in ~/include/perf :
> +
> +	gcc -c -I ~/include -fpic dlfilter-example.c
> +	gcc -shared -o dlfilter-example.so dlfilter-example.o
> +
> +To use the filter with perf script:
> +
> +	perf script --dlfilter ./dlfilter-example.so
> +
> +SEE ALSO
> +--------
> +linkperf:perf-script[1]
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 48a5f5b26dd4..2306c81b606b 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -98,6 +98,10 @@ OPTIONS
>          Generate perf-script.[ext] starter script for given language,
>          using current perf.data.
>  
> +--dlfilter=<file>::
> +	Filter sample events using the given shared object file.
> +	Refer linkperf:perf-dlfilter[1]
> +
>  -a::
>          Force system-wide collection.  Scripts run without a <command>
>          normally use -a by default, while scripts run with a <command>
> @@ -483,4 +487,5 @@ include::itrace.txt[]
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-script-perl[1],
> -linkperf:perf-script-python[1], linkperf:perf-intel-pt[1]
> +linkperf:perf-script-python[1], linkperf:perf-intel-pt[1],
> +linkperf:perf-dlfilter[1]
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d2771a997e26..aaf2922643a0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -55,6 +55,7 @@
>  #include <subcmd/pager.h>
>  #include <perf/evlist.h>
>  #include <linux/err.h>
> +#include "util/dlfilter.h"
>  #include "util/record.h"
>  #include "util/util.h"
>  #include "perf.h"
> @@ -79,6 +80,7 @@ static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>  static struct perf_stat_config	stat_config;
>  static int			max_blocks;
>  static bool			native_arch;
> +static struct dlfilter		*dlfilter;
>  
>  unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
>  
> @@ -2175,6 +2177,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
>  	struct addr_location al;
>  	struct addr_location addr_al;
> +	int ret = 0;
>  
>  	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
>  					  sample->time)) {
> @@ -2213,6 +2216,13 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (evswitch__discard(&scr->evswitch, evsel))
>  		goto out_put;
>  
> +	ret = dlfilter__filter_event(dlfilter, event, sample, evsel, machine, &al, &addr_al);
> +	if (ret) {
> +		if (ret > 0)
> +			ret = 0;
> +		goto out_put;
> +	}
> +
>  	if (scripting_ops) {
>  		struct addr_location *addr_al_ptr = NULL;
>  
> @@ -2229,7 +2239,7 @@ static int process_sample_event(struct perf_tool *tool,
>  
>  out_put:
>  	addr_location__put(&al);
> -	return 0;
> +	return ret;
>  }
>  
>  static int process_attr(struct perf_tool *tool, union perf_event *event,
> @@ -3568,6 +3578,7 @@ int cmd_script(int argc, const char **argv)
>  	};
>  	struct utsname uts;
>  	char *script_path = NULL;
> +	const char *dlfilter_file = NULL;
>  	const char **__argv;
>  	int i, j, err = 0;
>  	struct perf_script script = {
> @@ -3615,6 +3626,7 @@ int cmd_script(int argc, const char **argv)
>  		     parse_scriptname),
>  	OPT_STRING('g', "gen-script", &generate_script_lang, "lang",
>  		   "generate perf-script.xx script in specified language"),
> +	OPT_STRING(0, "dlfilter", &dlfilter_file, "file", "filter .so file name"),
>  	OPT_STRING('i', "input", &input_name, "file", "input file name"),
>  	OPT_BOOLEAN('d', "debug-mode", &debug_mode,
>  		   "do various checks like samples ordering and lost events"),
> @@ -3933,6 +3945,12 @@ int cmd_script(int argc, const char **argv)
>  		exit(-1);
>  	}
>  
> +	if (dlfilter_file) {
> +		dlfilter = dlfilter__new(dlfilter_file);
> +		if (!dlfilter)
> +			return -1;
> +	}
> +
>  	if (!script_name) {
>  		setup_pager();
>  		use_browser = 0;
> @@ -4032,6 +4050,10 @@ int cmd_script(int argc, const char **argv)
>  		goto out_delete;
>  	}
>  
> +	err = dlfilter__start(dlfilter, session);
> +	if (err)
> +		goto out_delete;
> +
>  	if (script_name) {
>  		err = scripting_ops->start_script(script_name, argc, argv, session);
>  		if (err)
> @@ -4081,6 +4103,7 @@ int cmd_script(int argc, const char **argv)
>  
>  	if (script_started)
>  		cleanup_scripting();
> +	dlfilter__cleanup(dlfilter);
>  out:
>  	return err;
>  }
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 95e15d1035ab..1a909b53dc15 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -126,6 +126,7 @@ perf-y += parse-regs-options.o
>  perf-y += parse-sublevel-options.o
>  perf-y += term.o
>  perf-y += help-unknown-cmd.o
> +perf-y += dlfilter.o
>  perf-y += mem-events.o
>  perf-y += vsprintf.o
>  perf-y += units.o
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> new file mode 100644
> index 000000000000..15cb9de13a4b
> --- /dev/null
> +++ b/tools/perf/util/dlfilter.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dlfilter.c: Interface to perf script --dlfilter shared object
> + * Copyright (c) 2021, Intel Corporation.
> + */
> +#include <dlfcn.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/zalloc.h>
> +#include <linux/build_bug.h>
> +
> +#include "debug.h"
> +#include "event.h"
> +#include "evsel.h"
> +#include "dso.h"
> +#include "map.h"
> +#include "thread.h"
> +#include "symbol.h"
> +#include "dlfilter.h"
> +#include "perf_dlfilter.h"
> +
> +static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
> +{
> +	struct symbol *sym = al->sym;
> +
> +	d_al->size = sizeof(*d_al);
> +	if (al->map) {
> +		struct dso *dso = al->map->dso;
> +
> +		if (symbol_conf.show_kernel_path && dso->long_name)
> +			d_al->dso = dso->long_name;
> +		else
> +			d_al->dso = dso->name;
> +		d_al->is_64_bit = dso->is_64_bit;
> +		d_al->buildid_size = dso->bid.size;
> +		d_al->buildid = dso->bid.data;
> +	} else {
> +		d_al->dso = NULL;
> +		d_al->is_64_bit = 0;
> +		d_al->buildid_size = 0;
> +		d_al->buildid = NULL;
> +	}
> +	if (sym) {
> +		d_al->sym = sym->name;
> +		d_al->sym_start = sym->start;
> +		d_al->sym_end = sym->end;
> +		if (al->addr < sym->end)
> +			d_al->symoff = al->addr - sym->start;
> +		else
> +			d_al->symoff = al->addr - al->map->start - sym->start;
> +		d_al->sym_binding = sym->binding;
> +	} else {
> +		d_al->sym = NULL;
> +		d_al->sym_start = 0;
> +		d_al->sym_end = 0;
> +		d_al->symoff = 0;
> +		d_al->sym_binding = 0;
> +	}
> +	d_al->addr = al->addr;
> +	d_al->comm = NULL;
> +	d_al->filtered = 0;
> +}
> +
> +static struct addr_location *get_al(struct dlfilter *d)
> +{
> +	struct addr_location *al = d->al;
> +
> +	if (!al->thread && machine__resolve(d->machine, al, d->sample) < 0)
> +		return NULL;
> +	return al;
> +}
> +
> +static struct thread *get_thread(struct dlfilter *d)
> +{
> +	struct addr_location *al = get_al(d);
> +
> +	return al ? al->thread : NULL;
> +}
> +
> +static const struct perf_dlfilter_al *dlfilter__resolve_ip(void *ctx)
> +{
> +	struct dlfilter *d = (struct dlfilter *)ctx;
> +	struct perf_dlfilter_al *d_al = d->d_ip_al;
> +	struct addr_location *al;
> +
> +	if (!d->ctx_valid)
> +		return NULL;
> +
> +	/* 'size' is also used to indicate already initialized */
> +	if (d_al->size)
> +		return d_al;
> +
> +	al = get_al(d);
> +	if (!al)
> +		return NULL;
> +
> +	al_to_d_al(al, d_al);
> +
> +	d_al->is_kernel_ip = machine__kernel_ip(d->machine, d->sample->ip);
> +	d_al->comm = al->thread ? thread__comm_str(al->thread) : ":-1";
> +	d_al->filtered = al->filtered;
> +
> +	return d_al;
> +}
> +
> +static const struct perf_dlfilter_al *dlfilter__resolve_addr(void *ctx)
> +{
> +	struct dlfilter *d = (struct dlfilter *)ctx;
> +	struct perf_dlfilter_al *d_addr_al = d->d_addr_al;
> +	struct addr_location *addr_al = d->addr_al;
> +
> +	if (!d->ctx_valid || !d->d_sample->addr_correlates_sym)
> +		return NULL;
> +
> +	/* 'size' is also used to indicate already initialized */
> +	if (d_addr_al->size)
> +		return d_addr_al;
> +
> +	if (!addr_al->thread) {
> +		struct thread *thread = get_thread(d);
> +
> +		if (!thread)
> +			return NULL;
> +		thread__resolve(thread, addr_al, d->sample);
> +	}
> +
> +	al_to_d_al(addr_al, d_addr_al);
> +
> +	d_addr_al->is_kernel_ip = machine__kernel_ip(d->machine, d->sample->addr);
> +
> +	return d_addr_al;
> +}
> +
> +static const struct perf_dlfilter_fns perf_dlfilter_fns = {
> +	.resolve_ip      = dlfilter__resolve_ip,
> +	.resolve_addr    = dlfilter__resolve_addr,
> +};
> +
> +#define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
> +
> +static int dlfilter__init(struct dlfilter *d, const char *file)
> +{
> +	CHECK_FLAG(BRANCH);
> +	CHECK_FLAG(CALL);
> +	CHECK_FLAG(RETURN);
> +	CHECK_FLAG(CONDITIONAL);
> +	CHECK_FLAG(SYSCALLRET);
> +	CHECK_FLAG(ASYNC);
> +	CHECK_FLAG(INTERRUPT);
> +	CHECK_FLAG(TX_ABORT);
> +	CHECK_FLAG(TRACE_BEGIN);
> +	CHECK_FLAG(TRACE_END);
> +	CHECK_FLAG(IN_TX);
> +	CHECK_FLAG(VMENTRY);
> +	CHECK_FLAG(VMEXIT);
> +
> +	memset(d, 0, sizeof(*d));
> +	d->file = strdup(file);
> +	if (!d->file)
> +		return -1;
> +	return 0;
> +}
> +
> +static void dlfilter__exit(struct dlfilter *d)
> +{
> +	zfree(&d->file);
> +}
> +
> +static int dlfilter__open(struct dlfilter *d)
> +{
> +	d->handle = dlopen(d->file, RTLD_NOW);
> +	if (!d->handle) {
> +		pr_err("dlopen failed for: '%s'\n", d->file);
> +		return -1;
> +	}
> +	d->start = dlsym(d->handle, "start");
> +	d->filter_event = dlsym(d->handle, "filter_event");
> +	d->stop = dlsym(d->handle, "stop");
> +	d->fns = dlsym(d->handle, "perf_dlfilter_fns");
> +	if (d->fns)
> +		memcpy(d->fns, &perf_dlfilter_fns, sizeof(struct perf_dlfilter_fns));
> +	return 0;
> +}
> +
> +static int dlfilter__close(struct dlfilter *d)
> +{
> +	return dlclose(d->handle);
> +}
> +
> +struct dlfilter *dlfilter__new(const char *file)
> +{
> +	struct dlfilter *d = malloc(sizeof(*d));
> +
> +	if (!d)
> +		return NULL;
> +
> +	if (dlfilter__init(d, file))
> +		goto err_free;
> +
> +	if (dlfilter__open(d))
> +		goto err_exit;
> +
> +	return d;
> +
> +err_exit:
> +	dlfilter__exit(d);
> +err_free:
> +	free(d);
> +	return NULL;
> +}
> +
> +static void dlfilter__free(struct dlfilter *d)
> +{
> +	if (d) {
> +		dlfilter__exit(d);
> +		free(d);
> +	}
> +}
> +
> +int dlfilter__start(struct dlfilter *d, struct perf_session *session)
> +{
> +	if (d) {
> +		d->session = session;
> +		if (d->start)
> +			return d->start(&d->data);
> +	}
> +	return 0;
> +}
> +
> +static int dlfilter__stop(struct dlfilter *d)
> +{
> +	if (d && d->stop)
> +		return d->stop(d->data);
> +	return 0;
> +}
> +
> +void dlfilter__cleanup(struct dlfilter *d)
> +{
> +	if (d) {
> +		dlfilter__stop(d);
> +		dlfilter__close(d);
> +		dlfilter__free(d);
> +	}
> +}
> +
> +#define ASSIGN(x) d_sample.x = sample->x
> +
> +int dlfilter__do_filter_event(struct dlfilter *d,
> +			      union perf_event *event,
> +			      struct perf_sample *sample,
> +			      struct evsel *evsel,
> +			      struct machine *machine,
> +			      struct addr_location *al,
> +			      struct addr_location *addr_al)
> +{
> +	struct perf_dlfilter_sample d_sample;
> +	struct perf_dlfilter_al d_ip_al;
> +	struct perf_dlfilter_al d_addr_al;
> +	int ret;
> +
> +	d->event       = event;
> +	d->sample      = sample;
> +	d->evsel       = evsel;
> +	d->machine     = machine;
> +	d->al          = al;
> +	d->addr_al     = addr_al;
> +	d->d_sample    = &d_sample;
> +	d->d_ip_al     = &d_ip_al;
> +	d->d_addr_al   = &d_addr_al;
> +
> +	d_sample.size  = sizeof(d_sample);
> +	d_ip_al.size   = 0; /* To indicate d_ip_al is not initialized */
> +	d_addr_al.size = 0; /* To indicate d_addr_al is not initialized */
> +
> +	ASSIGN(ip);
> +	ASSIGN(pid);
> +	ASSIGN(tid);
> +	ASSIGN(time);
> +	ASSIGN(addr);
> +	ASSIGN(id);
> +	ASSIGN(stream_id);
> +	ASSIGN(period);
> +	ASSIGN(weight);
> +	ASSIGN(ins_lat);
> +	ASSIGN(p_stage_cyc);
> +	ASSIGN(transaction);
> +	ASSIGN(insn_cnt);
> +	ASSIGN(cyc_cnt);
> +	ASSIGN(cpu);
> +	ASSIGN(flags);
> +	ASSIGN(data_src);
> +	ASSIGN(phys_addr);
> +	ASSIGN(data_page_size);
> +	ASSIGN(code_page_size);
> +	ASSIGN(cgroup);
> +	ASSIGN(cpumode);
> +	ASSIGN(misc);
> +	ASSIGN(raw_size);
> +	ASSIGN(raw_data);
> +
> +	if (sample->branch_stack) {
> +		d_sample.brstack_nr = sample->branch_stack->nr;
> +		d_sample.brstack = (struct perf_branch_entry *)perf_sample__branch_entries(sample);
> +	} else {
> +		d_sample.brstack_nr = 0;
> +		d_sample.brstack = NULL;
> +	}
> +
> +	if (sample->callchain) {
> +		d_sample.raw_callchain_nr = sample->callchain->nr;
> +		d_sample.raw_callchain = (__u64 *)sample->callchain->ips;
> +	} else {
> +		d_sample.raw_callchain_nr = 0;
> +		d_sample.raw_callchain = NULL;
> +	}
> +
> +	d_sample.addr_correlates_sym =
> +		(evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
> +		sample_addr_correlates_sym(&evsel->core.attr);
> +
> +	d_sample.event = evsel__name(evsel);
> +
> +	d->ctx_valid = true;
> +
> +	ret = d->filter_event(d->data, &d_sample, d);
> +
> +	d->ctx_valid = false;
> +
> +	return ret;
> +}
> diff --git a/tools/perf/util/dlfilter.h b/tools/perf/util/dlfilter.h
> new file mode 100644
> index 000000000000..671e2d3d5a06
> --- /dev/null
> +++ b/tools/perf/util/dlfilter.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * dlfilter.h: Interface to perf script --dlfilter shared object
> + * Copyright (c) 2021, Intel Corporation.
> + */
> +
> +#ifndef PERF_UTIL_DLFILTER_H
> +#define PERF_UTIL_DLFILTER_H
> +
> +struct perf_session;
> +union  perf_event;
> +struct perf_sample;
> +struct evsel;
> +struct machine;
> +struct addr_location;
> +struct perf_dlfilter_fns;
> +struct perf_dlfilter_sample;
> +struct perf_dlfilter_al;
> +
> +struct dlfilter {
> +	char				*file;
> +	void				*handle;
> +	void				*data;
> +	struct perf_session		*session;
> +	bool				ctx_valid;
> +
> +	union perf_event		*event;
> +	struct perf_sample		*sample;
> +	struct evsel			*evsel;
> +	struct machine			*machine;
> +	struct addr_location		*al;
> +	struct addr_location		*addr_al;
> +	struct perf_dlfilter_sample	*d_sample;
> +	struct perf_dlfilter_al		*d_ip_al;
> +	struct perf_dlfilter_al		*d_addr_al;
> +
> +	int (*start)(void **data);
> +	int (*stop)(void *data);
> +
> +	int (*filter_event)(void *data,
> +			    const struct perf_dlfilter_sample *sample,
> +			    void *ctx);
> +
> +	struct perf_dlfilter_fns *fns;
> +};
> +
> +struct dlfilter *dlfilter__new(const char *file);
> +
> +int dlfilter__start(struct dlfilter *d, struct perf_session *session);
> +
> +int dlfilter__do_filter_event(struct dlfilter *d,
> +			      union perf_event *event,
> +			      struct perf_sample *sample,
> +			      struct evsel *evsel,
> +			      struct machine *machine,
> +			      struct addr_location *al,
> +			      struct addr_location *addr_al);
> +
> +void dlfilter__cleanup(struct dlfilter *d);
> +
> +static inline int dlfilter__filter_event(struct dlfilter *d,
> +					 union perf_event *event,
> +					 struct perf_sample *sample,
> +					 struct evsel *evsel,
> +					 struct machine *machine,
> +					 struct addr_location *al,
> +					 struct addr_location *addr_al)
> +{
> +	if (!d || !d->filter_event)
> +		return 0;
> +	return dlfilter__do_filter_event(d, event, sample, evsel, machine, al, addr_al);
> +}
> +
> +#endif
> diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
> new file mode 100644
> index 000000000000..132f833f0a0b
> --- /dev/null
> +++ b/tools/perf/util/perf_dlfilter.h
> @@ -0,0 +1,120 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * perf_dlfilter.h: API for perf --dlfilter shared object
> + * Copyright (c) 2021, Intel Corporation.
> + */
> +#ifndef _LINUX_PERF_DLFILTER_H
> +#define _LINUX_PERF_DLFILTER_H
> +
> +#include <linux/perf_event.h>
> +#include <linux/types.h>
> +
> +/* Definitions for perf_dlfilter_sample flags */
> +enum {
> +	PERF_DLFILTER_FLAG_BRANCH	= 1ULL << 0,
> +	PERF_DLFILTER_FLAG_CALL		= 1ULL << 1,
> +	PERF_DLFILTER_FLAG_RETURN	= 1ULL << 2,
> +	PERF_DLFILTER_FLAG_CONDITIONAL	= 1ULL << 3,
> +	PERF_DLFILTER_FLAG_SYSCALLRET	= 1ULL << 4,
> +	PERF_DLFILTER_FLAG_ASYNC	= 1ULL << 5,
> +	PERF_DLFILTER_FLAG_INTERRUPT	= 1ULL << 6,
> +	PERF_DLFILTER_FLAG_TX_ABORT	= 1ULL << 7,
> +	PERF_DLFILTER_FLAG_TRACE_BEGIN	= 1ULL << 8,
> +	PERF_DLFILTER_FLAG_TRACE_END	= 1ULL << 9,
> +	PERF_DLFILTER_FLAG_IN_TX	= 1ULL << 10,
> +	PERF_DLFILTER_FLAG_VMENTRY	= 1ULL << 11,
> +	PERF_DLFILTER_FLAG_VMEXIT	= 1ULL << 12,
> +};
> +
> +/*
> + * perf sample event information (as per perf script and <linux/perf_event.h>)
> + */
> +struct perf_dlfilter_sample {
> +	__u32 size; /* Size of this structure (for compatibility checking) */
> +	__u64 ip;
> +	__s32 pid;
> +	__s32 tid;
> +	__u64 time;
> +	__u64 addr;
> +	__u64 id;
> +	__u64 stream_id;
> +	__u64 period;
> +	__u64 weight;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> +	__u16 ins_lat;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> +	__u16 p_stage_cyc;	/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> +	__u64 transaction;	/* Refer PERF_SAMPLE_TRANSACTION in <linux/perf_event.h> */
> +	__u64 insn_cnt;	/* For instructions-per-cycle (IPC) */
> +	__u64 cyc_cnt;		/* For instructions-per-cycle (IPC) */
> +	__s32 cpu;
> +	__u32 flags;		/* Refer PERF_DLFILTER_FLAG_* above */
> +	__u64 data_src;		/* Refer PERF_SAMPLE_DATA_SRC in <linux/perf_event.h> */
> +	__u64 phys_addr;	/* Refer PERF_SAMPLE_PHYS_ADDR in <linux/perf_event.h> */
> +	__u64 data_page_size;	/* Refer PERF_SAMPLE_DATA_PAGE_SIZE in <linux/perf_event.h> */
> +	__u64 code_page_size;	/* Refer PERF_SAMPLE_CODE_PAGE_SIZE in <linux/perf_event.h> */
> +	__u64 cgroup;		/* Refer PERF_SAMPLE_CGROUP in <linux/perf_event.h> */
> +	__u8  cpumode;		/* Refer CPUMODE_MASK etc in <linux/perf_event.h> */
> +	__u8  addr_correlates_sym; /* True => resolve_addr() can be called */
> +	__u16 misc;		/* Refer perf_event_header in <linux/perf_event.h> */
> +	__u32 raw_size;		/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
> +	const void *raw_data;	/* Refer PERF_SAMPLE_RAW in <linux/perf_event.h> */
> +	__u64 brstack_nr;	/* Number of brstack entries */
> +	const struct perf_branch_entry *brstack; /* Refer <linux/perf_event.h> */
> +	__u64 raw_callchain_nr;	/* Number of raw_callchain entries */
> +	const __u64 *raw_callchain; /* Refer <linux/perf_event.h> */
> +	const char *event;
> +};
> +
> +/*
> + * Address location (as per perf script)
> + */
> +struct perf_dlfilter_al {
> +	__u32 size; /* Size of this structure (for compatibility checking) */
> +	__u32 symoff;
> +	const char *sym;
> +	__u64 addr; /* Mapped address (from dso) */
> +	__u64 sym_start;
> +	__u64 sym_end;
> +	const char *dso;
> +	__u8  sym_binding; /* STB_LOCAL, STB_GLOBAL or STB_WEAK, refer <elf.h> */
> +	__u8  is_64_bit; /* Only valid if dso is not NULL */
> +	__u8  is_kernel_ip; /* True if in kernel space */
> +	__u32 buildid_size;
> +	__u8 *buildid;
> +	/* Below members are only populated by resolve_ip() */
> +	__u8 filtered; /* True if this sample event will be filtered out */
> +	const char *comm;
> +};
> +
> +struct perf_dlfilter_fns {
> +	/* Return information about ip */
> +	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
> +	/* Return information about addr (if addr_correlates_sym) */
> +	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
> +	/* Reserved */
> +	void *(*reserved[126])(void *);
> +};
> +
> +/*
> + * If implemented, 'start' will be called at the beginning,
> + * before any calls to 'filter_event'. Return 0 to indicate success,
> + * or return a negative error code. '*data' can be assigned for use
> + * by other functions.
> + */
> +int start(void **data);
> +
> +/*
> + * If implemented, 'stop' will be called at the end,
> + * after any calls to 'filter_event'. Return 0 to indicate success, or
> + * return a negative error code. 'data' is set by start().
> + */
> +int stop(void *data);
> +
> +/*
> + * If implemented, 'filter_event' will be called for each sample
> + * event. Return 0 to keep the sample event, 1 to filter it out, or
> + * return a negative error code. 'data' is set by start(). 'ctx' is
> + * needed for calls to perf_dlfilter_fns.
> + */
> +int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
> +
> +#endif
> -- 
> 2.17.1
> 

-- 

- Arnaldo
