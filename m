From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: attr inherit vs inherit_stat
Date: Thu, 6 Sep 2012 11:19:21 -0400
Message-ID: <alpine.DEB.2.00.1209061116560.10268@cl320.icl.utk.edu>
References: <alpine.DEB.2.00.1208071544240.16260@cl320.icl.utk.edu> <871uiie0q4.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:14263
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752895Ab2IFPTd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Sep 2012 11:19:33 -0400
In-Reply-To: <871uiie0q4.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org

On Tue, 4 Sep 2012, Namhyung Kim wrote:
> 
> AFAIK the "inherit" field determines whether the event is inherited to a
> child process/thread.  The "inherit_stat" is only meaningful when the
> "inherit" field is also set and it'll preserve (saved) event counts
> between context switch of the inherited processes/threads.

Thank you for taking the time to answer!

I'm still trying to construct a test case that shows the difference but 
I'm failing.

Aren't the stats *always* saved on context switch?

Does this affect what happens when you read the perf_event fd in the 
inherited threads, or only from the master thread?

What is the expected behavior if you set inherit_thread but do not set 
inherit?

Thanks for any clarifications you can provide,

Vince
