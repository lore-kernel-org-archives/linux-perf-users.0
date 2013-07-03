From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Link between Intel documentation events and perf list events
Date: Wed, 3 Jul 2013 15:28:44 +0200
Message-ID: <20130703132844.GJ6123@two.firstfloor.org>
References: <51D1AA04.7060403@insa-lyon.fr>
 <8761wt62f8.fsf@tassilo.jf.intel.com>
 <51D286E0.2070500@insa-lyon.fr>
 <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com>
 <51D2D69E.9020207@gmail.com>
 <20130702144904.GY6123@two.firstfloor.org>
 <51D3E9A5.2010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:37143 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab3GCN2r (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Jul 2013 09:28:47 -0400
Content-Disposition: inline
In-Reply-To: <51D3E9A5.2010804@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Andreas Hollmann <hollmann@in.tum.de>, Manuel Selva <manuel.selva@insa-lyon.fr>, linux-perf-users@vger.kernel.org

>     __asm__("movl $0xa, %%eax" : ); // Moves 0xA in EAX: CPUID input param to get performance monitoring info
>     __asm__("cpuid" : );
>     __asm__("movl %%eax, %0" :"=r"(resultEax) : :);
>     __asm__("movl %%ebx, %0" :"=r"(resultEbx) : :);
>     __asm__("movl %%edx, %0" :"=r"(resultEdx) : :);

This is not a correct way to write gcc inline assembler, you cannot 
assume that registers stay valid between assembler statements.

The easiest way is to use the macros from cpuid.h.

Here's a valid test program. Various Intel CPUs report REF_TSC (2) not
there, but it's really there, just not quite following the
descriptions. Other than that the architectural events are generally
available.

#include <cpuid.h>
#include <stdio.h>
int main()
{
	unsigned a, b, c, d;
	/* check __get_cpuid_max here */
	__cpuid(10, a, b, c, d);
	printf("eax: %x ebx %x ecx %x edx %x\n", a, b, c, d);
	int i;
	for (i = 0; i < 10; i++) 
		if (b & (1 << i))
			printf("event %d not supported\n", i);
	return 0;
}


-Andi
