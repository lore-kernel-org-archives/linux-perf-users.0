From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Question to perf annotate handling mov ...(%rip) instructions
Date: Wed, 29 Nov 2017 09:29:50 +0100
Message-ID: <20171129082950.GA26610@krava>
References: <f241fe0b-7a3f-cb6a-51ee-4833bce81e70@linux.vnet.ibm.com>
 <20171128145030.GG3298@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdK2I3w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Nov 2017 03:29:52 -0500
Content-Disposition: inline
In-Reply-To: <20171128145030.GG3298@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Tue, Nov 28, 2017 at 11:50:30AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > Function mov__parse() calls comment__symbol() which contains:
> > 
> >    static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
> >    {
> >         char *endptr, *name, *t;
> > 
> >         if (strstr(raw, "(%rip)") == NULL)
> >                 return 0;
> > 
> > This is architecture specific and does not work for non-Intel platforms.
> > 
> > I would like to fix perf annotate for s390x and above move instruction on s390x
> > is
> >      
> >     655a:       c0 10 00 01 9c eb       larl    %r1,39f30 <__gmon_start__>
> > 
> > There is a need to handle PLT resolution in an architecture independent way.
> > 
> > Ideas and suggestions?
> 
> Some historical background there, busy now, but you seem to be on the
> right track and IIRC you already sent a patch for this, right? I'll try
> to look at it.
> 
> Jiri may as well, since he worked a lot recently in this codebase, to
> refactor it some more to make it useful for annotating python code, perl
> next, other scripted languages should follow too.

so we try to parse each line out of objdump using arch specific
ops callbacks, check:

disasm_line__new
  disasm_line__init_ins
    dl->ins.ops->parse(...

the ops stuff are defined in:

static struct arch architectures[] = { 

        {
                .name = "s390",
                .init = s390__annotate_init,
                .objdump =  {
                        .comment_char = '#',
                },
        },

I'd check s390__annotate_init, there's some mechanism
of associating ops for arch and try to fit in ;-)

jirka
