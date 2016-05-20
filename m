From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Getting PEBS to work
Date: Thu, 19 May 2016 18:06:36 -0700
Message-ID: <CAE40pddwJZOikG2kS9z7pwhPgvBsupKsskangpX2FZriQ3ERmQ@mail.gmail.com>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
 <CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com>
 <CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com> <alpine.DEB.2.20.1605192045590.18235@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36730 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbcETBHH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 21:07:07 -0400
Received: by mail-io0-f179.google.com with SMTP id b78so12468618ioj.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2016 18:07:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605192045590.18235@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: jim mauro <jim.mauro@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, May 19, 2016 at 5:47 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> On Thu, 19 May 2016, Brendan Gregg wrote:
>
>> On Thu, May 19, 2016 at 5:09 PM, jim mauro <jim.mauro@gmail.com> wrote:
>>
>> Nor did r01c0. But pretty interesting you got PEBS output, and on
>> Linux 3.8. So maybe my 3.13 isn't the problem...
>
> does your dmesg say anything?  If I recall there are sandybridge machines
> with PEBS disabled due to errata.  Usually you need to update your
> CPU firmware to get it working.

# dmesg | egrep -i 'pmu|pmc|pebs'
[    0.381095] Performance Events: PEBS fmt1+, 16-deep LBR,
SandyBridge events, full-width counters, Intel PMU driver.
[    0.381101] perf_event_intel: PEBS disabled due to CPU errata,
please upgrade microcode
[    0.395348] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    1.231836] nouveau  [     PMC][0000:01:00.0] MSI interrupts enabled

Gah, it was there all along!

Thanks Vince. I hope future PEBS explorers find the commands in this
thread useful!

Now I have to update some microcode...

Brendan
