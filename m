Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F40C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Feb 2022 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356797AbiBNQzK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:55:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356760AbiBNQzD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Feb 2022 11:55:03 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C665164
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 08:54:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id e17so10721175pfv.5
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 08:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xep8r8FwQNGDUtT6MCNkLvujmr+CgnGH/3gJNw8UNm4=;
        b=W+rtIp0yg6rctoHuUv1y959WovbZOxLomGIDFiThDZZvBevWps1zd4NNGj85uzpUN/
         9Xu7zbdJPtJ+YCPCRbYyxBh/bcv/Is/Mm751xSV4LAWpzAgnMqvi2d0cxulcUb/yJDku
         VHtBf6lfAIgNAUCkZs0OWeok9PjX2ButslQENiuKHYZ1kwQt1dbqejcOWnag8O/+PEyN
         pubhz4u+KYN2EUQIHCKMiBfKjvOTZacxiD3UTVZSra+59MAC+T1wm6Lt4kbZSsA5XU6l
         sC23soKp2mczWZtmPDelCmlrfuFmjREfNCwcgUKOvrG8Smw5oWRrTef+XEq1lYmNHySQ
         YQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xep8r8FwQNGDUtT6MCNkLvujmr+CgnGH/3gJNw8UNm4=;
        b=G17MDPIGH0GL5lWoLGpwwFG9ayMfnnh3GbmhDd7rV+rGjB2e/5pU9m+nC9Oo72aXJ5
         r0u04/+f817rFQ7/sUfLzi+dDPaZwkkWhFozk/7w6WgmTNOESF/mz48p1OPhqkZ95ckI
         9E+elkA3zyMphAQS3ygPJo4Wn+keZ26nAiGnrBpH8vcDlumHXYHK/rq68EhCEWlHccRk
         62UPEG9VvhYRqsmbiOiBjJtTPkE5/qz7s9DSSWoEIPdR93TmJOdRAlXGdeNH0N5aGYj3
         mwNQfH++0eglM4x6lGjwLyQMhR8CaBnUZecAlh00PRAK7+WoppT6UVYfvic1X9OAwy/R
         ZbxQ==
X-Gm-Message-State: AOAM530Qlgkn21eozzmW+iBsh4XXTgSu9kdvL11ayPIIVkpZt1q+Wqll
        8Xym0qjWiD8KklKf8sWoi/FmmJDJQnIgR9EtkqZ0BNI9GnE=
X-Google-Smtp-Source: ABdhPJx+dCUlStqQhuQFDVYboOsIXFEFVTTzGJM4DSj5GZ15wmYM+yKgh1C/mDpxi8N5PQFN47vVgYYlNO33slpU1OU=
X-Received: by 2002:a62:1c8c:: with SMTP id c134mr445143pfc.62.1644857694913;
 Mon, 14 Feb 2022 08:54:54 -0800 (PST)
MIME-Version: 1.0
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Mon, 14 Feb 2022 18:54:38 +0200
Message-ID: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
Subject: libperf: CPU map question
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,
I'm trying to use libperf as an interface to perf from an application,
but I face some difficulties.  I cannot understand how perf_cpu_map_
APIs should be used. My use case is:
 I want to iterate over the CPUs from the map. I'm using
perf_evsel__cpus() API to get the map and perf_cpu_map__for_each_cpu()
macros to iterate over the map. However, using that logic I get a
struct perf_cpu for each CPU from the map. That structure seems to be
private and I cannot access the actual .cpu id. Am I missing something
?
Will be glad for any help and clarification.

Thanks!
-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
