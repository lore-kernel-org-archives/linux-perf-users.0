Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B110C7EE22
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 May 2023 05:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEKFgE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 May 2023 01:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEKFgD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 May 2023 01:36:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B608E61
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 22:36:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e4f674356so7360689a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683783361; x=1686375361;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hNKPKJQGc5C02qWJH+QMSd9EFf+RdxvoMCl8k5H3wG8=;
        b=CNiaw4tQvZvXT5RxJ1IbUdLNeq0kfhuG0FRX5D6Q7+j5STEy7a/3OqqSjDtQKbQtnL
         48oj+KCXPLgtYJjw73H4L85eWtkHU/+0QkV7ujkfqXNoSzrLa150RYUQSy5YIw4UmNzB
         YAKdrVnljW0rFh0xTGDqG2V/tjOpjj4JkeQ/8KDA+h474nmCLSqkvan4XKvNEkHGgeCh
         f/s5SqiKw45sykAy3ELZeZieONS1/SmgaNVPHszywV1P/7ltl1iZ8Thiohebkm2HX4p3
         2IFtbFZXSqzhVyB2mvulIcKphqXBIKIwBQEcrr2WlNdCxd9xk38jTgajXz7dmcK4hymJ
         9vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683783361; x=1686375361;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNKPKJQGc5C02qWJH+QMSd9EFf+RdxvoMCl8k5H3wG8=;
        b=PUNXS+eBzwMNmbfyP2Ljb74T2Fz+zFJPjdgPtSvHaXrDykbLZCrCNWxg0D0+ZAWxb3
         oGh5EV62EubPz/2EWdTwL81trrUAu1vHx9O8Em2wqN2p3HjdCOnwetxGL6mcjjm2YB1e
         PC9QoXMouVzvd5wwPXhZxVkHOjJnulVYp8aIde2e5Ts0+S0SpveJTvhIbYv0du9uSqRE
         rgUDFtZrfft6lauWSzQPfdscSBuZaeD+SF1FvrYLAcg0URRpiphRyvjk72ujOzIiorKx
         rmnFAMe6CY9t1EUMP5oIou3ICXN9OPMHYdThi3iXDfqn7fbSgTBwGViVDS7IaTPM5iPR
         sAGg==
X-Gm-Message-State: AC+VfDyCC30K5XG9yslcKvNtlcbUbI63k/Uri7WC6VYCxo5XBr6mPi1K
        4QfdJSHGn7954X16jw/OErfIJj2Zbn/5dRK6Ic4owDgz1T8=
X-Google-Smtp-Source: ACHHUZ5KexVQLVc0Vulq6FPr+ZgLcFbFvf7BXEpIMoHM9TUZdH8xOf5VqqzuT8UFX6beiybtUOfvV/ENOHzs74aih2s=
X-Received: by 2002:a17:90a:2981:b0:247:6be7:8cc0 with SMTP id
 h1-20020a17090a298100b002476be78cc0mr19380373pjd.35.1683783361235; Wed, 10
 May 2023 22:36:01 -0700 (PDT)
MIME-Version: 1.0
From:   Rajasekhar Pulluru <pullururajasekhar@gmail.com>
Date:   Thu, 11 May 2023 11:05:47 +0530
Message-ID: <CAGA5_H6b7jVJcy0ahnbTqG3eqA2PD3TGFmXm7xQ=gMBVJ1yZyg@mail.gmail.com>
Subject: missing symbol names in perf top but not in perf record/report
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An application (compiled with -g and -fno-omit-frame-pointer) is
running inside the linux container. Trying to use perf tool on the
linux host (not inside the container) to identify a list of functions
consuming more cpu cycles.
Running perf top -p `pidof app` on the linux host prints address
instead of symbol name, where-as perf record -p `pidof app` and perf
report prints symbol names instead of addresses.

Why doesn't perf top display symbol names if perf record/report can?

Linux host is based on jammy, and Linux container is based on bionic.

Appreciate any help.

Thanks & Regards,
Rajasekhar
