From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf tool cross build issue
Date: Wed, 15 Aug 2012 19:31:35 -0600
Message-ID: <502C4D77.7010505@gmail.com>
References: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54180 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab2HPBbp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Aug 2012 21:31:45 -0400
Received: by yhmm54 with SMTP id m54so2442529yhm.19
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Aug 2012 18:31:44 -0700 (PDT)
In-Reply-To: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Koteswararao Nelakurthi <knelakurthi@mvista.com>
Cc: linux-perf-users@vger.kernel.org

On 8/13/12 9:00 PM, Koteswararao Nelakurthi wrote:
> I am trying to cross compile Perf source present in 2.6.35/tools/perf
> directory for ARM.in ubuntu machine.(x86 is host machine).But i am
> facing the following compilation error as compiler looks at host
> specific header files instead of looking at header files present in
> perf/ directory..Please provide Makefile changes required to compile
> successfully perf for ARM.{{{
>
> perf>make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
>

Do you have a sysroot for the cross-compile environment? e.g., for WRL3 
we use:

CROSS_COMPILE = i586-wrs-linux-gnu-
CROSS_SYSROOT = /path/to/cross-compile/sysroot

make CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH) CC="$(CROSS_COMPILE)gcc 
--sysroot=$(CROSS_SYSROOT)"

David
