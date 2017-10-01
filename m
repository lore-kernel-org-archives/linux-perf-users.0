From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v3 03/13] perf report: create real callchain entries for inlined frames
Date: Sun, 01 Oct 2017 16:12:36 +0200
Message-ID: <4499499.qdQhpEf76S@agathebauer>
References: <20170906135501.306-1-milian.wolff@kdab.com> <20170906135501.306-4-milian.wolff@kdab.com> <20170919122719.GB13388@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:46178 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdJAOQl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 1 Oct 2017 10:16:41 -0400
In-Reply-To: <20170919122719.GB13388@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Dienstag, 19. September 2017 14:27:19 CEST Jiri Olsa wrote:
> On Wed, Sep 06, 2017 at 03:54:51PM +0200, Milian Wolff wrote:
> 
> SNIP
> 
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
> 
> could you please split the patch at least into
> above 'adding related inline_node tree managing functions + append_inlines'
> 
> and below 'struct inline_list' changes
> 
> not sure the 'struct symbol::inlined' could be separated,
> I'd take it as a bonus and nice gesture to reviewers ;-)

I have now split it up in three parts:

a) use symbol in srcline api and create fake symbols
b) use srcline string in srcline api
c) create real callchain entries

I hope that is easier to review. Thanks for the comments so far. I'll push a 
new version of this patch series now.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
