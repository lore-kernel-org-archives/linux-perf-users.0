From: David Ahern <dsahern@gmail.com>
Subject: Re: timing information with perf
Date: Thu, 12 Nov 2015 16:22:35 -0700
Message-ID: <56451F3B.8020509@gmail.com>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <20151112215728.GD7160@kernel.org>
 <21ECAC65-E51A-4430-A499-FFE216BF856B@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33136 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbbKLXWg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 18:22:36 -0500
Received: by iouu10 with SMTP id u10so73966803iou.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 15:22:36 -0800 (PST)
In-Reply-To: <21ECAC65-E51A-4430-A499-FFE216BF856B@netapp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 11/12/15 4:09 PM, Kornievskaia, Olga wrote:
> Just to elaborate further, what I=E2=80=99m interested in timings of =
NFS operations, so I=E2=80=99m not using any new tracepoints, but just =
the ones that are present in the code. However since NFS doesn=E2=80=99=
t various things outside of the process calling into NFS then will =E2=80=
=9Cperf trace=E2=80=9D still work?
>
> I=E2=80=99m using =E2=80=9Cperf record -e =E2=80=98nfs4:*=E2=80=99,=E2=
=80=99nfs:*=E2=80=99 -ag=E2=80=9D command to generate tracing info. Tha=
t captures tracepoints executed by the application as well as the kerne=
l threads that do asynchronous IO.

Do you really need callchains? (-g option)

After the perf-record run perf-script to dump the samples. Pipe that=20
into an awk script (or python or bash or ...) and you can compute what=20
you want.
