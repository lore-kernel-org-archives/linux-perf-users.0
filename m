From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: How to check perf commands are producing proper output or not?
Date: Fri, 28 Jan 2011 11:48:11 -0200
Message-ID: <20110128134811.GB6345@ghostprotocols.net>
References: <AANLkTikZc4L=-xzmOvqLC00qNHLuqCBOdcD3hofBNfFN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34928 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab1A1NsR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Jan 2011 08:48:17 -0500
Received: by gwj20 with SMTP id 20so1076392gwj.19
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jan 2011 05:48:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikZc4L=-xzmOvqLC00qNHLuqCBOdcD3hofBNfFN@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: nelakurthi koteswararao <koteswararao18@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Jan 28, 2011 at 05:49:00PM +0530, nelakurthi koteswararao escreveu:
>    I run the Perftest commands on 2.6.35 tree .
>    I want to test perf commands itself whether
>    they are producing the correct results or not.
>     
>    That means..suppose if i have following perf commands
>     
>    How to write test to test the above commands whether they are producing
>    the proper results specific to perf commands or not?
>     
>    Some tests like checking the processor registers at regular intervals to
>    validate
>    the perf results ? Any inputs regarding this query...?

That is a good question, we need more tests in tools/perf/builtin-test.c
that do this kinds of validations.

So far I wrote some that generate tracepoint events, but I can envision
for instance, figuring out the size of the L2 processor cache, creating
an array that is of that size, then go on touching it till it trashes
the cache while measuring the relevant event.

- Arnaldo
