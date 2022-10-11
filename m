Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5AC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 11:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJKLLH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKLLG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 07:11:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4798C02E
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 04:11:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso7880400pja.5
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyNu7ihVwa1kCmrsin+0WcnVl1ur8OzhltqOfbUTT10=;
        b=UZwIeeRg3uQhc+cpCzs6z0nQw2QZwvYVcjh3Tev6Nh1AaxET6iyPGP8LvCk7pGfNNO
         CWqx4NbFYdHi9MUlsJRCQzG47fLY3YozQb9exZzE5yn8D1Wq2HZSCyRL7nHPBv1r52w1
         KkCuYotEuqz/mv/klQcC8SUuxpd51/SjhC6Fi8XwDfmemRt+sDiQ48X+nnDTHoXRQw6f
         P0rBoCWkOT9k5qjy6h8dKhHD7NI2milNdGmYpnTOSju/+qlLaE51yISSZJeZhs+xML1u
         rjZWufVDRRbWpwRM/RxUzMPhDOkwdlkApaMv2pcm6VhtVpoyNBwiKy++7bIrIyWOvc8c
         CLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyNu7ihVwa1kCmrsin+0WcnVl1ur8OzhltqOfbUTT10=;
        b=Nc1xhWzhoKGR/wHbSQNe1iqkr6bEaMSmqXB1//pE+9OMsXl101NqfKhaylUaEBoWJ3
         FU2gg6gGNgYQ5N4/AE5nnjHIq2s6lMXSdcyzbAGfYCaSxCqU2PTCKMX5vuZT+oUgdCba
         /55HNoipFOpsiyfw88L7WFNVThWh5sdoTPq5IDrzn35XONiSKSTvqdEi3kP8+epxm9NB
         gFwb/NZTaYE/uCg3BLB87jiKmL5HSh/fhzJjJJRNLIVj33QYtatk26PzswEJTGlaC3Ij
         +IAfdR6GQ7ut1hCn4jz7xzERbnxsaSaGUM7NlgeTxqebvH7j+DdDaC+UseqOwKlG7Wrp
         cagg==
X-Gm-Message-State: ACrzQf3SQA3SclvTYnAz+PdZFZ841IfyQvpb7nQAv+QFUOQcCFUk4YMb
        o6GVrd2GnIWLDFwc4us0PXploxIHgbbU2GN6e792vg==
X-Google-Smtp-Source: AMsMyM7X9jF5KQTbREd1W8ZkKnNsDJAq+kh9AegZu7oAqTnFNWKJTzxtA4V3YI69PYMg7pEsV3hi+SDJhsdAHk7UZyc=
X-Received: by 2002:a17:90b:4b4b:b0:20a:926f:3c2e with SMTP id
 mi11-20020a17090b4b4b00b0020a926f3c2emr25763482pjb.87.1665486664825; Tue, 11
 Oct 2022 04:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <20220809223401.24599-4-mike.leach@linaro.org>
 <65e70db9-9f85-7285-0602-f2d29887550a@arm.com> <CAJ9a7Vgz+0xEQO-MvGUzbsr_LBh4pDep7JJtFoA+cAeiAERJFw@mail.gmail.com>
 <55170f1f-99f7-6e25-55d3-5d7247737afc@arm.com>
In-Reply-To: <55170f1f-99f7-6e25-55d3-5d7247737afc@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 11 Oct 2022 12:10:53 +0100
Message-ID: <CAJ9a7VgrJ3L6o9e0600G_JL6S_PXLsZcQDLPR_YGpSu4L=pOMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] coresight: stm: Update STM driver to use Trace
 ID API
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi suzuki,

On Fri, 7 Oct 2022 at 18:53, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 06/10/2022 14:54, Mike Leach wrote:
> > Hi Suzuki,
> >
> > On Mon, 3 Oct 2022 at 10:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> On 09/08/2022 23:33, Mike Leach wrote:
> >>> Updates the STM driver to use the trace ID allocation API.
> >>> This uses the _system_id calls to allocate an ID on device poll,
> >>> and release on device remove.
> >>>
> >>> The sysfs access to the STMTRACEIDR register has been changed from RW
> >>> to RO. Having this value as writable is not appropriate for the new
> >>> Trace ID scheme - and had potential to cause errors in the previous
> >>> scheme if values clashed with other sources.
> >>>
> >>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> >>> @@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
> >>>
> >>>    static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >>>    {
> >>> -     int ret;
> >>> +     int ret, trace_id;
> >>>        void __iomem *base;
> >>>        struct device *dev = &adev->dev;
> >>>        struct coresight_platform_data *pdata = NULL;
> >>> @@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >>>                goto stm_unregister;
> >>>        }
> >>>
> >>> +     trace_id = coresight_trace_id_get_system_id();
> >>> +     if (trace_id < 0) {
> >>
> >> The above API returns "INVALID_ID" and not a negative error status.
> >> I think it is better to fix the API to return:
> >>
> >>     ret < 0  - If there is any error
> >>              - Otherwise a positive integer
> >> And the users should be kept unaware of which ID is valid or invalid.
> >>
> >
> > coresight_trace_id_get_system_id() returns the ID if one can be
> > allocated or -EINVAL if not.
> >
> > Not sure what you are looking at here.
>
> Sorry, indeed I was mistaken there. It is the get_cpu_id() which
> returns the INVALID_ID on failure. Please could we make that
> consistent with this scheme ? i.e, < 0 on error.
>

That also returns -EINVAL, as both call the same underlying allocator.

However happy to add on the comments for the exported functions

Regards

Mike
> Also, please could we add a comment above the exported functions
> on their entry/exit criteria ? It is not clearly evident, unless
> we follow the code and figure out.
>
> Cheers
> Suzuki
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
