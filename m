From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
Date: Tue, 24 Mar 2020 20:05:15 +0100
Message-ID: <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>, linux-perf-users@vger.kernel.org
Cc: Martin Spier <mspier@netflix.com>, Brendan Gregg <bgregg@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 24.03.20 17:16, Kim Phillips wrote:
> On Ubuntu 19.10, where python 2.7 is still the default, I get:
> 
> $ perf script report flamegraph
>    File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 46
>      print(f"Flame Graph template {self.args.template} does not " +
>                                                                 ^
> SyntaxError: invalid syntax
> Error running python script /usr/libexec/perf-core/scripts/python/flamegraph.py
> 
> Installing libpython3-dev doesn't help.

Hmm, I was hoping that I can drop support for Python 2 in 2020 ;) (it's 
officially EOL since Jan 1, 2020)

The Ubuntu 18.04 release notes mention that "Python 2 is no longer 
installed by default. Python 3 has been updated to 3.6. This is the last 
LTS release to include Python 2 in main." 
(https://wiki.ubuntu.com/BionicBeaver/ReleaseNotes) - so imho it should 
be fine to drop Python 2 support.

I tested it with a Ubuntu VM, and by default the Python bindings aren't 
enabled in perf (see 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1707875).

But you can compile perf and select Python 3:

$ make -j2 PYTHON=python3

in the perf source directory (libpython3-dev must be installed).


Does this work for you?


Cheers,
Andreas
