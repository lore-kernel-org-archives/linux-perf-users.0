From: =?windows-1252?Q?Martin_Li=9Aka?= <mliska@suse.cz>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Wed, 27 May 2015 11:04:39 +0200
Message-ID: <556588A7.5070003@suse.cz>
References: <555F3F8A.6000204@suse.cz> <87mw0wc4vt.fsf@tassilo.jf.intel.com> <5562D33F.70706@suse.cz> <20150525151450.GK19417@two.firstfloor.org> <5564685D.1020204@suse.cz> <20150526170316.GO19417@two.firstfloor.org> <55658462.1000605@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51425 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbbE0JEm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 May 2015 05:04:42 -0400
In-Reply-To: <55658462.1000605@suse.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

On 05/27/2015 10:46 AM, Martin Li=9Aka wrote:
> On 05/26/2015 07:03 PM, Andi Kleen wrote:
>>> Anyway, attached patch is capable of displaying milliseconds approx=
imation for each instruction.
>>
>> You realize that the events perf is not counting do not directly map=
 to
>> wall time? Even if you count cycles, the cycles are either stopping =
in idle
>> or changing unit as the CPU's frequencies change. For other events t=
he
>> relationship is even more remote, think what happens when counting c=
ache or
>> TLB misses.
>>
>> Also even if it was mapping to time somehow, it's just a hit, not a
>> duration, so it cannot say how long a individual instruction took.
>>
>> So you cannot map a sample event to time.
>>
>> To do what you want you would need to use something like processor
>> trace, which can do exact accounting.
>>
>> I think the only thing that makes sense is to account it relative to
>> the event counts.
>>
>> -Andi
>>
>
> Hello Andi.
>
> I realize all aspects and capabilities of perf infrastructure. Even t=
hough
> these numbers are not precise, I helped me a lot with debugging of a =
benchmark
> which heavily utilizes a single CPU and runs in magnitude of seconds.
>
> Ok, so let's convert the patch to feature that we can map an instruct=
ion
> to a percentage number of events (cycles) it takes.
>
> If I understand correctly, is it just about division of the number of=
 events
> related to an instruction and total number of events?
>
> Thanks,
> Martin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi.

Sample output to verify that we have the same idea in mind:

$ perf annotate --show-total-period

  Disassembly of section .text:
          :
          :      0000000000038890 <random_r>:
          :      __random_r():
     1695 :        38890:       test   %rdi,%rdi
        0 :        38893:       je     38918 <random_r+0x88>
        1 :        38899:       test   %rsi,%rsi
        0 :        3889c:       je     38918 <random_r+0x88>
        9 :        3889e:       mov    0x18(%rdi),%eax
     1833 :        388a1:       mov    0x10(%rdi),%rdx
        2 :        388a5:       test   %eax,%eax
        0 :        388a7:       je     388f8 <random_r+0x68>
      168 :        388a9:       mov    (%rdi),%rcx
        8 :        388ac:       mov    0x8(%rdi),%r8
     1325 :        388b0:       mov    0x28(%rdi),%r9

Where:
$ perf report | head

# To display the perf.data header info, please use --header/--header-on=
ly options.
#
# Samples: 44K of event 'cycles'
# Event count (approx.): 42988831618

Thank for ideas,
Martin
