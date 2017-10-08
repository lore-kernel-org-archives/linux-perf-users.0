From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v4 05/15] perf report: create real callchain entries for inlined frames
Date: Sun, 08 Oct 2017 22:26:49 +0200
Message-ID: <1860010.LBD6XXpZyL@agathebauer>
References: <20171001143100.19988-1-milian.wolff@kdab.com> <20171001143100.19988-6-milian.wolff@kdab.com> <20171005033529.GB19141@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:48330 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdJHU0x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 Oct 2017 16:26:53 -0400
In-Reply-To: <20171005033529.GB19141@danjae.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com

On Donnerstag, 5. Oktober 2017 05:35:29 CEST Namhyung Kim wrote:
> On Sun, Oct 01, 2017 at 04:30:50PM +0200, Milian Wolff wrote:
> > The inline_node structs are maintained by the new dso->inlines
> > tree. This in turn keeps ownership of the fake symbols and
> > srcline string representing an inline frame.
> > 
> > This tree is always sorted by name. All other entries of the symbol
> 
> Isn't it sorted by address?

True. The tree of inlines is sorted by address. The sorting by name is part
of a different patch, I'll revise the commit message.

> > beside the function name are unused for inline frames. The advantage
> > of this approach is that all existing users of the callchain API can
> > now transparently display inlined frames without having to patch
> > their code.
> > 
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Cc: Yao Jin <yao.jin@linux.intel.com>
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > ---
> > 
> >  tools/perf/util/dso.c     |  3 +++
> >  tools/perf/util/dso.h     |  1 +
> >  tools/perf/util/machine.c | 37 ++++++++++++++++++++++++++++++++++
> >  tools/perf/util/srcline.c | 51
> >  +++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/srcline.h |  9 +++++++++
> >  5 files changed, 101 insertions(+)
> > 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 339e52971380..6e743dffc487 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -10,6 +10,7 @@
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
> > @@ -1201,6 +1202,7 @@ struct dso *dso__new(const char *name)
> > 
> >  		for (i = 0; i < MAP__NR_TYPES; ++i)
> >  		
> >  			dso->symbols[i] = dso->symbol_names[i] = RB_ROOT;
> >  		
> >  		dso->data.cache = RB_ROOT;
> > 
> > +		dso->inlined_nodes = RB_ROOT;
> > 
> >  		dso->data.fd = -1;
> >  		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
> >  		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
> > 
> > @@ -1234,6 +1236,7 @@ void dso__delete(struct dso *dso)
> > 
> >  		       dso->long_name);
> >  	
> >  	for (i = 0; i < MAP__NR_TYPES; ++i)
> >  	
> >  		symbols__delete(&dso->symbols[i]);
> > 
> > +	inlines__tree_delete(&dso->inlined_nodes);
> 
> I'm still curious why it doesn't make a trouble (I think there's
> use-after-free for non-inlined symbols).  Anyway moving the
> inlines__tree_delete() above the symbols__delete() will solve the
> concern IMHO.

I just tested this again. The reason why I'm not seeing the issue is the 
following: The executable DSO is never freed in my case, probably due to a 
refcounting bug that is unrelated to the actual patch series here.

Adding some simple debug output to `dso__delete`, I see that it's never being 
called for my main executable - only for libraries libm, kernel modules and 
pseudo sections like stack/anon/heap etc.

If I'm using a more elaborate example binary with libraries that contain 
inlines, I still cannot reproduce an issue with valgrind though...

But with ASAN it finally shows up:

==11080==ERROR: AddressSanitizer: heap-use-after-free on address 
0x608000395e4b at pc 0x55a7017388a9 bp 0x7ffe1c99c450 sp 0x7ffe1c99c440
READ of size 1 at 0x608000395e4b thread T0
    #0 0x55a7017388a8 in inline_node__delete util/srcline.c:579
    #1 0x55a7017388a8 in inlines__tree_delete util/srcline.c:634
    #2 0x55a70157c757 in dso__delete util/dso.c:1239
    #3 0x55a701614d6b in dsos__purge util/machine.c:139
    #4 0x55a701614d6b in dsos__exit util/machine.c:147
    #5 0x55a701614d6b in machine__exit util/machine.c:176
    #6 0x55a701641ce0 in perf_session__delete util/session.c:203
    #7 0x55a70135c50f in cmd_script /home/milian/projects/src/linux/tools/
perf/builtin-script.c:3117
    #8 0x55a701472b4c in run_builtin /home/milian/projects/src/linux/tools/
perf/perf.c:296
    #9 0x55a70147354a in handle_internal_command /home/milian/projects/src/
linux/tools/perf/perf.c:348
    #10 0x55a70128e4c5 in run_argv /home/milian/projects/src/linux/tools/perf/
perf.c:392
    #11 0x55a70128e4c5 in main /home/milian/projects/src/linux/tools/perf/
perf.c:536
    #12 0x7f402c989f69 in __libc_start_main (/usr/lib/libc.so.6+0x20f69)
    #13 0x55a701292989 in _start (/home/milian/projects/src/linux/tools/perf/
