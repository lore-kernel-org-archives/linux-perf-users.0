Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C5DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A826261058
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbhJGRTZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243032AbhJGRTX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633627049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o13jElEgGhyWsx3ZOARC0F5t/PnflMj2/CYzyGPJ5Uw=;
        b=VW2ZFbUJxDNDmWGnd4Wd6wBndTpwhL5w4/rlUexV3eSIhyiOHO/doi8I8lJ5/lcBDULFNu
        kdbPDrZtHbNDFbpZygl7nXukor7wFEJp4dNed7wl7CAUtlgMSJ4tkPMxU0DLZ60p5bgeRe
        rAMK8UH32qgB2ASUqRT8/ISz5j8qxi8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-UCVvZkZoMTK1sgOEzRCFkQ-1; Thu, 07 Oct 2021 13:17:28 -0400
X-MC-Unique: UCVvZkZoMTK1sgOEzRCFkQ-1
Received: by mail-wr1-f69.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so1574972wrm.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 10:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o13jElEgGhyWsx3ZOARC0F5t/PnflMj2/CYzyGPJ5Uw=;
        b=JtP/RGKneQvXz0JSGOtJ/R5E1ruKY605p9MvEfBVK51lC2sse4iiGyd7YTZFN1pv66
         UEXy896lH00609KdLu6ehXmu14kg+iNQ3MiMfNBydzTtSrjoe5XWu87x/tHLE1/trjLk
         W0oQink15LvKBqwVGO8KICiH3YN9TbUbK/24or1a9ccsv7b9N1n6q6T7Zc7L+QHQashR
         1q1hwpUXlALuTjJqJXoeKrxavZq1IimgOsLMV9j19RNWRtb9JKULwjt0NMiFwryVbTp5
         WLB13iBrTTcZNrbfO9JthT2kr4o/ctCypDABrh9Z1PY++40BiTlf1vg6/VuWAcyz2AaX
         UVWw==
X-Gm-Message-State: AOAM531WkDMmIOMEAGbrnnlP1IoWf1tlyVBZDRnucr2PXu4bnX7gNwCu
        xjSMM49cEPNP/++IuXNqiTJAYcKcyKGmjeWqgby8+z/ihaqNgcMLLz86sh7mVXg4pJYjHeo/X8p
        P7TzX5c7qKcPCgarNi4Ed5ElxDGPaJA==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr7126852wrb.265.1633627046990;
        Thu, 07 Oct 2021 10:17:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNV84pxmeYL9Pqg6ycHriw11po1eCQF6EMB4tY/n39sppATmfSI927JhoHpaLxdIaNCXHSlw==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr7126829wrb.265.1633627046749;
        Thu, 07 Oct 2021 10:17:26 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n7sm222782wra.37.2021.10.07.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:17:26 -0700 (PDT)
Date:   Thu, 7 Oct 2021 19:17:24 +0200
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
Message-ID: <YV8rpPWOgFa5ARlU@krava>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
 <YUuhe7e0J0PSea+b@krava>
 <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 28, 2021 at 09:53:24AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi Jirka
> 
> > On Wed, Sep 22, 2021 at 07:16:26PM +0900, Shunsuke Nakamura wrote:
> > > From: nakamura shunsuke <nakamura.shun@fujitsu.com>
> > > 
> > > perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> > > does not scale counters obtained by read() system call.
> > > 
> > > Add processing to perf_evsel__read() to scale the counters obtained during the
> > > read() system call when multiplexing.
> > > 
> > > 
> > > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > > ---
> > >  tools/lib/perf/evsel.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > index 8441e3e1aaac..0ebd1d34436f 100644
> > > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > > @@ -18,6 +18,7 @@
> > >  #include <sys/ioctl.h>
> > >  #include <sys/mman.h>
> > >  #include <asm/bug.h>
> > > +#include <linux/math64.h>
> > >  
> > >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> > >                      int idx)
> > > @@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > >        if (readn(*fd, count->values, size) <= 0)
> > >                return -errno;
> > >  
> > > +     if (count->ena != count->run) {
> > > +             if (count->run != 0)
> > > +                     count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> > > +     }
> > 
> > so I think perf stat expect raw values in there and does the
> > scaling by itself, please check following code:
> > 
> > read_counters
> >   read_affinity_counters
> >     read_counter_cpu
> >       read_single_counter
> >         evsel__read_counter
> > 
> >   perf_stat_process_counter
> >     process_counter_maps
> >       process_counter_values
> >         perf_counts_values__scale
> > 
> > 
> > perhaps we could export perf_counts_values__scale if it'd be any help
> 
> Thank you for your comment.
> 
> The purpose of this patch is to unify the counters obtained with 
> perf_evsel__read() to scaled or unscaled values.
> 
> perf_evsel__read() gets counter by perf_mmap__read_self() if RDPMC is 
> available, else gets by readn(). In current implementation, caller 
> gets scaled counter if goes through RDPMC path, otherwise gets unscaled 
> counter via readn() path.
> 
> However caller cannnot know which path were taken.
> 
> If caller expects a raw value, I think the RDPMC path should also 
> return an unscaled counter.
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index c89dfa5..aaa4579 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -353,8 +353,6 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
>                 count->ena += delta;
>                 if (idx)
>                         count->run += delta;
> -
> -               cnt = mul_u64_u64_div64(cnt, count->ena, count->run);

perf stat does not mmap counters so this should not be invoked
within perf stat.. but we should be consistent and scale after
calling perf_evsel__read.. and give user the possibility to get
un-scaled counts

that perhaps brings new feature.. mmap perf stat counters to invoke
the fast reading path for counters.. IIRC it should be matter just
to mmap the first 'user' page

thanks,
jirka

>         }
> 
>         count->val = cnt;
> 
> Rob, do you have any comments?
> 
> Best Regards
> Shunsuke

