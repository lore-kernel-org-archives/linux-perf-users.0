From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf probe: Adjust dso->long_name for offline module
Date: Wed, 25 Nov 2015 16:35:32 -0300
Message-ID: <20151125193532.GC2945@kernel.org>
References: <1448451059-156220-1-git-send-email-wangnan0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37714 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbbKYTfh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 14:35:37 -0500
Content-Disposition: inline
In-Reply-To: <1448451059-156220-1-git-send-email-wangnan0@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Wang Nan <wangnan0@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Zefan Li <lizefan@huawei.com>, pi3orama@163.com

Em Wed, Nov 25, 2015 at 11:30:59AM +0000, Wang Nan escreveu:
> If libelf unable to open debuginfo for an offline module but the ko has
> symtab, something unexpected may happen.
> 
>  # rm -rf ~/.debug/
>  # mv /usr/lib64/elfutils/libebl_x86_64.so{,.bak}
>  # ./perf probe -m /home/wangnan/kmodule/mymodule.ko my_func
>  [mymodule] with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
>  Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko

Understood, since we are giving the path to that module, we can, if its
build-id matches the one for the online module, use it, is that the
case, i.e. do we check, int his scenario, that the build-id matches?

- Arnaldo

>    Error: Failed to add events
>  # ./perf buildid-cache -a ./mymodule.ko
>  # ./perf probe -m /home/wangnan/kmodule/mymodule.ko my_func
>  Added new event:
>    probe:my_func        (on my_func in /home/wangnan/kmodule/mymodule.ko)
> 
>  You can now use it in all perf tools, such as:
> 
> 	 perf record -e probe:my_func -aR sleep 1
> 
> In the above example, probe fails if it isn't in buildid-cache. However,
> user would expect it success in both case because perf is able to find
> probe points actually.
> 
> The problem is because perf won't utilize module's full path if it
> failed to open debuginfo. In
>  convert_to_probe_trace_events ->
>  find_probe_trace_events_from_map ->
>  get_target_map ->
>  kernel_get_module_map ->
>  machine__findnew_module_map ->
>  map_groups__find_by_name
> 
> map_groups__find_by_name() is able to find the map of that module, but
> this information is found from /proc/modules before it knows the real
> path of the offline module. Therefore, the map->dso->long_name is
> set to something like '[mymodule]', which prevents dso__load() find
> the real path of the module file.
> 
> In another aspect, if dso__load() can get the offline module through
> buildid cache, it can read symble table from that ko. Even if debuginfo
> is not available, 'perf probe' can success if the '.symtab' can be
> found.
> 
> This patch fixes long_name so dso__load() is able to find module's path
> and read symbol table in this case.
> 
> After this patch:
> 
>  # rm -rf ~/.debug/
>  # mv /usr/lib64/elfutils/libebl_x86_64.so{,.bak}
>  # ./perf probe -m /home/wangnan/kmodule/mymodule.ko my_func
>  Added new event:
>    probe:my_func        (on my_func in /home/wangnan/kmodule/mymodule.ko)
> 
>  You can now use it in all perf tools, such as:
> 
>  	perf record -e probe:my_func -aR sleep 1
> 
>  # mv /usr/lib64/elfutils/libebl_x86_64.so{.bak,}
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Zefan Li <lizefan@huawei.com>
> Cc: pi3orama@163.com
> ---
>  tools/perf/util/probe-event.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 93996ec..ea4f79f 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2516,6 +2516,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  	struct probe_trace_point *tp;
>  	int num_matched_functions;
>  	int ret, i, j, skipped = 0;
> +	const char *dup_filename;
>  
>  	map = get_target_map(pev->target, pev->uprobes);
>  	if (!map) {
> @@ -2523,6 +2524,21 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  		goto out;
>  	}
>  
> +	/*
> +	 * If the map's dso is an offline module, give dso__load() a chance
> +	 * to find the file path of that module by fixing long_name.
> +	 */
> +	if (map->dso && strchr(pev->target, '/')) {
> +		if (!map->dso->long_name || map->dso->long_name[0] == '[') {
> +			dup_filename = strdup(pev->target);
> +			if (!dup_filename) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			dso__set_long_name(map->dso, dup_filename, true);
> +		}
> +	}
> +
>  	syms = malloc(sizeof(struct symbol *) * probe_conf.max_probes);
>  	if (!syms) {
>  		ret = -ENOMEM;
> -- 
> 1.8.3.4
