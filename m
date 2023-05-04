Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FDC77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjEDOeK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEDOeI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 10:34:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36764ECF;
        Thu,  4 May 2023 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2q1Na0yWnrxCd8vbOMPYz/xcczauSqn9EWcowSr4XIc=; b=wY435xR4+CwjWJ9LFIuoGNLvka
        dWhDGn6W86+Jw2I/OQeFmzzO0qD+fBbP3yVQp0sM1CR/teYcmmDcgl7GBOFKOQSHTENMB5bmM3GPp
        zVXmNn67yldM41vjaysbtH01Jhot9+lcxiJpmEEhjAZpKMxYdveWf/j9OvdjJmGK+WjIPMlmWLl5p
        9gBS9h/QsBg8D94BHw1CiWsHknlJbHfMrvSqAysHP7kQCKIGSdlDc8TyClJ5j+ReW3CcVrqSXHJNi
        usjNCB2JInauUpoRSS90LDcX1yVTo/OQaMomlLTol0RXpWSIqneB3B2GKMu6IMpj4k+RiS5+PwaTC
        xu4uxQFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pua15-00Afz2-Ky; Thu, 04 May 2023 14:33:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 807333002A3;
        Thu,  4 May 2023 16:33:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0432B263B6381; Thu,  4 May 2023 16:33:03 +0200 (CEST)
Date:   Thu, 4 May 2023 16:33:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
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
Message-ID: <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504122945.GA28757@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 04, 2023 at 02:29:45PM +0200, Oleg Nesterov wrote:
> On 05/04, Peter Zijlstra wrote:
> >
> > Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen sink
> > has already asked why can't we just rcu free the thing unconditionally.
> >
> > Google only found me an earlier version of this same patch set, but I'm
> > sure we've had that discussion many times over the past several years.
> 
> Yes... see for example
> 
> https://lore.kernel.org/lkml/CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com/
> 
> We already have an rcu pass before put_task_struct(zombie), see
> put_task_struct_rcu_user(), another one look unfortunate.

Ah indeed, it got mentioned there as well. And Linus seems to be arguing
against doing an rcu free there. So humm..

Then I'm thinking something trivial like so:

static inline void put_task_struct(struct task_struct *t)
{
	if (!refcount_dec_and_test(&t->usage))
		return;

	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
		call_rcu(&t->rcu, __put_task_struct_rcu);

	__put_task_struct(t);
}

should do, or alternatively use irq_work, which has a much lower
latency, but meh..