perf+0xadd989)

0x608000395e4b is located 43 bytes inside of 86-byte region 
[0x608000395e20,0x608000395e76)
freed by thread T0 here:
    #0 0x7f40300f2711 in __interceptor_free /build/gcc-multilib/src/gcc/
libsanitizer/asan/asan_malloc_linux.cc:45
    #1 0x55a701588a2f in symbol__delete util/symbol.c:282
    #2 0x55a701588a2f in symbols__delete util/symbol.c:294
    #3 0x55a70157c745 in dso__delete util/dso.c:1238
    #4 0x55a701614d6b in dsos__purge util/machine.c:139
    #5 0x55a701614d6b in dsos__exit util/machine.c:147
    #6 0x55a701614d6b in machine__exit util/machine.c:176
    #7 0x55a701641ce0 in perf_session__delete util/session.c:203
    #8 0x55a70135c50f in cmd_script /home/milian/projects/src/linux/tools/
perf/builtin-script.c:3117
    #9 0x55a701472b4c in run_builtin /home/milian/projects/src/linux/tools/
perf/perf.c:296
    #10 0x55a70147354a in handle_internal_command /home/milian/projects/src/
linux/tools/perf/perf.c:348
    #11 0x55a70128e4c5 in run_argv /home/milian/projects/src/linux/tools/perf/
perf.c:392
    #12 0x55a70128e4c5 in main /home/milian/projects/src/linux/tools/perf/
perf.c:536
    #13 0x7f402c989f69 in __libc_start_main (/usr/lib/libc.so.6+0x20f69)

Reordering the statements does fix it, as you suggested.

Many thanks for this review, very valuable!

> >  	if (dso->short_name_allocated) {
> >  	
> >  		zfree((char **)&dso->short_name);
> 
> [SNIP]
> 
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 07d1a058d7c4..69241d805275 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -583,3 +583,54 @@ void inline_node__delete(struct inline_node *node)
> > 
> >  	free(node);
> >  
> >  }
> > 
> > +
> > +void inlines__tree_insert(struct rb_root *tree, struct inline_node
> > *inlines) +{
> > +	struct rb_node **p = &tree->rb_node;
> > +	struct rb_node *parent = NULL;
> > +	const u64 addr = inlines->addr;
> > +	struct inline_node *i;
> > +
> > +	while (*p != NULL) {
> > +		parent = *p;
> > +		i = rb_entry(parent, struct inline_node, rb_node);
> > +		if (addr < i->addr)
> > +			p = &(*p)->rb_left;
> > +		else
> > +			p = &(*p)->rb_right;
> > +	}
> > +	rb_link_node(&inlines->rb_node, parent, p);
> > +	rb_insert_color(&inlines->rb_node, tree);
> > +}
> > +
> > +struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr)
> > +{
> > +	struct rb_node *n = tree->rb_node;
> > +
> > +	while (n) {
> > +		struct inline_node *i = rb_entry(n, struct inline_node,
> > +						 rb_node);
> > +
> > +		if (addr < i->addr)
> > +			n = n->rb_left;
> > +		else if (addr > i->addr)
> > +			n = n->rb_right;
> > +		else
> > +			return i;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +void inlines__tree_delete(struct rb_root *tree)
> > +{
> > +	struct inline_node *pos;
> > +	struct rb_node *next = rb_first(tree);
> > +
> > +	while (next) {
> > +		pos = rb_entry(next, struct inline_node, rb_node);
> > +		next = rb_next(&pos->rb_node);
> > +		rb_erase(&pos->rb_node, tree);
> > +		inline_node__delete(pos);
> > +	}
> > +}
> > diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
> > index 0201ed2c0b9c..ebe38cd22294 100644
> > --- a/tools/perf/util/srcline.h
> > +++ b/tools/perf/util/srcline.h
> > @@ -2,6 +2,7 @@
> > 
> >  #define PERF_SRCLINE_H
> >  
> >  #include <linux/list.h>
> > 
> > +#include <linux/rbtree.h>
> > 
> >  #include <linux/types.h>
> >  
> >  struct dso;
> > 
> > @@ -25,6 +26,7 @@ struct inline_list {
> > 
> >  struct inline_node {
> >  
> >  	u64			addr;
> >  	struct list_head	val;
> > 
> > +	struct rb_node		rb_node;
> > 
> >  };
> >  
> >  /* parse inlined frames for the given address */
> > 
> > @@ -33,4 +35,11 @@ struct inline_node *dso__parse_addr_inlines(struct dso
> > *dso, u64 addr,> 
> >  /* free resources associated to the inline node list */
> >  void inline_node__delete(struct inline_node *node);
> > 
> > +/* insert the inline node list into the DSO, which will take ownership */
> > +void inlines__tree_insert(struct rb_root *tree, struct inline_node
> > *inlines); +/* find previously inserted inline node list */
> > +struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr);
> > +/* delete all nodes within the tree of inline_node s */
> > +void inlines__tree_delete(struct rb_root *tree);
> > +
> > 
> >  #endif /* PERF_SRCLINE_H */


-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
