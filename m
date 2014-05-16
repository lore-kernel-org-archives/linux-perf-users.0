From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: Access to backtraces from user-space tracepoint callback in perf-script?
Date: Fri, 16 May 2014 11:57:02 -0400
Message-ID: <y0mlhu14sz5.fsf@fche.csb>
References: <1998748.ORBRrU6aol@milian-kdab2>
	<4531806.6Q1YW4Luy6@milian-kdab2> <87lhu5mc68.fsf@sejong.aot.lge.com>
	<1944165.rOQGbuz1ZM@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbaEPP5O (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 16 May 2014 11:57:14 -0400
In-Reply-To: <1944165.rOQGbuz1ZM@milian-kdab2> (Milian Wolff's message of "Wed, 14 May 2014 10:47:43 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org


Milian Wolff <mail@milianw.de> writes:

> [...]
>> >> today I played around with perf-script(-python) and custom tracepoints.
>> >> What I could not figure out so far is how to print a backtrace from the
>> >> python callback. [...]

While you wait, you might try systemtap, wherein there exists support
not just for plain C-level backtracing (print_ubacktrace() as for any
other program), but also python source-level backtracing (via a tapset
function).

https://sourceware.org/systemtap/examples/#general/py2example.stp

- FChE
