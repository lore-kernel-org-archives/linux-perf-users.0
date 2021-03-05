Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F7DC433E0
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Mar 2021 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD6C64FD4
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Mar 2021 08:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCEIyO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:54:14 -0500
Received: from foss.arm.com ([217.140.110.172]:49588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhCEIyK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Mar 2021 03:54:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601E6D6E;
        Fri,  5 Mar 2021 00:54:10 -0800 (PST)
Received: from [10.57.46.156] (unknown [10.57.46.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6AAD3F7D7;
        Fri,  5 Mar 2021 00:54:05 -0800 (PST)
Subject: Re: [PATCH RESEND WITH CCs v3 4/4] perf tools: determine if LR is the
 return address
To:     Alexandre Truong <alexandre.truong@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
 <20210304163255.10363-4-alexandre.truong@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <57fdc0c9-ea72-5cd0-405a-c7bff0daf9d6@arm.com>
Date:   Fri, 5 Mar 2021 10:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304163255.10363-4-alexandre.truong@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I've tested this patchset on a few different applications and have seen it significantly improve
quality of frame pointer stacks on aarch64. For example with GDB 10 and default build options,
'bfd_calc_gnu_debuglink_crc32' is a leaf function, and its caller 'gdb_bfd_crc' is ommitted,
but with the patchset it is included. I've also confirmed that this is correct from looking at
the source code.

Before:

        # Children      Self  Command          Shared Object               Symbol                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        # ........  ........  ...............  ..........................  ...........
        #
            34.55%     0.00%  gdb-100          gdb-100                     [.] _start
                   0.78%
                        _start
                        __libc_start_main
                        main
                        gdb_main
                        captured_command_loop
                        gdb_do_one_event
                        check_async_event_handlers
                        fetch_inferior_event
                        inferior_event_handler
                        do_all_inferior_continuations
                        attach_post_wait
                        post_create_inferior
                        svr4_solib_create_inferior_hook
                        solib_add
                        solib_read_symbols
                        symbol_file_add_with_addrs
                        read_symbols
                        elf_symfile_read
                        find_separate_debug_file_by_debuglink[abi:cxx11]
                        find_separate_debug_file
                        separate_debug_file_exists
                        gdb_bfd_crc
                        bfd_calc_gnu_debuglink_crc32

After:

        # Children      Self  Command          Shared Object               Symbol                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        # ........  ........  ...............  ..........................  ...........
        #
            34.55%     0.00%  gdb-100          gdb-100                     [.] _start
                   0.78%
                        _start
                        __libc_start_main
                        main
                        gdb_main
                        captured_command_loop
                        gdb_do_one_event
                        check_async_event_handlers
                        fetch_inferior_event
                        inferior_event_handler
                        do_all_inferior_continuations
                        attach_post_wait
                        post_create_inferior
                        svr4_solib_create_inferior_hook
                        solib_add
                        solib_read_symbols
                        symbol_file_add_with_addrs
                        read_symbols
                        elf_symfile_read
                        find_separate_debug_file_by_debuglink[abi:cxx11]
                        find_separate_debug_file
                        separate_debug_file_exists
                        get_file_crc   <--------------------- leaf frame caller added
                        bfd_calc_gnu_debuglink_crc32

There is a question about whether the overhead of recording all the registers is acceptable, for
filesize and time. We could make it a manual step, at the cost of not showing better frame pointer
stacks by default.

Tested-by: James Clark <james.clark@arm.com>

On 04/03/2021 18:32, Alexandre Truong wrote:
> On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
> use dwarf unwind info to check if the link register is the return
> address in order to inject it to the frame pointer stack.
> 
> Write the following application:
> 
> 	int a = 10;
> 
> 	void f2(void)
> 	{
> 		for (int i = 0; i < 1000000; i++)
> 			a *= a;
> 	}
> 
> 	void f1()
> 	{
> 		for (int i = 0; i < 10; i++)
> 			f2();
> 	}
> 
> 	int main (void)
> 	{
> 		f1();
> 		return 0;
> 	}
> 
> with the following compilation flags:
> 	gcc -fno-omit-frame-pointer -fno-inline -O2
> 
> The compiler omits the frame pointer for f2 on arm. This is a problem
> with any leaf call, for example an application with many different
> calls to malloc() would always omit the calling frame, even if it
> can be determined.
> 
> 	./perf record --call-graph fp ./a.out
> 	./perf report
> 
> currently gives the following stack:
> 
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f2
> 
> After this change, perf report correctly shows f1() calling f2(),
> even though it was missing from the frame pointer unwind:
> 
> 	./perf report
> 
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f1
> f2
> 
> Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Kemeng Shi <shikemeng@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Wilco Dijkstra <wilco.dijkstra@arm.com>
> ---
>  tools/perf/util/Build                         |  1 +
>  .../util/arm-frame-pointer-unwind-support.c   | 44 +++++++++++++++++++
>  .../util/arm-frame-pointer-unwind-support.h   |  7 +++
>  tools/perf/util/machine.c                     |  9 ++--
>  4 files changed, 58 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/arm-frame-pointer-unwind-support.c
>  create mode 100644 tools/perf/util/arm-frame-pointer-unwind-support.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 188521f34347..3b82cb992bce 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -1,3 +1,4 @@
> +perf-y += arm-frame-pointer-unwind-support.o
>  perf-y += annotate.o
>  perf-y += block-info.o
>  perf-y += block-range.o
> diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.c b/tools/perf/util/arm-frame-pointer-unwind-support.c
> new file mode 100644
> index 000000000000..964efd08e72e
> --- /dev/null
> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "arch/arm64/include/perf_regs.h"
> +#include "event.h"
> +#include "arm-frame-pointer-unwind-support.h"
> +#include "callchain.h"
> +#include "unwind.h"
> +
> +struct entries {
> +	u64 stack[2];
> +	size_t length;
> +};
> +
> +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
> +{
> +	return callchain_param.record_mode == CALLCHAIN_FP && sample->user_regs.regs
> +		&& sample->user_regs.mask == PERF_REGS_MASK;
> +}
> +
> +static int add_entry(struct unwind_entry *entry, void *arg)
> +{
> +	struct entries *entries = arg;
> +
> +	entries->stack[entries->length++] = entry->ip;
> +	return 0;
> +}
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread)
> +{
> +	int ret;
> +
> +	struct entries entries = {{0, 0}, 0};
> +
> +	if (!get_leaf_frame_caller_enabled(sample))
> +		return 0;
> +
> +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
> +
> +	if (ret || entries.length != 2)
> +		return ret;
> +
> +	return callchain_param.order == ORDER_CALLER ?
> +		entries.stack[0] : entries.stack[1];
> +}
> diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.h b/tools/perf/util/arm-frame-pointer-unwind-support.h
> new file mode 100644
> index 000000000000..16dc03fa9abe
> --- /dev/null
> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread);
> +
> +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 7f03ffa016b0..dfb72dbc0e2d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -34,6 +34,7 @@
>  #include "bpf-event.h"
>  #include <internal/lib.h> // page_size
>  #include "cgroup.h"
> +#include "arm-frame-pointer-unwind-support.h"
>  
>  #include <linux/ctype.h>
>  #include <symbol/kallsyms.h>
> @@ -2671,10 +2672,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
>  	return err;
>  }
>  
> -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
> -		struct thread *thread __maybe_unused)
> +static u64 get_leaf_frame_caller(struct perf_sample *sample, struct thread *thread)
>  {
> -	return 0;
> +	if (strncmp(thread->maps->machine->env->arch, "aarch64", 7) == 0)
> +		return get_leaf_frame_caller_aarch64(sample, thread);
> +	else
> +		return 0;
>  }
>  
>  static int thread__resolve_callchain_sample(struct thread *thread,
> 
