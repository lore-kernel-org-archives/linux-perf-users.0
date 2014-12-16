From: David Ahern <dsahern@gmail.com>
Subject: Re: perf probe failed to find symbols -
Date: Mon, 15 Dec 2014 20:52:41 -0700
Message-ID: <548FAC89.4010502@gmail.com>
References: <050363D101EB63409B222217F4B02E781EC22E9F@G6W2492.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:58255 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaLPDwo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Dec 2014 22:52:44 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so13261486pad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2014 19:52:44 -0800 (PST)
In-Reply-To: <050363D101EB63409B222217F4B02E781EC22E9F@G6W2492.americas.hpqcorp.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Chinnathambi, Muthusamy" <muthusamy.chinnathambi@hp.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 12/15/14 8:18 PM, Chinnathambi, Muthusamy wrote:
> Hi,
>
> I wanted try perf probe, but I am getting the following failure.
>
> [root@force perf_tests]# ./perf probe --add sys_read
> Failed to find symbol sys_read in kernel
>    Error: Failed to add events.

Works for me:
$ perf probe sys_read
Added new event:
   probe:sys_read       (on sys_read)

You can now use it in all perf tools, such as:

	perf record -e probe:sys_read -aR sleep 1

$ uname -r
3.6.11-4.fc16.x86_64

Also, sys_read already has a tracepoint:

   syscalls:sys_enter_read                            [Tracepoint event]
   syscalls:sys_exit_read                             [Tracepoint event]

David
