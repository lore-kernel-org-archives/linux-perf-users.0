From: TaeWoong Song <treeze.taeung@gmail.com>
Subject: Re: What do zeroing of samples in 'perf top' mean ?
Date: Sun, 5 Oct 2014 01:51:43 +0900
Message-ID: <D9DD6357-45C4-4ECF-B52C-254620376310@gmail.com>
References: <542A214D.1090804@gmail.com> <542B5CCA.5080302@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58233 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaJDQvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 4 Oct 2014 12:51:47 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so3001313pab.26
        for <linux-perf-users@vger.kernel.org>; Sat, 04 Oct 2014 09:51:47 -0700 (PDT)
In-Reply-To: <542B5CCA.5080302@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, =?utf-8?B?6rmA64Ko7ZiVIOupmO2GoOuLmA==?= <namhyung@gmail.com>

Hi,

I sent patch file about a visual cue for toggle zeroing of samples in pert top.

To know whether it is with -z option in a function hists__browser_title(), 
I add a argument 'struct hist_browser_timer *hbt' in the function.

The cause is 'hbt' can get current value of 'pert_top.zero' and know whether it is 'report' or 'top'.

Does it look good ? 

Thanks,
Taeung
On Oct 1, 2014, at 10:45 AM, taeung <treeze.taeung@gmail.com> wrote:

> Thanks for your answer.
> 
> On 09/30/2014 02:55 PM, Namhyung Kim wrote:
>> Hi Taeung,
>> 
>> On Tue, 30 Sep 2014 12:19:41 +0900, taeung wrote:
>>> Hi,
>>> 
>>> I have two questions about 'zeroing of samples' in 'perf top'.
>>> 
>>> I knew if I use 'perf top', I can see a performance counter profile in
>>> real time.
>>> But I can't find a difference between 'perf top -a' and 'perf top --zero'.
>>> 
>>> After 'perf top' is run , I press key 'z' to toggle zeroing of samples.
>>> But I don't know a difference between when I press key 'z' and before
>>> I did it.
>>> 
>>> 1. What is 'Zero history' ?
>>> (I saw it in Documentation/perf-top.txt that '--zero' option is 'Zero
>>> history across display updates.')
>>> 
>>> 2. What do 'zeroing of samples' mean ?
>> It seems that both questions are same.
>> 
>> The way perf top works is collecting samples and cumulate them into the
>> history (with decaying).  So it basically shows current value + old
>> value.  With -z option, it won't use old values.
>> 
>> And yes, one cannot easily find a difference between -z option and
>> normal output.  So we might need a visual cue as Arnaldo suggested
>> earlier.  Are you interested in implementing it?
> Yes , I really wanna implement it
> to easily find a difference between -z option and default option.
> 
> At last, I understand what -z option mean.
> 
> As what Arnaldo suggested , I'll implement it.
> 
