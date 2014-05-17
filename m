From: David Ahern <dsahern@gmail.com>
Subject: Re: Access to backtraces from user-space tracepoint callback in perf-script?
Date: Sat, 17 May 2014 08:31:55 -0600
Message-ID: <537772DB.3060406@gmail.com>
References: <1998748.ORBRrU6aol@milian-kdab2> <1944165.rOQGbuz1ZM@milian-kdab2> <y0mlhu14sz5.fsf@fche.csb> <2081629.cxlLP7Yh7G@minime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:49911 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbaEQOcC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 17 May 2014 10:32:02 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3807913pbb.8
        for <linux-perf-users@vger.kernel.org>; Sat, 17 May 2014 07:32:01 -0700 (PDT)
In-Reply-To: <2081629.cxlLP7Yh7G@minime>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>, "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-perf-users@vger.kernel.org

On 5/17/14, 5:24 AM, Milian Wolff wrote:
> On Friday 16 May 2014 11:57:02 Frank Ch. Eigler wrote:
>> Milian Wolff <mail@milianw.de> writes:
>>> [...]
>>>
>>>>>> today I played around with perf-script(-python) and custom
>>>>>> tracepoints.
>>>>>> What I could not figure out so far is how to print a backtrace from
>>>>>> the
>>>>>> python callback. [...]
>>
>> While you wait, you might try systemtap, wherein there exists support
>> not just for plain C-level backtracing (print_ubacktrace() as for any
>> other program), but also python source-level backtracing (via a tapset
>> function).
>>
>> https://sourceware.org/systemtap/examples/#general/py2example.stp
>
> Hey,
>
> thanks for the hint. But I never got SystemTap to work on any of my machines
> :-/
>
> For now I'll stick to manual libunwind + libbacktrace + LD_PRELOAD tracing.
> But I'd love to see this available in perf eventually.
>

Did you try the patch to perf? Does it give you access to the callchain 
in python scripts like you want?

David
