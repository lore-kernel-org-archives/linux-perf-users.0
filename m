From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5] Allow user probes on versioned symbols.
Date: Thu, 13 Apr 2017 15:11:39 -0300
Message-ID: <20170413181139.GU3275@kernel.org>
References: <967814e0-0d5a-4970-38d8-04d7dae9d5b1@us.ibm.com>
 <20170413112020.8c98e0a082ad821a43d968c3@kernel.org>
 <58e0c059-5f7f-b763-4e97-c0f785dfdb69@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753118AbdDMSLo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2017 14:11:44 -0400
Content-Disposition: inline
In-Reply-To: <58e0c059-5f7f-b763-4e97-c0f785dfdb69@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Thu, Apr 13, 2017 at 10:40:50AM -0500, Paul Clarke escreveu:
> On 04/12/2017 09:20 PM, Masami Hiramatsu wrote:
> > On Wed, 12 Apr 2017 09:41:51 -0500
> > Paul Clarke <pc@us.ibm.com> wrote:
> > >   static struct symbol *symbols__find_by_name(struct rb_root *symbols,
> > > -					    const char *name)
> > > +					    const char *name,
> > > +					    unsigned int includes)
> > 
> > Here, you might miss replacing this 'unsigned int' with enum.
> > (actually, enum is equal to int, not unsigned int)
> 
> (Ugh.) My bad. Will fix.
> 
> > > +enum symbols_tag_includes {
> > > +	SYMBOLS_TAG__INCLUDE_NONE,
> > > +	SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY
> > > +};
> > 
> > BTW, would we need such 's' for plural and third person singular for type name?
> > And also, you should use enum type name for prefix so that other developers
> > easily find the definition of enumeration, e.g.
> > 
> > enum symbol_tag_include {
> > 	SYMBOL_TAG_INCLUDE__NONE = 0,
> > 	SYMBOL_TAG_INCLUDE__DEFAULT_ONLY
> > };
 
> I was thinking the top-level namespace would be "symbols", because we

yeah, we have both namespaces: symbols__ and symbol__, the first for
operations on rbtrees of the later, for instance, from symbol.h:

void symbol__delete(struct symbol *sym);
void symbols__delete(struct rb_root *symbols);

symbols__delete() will call symbol__delete() for each entry in that
rbtree.

> are not necessarily working with a single symbol.  Secondary namespace
> would be "tag", since this enum is very specific to tags.  Then, the
> actions are whether to "include none (of tagged symbols)" or "include
> only symbols tagged as default".
 
> I'm fine with your suggestion, though, and will submit a new patch incorporating that soon.
> 
> Regards,
> PC
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
