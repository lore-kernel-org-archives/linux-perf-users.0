Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FF5C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 19:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCHT22 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHT20 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 14:28:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BEE567A4
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 11:28:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3533020pjg.4
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678303705;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f0PgYrCsXDhRdoyZ6PcABpPOuYsy0N/zcEpCEZvgcpo=;
        b=mzyshPk3vhvdiLJV3penXyJv09jB94SUpnl1uD1K17FIWwgbdBRLfH/MQlBjqJeJPL
         Cr0tllOmlQv4Wi/xv1ujimGbZdW3eeM6ePHkvgbUaqLx4XsAtcrnsyNMwVN8vF9A6rFO
         qC/tWag9usRtqC8Y8wbEt4i+vIy9KPVEYpttvhJBCKr9BjoCivARbbuTdiuUAEapGjzr
         2jzFaB6H+4Htte439jFaHSfulUW5q6u8C3XaAlXH38njHW25Xw3kayDIGh1LtG4oPjuU
         yHoZUUH4d/t+1xj0KzfCDADEhrbds2OKH04exH0P6ojkozBctNE2YqXj5Q4ROXWGmnJf
         B/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0PgYrCsXDhRdoyZ6PcABpPOuYsy0N/zcEpCEZvgcpo=;
        b=8Ios1HxbdS28ypCCdL3GDhoAY4cGozus/iWB/uDcsAFh5YUlW0jZZGWmI59EXt7DdB
         mWpfo2ECSMZhK1dugFKTpMdOj/0MbbfTluQViEN8z1avrFxQ/1J+f1bPJVF8NcGX446N
         cluo2U0I0W35R12lr/TnBo8bZ3Q1KGd/5IDzioGHWbQl0pVE1ze3BSpQWBbKaRYEy+4o
         jGHScv1Jb9EZyHIm+p8ipmkNXambiz5FBy56Nhs9NWtC1BEvs+AZ4HRwDyhp3epr/HLt
         940xzcdkwVWBVRVRSynby59Ro+oJDMVEfBIi15SyvOLT5BfeaKpLv6L8fgsBKbRoKgvt
         Qalg==
X-Gm-Message-State: AO0yUKV3/xzpdouX/2T9zNtO9R3mODY7v4qOWJLgUKi7FpnTZqw3UZSs
        rISGOR1UUIruAbO7Md43Ya/GtUd1rir2ek35+fpgzw==
X-Google-Smtp-Source: AK7set8G0z7kPgtnXo7mTn33EKOzFFvaUSsb9ozq/H80/1SrRPWb8q5edAIZB09dKbrDK1xs+Y1j/PdpFoR+uYg4xPg=
X-Received: by 2002:a17:90a:348d:b0:234:a62e:bc10 with SMTP id
 p13-20020a17090a348d00b00234a62ebc10mr7222800pjb.0.1678303704664; Wed, 08 Mar
 2023 11:28:24 -0800 (PST)
MIME-Version: 1.0
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
Date:   Wed, 8 Mar 2023 11:28:13 -0800
Message-ID: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
Subject: Broken build on 6.3-rc1 with uClibc-ng based toolchains due to
 poisoned strlcpy
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, rongtao@cestc.cn,
        daniel@iogearbox.net, Stanislav Fomichev <sdf@google.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi there,

So commit 6d0c4b11e743("libbpf: Poison strlcpy()") added the pragma
poison directive to libbpf_internal.h to protect against accidental
usage of strlcpy. This has broken the build for some toolchains and
the problem is that some libcs  (e.g. uClibc-ng) provide the strlcpy()
declaration from string.h, which leads to a problem with the following
include order:

                 string.h,
                 from Iibbpf_common.h:12,
                 from libbpf.h:20,
                 from libbpf_internal.h:26,
                 from strset.c:9:

If we patch libbpf_internal.h and move the #pragma GCC poison
directive to after the include list, we fix the problem but at the
expense of leaving libbpf.h unprotected (and libbpf_common.h as well,
of course). We could duplicate the directive on all these other libbpf
headers after the include list, but that's code duplication so I
wanted to bring this up here before I send out a patch.

Let me know what you think or if you have any other suggestions, please.

Thanks,
Jesus
