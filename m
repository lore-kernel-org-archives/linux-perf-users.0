From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: memory consumption information in perf stat?
Date: Thu, 4 Feb 2016 17:51:30 +0900
Message-ID: <56B31112.3000701@gmail.com>
References: <53853116.DaB1LNLXKQ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36496 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbcBDIve (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Feb 2016 03:51:34 -0500
Received: by mail-pf0-f178.google.com with SMTP id n128so37783794pfn.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Feb 2016 00:51:34 -0800 (PST)
In-Reply-To: <53853116.DaB1LNLXKQ@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Hi, Brendan Gregg

I saw your website and your email in LKML
so I sent this mail that contain a question.
(Thanks for your perf example page http://www.brendangregg.com/perf.html )

Would you mind if I ask you a question about perf ?

I saw several questions that can be answered by 'perf' in perf example 
page. 'Which code-paths are allocating memory, and how much?' among 
them. How to get answer of this question ?

I used 'perf mem record/report' and
'perf record -e mem-loads,mem-stores' to get memory information
running my sample program.
But I don't know very well how much is allocated memory
because only mem-* events count or overhead(%), etc can be seen.

Are there another way to check memory consumption info by perf ?

(I looked into perf example page but I mightn't look for the contents 
for it in the page.)
(Sure, I used 'command time -v', 'ps' and other tools in linux
to know this information.)

And I added Cc linux-perf-users and Milian Wolff
because I think this can be related to the mail of Milian.

(If someone would reply, I'd appreciate it.)

Thanks,
Taeung

On 01/29/2016 02:11 AM, Milian Wolff wrote:
> Hey all,
>
> for user-space profiling, it would be extremely useful to get memory
> consumption information such as peak heap size into the output of perf stat.
> Is this doable? I just learned that `command time -v` is able to output the
> maximum and average RSS. It would be extremely nice if `perf stat` could
> incorporate that as well somehow such that I only need a single application to
> look at that.
>
> If this is doable, then feel free to guide me to the code and I'm willing to
> supply a patch for perf stat.
>
> Thanks
>
