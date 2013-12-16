From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Mon, 16 Dec 2013 10:13:06 +0100
Message-ID: <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
	<877gb5vmmn.fsf@tassilo.jf.intel.com>
	<52AE2721.8020501@insa-lyon.fr>
	<20131215234548.GP21717@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:56829 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3LPJNH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Dec 2013 04:13:07 -0500
Received: by mail-la0-f50.google.com with SMTP id el20so2523176lab.23
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2013 01:13:06 -0800 (PST)
In-Reply-To: <20131215234548.GP21717@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Manuel Selva <manuel.selva@insa-lyon.fr>, linux-perf-users@vger.kernel.org

Thanks again.

I guess that by "how you configure perf" you are speaking about
thred/cpu, kernel/user parameters ? For now I am monitoring one
application only on a given node only and I am trying to setup things
in order to get useful results independently of the overhead. I'll
investigate overhead in a second time.

I can't use perf stat because I need to relate perf events with my
application's code.

Manu

2013/12/16 Andi Kleen <andi@firstfloor.org>:
> On Sun, Dec 15, 2013 at 11:03:13PM +0100, Manuel Selva wrote:
>> Thanks for the answer Andi.
>>
>> Is there any way (I couldn't find in the Intel documentation) to
>> have an approximation of the "maximum" acceptable frequency ?
>
> It depends on how much overhead is acceptable and how you configure
> perf (which affects the cost of the handler) and what the executed
> code does. You could tune it to minimize throttles.
>
> I would start with something like 20003
>
> If you only want the relative ratios of course using perf stat would
> be better.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
