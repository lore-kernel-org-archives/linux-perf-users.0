Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DF4C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Dec 2021 06:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhLQGeV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Dec 2021 01:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhLQGeV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Dec 2021 01:34:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30FC061574
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Dec 2021 22:34:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so1344430pjb.4
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Dec 2021 22:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=71XwCR8s+PcTQ7IcHTjDcZgm3Mbb8+hGKibg2AgnwRs=;
        b=MPBMpKU62+1pwxQQbRe8qtBn8K8XQuN5TNQx3O1ZRpLl/JNznuPXveuRoFLYktSKs+
         V5oBgDuU0QXqLw5O7iwXZzbsYARlT7hHQY6TbcfJ6QAxnVCM6JY2EC53jheaY/NbKwIP
         AdMYyztvNVzhzKKH1kskuJvfQFKdSYquOd5DAFkwhNxZcvnIV5y6w0XaDXKpIFttcssi
         edN6sfvoJZNQWFPhOZQK+qV6To0P9bfMQRU57y3jS5LVMPyPgC4MMOEu4ILLxNE0fxN2
         spSRyOJEmdjGUQeFgNIScaNEbTUk/m6uBJew5g84cQ727VPoeMXeBy4VMyv5A4CVYC93
         Td2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=71XwCR8s+PcTQ7IcHTjDcZgm3Mbb8+hGKibg2AgnwRs=;
        b=tIhcw3hDKFvX+wSwBnKoglNDLQ/w+F2sB327+pjzkAABQOzo1b5sRxFLbg+Bgi8BUQ
         cQ3jTx8WMRke7cXnU1tsVcLWFUrXG8XYjehnbk9l9mxHlybvUDabtYttMeu7K530P+n4
         3HyKxXoNPIZ5TJEJmE9MH0mhhlclvQFXQp1FU0hwGzhj8p63CXZpfZMeRTy06kbpLMww
         BjUbD6jGX2StEhF88w7zD/Wq39iAiAx3+QsvRrqaWXydJEx+Oma8YRG+FPFyXKW2sHEW
         R5zo4LGCBfXeiuOHhStNkGvDxyjoE/lx1/8n7LbkaPYdm+l7sOMfgRrEHnfmdzg6q3JM
         GVZw==
X-Gm-Message-State: AOAM532kDyQOJbDFCjZrX8P4qlduS/uClRa+mjUMCPSNIu8WELY2xzbq
        fxl0Z/nBNuC2Epoay84y71JpSA==
X-Google-Smtp-Source: ABdhPJzEx1NJDIquSU6sB47jjGhOaVsK+GWBpJ4Q3/10TyklCJORqvt3n5vCPvEC15HCD1wc8un15w==
X-Received: by 2002:a17:90b:4c4c:: with SMTP id np12mr10389732pjb.68.1639722860304;
        Thu, 16 Dec 2021 22:34:20 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.181.134])
        by smtp.gmail.com with ESMTPSA id l26sm7013533pgm.67.2021.12.16.22.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 22:34:19 -0800 (PST)
Date:   Fri, 17 Dec 2021 14:34:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf arm-spe: Synthesize SPE instruction events
Message-ID: <20211217063413.GA371207@leoy-ThinkPad-X240s>
References: <20211216152404.52474-1-german.gomez@arm.com>
 <CAM9d7cjyuJnFmz5vAuZtzGWD6ttG94owfJW4i53x50n8+a=kJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjyuJnFmz5vAuZtzGWD6ttG94owfJW4i53x50n8+a=kJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 16, 2021 at 04:53:45PM -0800, Namhyung Kim wrote:
> On Thu, Dec 16, 2021 at 7:24 AM German Gomez <german.gomez@arm.com> wrote:
> >
> > Synthesize instruction events for every ARM SPE record.
> >
> > Arm SPE implements a hardware-based sample period, and perf implements a
> > software-based one. Add a warning message to inform the user of this.
> >
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Tested this patch with perf commands (record/report/mem) and looks good
to me:

Tested-by: Leo Yan <leo.yan@linaro.org>
