From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Wed, 22 Jan 2014 15:40:26 +0100
Message-ID: <1390401626.22168.4.camel@nb-andreolini.mat.unimo.it>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <87d2jq1i7q.fsf@tassilo.jf.intel.com>
	 <1390001852.8555.8.camel@nb-andreolini>
	 <20140118044203.GR20765@two.firstfloor.org>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:32801 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbaAVOka (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jan 2014 09:40:30 -0500
Received: by mail-ee0-f45.google.com with SMTP id b15so4863733eek.32
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2014 06:40:30 -0800 (PST)
In-Reply-To: <20140118044203.GR20765@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Il giorno sab, 18/01/2014 alle 05.42 +0100, Andi Kleen ha scritto:
> The dwarf information should be present unless explicitely disabled.
> It's either a libunwind or compiler problem. You could file a gcc bug
> I suppose. Also check if gdb can backtrace through it. If that works
> it's likely unwind.
gdb can backtrace perfectly through ls -lR /. Also, recompiling the
whole system with -fno-omit-frame-pointer makes perf record & report
work like a charm. So I guess it must be the unwinder.

> unwind problems are unfortunately somewhat common (but most seem to
> be in handwritten assembler)
> 
> You'll also notice that dwarf unwind profiling is very expensive in overhead.
> I usually avoid it because of that.
Yes, I did, unfortunately.

I'll look into the other issue regarding the compressed kernel modules.
Again, thanks for your time.

Cheers
Mauro
