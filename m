Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB72C4321E
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Dec 2022 12:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiLEMw3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLEMw2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Dec 2022 07:52:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F621ADB8
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Dec 2022 04:52:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f18so18418179wrj.5
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Dec 2022 04:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5UjZSRp0oBsqsGcFRbypPs+O/SZ54hfQp9La25KVorA=;
        b=QgjGKI1XGOOOf4Pxs4Rn+0grYFJCDT9IbtiE7oJsNE4XDJOc3HxwuuEoMCd/MryJtz
         dYoK9WCDA8jBUV+PD+CmLnknQBT084Ylum7Cln+eK8F+a33fR/0f/nv6WpSpxdvGE789
         XQlP8933JtLTdhlzr0zfVUeBlxpcDPZcF69H+Sba1J2wiQS/jneZQfdTT2OABHACUVRQ
         YECw8jQtpEwLfHNJT96tPHDP5EU7BvWXfHUHMVoVyNA6BZsCTYP92A0IOB7GSH/1SGut
         YbcImQz8D/i67nMD38pxV8Uhp14dZHRFk8NTYYiqGmfkdVEp44hn7smmsOL7PGuWA5qW
         KFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UjZSRp0oBsqsGcFRbypPs+O/SZ54hfQp9La25KVorA=;
        b=bY4zPSQMybYyT9+l5I27mytg+UeD4Q14VQDiXNEmWDz42xkJMzM3v5BBRtCSAG/e89
         PD6dt5O95DI4QCcTPG/nu8jdKB9n0P+P/YD/D5T86PVpZ/rUGbHKE7i0fjJuw5XudOGn
         zdsQCMffyPk72pXcY8vqjfjISsttOfDc+Ki3ZfnBLnyRKlIDb8NAre1snPvKCud5ZpUn
         drdsJVjkXwWto5PUkGFHu0x8SL4BTEV6oCkJwizZx9FnSr54eHlumT7JSebYjtUpAZW1
         XIfZMXUtz2b42ATjKYtCmk46AFVk2gTu5A5/oXX4d5c3zUatQFxyhoeClc9cud4yri/B
         479A==
X-Gm-Message-State: ANoB5pmur3O9LN8y3Vchv0KR17myurICD0Q70PRaYjIzPnQiQSoCcLjG
        xd3VudZctaNhgBYvCDdY/kkrgGSiP8fndfGscgz4eOsGcjY=
X-Google-Smtp-Source: AA0mqf5LSopsuUo6GEbq2rHLBnevHYPuzJe7zj8GEBo9V0oErMz6+JTbgXKMTv7no9EuayRmZF+y5Ye9Boo3Jad+qEE=
X-Received: by 2002:adf:ed0e:0:b0:242:62df:9216 with SMTP id
 a14-20020adfed0e000000b0024262df9216mr3064225wro.165.1670244746018; Mon, 05
 Dec 2022 04:52:26 -0800 (PST)
MIME-Version: 1.0
From:   Sebastiano Miano <mianosebastiano@gmail.com>
Date:   Mon, 5 Dec 2022 13:52:15 +0100
Message-ID: <CAMENy5rSv0G45yZ-5Wmj9oZCb8XDVCX-oO8RsQ942q-zSF8yCA@mail.gmail.com>
Subject: perf-stat: count events for BPF programs
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Dear all,
I have a question regarding the use of the new 'perf stat -b' feature
to collect various events for a specific eBPF program.

I am running the following command on kernel 6.0.9-060009-generic:
sudo ./perf stat -e cycles --bpf-prog 96 --interval-print 1000

but I am unable to get any metric. The output is the following:
#   time                   counts unit              events
     1.001015662    <not supported>      cycles
     2.002171264    <not supported>      cycles
     3.003229801    <not supported>      cycles

any idea/suggestion of which could be the problem?

Thanks,
Sebastiano
