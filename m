From: Arun Sharma <asharma@fb.com>
Subject: Re: perf and gprof2dot
Date: Mon, 17 Oct 2011 16:30:29 -0700
Message-ID: <20111017233029.GA8704@dev1756.snc6.facebook.com>
References: <1110171539460.18449@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail016.snc4.facebook.com ([66.220.144.150]:43155 "EHLO
	intmgw003.snc4.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752850Ab1JQXua (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Oct 2011 19:50:30 -0400
Content-Disposition: inline
In-Reply-To: <1110171539460.18449@jrf.vwaro.pbz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Hills <mark@pogo.org.uk>
Cc: linux-perf-users@vger.kernel.org

On Mon, Oct 17, 2011 at 05:38:22PM +0100, Mark Hills wrote:
> I'm using perf very successfully, and recently in place of oprofile.
> 
> But I wondered if there is a way for 'perf report' to output a gprof-style 
> callgraph (similar to 'oprofile -c')?
> 
> Aside from being familiar, the motivation is so that it can be displayed 
> as a directed graph (not tree) by the excellent gprof2dot [1] tool.

perf record -ag -- sleep 1
perf script | script-below.py | gprof2dot -f hprof | dot -Tpng -o graph.png

It's probably better to teach gprof2dot how to parse the output of perf
script. But this was the path of least resistance for me.

I've seen gprof2dot choke on large input sets though.

 -Arun

#!/usr/bin/env python

"""
Generate hprof compatible sample output so we could feed this into gprof2dot.py -f hprof
"""

import re, string, sys
from optparse import OptionParser
from operator import itemgetter

class KernelSample:
    def __init__(self):
	pass

chain_re = re.compile('^\s*(?P<ip>\S+)\s+(?P<sym>.*)')
def process(file):
    global traces
    rdata = file.read()
    rdata = rdata.split('\n\n')
    for chain in rdata:
        ips = []
        try:
            for line in chain.splitlines()[1:]:
		mod_index = line.rfind('(')
		if mod_index != -1:
		    module = line[mod_index:]
		    line = line[:mod_index]
		else:
		    module = ''
		m = chain_re.match(line)
		ip = ''
		if m: 
		    #print module, m.group('ip'), m.group('sym')
		    ip = m.group('sym') 
                if module.find('kernel') != -1:
                    raise KernelSample()
    	        # strip parens
    	        module = module[1:-1]
                ips.append((ip, module))
        except KernelSample:
    	    continue
	if options.filter:
	    ignore = 1
	    for ip, module in ips:
	        if options.filter.match(ip):
		    ignore = 0
	    if ignore: continue
        trace = tuple(ips)
        if trace in traces.keys():
            traces[trace] += 1
        else:
            traces[trace] = 1

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option("-q", "--quiet",
                      action="store_false", dest="verbose", default=True,
                      help="don't print status messages to stdout")
    parser.add_option("-t", "--threshold", dest="threshold", default=1,
                      help="Ignore traces that have counts less than this")
    parser.add_option("-p", "--top", dest="top", default=-1,
                      help="Consider only the top N traces")
    parser.add_option("-f", "--filter", dest="filter", default=None,
                      help="Consider only traces that match this regex")

    (options, args) = parser.parse_args()
    if options.filter:
        options.filter = re.compile(options.filter)
    traces = {}
    for file in args:
	process(open(file))

    if not args:
	process(sys.stdin)
  
    options.top = int(options.top)
    traces = sorted(traces.iteritems(), key=itemgetter(1), reverse=True)
    if options.top != -1: traces = traces[:options.top]

    map = {} 
    print '-------' 
    count = 0
    for trace, hits in traces:
	map[trace] = count
        print "TRACE %d:" % count
	count += 1
        for frame in trace:
    	    ip, module = frame
	    print "\t%s (%s:0)" % (ip, module)

    print 'blah'
    print 'blah'
    print 'CPU blah'
    for trace, count in traces:
	id = map[trace]
        #rank, percent_self, percent_accum, count, traceid, method
	try:
            print '1 1 1 %d %d %s' % (count, id, trace[0][0])
	except:
	    import traceback
	    print trace
	    #traceback.print_exc(file=sys.stderr)
	    continue

    print 'CPU blah'
