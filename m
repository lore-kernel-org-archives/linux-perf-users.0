From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] Allow user probes on versioned symbols
Date: Fri, 31 Mar 2017 14:31:23 -0300
Message-ID: <20170331173123.GA18286@kernel.org>
References: <e12df271-9336-28c0-7441-2c20c6824b86@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e12df271-9336-28c0-7441-2c20c6824b86@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 31, 2017 at 11:06:16AM -0500, Paul Clarke escreveu:
> Symbol versioning, as in glibc, results in symbols being defined as:
> <real symbol>@[@]<version>
> (Note that "@@" identifies a default symbol, if the symbol name
> is repeated.)
> 
> perf is currently unable to deal with this, and is unable to create
> user probes at such symbols:

On top of what tree/branch should I try to apply this?

Trying on acme/perf/core:

[acme@jouet linux]$ patch -p1 < /wb/1.patch 
patching file tools/perf/util/auxtrace.c
Hunk #1 FAILED at 1875.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/auxtrace.c.rej
patching file tools/perf/util/map.c
Hunk #1 FAILED at 330.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/map.c.rej
patching file tools/perf/util/map.h
Hunk #1 FAILED at 130.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/map.h.rej
patching file tools/perf/util/symbol.c
Hunk #1 FAILED at 411.
Hunk #2 FAILED at 429.
2 out of 2 hunks FAILED -- saving rejects to file tools/perf/util/symbol.c.rej
[acme@jouet linux.copy]$ 

Apart from that, you are not checking the return of strndup, that
however unlikely, can fail, so must be checked.

On the style front you sometimes add a space after commas, sometimes
not, please make sure you add one.

But apart from those problems, I think that one should be able to ask
for a versioned symbol, to probe just apps using that specific version,
for instance, we should consider the whole name as two functions, which
in fact, they are, no?

Additionaly, I can't reproduce your problem here, on x86_64:

[root@jouet linux]# nm /lib64/libpthread-2.24.so  | grep ' pthread_cond_timedwait'
000000000000dd90 T pthread_cond_timedwait@GLIBC_2.2.5
000000000000d6e0 T pthread_cond_timedwait@@GLIBC_2.3.2
[root@jouet linux]#

[root@jouet linux]# perf probe -x /lib64/libpthread-2.24.so pthread_cond_timedwait@GLIBC_2.2.5
Probe point 'pthread_cond_timedwait@GLIBC_2.2.5' not found.
  Error: Failed to add events.
[root@jouet linux]# 

- Arnaldo

