From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: A problem about 'perf sched latency'
Date: Thu, 8 Feb 2018 11:05:53 +0800
Message-ID: <20180208030552.cng3ro72qg3e5uhp@intel.com>
References: <20180206135002.sn32vfqgfz326rcb@intel.com>
 <20180208005724.GB24686@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:1307 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeBHDOe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Feb 2018 22:14:34 -0500
Content-Disposition: inline
In-Reply-To: <20180208005724.GB24686@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, jolsa@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

On Thu, Feb 08, 2018 at 09:57:24AM +0900, Namhyung Kim wrote:
> Hello,
> 
[snip]
> > Does anyone know why? Thank you! :)
> 
> It seems your data doesn't have wakeup event which is required by the
> 'perf sched latency'.
> 
> Thanks,
> Namhyung
> 
Hi Kim,
Thanks for your reply. I thought the 'Swicthes' is the total number of sche-in event.
Now I know it only count wakeup sched-in event. It is not documented, so confused me.

> 
> > 
> > -- 
> > Thanks,
> > Changbin Du
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thanks,
Changbin Du
