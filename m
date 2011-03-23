From: Lin Ming <minggr@gmail.com>
Subject: Re: perf script and raw events?
Date: Wed, 23 Mar 2011 08:44:49 +0800
Message-ID: <AANLkTi=a9LxTL_9Vdc1Er1QaO3Tyt3gj_G5jQ3qBjMSp@mail.gmail.com>
References: <20110322224116.GA3794@dev1756.snc6.facebook.com>
	<4D892E0E.3010505@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62578 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1CWAou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Mar 2011 20:44:50 -0400
Received: by iwn34 with SMTP id 34so8026313iwn.19
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2011 17:44:49 -0700 (PDT)
In-Reply-To: <4D892E0E.3010505@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Arun Sharma <asharma@fb.com>, linux-perf-users@vger.kernel.org

On Wed, Mar 23, 2011 at 7:17 AM, David Ahern <daahern@cisco.com> wrote:
>
>
> On 03/22/11 16:41, Arun Sharma wrote:
>> David,
>>
>> # perf record -agR -e cycles -- sleep 1
>> # perf script
>>
>> gives me nice list of stack traces. However if I use
>> a raw event such as:
>>
>> # perf record -agR -e r53003c -- sleep 1
>> # perf script
>
> Works fine for me (with your raw patch for perf-script):
>
> # /tmp/build-perf/perf record -agR -e r53003c -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.147 MB perf.data (~6438 samples) =
]
>
> # /tmp/build-perf/perf script
>
> perf 27684 [000] 180983.511378: raw 0x53003c:
> =A0 =A0 =A0 =A0ffffffff810d696b put_mems_allowed ([kernel.kallsyms])
> =A0 =A0 =A0 =A0ffffffff810cbfa9 perf_mmap_alloc_page ([kernel.kallsym=
s])
> =A0 =A0 =A0 =A0ffffffff810ccd13 perf_mmap ([kernel.kallsyms])
> =A0 =A0 =A0 =A0ffffffff810f1772 mmap_region ([kernel.kallsyms])
> =A0 =A0 =A0 =A0ffffffff810f1c02 do_mmap_pgoff ([kernel.kallsyms])
>
> ...
>
> What is that raw event? Where do you find the encodings for raw event=
s?

raw event starts with a 'r' character and followed by the encoding of t=
he event.
You can find the encoding from cpu spec, for Intel CPU, it's Intel=AE 6=
4
and IA-32 Architectures Software Developer's Manuals.
http://www.intel.com/products/processor/manuals/

=46or example,

perf top -e cpu-cycles
is equivalent with
perf top -e r003c

Lin Ming

>
> David
>
>>
>> I get no traces and perf script immediately exits. Do you know why?
>>
>> =A0-Arun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
