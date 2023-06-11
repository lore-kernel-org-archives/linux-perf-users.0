Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456FCC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jun 2023 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFKRDE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jun 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjFKRDD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jun 2023 13:03:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B982E64
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 10:03:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9b7de94e7so231501cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686502980; x=1689094980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxeoHOZYaH8t6ghE/iZba4B+L8prc3MRJkS4u8iwn+k=;
        b=ybr6I0abcnIdAfJm/R1lxdxe3DZkZr8t7NcW7rwbcz3qcGpOaFVhErccTBggG5/iuA
         ypOl9b0L3lVLECC5NZubIIPzBi5llrROgGh70AZv/lWZJuc7ABXIG2/1jNEy1yp6zT2Z
         uW2yMWetTjL2uiPL9rTcZ6+CnCFYWFZ5mgvkgNIg3DSjdPaPVDOb5NGYQx3OA3wmNrL9
         YTH1jOJXUzRaXVG4kLxTOhnRYiSGqieIYD5QEjUETEPqHwdxOKx/MEUAH+Q1IqxpkAue
         aKWr+SXZS1xnaPHN+BztouN2vPRXjnoW6M8LfBADCfp+w6f5Rw4YBfZWw4fQ6M4JUY3i
         Y0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686502980; x=1689094980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxeoHOZYaH8t6ghE/iZba4B+L8prc3MRJkS4u8iwn+k=;
        b=gotjqxw2nI2FtAcsNLrGmsxk7anuFNKb/BP18Sn8dwr9FUPSGeVhWe0VZbf3+XL0DE
         UWW6g2IXP8SEWCQX6uXhFrzaOxSd3w5t2hn4wN+stN8N905CwkP63LlPeMJG7Pjlvb/m
         koGXM7DDPxpjQyJYI9VrcjekF9DTU6r6VfHIaijM2zbjOvCfWE8SQt3jr/U062LfxbwN
         UoupluTiUozlutQOsUv57RbKu+Xd3+2ar8HMsKmLAlyygp/6FnmLOERQKAPdfzaNfNs8
         plG/rwbPl7WpsL4KBCw043GmsI8Wb1vaVzZS3sdebn/+u83CqVhJkNaoHtVvsxstWg3I
         +zoA==
X-Gm-Message-State: AC+VfDyDftfHblYtSxiO7hd0Gf2Q0zFomhIONy6vohwoAsxT1wqwnvfy
        e3r158u7NJQNXWMrLT1B/Uu1W09EuL7ssWJcdmbgCxSqoBi7bxUaXHoJkA==
X-Google-Smtp-Source: ACHHUZ6OmztjnyM1lSKv0aLgQvbflZi2KvGBZipiXimCbLuUI1TLx48iES8mmOXXc4Titx6AZ25d8p+UfdR+b3KlZuI=
X-Received: by 2002:ac8:7c53:0:b0:3f9:ad2e:4801 with SMTP id
 o19-20020ac87c53000000b003f9ad2e4801mr169445qtv.17.1686502980484; Sun, 11 Jun
 2023 10:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPXMrf9mRG_uyEdkppJOjJxCREXjZsXGo2A_QEtwHM4G+nJoEA@mail.gmail.com>
 <CAP-5=fXth=1qRgH6iNKt6eAWt4MM4Xd0jn8o65BD9SDq8v6uYg@mail.gmail.com>
 <a63d33cf-de35-c41c-abb3-d55577e67d6d@arm.com> <36dd3607-fe6e-6f79-3932-f96b554c1d1e@arm.com>
 <aa998b2c-fa35-8e71-fe54-a5bffcfa30ae@arm.com>
