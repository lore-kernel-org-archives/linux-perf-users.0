From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: Re: measure uncore events
Date: Sun, 20 Oct 2013 00:03:09 -0400
Message-ID: <CAJh9x3rmFMeGmUS_u5TgrW4a7EPWwHdtJh1LR2BNX3n+k6k+Yg@mail.gmail.com>
References: <CAJh9x3o3au3ouwn4TTPt+CGyh3bo_u0Qo5LiKshe3HmSY7er4w@mail.gmail.com>
	<87d2nltypp.fsf@tassilo.jf.intel.com>
	<alpine.DEB.2.10.1310040918420.19931@vincent-weaver-1.um.maine.edu>
	<20131004133503.GE6882@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:60406 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3JTEDL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 20 Oct 2013 00:03:11 -0400
Received: by mail-wi0-f171.google.com with SMTP id h11so2554966wiv.16
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Oct 2013 21:03:09 -0700 (PDT)
In-Reply-To: <20131004133503.GE6882@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org

On Fri, Oct 4, 2013 at 9:35 AM, Andi Kleen <andi@firstfloor.org> wrote:
>> are you sure about that?  Support for plain Ivybridge Model 58 uncore
>> (which I assume this machine has) was added in Linux 3.10.
>>
>> Or are there low-end mobile IvyBridge chips that lack uncore support?
>
> There's no support for measuring the memory controller and various
> other interesting units. We only have that on the server parts.
>
> Yes you're right some basic CBOX support exist, but that wasn't
> what the poster was looking for.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only.

Thank you guys.  I'll find some core side events to get an approximate number
