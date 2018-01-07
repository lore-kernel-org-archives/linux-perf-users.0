From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf memory metrics on ec2 instance
Date: Sun, 7 Jan 2018 13:59:00 -0800
Message-ID: <CAE40pdcrX-kpE84jgH2rut9Beq8_3TU5BDOc0c5VhFmiTqT+ZA@mail.gmail.com>
References: <CA+q6zcXGsPT3bXhUS2gNf0_JPm+jLHBaSH+T_5CNPkZ3A9GK7g@mail.gmail.com>
 <87608i5xcd.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36723 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbeAGV7c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Jan 2018 16:59:32 -0500
Received: by mail-wm0-f42.google.com with SMTP id b76so11125943wmg.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jan 2018 13:59:31 -0800 (PST)
In-Reply-To: <87608i5xcd.fsf@linux.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Dmitry Dolgov <9erthalion6@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Jan 3, 2018 at 3:36 PM, Andi Kleen <ak@linux.intel.com> wrote:
>
> Dmitry Dolgov <9erthalion6@gmail.com> writes:
> >
> > It's quite confusing for me, because the same works fine on my local machine,
> > but this error I've got is not about something being not supported. Can you tell
> > me what I'm doing wrong?
>
> perf mem requires PEBS.  PEBS is currently not supported in VMs. You
> should let Amazon know that you need it though, so it could be possibly
> implemented.

Right. Clouds like AWS have millions of customers asking for various
things. Relatively speaking, those of us asking for PMCs, PEBS, BTS,
etc (which was hopefully more than just me), are a speck of dust. But
they do listen, and they did ship architectural PMCs on many large
instance types early last year (eg, m4.16xl). Since late last year,
most/all PMCs are now available on the Nitro hypervisor instances (c5,
m5, etc), and now everything is available on the new bare metal
instance type (preview only).

If anyone wants PEBS right now in EC2, get on the public preview of
the bare metal instance type.

Brendan

>
>
> -Andi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