> --
> $ nm /lib/powerpc64le-linux-gnu/libpthread.so.0 | grep pthread_create
> 0000000000008d30 t __pthread_create_2_1
> 0000000000008d30 T pthread_create@@GLIBC_2.17
> $ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
> probe-definition(0): pthread_create
> symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Open Debuginfo file: /usr/lib/debug/lib/powerpc64le-linux-gnu/libpthread-2.19.so
> Try to find probe point from debuginfo.
> Probe point 'pthread_create' not found.
>    Error: Failed to add events. Reason: No such file or directory (Code: -2)
> --
> 
> One is not able to specify the fully versioned symbol, either, due to
> syntactic conflicts with other uses of "@" by perf:
> --
> $ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create@@GLIBC_2.17
> probe-definition(0): pthread_create@@GLIBC_2.17
> Semantic error :SRC@SRC is not allowed.
> 0 arguments
>    Error: Command Parse Error. Reason: Invalid argument (Code: -22)
> --
> 
> The attached patch ignores versioning for default symbols, thus
> allowing probes to be created for these symbols:
> --
> $ /usr/bin/sudo ./perf probe -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
> Added new event:
>    probe_libpthread:pthread_create (on pthread_create in /lib/powerpc64le-linux-gnu/libpthread-2.19.so)
> 
> You can now use it in all perf tools, such as:
> 
>          perf record -e probe_libpthread:pthread_create -aR sleep 1
> 
> $ /usr/bin/sudo ./perf record -e probe_libpthread:pthread_create -aR ./test 2
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.052 MB perf.data (2 samples) ]
> $ /usr/bin/sudo ./perf script
>              test  2915 [000] 19124.260729: probe_libpthread:pthread_create: (3fff99248d38)
>              test  2916 [000] 19124.260962: probe_libpthread:pthread_create: (3fff99248d38)
> $ /usr/bin/sudo ./perf probe --del=probe_libpthread:pthread_create
> Removed event: probe_libpthread:pthread_create
> --
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
> v3:
> - code style fixes per David Ahern
> 
> v2:
> - move logic from arch__compare_symbol_names to new map__compare_symbol_names
> - call through from map__compare_symbol_names to arch__compare_symbol_names
> - redirect uses of arch__compare_symbol_names
> - send patch to LKML
> 
>  tools/perf/util/auxtrace.c |  2 +-
>  tools/perf/util/map.c      | 23 +++++++++++++++++++++++
>  tools/perf/util/map.h      |  3 ++-
>  tools/perf/util/symbol.c   |  4 ++--
>  4 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index c5a6e0b1..f3511a6 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1875,7 +1875,7 @@ static bool dso_sym_match(struct symbol *sym, const char *name, int *cnt,
>  			  int idx)
>  {
>  	/* Same name, and global or the n'th found or any */
> -	return !arch__compare_symbol_names(name, sym->name) &&
> +	return !map__compare_symbol_names(name, sym->name) &&
>  	       ((!idx && sym->binding == STB_GLOBAL) ||
>  		(idx > 0 && ++*cnt == idx) ||
>  		idx < 0);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 4f9a71c..26a3e87 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -330,6 +330,29 @@ int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
>  	return strcmp(namea, nameb);
>  }
> +int map__compare_symbol_names(const char *namea, const char *nameb)
> +{
> +	int rc;
> +	const char *namea_versioning, *nameb_versioning;
> +
> +	namea_versioning = strstr(namea,"@@");
> +	if (namea_versioning)
> +		namea = strndup(namea,namea_versioning-namea);
> +
> +	nameb_versioning = strstr(nameb,"@@");
> +	if (nameb_versioning)
> +		nameb = strndup(nameb,nameb_versioning-nameb);
> +
> +	rc = arch__compare_symbol_names(namea, nameb);
> +
> +	if (namea_versioning)
> +		free((void *)namea);
> +	if (nameb_versioning)
> +		free((void *)nameb);
> +
> +	return rc;
> +}
> +
>  struct symbol *map__find_symbol(struct map *map, u64 addr)
>  {
>  	if (map__load(map) < 0)
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index abdacf8..aaad64d 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -130,13 +130,14 @@ struct thread;
>   */
>  #define __map__for_each_symbol_by_name(map, sym_name, pos)	\
>  	for (pos = map__find_symbol_by_name(map, sym_name);	\
> -	     pos && arch__compare_symbol_names(pos->name, sym_name) == 0;	\
> +	     pos && map__compare_symbol_names(pos->name, sym_name) == 0;	\
>  	     pos = symbol__next_by_name(pos))
>  #define map__for_each_symbol_by_name(map, sym_name, pos)		\
>  	__map__for_each_symbol_by_name(map, sym_name, (pos))
>  int arch__compare_symbol_names(const char *namea, const char *nameb);
> +int map__compare_symbol_names(const char *namea, const char *nameb);
>  void map__init(struct map *map, enum map_type type,
>  	       u64 start, u64 end, u64 pgoff, struct dso *dso);
>  struct map *map__new(struct machine *machine, u64 start, u64 len,
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dc93940..4fb9d275 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -411,7 +411,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>  		int cmp;
>  		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
> -		cmp = arch__compare_symbol_names(name, s->sym.name);
> +		cmp = map__compare_symbol_names(name, s->sym.name);
>  		if (cmp < 0)
>  			n = n->rb_left;
> @@ -429,7 +429,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>  		struct symbol_name_rb_node *tmp;
>  		tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
> -		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
> +		if (map__compare_symbol_names(tmp->sym.name, s->sym.name))
>  			break;
>  		s = tmp;
> -- 
> 2.1.4
> 
> Regards,
> PC
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
