From: David Ahern <dsahern@gmail.com>
Subject: Re: access function parameters with DWARF-less perf probing
Date: Thu, 24 Apr 2014 08:12:34 -0600
Message-ID: <53591BD2.6080001@gmail.com>
References: <CANHDG4btxwQxGme+TwWYhPVEKSwyHA_C3fVxNuaFJOrzGYOyCA@mail.gmail.com> <87iopzb8vw.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56366 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbaDXOMi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Apr 2014 10:12:38 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so1959917pdj.41
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2014 07:12:37 -0700 (PDT)
In-Reply-To: <87iopzb8vw.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Jun Wang <junwang123@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 4/23/14, 11:21 PM, Andi Kleen wrote:
> Jun Wang <junwang123@gmail.com> writes:
>
>> Hi Everyone,
>>
>> With systemTap, in the absence of debugging information (DWARF), one
>> can access function parameters using (positional) numbers. Can the
>> same be done with `perf`?
>> Why? I'm trying to capture variables in a kernel function but I don't
>> have an good perf with DWARF support and there is are significant
>> challenges to build one due to the relatively old distro.
>
> You can specify the registers according to the ABI.
> di = 1. arg, si = 2nd arg etc.

http://en.wikipedia.org/wiki/X86_calling_conventions#List_of_x86_calling_conventions
