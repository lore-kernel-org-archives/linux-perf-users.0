From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
Date: Tue, 24 Mar 2020 11:16:41 -0500
Message-ID: <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200320151355.66302-1-agerstmayr@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>, linux-perf-users@vger.kernel.org
Cc: Martin Spier <mspier@netflix.com>, Brendan Gregg <bgregg@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 3/20/20 10:13 AM, Andreas Gerstmayr wrote:
> This script works in tandem with d3-flame-graph to generate flame graphs
> from perf. It supports two output formats: JSON and HTML (the default).
> The HTML format will look for a standalone d3-flame-graph template file in
> /usr/share/d3-flame-graph/d3-flamegraph-base.html and fill in the collected
> stacks.
> 
> Usage:
> 
>     perf record -a -g -F 99 sleep 60
>     perf script report flamegraph

On Ubuntu 19.10, where python 2.7 is still the default, I get:

$ perf script report flamegraph
  File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 46
    print(f"Flame Graph template {self.args.template} does not " +
                                                               ^
SyntaxError: invalid syntax
Error running python script /usr/libexec/perf-core/scripts/python/flamegraph.py

Installing libpython3-dev doesn't help.

$ perf script -s lang

Scripting language extensions (used in perf script -s [spec:]script.[spec]):

  Perl                                       [Perl]
  pl                                         [Perl]
  Python                                     [Python]
  py                                         [Python]

Should there be a python3 in that list?

Thanks,

Kim
