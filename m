Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A82C53210
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 06:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjACGyb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 01:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjACGy2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 01:54:28 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2989B48;
        Mon,  2 Jan 2023 22:54:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VYizcRl_1672728861;
Received: from 30.221.147.58(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VYizcRl_1672728861)
          by smtp.aliyun-inc.com;
          Tue, 03 Jan 2023 14:54:22 +0800
Message-ID: <037e063c-7cf2-a1cc-2084-f97c813cd2da@linux.alibaba.com>
Date:   Tue, 3 Jan 2023 14:54:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/6] Add metrics for neoverse-n2
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fU+4eR6ngX1Rn9fL9eAau4f9FHXx3+C2UxwbfeB7Sk0cw@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fU+4eR6ngX1Rn9fL9eAau4f9FHXx3+C2UxwbfeB7Sk0cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



在 2022/12/31 上午2:48, Ian Rogers 写道:
> Series:
> Acked-by: Ian Rogers <irogers@google.com>
> 
> The only observation I had is that the "per kilo instruction" in the
> names (ie ending pki) could be moved into the ScaleUnit. Which may
> make the names and the output a little cleaner.
> 
> Thanks!
> Ian

Will do, Thank you Ian!
