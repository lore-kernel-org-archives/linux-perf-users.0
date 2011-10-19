From: Mark Hills <mark@pogo.org.uk>
Subject: Re: perf and gprof2dot
Date: Wed, 19 Oct 2011 15:34:41 +0100 (BST)
Message-ID: <1110191529070.13784@jrf.vwaro.pbz>
References: <1110171539460.18449@jrf.vwaro.pbz> <20111017233029.GA8704@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:63310 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752901Ab1JSOeo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 19 Oct 2011 10:34:44 -0400
In-Reply-To: <20111017233029.GA8704@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, 17 Oct 2011, Arun Sharma wrote:

> On Mon, Oct 17, 2011 at 05:38:22PM +0100, Mark Hills wrote:
> > I'm using perf very successfully, and recently in place of oprofile.
> > 
> > But I wondered if there is a way for 'perf report' to output a gprof-style 
> > callgraph (similar to 'oprofile -c')?
> > 
> > Aside from being familiar, the motivation is so that it can be displayed 
> > as a directed graph (not tree) by the excellent gprof2dot [1] tool.
> 
> perf record -ag -- sleep 1
> perf script | script-below.py | gprof2dot -f hprof | dot -Tpng -o graph.png

Thanks Arun, interesting script.
 
> It's probably better to teach gprof2dot how to parse the output of perf 
> script. But this was the path of least resistance for me.

Since we spoke, the author of gprof2dot has added preliminary support for 
perf to his repository. It's not fully complete and is just a test; eg. 
the call ratios are wrong as gprof2dot expects them from the caller (not 
callee) perspective.

  $ perf report --show-nr-samples -g flat,0 | gprof2dot -f perf

I did not have chance to look at what extra work is needed, but the 
initial results are promising.

-- 
Mark
