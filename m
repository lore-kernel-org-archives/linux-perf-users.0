Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992F9C77B73
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 19:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjEXTZK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXTZK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 15:25:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4C12E;
        Wed, 24 May 2023 12:25:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2535d86a41bso469329a91.3;
        Wed, 24 May 2023 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684956309; x=1687548309;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7tQVx5KhyZTfskaT4JOiAzqz+awNPLyNJW3eUvdWJ0=;
        b=q1vHSsWKIoPK/EQaQMW1mMTBUXrr//27so0IxjSfsPSTKKEA/y8C0iHDzrximC3995
         f5p2j32PGcWw2T1wK9K/usol4pP2rMbiUYUyG5G7s6R8Efnfp7/5whbFESVVSOep4yiF
         WFVrh3SDPajXunQ6pv0zQGEISPL5/z/JMMZ7ksdmLqZAalKtngW+UBXK7vI+nYnOAbhZ
         wMV/ph6IJrPU7EJdNzC49myKb2ypdKUNixknIExcOYGW8FsNxHAh23duYledfBBhmFEN
         7HFoMUqVsmP2V+DYW/rCammnvuvOwtfI97/8ev8MnNjqg6JTTQjptCzcHk4djynjepIe
         VyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684956309; x=1687548309;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7tQVx5KhyZTfskaT4JOiAzqz+awNPLyNJW3eUvdWJ0=;
        b=HjnMJmuGcN2xOqBjTWbDf6ONrYJ3XMFQKlr2rvyCermUFzokeqzTX14ilGAKhpLDaD
         /KmFawkuiiWFKiRkovFb9rfClMkCH/FUGUX2pVnCJY5Bc0fMtIbI5OB21EAhNq2lsaR5
         Ncy54XDnGjyy22dDGvEaMq8WsUSI1tYGwGZBnC6Q10qcmAqEa3zCq9FwEDCE+nj5wtOy
         hG2F4E4Jwu0VKbZqNM1cPlgquS4k2BXTeEaPq4PHmskEXwPUxQA/T4de2SkBVnpF/fpF
         m+rI+1oyr9eAPk5arMvW+3lSeGCMX6Rbl0J6fC17dl2/63fqynQ13DXEqRDepYywznq+
         k5vQ==
X-Gm-Message-State: AC+VfDw5R1FJB+Dnx+0c8TTOpa/hef6ot6V3w/oSfUDLET9hD+QYHqVl
        JpuPZ3C7+ka7EjFz2o7PaP4=
X-Google-Smtp-Source: ACHHUZ4YAUrT5Y/axpi1xg1T9jcHGcQ4eQU8T6usdJDiUrh1N8CX+kEAuNQuZhSvwA64pXszIWEQGA==
X-Received: by 2002:a17:90a:4e03:b0:255:2e48:70b1 with SMTP id n3-20020a17090a4e0300b002552e4870b1mr14714631pjh.26.1684956308543;
        Wed, 24 May 2023 12:25:08 -0700 (PDT)
Received: from yoga ([2400:1f00:13:9f5c:402c:d1ef:ec3f:b268])
        by smtp.gmail.com with ESMTPSA id fr2-20020a17090ae2c200b002532d74fb59sm1683943pjb.22.2023.05.24.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:25:08 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 25 May 2023 00:55:00 +0530
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZG5kjDN63HqqMuJJ@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello everyone,

I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
and analyzing the performance data.

As a starter task, I have created a test for testing the perf data JSON converter command.
I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
your advice and guidance.

In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
potential issues but have not found any :). Additionally, I am running perf data commands to ensure
that all use cases are handled properly.

I have one question regarding the installation process. Typically, I navigate to the perf directory,
run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
like to know how all of you compile the perf tree.

Thank you for your support and I'm looking forward to collaborating with you on this project!

Regards,
Anup
