From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf cgroup: simplify arguments if track multiple
 events for a cgroup
Date: Wed, 31 Jan 2018 10:22:16 +0100
Message-ID: <20180131092216.GB3313@krava>
References: <20180129154805.GA6284@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129154805.GA6284@localhost.didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 29, 2018 at 11:48:09PM +0800, weiping zhang wrote:
> if use -G with one cgroup and -e with multiple events, only the first
> event has correct cgroup setting, all events from the second will track
> system-wide events.
> 
> if user want track multiple events for a specific cgroup, user must give
> parameters like follow:
> $ perf stat -e e1 -e e2 -e e3 -G test,test,test
> this patch simplify this case, just type one cgroup, like following:
> $ perf stat -e e1 -e e2 -e e3 -G test
> 
> $ mkdir -p /sys/fs/cgroup/perf_event/test
> $ perf stat -e cycles -e cache-misses  -a -I 1000 -G test
> 
> before:
>      1.001007226      <not counted>      cycles                    test
>      1.001007226              7,506      cache-misses
> 
> after:
>      1.000834097      <not counted>      cycles                    test
>      1.000834097      <not counted>      cache-misses              test
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
