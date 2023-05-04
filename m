Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC92C7EE21
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEDTYG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEDTYF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 15:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6A7AA9
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683228199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFbEcKjEgJv3LtDT74dBDeEmFhugrifR5vJkWRmgzQU=;
        b=T8t5m3rVub9Ky7u4zHEmiMbL3zLAgAbQBM4TwdrBAsFko1uqDegGs3+CqqjBnECpTK1bBh
        qcSS6IYlAq3fPh/uQGJWV8SN9Cm+rzK0HdzP2xNlv4GwvBQsesfIO1q8FxQO8HiRiq/o6R
        hCCMMPMdx4sIV/TtDZ1MN4/0ygYw7Zk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-qpEGbL5kMAaJrY1g8mktYw-1; Thu, 04 May 2023 15:23:17 -0400
X-MC-Unique: qpEGbL5kMAaJrY1g8mktYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763C110AFA77;
        Thu,  4 May 2023 19:23:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7CC171121339;
        Thu,  4 May 2023 19:22:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  4 May 2023 21:22:54 +0200 (CEST)
Date:   Thu, 4 May 2023 21:22:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20230504192246.GA4164@redhat.com>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com>
 <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152306.GA1135@redhat.com>
 <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 05/04, Wander Lairson Costa wrote:
>
> On Thu, May 4, 2023 at 12:23 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Yes, but as Sebastian explained CONFIG_PROVE_RAW_LOCK_NESTING won't like it.
> >
> >         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/
> >
> 
> I think that was my confusion in that thread. My understanding is that
> CONFIG_PROVE_RAW_LOCK_NESTING will check lock ordering but not
> context.

Sorry, I don't understand... perhaps I missed something. But iiuc
the problem is simple.

So, this code

	raw_spin_lock(one);
	spin_lock(two);

is obviously wrong if CONFIG_PREEMPT_RT.

Without PREEMPT_RT this code is fine because raw_spinlock_t and spinlock_t
are the same thing. Except they have different lockdep annotations if
CONFIG_PROVE_RAW_LOCK_NESTING is true, LD_WAIT_SPIN and LD_WAIT_CONFIG.

So if CONFIG_PROVE_RAW_LOCK_NESTING is set, lockdep will complain even
on the !PREEMPT_RT kernel, iow it checks the nesting as if the code runs
on with PREEMPT_RT.

Cough... not sure my explanation can help ;) It looks very confusing when
I read it.

Oleg.

