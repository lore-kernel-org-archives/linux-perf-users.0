From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v4 03/15] perf util: refactor inline_list to operate on symbols
Date: Sun, 08 Oct 2017 21:53:20 +0200
Message-ID: <1645843.NzRK3p6XgL@agathebauer>
References: <20171001143100.19988-1-milian.wolff@kdab.com> <20171001143100.19988-4-milian.wolff@kdab.com> <20171005015613.GA19141@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:44684 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbdJHTxY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 Oct 2017 15:53:24 -0400
In-Reply-To: <20171005015613.GA19141@danjae.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com

On Donnerstag, 5. Oktober 2017 03:56:13 CEST Namhyung Kim wrote:
> Hi Milian,
> 
> On Sun, Oct 01, 2017 at 04:30:48PM +0200, Milian Wolff wrote:
> > This is a requirement to create real callchain entries for inlined
> > frames.
> > 
> > Since the list of inlines usually contains the target symbol too,
> > i.e. the location where the frames get inlined to, we alias that
> > symbol and reuse it as-is is. This ensures that other dependent
> > functionality keeps working, most notably annotation of the
> > target frames.
> > 
> > For all other entries in the inline_list, a fake symbol is created.
> > These are marked by new 'inlined' member which is set to true. Only
> > those symbols are managed by the inline_list and get freed when
> > the inline_list is deleted from within inline_node__delete.
> > 
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Cc: Yao Jin <yao.jin@linux.intel.com>
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > ---
> 
> [SNIP]
> 
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
> 
> It seems you need to check availability of base_sym first as 'else'
> statement below checks it.  Or if it's guaranteed not NULL (I think
> you make it so later), remove the check (and add an assert?) instead.

I'll make it fail-safe by adding the check before calling strcmp. Well 
spotted, many thanks!

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
