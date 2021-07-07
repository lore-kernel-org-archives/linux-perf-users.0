Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E9C11F6E
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F287961CB0
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGGSSc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231376AbhGGSS1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NrGcVRBBo+Z0eYxcvlX4IPWY2HOdWHb4cz21M2X2Wt8=;
        b=R8DVrKsiIVrZ9z56Ihp/eG8zMPxg4a41FeEH9rjTNM8ta6xJEdKeBw4TVk4NUinUXL1bZe
        WDoCcUYyEnKXFR2fh64QttttCoDb7VaaXP7Oqw9kjxicSEE/M8fGjNd2GjjFaZo7B5II/K
        i98zE6400Qirz5BQaW0nlJdo3TFP1DE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-tNXBghauPuOerA1bi502fA-1; Wed, 07 Jul 2021 14:15:44 -0400
X-MC-Unique: tNXBghauPuOerA1bi502fA-1
Received: by mail-wr1-f69.google.com with SMTP id m9-20020a0560000089b02901362e1cd6a3so1048274wrx.13
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 11:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrGcVRBBo+Z0eYxcvlX4IPWY2HOdWHb4cz21M2X2Wt8=;
        b=ol0ScYRnpsmlNOotSu98Oa9Fwr4DYAgS2W8GNsIRdlqysqqOndlN8Df/C7wc9ZHfYe
         RyLavAsRd1VriKk7rjp5NMjv2vQhsa6rLaWDWP6jtZBXQYYiwN2sqQWj6jBRl9rgzYX6
         a8Cp2E8fHgOtQGt6aCdNmegbzBehgUvGlAFcoi2bF2XHiZhteXeBj+gDHWOiXTjB+8J7
         zNVgXreN1Xsmcxk7aMr3IU4Zer7/zlS+1F+dJqILWEc9mrFvk3yhCChBw/e8WkVkq6iF
         c31i0rpnvkGuZhWY1Kl42+5PLgNxUbrgtvgAKyA49CKWFBR7osFmCz98fQU5lIf4/F5j
         sZew==
X-Gm-Message-State: AOAM533IPpXnSOue8iz1EjQytI2KhQuwbtqdp1EMd+zgZkMppj0Y8N93
        pVkKkRhqy327CQUBS15ukpwI0Tq32QzIcgin1kmQ320uEoxir0g6SkKut/33Ega4i4CVFay+yce
        6DZw3UYJHFdI8k9c5TCoXX4kI4qmq4g==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr28542084wra.223.1625681743684;
        Wed, 07 Jul 2021 11:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqhTb6ODPf1GGTRC0qV3o22LOaPlkQF9xV35mbGMXHfiCPSSivqTkDrWa9a3O+V+/sJ/IXBw==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr28542069wra.223.1625681743520;
        Wed, 07 Jul 2021 11:15:43 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id c1sm20825838wrp.94.2021.07.07.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:15:43 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:15:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/7] libperF: Add group support to perf_evsel__open
Message-ID: <YOXvSpcxeAnrGBTi@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-7-jolsa@kernel.org>
 <YOXnq2yTVwklbrpO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXnq2yTVwklbrpO@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 07, 2021 at 02:43:07PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:17:03PM +0200, Jiri Olsa escreveu:
> > Adding support to set group_fd in perf_evsel__open
> > call and make it to follow the group setup.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/evsel.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 3e6638d27c45..9ebf7122d476 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/string.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/mman.h>
> > +#include <asm/bug.h>
> >  
> >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> >  		      int idx)
> > @@ -76,6 +77,25 @@ sys_perf_event_open(struct perf_event_attr *attr,
> >  	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
> >  }
> >  
> > +static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
> > +{
> > +	struct perf_evsel *leader = evsel->leader;
> > +	int fd;
> > +
> > +	if (evsel == leader)
> > +		return -1;
> > +
> > +	/*
> > +	 * Leader must be already processed/open,
> > +	 * if not it's a bug.
> > +	 */
> > +	BUG_ON(!leader->fd);
> 
> Humm, having panics in library code looks ugly, why can't we just return
> some errno and let the whatever is using the library to fail gracefully?

true, I took it from perf code, did not realize this,
I'll check what can we do in ehre

> 
> I applied the patches so far, will make them available at tmp.perf/core
> now.

great, I'll take the patches from there for my next change

thanks,
jirka

> 
> - Arnaldo
> 
> > +	fd = FD(leader, cpu, thread);
> > +	BUG_ON(fd == -1);
> > +	return fd;
> > +}
> > +
> >  int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> >  		     struct perf_thread_map *threads)
> >  {
> > @@ -111,11 +131,13 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> >  
> >  	for (cpu = 0; cpu < cpus->nr; cpu++) {
> >  		for (thread = 0; thread < threads->nr; thread++) {
> > -			int fd;
> > +			int fd, group_fd;
> > +
> > +			group_fd = get_group_fd(evsel, cpu, thread);
> >  
> >  			fd = sys_perf_event_open(&evsel->attr,
> >  						 threads->map[thread].pid,
> > -						 cpus->map[cpu], -1, 0);
> > +						 cpus->map[cpu], group_fd, 0);
> >  
> >  			if (fd < 0)
> >  				return -errno;
> > -- 
> > 2.31.1
> > 
> 
> -- 
> 
> - Arnaldo
> 

