From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Loop block overhead
Date: Wed, 14 May 2014 09:37:00 +0900
Message-ID: <87ha4tmc0j.fsf@sejong.aot.lge.com>
References: <CAPZR5J0vJU4X4H+f3gs3CK4duw6TaQuXS1q+xWkS0EgJ_DKiBw@mail.gmail.com>
	<87r44elgry.fsf@tassilo.jf.intel.com>
	<CAPZR5J1Rc8jcB7c-f+9h-SYpgkWBQy5h+HPV4_iYQ7NrZN8Vcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo04.lge.com ([156.147.1.127]:52220 "EHLO
	lgeamrelo04.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaENAhE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 May 2014 20:37:04 -0400
In-Reply-To: <CAPZR5J1Rc8jcB7c-f+9h-SYpgkWBQy5h+HPV4_iYQ7NrZN8Vcw@mail.gmail.com>
	(lhmaster's message of "Wed, 7 May 2014 14:55:05 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "lhmaster2 ." <lhmaster2@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Hi lhmaster,

On Wed, 7 May 2014 14:55:05 -0300, lhmaster wrote:
> Thank you for the info.
>
> I researched a bit and found that srcline uses addr2line capabilities
> to map memory addressed into source lines. Nevertheless, as I invoke
>
> $ perf report -s srcline, sys
>
> only the original mem addresses are printed. Should I pass some
> special parameter for perf record to make it work?

Nope.  But you need to make sure that your binary was built with
debuginfo and the binutils is available on your system.

Thanks,
Namhyung
