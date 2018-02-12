From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tracing/fgraph: Missed irq return mark for leaf entry
Date: Mon, 12 Feb 2018 10:56:05 +0900
Message-ID: <20180212015605.GF31513@sejong>
References: <1517413729-20411-1-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517413729-20411-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 31, 2018 at 11:48:49PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> The fgraph forget to print irq return mark for leaf entry. Then we can see
> unbalanced irq mark in the trace. This patch fix this.
> 
> Before:
>  1)               |  SyS_write() {
>  1)               |    __fdget_pos() {
>  1)   0.061 us    |      __fget_light();
>  1)   0.289 us    |    }
>  1)               |    vfs_write() {
>  1)   0.049 us    |      rw_verify_area();
>  1) + 15.424 us   |      __vfs_write();
>  1)   ==========> |
>  1)   6.003 us    |      smp_apic_timer_interrupt();
>  1)   0.055 us    |      __fsnotify_parent();
>  1)   0.073 us    |      fsnotify();
>  1) + 23.665 us   |    }
>  1) + 24.501 us   |  }
> 
> After:
>  0)               |  SyS_write() {
>  0)               |    __fdget_pos() {
>  0)   0.052 us    |      __fget_light();
>  0)   0.328 us    |    }
>  0)               |    vfs_write() {
>  0)   0.057 us    |      rw_verify_area();
>  0)               |      __vfs_write() {
>  0)   ==========> |
>  0)   8.548 us    |      smp_apic_timer_interrupt();
>  0)   <========== |
>  0) + 36.507 us   |      } /* __vfs_write */
>  0)   0.049 us    |      __fsnotify_parent();
>  0)   0.066 us    |      fsnotify();
>  0) + 50.064 us   |    }
>  0) + 50.952 us   |  }
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  kernel/trace/trace_functions_graph.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 23c0b0c..169b3c4 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -831,6 +831,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  	struct ftrace_graph_ret *graph_ret;
>  	struct ftrace_graph_ent *call;
>  	unsigned long long duration;
> +	int cpu = iter->cpu;
>  	int i;
>  
>  	graph_ret = &ret_entry->ret;
> @@ -839,7 +840,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  
>  	if (data) {
>  		struct fgraph_cpu_data *cpu_data;
> -		int cpu = iter->cpu;
>  
>  		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
>  
> @@ -869,6 +869,9 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  
>  	trace_seq_printf(s, "%ps();\n", (void *)call->func);
>  
> +	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
> +			cpu, iter->ent->pid, flags);
> +
>  	return trace_handle_return(s);
>  }
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
