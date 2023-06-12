Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C4C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 20:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjFLUpi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFLUpa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 16:45:30 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC6170C
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 13:45:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b3b90de128so19141445ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686602702; x=1689194702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=drJuJWNwArkfxWzubYqBhjyWEE7jVbV5pqjBOdAZiV0=;
        b=CY4o4ik1gLa9xfMuvdv8OGscu/Dg++2BDkdIvAQtBymy4uSSRRKpuADMPmkLBlQVDi
         USw6XZs33kqAgsGRls0e+5GLpRkF2IopqZ7JiFgFSIh41ekKxI+pdWJ9Wu+TAlV0TfoU
         QXGkz4CmByld2iKwvpqHPBiz5/K+MHgFl2Gimk8PgyICYQIksEFxl0v1AN/TfE+x3pXZ
         3JNezCrbhCe/64vzUtJugwJ3jb4ri6s0BN8FtBIM7oXVLZgqPa5oJuFGwOuywFQ5rfDP
         scgqUd1yPv70JiQmWBFqTIAFR7YpVo37aNfpTdva7cKU5qoGEmQF4cuv5aDFVBpFM5nk
         iuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602702; x=1689194702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drJuJWNwArkfxWzubYqBhjyWEE7jVbV5pqjBOdAZiV0=;
        b=Bwq2dAQtFeE0mIqGe0r9gdxBNYK2GePeuxZGKEbKgiie1utI4iUDP5GGNInnpRyiX+
         6EOZLBP/RAnMf0mIPFpJzgoNgWvBWhRXI8wfdSROKpBfEuoyznofHHEFZcXXXNNfdxxw
         /MYtoVhsUP0ienHJ3vixUID+Wrr4N9fX6wUHum1QHH5UDgodukdHYvBPy/6vSCd59bTY
         xbc+DRsIBsuG7pt1+C8z9ZojWuMxULncWVnr8rph9grn0vZFCakyeaibGZxCtOtFPNFC
         Z4/VU54pnJ/mb3zeFzrFFvvQQSyMlAPqEZvWKm6hyfTGO2y+MwyyYUSilLyzxJovc8do
         o4Og==
X-Gm-Message-State: AC+VfDzCAQiRqp/XCt2mnWFbQuK/fs+MTPfsX6s5X23ugid9/7q5/KZq
        o1himjlpGtGcKAzSrqolaWaBfw4dVEA=
X-Google-Smtp-Source: ACHHUZ6aA45QNqG52i/zj6ZF+FT+IO5VzanCkfruCnG83lWaYwSFdIBJr+/QlI2HiKrOO2/jpzeCT3zH4+8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1cd:b0:1a9:8e56:9e14 with SMTP id
 e13-20020a17090301cd00b001a98e569e14mr1512425plh.3.1686602701672; Mon, 12 Jun
 2023 13:45:01 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:45:00 -0700
In-Reply-To: <20230517133808.67885-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230517133808.67885-1-likexu@tencent.com>
Message-ID: <ZIeDzPA143dQGpux@google.com>
Subject: Re: [PATCH] perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg
 when using guest PEBS
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

+KVM

On Wed, May 17, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> After commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
> PEBS_DATA_CFG"), the cpuc->pebs_data_cfg may save some bits that are not
> supported by real hardware, such as PEBS_UPDATE_DS_SW. This would cause
> the VMX hardware MSR switching mechanism to save/restore invalid values
> for PEBS_DATA_CFG MSR, thus crashing the host when PEBS is used for guest.
> Fix it by using the active host value from cpuc->active_pebs_data_cfg.

In the future, please Cc: kvm@vger.kernel.org when posting fixes that obviously
affect KVM.  I wasted several hours bisecting these crashes.  In hindsight, I
should have searched all of lore sooner, but it really shouldn't have been that
hard for me to find this fix.

> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 070cc4ef2672..89b9c1cebb61 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	if (x86_pmu.intel_cap.pebs_baseline) {
>  		arr[(*nr)++] = (struct perf_guest_switch_msr){
>  			.msr = MSR_PEBS_DATA_CFG,
> -			.host = cpuc->pebs_data_cfg,
> +			.host = cpuc->active_pebs_data_cfg,
>  			.guest = kvm_pmu->pebs_data_cfg,
>  		};
>  	}
> -- 
> 2.40.1
> 
