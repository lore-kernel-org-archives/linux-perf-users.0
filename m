From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Latency = weigth in perf mem record/report?
Date: Mon, 17 Feb 2014 17:02:30 +0100
Message-ID: <20140217160230.GD3113@krava.brq.redhat.com>
References: <52FCFC1B.1000703@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42106 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbaBQQCi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Feb 2014 11:02:38 -0500
Content-Disposition: inline
In-Reply-To: <52FCFC1B.1000703@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

On Thu, Feb 13, 2014 at 06:08:43PM +0100, Harald Servat wrote:
> Dear list,
>=20
>   table 18-18 from the Vol 3b part 2 of the Intel=C2=AE 64 and IA-32
> Architectures  Software Developer=E2=80=99s Manual (labeled as Table =
18-18.
> PEBS Record Format for Intel Core i7 Processor Family ) [1]
> indicates that the PEBS samples report the latency value (in core
> cycles) for that particular load/store that emitted the sample at
> the address 0xa8 from the begin of the PEBS sample address.
>=20
>   I've seen that there is a weight field in the output of the perf
> report -D associated to the PERF_RECORD_SAMPLE. Looking at the
> kernel code I found in file
> arch/x86/kernel/cpu/perf_event_intel_ds.c the following code which
> seems to be storing the info I want
>=20
>  819         /*
>  820          * Use latency for weight (only avail with PEBS-LL)
>  821          */
>  822         if (fll && (sample_type & PERF_SAMPLE_WEIGHT))
>  823             data.weight =3D pebs->lat;
>=20
>   and then in tools/perf/builtin-mem.c the routine dump_raw_samples
> seems to dump this info. Am I right? Can anyone kindly confirm this?

Right, PEBS latency info is stored in sample's WEIGHT (for mem-loads an=
d
mem-stores events), and it's sample->weight on the perf tool side.

jirka
