Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584AAC77B78
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 15:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjEDPZd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDPZa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 11:25:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7717344A9;
        Thu,  4 May 2023 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zX4DJF+PwWblvm+wykuyM69Hc+yDwICH3hfz2Z5YxUA=; b=iagn8V3H/ViU6UBAW3QvY2VDmS
        7r8yQMKFfDEj0r4m+r0l7q2MjBzsIfVtoqz3BQ8FZuJFc9Er+GUhBGPNJJD0B6zsL0FOSdzS2fHsM
        m24nPc2sDAKXt5Sr2hDNH3B3DPrCwvhv2RMqHtIUmoIr7uuobKPxp+uyPMwhVfWwh37LoiB7TB5VU
        5XhaLX30+Nf71mfSgNXZ3Xeul58fwuM7C+oQyHWL8OZzaeMwcHkwy7+SlgDmobgD9m3rx9SnO1idn
        3Mdsih0Iegc28wg9LlmmqRN/hm5Uf3pTPNdoaAtgDuu740bqIonmWEFr7oy0rWyOv5+a5JPQZOa4H
        citVwWUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puaoo-001lOu-20;
        Thu, 04 May 2023 15:24:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E8FC3003CF;
        Thu,  4 May 2023 17:24:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2E2224209FE5; Thu,  4 May 2023 17:24:24 +0200 (CEST)
Date:   Thu, 4 May 2023 17:24:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
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
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <20230504152424.GG1744258@hirez.programming.kicks-ass.net>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com>
 <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 04, 2023 at 11:55:15AM -0300, Wander Lairson Costa wrote:

> > Then I'm thinking something trivial like so:
> >
> > static inline void put_task_struct(struct task_struct *t)
> > {
> >         if (!refcount_dec_and_test(&t->usage))
> >                 return;
> >
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> >                 call_rcu(&t->rcu, __put_task_struct_rcu);
> >
> >         __put_task_struct(t);
> > }
> >
> 
> That's what v5 [1] does. What would be the path in this case? Should I
> resend it as v8?

It's almost what v5 does. v5 also has a !in_task() thing. v5 also
violates codingstyle :-)

But yeah.. something like that.
