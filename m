From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 4/6] perf script: dump software events too
Date: Tue, 1 Mar 2011 16:11:40 +0100
Message-ID: <AANLkTi=jmS80Rs13QiTmdA5iUXvNaSKxQ9Gpp2P2nqRU@mail.gmail.com>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
	<1298865151-23656-5-git-send-email-daahern@cisco.com>
	<AANLkTikwsuBGVfB6uu7=H0jbL+2YbbvX=ea6rLwNP8w-@mail.gmail.com>
	<4D6D004F.5010602@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D6D004F.5010602@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

2011/3/1 David Ahern <daahern@cisco.com>:
> I don't follow what you mean.
>
> This is the same place that tracepoints are dumped. In the
> PERF_TYPE_TRACEPOINT case process_event == print_event which dumps the
> lines to stdout.

No it's not. scripting_ops can be either default_scripting_ops,
perl_scripting_ops
or python_scripting_ops.

Hence process_sample_event() doesn't necessarily ends up pretty print events.
It can also invoke a script that may decide to do what it wants with events.

pretty printing must be an endpoint decision.

> I came in added a switch that invokes a different handler for software
> events. Software events will be processed differently than tracepoint.
> The print_event function and its pretty_print function are not designed
> to dump software events (and eventually hardware events).

Why shouldn't it be designed to dump software events? It's called print_event().
Its current version is rather something I would call "limited". But it
was not designed
to be limited.

Ideally, we should have print_tracepoint_event() in
trace-event-parse.c, print_software_event()
where you want, and have print_event() in builtin-script.c that wraps on those.
