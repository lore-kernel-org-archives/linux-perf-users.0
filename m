From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: How do the software events work in perf?
Date: Tue, 23 Jul 2013 01:51:24 +0200
Message-ID: <CAFTL4hz1u3dvAJZmSLGg6C9p9A=+dxYZ6JUYwVPbOB3_uEiu6g@mail.gmail.com>
References: <CAEuYUeofoxasfFS+_oXggXEK5jDKz5S-z0_8Nt6r3bf+J7yE_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:42529 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab3GVXv0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 19:51:26 -0400
Received: by mail-lb0-f180.google.com with SMTP id t13so191952lbd.25
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2013 16:51:25 -0700 (PDT)
In-Reply-To: <CAEuYUeofoxasfFS+_oXggXEK5jDKz5S-z0_8Nt6r3bf+J7yE_w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

2013/7/23 Peipei Wang <wangpeipei.90@gmail.com>:
> Hi guys,
> I am curious about how perf get the software events. While hardware
> events are defined and can be found in architecture manuals, I don't
> get any information or documentation about how perf get the software
> events, or how they are collected.
>
> Thanks for your help.

Hi,

They are implemented using tracepoints. To summarize, tracepoints are callbacks
that are called on any interesting point in the code.

For example in the context switch path we have a function call
trace_sched_context_switch() that in turn calls a callback that then
rely into the perf events susbsystem to record the event in the
buffer.

In practice it is a bit more complicated, there is a layer in the
middle with the trace events subsystem.

For more details on tracepoints: Documentation/tracepoints.txt and
Documentation/events.txt

But really, this is just about function calls that we put when we find
some interesting code to trace. Like a very enhanced printk() :)
