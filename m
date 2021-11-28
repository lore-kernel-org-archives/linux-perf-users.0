Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F99C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 15:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358051AbhK1PmT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 10:42:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358065AbhK1PkT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 10:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638113822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mv1NvOXeQyiJrvL3ER4pPIxQ4R1Jg99P0t2qq4Q302o=;
        b=Rby+9wqUeKmxN9bCOzueXUmbwKSURJjbCuQJ4exj+O6A2UkzmPJ+ZA4/lE0C3gDx3OaoMT
        6DX559tvBh79LzWFDzNU9/GBzr3k6qGdYKAQtse6nF7/4q12JbP9r0yzOoH6B+Bbv3hqs2
        D9t701HF3i1qBcr6k/sh1KnuXMLXKhI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-vUf9qJUCPg-JWSqKtkXnpg-1; Sun, 28 Nov 2021 10:37:01 -0500
X-MC-Unique: vUf9qJUCPg-JWSqKtkXnpg-1
Received: by mail-wm1-f72.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so8963007wms.7
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 07:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mv1NvOXeQyiJrvL3ER4pPIxQ4R1Jg99P0t2qq4Q302o=;
        b=JeWLZ1d8XDAHDQjzLLwecDI6na9Zc3je0E2h+gHUrT+qaA6cqmJcmaryL6uL/hgzLA
         eMWUOjN+PM9DIt6oZ3dW4txXaONrd6IpI3nqQ0F8xlPT3iQ/pCI8Y99JZt/VThlmdNlA
         3lEmwspeqCqAxR5JiV6nUNIYT+8BI6MW7NAxUdSrJuvO5Nw7hefjFtWcz5TsB2W1w8+g
         A3yghHXMq4C0mWcr21fScoglD2bYvou/eV8buBYJFr09+Ml/ERNXZQSFS6cb1zulv9MS
         2SC95hUZY2H9t+oUjEjHzQaYOLxeeAoGSWq8UUszKyHHy7kPsDy5Omc/ox05nmD/6PnL
         vX0A==
X-Gm-Message-State: AOAM533KRmv4nRw8PQk1+ijuHrBhFoTbB9cl28vPbVli7sf8NCrOS2J+
        wYIAfuIJxQs136n1V7krHR8XUir9dFL+0Eo8/pmFGKv0INW4B/u9uMbUsNahFNMyimzghAWpty3
        enDXAIsYbovKKHiREK6ED/94bdcf/Jw==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr29565358wmc.110.1638113820331;
        Sun, 28 Nov 2021 07:37:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbeqR2RRDiywdsMZOmOMyncoPQuWlXCUSYpchdlFYZ0AGA8v+oxHm/WykAmLmag3FKmXJpSw==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr29565324wmc.110.1638113820091;
        Sun, 28 Nov 2021 07:37:00 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id a1sm14391161wri.89.2021.11.28.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:36:59 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:36:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Sandipan Das <sandipan.das@amd.com>, ravi.bangoria@amd.com,
        ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        kajoljain <kjain@linux.ibm.com>, acme@kernel.org
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
Message-ID: <YaOiGUNl7V83baEL@krava>
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava>
 <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
 <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
 <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
 <783c4cbc-667c-b6d0-fb05-5250e444d9b2@amd.com>
 <51cff547-4f13-bfa2-f977-75d51f0ce2ae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51cff547-4f13-bfa2-f977-75d51f0ce2ae@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 18, 2021 at 10:51:45AM -0600, Kim Phillips wrote:
