From: Andi Kleen <andi@firstfloor.org>
Subject: Re: ratio of progress of the counters
Date: Fri, 01 Nov 2013 12:35:46 -0700
Message-ID: <871u2zykx9.fsf@tassilo.jf.intel.com>
References: <CAJ38vxtu6nsNU8m_kWecJKVKs8ArBmaR2DF3iXmcE=pUQoxEEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26374 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab3KATgP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 Nov 2013 15:36:15 -0400
In-Reply-To: <CAJ38vxtu6nsNU8m_kWecJKVKs8ArBmaR2DF3iXmcE=pUQoxEEA@mail.gmail.com>
	(=?utf-8?Q?=22Jos=C3=A9_Sim=C3=A3o=22's?= message of "Thu, 31 Oct 2013
 16:39:20 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?Sm9zw6kgU2ltw6Nv?= <jose.m.simao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Jos=C3=A9 Sim=C3=A3o <jose.m.simao@gmail.com> writes:

> Dear all,
>
> I'm trying to collect ASCII-based progress information regarding a se=
t
> of performance counters. "Progress" means, for example, the ratios of
> values/second (e.g. page faults/seconds).
>
> I can get information in this form using 'perf stat' but 'stat' only
> gives me the final value. I would like to collect, or calculate,
> theses values from the running command and determine how these metric=
s
> evolved over time (i.e. faster or slower).

Newer perf stat has a -I (interval) option for this.

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only
