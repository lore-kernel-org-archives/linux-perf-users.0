Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A9C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 03:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhKWDR3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 22:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhKWDR2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 22:17:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F8C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 19:14:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x7so15488095pjn.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 19:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZZYotC4eIqoU9XqdHzgakvC6HGQGFbjmbFoABjPjqM=;
        b=PM5vca8jzAjbiQMIvW2hqMt1bes/MNmfBEfoUsXSLXcQ0s3NpGm+93hcYoCv2K6Rji
         rxqaJ94szpj6Bkqb9/DpVbcECy2vXVlNEiBbf9swh8Otamtozi8aPuaAzP+uXHvoAGyB
         bjMlYnkCDgYGVxLP+f+IMdZP61Wqmpd1+TczxzPRpv9+XWCsdZjvX6wPiJxciaFYQDj2
         1rTTRZQGz24g983DxX620lHOgZvJbz10j0SDRoZQw0Yb2+MQxIMdDWDmHqljXsxu+CRg
         +Dj/zdMedUrY96oUx36r1VkGSbdVGYy9dfyqHziaOwXdD5VR8Sun60opp837FdAQUzI2
         KPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZZYotC4eIqoU9XqdHzgakvC6HGQGFbjmbFoABjPjqM=;
        b=cUSOd9mcpebMeV1UhHqMjR/ErUBdTYfxekgQZll7SNWxb/yGnKdE1aYkDSwNePA+1c
         fmoboePuseLuoEbOBeDnV+0pQefvPo8MdSWe6LB5WrbJn/Kn1kN4zyNbXV+AlJiAdAwh
         SH5off/2aVZQNOzt0vJ3vuLeMZgkaxaopZFB72uhj82rMRsn/jOmIiiY1+ypqZtjQoQm
         swywZCBnRUJiNwymbz0NqLQFQjO0ACIW1D/0rAopVns4lbE0Bj9k6PXRtUsybtUFXFy4
         mYN+soUBETUCtW0J4qiZH/NJK1IjiHtF0/evMVcQoeq1Jem0+htViM8jXA0Hlqb178hX
         iXZg==
X-Gm-Message-State: AOAM5309kcqyCtSLzZ7fzTo/phuYwXNMZpVMrfdcu4OEBwQuoT/AABLC
        j34+YU+SwRHcCkPeJ+5b92ml+w==
X-Google-Smtp-Source: ABdhPJz5an7ozENnHkj+/Clm6Yd2bnHvpUarAJBUZ+BCr/VeNbx5R9ubu41tl0hNWtoROzV/2XqpiQ==
X-Received: by 2002:a17:90b:3a85:: with SMTP id om5mr2469284pjb.108.1637637261090;
        Mon, 22 Nov 2021 19:14:21 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.242])
        by smtp.gmail.com with ESMTPSA id m10sm3797643pgv.75.2021.11.22.19.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 19:14:20 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:14:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf cs-etm: Pass -1 as pid value for
 machine__set_current_tid()
Message-ID: <20211123031412.GD124250@leoy-ThinkPad-X240s>
References: <20211113143540.53957-1-leo.yan@linaro.org>
 <20211118171412.GB2530497@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118171412.GB2530497@p14s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 18, 2021 at 10:14:12AM -0700, Mathieu Poirier wrote:
> Good morning Leo,
> 
> On Sat, Nov 13, 2021 at 10:35:40PM +0800, Leo Yan wrote:
> > Currently, cs-etm passes the tid value for both tid and pid parameters
> > when calling machine__set_current_tid(), this can lead to confusion for
> > thread handling.  E.g. we arbitrarily pass the same value for pid and
> > tid, perf tool will be misled to consider it is a main thread (see
> > thread__main_thread()).
> > 
> > On the other hand, Perf tool only can retrieve tid from Arm CoreSight
> > context packet, and we have no chance to know pid (it maps to kernel's
> > task_struct::tgid) from hardware tracing data.  For this reason, this
> > patch passes -1 as pid for function machine__set_current_tid().
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index f323adb1af85..eed1a5930072 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1118,7 +1118,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
> >  	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
> >  		return err;
> >  
> > -	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
> > +	err = machine__set_current_tid(etm->machine, cpu, -1, tid);
> 
> I remember wondering about what to do with the pid parameter when I wrote this
> patch... 

Some updates after I digged into the pid parameter for
machine__set_current_tid().

During the recording phase, the perf tool will capture events
PERF_RECORD_COMM and PERF_RECORD_FORK; these events contain pid/tid
for profiled program.  Below is an example for RECORD_FORK/RECORD_COMM
events in perf data file:

  0x89f0 [0x40]: event: 7
  .
  . ... raw event: size 64 bytes
  .  0000:  07 00 00 00 00 20 40 00 59 6d 00 00 59 6d 00 00  ..... @.Ym..Ym..
  .  0010:  5a 6d 00 00 59 6d 00 00 00 00 00 00 00 00 00 00  Zm..Ym..........
  .  0020:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  .  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

  0 0 0x89f0 [0x40]: PERF_RECORD_FORK(27993:27994):(27993:27993)

  0x8a30 [0x38]: event: 3
  .
  . ... raw event: size 56 bytes
  .  0000:  03 00 00 00 00 00 38 00 59 6d 00 00 5a 6d 00 00  ......8.Ym..Zm..
  .  0010:  6d 61 69 6e 00 00 00 00 00 00 00 00 00 00 00 00  main............
  .  0020:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  .  0030:  00 00 00 00 00 00 00 00                          ........

  0 0 0x8a30 [0x38]: PERF_RECORD_COMM: main:27993/27994

In the reporting phase, perf tool will setup threads structure based on
the RECORD_FORK and RECORD_COMM events.  This means perf tool will set
the pid/tid for every thread, e.g. in up case, it allocates thread
context for 'main' program, and its one child thread is setup to
thread->pid_ as '27993' and thread->tid as '27994'.

Afterwards, when perf tool decodes CoreSight trace data and handles
context packet, at the end, machine__update_thread_pid() is invoked
for updating thread's pid:

  machine__update_thread_pid(struct machine *machine,
                             struct thread *th, pid_t pid)
  {
      if (pid == th->pid_ || pid == -1 || th->pid_ != -1)
          return;

      ...
  }

Whatever we pass the pid parameter as tid or '-1' from the caller
function machine__set_current_tid(), it doesn't change anything for the
thread context.  Since th->pid_ has been initialized and its value is
not '-1', no matter what's the pid value is passed via argument,
machine__update_thread_pid() will directly bail out.  This is why
before we pass 'tid' value rather than '-1' for pid, it doesn't cause
any error.

For this reason, this patch doesn't improve anything.  After discussed
with Mathieu offline, I decided to drop this change.  So update the
info in case someone is interested in the relevant info.

Thanks,
Leo
