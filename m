From: Junjie Qian <junjie.qian@yahoo.com>
Subject: Re: Profile the waiting time for lock or lock stats for one application
Date: Fri, 28 Feb 2014 12:00:51 -0800 (PST)
Message-ID: <1393617651.66709.YahooMailNeo@web124905.mail.ne1.yahoo.com>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com> <1393471039.86366.YahooMailNeo@web124905.mail.ne1.yahoo.com> <530EB12C.9020407@gmail.com>
Reply-To: Junjie Qian <junjie.qian@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm19-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.179]:49056 "EHLO
	nm19-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514AbaB1UAw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 15:00:52 -0500
In-Reply-To: <530EB12C.9020407@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Dear David,

Thank you for this suggestion, and sorry for late reply.
I have tried this yet, since I am using lock_stat to analyze the system=
 lock info, and I will let you know if I have any updates on this.
=A0
Thanks!
Best
Junjie



On Wednesday, February 26, 2014 9:29 PM, David Ahern <dsahern@gmail.com=
> wrote:
On 2/26/14, 8:17 PM, Junjie Qian wrote:

> Hi all,
>
> This is a follow up question about "perf lock".
> I recompile the kernel, with both CONFIG_LOCKDEP and CONFIG_LOCK_STAT=
 are "y". But when I run the command "perf lock record -- sleep 10", th=
e error information still shows as:
> tracepoint lock:lock_acquire is not enabled. Are CONFIG_LOCKDEP and C=
ONFIG_LOCK_STAT enabled?
>
> Could you give me some suggestions on this?

are you running as root? If you are running perf as a normal user is th=
e=20
events directory accessible -- /sys/kernel/debug/tracing? Does=20
/sys/kernel/debug/tracing/events/lock exist?

David

--
To unsubscribe from this list: send the line "unsubscribe linux-perf-us=
ers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
