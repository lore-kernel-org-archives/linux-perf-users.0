From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Question to perf spending a large amount of time monitoring a
 java process
Date: Tue, 5 Dec 2017 18:52:58 +0100
Message-ID: <20171205175258.GN3165@worktop.lehotels.local>
References: <20d3fa12-295c-84d3-2eae-aa32b5757d19@huawei.com>
 <87bmjdjcpa.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbdLERxH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Dec 2017 12:53:07 -0500
Content-Disposition: inline
In-Reply-To: <87bmjdjcpa.fsf@linux.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: zhangmengting <zhangmengting@huawei.com>, linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org, jolsa@redhat.com, huawei.libin@huawei.com, cj.chengjian@huawei.com, alexey.budankov@intel.com

On Tue, Dec 05, 2017 at 09:40:01AM -0800, Andi Kleen wrote:
> zhangmengting <zhangmengting@huawei.com> writes:
> 
> > Hi all,
> >
> > I found that perf spends a large amount of time attaching and monitoring
> > a java process with lock, although the execution time of the java process
> > is below 1 minute.
> 
> You could check if this patchkit helps
> 
> https://lkml.org/lkml/2017/9/8/118
> 
> Not sure why it's not moved forward. Peter?

Because its absolutely broken and I don't have had the time to work on
it much. There's a pile of patches here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

that fix the worst of the fallout.
