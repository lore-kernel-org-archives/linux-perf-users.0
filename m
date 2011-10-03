From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Profiling sleep times?
Date: Mon, 03 Oct 2011 22:17:07 +0200
Message-ID: <1317673027.20367.41.camel@twins>
References: <4E8A0F53.7020408@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56855 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757232Ab1JCUSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Oct 2011 16:18:54 -0400
In-Reply-To: <4E8A0F53.7020408@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>

On Mon, 2011-10-03 at 12:38 -0700, Arun Sharma wrote:
>                          trace_sched_stat_sleep(tsk, delta);

That one should be accessible as a tracepoint and will add delay to
count on each occurrence. 
