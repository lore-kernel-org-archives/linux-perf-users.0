Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_20,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCD7C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Mar 2021 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CCD64FCA
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Mar 2021 16:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCJQcu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhCJQci (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Mar 2021 11:32:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80119C061760
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Mar 2021 08:32:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w11so24036051wrr.10
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Mar 2021 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M/ohaZ6/LI5P7bkTP7IyY+5vj/YcmWluV9S3+P2LKjQ=;
        b=hQAN1G64SG8D9rP0SK2fZZTNyfqzk95SxEYPJL3NZPF6C04K03v/Q0SwXUdYjgKbi4
         1htrY6zl7uPDFFwCAWRuS0CLZiCs7IpkstH5oBufB8RgVjnsLeRuSb5RR7VC+AqrwZ7P
         KRp3L864Xwxrulqc8Md09/gsjgl5M9S9pWjs7BcLvRUT5pZSpHaN7ShZ5haJxZQII7Hu
         RK1M6X7+Sa/K5ooJvNws9lzixyz80nOJdjnZrnPVrBKPfxpDEvgRh2MsGPYd5u010KUs
         BfJB+k7rgqllgzI3MQdvSL/uGGdIaMfHGpzV8i1tbUkB/vsUVsw1hA5hc+3f25FWW2Ia
         Ptyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M/ohaZ6/LI5P7bkTP7IyY+5vj/YcmWluV9S3+P2LKjQ=;
        b=pP/myu7m+iyRjlOtRf18GDQSydOczkR/04TmXeaMrvc6u+6PNH+rwKQbRoZuOslTeL
         /1clG1+ZxqJqRUyJkkAKH4JUmJyFJBlwdsm4Q69DLDsuUjuWovjkdzBlJ7gdXRfBO9hq
         tOAVFzUVmo+tPpqeqYgKIKKdHTjaKvI2G9gD1vm+OmMFSJizRvqJFVk4J/pwAcntDtuA
         Ig0gw7B2V7teJ8sbfQMtyCntwbVkqOE8My0MNu9ikHoAs9f2WUrp12+3cmTYa9skBjNj
         J7dfkrGTrVI+9s4Nu5qFaZmCzZvL1yfkYJ4MXGRQXfsoqwfgH/OfmZ+voeuUxeUh3H3U
         3W6Q==
X-Gm-Message-State: AOAM533CVtinfHzUvyHxw46no+oG199NYm4c1s/zmw3BtSpVXvBupM3h
        GJYZQYSDoYksFPMeEW29Z+O3LkXBd/VM4ER0uS64qel3IpIB8A==
X-Google-Smtp-Source: ABdhPJwrEg9bYN1YWjdoDyNXnwFqSh3a23BSWRDB9cabMsDxxnCEkdjOx7Wmiql8HIJk7xZ99oUwG6IeHXBOJrDV/q8=
X-Received: by 2002:adf:a59a:: with SMTP id g26mr4372252wrc.271.1615393956698;
 Wed, 10 Mar 2021 08:32:36 -0800 (PST)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Mar 2021 08:32:25 -0800
Message-ID: <CAP-5=fXevQSmPPu2d3QixSJH=8Y5cb379angt36mATj96E7ZPw@mail.gmail.com>
Subject: Linux Foundation accepted for Google Summer-of-Code 2021
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Aveek Basu <basu.aveek@gmail.com>, Till Kamppeter <till@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I'm happy to share that the Linux Foundation has been accepted into
the Google Summer-of-Code 2021 and we are looking for students
interested in profiling, perf, etc. to apply to do projects.

The main details on the Linux foundation application are here:
https://wiki.linuxfoundation.org/gsoc/google-summer-code-2021

Details on potential projects with perf here:
https://wiki.linuxfoundation.org/gsoc/2021-gsoc-perf

Please help to share, especially to students.

Additional project ideas, mentors and help is also appreciated.

Thanks,
Ian
