From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Re: Why "perf stat" output more memory load/store counts?
Date: Wed, 11 Mar 2015 17:20:30 +0800
Message-ID: <CA+MhoaNhDCFmgxsRzhOyH1zETvPPjqrkLjOTEGi4OzWSBaaq_Q@mail.gmail.com>
References: <CA+MhoaMshSNRS1RD0Dq6dXY_XZtEnryfRq6Hvm+Ntf_Gs67h=g@mail.gmail.com>
	<alpine.DEB.2.11.1503100901230.5471@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:46327 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbCKJUc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 11 Mar 2015 05:20:32 -0400
Received: by wggx12 with SMTP id x12so7640784wgg.13
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2015 02:20:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1503100901230.5471@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

Hi Vince,

Firstly, thanks very much for your answers!

The following is adding ":u" output:

[root@dl380gen8snbjbb test]# perf stat -a -e "r81d0:u","r82d0:u" ./a

 Performance counter stats for './a':

        70,089,261 r81d0:u
         [100.00%]
        20,012,002 r82d0:u

       0.036274699 seconds time elapsed

Compared with the previous output, the numbers decrease drastically
(For load instruction: 89,261 vs 1,779,954; store instruction: 12,002
vs 6,601,675). This time, I think the more load/store instructions
(70,089,261 vs 70,000,000, 20,012,002 vs 20,000,000) are from bash
executing the whole command(perf stat -a -e "r81d0:u","r82d0:u"
./a):parse the command, fork process, etc.

 Is my thought right? Please help to give some comments, thanks very
much in advance!

Best Regards
Nan Xiao

On Tue, Mar 10, 2015 at 9:02 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> On Tue, 10 Mar 2015, Nan Xiao wrote:
>
>> I can't understand why there are so many more load/store operations
>> from "perf stat" output. Could anyone can explain this? Thanks very
>> much in advance!
>
> there are a lot of reasons you might get overcount, but in this particular
> case it looks like you are probably counting kernel events too.  Do things
> get better if you put ":u" on your event names so that you only count user
> events?
>
> Vince



-- 
Best Regards
Nan Xiao
