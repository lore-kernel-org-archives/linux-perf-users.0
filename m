From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: attr inherit vs inherit_stat
Date: Tue, 04 Sep 2012 15:55:15 +0900
Message-ID: <871uiie0q4.fsf@sejong.aot.lge.com>
References: <alpine.DEB.2.00.1208071544240.16260@cl320.icl.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:44978 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2IDHCq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Sep 2012 03:02:46 -0400
In-Reply-To: <alpine.DEB.2.00.1208071544240.16260@cl320.icl.utk.edu> (Vince
	Weaver's message of "Tue, 7 Aug 2012 15:47:32 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vweaver1@eecs.utk.edu>
Cc: linux-perf-users@vger.kernel.org

On Tue, 7 Aug 2012 15:47:32 -0400, Vince Weaver wrote:
> Hello

Hello Vince,

>
> I'm trying to figure out the difference between the "inherit" and
> "inherit_stat" bitfields in the perf_event_attr structure.
>
> Both seem to have similar functionality, and the code in core.c
> is hard to follow.
>
> Does anyone have any idea?

AFAIK the "inherit" field determines whether the event is inherited to a
child process/thread.  The "inherit_stat" is only meaningful when the
"inherit" field is also set and it'll preserve (saved) event counts
between context switch of the inherited processes/threads.

Thanks,
Namhyung
