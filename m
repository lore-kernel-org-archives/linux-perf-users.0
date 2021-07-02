Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F2C07E95
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 20:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5646140E
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 20:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGBUP1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 16:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbhGBUP1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 16:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625256774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MUH9rGxd7rWFQe3J2f8cM/Bj+wnAFooKCD/isRc7TRs=;
        b=Eix3OwEABSRvZOzHMl20/ELJMxCQAQMslBoTfP2PdFggIVujxu+MF7hz/JiRAqYT6y3tmx
        2uo3BD+cJxnEGMxTiOIRVbFcmGZRlpDJQKX2BmD6tbwlTsUPcHVBPnOCqIcL/EZ5niKM6r
        ipnZ7M+tyXpR/fpWAvHWWc81TETnLfQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-nqYAYBF2NVKpTsBbxez1Fw-1; Fri, 02 Jul 2021 16:12:52 -0400
X-MC-Unique: nqYAYBF2NVKpTsBbxez1Fw-1
Received: by mail-ej1-f71.google.com with SMTP id de48-20020a1709069bf0b029048ae3ebecabso3911170ejc.16
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jul 2021 13:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MUH9rGxd7rWFQe3J2f8cM/Bj+wnAFooKCD/isRc7TRs=;
        b=SKXEswCx7FWLXi4J1c5dlxXRsjwQR+9/evhZAu2ZFqvThE8vlaASEYoY6nMGMyNz4/
         5O9CdKQaeRiYfrxWfxw2Bno/+oXHRiSKOs5luVJ4Q2FpToKzgoxfFgwN6WI8vaH65hql
         vg5BbdUSPYcyIxsHOmGFGDd+rovBXpVgzfDQdXbWhjX5ka1pxzSLJs57D+8N7pxBu3Vp
         ylKazXvpztAyijksuf2dx6/rrgovj8n5jjIl2xrKWAFKll3fyk60eHRvkZHp9EDICNM/
         7pXtQmF9uO7gEm1YeWGMXFtb3sbyBebRTmqvE2UM/37k78adYpOcQgB/f0PSJW4js4gI
         a2zw==
X-Gm-Message-State: AOAM531fhTXTuXZj1mKB1NaqkFai/lBneTB8dJ6DpxRd417qmh44Y/3C
        b0miZQdy9coNsp18WluJmjH+G034D0/QH9pAI8z3miMuWKkcl+imtO81dt+M1Bs2Li+sZNS5L8y
        LpbPeZy4+PmWyxNIGkQa7x9lYHaZcYw==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr1546919edu.380.1625256771684;
        Fri, 02 Jul 2021 13:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlY5iZAyPCoGtFpUZ+dheMJoz1u8zxdv6p5hLL5YYq4rLcmf5eRgcqSrdcjuxSfnKxdwSmyw==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr1546904edu.380.1625256771490;
        Fri, 02 Jul 2021 13:12:51 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id u17sm1700243edt.67.2021.07.02.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 13:12:51 -0700 (PDT)
Date:   Fri, 2 Jul 2021 22:12:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Perf loses events without reporting
Message-ID: <YN9zQDghzBj8b4Ki@krava>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
 <YN2a3pSvealjK6uR@krava>
 <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
 <87fswyc6cb.fsf@stepbren-lnx.us.oracle.com>
 <87czs1didj.fsf@stepbren-lnx.us.oracle.com>
 <YN89LwSzTKc8wBar@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN89LwSzTKc8wBar@krava>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 02, 2021 at 06:22:10PM +0200, Jiri Olsa wrote:
> On Thu, Jul 01, 2021 at 11:00:24AM -0700, Stephen Brennan wrote:
> 
> SNIP
> 
> > 
> > static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
> > {
> > 	char buf[32];
> > 	int rv;
> > 	unsigned long millis = 0;
> > 
> > 	if (amt > sizeof(buf) - 1)
> > 		return -EFBIG;
> > 
> > 	if ((rv = copy_from_user(buf, data, amt)) != 0)
> > 		return -EFAULT;
> > 
> > 	buf[amt] = '\0';
> > 
> > 	if (sscanf(buf, "%lu", &millis) != 1)
> > 		return -EINVAL;
> > 
> > 	/* Threshold it at 5 minutes for safety. */
> > 	if (millis > 5 * 60 * 1000)
> > 		return -EINVAL;
> > 
> > 	pr_info("[irqoff] lock for %lu millis\n", millis);
> > 	spin_lock_irq(&irqoff_lock);
> > 	irqsoff_inirq_delay(millis);
> > 	spin_unlock_irq(&irqoff_lock);
> 
> yea, I can see that as well.. if I took the spin_lock_irq it works as
> expected.. will check

ok, so with disabling irqs you disable task tick which
kicks the unthrotling

throtling is started when you cross the limit of samples
per tick, which you do real fast with busy waiting

then when event is throttled (and no samples are generated),
the next task tick restores it.. but with disabled irqs,
there's no task tick, so the event is throttled all the
time when irqs are disabled

is there any use case you have to have irqs disabled for so long?

cc-ing peterz
initial email: https://lore.kernel.org/linux-perf-users/YN89LwSzTKc8wBar@krava/T/#m616481aa95da10e17d9b0769717f006b9ff38637

jirka

