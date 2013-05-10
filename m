From: David Ahern <dsahern@gmail.com>
Subject: Re: perf record always record the same kernel symbol
Date: Fri, 10 May 2013 13:12:42 -0600
Message-ID: <518D46AA.1000006@gmail.com>
References: <CAKZq+rfUO070Ph38EeOzGGxG3CtWiLZ4-eH=PLgby62Ugk3w1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:61627 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab3EJTMr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 May 2013 15:12:47 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so2370330dad.23
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2013 12:12:46 -0700 (PDT)
In-Reply-To: <CAKZq+rfUO070Ph38EeOzGGxG3CtWiLZ4-eH=PLgby62Ugk3w1w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chao Xu <caesarxuchao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 5/10/13 1:04 PM, Chao Xu wrote:
> Hi,
>
> I issued the following commands:
> sudo perf record sleep 1
> sudo perf report

you are profiling the 'sleep' command which is not very exciting. Try:
   sudo perf record -a -- sleep 1
   sudo perf report

David
