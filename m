Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99821C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7558960E52
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhHJOBf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240095AbhHJOBf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9EEF600CD;
        Tue, 10 Aug 2021 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628604073;
        bh=us0HzEBX/W5loXdCO8hr6J585fhTK/EB9VDovlCx3v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4kmDveMC10bO/v0RhDZvZFjtrC2GsvVIKEHVDyXshd7svecYkblUKvk3xEHHTEj+
         hOEEiE5K1Za+rcXbjHk+grLNVLNb9FKdieOP+RIRXEi7gcYASdLrKjLQS+xZlZ8a4H
         pwqHzgzaqsjQrf/rOJzXZDraDDSVT+ym65YJfR/c4nh/6K3BrIl6inkZxtHF0Ak574
         VcuVztz9e4Z6TilvT5ZvUzu8avZAvfoOctqezdaKPGoOiOvMusl7SC/mRoNhMD4qJy
         DlC37OTAbx7tJ/XQbWexQ0DpLqk0gTF+hUbpWTXAGbZEMDmhUrePZeQsuLAPnIwUTl
         PamZn0jdpz8AQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBF96403F2; Tue, 10 Aug 2021 11:01:07 -0300 (-03)
Date:   Tue, 10 Aug 2021 11:01:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, linuxarm@huawei.com
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
Message-ID: <YRKGo1AtfBn85sZ7@kernel.org>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
 <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
 <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 04:46:04PM +0100, John Garry escreveu:
> On 03/08/2021 09:19, John Garry wrote:
> > So I think we need something like this:
> > 
> > ----->8--------
> > 
> >  From a08df563665e9ec088b1af86ceed058497e112a4 Mon Sep 17 00:00:00 2001
> > From: John Garry <john.garry@huawei.com>
> > Date: Tue, 3 Aug 2021 08:44:09 +0100
> > Subject: [PATCH] perf jevents: Make build dependency on test JSONs
> > 
> > Currently all JSONs and the mapfile for an arch are dependencies for
> > building pmu-events.c
> > 
> > The test JSONs are missing as a dependency, so add them.
> > 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > 
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 215ba30b8534..a055dee6a46a 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -6,10 +6,13 @@ pmu-events-y    += pmu-events.o
> >   JDIR        =  pmu-events/arch/$(SRCARCH)
> >   JSON        =  $(shell [ -d $(JDIR) ] &&                \
> >               find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
> > +JDIR_TEST    =  pmu-events/arch/test
> > +JSON_TEST    =  $(shell [ -d $(JDIR_TEST) ] &&            \
> > +            find $(JDIR_TEST) -name '*.json')
> > 
> >   #
> >   # Locate/process JSON files in pmu-events/arch/
> >   # directory and create tables in pmu-events.c.
> >   #
> > -$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
> > +$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
> >       $(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch
> > $(OUTPUT)pmu-events/pmu-events.c $(V)
> > 
> > 
> > -----8<-----
> 
> Hi Arnaldo,
> 
> Shall I send this as a formal patch?

The question is when should I apply this patch? After this series? After
the patch I commented about, before?

- Arnaldo
