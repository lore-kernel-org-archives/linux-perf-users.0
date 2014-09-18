From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 14:39:24 -0600
Message-ID: <541B42FC.5000105@gmail.com>
References: <2221771.b2oSN5LR6X@milian-kdab2> <2297882.Vc1x1zOfA6@milian-kdab2> <20140918155745.GH2770@kernel.org> <45528931.El8SOGvs6Z@milian-kdab2> <20140918191713.GK2770@kernel.org> <541B3DED.1010306@gmail.com> <20140918203625.GM2770@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63273 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069AbaIRUjh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 16:39:37 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so2131078pde.12
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2014 13:39:37 -0700 (PDT)
In-Reply-To: <20140918203625.GM2770@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On 9/18/14, 2:36 PM, Arnaldo Carvalho de Melo wrote:
> I'm just trying to figure out if what people want is a complete
> backtrace of all threads in a process, no matter what they are doing, at
> some given time, i.e. at "sysrq-t" time, is that the case?

I think so. That's what poor-man's profiler is doing -- attach gdb every 
N seconds, dump stack. In perf terminology generate a sample and include 
the callchain.

David
