From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf stat: Add support to print counts for fixed times
Date: Wed, 24 Jan 2018 08:48:13 +0100
Message-ID: <20180124074813.GC8473@krava>
References: <1516761799-25350-1-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516761799-25350-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 24, 2018 at 03:43:19AM +0100, ufo19890607 wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> Hi Jirka
> And how can you control the output for perf stat, if I don't want to use the 
> "sleep" workload, like some user programs. I want to check the "cycles"
> for this program when it just begin to run.
> 
> root@node10:/home$ gcc -g -o malloc malloc.c
> root@node10:/home$ ./perf stat -e cycles -I 1000 --times-print 3 ./malloc &
> [1] 32586
> #           time             counts unit events
>      1.000094153      2,914,162,979      cycles                                                      
>      2.000323667      3,062,832,799      cycles                                                      
>      3.000443807      3,063,146,609      cycles

yea, we can't do that now.. we have the exat oposit option in record,
because sometimes you want to skip the initialization phase of the
workload.. any special reason why you want to see just the begining?

we can add this, but maybe change the option name a bit

your code now allows this even if it's not in interval mode

	[jolsa@krava perf]$ sudo ./perf stat -e cycles -a --times-print 3

	 Performance counter stats for 'system wide':

	     1,469,288,467      cycles                                                      

	       3.000502814 seconds time elapsed


I think we should either keep it interval specific:

  perf stat -e cycles -I 1000 --interval-count=3

or make the option general and time based:

  perf stat -e cycles --time=3000


or maybe both ;-)

thanks,
jirka
