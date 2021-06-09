Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F11C4743D
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 01:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33CB61027
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 01:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFIBiN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 21:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhFIBiL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 21:38:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB2C061574
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Jun 2021 18:36:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so420603pjj.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Jun 2021 18:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ADGx8I2KcMDPVSoVByCVW4+6HsQLP6CKmqo+BRHHLzc=;
        b=O+J6P1Rm38MQriGs607fNK5W+OdHQ4cnplN9ZC+kswm45I0FvLSINUD4YuTrE3bHPO
         DOSS5CN/52sj2+kIkVA5oBqiVuPVSjuqBkdy6MCmI2LIk88GwHE/M9kW+N73hPEdPK3C
         nfNMpryWJvk5RHX6TxS/oc3tYATk6yukvu3G5Ju9bzee56fWpAfvWFx7obzmnhBSwwu9
         uAvhwg8PzWHqSyVV8OcZiQH/IWrvCO/IL67KDKy14QHWZIMsCdeSNUPFNpL2qFUuTzy/
         wpv9XnhIA0yLmWlcGbmx6KhNZCaxVOZDiJ/oAyxdD3lsZpKjVADEkWKb86/TZKTk+9Wj
         isJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADGx8I2KcMDPVSoVByCVW4+6HsQLP6CKmqo+BRHHLzc=;
        b=TKJi4JaGLQGEL9fzCE5marFhbYFTkBsF6DJTyxOHZFBCEj/fUOAnuGPlCQX5K2GlBC
         co2n+qkfTbjdHUZqLvLQw1xmCWGGE3DAXOY4/vHjk/mcVVZbwKE+/DLd+Q9kGISpQ6ts
         d2clbAQvglIptrt/6hNCx5tX/M74RB69kbh3p0o+VI/bbXJXEShrxW7jhdJfvtQD757l
         PTz3h5GVXU65K2I4FeG993eCErxjNE1qFjQuCL9Ropmjj24PaKW1ZaYqPhnEP8F1tiAO
         SBSHx2BjL9Oi7GT9uQ0U3DQkxBQVlyngj8YbphT+zBNpNucOr9EL+MA0FX6rBLbUk/iw
         ou0Q==
X-Gm-Message-State: AOAM5338gbXn1U5wPnp7Nz4aepNFc13k2NDCj6kfZrXB04epSKONTzV+
        bYAVUfOmrKuvLrp706s1u3ANvg==
X-Google-Smtp-Source: ABdhPJzMBGCVS1q9skbi2XatNkAp/tRgKA6BSqDd8okbKfPzx7mA8R7I60UbR1xs0xRDqhAfmguNOQ==
X-Received: by 2002:a17:902:e302:b029:110:994a:abb7 with SMTP id q2-20020a170902e302b0290110994aabb7mr2972334plc.53.1623202562643;
        Tue, 08 Jun 2021 18:36:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id w63sm11968095pfw.153.2021.06.08.18.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:36:02 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:35:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
Message-ID: <20210609013555.GD4640@leoy-ThinkPad-X240s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
 <20210608214149.GA331611@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608214149.GA331611@p14s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 08, 2021 at 03:41:49PM -0600, Mathieu Poirier wrote:
> On Sat, May 29, 2021 at 12:15:50AM +0800, Leo Yan wrote:
> > The perf tool records the Arm CoreSight trace data with snapshot mode
> > with the option '-S', when receiving USR2 signal, it is observed the
> > captured trace data size is very varied: from several MBs to ~20MBs.
> > This can be reproduced with the command:
> > 
> >   perf record -e cs_etm// -S \
> > 	-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
> >   PERFPID=$!
> >   sleep 1
> >   kill -USR2 $PERFPID
> > 
> > It's different for only specifying option '-S' than options '-a -S'.  If
> > without option '-a', perf tool creates separate AUX buffers for every
> > CPU, but the tracer will be enabled only when the profiled program is
> > scheduled onto the corresponding CPU, this might lead to record very
> > old trace data when snapshot.
> 
> I'm very perplexed by this paragraph...  The '-a' option means tracing on all
> CPUs, which will definitely allocate an AUX buffer per CPU.

Sorry for confusion.  We can understand the mechanism based on two factors:
one factor is AUX buffer allocation (per CPU or single AUX buffer
shared by all CPUs), another factor is what's the occasion to enable tracers.

