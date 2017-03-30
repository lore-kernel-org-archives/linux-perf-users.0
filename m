From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe symbols with @GLIBC...
Date: Thu, 30 Mar 2017 12:44:01 +0900
Message-ID: <20170330124401.384447e3a1c608a9c4879c5d@kernel.org>
References: <54E752BF.50309@us.ibm.com>
        <54E76CDC.2090904@gmail.com>
        <54E775A6.8000704@us.ibm.com>
        <e90f2a52-3ffd-69ad-4d55-6c8148938128@us.ibm.com>
        <894843b3-c2b1-6875-1ab3-305834b1f7f7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932634AbdC3DoH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Mar 2017 23:44:07 -0400
In-Reply-To: <894843b3-c2b1-6875-1ab3-305834b1f7f7@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Paul Clarke <pc@us.ibm.com>, linux-perf-users@vger.kernel.org

On Wed, 29 Mar 2017 10:23:49 -0600
David Ahern <dsahern@gmail.com> wrote:

> 
> [ cc Masami ]
> 
> On 3/27/17 3:49 PM, Paul Clarke wrote:
> > On 02/20/2015 11:57 AM, Paul Clarke wrote:
> > 
> > (Yes, 2 years later.  :-)
> > 
> >> On 02/20/2015 11:20 AM, David Ahern wrote:
> >>> On 2/20/15 8:29 AM, Paul Clarke wrote:
> >>>> How does one set a dynamic tracepoint for user-mode symbols with "@"
> >>>> qualifiers?
> >>>>
> >>>> # perf probe -F -x /lib/libpthread.so.0 --filter='pthread_create*'
> >>>> pthread_create@@GLIBC_2.1
> >>>> pthread_create@GLIBC_2.0
> >>>
> >>> one of many reasons I proposed an option to let users specify an
> >>> address.
> >>>
> >>> https://lkml.org/lkml/2013/12/1/126
> >>> https://lkml.org/lkml/2013/12/2/324
> >>>
> >>> It was not picked up.
> >>
> >> I presume then, that I'm not doing something obviously wrong, and this
> >> is the current state of affairs?
> >>
> >> Given that, I would argue that a better resolution would be to:
> >>
> >> 1. Support setting probes using the name of the symbol as reported by
> >> "--funcs".  For example, the following should work:
> >>
> >> # perf probe -x /lib/libpthread.so.0 pthread_create@GLIBC_2.0
> >>
> >> -- AND / OR --
> >>
> >> 2. Go ahead and just set probes at all functions which match the base
> >> function name.  For example, the following:
> >>
> >> # perf probe -v -x /lib/libpthread.so.0 pthread_create
> >>
> >> Would set probes at both known "pthread_create" entry points:
> >> - pthread_create@@GLIBC_2.1
> >> - pthread_create@GLIBC_2.0
> > 
> > I created a patch implementing something close to the latter, but only
> > picking up the default symbol (double-"@").  I submit to spark discussion,
> > not that I necessarily consider this patch complete or correct.
> > 
> > -- >8 --
> > 
> > Allow user probes on versioned symbols.
> > 
> > Symbol versioning, as in glibc, results in symbols being defined as:
> > <real symbol>@[@]<version>
> > (Note that "@@" identifies a default symbol, if the symbol name
> > is repeated.)
> > 
> > perf is currently unable to deal with this, and is unable to create
> > user probes at such symbols:
> > -- 
> > $ nm /lib/powerpc64le-linux-gnu/libpthread.so.0 | grep pthread_create
> > 0000000000008d30 t __pthread_create_2_1
> > 0000000000008d30 T pthread_create@@GLIBC_2.17
> > $ /usr/bin/sudo perf probe -v -x
> > /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
> > probe-definition(0): pthread_create
> > symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
> > 0 arguments
> > Open Debuginfo file:
> > /usr/lib/debug/lib/powerpc64le-linux-gnu/libpthread-2.19.so
> > Try to find probe point from debuginfo.
> > Probe point 'pthread_create' not found.
> >   Error: Failed to add events. Reason: No such file or directory (Code: -2)
> > -- 
> > 
> > One is not able to specify the fully versioned symbol, either, due to
> > syntactic conflicts with other uses of "@" by perf:
> > -- 
> > $ /usr/bin/sudo perf probe -v -x
> > /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create@@GLIBC_2.17
> > probe-definition(0): pthread_create@@GLIBC_2.17
> > Semantic error :SRC@SRC is not allowed.
> > 0 arguments
> >   Error: Command Parse Error. Reason: Invalid argument (Code: -22)
> > -- 
> > 
> > The attached patch ignores versioning for default symbols, thus
> > allowing probes to be created for these symbols:
> > -- 
> > $ /usr/bin/sudo ./perf probe -x
> > /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
> > Added new event:
> >   probe_libpthread:pthread_create (on pthread_create in
> > /lib/powerpc64le-linux-gnu/libpthread-2.19.so)
> > 
> > You can now use it in all perf tools, such as:
> > 
> >         perf record -e probe_libpthread:pthread_create -aR sleep 1
> > 
> > $ /usr/bin/sudo ./perf record -e probe_libpthread:pthread_create -aR
> > ./test 2
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.052 MB perf.data (2 samples) ]
> > $ /usr/bin/sudo ./perf script
> >             test  2915 [000] 19124.260729:
> > probe_libpthread:pthread_create: (3fff99248d38)
> >             test  2916 [000] 19124.260962:
> > probe_libpthread:pthread_create: (3fff99248d38)
> > $ /usr/bin/sudo ./perf probe --del=probe_libpthread:pthread_create
> > Removed event: probe_libpthread:pthread_create
> > -- 
> > 
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 4f9a71c..998b640 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -327,7 +327,23 @@ int map__load(struct map *map)
> >  
> >  int __weak arch__compare_symbol_names(const char *namea, const char
> > *nameb)
> >  {
> > -    return strcmp(namea, nameb);
> > +    int rc;
> > +    const char *namea_versioning, *nameb_versioning;
> > +
> > +    namea_versioning = strstr(namea,"@@");
> > +    if (namea_versioning)
> > +        namea = strndup(namea,namea_versioning-namea);
> > +
> > +    nameb_versioning = strstr(nameb,"@@");
> > +    if (nameb_versioning)
> > +        nameb = strndup(nameb,nameb_versioning-nameb);
> > +
> > +    rc = strcmp(namea, nameb);
> > +
> > +    if (namea_versioning) free((void *)namea);
> > +    if (nameb_versioning) free((void *)nameb);
> > +
> > +    return rc;
> >  }
> >  
> >  struct symbol *map__find_symbol(struct map *map, u64 addr)
> 
> 
> Generic code should not be put that in an arch__ function; perhaps a
> compare_symbol_names that does the checks and the arch one.

Right, I see this is an arch independant issue (since I can see same issue on x86).
IMO, we need a wrapper function (e.g. compare_symbol_names) and use it in caller sites.

Thank you,


> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
