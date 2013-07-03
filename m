From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Link between Intel documentation events and perf list events
Date: Wed, 03 Jul 2013 16:02:50 +0200
Message-ID: <51D42F0A.70806@gmail.com>
References: <51D1AA04.7060403@insa-lyon.fr> <8761wt62f8.fsf@tassilo.jf.intel.com> <51D286E0.2070500@insa-lyon.fr> <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com> <51D2D69E.9020207@gmail.com> <20130702144904.GY6123@two.firstfloor.org> <51D3E9A5.2010804@gmail.com> <20130703132844.GJ6123@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:47818 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3GCOCx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Jul 2013 10:02:53 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so98673bkc.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2013 07:02:51 -0700 (PDT)
In-Reply-To: <20130703132844.GJ6123@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thanks, the correct program is reporting all events as available.

Manu

On 07/03/2013 03:28 PM, Andi Kleen wrote:
> #include <cpuid.h>
> #include <stdio.h>
> int main()
> {
> 	unsigned a, b, c, d;
> 	/* check __get_cpuid_max here */
> 	__cpuid(10, a, b, c, d);
> 	printf("eax: %x ebx %x ecx %x edx %x\n", a, b, c, d);
> 	int i;
> 	for (i = 0; i < 10; i++)
> 		if (b & (1 << i))
> 			printf("event %d not supported\n", i);
> 	return 0;
> }
