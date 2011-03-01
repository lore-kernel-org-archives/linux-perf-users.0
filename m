From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 4/6] perf script: dump software events too
Date: Tue, 01 Mar 2011 09:11:20 -0700
Message-ID: <4D6D1AA8.4060809@cisco.com>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>	<1298865151-23656-5-git-send-email-daahern@cisco.com>	<AANLkTikwsuBGVfB6uu7=H0jbL+2YbbvX=ea6rLwNP8w-@mail.gmail.com>	<4D6D004F.5010602@cisco.com> <AANLkTi=jmS80Rs13QiTmdA5iUXvNaSKxQ9Gpp2P2nqRU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:13572 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab1CAQLG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 11:11:06 -0500
In-Reply-To: <AANLkTi=jmS80Rs13QiTmdA5iUXvNaSKxQ9Gpp2P2nqRU@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de



On 03/01/2011 08:11 AM, Frederic Weisbecker wrote:
> 
> Why shouldn't it be designed to dump software events? It's called print_event().
> Its current version is rather something I would call "limited". But it
> was not designed
> to be limited.

That's because its origins are trace specific. Per last week's thread,
perf-script was perf-trace until Nov 2010. perf-script deals with
tracepoints.

> 
> Ideally, we should have print_tracepoint_event() in
> trace-event-parse.c, print_software_event()
> where you want, and have print_event() in builtin-script.c that wraps on those.


process_event does not take the event sample, it takes elements of it:

struct scripting_ops {
...
    void (*process_event) (int cpu, void *data, int size,
                   unsigned long long nsecs, char *comm);
...
};


David
