From: Yale Zhang <yzhang1985@gmail.com>
Subject: Re: 'perf' to test throughput on PCIe interface?
Date: Tue, 26 Jul 2016 13:38:13 -0700
Message-ID: <CALQF7ZzVEuX7hYD49X1=YNpRBT=BYEX7ApiP8gdvbcZiYN4P2w@mail.gmail.com>
References: <CAHhAz+gBLm9LmW5FPeH4zfu=uTFNwYrF+2bpnS9Tj-ZQ-S26Bg@mail.gmail.com>
 <ebab5e20-aea4-7e73-5851-29e7c7dcc640@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34941 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbcGZUiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Jul 2016 16:38:15 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so1389745ith.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Jul 2016 13:38:15 -0700 (PDT)
In-Reply-To: <ebab5e20-aea4-7e73-5851-29e7c7dcc640@hpe.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Rick Jones <rick.jones2@hpe.com>
Cc: Muni Sekhar <munisekharrms@gmail.com>, linux-perf-users@vger.kernel.org

Have you heard of the Intel's performance counter monitor, which has a
utility, pcm-pcie which measures PCIe activity in real time? The only
confusing thing for me is it measures number of cache lines
read/written, instead of #packets or bytes.

Not clear if this means PCIe actually reads/writes directly from/to
the cache or if it means regular memory and cache line (64 bytes) is
the atomic unit to cooperate with cache coherence. I'm guessing the
performance counters don't measure the actual packet sizes, only the #
cache lines accessed.

Can someone confirm?

Also, is PCIe cache coherence even a useful feature? Although it can
automatically do a cache invalidation when writing to memory, for
reads it needs to ask the cache to write back any dirty data or put
the burden on the programmer, or use write-through instead of
write-back. AFAIK for graphics drivers, memory mapped PCIe memory is
uncached and use write combining.

On Tue, Jul 26, 2016 at 10:26 AM, Rick Jones <rick.jones2@hpe.com> wrot=
e:
> On 07/26/2016 04:16 AM, Muni Sekhar wrote:
>>
>> Hi All,
>>
>> I installed Linux =E2=80=98perf=E2=80=99 manually by compiling the =E2=
=80=9Clinux/tools/perf=E2=80=9D
>> source code.
>>
>> Can 'perf' tool be used to test the throughput on PCIe interface?
>
>
> Long ago and far away, there was a utility called pcitop which did th=
ings
> like that.  It relied on the presence of performance counters in the =
PCI/
> busconverter/busadaptor chipset.  If I recall correctly, at the time,=
 the
> only known ones were in Itanium chipsets.
>
> I assume that if there are now documented counters for other chipsets=
,
> providing performance information for PCI* buses, either pcitop, perf=
 or
> something else could be modified to gather them.
>
> happy benchmarking,
>
> rick jones
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
