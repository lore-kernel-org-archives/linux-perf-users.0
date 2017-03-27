From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: perf software events broken in containers
Date: Mon, 27 Mar 2017 12:10:14 -0400
Message-ID: <y0mpoh2og49.fsf@fche.csb>
References: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
        <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com>
        <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdC0QKQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2017 12:10:16 -0400
In-Reply-To: <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
        (Brendan Gregg's message of "Wed, 22 Mar 2017 12:59:22 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>


brendan.d.gregg wrote:

> [...]
>> stap -v -e 'probe kernel.function("idr_find").return {printf("%s %s 0x%x\n", pn(), $$parms$, $return)}'
>>
>
> Right, I've been doing that with ftrace/kprobes/bcc/BPF... Many of the
> functions aren't visible, though, I suspect inlined.

stap is comfortable with probing inlined functions, or
generally any statements within functions.

See e.g. https://sourceware.org/systemtap/examples/#general/whythefail.stp

- FChE
