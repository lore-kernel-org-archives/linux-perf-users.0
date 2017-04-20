From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v6] Allow user probes on versioned symbols
Date: Thu, 20 Apr 2017 06:38:01 -0500
Message-ID: <c84cd8a7-27bb-14a8-2ff7-719e03c89273@us.ibm.com>
References: <27b85625-3134-9d2e-8501-36f4c2e4dbf5@us.ibm.com>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S944911AbdDTLiH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Apr 2017 07:38:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3KBY3ST098632
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Apr 2017 07:38:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29xaqksu9p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Apr 2017 07:38:06 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 20 Apr 2017 07:38:05 -0400
In-Reply-To: <27b85625-3134-9d2e-8501-36f4c2e4dbf5@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

ping

On 04/13/2017 12:03 PM, Paul Clarke wrote:
> Symbol versioning, as in glibc, results in symbols being defined as:
> <real symbol>@[@]<version>
> (Note that "@@" identifies a default symbol, if the symbol name
> is repeated.)
> 
> perf is currently unable to deal with this, and is unable to create
> user probes at such symbols:
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
>     Error: Failed to add events. Reason: No such file or directory (Code: -2)
> --
> 
> One is not able to specify the fully versioned symbol, either, due to
> syntactic conflicts with other uses of "@" by perf:
> --
> $ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create@@GLIBC_2.17
> probe-definition(0): pthread_create@@GLIBC_2.17
> Semantic error :SRC@SRC is not allowed.
> 0 arguments
>     Error: Command Parse Error. Reason: Invalid argument (Code: -22)
> --
> 
> This patch ignores versioning for default symbols, thus allowing probes to be
> created for these symbols:
> --
> $ /usr/bin/sudo ./perf probe -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
> Added new event:
>     probe_libpthread:pthread_create (on pthread_create in /lib/powerpc64le-linux-gnu/libpthread-2.19.so)
> 
> You can now use it in all perf tools, such as:
> 
>           perf record -e probe_libpthread:pthread_create -aR sleep 1
> 
> $ /usr/bin/sudo ./perf record -e probe_libpthread:pthread_create -aR ./test 2
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.052 MB perf.data (2 samples) ]
> $ /usr/bin/sudo ./perf script
>               test  2915 [000] 19124.260729: probe_libpthread:pthread_create: (3fff99248d38)
>               test  2916 [000] 19124.260962: probe_libpthread:pthread_create: (3fff99248d38)
> $ /usr/bin/sudo ./perf probe --del=probe_libpthread:pthread_create
> Removed event: probe_libpthread:pthread_create
> --
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
> v6:
> - new name for enum (per Masami Hiramatsu)
> - fixed use of "unsigned int" instead of enum
> - some whitespace adjustments
> 
> v5:
> - now using new enum to specify matching semantics (per Masami Hiramatsu)
> 
> v4:
> - rebased to acme/perf/core
> - moved changes from "map" namespace to "symbol" namespace,
> - rewrote symbol__compare (now *match) to avoid need for strdup
> - new symbol__match_symbol_name to support versioned symbols, ignoring default
>      tags
> - new arch__compare_symbol_names_n to map to strncmp
> - dso__find_symbol_by_name: now tries exact match (as before), then tries
>       also adding symbols tagged as default (@@)
> - symbols__find_by_name: new parameter to support finding with or without default
>      tags
> - does NOT handle setting probes using the tagged symbol name (symbol@[@]tag)
> 
> v3:
> - code style fixes per David Ahern
> 
> v2:
> - move logic from arch__compare_symbol_names to new map__compare_symbol_names
> - call through from map__compare_symbol_names to arch__compare_symbol_names
> - redirect uses of arch__compare_symbol_names
> - send patch to LKML
>   tools/perf/arch/powerpc/util/sym-handling.c | 12 ++++++
>   tools/perf/util/map.c                       |  5 ---
>   tools/perf/util/map.h                       |  5 ++-
>   tools/perf/util/symbol.c                    | 61 +++++++++++++++++++++++------
>   tools/perf/util/symbol.h                    | 11 ++++++
>   5 files changed, 74 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 39dbe51..bf9a259 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -52,6 +52,18 @@ int arch__compare_symbol_names(const char *namea, const char *nameb)
>   
>   	return strcmp(namea, nameb);
>   }
> +
> +int arch__compare_symbol_names_n(const char *namea, const char *nameb,
> +				 unsigned int n)
> +{
> +	/* Skip over initial dot */
> +	if (*namea == '.')
> +		namea++;
> +	if (*nameb == '.')
> +		nameb++;
> +
> +	return strncmp(namea, nameb, n);
> +}
>   #endif
>   
>   #if defined(_CALL_ELF) && _CALL_ELF == 2
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index c1870ac..f4d8272 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -325,11 +325,6 @@ int map__load(struct map *map)
>   	return 0;
>   }
>   
> -int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
> -{
> -	return strcmp(namea, nameb);
> -}
> -
>   struct symbol *map__find_symbol(struct map *map, u64 addr)
>   {
>   	if (map__load(map) < 0)
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index c8a5a64..f9e8ac8 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -130,13 +130,14 @@ struct thread;
>    */
>   #define __map__for_each_symbol_by_name(map, sym_name, pos)	\
>   	for (pos = map__find_symbol_by_name(map, sym_name);	\
> -	     pos && arch__compare_symbol_names(pos->name, sym_name) == 0;	\
> +	     pos &&						\
> +	     !symbol__match_symbol_name(pos->name, sym_name,	\
> +					SYMBOL_TAG_INCLUDE__DEFAULT_ONLY); \
>   	     pos = symbol__next_by_name(pos))
>   
>   #define map__for_each_symbol_by_name(map, sym_name, pos)		\
>   	__map__for_each_symbol_by_name(map, sym_name, (pos))
>   
> -int arch__compare_symbol_names(const char *namea, const char *nameb);
>   void map__init(struct map *map, enum map_type type,
>   	       u64 start, u64 end, u64 pgoff, struct dso *dso);
>   struct map *map__new(struct machine *machine, u64 start, u64 len,
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9b4d8ba..aebaba5 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -87,6 +87,17 @@ static int prefix_underscores_count(const char *str)
>   	return tail - str;
>   }
>   
> +int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
> +{
> +	return strcmp(namea, nameb);
> +}
> +
> +int __weak arch__compare_symbol_names_n(const char *namea, const char *nameb,
> +					unsigned int n)
> +{
> +	return strncmp(namea, nameb, n);
> +}
> +
>   int __weak arch__choose_best_symbol(struct symbol *syma,
>   				    struct symbol *symb __maybe_unused)
>   {
> @@ -396,8 +407,26 @@ static void symbols__sort_by_name(struct rb_root *symbols,
>   	}
>   }
>   
> +int symbol__match_symbol_name(const char *name, const char *str,
> +			      enum symbol_tag_include includes)
> +{
> +	const char *versioning;
> +
> +	if (includes == SYMBOL_TAG_INCLUDE__DEFAULT_ONLY &&
> +	    (versioning = strstr(name,"@@"))) {
> +
> +		unsigned int len = strlen(str);
> +		if (len < versioning - name)
> +			len = versioning - name;
> +
> +		return arch__compare_symbol_names_n(name, str, len);
> +	} else
> +		return arch__compare_symbol_names(name, str);
> +}
> +
>   static struct symbol *symbols__find_by_name(struct rb_root *symbols,
> -					    const char *name)
> +					    const char *name,
> +					    enum symbol_tag_include includes)
>   {
>   	struct rb_node *n;
>   	struct symbol_name_rb_node *s = NULL;
> @@ -411,11 +440,11 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>   		int cmp;
>   
>   		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
> -		cmp = arch__compare_symbol_names(name, s->sym.name);
> +		cmp = symbol__match_symbol_name(s->sym.name, name, includes);
>   
> -		if (cmp < 0)
> +		if (cmp > 0)
>   			n = n->rb_left;
> -		else if (cmp > 0)
> +		else if (cmp < 0)
>   			n = n->rb_right;
>   		else
>   			break;
> @@ -424,16 +453,17 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>   	if (n == NULL)
>   		return NULL;
>   
> -	/* return first symbol that has same name (if any) */
> -	for (n = rb_prev(n); n; n = rb_prev(n)) {
> -		struct symbol_name_rb_node *tmp;
> +	if (includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY)
> +		/* return first symbol that has same name (if any) */
> +		for (n = rb_prev(n); n; n = rb_prev(n)) {
> +			struct symbol_name_rb_node *tmp;
>   
> -		tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
> -		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
> -			break;
> +			tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
> +			if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
> +				break;
>   
> -		s = tmp;
> -	}
> +			s = tmp;
> +		}
>   
>   	return &s->sym;
>   }
> @@ -500,7 +530,12 @@ struct symbol *symbol__next_by_name(struct symbol *sym)
>   struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
>   					const char *name)
>   {
> -	return symbols__find_by_name(&dso->symbol_names[type], name);
> +	struct symbol *s = symbols__find_by_name(&dso->symbol_names[type], name,
> +						 SYMBOL_TAG_INCLUDE__NONE);
> +	if (!s)
> +		s = symbols__find_by_name(&dso->symbol_names[type], name,
> +					  SYMBOL_TAG_INCLUDE__DEFAULT_ONLY);
> +	return s;
>   }
>   
>   void dso__sort_by_name(struct dso *dso, enum map_type type)
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 5245d2f..84fc0c0 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -348,8 +348,19 @@ void arch__sym_update(struct symbol *s, GElf_Sym *sym);
>   #define SYMBOL_A 0
>   #define SYMBOL_B 1
>   
> +int arch__compare_symbol_names(const char *namea, const char *nameb);
> +int arch__compare_symbol_names_n(const char *namea, const char *nameb,
> +				 unsigned int n);
>   int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
>   
> +enum symbol_tag_include {
> +	SYMBOL_TAG_INCLUDE__NONE = 0,
> +	SYMBOL_TAG_INCLUDE__DEFAULT_ONLY
> +};
> +
> +int symbol__match_symbol_name(const char *namea, const char *nameb,
> +			      enum symbol_tag_include includes);
> +
>   /* structure containing an SDT note's info */
>   struct sdt_note {
>   	char *name;			/* name of the note*/
> 
