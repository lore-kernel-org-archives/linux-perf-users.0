From: Andrew Vagin <avagin@gmail.com>
Subject: Re: Trouble parsing trace events
Date: Wed, 23 Nov 2011 11:03:52 +0400
Message-ID: <4ECC9AD8.3010801@gmail.com>
References: <4ECC97EB.1040008@fb.com>
Reply-To: avagin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:31980 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756736Ab1KWHED (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Nov 2011 02:04:03 -0500
In-Reply-To: <4ECC97EB.1040008@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>

Hello Arun,

This bug was fixed already, but the commit isn't in Linus's tree yet.
http://git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=49908a1b25d448d68fd26faca260e1850201575f

On 11/23/2011 10:51 AM, Arun Sharma wrote:
>
> I'm using a 3.2-rc1 based kernel and perf userspace built from 
> tip/auto-latest (commit id e471db8) + Andrew Vagin's sleep profiling 
> patches.
>
> # perf record -agT -e sched:sched_switch -F 100 -- sleep 3
> [ perf record: Woken up 9 times to write data ]
> [ perf record: Captured and wrote 4.044 MB perf.data (~176664 samples) ]
>
> # perf script
>   Warning: Error: expected type 5 but read 4
>   Warning: Error: expected type 4 but read 0
>   Fatal: bad op token {
>
> Is there a known incompatibility between kernel and userspace that 
> could explain this?
>
> I don't see this problem with other trace points (eg: kmem:kmalloc).
>
>  -Arun
