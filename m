Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32659C19F2D
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Aug 2022 01:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiHEBjL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 21:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiHEBjI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 21:39:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BA870E63
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 18:39:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f63772b89so10755587b3.6
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=7+EYB1pk4IZO2mzflNAQJXsnyqSSlRrvUF2/Jl/U4Cs=;
        b=X/XIJN+F3QDx4daRHdc5rBM6aQ+E+E8TId0C/sWiu5GqnrEzKUVZlVa1QmRreZtg9O
         a4q7LBMC2huIkNgsiyCwNlJZJIQpo4WVPltZsFM6wsal0/v6ufa1KySYfRAslTwduc8h
         gy8ISFZ1/otBuyqJLojF0Jq4mOntCqKt3zDZYzjf+x25vQDv+H58c0a97lIcdnbiGklh
         jDDF103ctVoopq9ur/AlZbvd6b7Ln9UmiqdKBcZWH3kwR0Cx2KeTB667TFzwu/uROeR1
         2jSLKqf/zijQqn/iByQcvYDBAOKWYIIdN40Tv39kK5L2SMQ6AoWL49wI2ND7un438FHM
         AHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=7+EYB1pk4IZO2mzflNAQJXsnyqSSlRrvUF2/Jl/U4Cs=;
        b=JVcYNXR8RexZ/LFwnKPd0IlLTBucMJAyBXpDIRw5OCY/E3uH7ri0ySGIqFSXKDuRdZ
         tV6VWAcVqBsND4G8gDiFzHwzf5XHVATAcqCOHbmcca7g5DJpha6seOYHlxqYXAgDkEmy
         qzBl9X1A0hqXeOfcmpl9YPxE+/8fwDHyrI2gdn+/Ux9GnodtN067bjZKIrdiFvNv/CiD
         QYG9brRziRIA6MfaVz2bVq3LYCO0LGY+B2uF3s9gwO07tHoeuN5t1d79PEabNxPrlm1l
         5W0lqM06XAoJKBoaZ3kvaoCbd97OjZdJOXKuktKtv6XdZThcQ2tZJV9ozhbbyr0hudw5
         pzsw==
X-Gm-Message-State: ACgBeo2PThHlHW4HN+Mjbo1NmqXv6FpPqf4BIIHWZgS1iUy0lSt+GayC
        kDFBnFUEwvhKoDhPj8GGd8i2T9deaszA
X-Google-Smtp-Source: AA6agR5pZ0812bin//wLqKa0nyC+jILL3NkiM8EBcuLLPhcwJPe0Q9vcYF7WwkHc+OsirDKlYjx/gUEeuw0u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:814f:0:b0:66f:9fbc:87ff with SMTP id
 j15-20020a25814f000000b0066f9fbc87ffmr3633735ybm.12.1659663545301; Thu, 04
 Aug 2022 18:39:05 -0700 (PDT)
Date:   Thu,  4 Aug 2022 18:38:53 -0700
Message-Id: <20220805013856.1842878-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 0/3] Remove bad uncore filter/events
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The event converter scripts at:
https://github.com/intel/event-converter-for-linux-perf
passes Filter values from data on 01.org that is bogus in a perf command
line and can cause perf to infinitely recurse in parse events. Remove
such events or filter using the updated patch:
https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/afd779df99ee41aac646eae1ae5ae651cda3394d

v3. Removed filters rather than events in some cases as Suggested-by:
    Liang, Kan <kan.liang@linux.intel.com>
v2. Manually fixed a broken \\Inbound\\ ivytown event.

Ian Rogers (3):
  perf vendor events: Remove bad broadwellde uncore events
  perf vendor events: Remove bad ivytown uncore events
  perf vendor events: Remove bad jaketown uncore events

 .../arch/x86/broadwellde/uncore-cache.json    | 97 -------------------
 .../arch/x86/broadwellde/uncore-other.json    | 13 ---
 .../arch/x86/ivytown/uncore-cache.json        | 90 -----------------
 .../arch/x86/ivytown/uncore-interconnect.json |  1 -
 .../arch/x86/ivytown/uncore-other.json        | 13 ---
 .../arch/x86/ivytown/uncore-power.json        | 19 ----
 .../arch/x86/jaketown/uncore-cache.json       | 30 ------
 .../arch/x86/jaketown/uncore-other.json       | 13 ---
 .../arch/x86/jaketown/uncore-power.json       | 11 ---
 9 files changed, 287 deletions(-)

-- 
2.37.1.559.g78731f0fdb-goog

