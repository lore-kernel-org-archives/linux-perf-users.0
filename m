From: Mauro Andreolini <mauro.andreolini@unimore.it>
Subject: Re: Two questions on perf dwarf callchains
Date: Tue, 04 Feb 2014 17:01:53 +0100
Message-ID: <1391529713.1174.22.camel@nb-andreolini.mat.unimo.it>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <20140129111844.GA1869@krava.brq.redhat.com>
	 <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
	 <20140130114751.GB1161@krava.brq.redhat.com>
	 <1391092999.1111.3.camel@nb-andreolini.mat.unimo.it>
	 <20140130154047.GB1827@krava.brq.redhat.com>
	 <1391437856.1135.8.camel@nb-andreolini.mat.unimo.it>
	 <1391527739.1174.16.camel@nb-andreolini.mat.unimo.it>
	 <20140204153526.GE1117@krava.brq.redhat.com>
Reply-To: mauro.andreolini@unimore.it
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:58520 "EHLO
	smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbaBDQB5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Feb 2014 11:01:57 -0500
In-Reply-To: <20140204153526.GE1117@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Jean Pihet <jean.pihet@linaro.org>

> I think I found only one unresolved symbol (it's always the
> > same one, maybe I screwed up the compilation):
> > 
> >      0.01%       ls  [kernel.kallsyms]  [k] do_raw_read_unlock
> >                  |
> >                  --- do_raw_read_unlock
> >                      _raw_read_unlock
> >                      0xffffffffa0154479 <--- HERE
> 
> hum, is there any symbol around that address?
> you can check /proc/kallsyms or vmlinux file from debug package
[Damn sorry for using my other e-mail account, I made a mistake].
/proc/kallsyms shows this:

ffffffffa01780c0 R crc16_table	[crc16]
ffffffffa0178000 T crc16	[crc16]
ffffffffa0154000 start_this_handle	[jbd2]
ffffffffa01669e0 b __key.27934	[jbd2]

I guess it's in start_this_handle()?

> > Is this going into mainline soon?
> 
> hopefully ;-) it's on review now..
> 
> thanks a lot for testing! please let us know any issues you spot
You welcome!

Mauro
