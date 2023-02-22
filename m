Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB5C61DA3
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Feb 2023 01:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjBVBoQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBVBoO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Feb 2023 20:44:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44FE2411A
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Feb 2023 17:43:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n5so3798724pfv.11
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Feb 2023 17:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGQR9BKenQJcygCfU4We/diuL+ICMe3u3JE4eZxnrcU=;
        b=pWypUIyIYLmWw8RihuQAkHi2oHJjsldHhOakLOdcwfTzhxMpltnkOLjEovT9mHR95M
         87rkOx7XEx8mREyM+t4VALYocP0g9kmjs24mNsFmJnaW+brJBYjnksTe+OwyCFVAVg/V
         tgrJszaPCZqSWyRDVBWdfhlu8HxB9nZ16OZaHqbjNlb0G12rXRYlldszar1aAb8zEzlG
         TD3xrXX+uTWODTDL+1uwQPpYOEY3CtJ2eRp2NJheLA06V6ckZTb9+0prXq6TQC5ojygA
         F6TtzjCkHkfEz3FhgpnTlnjDC2fC9wF/txbfTGyL+fMu3tYSVPsrgM4mW1r6aUdTiBMz
         brjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGQR9BKenQJcygCfU4We/diuL+ICMe3u3JE4eZxnrcU=;
        b=YW88yFfuF1g/rY480ElY9Ecg7DuO6v/COmMSwcYBqpFveYTM4aKkyW9Q+jwSJI0kvu
         3x2lVdGqscjkQVP7Qh1sHUikjc0WXI90Wz17TlOvO9L/Pj9j698J+tlPKn1SbQ0zncfu
         PLqJc7akTPMirWwqjV/nrDQn2rmggyljVIp1qmOAydyIe4UcE5s5+daFGW4YDXCuBFiE
         UDJwbhyLdooEWX0WblSm4dWuB+s7skhTKCKfgxVxtVZ7VB47dmnagEv2PU56yMYi0MJB
         +NtqhMzZ5lKdoqHwCTb+b49DCsg04oWkRn+0xEqrrN65Bf9z5xDGSaZ3U0AluDoKIy65
         vl5w==
X-Gm-Message-State: AO0yUKVftmRXz7l/IwMvZ5jsBGOv31LyWMYhEcdtmVz6d9T0jrHfBroh
        Me3PZznfPLYP5mXxhxY1fdrW+A==
X-Google-Smtp-Source: AK7set9braK4Z+1AEc8yI0Oqim+6ZGLIF5SWXXwtrKp43LARv7YLBrTQQtInIGw/nL1RMThOmJmWRg==
X-Received: by 2002:a62:5290:0:b0:596:15de:ea1e with SMTP id g138-20020a625290000000b0059615deea1emr6648555pfb.9.1677030226002;
        Tue, 21 Feb 2023 17:43:46 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-211-66.hinet-ip.hinet.net. [211.23.211.66])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b00587fda4a260sm1875612pfh.9.2023.02.21.17.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:43:45 -0800 (PST)
Date:   Wed, 22 Feb 2023 09:43:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <andersson@kernel.org>, arm <arm@kernel.org>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
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
Message-ID: <Y/VzRJzxkPm3l0Km@leoy-yangtze.lan>
References: <20230126163008.3676950-1-andersson@kernel.org>
 <cdcff86c-77fe-4c5d-b8e8-58b815b9e969@app.fastmail.com>
 <20230130222412.t2tkkhqfep2orxf2@builder.lan>
 <9b680581-0956-4188-9af9-af06b625c001@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b680581-0956-4188-9af9-af06b625c001@app.fastmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 15, 2023 at 04:05:36PM +0100, Arnd Bergmann wrote:

[...]

> > To my knowledge the hwtracing framework is an interface for
> > enabling/disabling traces and then you get a stream of trace data out of
> > it.
> >
> > With DCC you essentially write a small "program" to be run at the time
> > of an exception (or triggered manually). When the "program" is run it
> > acquire data from mmio interfaces and stores data in sram, which can
> > then be retrieved - possibly after the fatal reset of the system.
> >
> > Perhaps I've misunderstood the hwtracing framework, please help me steer
> > Souradeep towards a subsystem you find suitable for this functionality.
> 
> I'm also not too familiar with tracing infrastructure and was hoping
> that the coresight maintainers (Mathieu, Suzuki, Mike and Leo)
> would have some suggestions here. My initial guess was that in
> both cases, you have hardware support that is abstracted by the
> kernel in order to have a user interface that can be consumed
> by the 'perf' tool.

My understanding is hwtracing provides a common framework for STM so
that different tracing IPs (like Intel_th and Arm CoreSight) can
register STM module into this framework.  The framework code is placed
in: linux/drivers/hwtracing/stm.

Now kernel doesn't provide a general framework for all hardware tracing
IPs, e.g. Arm CoreSight has its own framework to manage tracing
components and creating links with sinks.

Simply to say, we can place DCC driver in linux/drivers/hwtracing folder
(like Hisilicon's ptt driver), but we have no common framework for it to
use.

Based on reading DCC's driver, seems to me it's more like a bus tracing
module rather than a uncore PMU.  I found the driver does not support
interrupt, I am not sure this is a hardware limitation or just software
doesn't implement the interrupt handling, without interrupt, it would be
difficult for using DCC for profiling.

If we register DCC into perf framework, the good thing is DCC can use
perf framework (e.g. perf's configs) as its user space interface, but
it's still not clear for me how to capture the DCC trace data (no
interrupt and not relevant with process task switching).

[...]

> If the possible use is purely for saving some state across
> a reboot, as opposed to other events, I wonder if there is
> a good way to integrate it into the fs/pstore/ code, which
> already has a way to multiplex various kinds of input (log
> buffer, ftrace call chain, userspace strings, ...) into
> various kinds of persistent buffers (sram, blockdev, mtd,
> efivars, ...) with the purpose of helping analyze the
> state after a reboot. 

Good point!

I understand pstore/ramoops is somehow like a sink which routes the
tracing data (software tracing data but not hadware tracing data) to
persistent memory.  This is why we also can route these software
tracing data to STM (hardware sink!).

Seems to me, Arnd suggests to connect two sinks between DCC and
pstore (to persistent memory).  But I cannot give an example code in
kernel for doing this way, sorry if I miss something.

Essentially, a good user case is to keep a persistent memory for the
tracing data, then after rebooting cycle we can retrieve the tracing
data via user space interface (like sysfs node).

Thanks,
Leo
