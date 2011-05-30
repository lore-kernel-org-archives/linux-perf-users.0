From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: kvm-tool seems to be stuck
Date: Mon, 30 May 2011 08:54:24 +0200
Message-ID: <BANLkTi=sxvKL78rYofuJiofoXhEGxxtp_Q@mail.gmail.com>
References: <BANLkTikJJiW1-tYZeeshAUeSiNLhtFEGwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:62424 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab1E3GyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 May 2011 02:54:25 -0400
Received: by pxi2 with SMTP id 2so2289959pxi.10
        for <linux-perf-users@vger.kernel.org>; Sun, 29 May 2011 23:54:24 -0700 (PDT)
In-Reply-To: <BANLkTikJJiW1-tYZeeshAUeSiNLhtFEGwQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Stupid me, sent to the wrong list... sorry for the noise

On Sun, May 29, 2011 at 9:41 PM, Francis Moreau <francis.moro@gmail.com=
> wrote:
> Hello,
>
> I just wanted to give kvm-tool a try and it unfortunately seems to be
> stuck somewhere:
>
> $ ./kvm run --disk linux-0.2.img --kernel
> ../../../linux-2.6/arch/x86/boot/bzImage
> =A0# kvm run -k ../../../linux-2.6/arch/x86/boot/bzImage -m 448 -c 4
> =A0Warning: Unable to open /dev/net/tun
> PPrroobbiinngg =A0EEDDDD =A0((eedddd=3D=3Dooffff =A0ttoo =A0ddiissaab=
bllee))...... =A0ookk
>
> This is with kvm master at 6dfc8581f14d355a89e7edaf4394ee8c69177f1f
> (cloned this evening).
>
> Could anybody tell me what I did wrong ?
>
> Thanks
> --
> Francis
>



--=20
=46rancis
