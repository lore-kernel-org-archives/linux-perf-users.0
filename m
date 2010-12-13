From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 12:15:11 -0700
Message-ID: <4D0670BF.6050403@cisco.com>
References: <20101213170923.GB1691@nowhere> <1292260289.6803.297.camel@twins> <20101213171537.GC1691@nowhere> <1292260699.6803.305.camel@twins> <20101213172216.GB7417@ghostprotocols.net> <1292261716.6803.332.camel@twins> <1292262433.6803.351.camel@twins> <4D065CB2.7050104@cisco.com> <1292263024.6803.370.camel@twins> <4D065F69.7080707@cisco.com> <20101213190831.GA7984@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101213190831.GA7984@ghostprotocols.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


> We have:
> 
> [acme@mica linux]$ perf list | grep -- -clock
>   cpu-clock                                  [Software event]
>   task-clock                                 [Software event]
> [acme@mica linux]$ 
> 
> So we would have a new one:
> 
>   monotonic-clock

Name seems off. The 'event' is to grab time-of-day and have the 'time'
attribute set which gives the correlation between wall-clock and perf
timestamps.

David

> 
> Peter, agreed? I'll try to implement it now, good opportunity to learn a
> bit more about soft pmus, I'd have to do that anyway for NIC stats, etc.
> 
> - Arnaldo
