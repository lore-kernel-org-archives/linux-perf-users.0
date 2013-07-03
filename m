From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Link between Intel documentation events and perf list events
Date: Wed, 03 Jul 2013 11:06:45 +0200
Message-ID: <51D3E9A5.2010804@gmail.com>
References: <51D1AA04.7060403@insa-lyon.fr> <8761wt62f8.fsf@tassilo.jf.intel.com> <51D286E0.2070500@insa-lyon.fr> <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com> <51D2D69E.9020207@gmail.com> <20130702144904.GY6123@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020107000105030703020604"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49552 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab3GCJGt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Jul 2013 05:06:49 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so4974116wid.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2013 02:06:47 -0700 (PDT)
In-Reply-To: <20130702144904.GY6123@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Andreas Hollmann <hollmann@in.tum.de>, Manuel Selva <manuel.selva@insa-lyon.fr>, linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107000105030703020604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks.

I still have question on perf, and because I can't find an answer on the 
net I am asking here again. I wrote a simple C program calling CPUID to 
get information about my laptop performance monitoring units (putting 
0XA in eax register before calling cpuid)

In the results located in ebx I see a 1 bit for the core cycle event and 
a 1 bit for the instruction retired event. According to Intel 
documentation these ones means that theassociated events are not 
available. But I can use these events with perf, and user libraries such 
as PAPI are telling me that they are available.

I attached to this mail my program, is there any problem in it, where is 
my mistake ?

Manu

On 07/02/2013 04:49 PM, Andi Kleen wrote:
> On Tue, Jul 02, 2013 at 03:33:18PM +0200, Manuel Selva wrote:
>> Thanks again for the help.Your answer suggests that events listed as
>> Hardware event by perf listare what is called Architecural Events
>> for Intel processors, isn't it ?
> perf uses a superset of the architectural events
> (but only a small subset of a full Intel event list)
>
> Also it supports setting the other events in raw form
> (or various add-on tools exist to provide them as names)
>
>> On my Sandy Bridge core i5-2520M, perf list reports 10 hardware
>> events, where as they are only 7 entriesin the table 18-1 of Intel
>> documentation you mentioned. So I am wondering what are these 3
>> additional events;
> Not all events supported by perf are in sysfs.
>
>> event=0x00,umask=0x03 (ref-cycles)
>> event=0xb1,umask=0x01,inv,cmask=0x01 (stalled-cycles-backend)
>> event=0x0e,umask=0x01,inv,cmask=0x01 (stalled-cycles-frontend)
>>
>> Looking at table 19-7 in the same Intel document, I can see non
>> architectural events for my core i5-2xxx. In this table I can see
>> that:
>>
>> ref-cycles                       ==> Can't find it
> This is typically called CPU_CLK_UNHALTED.REF_TSC or so
> in the Intel documentation.
>
>> stalled-cycles-backend ==> Counts total number of uops to be
>> dispatched per- thread each cycle. Set Cmask = 1, INV =1 to count
>> stall cycles.
>> stalled-cycles-frontend ==> Increments each cycle the # of Uops
>> issued by the RAT to RS.Set Cmask = 1, Inv = 1, Any= 1to count
>> stalled cycles of this core.
> These two are very broken. Just ignore them.
>
> -Andi


--------------020107000105030703020604
Content-Type: text/x-csrc;
 name="cpuid.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cpuid.c"

#include <stdio.h>

int main() {

    unsigned int resultEax;
    unsigned int resultEbx;
    unsigned int resultEdx;

    __asm__("movl $0xa, %%eax" : ); // Moves 0xA in EAX: CPUID input param to get performance monitoring info
    __asm__("cpuid" : );
    __asm__("movl %%eax, %0" :"=r"(resultEax) : :);
    __asm__("movl %%ebx, %0" :"=r"(resultEbx) : :);
    __asm__("movl %%edx, %0" :"=r"(resultEdx) : :);

    printf("%-82s =  %2u\n", "Version ID of architectural performance monitoring" , resultEax & 255U); // Bits 07 to 00
    printf("%-82s =  %2u\n", "Number of general-purpose performance monitoring counter per logical processor", (resultEax >> 8) & 255); // Bits 15 to 08
    printf("%-82s =  %2u\n", "Bit width of general-purpose performance monitoring counter", (resultEax >> 16) & 255); // Bits 23 to 16
    printf("%-82s =  %2u\n", "Length of EBX bit vector to enumerate architectural performance monitoring events", (resultEax >> 24) & 255); // Bits 31 to 24
    printf("\n");

    printf("%-82s =  %2u\n", "Core cycle event (0 if available, 1 if not)", resultEbx & 1); // Bits 00
    printf("%-82s =  %2u\n", "Instruction retired event (0 if available, 1 if not)", (resultEbx >> 1) & 1); // Bits 01
    printf("%-82s =  %2u\n", "Reference cycles event (0 if available, 1 if not)", (resultEbx >> 2) & 1); // Bits 02
    printf("%-82s =  %2u\n", "Last level cache reference event (0 if available, 1 if not)", (resultEbx >> 3) & 1); // Bits 03
    printf("%-82s =  %2u\n", "Last level cache misses event (0 if available, 1 if not)", (resultEbx >> 4) & 1); // Bits 04
    printf("%-82s =  %2u\n", "Branch instruction retired event (0 if available, 1 if not)", (resultEbx >> 5) & 1); // Bits 05
    printf("%-82s =  %2u\n", "Branch mispredict retired event (0 if available, 1 if not)", (resultEbx >> 6) & 1); // Bits 06
    printf("\n");

    printf("%-82s =  %2u\n", "Number of fixed-function performance counters", (resultEdx >> 0) & 15); // Bits 04 to 00
    printf("%-82s =  %2u\n", "Bit width of fixed-function performance counters", (resultEdx >> 5) & 255); // Bits 12 to 05

    return 0;
}

--------------020107000105030703020604--
