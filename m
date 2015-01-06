From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Size of perf data files
Date: Mon, 05 Jan 2015 21:39:49 -0800
Message-ID: <87ppas31sq.fsf@tassilo.jf.intel.com>
References: <CALQF7ZygJpx=Lf0Dc70=cRRCheF_8SFos8sv8z0kjiog2Do0Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42056 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbbAFFjt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 Jan 2015 00:39:49 -0500
In-Reply-To: <CALQF7ZygJpx=Lf0Dc70=cRRCheF_8SFos8sv8z0kjiog2Do0Zg@mail.gmail.com>
	(Yale Zhang's message of "Mon, 5 Jan 2015 19:21:22 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yale Zhang <yzhang1985@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Yale Zhang <yzhang1985@gmail.com> writes:

> Perf developers,
> I'm also very interested in reducing the size of the data files when
> reporting call stacks. Currently, profiling 30s of execution with call

The simplest way is to lower the frequency. Especially don't
use adaptive frequency (which is the default). This also
lowers overhead quite a bit. Also don't use dwarf unwinding.
It is very expensive.

There are some other ways.

I suspect you would most of what you want by just running
a fast compressor (snappy or LZO) at perf record time. That would
be likely a useful addition.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
