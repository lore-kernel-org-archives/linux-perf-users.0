From: Ben Redelings <benjamin.redelings@gmail.com>
Subject: Re: "perf script" broken with --call-graph=dwarf on recent kernels?
Date: Tue, 18 Aug 2015 14:28:40 -0400
Message-ID: <55D37958.7090904@gmail.com>
References: <55D20AF9.9040705@gmail.com> <20150818070548.GA23807@krava.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35930 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbHRS2n (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Aug 2015 14:28:43 -0400
Received: by qgeb6 with SMTP id b6so5542608qge.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2015 11:28:42 -0700 (PDT)
In-Reply-To: <20150818070548.GA23807@krava.local>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

Yeah, I applied the patch you posted, and it works.  Thanks!

-BenRI

On 08/18/2015 03:05 AM, Jiri Olsa wrote:
> On Mon, Aug 17, 2015 at 12:25:29PM -0400, Ben Redelings wrote:
>
> SNIP
>
>> (/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
>>                    306ce1 empirical_frequencies
>> (/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
>>                    3330d9 get_smodel
>> (/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
>>                    4dc133 get_smodels
>> (/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
>>                    4e02ea create_A_and_T_model
>> (/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
>>
>> This is more what I was expecting, and similar to what I used to get with
>> --call-graph=dwarf.
>>
>> However, the call chains that I get using DWARF tend to be longer and lead
>> to more accurate results, so I would prefer to use DWARF instead of lbr.  Is
>> there something that I'm doing wrong?  Also, it seems like
>> --call-graph=dwarf successfully records call chains that can be seen via
>> perf report, but somehow 'perf script' doesn't show them.  Could that
>> happen?
>>
>> -BenRI
>>
>> P.S. I'm using debian's kernel 4.1.0 and perf tools on a Core i3-4030.
> hum, it's probably fixed already:
> http://marc.info/?l=linux-kernel&m=143945026316969&w=2
>
> it's currently in Arnaldo's perf/core branch
>
> jirka
