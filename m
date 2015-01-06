From: Yale Zhang <yzhang1985@gmail.com>
Subject: Re: Size of perf data files
Date: Tue, 6 Jan 2015 13:02:23 -0800
Message-ID: <CALQF7ZzpLB3Ch3=nn5yi23eneqwXnEpFTq6dX4BT7dLYvxcVXw@mail.gmail.com>
References: <CALQF7ZygJpx=Lf0Dc70=cRRCheF_8SFos8sv8z0kjiog2Do0Zg@mail.gmail.com>
	<87ppas31sq.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:60720 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbAFVCY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 Jan 2015 16:02:24 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so115535iec.12
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jan 2015 13:02:23 -0800 (PST)
In-Reply-To: <87ppas31sq.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

I don't see how lowering the frequency helps. If I lower it, then I'll
need to run longer to capture the same # samples to achieve a given
variation.
I've already tried lowering the size of each sample from 8KiB to 512,
but that only allows storing 2 or 3 parent function calls, which isn't
enough for me.

"don't use dwarf unwinding."
The main reason I'm trying to switch from Zoom to perf is because it
supports dwarf unwinding! That's very convenient because otherwise
I'll need to compile with frame pointers to do stack traces. This
isn't the default and can slow down the program. As long as the Dwarf
unwinding doesn't perturb the profilee  (by doing it at the end), then
it would be OK.


On Mon, Jan 5, 2015 at 9:39 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Yale Zhang <yzhang1985@gmail.com> writes:
>
>> Perf developers,
>> I'm also very interested in reducing the size of the data files when
>> reporting call stacks. Currently, profiling 30s of execution with call
>
> The simplest way is to lower the frequency. Especially don't
> use adaptive frequency (which is the default). This also
> lowers overhead quite a bit. Also don't use dwarf unwinding.
> It is very expensive.
>
> There are some other ways.
>
> I suspect you would most of what you want by just running
> a fast compressor (snappy or LZO) at perf record time. That would
> be likely a useful addition.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only
