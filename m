From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Fri, 10 Dec 2010 17:26:59 +0900
Message-ID: <4D01E453.3000208@hitachi.com>
References: <m2pqtb9ekn.fsf@gmail.com>	<20101209153548.GA11820@ghostprotocols.net> <m2k4jiewhi.fsf@gmail.com>	<4D019E3F.4040902@hitachi.com> <m3pqtaxdv8.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:52824 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab0LJI1G (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Dec 2010 03:27:06 -0500
In-Reply-To: <m3pqtaxdv8.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Francis Moreau <francis.moro@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

(2010/12/10 16:53), Franck Bui-Huu wrote:
> 
> BTW, it seems to me that perf-probe(1) is ignoring the kernel path given
> by '-k' switch.
> 
> Looking at kernel_get_module_path(), it only considers the standard
> paths given by vmlinux_path[].
> 
> I would have seen this, no ?

Right! Thank you for finding the bug!


> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 694f04b..558545e 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -114,6 +114,8 @@ static struct symbol *__find_kernel_function_by_name(const char *name,
>  const char *kernel_get_module_path(const char *module)
>  {
>  	struct dso *dso;
> +	struct map *map;
> +	const char *vmlinux_name;
>  
>  	if (module) {
>  		list_for_each_entry(dso, &machine.kernel_dsos, node) {
> @@ -123,14 +125,23 @@ const char *kernel_get_module_path(const char *module)
>  		}
>  		pr_debug("Failed to find module %s.\n", module);
>  		return NULL;
> -	} else {
> -		dso = machine.vmlinux_maps[MAP__FUNCTION]->dso;
> -		if (dso__load_vmlinux_path(dso,
> -			 machine.vmlinux_maps[MAP__FUNCTION], NULL) < 0) {
> -			pr_debug("Failed to load kernel map.\n");
> -			return NULL;
> -		}
>  	}
> +
> +	map = machine.vmlinux_maps[MAP__FUNCTION];
> +	dso = map->dso;
> +
> +	vmlinux_name = symbol_conf.vmlinux_name;
> +	if (vmlinux_name) {
> +		if (dso__load_vmlinux(dso, map, vmlinux_name, NULL) == 0)
> +			goto found;
> +		return NULL;
> +	}
> +
> +	if (dso__load_vmlinux_path(dso, map, NULL) < 0) {
> +		pr_debug("Failed to load kernel map.\n");
> +		return NULL;
> +	}
> +

Hmm, could you put these changes into an else block?
Because this part is only for the kernel vmlinux, and
not for modules.

Thanks,


-- 
Masami HIRAMATSU
2nd Dept. Linux Technology Center
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
