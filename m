From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: fix off-by-one for non-activation frames
Date: Tue, 16 May 2017 23:38:29 +0900
Message-ID: <20170516143829.GA12886@danjae.aot.lge.com>
References: <20170516085951.4056-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32795 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdEPOin (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2017 10:38:43 -0400
Content-Disposition: inline
In-Reply-To: <20170516085951.4056-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Tue, May 16, 2017 at 10:59:51AM +0200, Milian Wolff wrote:
> As the documentation for dwfl_frame_pc says, frames that
> are no activation frames need to have their program counter
> decremented by one to properly find the function of the caller.
> 
> This fixes many cases where perf report currently attributes
> the cost to the next line. I.e. I have code like this:
> 
> ~~~~~~~~~~~~~~~
>   #include <thread>
>   #include <chrono>
> 
>   using namespace std;
> 
>   int main()
>   {
>     this_thread::sleep_for(chrono::milliseconds(1000));
>     this_thread::sleep_for(chrono::milliseconds(100));
>     this_thread::sleep_for(chrono::milliseconds(10));
> 
>     return 0;
>   }
> ~~~~~~~~~~~~~~~

It'd be nice if the test program has a signal frame for verification.


> 
> Now compile and record it:
> 
> ~~~~~~~~~~~~~~~
> g++ -std=c++11 -g -O2 test.cpp
> echo 1 | sudo tee /proc/sys/kernel/sched_schedstats
> perf record \
>     --event sched:sched_stat_sleep \
>     --event sched:sched_process_exit \
>     --event sched:sched_switch --call-graph=dwarf \
>     --output perf.data.raw \
>     ./a.out
> echo 0 | sudo tee /proc/sys/kernel/sched_schedstats
> perf inject --sched-stat --input perf.data.raw --output perf.data
> ~~~~~~~~~~~~~~~
> 
> Before this patch, the report clearly shows the off-by-one issue.
> Most notably, the last sleep invocation is incorrectly attributed
> to the "return 0;" line:
> 
> ~~~~~~~~~~~~~~~
>   Overhead  Source:Line
>   ........  ...........
> 
>    100.00%  core.c:0
>             |
>             ---__schedule core.c:0
>                schedule
>                do_nanosleep hrtimer.c:0
>                hrtimer_nanosleep
>                sys_nanosleep
>                entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
>                __nanosleep_nocancel .:0
>                std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > thread:323
>                |
>                |--90.08%--main test.cpp:9
>                |          __libc_start_main
>                |          _start
>                |
>                |--9.01%--main test.cpp:10
>                |          __libc_start_main
>                |          _start
>                |
>                 --0.91%--main test.cpp:13
>                           __libc_start_main
>                           _start
> ~~~~~~~~~~~~~~~
> 
> With this patch here applied, the issue is fixed. The report becomes
> much more usable:
> 
> ~~~~~~~~~~~~~~~
>   Overhead  Source:Line
>   ........  ...........
> 
>    100.00%  core.c:0
>             |
>             ---__schedule core.c:0
>                schedule
>                do_nanosleep hrtimer.c:0
>                hrtimer_nanosleep
>                sys_nanosleep
>                entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
>                __nanosleep_nocancel .:0
>                std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > thread:323
>                |
>                |--90.08%--main test.cpp:8
>                |          __libc_start_main
>                |          _start
>                |
>                |--9.01%--main test.cpp:9
>                |          __libc_start_main
>                |          _start
>                |
>                 --0.91%--main test.cpp:10
>                           __libc_start_main
>                           _start
> ~~~~~~~~~~~~~~~
> 
> Note how this patch fixes this issue for both unwinding methods, i.e.
> both dwfl and libunwind. The former case is straight-forward thanks
> to dwfl_frame_pc. For libunwind, we replace the functionality via
> unw_is_signal_frame for any but the very first frame.
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/unwind-libdw.c           |  6 +++++-
>  tools/perf/util/unwind-libunwind-local.c | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> v2:
> - use unw_is_signal_frame to also fix this issue for libunwind
> 
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index f90e11a555b2..943a06291587 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -168,12 +168,16 @@ frame_callback(Dwfl_Frame *state, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	Dwarf_Addr pc;
> +	bool isactivation;
>  
> -	if (!dwfl_frame_pc(state, &pc, NULL)) {
> +	if (!dwfl_frame_pc(state, &pc, &isactivation)) {
>  		pr_err("%s", dwfl_errmsg(-1));
>  		return DWARF_CB_ABORT;
>  	}
>  
> +	if (!isactivation)
> +		--pc;
> +
>  	return entry(pc, ui) || !(--ui->max_stack) ?
>  	       DWARF_CB_ABORT : DWARF_CB_OK;
>  }
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index f8455bed6e65..30ab26375c80 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -690,8 +690,22 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
>  		if (ret)
>  			display_error(ret);
>  
> +		bool previous_frame_was_signal = false;
>  		while (!ret && (unw_step(&c) > 0) && i < max_stack) {
>  			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
> +
> +			/*
> +			 * Decrement the IP for any non-activation frames.
> +			 * this is required to properly find the srcline
> +			 * for caller frames.
> +			 * See also the documentation for dwfl_frame_pc,
> +			 * which this code tries to replicate.
> +			 */
> +			bool frame_is_signal = unw_is_signal_frame(&c) > 0;
> +			if (!previous_frame_was_signal && !frame_is_signal)
> +				--ips[i];
> +			previous_frame_was_signal = frame_is_signal;

Does it need to check previous frame too?

Thanks,
Namhyung


> +
>  			++i;
>  		}
>  
> -- 
> 2.13.0
> 
