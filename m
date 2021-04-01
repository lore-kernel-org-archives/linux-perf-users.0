Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A58C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Apr 2021 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF82561041
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Apr 2021 06:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDAGJQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAGI5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Apr 2021 02:08:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE4C0613E6
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Mar 2021 23:08:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y2so482816plg.5
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Mar 2021 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=o+wLD8Gf0pznEQKYD0GsyZQutIblJ3CXCcoyvN5q0HE=;
        b=uRPqe4RSWykuOXrEqdf05pPLq+9E7h5wj0O8+2Cy16bpHQwlvEhegRcAw2vjU4/3/9
         Q8u4Fzs0yxRH0oExWvGMBiO4MGNhdpdWj5qxRwHczJEV2eCc1W+LAleB8jEoyF40PbDq
         L8iNQQ/+XwDkxKwMkcYa2r1vMJ4qwP5lcZRHBkEMYZ3mzwkcBOxAaMHbLxJBaQ1c8/iV
         msnAFvk0AHxjxnK18jbkZ6V7BI51C+gf5LD/8LoHuMe6wLt0TWl3Rxqjz76wVt/2pgdp
         wpONNFNEHcgc0v90yfcOuw2hkyy7Ec/rOjY/qmrYvV0tDmqNlnP9tai9RrUFTXkmvEZk
         Odtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=o+wLD8Gf0pznEQKYD0GsyZQutIblJ3CXCcoyvN5q0HE=;
        b=tCCUJvVAT0JWCgkzaXzM7/3Kvqr9sf3x5mP6D0646MVN/chUmEN/p5vpd23SBu9htI
         vG8DTgE3UA1S9KMtxONS+8Mbr6HOqwRLc5skMTISr14Ja26AIiDo31jPBUcEFyDSyk7j
         Ks1Zh89iiNsr0E8YR+BsnugZ5aObKRSWCT55qWUHW3ci2EMweRZbcAaI80PHwz3hEokq
         AgFOxNIZjUJz18/LiHes5OCpgT3EFPQaAV5dRh78Ls50R4oy8NndE58jnmQKH1dyMFaJ
         FnNWsA37qBA90solwGIL+CQxBSdjXaS1C6yT6EbCkUEbyxRHE4+5ah9T3dVlnS2Vq2Be
         lNiQ==
X-Gm-Message-State: AOAM531K1EDv/Eu8+8oqt91btagcbM2sUIsyhqLo6JBjFnHdtXbEGZ6g
        LxNiqs99xTI0VHz/FtEEhfJStMyUrNkzKg==
X-Google-Smtp-Source: ABdhPJxB9i1VM9B3yHT/2YOgVVVEranpQbOwk/7bdSF1KivB/F7wnAFYIVMdLmbSJ7RWmtcIlkX19w==
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr7434984pjh.19.1617257336956;
        Wed, 31 Mar 2021 23:08:56 -0700 (PDT)
Received: from [30.138.96.109] ([205.204.117.117])
        by smtp.gmail.com with ESMTPSA id g18sm4035289pfb.178.2021.03.31.23.08.55
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 23:08:56 -0700 (PDT)
To:     linux-perf-users@vger.kernel.org
From:   anzhou94 <anzhou94@gmail.com>
Subject: Manually setting libbfd unavailable will cause perf building aborted
Message-ID: <5ec369cd-cd78-7dea-de75-6666711ccd19@gmail.com>
Date:   Thu, 1 Apr 2021 14:06:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, all


When buiiding perf, whether libbfd available and whether libbfd supports
buildid feature will be checked. The check results are stored in two
variables: feature-libbfd and feature-libbfd-buildid. Then the variables
will be used in tools/perf/Makefile.conf as follows:

ifeq ($(feature-libbfd), 1)
  EXTLIBS += -lbfd -lopcodes
else

  ...

endif

ifeq ($(feature-libbfd-buildid), 1)
  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
else
  msg := $(warning Old version of libbfd/binutils things ... will not be
available);
endif


When compiling and executing the corresponding test program to get the
check results, the above codes works well. While, when manually setting
libbfd unavariable, i.e. feature-libbfd=0, these codes will cause
building perf aborted.


Why? That's because whether libbfd is available and whether libbfd
supports buildid are individually checked and used. When we manually
setting feature-libbfd=0, value of feature-libbfd-buildid could be 1. I
encountered such thing when building debian linux-image from source.

If libbfd unavailable, to check whether libbfd supports build is
meaningless. Hence, unless libbfd available, we shouldn't check whether
libbfd supports buildid. So, the above codes should be fixed:


ifeq ($(feature-libbfd), 1)
  EXTLIBS += -lbfd -lopcodes
else

  ...

  ifeq ($(feature-libbfd-buildid), 1)
    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
  else
    msg := $(warning Old version of libbfd/binutils things ... will not
be available);
  endif

endif




