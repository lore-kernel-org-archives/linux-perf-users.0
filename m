From: Greg KH <greg@kroah.com>
Subject: Re: Scheduler benchmarks
Date: Tue, 18 Aug 2020 16:36:33 +0200
Message-ID: <20200818143633.GA628293@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> Hi all,
> 
> I’ve two identical Linux systems with only kernel differences.

What are the differences in the kernels?

> While doing kernel profiling with perf, I got the below mentioned
> metrics for Scheduler benchmarks.
> 
> 1st system (older kernel version compared to the other system) benchmark result:
> 
> $ perf bench sched messaging -g 64
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 64 groups == 2560 processes run
> 
>      Total time: 2.936 [sec]
> 
> 
> 2nd system benchmark result:
> 
> $ perf bench sched messaging -g 64
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 64 groups == 2560 processes run
> 
>      Total time: 10.074 [sec]
> 
> 
> So as per scheduler benchmark results, clearly a huge difference
> between two systems.
> Can anyone suggest to me how to dive deeper to know the root cause for
> it.

Look a the differences between your different kernels, that would be a
great start :)

good luck!

greg k-h
