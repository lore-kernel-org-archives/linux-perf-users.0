From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Wed, 22 Jan 2014 19:02:30 +0100
Message-ID: <1390413750.5206.6.camel@nb-andreolini.mat.unimo.it>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <87d2jq1i7q.fsf@tassilo.jf.intel.com>
	 <1390001852.8555.8.camel@nb-andreolini>
	 <20140118044203.GR20765@two.firstfloor.org>
	 <1390401626.22168.4.camel@nb-andreolini.mat.unimo.it>
	 <20140122175529.GX20765@two.firstfloor.org>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:56500 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaAVSCd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jan 2014 13:02:33 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so4778305eak.16
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2014 10:02:32 -0800 (PST)
In-Reply-To: <20140122175529.GX20765@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Il giorno mer, 22/01/2014 alle 18.55 +0100, Andi Kleen ha scritto:
> On Wed, Jan 22, 2014 at 03:40:26PM +0100, Mauro Andreolini wrote:
> > Il giorno sab, 18/01/2014 alle 05.42 +0100, Andi Kleen ha scritto:
> > > The dwarf information should be present unless explicitely disabled.
> > > It's either a libunwind or compiler problem. You could file a gcc bug
> > > I suppose. Also check if gdb can backtrace through it. If that works
> > > it's likely unwind.
> > gdb can backtrace perfectly through ls -lR /. Also, recompiling the
> 
> You tested it on the same IP as perf failed on, correct?
> It will depend on the exact location.
Yes, I did.

> 
> > whole system with -fno-omit-frame-pointer makes perf record & report
> > work like a charm. So I guess it must be the unwinder.
> 
> Please report it to the libunwind developers.
OK. Will do.

Mauro
