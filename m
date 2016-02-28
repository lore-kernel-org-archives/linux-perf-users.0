From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [RFC] perf: probe_finder: continue if atleast one probe point
 found
Date: Sun, 28 Feb 2016 20:35:55 +0900
Message-ID: <56D2DB9B.4090500@gmail.com>
References: <1456658087-4107-1-git-send-email-agnel.joel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456658087-4107-1-git-send-email-agnel.joel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel.opensrc@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: agnel.joel@gmail.com
List-Id: linux-perf-users.vger.kernel.org

Hi, Joel

perf subsystem's maintainers are
Arnaldo Carvalho de Melo <acme@kernel.org>
Peter Zijlstra <peterz@infradead.org>
Ingo Molnar <mingo@redhat.com>

(or Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>)

AFAIK,
When sending some patches, it would be better to add them into To: or Cc:


Thanks,
Taeung

On 02/28/2016 08:14 PM, Joel Fernandes wrote:
> Sometimes for inline functions, perf probe can fail such as if an arguments are
> requested at probe points. This is probably because when the compiler inlines,
> for some instances it optimizes away arguments. Either way, the DWARF has
> missing arguments for certain probe points of inline functions causing 'perf
> probe' to fail. I noticed this when probing the C library that ships with my
> distribution. With the following patch I am successfully able to record kprobe
> events with arguments.
>
> Test
> ----
>   ./perf probe \
>     -k ./vmlinux -s ./ -x /lib/x86_64-linux-gnu/libc.so.6 -a 'malloc bytes' -v
>
> Without the patch
> -----------------
> Matched function: __libc_malloc
> found inline addr: 0x831a6
> Probe point found: malloc_atfork+150
> Searching 'bytes' variable in context.
> Converting variable bytes into trace event.
> bytes type is long unsigned int.
> found inline addr: 0x844a0
> Probe point found: __libc_malloc+0
> Searching 'bytes' variable in context.
> Converting variable bytes into trace event.
> bytes type is long unsigned int.
> found inline addr: 0x8463b
> Probe point found: __malloc_get_state+11
> Searching 'bytes' variable in context.
> Failed to find 'bytes' in this function.
> An error occurred in debuginfo analysis (-2).
>    Error: Failed to add events. Reason: No such file or directory (Code: -2)
>
> With the patch
> --------------
> Open Debuginfo file: /usr/lib/debug/lib/x86_64-linux-gnu/libc-2.21.so
> Try to find probe point from debuginfo.
> Symbol malloc address found : 844a0
> Matched function: __libc_malloc
> found inline addr: 0x831a6
> Probe point found: malloc_atfork+150
> Searching 'bytes' variable in context.
> Converting variable bytes into trace event.
> bytes type is long unsigned int.
> found inline addr: 0x844a0
> Probe point found: __libc_malloc+0
> Searching 'bytes' variable in context.
> Converting variable bytes into trace event.
> bytes type is long unsigned int.
> found inline addr: 0x8463b
> Probe point found: __malloc_get_state+11
> Searching 'bytes' variable in context.
> Failed to find 'bytes' in this function.
> Probe point error, ignoring. Atleast one probe point found
> found inline addr: 0x84bba
> Probe point found: __libc_realloc+410
> Searching 'bytes' variable in context.
> Failed to find 'bytes' in this function.
> Probe point error, ignoring. Atleast one probe point found
> found inline addr: 0x84d08
> ...
> Probe point error, ignoring. Atleast one probe point found
> Found 3 probe_trace_events.
> Opening /sys/kernel/debug/tracing//uprobe_events write=1
> Writing event: p:probe_libc/malloc /lib/x86_64-linux-gnu/libc-2.21.so:0x831a6 bytes=%bp:u64
> Writing event: p:probe_libc/malloc_1 /lib/x86_64-linux-gnu/libc-2.21.so:0x844a0 bytes=%di:u64
> Writing event: p:probe_libc/malloc_2 /lib/x86_64-linux-gnu/libc-2.21.so:0x85af7 bytes=%di:u64
> Added new events:
>    probe_libc:malloc    (on malloc in /lib/x86_64-linux-gnu/libc-2.21.so with bytes)
>    probe_libc:malloc_1  (on malloc in /lib/x86_64-linux-gnu/libc-2.21.so with bytes)
>    probe_libc:malloc_2  (on malloc in /lib/x86_64-linux-gnu/libc-2.21.so with bytes)
>
> Signed-off-by: Joel Fernandes <agnel.joel@gmail.com>
> ---
>   tools/perf/util/probe-finder.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 4ce5c5e..3ac9481 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1255,6 +1255,10 @@ end:
>   	if (ret) {
>   		clear_probe_trace_event(tev);
>   		tf->ntevs--;
> +		if (tf->ntevs != 0) {
> +			pr_debug("Ignoring error as atleast one probe point found.\n");
> +			ret = 0;
> +		}
>   	}
>   	free(args);
>   	return ret;
>
