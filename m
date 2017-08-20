From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v2 03/14] perf report: create real callchain entries for inlined frames
Date: Sun, 20 Aug 2017 22:57:17 +0200
Message-ID: <15340121.XrrsYTu5UN@agathebauer>
References: <20170806212446.24925-1-milian.wolff@kdab.com> <20170806212446.24925-4-milian.wolff@kdab.com> <20170816075313.GA26397@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:55994 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbdHTU5V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 20 Aug 2017 16:57:21 -0400
In-Reply-To: <20170816075313.GA26397@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com

On Mittwoch, 16. August 2017 09:53:13 CEST Namhyung Kim wrote:
> Hi Milian,
> 
> On Sun, Aug 06, 2017 at 11:24:35PM +0200, Milian Wolff wrote:
> > The inlined frames use a fake symbol that is tracked in a special
> > map inside the dso, which is always sorted by name. All other
> 
> It seems the above is not true.  Fake symbols are maintained by
> inline_node which in turn maintained by dso->inlines tree.

OK, I'll rephrase this to make it more explicit. But what I call "map" is what 
you call "tree", no?

<snip>

> > @@ -201,7 +202,8 @@ static inline void callchain_cursor_reset(struct
> > callchain_cursor *cursor)> 
> >  int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
> >  
> >  			    struct map *map, struct symbol *sym,
> >  			    bool branch, struct branch_flags *flags,
> > 
> > -			    int nr_loop_iter, int samples, u64 branch_from);
> > +			    int nr_loop_iter, int samples, u64 branch_from,
> > +			    const char *srcline);
> > 
> >  /* Close a cursor writing session. Initialize for the reader */
> >  static inline void callchain_cursor_commit(struct callchain_cursor
> >  *cursor)
> 
> I think it'd be better splitting srcline change into a separate
> commit.

OK, I'll try to see how this goes. It would simply add the boiler plate code 
to pass the srcline around, and then set it from within the callchain code, 
right?

> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index b9e087fb8247..72e6e390fd26 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -9,6 +9,7 @@
> > 
> >  #include "compress.h"
> >  #include "path.h"
> >  #include "symbol.h"
> > 
> > +#include "srcline.h"
> > 
> >  #include "dso.h"
> >  #include "machine.h"
> >  #include "auxtrace.h"
> > 
> > @@ -1233,6 +1234,7 @@ void dso__delete(struct dso *dso)
> > 
> >  		       dso->long_name);
> >  	
> >  	for (i = 0; i < MAP__NR_TYPES; ++i)
> >  	
> >  		symbols__delete(&dso->symbols[i]);
> > 
> > +	inlines__tree_delete(&dso->inlined_nodes);
> 
> Hmm.. inline_node is released after symbol but it seems to have a
> problem.  Please see below.
>
> >  	if (dso->short_name_allocated) {
> >  	
> >  		zfree((char **)&dso->short_name);
> > 
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index f886141678eb..7d1e2b3c1f10 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -141,6 +141,7 @@ struct dso {
> > 
> >  	struct rb_root	 *root;		/* root of rbtree that rb_node is in 
*/
> >  	struct rb_root	 symbols[MAP__NR_TYPES];
> >  	struct rb_root	 symbol_names[MAP__NR_TYPES];
> > 
> > +	struct rb_root	 inlined_nodes;
> > 
> >  	struct {
> >  	
> >  		u64		addr;
> >  		struct symbol	*symbol;
> 
> [SNIP]
> 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index d4df353051af..a7f8499c8756 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index ebc88a74e67b..a1fdf035d1dd 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -33,28 +33,17 @@ static const char *dso__name(struct dso *dso)
> > 
> >  	return dso_name;
> >  
> >  }
> > 
> > -static int inline_list__append(char *filename, char *funcname, int
> > line_nr, -			       struct inline_node *node, struct dso *dso)
> > +static int inline_list__append(struct symbol *symbol, char *srcline,
> > +			       struct inline_node *node)
> > 
> >  {
> >  
> >  	struct inline_list *ilist;
> > 
> > -	char *demangled;
> > 
> >  	ilist = zalloc(sizeof(*ilist));
> >  	if (ilist == NULL)
> >  	
> >  		return -1;
> > 
> > -	ilist->filename = filename;
> > -	ilist->line_nr = line_nr;
> > -
> > -	if (dso != NULL) {
> > -		demangled = dso__demangle_sym(dso, 0, funcname);
> > -		if (demangled == NULL) {
> > -			ilist->funcname = funcname;
> > -		} else {
> > -			ilist->funcname = demangled;
> > -			free(funcname);
> > -		}
> > -	}
> > +	ilist->symbol = symbol;
> > +	ilist->srcline = srcline;
> > 
> >  	if (callchain_param.order == ORDER_CALLEE)
> >  	
> >  		list_add_tail(&ilist->list, &node->val);
> > 
> > @@ -64,6 +53,30 @@ static int inline_list__append(char *filename, char
> > *funcname, int line_nr,> 
> >  	return 0;
> >  
> >  }
> > 
> > +// basename version that takes a const input string
> > +static const char *gnu_basename(const char *path)
> > +{
> > +	const char *base = strrchr(path, '/');
> > +
> > +	return base ? base + 1 : path;
> > +}
> > +
> > +static char *srcline_from_fileline(const char *file, unsigned int line)
> > +{
> > +	char *srcline;
> > +
> > +	if (!file)
> > +		return NULL;
> > +
> > +	if (!srcline_full_filename)
> > +		file = gnu_basename(file);
> > +
> > +	if (asprintf(&srcline, "%s:%u", file, line) < 0)
> > +		return NULL;
> > +
> > +	return srcline;
> > +}
> > +
> > 
> >  #ifdef HAVE_LIBBFD_SUPPORT
> >  
> >  /*
> > 
> > @@ -203,19 +216,55 @@ static void addr2line_cleanup(struct a2l_data *a2l)
> > 
> >  #define MAX_INLINE_NEST 1024
> > 
> > +static struct symbol *new_inline_sym(struct dso *dso,
> > +				     struct symbol *base_sym,
> > +				     const char *funcname)
> > +{
> > +	struct symbol *inline_sym;
> > +	char *demangled = NULL;
> > +
> > +	if (dso) {
> > +		demangled = dso__demangle_sym(dso, 0, funcname);
> > +		if (demangled)
> > +			funcname = demangled;
> > +	}
> > +
> > +	if (strcmp(funcname, base_sym->name) == 0) {
> > +		// reuse the real, existing symbol
> > +		inline_sym = base_sym;
> 
> So inline_node could refer the existing symbol.

Yes, that does indeed seem to be an issue. I wonder why I'm not seeing any 
crashes or valgrind/ASAN reports though. I'll have to dig into this.

> > +	} else {
> > +		// create a fake symbol for the inline frame
> > +		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
> > +					 base_sym ? base_sym->end : 0,
> > +					 base_sym ? base_sym->binding : 0,
> > +					 funcname);
> > +		if (inline_sym)
> > +			inline_sym->inlined = 1;
> > +	}
> > +
> > +	free(demangled);
> > +
> > +	return inline_sym;
> > +}
> > +
> > 
> >  static int inline_list__append_dso_a2l(struct dso *dso,
> > 
> > -				       struct inline_node *node)
> > +				       struct inline_node *node,
> > +				       struct symbol *sym)
> > 
> >  {
> >  
> >  	struct a2l_data *a2l = dso->a2l;
> > 
> > -	char *funcname = a2l->funcname ? strdup(a2l->funcname) : NULL;
> > -	char *filename = a2l->filename ? strdup(a2l->filename) : NULL;
> > +	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
> > +	char *srcline = NULL;
> > +
> > +	if (a2l->filename)
> > +		srcline = srcline_from_fileline(a2l->filename, a2l->line);
> > 
> > -	return inline_list__append(filename, funcname, a2l->line, node, dso);
> > +	return inline_list__append(inline_sym, srcline, node);
> > 
> >  }
> 
> [SNIP]
> 
> > @@ -511,10 +563,63 @@ void inline_node__delete(struct inline_node *node)
> > 
> >  	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
> >  	
> >  		list_del_init(&ilist->list);
> > 
> > -		zfree(&ilist->filename);
> > -		zfree(&ilist->funcname);
> > +		zfree(&ilist->srcline);
> > +		// only the inlined symbols are owned by the list
> > +		if (ilist->symbol && ilist->symbol->inlined)
> > +			symbol__delete(ilist->symbol);
> 
> Existing symbols are released at this moment.

Thanks for the review, I'll try to look into these issues once I have more 
time again.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
