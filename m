From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Two questions on perf dwarf callchains
Date: Wed, 22 Jan 2014 18:55:29 +0100
Message-ID: <20140122175529.GX20765@two.firstfloor.org>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
 <87d2jq1i7q.fsf@tassilo.jf.intel.com>
 <1390001852.8555.8.camel@nb-andreolini>
 <20140118044203.GR20765@two.firstfloor.org>
 <1390401626.22168.4.camel@nb-andreolini.mat.unimo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:36592 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaAVRzb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jan 2014 12:55:31 -0500
Content-Disposition: inline
In-Reply-To: <1390401626.22168.4.camel@nb-andreolini.mat.unimo.it>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mauro Andreolini <mauro.andreolini@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Wed, Jan 22, 2014 at 03:40:26PM +0100, Mauro Andreolini wrote:
> Il giorno sab, 18/01/2014 alle 05.42 +0100, Andi Kleen ha scritto:
> > The dwarf information should be present unless explicitely disabled.
> > It's either a libunwind or compiler problem. You could file a gcc bug
> > I suppose. Also check if gdb can backtrace through it. If that works
> > it's likely unwind.
> gdb can backtrace perfectly through ls -lR /. Also, recompiling the

You tested it on the same IP as perf failed on, correct?
It will depend on the exact location.

> whole system with -fno-omit-frame-pointer makes perf record & report
> work like a charm. So I guess it must be the unwinder.

Please report it to the libunwind developers.

-Andi
