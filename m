Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2433C11F68
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5306141D
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhGBQYs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 12:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGBQYs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 12:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625242935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+F56iX2HeLnYU5qEBzI7G3YURXhUl6KbnmwROL9d3E=;
        b=LpyYKja6fWiygORuP6M/0xggOE8ddPdcoJdy4quxUQ1bmNCOFLhYE4di/K73ZN+om5JRaS
        EHHT8BE78dw5oUU65SAkOUNp1zq9dypnl0oHE3tTz6YBeObfQRPgHO+pnxboZPa+btAxWT
        Zo+e3rkhz4i1Xge6tt9N9e5GoiHTdEE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-4YE2VCz4N6en_MKdNMfF4g-1; Fri, 02 Jul 2021 12:22:11 -0400
X-MC-Unique: 4YE2VCz4N6en_MKdNMfF4g-1
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso5310822edu.4
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jul 2021 09:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+F56iX2HeLnYU5qEBzI7G3YURXhUl6KbnmwROL9d3E=;
        b=ozVXje84pgAU/rwxRo7MpiewzXP6OKZLDjvkDGuV/qxbU21kOSdFdzAFmTnocRORda
         fmZMT09KDc/QsnJf0tPjUm4InO/IVfPNRRkepvDhGpYlp1BBPc1J/zbDkj+5ykTebgt6
         LW3OZj972fs0SL/J/lC81GfzbXGGR33pkmKAdT/C7AM+aevXgdOR0OO5RtqO5PahKboW
         sCIIPbQ7WicA4v3ng/ssDADCXv0Bqqu78q+ZCNvRhL2OT9rvV2+oalePlLSm/01EtWhK
         iwdbxfim+jA+3zWksbkv4EKPNc0kz1tCPlGPmrxOkPxLw1q9Ekx88NfvNJa2DnPG9gZt
         Aq9Q==
X-Gm-Message-State: AOAM5314cBb1T0UFSyUN4OJsxCPEdmcdeIi9b9ipqBKqs+bwMJV7WkUr
        elaXToQPvQdVeexYkO6Wl6JlzHW+es6H+XA5t/6gzpF2kvEFbrutF4g18PvJliDka6MCh+4ePfr
        CgOKCm3eh4+s60WFNPU8inZ4ipIhoKA==
X-Received: by 2002:a17:907:7ba3:: with SMTP id ne35mr536705ejc.12.1625242930750;
        Fri, 02 Jul 2021 09:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLemUURdGV01cjMVEh7l/pvg+dgjnh+AaM1PMZXwIowFbPz0iFXQPAUYs9mWUf8RGsJ6lCjg==
X-Received: by 2002:a17:907:7ba3:: with SMTP id ne35mr536686ejc.12.1625242930578;
        Fri, 02 Jul 2021 09:22:10 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id bz27sm1216686ejc.15.2021.07.02.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 09:22:10 -0700 (PDT)
Date:   Fri, 2 Jul 2021 18:22:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: Perf loses events without reporting
Message-ID: <YN89LwSzTKc8wBar@krava>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
 <YN2a3pSvealjK6uR@krava>
 <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
 <87fswyc6cb.fsf@stepbren-lnx.us.oracle.com>
 <87czs1didj.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czs1didj.fsf@stepbren-lnx.us.oracle.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 01, 2021 at 11:00:24AM -0700, Stephen Brennan wrote:

SNIP

> 
> static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
> {
> 	char buf[32];
> 	int rv;
> 	unsigned long millis = 0;
> 
> 	if (amt > sizeof(buf) - 1)
> 		return -EFBIG;
> 
> 	if ((rv = copy_from_user(buf, data, amt)) != 0)
> 		return -EFAULT;
> 
> 	buf[amt] = '\0';
> 
> 	if (sscanf(buf, "%lu", &millis) != 1)
> 		return -EINVAL;
> 
> 	/* Threshold it at 5 minutes for safety. */
> 	if (millis > 5 * 60 * 1000)
> 		return -EINVAL;
> 
> 	pr_info("[irqoff] lock for %lu millis\n", millis);
> 	spin_lock_irq(&irqoff_lock);
> 	irqsoff_inirq_delay(millis);
> 	spin_unlock_irq(&irqoff_lock);

yea, I can see that as well.. if I took the spin_lock_irq it works as
expected.. will check

thanks,
jirka

