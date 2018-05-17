From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH 01/11] perf tests parse-events: Add intel_pt parse test
Date: Thu, 17 May 2018 17:54:10 -0500
Message-ID: <20180517175410.d23409d805581923bc456ec2@arm.com>
References: <20180516144908.22212-1-acme@kernel.org>
        <20180516144908.22212-2-acme@kernel.org>
        <20180516163355.d8e4c669ad29d416e9ffb13e@arm.com>
        <20180517201553.GB25467@kernel.org>
        <20180517205811.GE12497@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517205811.GE12497@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, 17 May 2018 22:58:11 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Thu, May 17, 2018 at 05:15:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > So parse_state->error == NULL, Jiri, ideas?
> 
> yep, we don't use it in tests.. and when trying intel_pt on
> system without that pmu, the parse_events_add_pmu fails
> and store the error to NULL.. we should check on that err pointer
> 
> wrt to the test itself, how about we add callback
> to check if the test is valid before we run it,
> something like below
> jirka

That diff makes this test pass again on x86 without an intel_pt, and
on Arm32/64 (the intel_pt test gets skipped on those machines):

Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
