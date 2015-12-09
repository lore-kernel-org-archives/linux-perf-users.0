From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core  14/22] perf: Fix dso__load_sym to put dso
Date: Wed, 9 Dec 2015 11:16:01 -0300
Message-ID: <20151209141601.GE15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021118.10245.49869.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151209021118.10245.49869.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 09, 2015 at 11:11:18AM +0900, Masami Hiramatsu escreveu:
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1045,6 +1045,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
>  				/* kmaps already got it */
>  				map__put(curr_map);
>  				dsos__add(&map->groups->machine->dsos, curr_dso);
> +				/* curr_map and machine->dsos already got it */
> +				dso__put(curr_dso);
>  				dso__set_loaded(curr_dso, map->type);
>  			} else
>  				curr_dso = curr_map->dso;

Right, to make the code smaller, how about doing it this way, i.e. drop
the reference once we have that curr_dso object with a ref held by
curr_map, if curr_map doesn't get it, then we don't need and will drop
it anyway:

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 53f19968bfa2..84d787074152 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1026,8 +1026,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
 				curr_dso->long_name_len = dso->long_name_len;
 				curr_map = map__new2(start, curr_dso,
 						     map->type);
+				dso__put(curr_dso);
 				if (curr_map == NULL) {
-					dso__put(curr_dso);
 					goto out_elf_end;
 				}
 				if (adjust_kernel_syms) {
