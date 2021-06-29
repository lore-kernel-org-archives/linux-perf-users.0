Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC9C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 06:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549AD61D91
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 06:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF2GL7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhF2GL6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Jun 2021 02:11:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C3C061760
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jun 2021 23:09:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 80so1790786pgg.10
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jun 2021 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yv7EEUQoiKqhop6AB04pLVKMYLWu1sR4zDrGtQgBw+g=;
        b=aoLs43qrv+77ukkA/Df5zJJwPwO210bGQSahFnhXMqpDL05rKg9TB8NzI1q81snkYP
         HUsP/n3DeX/hoNBS4hY4b3Ce6gUpSfPbCdjg2+pldPGtVGazXWzY6wN4H0ZFMisLB2/e
         p4J+LHIJG2MjJZJCFRKSRwFyKHG3qk0Q0U/fXcO8KhZWbt44D1Q/IieeqnTL+ohkTkyi
         VvCUdWqFDPYAQvRCCYjSWQZ30twGT6lxaSg+yzdxZRRs8pZFM0lNnBJg+m7S4UdxxL8F
         NqCoAKnIBNFvNME/lnHXvj/TpM3JPoyULNJ8aRora0S9VQPCggXKwUXE4ZyXfThBohzp
         AUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yv7EEUQoiKqhop6AB04pLVKMYLWu1sR4zDrGtQgBw+g=;
        b=eygbDlFjsa12gIb3CYzZU48W3NBQPSXWZc/Em0V9gyB53FwItfGuSrBc7SQpkaUBAW
         lMbuzWWJVDCvEAaU2ZwMC4z6WYFRZcKpPEVqvYj8OOtkvEupsmhlS7nFcTs7zEhySl2y
         4hGBPgisTvJ0EfaUAKIfFQa2cR0h19yX9+sRFZTgSXxvIfU5U8oJryGjpaUuRkgjolTG
         87Jr9wUwdZ42rhwAN4YJRC048u2tbmsw1RAb/XZyIMUTqRejN0m7kTUd4txqtuBcWH+y
         NTZWw56orqNEktMze6OelKb8ahwtTtzpALX/urfzMJ1P1vdL1SmEukDjCxZqULOHVIkM
         1Dow==
X-Gm-Message-State: AOAM531SMem35nV/DjaqrAuWwXh4cmfJS923o+RnmyrOd0ltC6ThrD/E
        yOvf9M91Luf+2sOah6FRoJqTtw==
X-Google-Smtp-Source: ABdhPJzsx5q2/A7x8D0k31KuFdMYdLJxqIBjhNKJPqPdRLhItpNrKvUm4MwgWGiy8caPvSMtXQ5Olg==
X-Received: by 2002:aa7:9252:0:b029:2ae:bde3:621f with SMTP id 18-20020aa792520000b02902aebde3621fmr28464344pfp.18.1624946971463;
        Mon, 28 Jun 2021 23:09:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id 69sm16753945pfz.110.2021.06.28.23.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:09:30 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:09:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <james.clark@arm.com>, acme@kernel.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <20210629060924.GD163942@leoy-ThinkPad-X240s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210628012744.GA158794@leoy-ThinkPad-X240s>
 <c7906b72-e547-da37-c387-23de65831ac4@arm.com>
 <20210628120802.GC200044@leoy-ThinkPad-X240s>
 <20210628200132.GB1200359@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628200132.GB1200359@p14s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mathieu,

On Mon, Jun 28, 2021 at 02:01:32PM -0600, Mathieu Poirier wrote:

[...]

> > > Hi Leo,
> > > 
> > > I think this is not true in piped mode because there is no auxtrace index.
> > > In that mode, events are processed only in file order and cs_etm__process_auxtrace_event()
> > > is called for each buffer.
> > > 
> > > You can reproduce this with something like this:
> > > 
> > >      ./perf record -o - ls > stdio.data
> > >      cat stdio.data | ./perf report -i -
> > 
> > You are right!  I tried these two commands with cs_etm event, just as
> > you said, in this case, the AUX trace data is not queued; so the flow
> > for "if (!etm->data_queued)" should be kept.  If so, I am very fine
> > for current change.  Thanks for sharing the knowledge.
> > 
> > > There are some other Coresight features that don't work as expected in this mode, like
> > > sorting timestamps between CPUs. The aux split patchset won't work either because random
> > > access isn't possible. And the TRBE patch that I'm working on now won't work, because it
> > > also requires the random access to lookup the flags on the AUX record to configure the 
> > > decoder for unformatted trace.
> >
> 
> There is a lot of things happening in this area.  Based on the above should I
> still plan to review this set or should I wait for another revision?

I think you could continue to review this patch set for AUX data splitting.

Since we have concern for the AUX data splitting with snapshot mode,
James and me both have verified the AUX data splitting (this patch
set) with snapshot mode, and the testing result shows this patch set
is reliable.

Regard another patch set for fixing snapshot mode [1], I will send a new
version (drop patch 1/3 and refine for patch 3/3), so you could hold
on for that patch set.

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/cover/1437696/
