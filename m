From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Why "perf stat" output more memory load/store counts?
Date: Wed, 11 Mar 2015 10:00:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1503110957400.8554@vincent-weaver-1.umelst.maine.edu>
References: <CA+MhoaMshSNRS1RD0Dq6dXY_XZtEnryfRq6Hvm+Ntf_Gs67h=g@mail.gmail.com> <alpine.DEB.2.11.1503100901230.5471@vincent-weaver-1.umelst.maine.edu> <CA+MhoaNhDCFmgxsRzhOyH1zETvPPjqrkLjOTEGi4OzWSBaaq_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:46643 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbCKN4N (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 11 Mar 2015 09:56:13 -0400
Received: by qgfh3 with SMTP id h3so9971369qgf.13
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2015 06:56:13 -0700 (PDT)
In-Reply-To: <CA+MhoaNhDCFmgxsRzhOyH1zETvPPjqrkLjOTEGi4OzWSBaaq_Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Nan Xiao <xiaonan830818@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, 11 Mar 2015, Nan Xiao wrote:

> Compared with the previous output, the numbers decrease drastically
> (For load instruction: 89,261 vs 1,779,954; store instruction: 12,002
> vs 6,601,675). This time, I think the more load/store instructions
> (70,089,261 vs 70,000,000, 20,012,002 vs 20,000,000) are from bash
> executing the whole command(perf stat -a -e "r81d0:u","r82d0:u"
> ./a):parse the command, fork process, etc.

perf is very careful to only count the actual process you are running, so 
the overhead probably doesn't involve bash in any way.

x86 processors have many sources of overhead/overcount.  if you're really 
interested in the low-level details you can read my ISPASS 2013 paper 
found here:
	http://web.eece.maine.edu/~vweaver/projects/deterministic/deterministic_counters.pdf


Vince
