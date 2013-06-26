From: David Ahern <dsahern@gmail.com>
Subject: Re: Can perf be used to record cycles or instructions on Virtual
 Machine
Date: Wed, 26 Jun 2013 13:20:50 -0600
Message-ID: <51CB3F12.4030206@gmail.com>
References: <CAEuYUeoCAOJAP4xvKWsFf4e-VJ0BuooO=i8_1qadva-1YFii5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43018 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3FZTUx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Jun 2013 15:20:53 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1609192pde.23
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2013 12:20:53 -0700 (PDT)
In-Reply-To: <CAEuYUeoCAOJAP4xvKWsFf4e-VJ0BuooO=i8_1qadva-1YFii5w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 6/26/13 1:13 PM, Peipei Wang wrote:
> Hi, all.
> I got a new problem.
>
> When I use perf to get CPI( cycles per instruction) on a Virtual
> Machine, I receive the message that
> cycles and instructions are not supported.
>
> However, other events like page-faults or context-switches can be
> supported well.
> I don't know why. So I guess I can't user perf to record a certain
> sort of performance events on Virtual Machine.
>
> Is my guess correct??  What kind of performance events in hell  aren't
> supported?

KVM supports a virtual PMU which uses perf_events host side. I believe 
it went into v3.2, so a host kernel version of 3.2 and greater will have it.

You also need an updated qemu version to set the cpuid bits. I forget 
which version exactly - 1.2 should work.

David