> On 11/18/21 1:28 AM, Sandipan Das wrote:
> > 
> > On 11/16/2021 9:31 PM, Kim Phillips wrote:
> > > On 11/15/21 10:38 PM, kajoljain wrote:
> > > > On 11/15/21 3:28 PM, Sandipan Das wrote:
> > > > > 
> > > > > On 11/14/2021 10:11 PM, Jiri Olsa wrote:
> > > > > > good question.. I see raw events as a way to put to config whatever
> > > > > > the user wants and IMO adding changes/quirks that silently changes
> > > > > > config could create confusion and angry users ;-)
> > > > > > 
> > > > 
> > > > I agree, making quirks in config will only going to confuse users as
> > > > It's against the encodings we had in
> > > > /sys/bus/event_source/devices/<pmu>/format/*
> > > > 
> > > > > > I'd think that if user is composing/using raw events then using
> > > > > > directly r100001f8e is not such a big deal?
> > > > > > 
> > > > > 
> > > > > Sure. Some of the confusion may be due to the fact that the man pages
> > > > > for perf-{stat,record,top} state that raw events are "eventsel+umask".
> > > > > While that is technically true, it does not describe the encoding
> > > > > scheme (/sys/bus/event_source/devices/<pmu>/format/*)
> > > > > 
> > > > > Would another option be to update the man pages with a reference to
> > > > > these sysfs files when describing raw events?
> > > > > 
> > > > > Something like:
> > > > > 
> > > > > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > > > > index 2d7df8703cf2..5dfdfeba594b 100644
> > > > > --- a/tools/perf/Documentation/perf-record.txt
> > > > > +++ b/tools/perf/Documentation/perf-record.txt
> > > > > @@ -30,8 +30,10 @@ OPTIONS
> > > > > 
> > > > >            - a symbolic event name        (use 'perf list' to list all events)
> > > > > 
> > > > > -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
> > > > > -         hexadecimal event descriptor.
> > > > > +        - a raw PMU event (eventsel+umask) in the form of rN..NN where N..NN
> > > > > +          is a hexadecimal value representing the raw encoding with the layout
> > > > > +          of the corresponding event control register as defined by entries in
> > > > > +          /sys/bus/event_sources/devices/<pmu>/format/*
> > > > 
> > > > Do we need to specify (eventsel+umask) in the raw event description? As
> > > > the format/fields totally depend on PMU and umask name convention is
> > > > specific to one arch.
> > > > 
> > > > Can we just update it to:
> > > > 
> > > > - a raw PMU event in the form of rNNN where NNN is a hexadecimal value
> > > > representing the raw encoding, with the layout of the corresponding
> > > > event control register as defined by entries in
> > > > /sys/bus/event_sources/devices/<pmu>/format/*
> > > 
> > > The r notation is for the cpu pmu only.
> > > 
> > > The triple-digit 'NNN' is what's most misleading for 12-bit
> > > event implementation users, such as AMD's core PMUs.  It
> > > tells users 'see your processor's documentation's triple-
> > > hex-digit PMCx18e event?  All you need to do is make that
> > > "-e r18e" on the perf stat/record command line.
> > > 
> > > So all notions of what size of parameter 'r' takes, esp. 'NNN'
> > > should be removed IMO.  Perhaps an AMD/12-bit-specific
> > > example can be provided.
> > > 
> > > I had thought that the shorthand command line r spec alone
> > > could be modified to be smarter and more accommodating
> > > for conventional rUUEE users migrating to AMD/12-bit,
> > > which AFAICT is not what this patch does.  I think it
> > > modifies even the  cpu/config=0xNNNNN/ specification,
> > > which, granted, is bad.
> > > 
> > 
> > Sorry I didn't know that events could be programmed with "config=...".
> > Thanks for pointing that out. For basic '-e r...' usage, modifying
> > parse_events_add_numeric() and leaving parse_events_add_pmu() as is
> > should take care of it.
> > 
> > I thought about using the same fixup for the pmu format i.e. cpu/r0xNNNNN/
> > but as you rightly mentioned, it breaks when using cpu/config=0xNNNNN/.
> 
> I think we'd be breaking compatibility with changing -r,
> even if the two (0x100 and 0x200) event bits used for most
> three-digit AMD events are being masked.
> 
> Shall we just add an AMD-specific real-world 0xE0000UUEE example
> to the {stat,record} documentation to clear the mud?

sorry for late answer, but that seems to me like good idea

jirka

