From: David Ahern <dsahern@gmail.com>
Subject: Re: measuring and/or dealing with "idleness" and variable frequency
Date: Mon, 10 Jun 2013 16:33:20 -0600
Message-ID: <51B65430.8050501@gmail.com>
References: <51B0CADF.8040508@hp.com> <51B3F4A3.3020502@gmail.com> <51B63847.1010008@hp.com> <51B652F9.4020402@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:55300 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3FJWdd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 10 Jun 2013 18:33:33 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so5031242pdi.16
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jun 2013 15:33:33 -0700 (PDT)
In-Reply-To: <51B652F9.4020402@hp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Rick Jones <rick.jones2@hp.com>
Cc: linux-perf-users@vger.kernel.org

On 6/10/13 4:28 PM, Rick Jones wrote:
>> I think I could get what I want from that - assuming I could get that to
>> a kernel I can use in my test env, but am guessing it is rather more
>> than I"m looking for at the moment.  I'm wondering if there might be a
>> simpler way to go - just get the idle loop to keep looping rather than
>> halt (?) the thread, so there would still be cycle events in the PMU?
>> (And perhaps set the system to a static, high-performance mode to avoid
>> frequency changes and maybe even disable HT?)
>
> Or, after having found
> https://www.kernel.org/doc/Documentation/kernel-parameters.txt, perhaps
> idle=poll?

Yes, that should turn the server into a power-sucking space heater and 
keep the cycles counter firing.

David
