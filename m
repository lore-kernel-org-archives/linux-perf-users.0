From: Milian Wolff <mail@milianw.de>
Subject: Re: Access to backtraces from user-space tracepoint callback in perf-script?
Date: Sat, 17 May 2014 13:24:16 +0200
Message-ID: <2081629.cxlLP7Yh7G@minime>
References: <1998748.ORBRrU6aol@milian-kdab2> <1944165.rOQGbuz1ZM@milian-kdab2> <y0mlhu14sz5.fsf@fche.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:33348 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787AbaEQLYW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 17 May 2014 07:24:22 -0400
In-Reply-To: <y0mlhu14sz5.fsf@fche.csb>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-perf-users@vger.kernel.org

On Friday 16 May 2014 11:57:02 Frank Ch. Eigler wrote:
> Milian Wolff <mail@milianw.de> writes:
> > [...]
> > 
> >> >> today I played around with perf-script(-python) and custom
> >> >> tracepoints.
> >> >> What I could not figure out so far is how to print a backtrace from
> >> >> the
> >> >> python callback. [...]
> 
> While you wait, you might try systemtap, wherein there exists support
> not just for plain C-level backtracing (print_ubacktrace() as for any
> other program), but also python source-level backtracing (via a tapset
> function).
> 
> https://sourceware.org/systemtap/examples/#general/py2example.stp

Hey,

thanks for the hint. But I never got SystemTap to work on any of my machines 
:-/

For now I'll stick to manual libunwind + libbacktrace + LD_PRELOAD tracing. 
But I'd love to see this available in perf eventually.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
