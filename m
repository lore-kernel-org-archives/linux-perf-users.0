From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf trace report with time consumed
Date: Mon, 4 Apr 2016 08:14:08 +0200
Message-ID: <20160404061408.GA2137@krava.local>
References: <1894563.GPSC8z33rH@agathebauer>
 <20160330215832.GG3420@kernel.org>
 <11979280.sfXiZ5YTfG@agathebauer>
 <4309725.73SKaCNb55@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38545 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbcDDGOL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Apr 2016 02:14:11 -0400
Content-Disposition: inline
In-Reply-To: <4309725.73SKaCNb55@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, perf group <linux-perf-users@vger.kernel.org>

On Sun, Apr 03, 2016 at 08:46:19PM +0200, Milian Wolff wrote:
> Jiri, see my mail below for the WIP patch below that triggers the crash when 
> DWARF callchains are enabled for `perf trace`.
> 
> Would be great if you could tell me what I'm missing.

would you please resend, I can't apply the one you posted

[jolsa@krava linux-perf]$ patch -p1 < /tmp/w
patching file tools/perf/builtin-trace.c
Hunk #1 FAILED at 34.
patch: **** malformed patch at line 126: PRINT_IP_OPT_DSO | PRINT_IP_OPT_SYM /* TODO print_opts*/,

thanks,
jirka
