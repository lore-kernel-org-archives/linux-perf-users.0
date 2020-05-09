From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH v3 00/14] Share events between metrics
Date: Fri, 8 May 2020 17:12:38 -0700
Message-ID: <20200509001238.GD3538@tassilo.jf.intel.com>
References: <20200508053629.210324-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 07, 2020 at 10:36:15PM -0700, Ian Rogers wrote:
> Metric groups contain metrics. Metrics create groups of events to
> ideally be scheduled together. Often metrics refer to the same events,
> for example, a cache hit and cache miss rate. Using separate event
> groups means these metrics are multiplexed at different times and the
> counts don't sum to 100%. More multiplexing also decreases the
> accuracy of the measurement.
> 
> This change orders metrics from groups or the command line, so that
> the ones with the most events are set up first. Later metrics see if
> groups already provide their events, and reuse them if
> possible. Unnecessary events and groups are eliminated.

Yes some improvements here are great.

> 
> The option --metric-no-group is added so that metrics aren't placed in
> groups. This affects multiplexing and may increase sharing.
> 
> The option --metric-mo-merge is added and with this option the
> existing grouping behavior is preserved.

Could we also make this a per metric option, like

-M foo:nomerge,... 

or somesuch? Okay i suppose this could be a followon.

Ultimatively like you said we probably want to configure
defaults in the event file.

-Andi
