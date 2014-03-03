From: Muthusamy <muthu9283@yahoo.com>
Subject: Re: unable to get load latency info
Date: Sun, 2 Mar 2014 21:12:58 -0800 (PST)
Message-ID: <1393823578.5408.YahooMailNeo@web125402.mail.ne1.yahoo.com>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com> <87bnxrcq0y.fsf@tassilo.jf.intel.com> <531095B3.3070800@bsc.es> <20140228164510.GU22728@two.firstfloor.org>
Reply-To: Muthusamy <muthu9283@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm4-vm6.bullet.mail.ne1.yahoo.com ([98.138.91.97]:40138 "EHLO
	nm4-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111AbaCCFM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Mar 2014 00:12:59 -0500
In-Reply-To: <20140228164510.GU22728@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>, Andi Kleen <andi@firstfloor.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> On 28/02/14 14:42, Andi Kleen wrote:

> I don't think r100b is a valid event on Westmere.

Thanks for the replies.
As=A0Harald Servat and others pointed I am now trying "perf mem record"

[root@rafa cms]# ./perf mem record /bin/ls
invalid or unsupported event: 'cpu/mem-loads/pp'

Is this a issue with the (old) kernel version I am on or the CPU versio=
n or both.

Regards,
Muthusamy C



> On Friday, February 28, 2014 10:15 PM, Andi Kleen <andi@firstfloor.or=
g> wrote:
> >> =A0  what do you mean by use-latency here? I understood that PEBS =
was
>>  able to report the number of core cycles that the load took to from
>>  some part of the memory hierarchy until it reached the CPU.
>=20
> PEBS load/store latency reports the cycles from when the instruction
> started issuing in the pipeline to the return of the value. That's no=
t
> quite the same, it can be much longer than the pure memory hierarchy
> cost.
>=20
>=20
> -Andi
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20
