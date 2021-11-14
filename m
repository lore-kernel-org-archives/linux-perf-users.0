Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605AEC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4893C61027
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 16:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhKNQTh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 Nov 2021 11:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236137AbhKNQTV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Nov 2021 11:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636906582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ThPWPGxclO6HCx6vB+C0CqhUooFZuPsY+MpmwS3/Gc=;
        b=YYlNRkiwXaEQyW28ZUSOn16m8INW3phBdYHAUf6ClmoOcuvDivWcwZpqltt/7MqXzbtBgG
        uQK0lj7wK6rtLOBI42bxjyK3TznMcGDYzx96/qNi+j3cU/0Y86PiaTc3j/i2rH7D1YtSgS
        rpAFnPJ7kKru7LG1pQX4eWtvNDcOy9w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-oWtwMagVPTaBluYWnfb5IQ-1; Sun, 14 Nov 2021 11:16:20 -0500
X-MC-Unique: oWtwMagVPTaBluYWnfb5IQ-1
Received: by mail-wr1-f70.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso2515873wrj.12
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Nov 2021 08:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ThPWPGxclO6HCx6vB+C0CqhUooFZuPsY+MpmwS3/Gc=;
        b=zkRyRRaFeZFpYO5Uu8p8LteFnGZ6oS2qfzrvEDN3iYPF3PAi3XnD9djxjOudfux4HL
         0qLedx8GoRSrLq7in1vRwHrU9AUGXnBrDCWJRlQSkZohe7H6cCiQndI9fQTlqhZxm1MK
         sSzs22MY3J1XoOpzBNVqTCCCIFAqO1+o9k1dkUrtUFxYoGXbSw9R5U3d3dV7DnkY1s/T
         qbIeAEQlZHymjLPFMdujuNpeUFh5C6MTGacrAr8GvgSXc/DACbUYEjEl+86/5P0e6wPm
         LWoLGFx/K6izv5YJ+H3zrP5jVAxH0tSw7pZ9QKVD7cSttseE3Ot7yL+G1ZeZ5NkrOHhJ
         o7Kg==
X-Gm-Message-State: AOAM530H8gbuNoeysccqkSwwyLsPHwh01sgnccrH2GEn/C5L/pA2QOTl
        ubUeTPmGEw9jCBZCkEtzcKGOolPRdI1ldKPvanc+kDE/1oCHZ0tywriHmstZss2ES3YH0JUEncP
        yygAKxiyFs604oKwCg1XQ666tpjJz5w==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr34632451wmi.178.1636906579602;
        Sun, 14 Nov 2021 08:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2oV8uu5KGyTQ/J5RSZhjWT+kGR6eUEouyOQpXWZZz7HBXFNpNxKeToV473estwHh5eTSQ9w==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr34632427wmi.178.1636906579355;
        Sun, 14 Nov 2021 08:16:19 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f3sm17092956wmb.12.2021.11.14.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:16:18 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:16:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Rob Herring <robh@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Message-ID: <YZE2UNYUjO/Cpn24@krava>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
 <YUuhe7e0J0PSea+b@krava>
 <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YV8rpPWOgFa5ARlU@krava>
 <OSBPR01MB46000071426DEC8FFF04C4F6F7BD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600CC928A1D4BB0703EFAE3F7919@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4600CC928A1D4BB0703EFAE3F7919@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 12:49:24AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi Jirka
> 
> > > > > On Wed, Sep 22, 2021 at 07:16:26PM +0900, Shunsuke Nakamura wrote:
> > > > > > From: nakamura shunsuke <nakamura.shun@fujitsu.com>
> > > > > > 
> > > > > > perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> > > > > > does not scale counters obtained by read() system call.
> > > > > > 
> > > > > > Add processing to perf_evsel__read() to scale the counters obtained during the
> > > > > > read() system call when multiplexing.
> > > > > > 
> > > > > > 
> > > > > > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > > > > > ---
> > > > > >  tools/lib/perf/evsel.c | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > > 
> > > > > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > > > > index 8441e3e1aaac..0ebd1d34436f 100644
> > > > > > --- a/tools/lib/perf/evsel.c
> > > > > +++ b/tools/lib/perf/evsel.c
> > > > > > @@ -18,6 +18,7 @@
> > > > > >  #include <sys/ioctl.h>
> > > > > >  #include <sys/mman.h>
> > > > > >  #include <asm/bug.h>
> > > > > > +#include <linux/math64.h>
> > > > > >  
> > > > > >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> > > > > >                      int idx)
> > > > > > @@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > > > > >        if (readn(*fd, count->values, size) <= 0)
> > > > > >                return -errno;
> > > > > >  
> > > > > > +     if (count->ena != count->run) {
> > > > > > +             if (count->run != 0)
> > > > > > +                     count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> > > > > > +     }
> > > > > 
> > > > > so I think perf stat expect raw values in there and does the
> > > > > scaling by itself, please check following code:
> > > > > 
> > > > > read_counters
> > > > >   read_affinity_counters
> > > > >     read_counter_cpu
> > > > >       read_single_counter
> > > > >         evsel__read_counter
> > > > > 
> > > > >   perf_stat_process_counter
> > > > >     process_counter_maps
> > > > >       process_counter_values
> > > > >         perf_counts_values__scale
> > > > > 
> > > > > 
> > > > > perhaps we could export perf_counts_values__scale if it'd be any help
> > > > 
> > > > Thank you for your comment.
> > > > 
> > > > The purpose of this patch is to unify the counters obtained with 
> > > > perf_evsel__read() to scaled or unscaled values.
> > > > 
> > > > perf_evsel__read() gets counter by perf_mmap__read_self() if RDPMC is 
> > > > available, else gets by readn(). In current implementation, caller 
> > > > gets scaled counter if goes through RDPMC path, otherwise gets unscaled 
> > > > counter via readn() path.
> > > > 
> > > > However caller cannnot know which path were taken.
> > > > 
> > > > If caller expects a raw value, I think the RDPMC path should also 
> > > > return an unscaled counter.
> > > > 
> > > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > > index c89dfa5..aaa4579 100644
> > > > --- a/tools/lib/perf/mmap.c
> > > > +++ b/tools/lib/perf/mmap.c
> > > > @@ -353,8 +353,6 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
> > > >                 count->ena += delta;
> > > >                 if (idx)
> > > >                         count->run += delta;
> > > > -
> > > > -               cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
> > > 
> > > perf stat does not mmap counters so this should not be invoked
> > > within perf stat.. but we should be consistent and scale after
> > > calling perf_evsel__read.. and give user the possibility to get
> > > un-scaled counts
> > > 
> > > that perhaps brings new feature.. mmap perf stat counters to invoke
> > > the fast reading path for counters.. IIRC it should be matter just
> > > to mmap the first 'user' page
> > 
> > Thank you for your comment.
> > I think it will be good that perf stat supports rdpmc.
> > 
> > I will modify the patch. 
> 
> I think rdpmc cannot measure the command/program specified in perf stat 
> because it measures the calling thread of perf_event_open.
> If my understanding is wrong, please point it out to me.

right, I guess we could use that just for system wide monitoring,
where we open counter for each cpu

jirka

