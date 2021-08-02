Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8602C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CABE60F70
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 12:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhHBMGD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhHBMGC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 08:06:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97163C0613D5
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Aug 2021 05:05:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so13722858pjb.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Aug 2021 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0kDiBlJoK8SwQL0AO/6bSRAuB/n3Sin/aq5lPKY5VZA=;
        b=IvdBG/R3DD3elu/VswhN8sDqSFqK1j+y+p5AhZ6twjSA522qW10eg6DtBZJB2lhrTm
         k1UbVMglLA+d0Tfhas09Of44vOZ4wlvXOfC1jVXd4cEHUwD1MyXbLqLwX4GS1kseQXqw
         MwIRU0p69s0hu9BSoapajbHT3fxZ5JxH8JKgpXZGruUaesRJD0NzWdrB+BJjwwDwOEXP
         eyZmBsN2sEr468eevar1HCLy819e3SazmPdqNerEDat+sl0PIzS1FrbquRCxCxCoDHpK
         O3vtA8KeVwhjsgBd4Lpn6/ubBVEzr7uXcK+WsWLNd1I7eSGF+tZoPq4juIvBDPlAD1IZ
         Vf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kDiBlJoK8SwQL0AO/6bSRAuB/n3Sin/aq5lPKY5VZA=;
        b=uW4CsLvc6XgGWEth+ISzeC0z2gPgM2v0QcF7RJ9kroGUMrMOBOjkwGiXDVskztYr7A
         8AibNF/Aq0EB0uRvo2DqWh8Y/E/CNJR7tmVRH3e6cqMSaRI5nnXzUPK2rbo503qFcnnm
         URQo8lVMlDO9EhDNyLV6QCiBn1Q+OFql7WhRKFccSMEdFNWVy1++QECcxwLjsYVUvl4h
         NaRamsj2ycVlpT8+uSniLADJGUvfjCipbUI3Fe+Wo2hjUE5vj++JcZBz+LneE8uOiqdd
         lY3Hwjkp9TqTTf6FwlpE0EeSygC/ecMt9Pn14aEKSFcV4cjwmHpVoBnvyIXBtbHaEny7
         yJOw==
X-Gm-Message-State: AOAM531+N6GAN5+Z5tklPmEaLJ5fkLXy9B83f8ob9DOGTYM/XyPkR7OE
        lk2HcBp+KdgdOJ93A/6v1jI3qQ==
X-Google-Smtp-Source: ABdhPJzhfRR5zHRCHa7+fEUklyy2loDgcix5JVetpSORYNP3hvmnut/fV4+tmG88Ir+94hZX6Sb1eA==
X-Received: by 2002:a17:902:f542:b029:12c:6f4:ad92 with SMTP id h2-20020a170902f542b029012c06f4ad92mr13928495plf.5.1627905952956;
        Mon, 02 Aug 2021 05:05:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id mu9sm10791138pjb.26.2021.08.02.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:05:52 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:05:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
Message-ID: <20210802120545.GJ7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-4-james.clark@arm.com>
 <20210731074343.GG7437@leoy-ThinkPad-X240s>
 <CAJ9a7Vj_KhV+v6VU+EQN5t818VS9jvf3v3-2JbwVMOHZbi3gcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vj_KhV+v6VU+EQN5t818VS9jvf3v3-2JbwVMOHZbi3gcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mike,

On Mon, Aug 02, 2021 at 12:21:31PM +0100, Mike Leach wrote:

[...]

> > Here I think the right thing to do is to support newer revisions for
> > ETMv4, and then based on the revision it creates a decoder with
> > supporting ETE feature.  For a more neat solution, if the perf tool
> > passes the "correct" revision number to the OpenCSD decoder, it should
> > can decode trace data with ETE packets.  In this way, the ETE decoding
> > can be transparent for perf cs-etm code.
> >
> 
> The OpenCSD decoder separates the ETMv4 decoder from the ETE decoder -
> for the reasons given above.

Thanks for explanation.

> Additionally the ETE decoder and the ETMv4 decoder required different
> sets of ID registers to correctly set up the decoder.  For example,
> for ETMv4 the version is extracted form TRCIDR1, for ETE the version
> in TRCIDR1 is set 0xFF, and thus needs TRCDEVARCH to extract the
> revision. It is likely that later updates to ETE will require an
> additional TRCIDR register to be saved.

Okay, for ETMv4.x and ETE, finally I think we need to rely on TRCDEVARCH to
decide the tracer version based on the architecture number (arch 4 or 5)
and revision number.

> Choosing the base type of decoder in this way is how the library can
> support ETMv3, EMTv4, ETE, STM, PTM etc - and while some of those
> protocols use TRCIDR1 and TRCDEVARCH - not all do.
> 
> It would in theory be possible to have the OpenCSD library
> "autodetect" the type of decoder needed based purely on a set of ID
> registers. But this set of ID registers would be far larger than the
> ones currently used, and would require modifcation to a lot of the
> existing device drivers to ensure they were accessible via sysfs. This
> register set includes the ID registers that are currently used to
> identify the component on the AMBA bus and match to the correct
> driver, plus additional CoreSight management registers. This would
> also create a dependency between decoder creation and ID numbers - in
> the same way that each new ETM4.x part number has to be added to the
> ETM4.x device driver.
> 
> Such a system would require a significant update to the OpenCSD
> infrastructure, and is not planned at this time.

It's fine for me not introducing significant change in OpenCSD.

If so, I understand your suggestion in another email to add a new magic
number and a new protocol (this patch set has added the new protocol
CS_ETM_PROTO_ETE) for creating ETE decoder.

Just confirm one thing which is a bit confused me: for ETMv4.5 or any
newer ETM IPs, should the perf tool keep the existed way to create the
ETMv4 decoder?  Or there have updating is required for decoder to
support the extended packets?

Thanks,
Leo
