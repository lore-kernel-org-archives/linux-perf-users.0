From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Size of perf data files
Date: Wed, 26 Nov 2014 13:06:17 -0300
Message-ID: <20141126160617.GD30226@kernel.org>
References: <1601237.BEhNSa8l6d@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51561 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbaKZQGY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 11:06:24 -0500
Content-Disposition: inline
In-Reply-To: <1601237.BEhNSa8l6d@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Em Wed, Nov 26, 2014 at 01:47:41PM +0100, Milian Wolff escreveu:
> I wonder whether there is a way to reduce the size of perf data files. Esp. 
> when I collect call graph information via Dwarf on user space applications, I 
> easily end up with multiple gigabytes of data in just a few seconds.
 
> I assume currently, perf is built for lowest possible overhead in mind. But 
> could maybe a post-processor be added, which can be run after perf is finished 
> collecting data, that aggregates common backtraces etc.? Essentially what I'd 
> like to see would be something similar to:
 
> perf report --stdout | gzip > perf.report.gz
> perf report -g graph --no-children -i perf.report.gz
 
> Does anything like that exist yet? Or is it planned? 

No, it doesn't, and yes, it would be something nice to have, i.e. one
that would process the file, find the common backtraces, and for that
probably we would end up using the existing 'report' logic and then
refer to those common backtraces by some index into a new perf.data file
section, perhaps we could use the features code for that...

But one thing you can do now to reduce the size of perf.data files with
dwarf callchains is to reduce the userspace chunk it takes, what is
exactly the 'perf record' command line you use?

The default is to get 8KB of userspace stack per sample, from
'perf record --help':

    -g             enables call-graph recording
        --call-graph <mode[,dump_size]>
                   setup and enables call-graph (stack chain/backtrace) recording: fp dwarf
    -v, --verbose  be more verbose (show counter open errors, etc)

So, please try with something like:

 perf record --call-graph dwarf,512

And see if it is enough for your workload and what kind of effect you
notice on the perf.data file size. Play with that dump_size, perhaps 4KB
would be needed if you have deep callchains, perhaps even less would do.

Something you can use to speed up the _report_ part is:

        --max-stack <n>   Set the maximum stack depth when parsing the
                          callchain, anything beyond the specified depth
                          will be ignored. Default: 127

But this won't reduce the perf.data file, obviously.

- Arnaldo
