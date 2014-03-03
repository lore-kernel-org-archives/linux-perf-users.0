From: Junjie Qian <junjie.qian@yahoo.com>
Subject: Re: Profile the waiting time for lock or lock stats for one application
Date: Mon, 3 Mar 2014 08:11:12 -0800 (PST)
Message-ID: <1393863072.34363.YahooMailNeo@web124906.mail.ne1.yahoo.com>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com> <20140228184343.GD10080@sdfg.com.ar> <5311FD27.7000903@gmail.com> <20140301160338.GE10080@sdfg.com.ar>
Reply-To: Junjie Qian <junjie.qian@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm28-vm5.bullet.mail.ne1.yahoo.com ([98.138.91.250]:41244 "EHLO
	nm28-vm5.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753968AbaCCQLN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Mar 2014 11:11:13 -0500
In-Reply-To: <20140301160338.GE10080@sdfg.com.ar>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>, David Ahern <dsahern@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

Really appreciate your help on this issue!
1. using root solve my problem with "perf lock", thank you very much!
2. about the discussion on locks in user-space. I discussed this with m=
y advisor, and found that lock contention does not mean waiting time or=
 idle cpu-cycles sometime, for example, spin-lock in user-space that al=
l threads/cores are still running but useless work and this cannot be d=
etected as either system lock or idle-cpu-cycles.=A0
The way, I am trying to do this, now is insert the counter into the app=
lication layer once the lock happens start the counting and I prepare t=
o monitor the threads in queue to detect the lock.

I will let you know if I have any updates on this.
Again thank you all for your help and discussions.
=A0
Thanks!
Best
Junjie



On Saturday, March 1, 2014 10:04 AM, Rodrigo Campos <rodrigo@sdfg.com.a=
r> wrote:
On Sat, Mar 01, 2014 at 08:30:47AM -0700, David Ahern wrote:
> On 2/28/14, 11:43 AM, Rodrigo Campos wrote:
> >There are ways (not sure if the patch is in) to track for lock conte=
nsion using
> >perf, but not sure (I think not easy at least) if the lock is not co=
ntended. As,
> >if using glibc, lot of locks are implemented using futex and then so=
lved
> >entirely in userspace lot of times (at least without contention).
>=20
> What patch are you referring to? You can trace system calls to catch

I think one from you, from late last year. I'm not sure and I'm not on =
my
notebook right now. Something to trace the futex syscall or something l=
ike that
? That can help to understand lock contention on userspace





Thanks,

Rodrigo
