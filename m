From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: Link between Intel documentation events and perf list events
Date: Tue, 2 Jul 2013 14:39:42 +0200
Message-ID: <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com>
References: <51D1AA04.7060403@insa-lyon.fr>
	<8761wt62f8.fsf@tassilo.jf.intel.com>
	<51D286E0.2070500@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailsender1.informatik.tu-muenchen.de ([131.159.0.97]:58942
	"EHLO mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752581Ab3GBMjr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Jul 2013 08:39:47 -0400
Received: from mail-ve0-f180.google.com (mail-ve0-f180.google.com [209.85.128.180])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTPSA id 1202E2403D9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2013 14:39:43 +0200 (CEST)
Received: by mail-ve0-f180.google.com with SMTP id pa12so4773344veb.11
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jul 2013 05:39:43 -0700 (PDT)
In-Reply-To: <51D286E0.2070500@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Hi,

since Kernel version 3.7 you can lookup the used raw event in
/sys/device/cpu/events and compare it
to Table 18-1 SDM Volume 3B: System Programming Guide, Part 2.

$ cd /sys/devices/cpu/events/
$ echo *; cat *
branch-instructions branch-misses cache-misses cache-references
cpu-cycles instructions
event=0xc4
event=0xc5
event=0x2e,umask=0x41
event=0x2e,umask=0x4f
event=0x3c
event=0xc0

Here is commit from Jiri Olsa that makes it possible.
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a47473939db20e3961b200eb00acf5fcf084d755

Regards,
Andreas



2013/7/2 Manuel Selva <manuel.selva@insa-lyon.fr>:
> Thanks for the answer Andi.
>
> On a more general sense, how one can link perf events (as reported by perf
> list) to hardware documentation ? Is there some document explaining that or
> should I dig into the perf code source code in the Linux kernel ?
>
> Manu
>
>
> On 07/02/2013 05:55 AM, Andi Kleen wrote:
>>
>> Manuel Selva<manuel.selva@insa-lyon.fr>  writes:
>>
>>> My question is about the link between events reported in Intel
>>> documentation and events listed by perf list. Is the perf list
>>> cache-misses event the same than the one mentioned as Last-level cache
>>> missesin Intel documentation ?
>>
>> Yes it is
>>
>> (at least currently, perf events are not particularly well defined
>> and have changed in the past. However this one is proably not likely
>> to change)
>>
>> -Andi
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
