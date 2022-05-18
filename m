Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B92C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiERV6g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiERV5k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 17:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF367179C01
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652910462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRq9jQlL5uauZYJOfwLJaX80FqOdAwkzNjvAZHd2sj0=;
        b=M2uJYnzQBxz4fGzsJVfcoYqnjCh70PDt60JTE589dt+PJXpouIYHW9QXfu6cp6Jfll1Lpo
        jQK9Zxt1NXR5xz8PX4fGlq3sjcg9ESkSQ5MUnB/rmsx1YnwDUsRkRLssAV7vJHHfeyq0qS
        ehJ4xxR02s5JvI7lh27oTAIHboCDM/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-qjb91ZU-OXG-sqkPbxeHlQ-1; Wed, 18 May 2022 17:47:41 -0400
X-MC-Unique: qjb91ZU-OXG-sqkPbxeHlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB6B185A5A8;
        Wed, 18 May 2022 21:47:40 +0000 (UTC)
Received: from Diego (unknown [10.39.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72B922026D6A;
        Wed, 18 May 2022 21:47:38 +0000 (UTC)
Date:   Wed, 18 May 2022 23:47:36 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Ian Rogers <irogers@google.com>
cc:     Arnaldo de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: perf stat report segfaults
In-Reply-To: <CAP-5=fU=kydiXW2Q_zc21dywD-wPWtwA8-dvcnu-e0VzOch_Hg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2205182311190.29735@Diego>
References: <alpine.LRH.2.20.2205180047230.29735@Diego> <CAP-5=fU=kydiXW2Q_zc21dywD-wPWtwA8-dvcnu-e0VzOch_Hg@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463784192-1261941476-1652910460=:29735"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784192-1261941476-1652910460=:29735
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 May 2022, Ian Rogers wrote:
> On Wed, May 18, 2022, 12:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
>       Hello Ian.
> 
>       I have been rebasing perf in RHEL to v5.17 and I have hit the following
>       problem:
> 
>       # perf stat record -- ls
>       [...]
>       # perf stat report
>       Segmentation fault (core dumped)
> 
>       Investigation led me to your patch:
> 
>       commit 7ac0089d138f80dcd7ba8ca368a9b2bdfe780b16
>       Author: Ian Rogers <irogers@google.com>
>       Date: Tue Jan 4 22:13:38 2022 -0800
> 
>         perf evsel: Pass cpu not cpu map index to synthesize
> 
>       This results in that perf_event__synthesize_stat()'s second argument
>       is -1 instead of 0 before.
> 
>       With that, the cpu field is stored as ff ff ff ff, as you can see in the
>       raw report:
> 
>       -1 -1 0x630 [0x30]: PERF_RECORD_STAT
>       ... id 9597, cpu -1, thread 1
>       ... value 3431216, enabled 3431216, running 3431216
>       : unhandled!
> 
>       0x660 [0x30]: event: 76
>       .
>       . ... raw event: size 48 bytes
>       .  0000:  00 00 00 4c 00 00 00 30 00 00 00 00 00 00 25 7e  ...L...0......%~
>       .+>0010:  ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 36  ...............6
>       .| 0020:  00 00 00 00 01 44 6e 89 00 00 00 00 01 44 6e 89  .....Dn......Dn.
>        |
>        here
> 
>       This value is later loaded and used as an index to xyarray in libperf, which
>       causes the segfault.
> 
> 
> Thanks for reporting this and sorry for the breakage! This kind of problem is something I've been trying  to fix. Basically perf has cpu
> maps that are sorted arrays of CPU numbers. For a counter that is available on every CPU this gets reported as say [0,1,2,3] on a 4 CPU
> system. Some counters are available on fewer CPUs, for example my 2 socket skylake machine has a memory controller counter with a cpu map
> of [0,18]. The indices into the CPU map are more densely encoded than just using the CPU number, so rather than have arrays (for things
> like file descriptors, saved values, etc.) sized by the number of CPUs they are sized by the CPU map size and indexed using the CPU map
> index. The problem I've been trying to fix is when the code has inadvertently swapped the two values. This can work if the CPU map has an
> entry for every CPU in the system, but fails for say my Skylake memory controller.

OK. Let's summarize what we are trying to store in the PERF_RECORD_STAT record.

I'd guess it is something like "event ABC (i.e. cpu-cycles) has been enabled
on "any" cpu (-1) and gave a value XYZ"

When I run `perf stat record -a -e cpu-cycles -- sleep 2`, I am getting `nproc`
entries of PERF_RECORD_STAT type each has a valid cpu number from 0 to 7 (my
machine has 8 cpus). Probably, when all the values are put together, I get this:

$ ./perf stat report

 Performance counter stats for '/home/Michael/Documents/SOURCES/acme/linux/tools/perf/perf stat record -a -e cpu-cycles -- sleep 2':

     2,907,751,861      cpu-cycles

       2.000957416 seconds time elapsed

I suppose that perf stat report when reading the perf.data, creates an xyarray
with all the data in and then by indexing by 0-7, it obtains the data.

This seems to make sense pretty much.

...

However, with "any" value (-1), which means "trace process `ls`, no matter which
cpu it gets scheduled on", we have the problem...

The data is stored at index 0 in xyarray, and the same index it should be read 
from.

From this point of view, my "if (cpu == -1) cpu = 0;" looks fine, just unclear.

Am I right?
> 
> In your example here the CPU value of -1 is a special "any" CPU marker that is described in the perf_event_open man page. When trying to
> work out the intent of the code in fixing CPU vs index I'd push the value through the API and try to use an intention revealing name, so
> typically cpu_map_idx. In this case this appears to have been done on the writing side but not on the reading side.
> 
>       This is my "hotfix":
> 
>       diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>       index 817a2de264b4..b6ca193ff972 100644
>       --- a/tools/perf/util/stat.c
>       +++ b/tools/perf/util/stat.c
>       @@ -472,9 +472,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>        int perf_event__process_stat_event(struct perf_session *session,
>                                          union perf_event *event)
>        {
>       -       struct perf_counts_values count;
>       +  struct perf_counts_values count, *ptr;
>               struct perf_record_stat *st = &event->stat;
>               struct evsel *counter;
>       +       int cpu = st->cpu;
> 
>               count.val = st->val;
>               count.ena = st->ena;
>       @@ -486,7 +487,9 @@ int perf_event__process_stat_event(struct perf_session *session,
>                       return -EINVAL;
>               }
> 
>       -       *perf_counts(counter->counts, st->cpu, st->thread) = count;
>       +       if (cpu == -1) cpu = 0;
>       +       ptr = perf_counts(counter->counts, cpu, st->thread);
>       +       if (ptr) *ptr = count;
>               counter->supported = true;
>               return 0;
>        }
> 
> 
>       It needs to be reworked, but checking whether perf_counts() returns
>       not-NULL pointer is necessary anyway.
> 
>       My question here is what the -1 actually means and whether I can simply
>       do "if (cpu == -1) cpu = 0;", since the data lies on "offset" 0 anyway,
>       even when it's recorded by perf with your patch...
> 
> 
> So I'd rather this wasn't fixed this way. The "cpu" here is really a cpu_map_idx, we need to work backward to make sure that is the case.
> To try to make this safer I created a struct perf_cpu to disambiguate indices from CPU values. When we load the -1 from the file we need
> to turn it into an index using the cpu map. As the array is sorted the index will always be 0, but it would be nicer to use
> perf_cpu_map__idx [1] to show we're translating from what to what and how it relates to a particular cpu map.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/include/internal/cpumap.h?h=perf/core#n27

OK, so instead of

  if (cpu == -1) cpu = 0;

we might use something like

  int cpu = perf_cpu_map__idx();

How the perf_cpu_map__idx() args are specified?

And then continue with:

  ptr = perf_counts(counter->counts, cpu, st->thread);
  if (ptr != NULL)
  {
    *ptr = count;
	counter->supported = true;
	return 0;
  }
  return -EINVAL;

The NULL check instead of Jiri Olsa's oneliner
*perf_counts(counter->counts, st->cpu, st->thread) = count;
... is needed in my opinion, just because perf_counts() function
*can* return NULL.

>  
>       I think the -1 comes from perf_event_open syscall, where cpu == -1 means
>       all cpus. Am I right?
> 
> 
> Yep, I'm trying to distinguish "all" from "any". On a 4 CPU system all would be [0, 1, 2, 3] while any would be [-1].
>  
>       In your opinion, what should be done to fix this problem the best way?
> 
> 
> Notes above but I'll also try to take a look at this using your very simple reproducer (which should definitely be a test).

... which is a test for a quite long time.

Some years ago, I wrote a perf testsuite here:
https://github.com/rfmvh/perftool-testsuite
(still updated and developed)

However, upstreaming this testsuite to Linus' repo failed two times, so
I've given up.

The problem with this testsuite is that very few people outside Red Hat
actually use it. But I think it'd deserve to be run for upstream perf
before merging bigger patches too.

It's a pity, since I think the test coverage of the testsuite is quite
wide nowadays.

If you want to run it, just clone the repo, cd to base_stat and run
./test_record_report.sh

Requirements for the testsuite are simple -- perl, gcc, gcc-c++, bc
and bash...


Thank you for your answer and looking at it.
Michael

> 
> Thanks,
> Ian
>  
>       Thank you.
>       Michael
> 
> 
> 
---1463784192-1261941476-1652910460=:29735--

