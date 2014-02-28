From: Andi Kleen <andi@firstfloor.org>
Subject: Re: unable to get load latency info
Date: Fri, 28 Feb 2014 05:42:21 -0800
Message-ID: <87bnxrcq0y.fsf@tassilo.jf.intel.com>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39708 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbaB1NmW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 08:42:22 -0500
In-Reply-To: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com>
	(Muthusamy's message of "Thu, 27 Feb 2014 22:24:39 -0800 (PST)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Muthusamy <muthu9283@yahoo.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Muthusamy <muthu9283@yahoo.com> writes:
> perf version 3.12.11
> [root@rafa tmp]# ./perf stat -e r100b pwd =C2=A0### (I have tried wit=
h
> other data intensive programs too)

I don't think r100b is a valid event on Westmere. Not sure where you go=
t
that from. As others pointed out you need to use perf mem record/report
with sampling (but note that it reports use-latency, not load-latency)

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only
