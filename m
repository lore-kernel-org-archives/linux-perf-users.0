From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: vmlinux buildid doesn't match the running one (/sys/kernel/notes)
Date: Sun, 1 May 2011 21:02:35 +0200
Message-ID: <BANLkTikfDmsZ056G+Eht2BbNH4GVBokXzw@mail.gmail.com>
References: <BANLkTim+kr6TYdkuh=bugJaNmSnLE0h-8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49402 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab1EATCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 1 May 2011 15:02:36 -0400
Received: by pzk9 with SMTP id 9so2787045pzk.19
        for <linux-perf-users@vger.kernel.org>; Sun, 01 May 2011 12:02:35 -0700 (PDT)
In-Reply-To: <BANLkTim+kr6TYdkuh=bugJaNmSnLE0h-8Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Sorry for asking again but I would be really greatfull is someone can
tell me what's wrong when using a kernel that I compiled by my own.

I do not have that issue is I use the kernel shipped by my distro (FC14=
).

Thanks

On Thu, Apr 28, 2011 at 7:04 PM, Francis Moreau <francis.moro@gmail.com=
> wrote:
> Hello,
>
> I'm trying to use perf-probe, but it fails.
>
> Basically it's due to the buildid of the running kernel (the one whic=
h
> can be read from /sys/kernel/notes) and the one in vmlinx (which I
> compiled my self).
>
> I did this:
>
> =A0$ make
> =A0$ make modules_install install
> =A0$ ls vmlinux
> =A0vmlinux
>
> reboot
>
> =A0$ perf probe -k vmlinux -L schedule
> =A0Failed to find path of kernel module.
> =A0Failed to open debuginfo file.
> =A0Error: Failed to show lines. (-2)
>
> So my question is why the buildids doesn't match ?
>
> I guess I did something wrong since it's pretty a standard use case
> but I don't see why...
>
> Thanks
> --
> Francis
>



--=20
=46rancis
