Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8239DC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 07:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbjFIHPs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbjFIHPe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 03:15:34 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A73AA0
        for <linux-perf-users@vger.kernel.org>; Fri,  9 Jun 2023 00:15:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33be5dbb90cso6372335ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jun 2023 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686294910; x=1688886910;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UXcHU2bOUKkWG5SrVEt81jnMq95uggPNWPX7wKWbtNg=;
        b=DDVTwl6UbenNG8sm1EXOMA1noQRXglL2vDdGiiu6eNyACe3PExAuCeakQWsOf1pzsN
         V8+A0eXD9RbAz+VaKZmnw1+klObBGb3weU/pl+k9wGhj/MiBErsN7GNsGZTgXx2j7EDe
         zWZ1u01FjJ4P72N1xJ5AD4VXCcjv8EN8v0mkTHWuDctxUILb9nk80LYobqGJFid8j2Ug
         J6Kl1hUKA9H6bsjbYBMfUporCGUGhW2A8Csp3VFBHEqob4g+KzVbx+6T+CzaE9PlIFKx
         COOhLJ38rW5ZJYWMS7LtnWqqHgsQEiHS2jXG5ignAHqEL2xYZXJBwLHM78YuTIW53ZSD
         nMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294910; x=1688886910;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXcHU2bOUKkWG5SrVEt81jnMq95uggPNWPX7wKWbtNg=;
        b=JwFH7TZ4nFc0jpkpLstaTRQ8DfxiNlXonZno97jOn2BY2b8bTEyaNtLedVYDZGq0JF
         wNV47QwRMR9ig7i+KH28JOrWetP1nl/qJDG6leQ1UB9Yvq+inVOkErsNXjGSbHLFmMhb
         7c2mXncgSY6POUNnDMlpH3qgPudXN4TbKLbsWfEcf9P1HSusQczE8LQbJ+et68jX1DNC
         g8o3SzNwMsQyDennRkXJkCUKO7KCcpDojCaGonWjhfyWO4dpoyPQ1k9dyXaTfStre5p6
         s1NWiYzLxpj++pOLwB2+aUbAueo8SqkZoVqD94zxLaFiCSelGTRVTV7gMQMctqs5ugr1
         56Zw==
X-Gm-Message-State: AC+VfDzleNJkRlKqBpcjTr83oIBo+OTL0S6S0HPgr6vmBk1BcuQCjqrw
        wSWfBzF176p02pWqH2bn3nuR+PQBX19e6rSgvwiNkNC6ssA=
X-Google-Smtp-Source: ACHHUZ4CwlLS9vrxJK1IcSKBz+kWkAPxkuBSAYXHZHWjAEyFgHrVSCUrUbDIRdK39OHN2KC96avZ28IRirM8JarAo14=
X-Received: by 2002:a92:cf08:0:b0:33d:c0e1:9cb2 with SMTP id
 c8-20020a92cf08000000b0033dc0e19cb2mr841495ilo.27.1686294909698; Fri, 09 Jun
 2023 00:15:09 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>
Date:   Fri, 9 Jun 2023 15:14:58 +0800
Message-ID: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
Subject: Some questions about using the perf tool in ARM-SPE
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

hi linux-perf-users

I glad perf tool can support ARM-SPE.
however, I have encountered some problems in using
My perf tool version is 6.1. I compiled it to run on an Android system
"Here are my questions"

1.I can't use the perf c2c function to analyze, i'm not sure if it
only supports certain hardware architectures

>>user_shell:/data/local/tmp # ./perf c2c report
>> Failed setup nodes

2.I get more information via the command /.perf report --mem-mode but
I'm confused about the data

Snoop  Locked  Blocked     Local INSTR Latency
......         ..........  .       ..................
N/A            No          N/A           0
N/A            No          N/A           0
N/A            No          N/A           0
N/A            No          N/A           0
.               ,                .
.
.
I have observed a lot of data about Snoop&Locked&Blocked&Local INSTR
Latency and their results are always N/A&No&N/A&0 which makes me feel
like it is not supported. Please give me some information about it and
introduction.

Many Thanks
Best Regards
Zack.
