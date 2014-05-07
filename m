From: "lhmaster2 ." <lhmaster2@gmail.com>
Subject: Re: Loop block overhead
Date: Wed, 7 May 2014 14:55:05 -0300
Message-ID: <CAPZR5J1Rc8jcB7c-f+9h-SYpgkWBQy5h+HPV4_iYQ7NrZN8Vcw@mail.gmail.com>
References: <CAPZR5J0vJU4X4H+f3gs3CK4duw6TaQuXS1q+xWkS0EgJ_DKiBw@mail.gmail.com>
	<87r44elgry.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:60647 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbaEGRzG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 7 May 2014 13:55:06 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so1377528wgh.7
        for <linux-perf-users@vger.kernel.org>; Wed, 07 May 2014 10:55:05 -0700 (PDT)
In-Reply-To: <87r44elgry.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thank you for the info.

I researched a bit and found that srcline uses addr2line capabilities
to map memory addressed into source lines. Nevertheless, as I invoke

$ perf report -s srcline, sys

only the original mem addresses are printed. Should I pass some
special parameter for perf record to make it work?

Best regards,
Lucas


On 30 April 2014 17:10, Andi Kleen <andi@firstfloor.org> wrote:
>
> "lhmaster2 ." <lhmaster2@gmail.com> writes:
>
> > Dear all,
> >
> > Is there any way to make perf report retrieve the total overhead due
> > to loop blocks, like what is done with total function overhead?
>
> perf has no idea what a loop is unfortunately.
>
> You can use srcline as a sort key to account per line.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only
