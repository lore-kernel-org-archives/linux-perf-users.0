From: David Ahern <dsahern@gmail.com>
Subject: Re: How can I write a script and use perf script to process the record
 data periodically
Date: Thu, 15 Aug 2013 10:58:18 -0600
Message-ID: <520D08AA.9000605@gmail.com>
References: <CAEuYUep7Ph+QnOonkvEAropiUqCFV9e-DT9ygcP7LDNEyV6SMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:54358 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471Ab3HOQ6W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 15 Aug 2013 12:58:22 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so956243pbc.39
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2013 09:58:21 -0700 (PDT)
In-Reply-To: <CAEuYUep7Ph+QnOonkvEAropiUqCFV9e-DT9ygcP7LDNEyV6SMQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 8/14/13 3:19 PM, Peipei Wang wrote:
> Hi all,
>
> I want to use perf script to process the data sampled by "perf record"
> since it is huge overhead to just write down all the samples.
> Processing the samples every minute is what I am desperate to do.

I don't follow what you are trying to do. perf-script can pretty print 
each sample -- time, cpu, task, pid/tid, etc (that option of perf-script 
is really a misnomer and this should be a perf-dump command).

 From there you want to process the samples?

If you know perl or python take a look at the scripts in 
tools/perf/scripts/python. I have not written external scripts, so can't 
offer any suggestions for you.

David
