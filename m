From: Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: profiling Firefox, no perf-<PID>.map file
Date: Sun, 04 Sep 2016 12:50:35 +0200
Message-ID: <1472986235.1802.4.camel@suse.cz>
References: <1472928806.2377.2.camel@suse.cz>
         <3432177.9qbfN6MEYg@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbcIDKu4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Sep 2016 06:50:56 -0400
In-Reply-To: <3432177.9qbfN6MEYg@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

On Sat, 2016-09-03 at 22:37 +0200, Milian Wolff wrote:
> [...]
> 
> You need integration for generating such a file in the JavaScript engine. node 
> and QML are two examples for that. But if you don't want to attribute JIT code 
> addresses to JavaScript code, you can safely ignore this warning.
> 

Right, thanks for pointing it out. It's the VM who's JIT'ing that is
in charge of writing the perf-<PID>.map files.
I've now found the relevant part in Brendan Gregg's perf page describing
this: http://www.brendangregg.com/perf.html#JIT_Symbols
The first time around I read that section it didn't ring a bell,
now I see what the problem is.

Thanks,
Giovanni
