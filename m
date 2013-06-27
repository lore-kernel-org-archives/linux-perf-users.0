From: David Ahern <dsahern@gmail.com>
Subject: Re: How to get perf stat output and redirect to a file rather than
 screen
Date: Thu, 27 Jun 2013 11:49:42 -0600
Message-ID: <51CC7B36.6030201@gmail.com>
References: <CAEuYUeqBE57QnF1rqk9G5tM58pXFVvpNP2GE4mQcvE0cLBgncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:40559 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab3F0Rtq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 27 Jun 2013 13:49:46 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so522827pdd.34
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2013 10:49:45 -0700 (PDT)
In-Reply-To: <CAEuYUeqBE57QnF1rqk9G5tM58pXFVvpNP2GE4mQcvE0cLBgncA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 6/27/13 11:47 AM, Peipei Wang wrote:
> Hi all.
>
> I want to save the output of perf stat as a file, however, I 've tried
> several ways, none of them works. Here is what I have tried.
> My basic command is " timeout -s SIGINT 4s perf stat  -p 32098". That
> is using perf stat to capture process 32098 for 4 seconds.

perf stat -o <stat-output-file> -p 32098

Also, instead of timeout ... you can run:
   perf sat -o /tmp/perfstat.out -p 32098 -- sleep 4

That tells perf to profile process 32098 and do so for as long as the 
workload is running where the workload is to sleep for 4 seconds.

David
