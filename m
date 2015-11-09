From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: observations at periodic intervals
Date: Mon, 9 Nov 2015 12:00:16 -0300
Message-ID: <20151109150016.GB4715@kernel.org>
References: <CAJ38vxsyHv4+SDHhP_YKMFAf-5i_S2Hp+T-0oc4RtsEgdGFodg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38488 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbbKIPAV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Nov 2015 10:00:21 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 495C7205ED
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2015 15:00:19 +0000 (UTC)
Received: from zoo.infradead.org (unknown [179.235.152.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 89BD9205DF
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2015 15:00:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ38vxsyHv4+SDHhP_YKMFAf-5i_S2Hp+T-0oc4RtsEgdGFodg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?iso-8859-1?Q?Jos=E9_Sim=E3o?= <jose.m.simao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Nov 06, 2015 at 09:06:14PM +0000, Jos=E9 Sim=E3o escreveu:
> Dear user of linux-perf-users@vger.kernel.org,
>=20
> When using the -I option of 'stat' to periodically collect the value
> of performance counters (e.g. perf stat -e cache-misses -I 500 cmd)
> the reported value at each internal (500ms in the example) is how muc=
h
> the selected counter increased since the last observation?
>=20
> I assume it is because the values are not monotonically increasing.

=46rom 'perf stat --help' /-I

       -I msecs, --interval-print msecs
           Print count deltas every N milliseconds (minimum: 100ms)
             example: perf stat -I 1000 -e cycles -a sleep 5

This is also available via 'man perf-stat'

So, yes, your observation is correct, those are deltas.

- Arnaldo
