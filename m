Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D42C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FE961139
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 13:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhI1NSb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240890AbhI1NSb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 09:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D6DF60F44;
        Tue, 28 Sep 2021 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632835011;
        bh=QbaaSCLAW6PTflFYrgqJpeOjJl/mht0XIz96o0/AUh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+KAefNCDNTfg2x5RewtC5Zxoj4StLY1MhjiGvuQxM4wSEf6P8jfJ6hJR6HcZ29/p
         Srcw6yZHE5q75nzyYNa05zl0AJIf5GmrptTkOJmDg80fv6yRISCJv0AkLGPk33EnZC
         dkJ79+ggxSjXfR9QgWO7ShTL61eVeE9+NUC0zF0eBT1vs1I1J1012XBAy3O0a9yR/g
         y8KmCfPv8wpnj9Z9dTvXpdKaOpE+1xp6IVaj9tRqOuGobjCBGABoQH+cN0nDVxSIX9
         NjiIgpMOAWDo6bAHRbXmZQ5CRi3Bui4gQ1Km2Nhza0p+y5w82lbpBkHEQ2n2fj8UiC
         oamkPLitmueyg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61955410A1; Tue, 28 Sep 2021 10:16:48 -0300 (-03)
Date:   Tue, 28 Sep 2021 10:16:48 -0300
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
Message-ID: <YVMVwDt3QHBPfT/T@kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
 <c547bc2d-ab7c-1e89-5d12-bd5d875f7aa5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c547bc2d-ab7c-1e89-5d12-bd5d875f7aa5@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 28, 2021 at 01:49:20PM +0100, John Garry escreveu:
> On 28/09/2021 12:52, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 28, 2021 at 06:29:38PM +0800, Like Xu escreveu:
> > > From: Like Xu <likexu@tencent.com>
> > > 
> > > The compiler reports that free_sys_event_tables() is dead code. But
> > > according to the semantics, the "LIST_HEAD(arch_std_events)" should
> > > also be released, just like we do with 'arch_std_events' in the main().
> > 
> > Thanks, applied.
> > 
> > - Arnaldo
> > 
> 
> If not too late:
> Reviewed-by: John Garry <john.garry@huawei.com>

Not too late, collected.
 
> I think that it could be a good idea to raise gcc warning level to detect
> unused static functions, like this was

Agreed, but we already have:

CORE_CFLAGS += -Wall
CORE_CFLAGS += -Wextra

We can se it for this specific case with:

$ make V=1 -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin | grep jevents
make -f /var/home/acme/git/perf/tools/build/Makefile.build dir=pmu-events obj=jevents
  gcc -Wp,-MD,/tmp/build/perf/pmu-events/.jevents.o.d -Wp,-MT,/tmp/build/perf/pmu-events/jevents.o  -D"BUILD_STR(s)=#s" -I/var/home/acme/git/perf/tools/include  -c -o /tmp/build/perf/pmu-events/jevents.o pmu-events/jevents.c
   ld -r -o /tmp/build/perf/pmu-events/jevents-in.o  /tmp/build/perf/pmu-events/json.o /tmp/build/perf/pmu-events/jsmn.o /tmp/build/perf/pmu-events/jevents.o
gcc /tmp/build/perf/pmu-events/jevents-in.o -o /tmp/build/perf/pmu-events/jevents
/tmp/build/perf/pmu-events/jevents x86 pmu-events/arch /tmp/build/perf/pmu-events/pmu-events.c 1
jevents: Processing mapfile pmu-events/arch/x86/mapfile.csv

Humm... no "-Wall -Wextra" there... lemme try to fix it

- Arnaldo
 
> thanks
> 
> > > Fixes: e9d32c1bf0cd7a98 ("perf vendor events: Add support for arch standard events")
> > > Signed-off-by: Like Xu <likexu@tencent.com>
> > > ---
> > >   tools/perf/pmu-events/jevents.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > > index 6731b3cf0c2f..7c887d37b893 100644
> > > --- a/tools/perf/pmu-events/jevents.c
> > > +++ b/tools/perf/pmu-events/jevents.c
> > > @@ -1285,6 +1285,7 @@ int main(int argc, char *argv[])
> > >   	}
> > >   	free_arch_std_events();
> > > +	free_sys_event_tables();
> > >   	free(mapfile);
> > >   	return 0;
> > > @@ -1306,6 +1307,7 @@ int main(int argc, char *argv[])
> > >   		create_empty_mapping(output_file);
> > >   err_out:
> > >   	free_arch_std_events();
> > > +	free_sys_event_tables();
> > >   	free(mapfile);
> > >   	return ret;
> > >   }
> > > -- 
> > > 2.32.0
> > 

-- 

- Arnaldo
