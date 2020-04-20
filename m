From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 11/16] perf intel-pt: Add support for synthesizing
 callchains for regular events
Date: Sun, 19 Apr 2020 20:04:57 -0700
Message-ID: <20200420030457.GA608746@tassilo.jf.intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-12-adrian.hunter@intel.com>
 <20200416151443.GA2650@kernel.org>
 <5b8f28f5-968f-bfff-68af-ed0350a90765@intel.com>
 <20200417213704.GB21512@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200417213704.GB21512@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> Andi? My concern is that if this is the optimal solution for a good
> subset of the machines out there, then we need to make it easy to use,
> even transparent, if possible and safe to take that path.

I'm not sure it's that great in the general case.  A PT call graph
would need a full PT recording from start to end.

The problem with full PT recording is that it doesn't really work for a
lot of workloads, because for anything doing enough computation the CPU
just generates too much data and you end up with a lot of gaps in the
trace when the perf record flushing cannot keep up.

Also even if it worked you might end up with far too much data that
will take a long time to process.

So I suspect it wouldn't work often enough to be generally useful.

For the leader sample case we just want to use some non PT method
to get the call graph.

-Andi
