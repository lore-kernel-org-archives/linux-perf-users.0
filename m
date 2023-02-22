Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1743C61DA4
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Feb 2023 12:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBVMOO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Feb 2023 07:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjBVMON (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Feb 2023 07:14:13 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40F233CE
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 04:14:10 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so3992091pgh.13
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 04:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYGZ5//o8M4pVJprIcaF2S4AKthafJRvOQpNFYhcofw=;
        b=TryG8umiRILDNUIzA1zTxlagBAfT5lz0wkt1kAVhdh2HRVtf6M53uxmu70d9CcCwq3
         mGoVW7uWq/X/NXvmfl4J07c72SioPZ7D24FVx5TuP80SqrXFHN9jm73ohoBrTYOWySWd
         fmk5W+R4DM+udAzM8f03UcGP+ldclcstr/0hvqJaR8B59TTL7it1DD0QpL8LkCC1DSIP
         GROpt/saqLUP6KMY4rkI5SnrQQS4hSFFatn2NBtfmCRCHDv2qySBtP9qK1P/vDDWCQ/b
         OlyMqm3tl/5qkI2fXTZdrIu2uT7tEb6pU3jnwKRD9pX6FZCBfSfTYadLeuMY6l6MVhb3
         brAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYGZ5//o8M4pVJprIcaF2S4AKthafJRvOQpNFYhcofw=;
        b=rUdlI7OpLUC/ar6zQBLLAvVSDKhSO8JfTaqJbY4rSjRUzH111WAls/H+tO0GxK32jr
         E5WRPHfYt717B/xRqTrnC/0QuRDGFVcPkDAp/acfvEifh/IJy7s7ddCJSfddYZZlckDd
         GutY7113k3UXu0lY6fdQge/UVGpWyXN4+YyLip/OLw5WDXD9qHK2aON9HwiDzBSvGwB3
         lwNeZzr0WnnpYPLtbGsYjmkFwOMbmJ800+wDZfRZynMymN5+MPBnJAdFHOAjNWy6GDSQ
         VsB/Ajss7LjwykgRsLEz+IF1nr68nhgCF9jH7pueiJpza02EyohOs4nGZxYG5rnauReC
         uK5w==
X-Gm-Message-State: AO0yUKXXa0d4ZzWv2UnoxE6Z7jchRWFLZmqQziO63FNJk7MRnE7Z5BMJ
        YnzO2ERvf/VGWW6L4s04N1demw==
X-Google-Smtp-Source: AK7set/FbhCTWvNdc9k6TNd2ug0UrmTguYiyEScloVCq8+eigxepEY8xvZZ+ET0fyq2XVSiUKBJeuQ==
X-Received: by 2002:a05:6a00:4c13:b0:5a8:b6ec:3aac with SMTP id ea19-20020a056a004c1300b005a8b6ec3aacmr6963046pfb.15.1677068049595;
        Wed, 22 Feb 2023 04:14:09 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id f14-20020aa782ce000000b005d774488b89sm984450pfn.206.2023.02.22.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:14:09 -0800 (PST)
Date:   Wed, 22 Feb 2023 20:13:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>, arm <arm@kernel.org>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dawei Li <set_pte_at@outlook.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Naman Jain <quic_namajain@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>
Subject: Re: [GIT PULL] Qualcomm driver updates for v6.3
Message-ID: <Y/YHByya0NvoU+If@leoy-yangtze.lan>
References: <20230126163008.3676950-1-andersson@kernel.org>
 <cdcff86c-77fe-4c5d-b8e8-58b815b9e969@app.fastmail.com>
 <20230130222412.t2tkkhqfep2orxf2@builder.lan>
 <9b680581-0956-4188-9af9-af06b625c001@app.fastmail.com>
 <Y/VzRJzxkPm3l0Km@leoy-yangtze.lan>
 <4704856d-eac6-9088-4523-3739e04d3fcd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4704856d-eac6-9088-4523-3739e04d3fcd@quicinc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Souradeep,

On Wed, Feb 22, 2023 at 04:46:07PM +0530, Souradeep Chowdhury wrote:
> On 2/22/2023 7:13 AM, Leo Yan wrote:
> > On Wed, Feb 15, 2023 at 04:05:36PM +0100, Arnd Bergmann wrote:

[...]

> > > If the possible use is purely for saving some state across
> > > a reboot, as opposed to other events, I wonder if there is
> > > a good way to integrate it into the fs/pstore/ code, which
> > > already has a way to multiplex various kinds of input (log
> > > buffer, ftrace call chain, userspace strings, ...) into
> > > various kinds of persistent buffers (sram, blockdev, mtd,
> > > efivars, ...) with the purpose of helping analyze the
> > > state after a reboot.
> > 
> > Good point!
> > 
> > I understand pstore/ramoops is somehow like a sink which routes the
> > tracing data (software tracing data but not hadware tracing data) to
> > persistent memory.  This is why we also can route these software
> > tracing data to STM (hardware sink!).
> > 
> > Seems to me, Arnd suggests to connect two sinks between DCC and
> > pstore (to persistent memory).  But I cannot give an example code in
> > kernel for doing this way, sorry if I miss something.
> > 
> > Essentially, a good user case is to keep a persistent memory for the
> > tracing data, then after rebooting cycle we can retrieve the tracing
> > data via user space interface (like sysfs node).
> 
> Hi Leo/Arnd,
> 
> Just wanted to let you know that the justification of not using PStore was
> already given in the version 1 of this patch series as below
> 
> https://lore.kernel.org/linux-arm-msm/ab30490c016f906fd9bc5d789198530b@codeaurora.org/#r
> 
> PStore/Ramoops only persists across warm-reboots which is present for chrome
> devices but not for android ones.

Thanks for the info.  Just remind a subtle difference of reboots.

Besides warm reboot, kernel can reboot system after panic (see kernel
command line option `panic`) and watchdog can reboot the system as well.

Even though Android doesn't support warm reboot, system still can reboot
on panic or by watchdog (in particular after bus lockup), pstore/ramoops
also can support these cases.

> Also the dcc_sram contents can
> also be collected by going for a software trigger after loading the kernel
> and the dcc_sram is parsed to get the register values with the
> opensource parser as below
> 
> https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/dcc_parser

To be clear, current driver is fine for me (TBH, I didn't spend much
time to read it but it's very neat after quickly went through it), I
just share some info in case it's helpful for the discussion.

Thanks,
Leo
