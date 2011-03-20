From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] perf events: add support for realtime clock
 attribute
Date: Sun, 20 Mar 2011 20:08:10 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1103202000500.2787@localhost6.localdomain6>
References: <1300647277-8431-1-git-send-email-daahern@cisco.com> <1300647277-8431-2-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:37234 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab1CTTIi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 20 Mar 2011 15:08:38 -0400
In-Reply-To: <1300647277-8431-2-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org

On Sun, 20 Mar 2011, David Ahern wrote:
> +
> +	if (sample_type & PERF_SAMPLE_REALTIME)
> +		data->realtime = ktime_to_ns(ktime_get_real());

That's going to live lock on any sample which happens to hit in a
xtime_lock write locked section. I knew why I suggested adding
tracepoints to the timekeeping code :)

Thanks,

	tglx