In-Reply-To: <aa998b2c-fa35-8e71-fe54-a5bffcfa30ae@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 11 Jun 2023 10:02:48 -0700
Message-ID: <CAP-5=fXQR5JeKyfgXG2-j_Ay61xhZPP0j+VtsNkW=e3--_Hr0g@mail.gmail.com>
Subject: Re: Reg: Perf report consuming too high memory
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     RAJESH DASARI <raajeshdasari@gmail.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 2, 2023 at 3:45=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
>
>
> On 02/06/2023 11:36, James Clark wrote:
> >
> >
> > On 02/06/2023 11:24, James Clark wrote:
> >>
> >>
> >> On 02/06/2023 00:30, Ian Rogers wrote:
> >>> On Thu, Jun 1, 2023 at 6:51=E2=80=AFAM RAJESH DASARI <raajeshdasari@g=
mail.com> wrote:
> >>>>
> >>>> Hi ,
> >>>>
> >>>> I am noticing high memory usage, oom killer is invoked and restartin=
g
> >>>> our node while running perf report command.
> >>>>
> >>>>  perf record -a  -g   sleep 120
> >>>> [ perf record: Woken up 2472 times to write data ]
> >>>> [ perf record: Captured and wrote 623.050 MB (3830374 samples) ]
> >>>>
> >>>> perf report
> >>>>
> >>>>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+=
 COMMAND
> >>>>  119877 root      20   0 7335760   7.0g 670244 S   0.0  59.7   0:22.=
23 perf
> >>>>
> >>>> perf report command is consuming more memory, oom killer is invoked.
> >>>> System details : kernel 5.4.242 + glibc 2.26 + gcc12
> >>>> I tried with perf 6.x versions but I still see more memory consumpti=
on.
> >>>>
> >>>> I tried the same experiment on a different system under the same loa=
d
> >>>> , this system has ( kernel 5.4.242 + glibc 2.24 + gcc 11)
> >>>>
> >>>> perf record -a  -g  sleep 120
> >>>> [ perf record: Woken up 1868 times to write data ]
> >>>> [ perf record: Captured and wrote 470.203 MB
> >>>> /tmp/rcpprofiling/data_cg.data (3828394 samples) ]
> >>>>
> >>>> perf report
> >>>>
> >>>> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ C=
OMMAND
> >>>> 840045 root      20   0 1459520   1.4g 493380 R  98.1  11.8   0:31.2=
1
> >>>> perf report
> >>>>
> >>>>
> >>>> I see that the more the perf.data file size, the more  memory it
> >>>> consumes, but in this case i only see 200MB difference between the
> >>>> perf.data file and also only 2k sample difference, but memory
> >>>> consumption is too high in the first system.
> >>>>
> >>>> What could be the reason, is this expected behaviour or how to debug
> >>>> why perf is consuming more memory here  . Please help me with this
> >>>> query .
> >>>
> >>> Hi Rajesh,
> >>>
> >>> As you are using perf in system wide mode every running process has
> >>> its memory map added to the perf.data file, this is so that a virtual
> >>> address in a sample can be turned into a file offset. perf report wil=
l
> >>> process the shared objects and even use objdump to annotate them. Thi=
s
> >>> can all be pretty costly in terms of memory but it sounds like perf i=
s
> >>> working-as-intended. Have you tried just attaching perf to the proces=
s
> >>> you are interested in?
> >>>
> >>
> >> For the mapped in binaries I would expect that to show up on virtual
> >> memory used rather than resident. For a 10 second -a sleep recording o=
n
> >> my laptop perf report takes 5.9G of resident memory to show 476K sampl=
es.
> >>
> >> Running it with 'valgrind --tool=3Dmassiv' then 'massif-visualizer' I =
can
> >> see it's pretty much all the allocations for the callchains:
> >>
> >>  4.7 GiB: zalloc (zalloc.c:8)
> >>   4.3GiB: fill_node (callchain.c:585)
> >>    4.3 GiB: add_child (callchain.c:646)
> >>     3.6 GiB: append_chain_children (callchain.c:906)
> >>      ...
> >>
> >> But this was a recording without --call-graph, so it's like it's using
> >> 12KB per sample for one level of callchains (if you divide 5.9G by
> >> 476K). Maybe that's not really an excessive amount of memory. It could
> >> probably be optimised a bit but maybe the issue is the default sample
> >> rate and using -a after all.
> >>
> >
> > Actually if I open it with --call-graph=3Dnone it only uses 670MB of
> > resident memory. So a pretty huge reduction, and the report doesn't loo=
k
> > so much different because it wasn't recorded with callgraphs in the
> > first place. That could help with your issue Rajesh.
> >
>
> Oh sorry I see the -g short form is for default --call-graphs, so that
> explains it. All my top results in the report were only 1 deep but
> that's probably because of debug symbols or something. There are
> probably other much longer ones elsewhere in the report so my
> calculation above can be disregarded.

