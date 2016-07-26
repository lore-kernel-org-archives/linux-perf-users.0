From: Rick Jones <rick.jones2@hpe.com>
Subject: Re: 'perf' to test throughput on PCIe interface?
Date: Tue, 26 Jul 2016 10:26:00 -0700
Message-ID: <ebab5e20-aea4-7e73-5851-29e7c7dcc640@hpe.com>
References: <CAHhAz+gBLm9LmW5FPeH4zfu=uTFNwYrF+2bpnS9Tj-ZQ-S26Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:28824 "EHLO
	g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648AbcGZR0E (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Jul 2016 13:26:04 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id DC02B6353C
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Jul 2016 17:26:02 +0000 (UTC)
In-Reply-To: <CAHhAz+gBLm9LmW5FPeH4zfu=uTFNwYrF+2bpnS9Tj-ZQ-S26Bg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>, linux-perf-users@vger.kernel.org

On 07/26/2016 04:16 AM, Muni Sekhar wrote:
> Hi All,
>
> I installed Linux =E2=80=98perf=E2=80=99 manually by compiling the =E2=
=80=9Clinux/tools/perf=E2=80=9D
> source code.
>
> Can 'perf' tool be used to test the throughput on PCIe interface?

Long ago and far away, there was a utility called pcitop which did=20
things like that.  It relied on the presence of performance counters in=
=20
the PCI/ busconverter/busadaptor chipset.  If I recall correctly, at th=
e=20
time, the only known ones were in Itanium chipsets.

I assume that if there are now documented counters for other chipsets,=20
providing performance information for PCI* buses, either pcitop, perf o=
r=20
something else could be modified to gather them.

happy benchmarking,

rick jones
