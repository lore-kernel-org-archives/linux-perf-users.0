From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: What do zeroing of samples in 'perf top' mean ?
Date: Tue, 30 Sep 2014 14:55:10 +0900
Message-ID: <87zjdhhcu9.fsf@sejong.aot.lge.com>
References: <542A214D.1090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:52307 "EHLO
	lgemrelse6q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaI3FzM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Sep 2014 01:55:12 -0400
In-Reply-To: <542A214D.1090804@gmail.com> (taeung's message of "Tue, 30 Sep
	2014 12:19:41 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Taeung,

On Tue, 30 Sep 2014 12:19:41 +0900, taeung wrote:
> Hi,
>
> I have two questions about 'zeroing of samples' in 'perf top'.
>
> I knew if I use 'perf top', I can see a performance counter profile in
> real time.
> But I can't find a difference between 'perf top -a' and 'perf top --zero'.
>
> After 'perf top' is run , I press key 'z' to toggle zeroing of samples.
> But I don't know a difference between when I press key 'z' and before
> I did it.
>
> 1. What is 'Zero history' ?
> (I saw it in Documentation/perf-top.txt that '--zero' option is 'Zero
> history across display updates.')
>
> 2. What do 'zeroing of samples' mean ?

It seems that both questions are same.

The way perf top works is collecting samples and cumulate them into the
history (with decaying).  So it basically shows current value + old
value.  With -z option, it won't use old values.

And yes, one cannot easily find a difference between -z option and
normal output.  So we might need a visual cue as Arnaldo suggested
earlier.  Are you interested in implementing it? :)

Thanks,
Namhyung
