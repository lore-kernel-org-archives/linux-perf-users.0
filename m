From: JJ Hiblot <jjhiblot@gmail.com>
Subject: Re: Measuring worst case interrupt processing time
Date: Mon, 09 Dec 2013 12:26:14 +0100
Message-ID: <52A5A8D6.6020401@gmail.com>
References: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:55459 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932735Ab3LIL0i (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Dec 2013 06:26:38 -0500
In-Reply-To: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mohammed Riyaz <riyaz.list@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

I used to do this kind of measurement with a GPIO and an oscilloscope=20
set up in persistence mode. In this case ,the precision of  the measure=
=20
doesn't depend of the timer's resolution.

Jean-Jacques

Le 08/12/2013 14:18, Mohammed Riyaz a =E9crit :
> Hi,
>
> I am working on trying to measure the worst case processing time for
> hard IRQ and soft IRQ. Well, I understand that we could use time
> stamps at entry and exit to measure this. Just wanted to know if ther=
e
> were other standard ways of measuring this. Any suggestions?
>
> Thanks
>
> Riyaz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
