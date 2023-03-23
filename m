Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C8C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Mar 2023 01:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCWBnM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 21:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCWBnL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 21:43:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07D2D45
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 18:43:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3e0965f70ecso163381cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 18:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679535790;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LlKFIUnSiiyDV3W4CcAc2xVtnCFtBb9VdMUxb4jw44=;
        b=SrlTMZmYgOWH2+lpIr/3B4bXeXk2h9EtYR6hMRGQPunkoAQiPnt777dvmzlY7q8vFu
         cTqcdLypbh6S7gcResJEcj68suRCTCnSf3cN6r5PSgQnVjd/IZruAoURU6WrhfBpRrwo
         3bbI34wK7oEr7BOA6n2r8XoZhLyPI0DvSNLm+fW5omdFGSwc5jKYkfqZD7okHOWUw2ZF
         l6xQsKRWKlqYF1M9Th/1uoXJs0ngkk2WFZyx65S5wvHPPQRZ5uyaw7LY2WrAsgxGPGM8
         DHXLLhc2FoQCDaSUiIdK0nvDZ/qE37ZCRTPK5ThEhcfCrRM7zORlxhlIT0crmm5KeLdb
         QTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679535790;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LlKFIUnSiiyDV3W4CcAc2xVtnCFtBb9VdMUxb4jw44=;
        b=oIvTHlewE7txDlKAICvZ7kmsD6WMSWOfTkagP+o9BtOp8FmgR2YB02bY8O9HFmXgo8
         ANValjEmm71ta7igBEVcaPw8ygrZl0FLCF4EqiOwt04ThMWiIfG3umMdBB02+F3Jh2Ot
         G8A96pH5bT6MvSEAg+yPr+gB5k/AMlToAocGBfj2BeDdZxlhvmwTH6WSdMvWQPUMOL6b
         LoH/Dk1o//4G69rjzdWUi1q3g2nTBUg3QNIZEqNwi8OywKkd4RilrDur0mGJ6M931T0e
         6B/F6GYE2SB1OXdwqO2aASplVdi5Op3cAXenDYuSoKpLx6cAGWJpFkcCOHngGn3aJgeQ
         oTQA==
X-Gm-Message-State: AO0yUKX7CGemKNxAQCumCZU7xD6ogl0cbtfHovnySaAiVNqx4Vs3uWTN
        Ryqpcqbu7VS9pSnoO2BdWTHxryy7NJivx4tbSW+B3xHpl8OwS5eIOKjVqQ==
X-Google-Smtp-Source: AK7set9qTOJdeJ55DXen5M7F1pIehc7zwBpS5B15RCsnb+/+t7c3VOg5Ek4FkVqhdrSnXw21/2sKAB7P0o0g9Gsn19U=
X-Received: by 2002:a05:622a:312:b0:3c0:4e06:764d with SMTP id
 q18-20020a05622a031200b003c04e06764dmr742874qtw.16.1679535790114; Wed, 22 Mar
 2023 18:43:10 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Mar 2023 18:42:55 -0700
Message-ID: <CAP-5=fV_A0A8-BnfaWFoXX2a284UDp8JHvaBLC_FXPzW5GT+=Q@mail.gmail.com>
Subject: Determining if optane memory is installed
To:     nvdimm@lists.linux.dev
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi nvdimm@,

In the perf tool there are metrics for platforms like cascade lake
where we're collecting data for optane memory [1] but if optane memory
isn't installed then the counters will always read 0. Is there a
relatively simple way of determining if Optane memory is installed?
For example, the presence of a file in /sys/devices. I'd like to
integrate detection of this and make the perf metrics more efficient
for the case where Optane memory isn't installed.

Thanks,
Ian Rogers

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json#n1134
