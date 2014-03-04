From: Muthusamy <muthu9283@yahoo.com>
Subject: Re: unable to get load latency info
Date: Tue, 4 Mar 2014 02:43:25 -0800 (PST)
Message-ID: <1393929805.25511.YahooMailNeo@web125403.mail.ne1.yahoo.com>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com> <87bnxrcq0y.fsf@tassilo.jf.intel.com> <531095B3.3070800@bsc.es> <20140228164510.GU22728@two.firstfloor.org> <1393823578.5408.YahooMailNeo@web125402.mail.ne1.yahoo.com> <5314343E.803@bsc.es> <1393851732.26401.YahooMailNeo@web125404.mail.ne1.yahoo.com> <531490AC.70605@bsc.es>
Reply-To: Muthusamy <muthu9283@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm11-vm6.bullet.mail.ne1.yahoo.com ([98.138.91.104]:35378 "EHLO
	nm11-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756777AbaCDKn0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Mar 2014 05:43:26 -0500
In-Reply-To: <531490AC.70605@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

>>> On Monday, March 3, 2014 1:20 PM, Harald Servat=A0
> <harald.servat@bsc.es> wrote:


> I notice that you provide on an earlier output a uname -a showed=A0
> 2.6.32-xxxx but perf --version showed version 3.12.11, and they don't=
=A0
> match but should. Are you running on 2.6.x or on 3.12.x?

After upgrading the kernel, it did work.
Thanks a lot for the support.

Regards,
Muthusamy C


> On Monday, March 3, 2014 7:54 PM, Harald Servat <harald.servat@bsc.es=
> wrote:
> > On 03/03/14 14:02, Muthusamy wrote:
>>>  On Monday, March 3, 2014 1:20 PM, Harald Servat=20
> <harald.servat@bsc.es> wrote:
>>> =A0 =A0 so I imagine that you're ok with respect to OS.
>>> =A0 =A0 =A0 Besides of that, the Intel Manual [1] says in section 1=
8.7.1.1=20
> that
>>>  Nehalem (and I'd would guess Westmere, as it is a Nehalem=20
> successor)
>>>  supports PEBS, so it should work.
>>=20
>>=20
>>  So, what am I missing. Is there something the kernel needs to be en=
abled=20
> for PEBS. If yes, how do I know if it is enabled.
>>=20
>>  Regards,
>>  Muthusamy C
>>=20
>=20
> I notice that you provide on an earlier output a uname -a showed=20
> 2.6.32-xxxx but perf --version showed version 3.12.11, and they don't=
=20
> match but should. Are you running on 2.6.x or on 3.12.x?
>=20
>=20
> Regards
>=20
>=20
> WARNING / LEGAL TEXT: This message is intended only for the use of th=
e
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>=20
> http://www.bsc.es/disclaimer
>=20
