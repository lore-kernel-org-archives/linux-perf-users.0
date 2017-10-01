From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v3 03/13] perf report: create real callchain entries for inlined frames
Date: Sun, 01 Oct 2017 14:37:56 +0200
Message-ID: <1648232.PM1aBqIB3I@agathebauer>
References: <20170906135501.306-1-milian.wolff@kdab.com> <20170906135501.306-4-milian.wolff@kdab.com> <20170919122711.GA13388@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:35126 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdJAMh7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 1 Oct 2017 08:37:59 -0400
In-Reply-To: <20170919122711.GA13388@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>

On Dienstag, 19. September 2017 14:27:11 CEST Jiri Olsa wrote:
> On Wed, Sep 06, 2017 at 03:54:51PM +0200, Milian Wolff wrote:
> 
> SNIP
> 
> > -struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr);
> > +// parse inlined frames for the given address
> > +struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
> > +					    struct symbol *sym);
> > +// free resources associated to the inline node list
> > 
> >  void inline_node__delete(struct inline_node *node);
> > 
> > +// insert the inline node list into the DSO, which will take ownership
> > +void inlines__tree_insert(struct rb_root *tree, struct inline_node
> > *inlines); +// find previously inserted inline node list
> > +struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr);
> > +// delete all nodes within the tree of inline_node s
> > +void inlines__tree_delete(struct rb_root *tree);
> 
> nit, think we prefer the /* */ comment style

I'll fix this, but note that there are more places outside this patch series 
where this style has crept in. Some of them also from past patches of mine - 
sorry for that.

I looks to me as if the checkpatch.pl should catch this, but it doesn't for me 
which is odd. Does anyone know what I need to do to enable the C99_COMMENTS 
check?

~~~~~
┌milian@agathebauer:~/projects/src/linux/tools/perf|wip/distinguish-inliners<>
└$ grep '// ' 0009-perf-report-properly-handle-branch-count-in-match_ch.patch 
-               // if no srcline is available, fallback to symbol name
-               // otherwise fall-back to IP-based comparison below
-               // compare inlined frames based on their symbol name because
-               // different inlined frames will have the same symbol start
+               // else fall-through
+                       // compare inlined frames based on their symbol name
+                       // because different inlined frames will have the same
+                       // symbol start. otherwise do a faster comparison 
based
+                       // on the symbol start address
+               // else fall-through
┌milian@agathebauer:~/projects/src/linux/tools/perf|wip/distinguish-inliners<>
└$ ../../scripts/checkpatch.pl --strict 0009-perf-report-properly-handle-
branch-count-in-match_ch.patch 
total: 0 errors, 0 warnings, 0 checks, 136 lines checked

0009-perf-report-properly-handle-branch-count-in-match_ch.patch has no obvious 
style problems and is ready for submission.
~~~~~

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
