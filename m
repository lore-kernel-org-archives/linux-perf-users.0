Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D5AC7EE22
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjEDJdj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEDJdZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 05:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A144AD
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683192757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Br2sdhxJExbXbcqoz/VU+uPPIl2iDyGjIsFcKxJYcBE=;
        b=RrtLX3cuFKxRZD9S0mslS6cAXKjFigKANVJvskN/0Hf59GfxbWluA7n6TRFRDcHsqMU6Jt
        tx1Mw9NKNwps6RKU2u8IixQXeVFJvhpaaPeZ1N7jdiD+btIzEOHdvoVwtCViHumVAGAI7I
        I1XunG5+XGH8JTuy7/a/VA+T2jjULmo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-3KsX3vh9NpeXiUTVUPyekQ-1; Thu, 04 May 2023 05:32:36 -0400
X-MC-Unique: 3KsX3vh9NpeXiUTVUPyekQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30620ebd3c2so102935f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683192754; x=1685784754;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br2sdhxJExbXbcqoz/VU+uPPIl2iDyGjIsFcKxJYcBE=;
        b=hRIie7upyLSEBKIGW3FSB+AXK9+sH4hxS937+DnphvTZuqcVWiigXI/xHju/S4QZ5b
         W4qDilNqdeVxZWiYqofJKggvlyd3Gnz03AMOp1WP4wI7tO8HzXXItiv5Nxr1j6YNwZjX
         WltF3ln+3byAGxk8GCIyJg8+Pau6wCceD62COCMpCxJPfEKOiWdJKmzY9uSF7QgWXu5i
         AmrBjZx4tskWVJ2p6sFtJPcRVrTiZ/IcQQvU9Tb0GufeL1inB8FL3OZhcdpP8cfW9EU+
         HKShNPfSrQKu3INdscsyjKzB4YW63R8U3yb+JjJM1MDk6+SxMNmV6EE4hdi63YHNCujn
         KH9Q==
X-Gm-Message-State: AC+VfDyGOFiwIHr/bk2Evn4KF8lhgq1nQQJ8WtxFHGbWz3mdUbEEtm1S
        teMxO/NQ3D4uGDZk4QO5dNa2Et3n64LT+S11PFtZy+cZ8ZhLsqZAf1o1nT3YrCDT2tVJKq+69ar
        efyBPZj6gwYmH03fNtsX3krJRmyPqBQ==
X-Received: by 2002:a05:6000:1292:b0:304:75b1:4dff with SMTP id f18-20020a056000129200b0030475b14dffmr2679640wrx.48.1683192754409;
        Thu, 04 May 2023 02:32:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lFdaoDN/domYYFl97TJ7iMctTEG96htH3lecWTjBRB0SpQ5yaagyG1HTRY2lhM63g8FCxBg==
X-Received: by 2002:a05:6000:1292:b0:304:75b1:4dff with SMTP id f18-20020a056000129200b0030475b14dffmr2679627wrx.48.1683192754120;
        Thu, 04 May 2023 02:32:34 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm36383284wrx.2.2023.05.04.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 02:32:33 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 2/3] sched/task: Add the
 put_task_struct_atomic_safe() function
In-Reply-To: <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
Date:   Thu, 04 May 2023 10:32:31 +0100
Message-ID: <xhsmha5ykjvbk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04/05/23 10:42, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 08:43:02AM -0300, Wander Lairson Costa wrote:
>> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
>> index b597b97b1f8f..cf774b83b2ec 100644
>> --- a/include/linux/sched/task.h
>> +++ b/include/linux/sched/task.h
>> @@ -141,6 +141,41 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
>>
>>  void put_task_struct_rcu_user(struct task_struct *task);
>>
>> +extern void __delayed_put_task_struct(struct rcu_head *rhp);
>> +
>> +static inline void put_task_struct_atomic_safe(struct task_struct *task)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +		/*
>> +		 * Decrement the refcount explicitly to avoid unnecessarily
>> +		 * calling call_rcu.
>> +		 */
>> +		if (refcount_dec_and_test(&task->usage))
>> +			/*
>> +			 * under PREEMPT_RT, we can't call put_task_struct
>> +			 * in atomic context because it will indirectly
>> +			 * acquire sleeping locks.
>> +			 * call_rcu() will schedule __delayed_put_task_struct()
>> +			 * to be called in process context.
>> +			 *
>> +			 * __put_task_struct() is called when
>> +			 * refcount_dec_and_test(&t->usage) succeeds.
>> +			 *
>> +			 * This means that it can't conflict with
>> +			 * put_task_struct_rcu_user() which abuses ->rcu the same
>> +			 * way; rcu_users has a reference so task->usage can't be
>> +			 * zero after rcu_users 1 -> 0 transition.
>> +			 *
>> +			 * delayed_free_task() also uses ->rcu, but it is only called
>> +			 * when it fails to fork a process. Therefore, there is no
>> +			 * way it can conflict with put_task_struct().
>> +			 */
>> +			call_rcu(&task->rcu, __delayed_put_task_struct);
>> +	} else {
>> +		put_task_struct(task);
>> +	}
>> +}
>
> Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen sink
> has already asked why can't we just rcu free the thing unconditionally.
>
> Google only found me an earlier version of this same patch set, but I'm
> sure we've had that discussion many times over the past several years.
> The above and your follow up patch is just horrible.
>

So on v3/v4 we got to doing that unconditionally for PREEMPT_RT, but per
[1] Wander went back to hand-fixing the problematic callsites.

Now that I'm looking at it again, I couldn't find a concrete argument from
Oleg against doing this unconditionally - as Wander is pointing out in the
changelog and comments, reusing task_struct.rcu for that purpose is safe
(although not necessarily obviously so).

Is this just miscommunication, or is there a genuine issue with doing this
unconditionally? As argued before, I'd also much rather have this be an
unconditional call_rcu() (regardless of context or PREEMPT_RT).

