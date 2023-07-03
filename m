Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB4EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 09:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGCJj3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGCJj1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 05:39:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E291
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 02:39:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b7f223994fso33541245ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688377164; x=1690969164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CchEOar5AEK0MMMCN1XDgQMJaOTxORnn2i16L0C6EWU=;
        b=MLqleqo/c2+5ozEBHsyUCSGRKp+dd0lfa4ItH3KU58F1MdM8rfQBnUlc5B+0VVt+Gv
         JoYP+ATpb5KF7hr5JDJN+eJZ42i6+g2k6xjJhD/W0jnUXyOryyPW9XysyJOuGfakVRX4
         CqmCLju6jRPcBsFsouq+mzGtEJAz4K1pVre82QBvCe9NWOugA0PLJhiUerv1csEmLVNe
         fvSvolSncAPS0AG1wMm2JXi+IkIBSec/fm88R9KGd73RNcqn7PX22xpTHbHMUk/AdotH
         HFGQXh054Qx4OO4Mr3qwd1/qzOZe/7RE5hIziNnoTnvYyClxzxFEAzKPDjyL5gIjKZV1
         Q+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377164; x=1690969164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CchEOar5AEK0MMMCN1XDgQMJaOTxORnn2i16L0C6EWU=;
        b=kp4Z7XTUU5fOmY5bv69Rc5e4haK7OV10Y300E4WbVvHkP6VlVJOl/qYUxS58rwkQYj
         PtOEveod72nOWEiarUDRtyTQ/dKI0PfuYbLAg40L8MJCSO8HF1JaV4pBU0rv6QdDAyFP
         0vk0W8aLV0HHJYaWsPwcEA10TFb9+8sCkXNH8UefB74ESYk3YNuxtQZ0F+5HYjvHZRe6
         IHcH0dkmV6QlCUPs1HRd1kkWxv2WXjBEwYWr5D705CFvWiVptW9TKRUwPj4HgMoYOVQI
         gqFt3mVWwCJG+sM+eHzF/bp2fcppDcXVXACCMHInX/S2Int/TAj30VoB1gn0hwbVZXtv
         siYA==
X-Gm-Message-State: ABy/qLbn9Ai8UAQNQX1aBR7aih8joNEUQfVmm/ch/XsZjpV7wR3JhA77
        dZ0UN8+6ifDJH1nkNgr4yoxmbw==
X-Google-Smtp-Source: APBJJlGKvOKmQlDkcgJx4HJZTsBFNtbvvaRjUNSuA9rBHqHfdD72Z4IG5d2Gu/pHEOBDHraa3nxnWw==
X-Received: by 2002:a17:902:7684:b0:1b8:1776:d48a with SMTP id m4-20020a170902768400b001b81776d48amr9958375pll.61.1688377164295;
        Mon, 03 Jul 2023 02:39:24 -0700 (PDT)
Received: from leoy-huanghe ([64.227.105.120])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001b86f1b5797sm5342830plg.302.2023.07.03.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:39:23 -0700 (PDT)
Date:   Mon, 3 Jul 2023 17:39:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        =?utf-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: Some questions about using the perf tool in ARM-SPE
Message-ID: <20230703093913.GA904662@leoy-huanghe>
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
 <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Suzuki, James,

On Mon, Jul 03, 2023 at 09:24:27AM +0100, James Clark wrote:

[...]

> >>> I have a new discovery that c2c seems to support only certain Arm
> >>> Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?
> >>
> >> Based on Cortex-X4 TRM [1], we can see Cortex-X4 has the same SPE data
> >> source packet format with Neoverse CPUs.  In theory, we can add
> >> Cortex-X4's MIDR into the neoverse_spe[] array in
> >> tools/perf/util/arm-spe.c to support Cortex-X4.
> >>
> >> Linux master branch misses the definition for Cortex-X4's MIDR [2],
> >> Mark.R / Suzuki / James, could you confirm if Arm has plan or already
> >> has patches for enabling Cortex-X4's MIDR?
> > 
> > Is there a particular reason why need this in the kernel ? Usual
> > policy is, kernel needs to distinguish an MIDR, only if it ever
> > needs to. e.g, a CPU erratum specific to the MIDR.

Just clarify a bit.  Since Arm SPE data source packet is
implementation dependent, which means different CPU types can use
different data source formats, or some CPU variants don't support data
source packet at all; for this reason, perf tool checks CPU MIDR to
decide if data source format can be supported or not.

Now perf tool directly includes kernel header
arch/arm64/include/asm/cputype.h for CPU MIDR definitions, which is
why I am asking if any one is working on adding MIDR for Cortex-X4.

> This is on the tool side rather than in the kernel. But yes, if the data
> source encoding is the same as the existing ones please send a patch
> adding X4's MIDR to the list.

I can do this; as elaborated above, I think we need two patches, one is
a kernel patch for adding MIDR and another patch is for perf tool to
consume the MIDR of X4.  I would like to know if this is expected or
not from your side.

Thanks,
Leo