Fwiw, I think there are a number of low hanging fruits for improving
the memory usage. One problem we've had is with memory leaks. With
this patch series that Arnaldo has in tmp.perf-tools-next
(https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/):
https://lore.kernel.org/lkml/20230608232823.4027869-1-irogers@google.com/

we are address and leak sanitizer clean. The work is based on the
reference count checking, which was controversial when first proposed,
was merged in 6.4 and now with the patch series leak sanitizer is
saying there are no memory leaks. It'd be great if people could check
that leak sanitizer is good when running not on x86-64.

When I've looked in the past the most costly thing in terms of RAM has
been symbols:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/symbol.h?h=3Dperf-tools-next#n44

Threads have mmaps (known as maps in the code) so that virtual
addresses in samples can be looked up, mmaps have dsos and dsos have
symbols associated with particular addresses. Symbols are dynamically
sized as they have the name of the symbol as an array after the
struct. They are also dynamically sized as they may have a things
before them as documented in the comment:

/**
 * A symtab entry. When allocated this may be preceded by an annotation (se=
e
 * symbol__annotation), a browser_index (see symbol__browser_index) and rb_=
node
 * to sort by name (see struct symbol_name_rb_node).
 */

So taking these in turn:
 - symbol__annotation puts a "struct annotation" before the symbol:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/annotate.h?h=3Dperf-tools-next#n274

    the struct annotation is not cheap and these patches get rid of
the largest part of it, the mutex:
https://lore.kernel.org/lkml/20230611072751.637227-1-irogers@google.com/

   There is still more that can be done with struct annotation. The widths:

struct {
u8 addr;
u8 jumps;
u8 target;
u8 min_addr;
u8 max_addr;
u8 max_ins_name;
} widths;

   Are to do with UI printing. Do we really need to allocate these for
every symbol even if we've not run perf annotate? It seems they can
move into "struct annotated_source" saving 6 bytes in cases like perf
top. The cycles and IPC data:

u64 hit_cycles;
u64 hit_insn;
unsigned int total_insn;
unsigned int cover_insn;

   is filled in optionally if annotate2 is run:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/symbol.h?h=3Dperf-tools-next#n66

   but we allocate the space regardless. Perhaps this can be a lazy
initialization pattern or the data moved to "struct annotated_source".
Perhaps a logical conclusion for that is to just make the value
preceding symbol a lazily created "struct annotation *".

 - the browser index is a u32 only present if verbose is enabled and
that has a FIXME:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/ui/browsers/map.c?h=3Dperf-tools-next#n42
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/builtin-report.c?h=3Dperf-tools-next#n1670

 - sort by name requires an rb_node, so 3 pointers:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/symbol.h?h=3Dperf-tools-next#n97
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/i=
nclude/linux/rbtree.h?h=3Dperf-tools-next#n23

   The main things that name sorting is used for is finding names in a
dso. For the same complexity we could switch to an array of "struct
symbol *" where the array is sorted by symbol name. The search
complexity would still be O(n*log(n)) and the creation complexity
would still be O(n*log(n)), but the overhead would be 1 pointer (in
the array) instead of 3 in symbol. There is also an iterator to
iterate by name:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/map.h?h=3Dperf-tools-next#n145
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/symbol.c?h=3Dperf-tools-next#n593

   but it should be straightforward to scan the array rather than the rbtre=
e.

I think we should be able to get the symbol overhead to be half of
what it is presently in cases like perf top and perf report, but I may
be overlooking things. With the 0 memory leaks that
perf-tools-next/Linux 6.5 is bringing, I think we may be in good shape
to unload dsos/symbols based on memory pressure. We should be able to
make perf commands run in a lot less RAM and patches improving this
would be welcome.

Thanks,
Ian

> >>> Thanks,
> >>> Ian
> >>>
> >>>> Thanks,
> >>>> Rajesh Dasari.
