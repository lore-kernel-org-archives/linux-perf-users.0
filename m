From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: How does perf collects stats for L1/L2 cache events
Date: Fri, 23 Aug 2013 13:23:55 -0300
Message-ID: <20130823162355.GA1895@ghostprotocols.net>
References: <CAD15agZimrkEsYi12oQRSCjTvNaXd9rFzrPE=tRBkqJiASUJ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:46495 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab3HWQYE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Aug 2013 12:24:04 -0400
Received: by mail-yh0-f43.google.com with SMTP id z20so194599yhz.30
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Aug 2013 09:24:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAD15agZimrkEsYi12oQRSCjTvNaXd9rFzrPE=tRBkqJiASUJ=A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ritesh Harjani <ritesh.harjani@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, Michael Ellerman <michael@ellerman.id.au>, Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

Em Fri, Aug 23, 2013 at 04:21:00PM +0530, Ritesh Harjani escreveu:
>    Hi folks,
> 
>    I have some following  queries on perf:
> 
>    1. how does perf collect L1/L2 cache events on various architectures?

PMU counters.
 
>    2. My question might be specific to ARM architecture as well, does perf
>    collects the stats of cache events based on PMU counter in ARM processor ?

yes

>    If no, could some one please tell, how does perf collects this data  ?
> 
>    3. And how about rest of the architectures ?

PMU counters. Look at arch/

>    4. Also, If possible could someone please guide to that piece of code(
>    where cache events stats are collected ) in tools/perf/ ?

Start at arch/arm, I hadn't looked, but did a quick scan now with:

[acme@zoo linux]$ find arch/arm/ -name "*perf*"

- Arnaldo
