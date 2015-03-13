From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Re: Why "perf stat" output more memory load/store counts?
Date: Fri, 13 Mar 2015 08:25:09 +0800
Message-ID: <CA+MhoaOXaEigjqOYfZBwx3BGjppakUt8wttv_NeCxES7GN1tFw@mail.gmail.com>
References: <CA+MhoaMshSNRS1RD0Dq6dXY_XZtEnryfRq6Hvm+Ntf_Gs67h=g@mail.gmail.com>
	<alpine.DEB.2.11.1503100901230.5471@vincent-weaver-1.umelst.maine.edu>
	<CA+MhoaNhDCFmgxsRzhOyH1zETvPPjqrkLjOTEGi4OzWSBaaq_Q@mail.gmail.com>
	<alpine.DEB.2.11.1503110957400.8554@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34267 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbCMAZL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Mar 2015 20:25:11 -0400
Received: by wiwl15 with SMTP id l15so8199690wiw.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2015 17:25:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1503110957400.8554@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

Hi, Vince,

Thanks very much for your comments! I will check the paper.

Best Regards
Nan Xiao

On Wed, Mar 11, 2015 at 10:00 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> On Wed, 11 Mar 2015, Nan Xiao wrote:
>
>> Compared with the previous output, the numbers decrease drastically
>> (For load instruction: 89,261 vs 1,779,954; store instruction: 12,002
>> vs 6,601,675). This time, I think the more load/store instructions
>> (70,089,261 vs 70,000,000, 20,012,002 vs 20,000,000) are from bash
>> executing the whole command(perf stat -a -e "r81d0:u","r82d0:u"
>> ./a):parse the command, fork process, etc.
>
> perf is very careful to only count the actual process you are running, so
> the overhead probably doesn't involve bash in any way.
>
> x86 processors have many sources of overhead/overcount.  if you're really
> interested in the low-level details you can read my ISPASS 2013 paper
> found here:
>         http://web.eece.maine.edu/~vweaver/projects/deterministic/deterministic_counters.pdf
>
>
> Vince



-- 
Best Regards
Nan Xiao
