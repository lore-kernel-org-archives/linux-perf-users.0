Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D802C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 06:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiERGMc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiERGMb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 02:12:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7B4D276
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 23:12:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a11so1230291pff.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Egc6ZBRUY3Z7canJd0liUWr1zN4YpwqPjX5M7wJmK6A=;
        b=ZyceAB71StStDws0PCQWbFm05oQFzX/fmB8D4jIFiyZTkjcY7YAb4KwAptsQh5eUog
         GEdf+efoFYDdNjPxnAyABJV9ERr+rmmLMkRN2QeddxZ7M3fCgJpCpts3ufWRe92HNS6B
         1sH6y2UbOTyzLwEvJyEzGMmtGjgx8Q+hsiJlaoPU7dDMXxxhF7ZwQRiIS3RWGH2MM4+8
         pP46COFUjCg7ezNqyyGeWUyAFXu/qUvXu0VuE2teZlTmI+druzbxUVI1HCAAdF7pbmDc
         MmwTI4PuCWDYoRykrlSrE3GPu9hqFwtSBKwmcbbClXuRgA0TsNBdWnI0tdiuJrE8D8uJ
         Weyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Egc6ZBRUY3Z7canJd0liUWr1zN4YpwqPjX5M7wJmK6A=;
        b=WHS2Hd5umu9EXduxGcgTKacJbCT3vwZ30paZTGeFG/quHJvNRY0dHgQzIWSDZ0oDVl
         tr5ME3xlk6SGGA3qG1iLPtxkt7uBI17ZMlFb/mrMSGEUJSmTaXQvrrTASXsF6+Hu6nJW
         ix4MWvmrr4XDnaqAtHvqlIPGdloqsdMaCal4okPSAr3jugG34ktc6fqgei/98WVIvcnq
         RG6Lqt9yYReAAEqg7h/xIpZkoZfgEa1k0z4YiM7zsVx9nEJ3w72PjMshImd59zCBePht
         3Lo0CTdshan5YM7WvChANAJ0gWSlsg3k6VMq5ov7YLjYEsC/L3SBKpKljwQVzMreID+f
         nTvg==
X-Gm-Message-State: AOAM5310q3a+dF8cpZLJjZDkwnJd/x/UgLDsfcxOkXVe362Q0zvLdJz7
        vrmQxoEytwpstuv694arwhol1g==
X-Google-Smtp-Source: ABdhPJyKvttCrwlKvi6zipgCpCV0oQPQEBdkDd7IOo/kkUeLxXuGu/H6Qpe5WWHWjmeWOTHiM8ug2w==
X-Received: by 2002:a05:6a02:206:b0:399:3c9:f465 with SMTP id bh6-20020a056a02020600b0039903c9f465mr23061776pgb.388.1652854350012;
        Tue, 17 May 2022 23:12:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id 1-20020a620501000000b0050dc76281e1sm840168pff.187.2022.05.17.23.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:12:29 -0700 (PDT)
Date:   Wed, 18 May 2022 14:12:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adam Li <adamli@amperemail.onmicrosoft.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/11] perf c2c: Sort on peer snooping for load
 operations
Message-ID: <20220518061221.GA430350@leoy-ThinkPad-X240s>
References: <20220508092346.255826-1-leo.yan@linaro.org>
 <20220508092346.255826-10-leo.yan@linaro.org>
 <fefc1f23-ea1c-6339-77c4-b0974cbd6e93@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefc1f23-ea1c-6339-77c4-b0974cbd6e93@amperemail.onmicrosoft.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adam,

On Fri, May 13, 2022 at 05:05:45PM +0800, Adam Li wrote:

[...]

> > As result, we can get the 'peer' display as below:
> > 
> >   # perf c2c report -d peer --coalesce tid,pid,iaddr,dso -N --stdio
> > 
> 
> Hi Leo,
> 
> I tested v2 patch on 2P Altra system.
> In case the false-sharing data is mainly from remote node, 'Snoop Peers'
> cannot indicate severity of false-sharing. As showed in bellow output,
> there are only 10 'Load HIT Peer' records, while there are 2353
> 'Load Remote DRAM' records.
> 
> And the name 'Load Remote DRAM' is kind of misleading, since we cannot tell
> the data source is 'DRAM'.

Appreicate for the testing, and your feedback is very helpful.

After some discussion, in the patch set v9 "perf: arm-spe: Decode SPE
source and use for perf c2c" (please ignore the typo "v8", actually
it's patch set v9), Ali has updated the memory tag setting for the
type ARM_SPE_NV_REMOTE.  I think the prominent change is we set
PERF_MEM_SNOOPX_PEER flag for remote access.

Please note, in the total statistics, all remote accesses will be
accounted into metric "rmt_hit", so "rmt_hit" includes the access for
remote DRAM or any upwards cache levels due we cannot distinguish
them.

From my experiment, with this updating the output result is promised
for the peer accesses and it's easier for inspecting false sharing.

As you might see I have prepared a git repo:
https://git.linaro.org/people/leo.yan/linux-spe.git/ branch:
perf_c2c_arm_spe_peer_v3, which contains the updated patches for both
memory flag setting and perf c2c related patches.

Could you confirm if the updated code works for you or not?

Thanks,
Leo
