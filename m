From: David Ahern <dsahern@gmail.com>
Subject: Re: What should I do if I want to get Perf samples and Read Performance
 Counter at the same time?
Date: Wed, 28 Aug 2013 14:04:36 -0600
Message-ID: <521E57D4.7090105@gmail.com>
References: <CAEuYUerYx9w=LdJsGG0PV0BKteMcoTL4ro=3+nfm8hBdXtuZ2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34006 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3H1UEj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Aug 2013 16:04:39 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so6705002pde.38
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2013 13:04:39 -0700 (PDT)
In-Reply-To: <CAEuYUerYx9w=LdJsGG0PV0BKteMcoTL4ro=3+nfm8hBdXtuZ2w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 8/28/13 11:21 AM, Peipei Wang wrote:
> Hi all,
>
> Here is my issue, looking forward to the suggestions from you guys. I
> have a java process and I can get the process id. I want to get the
> information about the event cache-misses for this process at the
> sampling rate 100(For this, I use perf record -e cache-misses -c 100 -p
> pid) . And I also want to know how many cache-misses events occurs for
> each second(For this I use watch perf stat -e cache-misses -p pid sleep 1)
>
> Any one has ideas about how to get both of them?

I believe you will need to write your own perf command to do that

David
