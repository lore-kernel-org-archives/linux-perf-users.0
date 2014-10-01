From: taeung <treeze.taeung@gmail.com>
Subject: Re: What do zeroing of samples in 'perf top' mean ?
Date: Wed, 01 Oct 2014 10:45:46 +0900
Message-ID: <542B5CCA.5080302@gmail.com>
References: <542A214D.1090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49310 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaJABp5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Sep 2014 21:45:57 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so115151pdi.24
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2014 18:45:56 -0700 (PDT)
Received: from [192.168.1.210] ([106.245.241.10])
        by mx.google.com with ESMTPSA id cq7sm16353317pdb.16.2014.09.30.18.45.55
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 18:45:56 -0700 (PDT)
In-Reply-To: <542A214D.1090804@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Thanks for your answer.

On 09/30/2014 02:55 PM, Namhyung Kim wrote:
> Hi Taeung,
>
> On Tue, 30 Sep 2014 12:19:41 +0900, taeung wrote:
>> Hi,
>>
>> I have two questions about 'zeroing of samples' in 'perf top'.
>>
>> I knew if I use 'perf top', I can see a performance counter profile in
>> real time.
>> But I can't find a difference between 'perf top -a' and 'perf top 
>> --zero'.
>>
>> After 'perf top' is run , I press key 'z' to toggle zeroing of samples.
>> But I don't know a difference between when I press key 'z' and before
>> I did it.
>>
>> 1. What is 'Zero history' ?
>> (I saw it in Documentation/perf-top.txt that '--zero' option is 'Zero
>> history across display updates.')
>>
>> 2. What do 'zeroing of samples' mean ?
> It seems that both questions are same.
>
> The way perf top works is collecting samples and cumulate them into the
> history (with decaying).  So it basically shows current value + old
> value.  With -z option, it won't use old values.
>
> And yes, one cannot easily find a difference between -z option and
> normal output.  So we might need a visual cue as Arnaldo suggested
> earlier.  Are you interested in implementing it?
Yes , I really wanna implement it
to easily find a difference between -z option and default option.

At last, I understand what -z option mean.

As what Arnaldo suggested , I'll implement it.

Thanks,
Taeung
