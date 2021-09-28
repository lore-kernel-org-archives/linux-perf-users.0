Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C9C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B44611CB
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhI1MjS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240526AbhI1MjS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 08:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C15DD611CA;
        Tue, 28 Sep 2021 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632832658;
        bh=+JnuFX92dT3ZwyWt5V3PBwayU1FCUtczCLj2D+OBQ94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMBwCVGacOSeRXSk4fi6xpxoRs5B4134685XDnqGZLoOINwl5h0EqgVaYT2E96zsu
         Nh/SjzFYH4nxVNi1NRxDozq/ZcDkxNZ5dLIHl3RV0l8+D4wlN019vFy5Vxl5MNDgzc
         uFHRmeqGUGUFaP6dmm3rCVbcccjBRXViYm78IfF6jKa4V1Q0bIvuDVZxG96TAJR4Vf
         gN7VsDrteepV9ZBieAb9R80Y33nkLuX1IBpJbUhW4aT9m+VwbfMDDAan3V7y+iD1lI
         yrKnAHv6i4qDLjGdHL5RR25+JLl9PHlFiNLGsRSUKEZUk/Y5TsBQZsev8BwCGD/2um
         TRCppn9c9mysA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24745410A1; Tue, 28 Sep 2021 09:37:36 -0300 (-03)
Date:   Tue, 28 Sep 2021 09:37:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
Message-ID: <YVMMkIO+XNIk0xUj@kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
 <7ff0a3bf-ebfc-2462-f6ed-d86a67bbd614@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff0a3bf-ebfc-2462-f6ed-d86a67bbd614@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 28, 2021 at 07:53:54PM +0800, Like Xu escreveu:
> On 28/9/2021 7:52 pm, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 28, 2021 at 06:29:38PM +0800, Like Xu escreveu:
> > > From: Like Xu <likexu@tencent.com>
> > > 
> > > The compiler reports that free_sys_event_tables() is dead code. But
> > > according to the semantics, the "LIST_HEAD(arch_std_events)" should
> Sorry, s/arch_std_events/sys_event_tables/, please --amend.

sure
 
> > > also be released, just like we do with 'arch_std_events' in the main().
> > 
> > Thanks, applied.
> > 
> > - Arnaldo
> > 
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