If with only option '-a -S', as you said, perf allocates an AUX buffer per CPU.
And it always enable ETMs for all CPUs.

If with option '-S', perf also allocates an AUX buffer per CPU, but
it's different for enabling tracers from the option '-a -S';  in this
case, perf works like per-thread mode, the tracer (ETM) is only enabled
when the profiled process is scheduled on a specific CPU.  e.g. when
the task is scheduled on CPU2, then the ETM attached to CPU2 is
enabled for tracing.

> > Let's see below diagram:
> >                                                             snapshot
> >   CPU0: ______###P1###__________________________________________|
> >   CPU1: __________________________###P3###____________###P5###__|
> >   CPU2: ____________________________________###P4###____________|
> >   CPU3: ________________###P2###________________________________V
> > 
> > In this diagram, the program runs for 5 periods (from P1 to P5), these 5
> > periods show the task run on different CPUs, e.g. during P1 period the
> > program runs on CPU0, and during P2 period the program is migrated to
> > CPU1, and so on.  At the end of P1 period when the program is switched
> > out from CPU0, the ETR trace data is saved into AUX trace buffer, this
> > AUX buffer is a dedicated buffer for CPU0's tracer.  With the same
> > logic, P2's trace data is saved into CPU3's tracer buffer, P4's trace
> > data is saved into CPU2's buffer, P3 and P5's trace data is saved into
> > CPU1's.  Therefore, when snapshot, it saves the trace data from all AUX
> > ring buffers (in this case, it have total 4 AUX ring buffers) into perf
> > data file.
> >
> 
> When a snapshot happens and if the event is currently active, traces
> accumulated since the event was _installed_ on the CPU will be copied from the
> coresight buffer to the AUX buffer.  Trace data accumulated in other buffers will
> already have been copied when the event was scheduled out.

Yes.

> I *think* what is happening here is that if P5 was still active when the
> snapshot occurs, we would get trace data from P3 and P5, and not P4.  Is my
> understanding correct?

No, in current code, when the snapshot occurs, we get trace data from
P1 to P5.

Keep in mind that the AUX ring buffer and CoreSight's bounce buffer are
allocated per CPU.  So P1 trace data is stored into AUX buffer 0, P3 and
P5 trace data is stored in AUX buffer 1, and so on.

When the snapshot is taken, it iterates the AUX buffers one bye one
from buffer 0 to buffer 3, see the function
record__auxtrace_read_snapshot_all() in the perf source file builtin-record.c.
Since every AUX buffer contains the trace data, so P1 to P5's trace
data will be recorded into perf data file.

> > This is why we can see varied trace data size, it's quite dependent on
> > the task scheduling on CPUs, if the task is spinned to only one CPU and
> > without scheduling out, it will only record trace data from only one
> > AUX trace buffer.  If the task is frequently scheduled in and out, then
> > it gives more chance to fill trace data into the AUX buffer.
> > 
> > In this example, it also causes the discontinuous trace data.  If P3's
> > trace data is lost after P5's trace data overwrites the AUX trace data,
> > thus perf tool fails to record continuous trace data if only have
> > trace data for P1/P2/P4/P5.
> > 
> > For snapshot mode, usually the user only wants to capture the trace data
> > for the specific time point and prior to the that point the tracer
> > should work with free run mode.  This means it's not necessary to
> > capture trace data for task's scheduling in and out until the perf tool
> > explicitly disables tracers for snapshot.  This can be fulfilled by
> > checking the variable "event->ctx->is_active", when the task is
> > scheduled out this variable is set to zero, and when snapshot this
> > variable is still non-zero value.  So the driver can only record trace
> > data only when "event->ctx->is_active" is non-zero.
> 
> The problem with this approach is that if the AUX buffer is 4MB and the CS
> buffer is 1MB then we only record 1MB, but because of N:1 topologies we may not
> be able to do better.  I haven't looked at the code yet, something I will do
> tomorrow.

Yes, the fixing in this patch copies the trace data is limited by the
CoreSight bounce buffer length.  So if CoreSight buffer length is
1MiB, then we have no chance to allocate 4MiB for AUX buffer.

Seems to me, it's unlikely that we have the AUX buffer with 4MiB and
CoreSight bounce buffer with 1MiB.  I read the function
tmc_alloc_etr_buffer(), in most case, the AUX buffer size and
CoreSight bounce buffer size is consistent.

If have any furter questions, just let me know.  Thanks for reviewing.

Leo
