From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf not measuring LLC events?
Date: Mon, 21 Jan 2013 15:38:16 +0100
Message-ID: <20130121143816.GE1995@krava.brq.redhat.com>
References: <loom.20121215T192044-606@post.gmane.org>
 <loom.20130118T172647-728@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60781 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388Ab3AUOiU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Jan 2013 09:38:20 -0500
Content-Disposition: inline
In-Reply-To: <loom.20130118T172647-728@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jeff Johnson <jerojohn@ucsc.edu>
Cc: linux-perf-users@vger.kernel.org

On Fri, Jan 18, 2013 at 04:28:51PM +0000, Jeff Johnson wrote:
> Dervin Thunk <dervin.thunk <at> gmail.com> writes:
> 
> > 
> > Dear all,
> > 
> > I'm trying to measure the LLC events of a program. I'm running
> > linux-tools-3.2.0- 34 on a fairly recent 4 core Intel machine. For a
> > certain program that reads a 64 MB file into memory, I get
> > 
> >  Performance counter stats for './algo data/E.dna':
> > 
> >                  0 LLC-loads                                                   
> >                  0 LLC-load-misses
> 
> 
> Dervin, 
> I am experiencing the same issue. I am running perf on an i5 machine. Have you 
> gotten any feedback regarding this? 

I'm getting some 'sane' numbers on 2 cores i7 SandyBridge on 3.6.11-1.fc17.x86_64

not sure if this was broken back in 3.2.0

please be more specific on what system you're testing on
and provide whole perf stat command line

jirka
