Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C4FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26EF611CA
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 13:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbhI1NYS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240579AbhI1NYR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 09:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6748C611BD;
        Tue, 28 Sep 2021 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632835358;
        bh=cWaVXKQuN3nkLq32pZ/eOvCZQPH57EVZSiGyda8i8F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdmWfrfsJwEAyZfjzOtPJp3ifg4fVak+YTq/bqBKF2AU6gNd5YQ3gptbMO7oKMMlX
         +zhdSXFgW5semnuzJglE9aaVXFQpeXMIteMYpCU563Awd53cx2OVsn1n6wMhJsxhIG
         z7Ln/jD38NA0dtq2J+TIZMrwvK6OJUma/FqMnx+Qo0JgUTaTWrjhU7YfvA7MqVPXTe
         GbK3C/gcAI/XRwCfXsDOW7KcbWs8J5WQFH9mhwOxZJ4ax4mAFAvcy0MFfkUF64BnWa
         WCt9WHd09g5ip5cVAtpJI3c/X/FlnO1M9tZ/iYat0e7R8C4l/0xyltK1HH/veNlyyK
         en744RjDi3mMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10C9F410A1; Tue, 28 Sep 2021 10:22:36 -0300 (-03)
Date:   Tue, 28 Sep 2021 10:22:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
Message-ID: <YVMXHM0F/y2ptX8C@kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
 <c547bc2d-ab7c-1e89-5d12-bd5d875f7aa5@huawei.com>
 <YVMVwDt3QHBPfT/T@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVMVwDt3QHBPfT/T@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 28, 2021 at 10:16:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Sep 28, 2021 at 01:49:20PM +0100, John Garry escreveu:
> > On 28/09/2021 12:52, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Sep 28, 2021 at 06:29:38PM +0800, Like Xu escreveu:
> > > > From: Like Xu <likexu@tencent.com>
> > > > 
> > > > The compiler reports that free_sys_event_tables() is dead code. But
> > > > according to the semantics, the "LIST_HEAD(arch_std_events)" should
> > > > also be released, just like we do with 'arch_std_events' in the main().
> > > 
> > > Thanks, applied.
> > > 
> > > - Arnaldo
> > > 
> > 
> > If not too late:
> > Reviewed-by: John Garry <john.garry@huawei.com>
> 
> Not too late, collected.
>  
> > I think that it could be a good idea to raise gcc warning level to detect
> > unused static functions, like this was
> 
> Agreed, but we already have:
> 
> CORE_CFLAGS += -Wall
> CORE_CFLAGS += -Wextra
> 
> We can se it for this specific case with:
> 
> $ make V=1 -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin | grep jevents
> make -f /var/home/acme/git/perf/tools/build/Makefile.build dir=pmu-events obj=jevents
>   gcc -Wp,-MD,/tmp/build/perf/pmu-events/.jevents.o.d -Wp,-MT,/tmp/build/perf/pmu-events/jevents.o  -D"BUILD_STR(s)=#s" -I/var/home/acme/git/perf/tools/include  -c -o /tmp/build/perf/pmu-events/jevents.o pmu-events/jevents.c
>    ld -r -o /tmp/build/perf/pmu-events/jevents-in.o  /tmp/build/perf/pmu-events/json.o /tmp/build/perf/pmu-events/jsmn.o /tmp/build/perf/pmu-events/jevents.o
> gcc /tmp/build/perf/pmu-events/jevents-in.o -o /tmp/build/perf/pmu-events/jevents
> /tmp/build/perf/pmu-events/jevents x86 pmu-events/arch /tmp/build/perf/pmu-events/pmu-events.c 1
> jevents: Processing mapfile pmu-events/arch/x86/mapfile.csv
> 
> Humm... no "-Wall -Wextra" there... lemme try to fix it

With this:

⬢[acme@toolbox perf]$ git diff
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46af77e..ea7107630bf4327f 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,7 @@
 hostprogs := jevents

 jevents-y      += json.o jsmn.o jevents.o
-HOSTCFLAGS_jevents.o   = -I$(srctree)/tools/include
+HOSTCFLAGS_jevents.o   = -I$(srctree)/tools/include -Wall -Wextra
 pmu-events-y   += pmu-events.o
 JDIR           =  pmu-events/arch/$(SRCARCH)
 JSON           =  $(shell [ -d $(JDIR) ] &&                            \
⬢[acme@toolbox perf]$

I get this before applying Xu's patch:

  LINK    /tmp/build/perf/libbpf.a
pmu-events/jevents.c: In function ‘save_arch_std_events’:
pmu-events/jevents.c:473:39: warning: unused parameter ‘data’ [-Wunused-parameter]
  473 | static int save_arch_std_events(void *data, struct json_event *je)
      |                                 ~~~~~~^~~~
At top level:
pmu-events/jevents.c:93:13: warning: ‘free_sys_event_tables’ defined but not used [-Wunused-function]
   93 | static void free_sys_event_tables(void)
      |             ^~~~~~~~~~~~~~~~~~~~~


-------------------------------------

I'll add this to perf/core, as this isn't a strict fix, so can wait for
v5.16.

- Arnaldo
