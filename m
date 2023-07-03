Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C387AC001B3
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGCKVA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGCKUx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 06:20:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A919BE
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 03:20:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b882228638so7145645ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688379652; x=1690971652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6v08z17Vb6wfDocwp2lvaEISP+4aWL/qNSHEkH7ld0=;
        b=Tjb3NoX8BKkjZ7C/5x9A/ke8HOqWCxMdCzsutVclhlix00YkUFfsKFxe1/qYUB+MZ5
         nvBY9Gh81T437f3KdqGXHlbiWrGD89qKcFF9HVuSxKkKHOx0P3bg5S/vtlOVDQNzviLL
         iGwe/2FIhUQ2+DhW0B8DJyucO6/IL+MZucrhZ6VaG8WMwdp0Uak3y3Yvv11VCJlt4WL8
         1KvmImjaNvYwYY+COUFtZUPv5j/1HPIaKi4E0XYi4+phGDterwAgGHMzQcuHcmG4eKaA
         9I1pr+AtVsIJDOmP20V5+wTIYBh0ut8cFKXr9HVnIkKIDYzpxQb/H4Nptks18+j8VUx9
         Q2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379652; x=1690971652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6v08z17Vb6wfDocwp2lvaEISP+4aWL/qNSHEkH7ld0=;
        b=F/Td2BhGgLqTpaBqwhoaXiUlK0P+4PO388uqaKWnB8P+AeZHHGdMoCAQcCJDd2LAs8
         ufnUkfVSxbHdwiPY8L3bquBH0PFh2mS55l0ehAippdjjy2MKo659AAR6D22E3bbPsDN7
         XSou/Bqaz/6sHHz+FEUF6lvDUhhVKV672v9/UxAaFocsKdt8EeEL4QhPOfGCiRIWMQCb
         GXZWbXXRDyqSt6o14TqBRoI/WBCdbQGRBrgFCJYbhU7n6TVsDdtI++KVDrNYxKoVxDnc
         n4apRrkBP0WUpWnTSdzqUIMSVERx7WVcLFl/9Rr823gnHVynvA0ZDY8j9he7GXUzLfv8
         n8hw==
X-Gm-Message-State: ABy/qLYaKrrh5CuEVtpl/DkAPgokVoHzLopxTuNzO6SxuigfosmLN/Bt
        9/fQQw2OSef5jXY74LOqcHfE5Q==
X-Google-Smtp-Source: APBJJlFoyEBoEGqdL2BC4vF8T6iIOUOlz1YSHuIwTtHopuGl2o+BaORdDWcFObVWsS+zkdhfWAPXow==
X-Received: by 2002:a17:902:da92:b0:1b1:e002:703a with SMTP id j18-20020a170902da9200b001b1e002703amr8988232plx.12.1688379651802;
        Mon, 03 Jul 2023 03:20:51 -0700 (PDT)
Received: from leoy-huanghe ([192.169.115.125])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902a41800b001b39ffff838sm6824374plq.25.2023.07.03.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 03:20:51 -0700 (PDT)
Date:   Mon, 3 Jul 2023 18:20:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        =?utf-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: Some questions about using the perf tool in ARM-SPE
Message-ID: <20230703102032.GB904662@leoy-huanghe>
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
 <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
 <20230703093913.GA904662@leoy-huanghe>
 <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 03, 2023 at 10:42:21AM +0100, James Clark wrote:

[...]

> >> This is on the tool side rather than in the kernel. But yes, if the data
> >> source encoding is the same as the existing ones please send a patch
> >> adding X4's MIDR to the list.
> > 
> > I can do this; as elaborated above, I think we need two patches, one is
> > a kernel patch for adding MIDR and another patch is for perf tool to
> > consume the MIDR of X4.  I would like to know if this is expected or
> > not from your side.
> > 
> 
> Personally I would just add it on the tool side only. If it's not really
> needed in the kernel then it doesn't make sense to add it.

Makes sense to me.  I will try to work out a patch, and it's good to not
break building when kernel adds the same MIDR x4 definition.

Thanks,
Leo

> But I suppose from a consistency point of view we could add it in both
> places. I'm not too fussed either way.
> 
> > Thanks,
> > Leo
