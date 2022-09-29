Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE41C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Sep 2022 21:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiI2VyZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI2VyY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Sep 2022 17:54:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740512756E
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Sep 2022 14:54:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so2577103pgq.8
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Sep 2022 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=6VJEdRuAnZMaurhn8E94wnhY51Zn54NeRR0vh4+82g4=;
        b=ePFQ1ierwJ6FjgiOitss43F5wTpMNy0TAkSzHek74RdHj6eqPGO4UBZKuHMk/rYbF3
         eUfD6Au98n2XITK2l2lVA0OWSVlvhV96Z2+xxN20+R2n6hYsTIVDgHAvyNWB/L7IHSuM
         kUpD4SMRXgWXaTWG7+evVhM9MHh9OhBu/dVWTT+y8XhBEmdNDl732Q8db8BJvWsuPZEC
         8ALwV2/EmpsxuFx2HvgFmDA19Gc82c1UrI1nk1kWGBZeAQw0ska85t1Dlm2sFFB9fCO9
         a7d2/snZ5eLHt6GY1v6TliLdieYY7oDtXyFUnZx817HMlqXwJ4khVZFU1plnP+I2wk6G
         gDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6VJEdRuAnZMaurhn8E94wnhY51Zn54NeRR0vh4+82g4=;
        b=6RxKpnKdJsQybpVeraAtGfYdyV6yob40JsuBw4M8C45gZLDRHFXt2BbN66UG1vxgBC
         VqFAX25NZsT/hN7iwUn7OvQ5pZNwJ1NzdJxtuwUn/DHS7JOyhAACA2PJkSTwzY8NZFZz
         xec9KZqaPiA5uvmW1DN9mvv9nC+brVHWav8URLxte2GmjmLGfjUQbcDSYSWUlD9NQnOP
         I6X5OmfflR7jy2ZlKXO9odFyp3Vr7V/1BV4qLbufX5Bj/7V1wK9k4AQ+BfF1FFVYJsSp
         ZtFkcyXaSDBrvlJs3wBPXnjA8XORiBUPoNB3HiL2lnQIHfy7Xp498QtfKF/NG1hbYjam
         bw8g==
X-Gm-Message-State: ACrzQf0hlEWq7nccv9/DjqPmZdd9OazRNo0zodd16jQ24TjV406SZOD/
        jWm1uIqHFRb6iB+UcfIbyK9auRku2HwmFPnYkMgy2X8qhfj55A==
X-Google-Smtp-Source: AMsMyM7d3VBgob6HSDmPHbGU2dcKlX1Q8PGJV2P3+Mgcp8+nkpRfJ3bDWggGJpr4BxBIEgCgoOlO/yKFN/IzIaMKyqU=
X-Received: by 2002:a05:6a00:1743:b0:548:8629:ceab with SMTP id
 j3-20020a056a00174300b005488629ceabmr5297404pfc.23.1664488463053; Thu, 29 Sep
 2022 14:54:23 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Sep 2022 14:54:11 -0700
Message-ID: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
Subject: Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'.
To:     linux-perf-users@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

So I recently moved from a dual-xeon box to a zen 2 based threadripper
workstation.

My usual incantation for measuring profiles for compile time isn't working:

$ perf record -e cycles:pp --freq=128 --call-graph lbr -- make LLVM=1 -j$(nproc)
Error:
Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'.

I've already set /proc/sys/kernel/perf_event_paranoid and
/proc/sys/kernel/kptr_restrict to 0.

I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
Is this a known issue, or am I holding it wrong?
-- 
Thanks,
~Nick Desaulniers
