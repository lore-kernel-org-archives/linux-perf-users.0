From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: Re: What perf_event_paranoid can do?
Date: Mon, 21 Mar 2011 17:56:43 +0800
Message-ID: <20110321095643.GA57074@cs.nctu.edu.tw>
References: <20110321061435.GA52815@cs.nctu.edu.tw>
 <AANLkTimJ36H76Z77AmauMWtZ9hOM62X1Y2jJa5H6fxWa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:33221 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1CUJ4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Mar 2011 05:56:44 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimJ36H76Z77AmauMWtZ9hOM62X1Y2jJa5H6fxWa@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lin Ming <minggr@gmail.com>
Cc: linux-perf-users@vger.kernel.org, =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>

Hi, Lin

> It's used to control if some action is allowed or not for normal user=
=2E
> See comments at kernel/perf_event.c:
>=20
> /*
>  * perf event paranoia level:
>  *  -1 - not paranoid at all
>  *   0 - disallow raw tracepoint access for unpriv
>  *   1 - disallow cpu events for unpriv
>  *   2 - disallow kernel profiling for unpriv
>  */

  I assume -1 give normal user the most high level privilege,=20
but it doesn't work. I have tried -1 through 2, but none of
them works. Any suggestion? Or maybe the event "branches" does
not support PBES modifier (pp)?

  Thanks!

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667
