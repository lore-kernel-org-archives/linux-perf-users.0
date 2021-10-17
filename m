Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28073C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Oct 2021 06:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DE560FED
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Oct 2021 06:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbhJQGPW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Oct 2021 02:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhJQGPW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Oct 2021 02:15:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA49C061765
        for <linux-perf-users@vger.kernel.org>; Sat, 16 Oct 2021 23:13:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d9so4928659pfl.6
        for <linux-perf-users@vger.kernel.org>; Sat, 16 Oct 2021 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iiUsb1cE83ywvQV5UZip8b5x2e5QmVrvVvAWD2Go4Y4=;
        b=pboFRXlb0KKncS2ZrsAk+9ZB5kxQRMHoxlxYAzMx4lsP46bbwVtO53gUaGKwMZpx0D
         jJx9bvq7i6K/Lm1PTF0EIduKK3ThC5ybFGY1YUn3N4NW9SYXBHN6VHx/qjMCHX+vFl00
         OV2Jnm7/jGpMBxQyAoZ7kWu6pkZawvpP1u7LLYawfHy+Y55BdTreHhwo8M8hfkYPC0ez
         fWC3iSSORsKpdaNiONw7tKHQz6Vg2ki0V2YHwiE6DDNJgJA5k0oYI92BuWWGtuWTujEG
         C+PJU0PeXPadgAo0NaQvikRWRl8d+SeGl9dESdWvbsNZDc5Ln3xINxQocTtCFTGNEYYn
         NFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iiUsb1cE83ywvQV5UZip8b5x2e5QmVrvVvAWD2Go4Y4=;
        b=5BGSEcBAPFP8L0SDj4giB32leF1CKFQ4t0rsq+hPDRQznQ6JhjvMTV00g4LvyevIj6
         p0hRJJ9FrX78tU4VSINQM+x6Ip9ukeO6qstKwQjcrkZQFqtN9pWNHdiZk/tKDB/mJulk
         szISd45aQYKQ7AumwHEQQwsP77ybTsDRkMm/VFWz2bjlt4ial7dJ2AaCSSEWzFOpt3WZ
         pZxk7O/cH+8DIGA4RqZjE62K0/x6zkN8KBOB/5VtyU2W1+4hxWS1kbJOhx7SN6OCwa/u
         Q9zADZZtJpT66UGBm+8/gddN/EbwWNEAtS7DfWJUPLEpDNp1M3uksjz/ytXXkMKkR26v
         ozXQ==
X-Gm-Message-State: AOAM531XGviShllQ9HTdyMQs+F4V/T9uCNSGoVU3lVW87DQa0ut0gF/D
        s0K8M12a6aBVMvlhx/M/+Xtwiw==
X-Google-Smtp-Source: ABdhPJzsRT0SFzj4MgkUfEIo67XCx2S5g/JamGuwvAezJlXAtsat0nvEG/E7ygf9ilSFmx4306508g==
X-Received: by 2002:a65:6658:: with SMTP id z24mr17463560pgv.266.1634451192461;
        Sat, 16 Oct 2021 23:13:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id z11sm15833174pjl.45.2021.10.16.23.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 23:13:11 -0700 (PDT)
Date:   Sun, 17 Oct 2021 14:13:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211017061305.GA130233@leoy-ThinkPad-X240s>
References: <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
 <20211013075125.GA6701@willie-the-truck>
 <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German, Will,

On Fri, Oct 15, 2021 at 01:33:39PM +0100, German Gomez wrote:

[...]

> $ ./perf record -vvv -e arm_spe/period=148576/u -S1000 -m16,16 -- taskset --cpu-list 0 stress --cpu 1 &

When testing Arm SPE snapshot mode with the command (it's quite
similiar with up command but not exactly same):

# ./perf --debug verbose=3 record -e arm_spe/period=148576/u -C 0 -S1000 -m16,16 \
    -- taskset --cpu-list 0 stress --cpu 1 &
# kill -USR2 [pid_num]

... then I wait for long time and didn't stop the perf program, then
I observed the output file contains many redundant events
PERF_RECORD_AUX.  E.g. in the shared perf data file [1], you could use
below commands to see tons of the events PERF_RECORD_AUX which I only
send only one USR2 signal for taking snapshot:

  # perf report -D -i perf.data --stdio | grep -E 'RECORD_AUX' | wc -l
  2245787

  # perf report -D -i perf.data --stdio | grep -E 'SPE'
  . ... ARM SPE data: size 0x3e8 bytes
  Binary file (standard input) matches

I looked into the Arm SPE driver and found it doesn't really support
free run mode for AUX ring buffer when the driver runs in snapshot
mode, the pair functions perf_aux_output_end() and
perf_aux_output_begin() are invoked when every time handle the
interrupt.  The detailed flow is:

  arm_spe_pmu_irq_handler()
    `> arm_spe_pmu_buf_get_fault_act()
         `> arm_spe_perf_aux_output_end()
              `> set SPE registers
              `> perf_aux_output_end()
    `> arm_spe_perf_aux_output_begin()
         `> perf_aux_output_begin()
         `> set SPE registers

Seems to me, a possible solution is to add an extra parameter 'int
in_interrupt' for functions arm_spe_perf_aux_output_end() and
arm_spe_perf_aux_output_begin(), if this parameter is passed as 1 in
the interrupt handling, these two functions should skip invoking
perf_aux_output_end() and perf_aux_output_begin() so can avoid the
redundant perf event PERF_RECORD_AUX.

  arm_spe_pmu_irq_handler()
    `> arm_spe_pmu_buf_get_fault_act()
         `> arm_spe_perf_aux_output_end(..., in_interrupt=1)
              `> set SPE registers
    `> arm_spe_perf_aux_output_begin(..., in_interrupt=1)
         `> set SPE registers

P.s. I think Intel-PT has supported free run mode for snapshot mode,
so it should not generate interrupt in this mode.  Thus Intel-PT can
avoid this issue, please see the code [2].

Thanks,
Leo

[1] https://people.linaro.org/~leo.yan/spe/snapshot_test/perf.data
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/pt.c#n753
