From: David Ahern <dsahern@gmail.com>
Subject: Re: what does id mean in perf script
Date: Fri, 23 Aug 2013 09:38:41 -0600
Message-ID: <52178201.2050207@gmail.com>
References: <CAEuYUepPXrZnGN4tZxu2usynRmQ8tdQXCKUgv2NF4uD5Z5-k1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64653 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab3HWPir (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Aug 2013 11:38:47 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so811165pdj.40
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Aug 2013 08:38:47 -0700 (PDT)
In-Reply-To: <CAEuYUepPXrZnGN4tZxu2usynRmQ8tdQXCKUgv2NF4uD5Z5-k1w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 8/23/13 8:38 AM, Peipei Wang wrote:
> Hi all,
>
> I got a file using perf script as follows. I want to know the meaning
> in the array id in event,like
>   id = { 672074, 672075, 672076, 672077
> , 672078, 672079, 672080, 672081, 672082, 672083, 672084, 672085,
> 672086, 672087, 672088, 672089, 672090, 672091, 672092, 672093,
> 672094, 672095, 672096, 672097, 672098, 672099, 672100, 672101,
> 672102, 672103, 672104, 672105, 672106, 672107, 672108, 672109,
> 672110, 672111, 672112, 672113, 672114, 672115, 672116, 672117,
> 672118, 672119, 672120, 672121, 672122, 672123, 672124, 672125,
> 672126, 672127, 672128, 672129, 672130, 672131, 672132 }
>
> What do these numbers mean??

I believe those are the id's for the events in your data set. A means 
for correlating your samples with the evsel that describes the event.

David
