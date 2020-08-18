From: Greg KH <greg@kroah.com>
Subject: Re: Scheduler benchmarks
Date: Tue, 18 Aug 2020 19:14:57 +0200
Message-ID: <20200818171457.GA736234@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > Hi all,
> > >
> > > I’ve two identical Linux systems with only kernel differences.
> >
> > What are the differences in the kernels?

You didn't answer this question, is this the same kernel source being
compared here?  Same version?  Same compiler?  Everything identical?

> > > While doing kernel profiling with perf, I got the below mentioned
> > > metrics for Scheduler benchmarks.
> > >
> > > 1st system (older kernel version compared to the other system) benchmark result:
> > >
> > > $ perf bench sched messaging -g 64
> > > # Running 'sched/messaging' benchmark:
> > > # 20 sender and receiver processes per group
> > > # 64 groups == 2560 processes run
> > >
> > >      Total time: 2.936 [sec]
> > >
> > >
> > > 2nd system benchmark result:
> > >
> > > $ perf bench sched messaging -g 64
> > > # Running 'sched/messaging' benchmark:
> > > # 20 sender and receiver processes per group
> > > # 64 groups == 2560 processes run
> > >
> > >      Total time: 10.074 [sec]
> > >
> > >
> > > So as per scheduler benchmark results, clearly a huge difference
> > > between two systems.
> > > Can anyone suggest to me how to dive deeper to know the root cause for
> > > it.
> >
> > Look a the differences between your different kernels, that would be a
> > great start :)
> I created the difference between two kernel config files and then
> tried to spot the CONFIG*SCHED* differences.
> Interestingly I see the difference in I/O scheduler config, 1st system
> is set to “deadline” and other one is set to “cfq”. So I made it equal
> by echoing to “/sys/block/<disk device>/queue/scheduler" but still no
> change in scheduler benchmark metrics.
> 
> Is it the correct way to find the differences between kernels? If so,
> what other important CONFIG_* variables need to consider?
> 
> 
> $ cat config.patch | grep -i sched
> 
>  CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_FAIR_GROUP_SCHED=y
>  # CONFIG_RT_GROUP_SCHED is not set
>  # IO Schedulers
> @@ -369,10 +434,14 @@ CONFIG_IOSCHED_NOOP=y
>  CONFIG_IOSCHED_DEADLINE=y
>  CONFIG_IOSCHED_CFQ=y
>  CONFIG_CFQ_GROUP_IOSCHED=y
> -CONFIG_DEFAULT_IOSCHED="deadline"
> +CONFIG_DEFAULT_IOSCHED="cfq"
> +CONFIG_MQ_IOSCHED_DEADLINE=m
> +CONFIG_MQ_IOSCHED_KYBER=m
> +CONFIG_IOSCHED_BFQ=m
> +CONFIG_BFQ_GROUP_IOSCHED=y
>  CONFIG_SCHED_SMT=y
>  CONFIG_SCHED_MC=y
> +CONFIG_SCHED_MC_PRIO=y
> +# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

There's lots of other options that affect performance, depending on your
specific benchmark, other than these.

good luck!

greg k-h
