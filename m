From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4] tools/perf: Allow user probes on versioned symbols
Date: Tue, 11 Apr 2017 09:00:02 +0900
Message-ID: <20170411090002.e74f1e80d98277b3a3f93278@kernel.org>
References: <a459fae5-19e8-207b-6ec0-addd39b6417d@us.ibm.com>
        <20170410221102.0a9f91d0d11aa5665e4166a3@kernel.org>
        <87285133-a06b-da22-2737-4cc6bc0cdade@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbdDKAAJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Apr 2017 20:00:09 -0400
In-Reply-To: <87285133-a06b-da22-2737-4cc6bc0cdade@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: pc@us.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, 10 Apr 2017 09:53:48 -0500
Paul Clarke <pc@us.ibm.com> wrote:
> >> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> >> index 5245d2f..bde2100 100644
> >> --- a/tools/perf/util/symbol.h
> >> +++ b/tools/perf/util/symbol.h
> >> @@ -348,8 +348,17 @@ void arch__sym_update(struct symbol *s, GElf_Sym *sym);
> >>   #define SYMBOL_A 0
> >>   #define SYMBOL_B 1
> >>
> >> +int arch__compare_symbol_names(const char *namea, const char *nameb);
> >> +int arch__compare_symbol_names_n(const char *namea, const char *nameb,
> >> +				 unsigned int n);
> >>   int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
> >>
> >> +#define SYMBOLS__TAG_INCLUDE_NONE 0
> >> +#define SYMBOLS__TAG_INCLUDE_DEFAULT_ONLY 1
> >
> > Hmm, even if you like to pass an obvious flag, these should be
> > defined by enum, and please choose simpler and clear flag name.
> >
> > E.g.
> > enum {
> > 	SYMBOLS__COMP_WITH_TAG,
> > 	SYMBOLS__COMP_WITHOUT_TAG,
> > };
> 
> Earlier in this thread, we discussed supporting non-default tagged symbols (those tagged with "@version").  To allow for that, I was thinking of these three cases:
> - SYMBOLS__TAG_INCLUDE_NONE: ignore all tagged symbols (the current behavior)
> - SYMBOLS__TAG_INCLUDE_DEFAULT_ONLY:  match tagged symbols when tagged as default ("@@"; added with this patch)
> - SYMBOLS__TAG_INCLUDE_ALL:  match all tagged symbols ("@" and "@@"; future)

Ah, I see now.

> For the names of the enums, I chose "SYMBOLS__TAG..." to put it first in the SYMBOLS namespace, and second in a "TAG" sub-namespace.

For the namespace, we should use same namespase as enum's name.

> I'm happy to fix the discrepancy with signed/unsigned by changing to enum.
> 
> Let me know what enum names are preferred, given the above discussion, and I'll post a new patch.

OK, then what about enum symbol_tag and use "SYMBOL_TAG__" for namespace?

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
