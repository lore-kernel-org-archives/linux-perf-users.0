Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48342C74A5B
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCQNDS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 09:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCQNDR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 09:03:17 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFCDB7D9F
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 06:03:14 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k11so4397175vsq.13
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679058193;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ogmft17LqxniCQozRdbn+rh9Xvw4awAspC+U0/TcO5I=;
        b=EBB4XOazV+bNMWgjCT6v9qKN18lcOZL3hy1Z3OnbYcoVJHk2/ty1grOE7Hn7sBD2bf
         3ENBt1TDyxRai6Kei6/a+h0nViGK0qQNsRxdySRcvD8PVq4JoZCxTX4H9HDp2fmkQGSd
         e1kUmm/wCAYa0VurGSlh3Gmwa30WXRIz5bi4+3SGzuDFHTYrweciBw4IVpUknydX57s1
         TdjTFfi9wwEl6DuWcbmwj+KEDN4K/KngG7yV8oSYoWkbnQFLU6eclnuOey4rPBum2C76
         x70hFeEWvogUgi5vlsjD+WFOh9LnhMPadu1wU27wBrqu3FPX4mXu/U1D2iyHI/+gz6s9
         aumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679058193;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogmft17LqxniCQozRdbn+rh9Xvw4awAspC+U0/TcO5I=;
        b=aD6FlCodJTvp2+1fMDW1rUd1Fvj+XunBbcUQI3Ws1LCUQVk3aS+SfQf54Hlwp6Lnzr
         u+HqOFWz7xyHORVmcRBcRGqLEx2y3BOEMZ2Al1f3B/jXukuXqWeo64DPS6OKj0wPwIZ1
         HHq2eE4rEbuPtarFQy6+YjBJ8mRy7aMoXhBEHo2nRDq8qE6HS9LhYoPna5IANsOTqG6N
         Z23y7SJCuEPdPjFHTKsOglhNrRFfE/1IOzgoxJkMVwd62GFDm1hM2Td0WTgMgd+/Cfzz
         oTSCQlVdrb81gqmZHL+ntwhYPgHYgY7Qpl96Zx/kOcfyjCQTWRnHsVN08l8mbXXxSOA5
         t5pA==
X-Gm-Message-State: AO0yUKXRY2Nu0gdgRptYUEoZPvj4wxEYiO22Kuaa6939C+40XARe5SQE
        4hCFjqQEbLEAJZgJEnHK7qRVJ017PiUQVYuH6NMOVeWJiaY=
X-Google-Smtp-Source: AK7set9PDGtRYdVp0WvTI3p0es6lHpVchHCHZeNmXKuVV8Hea33sPr+cjc1gwzVXaYifwcXMCXHoXe4DvAtx1iU1v6E=
X-Received: by 2002:a67:e0ca:0:b0:412:5424:e58e with SMTP id
 m10-20020a67e0ca000000b004125424e58emr1839236vsl.0.1679058193150; Fri, 17 Mar
 2023 06:03:13 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Downs <travis.downs@gmail.com>
Date:   Fri, 17 Mar 2023 10:02:37 -0300
Message-ID: <CAOBGo4z=LObbQ-KRRuH__pFsC=1r1jQ2r0e3TbCTeweA9YsDxA@mail.gmail.com>
Subject: Cross-arch analysis
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Can I run perf record against a binary running on say Arm64, then pull
back the perf.data file
to an x86 machine and run perf report there?
