From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Event not supported
Date: Tue, 18 Feb 2014 20:50:30 +0100
Message-ID: <5303B986.2070801@gmail.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com> <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:53443 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaBRTun (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Feb 2014 14:50:43 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so11901389wes.37
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2014 11:50:42 -0800 (PST)
In-Reply-To: <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>, linux-perf-users@vger.kernel.org

CPUID is an X86 instruction: http://en.wikipedia.org/wiki/CPUID used to 
get information about the CPU. The Core performance counter extensions 
is mentioned on the wikipedia page.

You'll need to write assembly code to use this instruction or use 
cpuid.h. Here is an example of using this instruction from a previous 
answer on this list:

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


Manu

On 02/18/2014 07:42 PM, Martin Ichilevici de Oliveira wrote:
> performance counter extensions
> cpuid
