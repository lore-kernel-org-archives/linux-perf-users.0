From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] perf probe: Adjust dso->long_name for offline module
Date: Thu, 26 Nov 2015 13:45:32 -0300
Message-ID: <20151126164532.GE28162@kernel.org>
References: <1448451059-156220-1-git-send-email-wangnan0@huawei.com>
 <1448510397-187965-1-git-send-email-wangnan0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43426 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbbKZQpg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 26 Nov 2015 11:45:36 -0500
Content-Disposition: inline
In-Reply-To: <1448510397-187965-1-git-send-email-wangnan0@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Wang Nan <wangnan0@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Zefan Li <lizefan@huawei.com>, pi3orama@163.com

Em Thu, Nov 26, 2015 at 03:59:57AM +0000, Wang Nan escreveu:
> Something unexpected may happen if copy statically linked perf to a
> production environment:
> 
>  # ./perf probe -m ./mymodule.ko my_func
>  [mymodule] with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
>  Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
>    Error: Failed to add events.
>  # ./perf buildid-cache -a ./mymodule.ko
>  # ./perf probe -m ./mymodule.ko my_func
>  Added new event:
>    probe:my_func        (on my_func in /home/wangnan/kmodule/mymodule.ko)
> 
>  You can now use it in all perf tools, such as:
> 
>  	perf record -e probe:my_func -aR sleep 1
> 
> Where:
> 
>  # ldd ./perf
> 	not a dynamic executable
>  # strace -e open ./perf probe -m ./mymodule.ko my_func
>  ...
>  open("/home/wangnan/kmodule/mymodule.ko", O_RDONLY) = 3
>  open("/home/wangnan/kmodule/../lib64/elfutils/libebl_x86_64.so", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>  ...
>  open("/lib64/tls/libebl_x86_64.so", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>  open("/lib64/libebl_x86_64.so", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>  open("/usr/lib64/tls/libebl_x86_64.so", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>  open("/usr/lib64/libebl_x86_64.so", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>  open("[mymodule]", O_RDONLY)            = -1 ENOENT (No such file or directory)
>  open("/home/wangnan/.debug/.build-id/32/6ab42550ef3d24944f53c817533728367effeb", O_RDONLY) = -1 ENOENT (No such file or directory)
>  open("[mymodule]", O_RDONLY)            = -1 ENOENT (No such file or directory)
> 
> In the above example, probe fails before we put the module into
> buildid-cache. However, user would expect it success in both case
> because perf is able to find probe points actually.
> 
> The reason is because perf won't utilize module's full path if it
> failed to open debuginfo. In
>  convert_to_probe_trace_events ->
>  find_probe_trace_events_from_map ->
>  get_target_map ->
>  kernel_get_module_map ->
>  machine__findnew_module_map ->
>  map_groups__find_by_name
> 
> map_groups__find_by_name() is able to find the map of that module, but
> this information is found from /proc/module before it knows the real
> path of the offline module. Therefore, the map->dso->long_name is
> set to something like '[mymodule]', which prevent dso__load() find
> the real path of the module file.
> 
> In another aspect, if dso__load() can get the offline module through
> buildid cache, it can read symble table from that ko. Even if debuginfo
> is not available, 'perf probe' can success if the '.symtab' can be
> found.
> 
> This patch improves machine__findnew_module_map(): when dso->long_name
> is leading with '[' (doesn't find path of module when parsing
> /proc/modules), fixes it by dso__set_long_name(), so following
> dso__load() is possible to find the symbol table.
> 
> This patch won't interfere with buildid matching. Here is the test
> result:
> 
>  # ./perf probe -m ./mymodule.ko my_func
>  Added new event:
>    probe:my_func        (on my_func in /home/wangnan/kmodule/mymodule.ko)
> 
>  You can now use it in all perf tools, such as:
> 
>  	perf record -e probe:my_func -aR sleep 1
> 
>  # ./perf probe -d '*'
>  Removed event: probe:my_func
>  # mv ./mymodule.{ko,.bak}
>  # mv ./moduleb.ko mymodule.ko
>  # ./perf probe -m ./mymodule.ko my_func
>  /home/wangnan/kmodule/mymodule.ko with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
>  Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
>    Error: Failed to add events.
> 
>  # ./perf probe -v -m ./mymodule.ko my_func
>  probe-definition(0): my_func
>  symbol:my_func file:(null) line:0 offset:0 return:0 lazy:(null)
>  0 arguments
>  Could not open debuginfo. Try to use symbols.
>  symsrc__init: build id mismatch for /home/wangnan/kmodule/mymodule.ko.
>  /home/wangnan/kmodule/mymodule.ko with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
>  Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
>    Error: Failed to add events. Reason: No such file or directory (Code: -2)
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Zefan Li <lizefan@huawei.com>
> Cc: pi3orama@163.com
> ---
> 
> v2 -> v3: pass dso to adjust_dso_long_name() instead of map
>           because adjust_dso_long_name() doesn't use other part of map.
> 
> ---
>  tools/perf/util/machine.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 7f5071a..5781992 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -561,6 +561,24 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
>  	return 0;
>  }
>  
> +static void adjust_dso_long_name(struct dso *dso, const char *filename)

Here, to follow convention, and also to better reflect what it does,
since it deals _only_ with kernel modules, not with all dsos, I'd call
it:

static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)

It will validate if it is a long name that needs fixing, by looking at
the fist character in long_name.

I thought about dso__set_kmod_long_name() but that would imply that it
would always set it to the filename provided, but 'adjust' seems better
as it will only do it if needed, i.e. if it is still in the initial
'[name]' form.

Since this is just naming, I'll do these changes and apply as you
already addressed Masami's request that this be done in machine.c, and I
agree with that, just please take the above rationale into account for
future patches.

Thanks,

- Arnaldo

> +{
> +	const char *dup_filename;
> +
> +	if (!filename || !dso || !dso->long_name)
> +		return;
> +	if (dso->long_name[0] != '[')
> +		return;
> +	if (!strchr(filename, '/'))
> +		return;
> +
> +	dup_filename = strdup(filename);
> +	if (!dup_filename)
> +		return;
> +
> +	dso__set_long_name(dso, filename, true);
> +}
> +
>  struct map *machine__findnew_module_map(struct machine *machine, u64 start,
>  					const char *filename)
>  {
> @@ -573,8 +591,15 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
>  
>  	map = map_groups__find_by_name(&machine->kmaps, MAP__FUNCTION,
>  				       m.name);
> -	if (map)
> +	if (map) {
> +		/*
> +		 * If the map's dso is an offline module, give dso__load()
> +		 * a chance to find the file path of that module by fixing
> +		 * long_name.
> +		 */
> +		adjust_dso_long_name(map->dso, filename);
>  		goto out;
> +	}
>  
>  	dso = machine__findnew_module_dso(machine, &m, filename);
>  	if (dso == NULL)
> -- 
> 1.8.3.4
