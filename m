From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core 21/22] perf: Fix machine.vmlinux_maps to make
 sure to clear the old one
Date: Wed, 9 Dec 2015 12:22:56 -0300
Message-ID: <20151209152256.GL15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021133.10245.93730.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54164 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbbLIPXJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 10:23:09 -0500
Content-Disposition: inline
In-Reply-To: <20151209021133.10245.93730.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Wed, Dec 09, 2015 at 11:11:33AM +0900, Masami Hiramatsu escreveu:
> Fix machine.vmlinux_maps to make sure to clear the old one
> if it is renewal. This can leak the previous maps on the
> vmlinux_maps because those are just overwritten.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---
>  tools/perf/util/machine.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index bfc289c..3172aa5 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -44,6 +44,8 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  	machine->comm_exec = false;
>  	machine->kernel_start = 0;
>  
> +	memset(machine->vmlinux_maps, 0, sizeof(struct map *) * MAP__NR_TYPES);


Simpler:

	memset(machine->vmlinux_maps, 0, sizeof(machine->vmlinux_maps));

struct machine {
 	...
	struct map *vmlinux_maps[MAP__NR_TYPES];
 	...
};

[acme@zoo c]$ cat pointer_array_sizeof.c 
#include <stdio.h>

struct foo { int *array[2]; };
struct bar { int *array[4]; };

int main(void)
{
	struct foo *foo; struct bar *bar;

	printf("sizeof(foo->array)=%zd\n", sizeof(foo->array));
	printf("sizeof(bar->array)=%zd\n", sizeof(bar->array));
	return 0;
}
[acme@zoo c]$ make pointer_array_sizeof
cc     pointer_array_sizeof.c   -o pointer_array_sizeof
[acme@zoo c]$ ./pointer_array_sizeof 
sizeof(foo->array)=16
sizeof(bar->array)=32
[acme@zoo c]$

> +
>  	machine->root_dir = strdup(root_dir);
>  	if (machine->root_dir == NULL)
>  		return -ENOMEM;
> @@ -770,6 +772,9 @@ int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  	enum map_type type;
>  	u64 start = machine__get_running_kernel_start(machine, NULL);
>  
> +	/* In case of renewal the kernel map, destroy previous one */
> +	machine__destroy_kernel_maps(machine);
> +
>  	for (type = 0; type < MAP__NR_TYPES; ++type) {
>  		struct kmap *kmap;
>  		struct map *map;
