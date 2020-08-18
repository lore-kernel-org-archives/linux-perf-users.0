From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: Scheduler benchmarks
Date: Tue, 18 Aug 2020 23:01:35 +0530
Message-ID: <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200818171457.GA736234@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > >
> > > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > > Hi all,
> > > >
> > > > I=E2=80=99ve two identical Linux systems with only kernel differenc=
es.
> > >
> > > What are the differences in the kernels?
>
> You didn't answer this question, is this the same kernel source being
> compared here?  Same version?  Same compiler?  Everything identical?
Both systems are having exactly the same hardware configuration.
Compiler and kernel versions are different. One system has Ubuntu
16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
version 7.5.0).



>
> > > > While doing kernel profiling with perf, I got the below mentioned
> > > > metrics for Scheduler benchmarks.
> > > >
> > > > 1st system (older kernel version compared to the other system) benc=
hmark result:
> > > >
> > > > $ perf bench sched messaging -g 64
> > > > # Running 'sched/messaging' benchmark:
> > > > # 20 sender and receiver processes per group
> > > > # 64 groups =3D=3D 2560 processes run
> > > >
> > > >      Total time: 2.936 [sec]
> > > >
> > > >
> > > > 2nd system benchmark result:
> > > >
> > > > $ perf bench sched messaging -g 64
> > > > # Running 'sched/messaging' benchmark:
> > > > # 20 sender and receiver processes per group
> > > > # 64 groups =3D=3D 2560 processes run
> > > >
> > > >      Total time: 10.074 [sec]
> > > >
> > > >
> > > > So as per scheduler benchmark results, clearly a huge difference
> > > > between two systems.
> > > > Can anyone suggest to me how to dive deeper to know the root cause =
for
> > > > it.
> > >
> > > Look a the differences between your different kernels, that would be =
a
> > > great start :)
> > I created the difference between two kernel config files and then
> > tried to spot the CONFIG*SCHED* differences.
> > Interestingly I see the difference in I/O scheduler config, 1st system
> > is set to =E2=80=9Cdeadline=E2=80=9D and other one is set to =E2=80=9Cc=
fq=E2=80=9D. So I made it equal
> > by echoing to =E2=80=9C/sys/block/<disk device>/queue/scheduler" but st=
ill no
> > change in scheduler benchmark metrics.
> >
> > Is it the correct way to find the differences between kernels? If so,
> > what other important CONFIG_* variables need to consider?
> >
> >
> > $ cat config.patch | grep -i sched
> >
> >  CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> >  CONFIG_CGROUP_SCHED=3Dy
> >  CONFIG_FAIR_GROUP_SCHED=3Dy
> >  # CONFIG_RT_GROUP_SCHED is not set
> >  # IO Schedulers
> > @@ -369,10 +434,14 @@ CONFIG_IOSCHED_NOOP=3Dy
> >  CONFIG_IOSCHED_DEADLINE=3Dy
> >  CONFIG_IOSCHED_CFQ=3Dy
> >  CONFIG_CFQ_GROUP_IOSCHED=3Dy
> > -CONFIG_DEFAULT_IOSCHED=3D"deadline"
> > +CONFIG_DEFAULT_IOSCHED=3D"cfq"
> > +CONFIG_MQ_IOSCHED_DEADLINE=3Dm
> > +CONFIG_MQ_IOSCHED_KYBER=3Dm
> > +CONFIG_IOSCHED_BFQ=3Dm
> > +CONFIG_BFQ_GROUP_IOSCHED=3Dy
> >  CONFIG_SCHED_SMT=3Dy
> >  CONFIG_SCHED_MC=3Dy
> > +CONFIG_SCHED_MC_PRIO=3Dy
> > +# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>
> There's lots of other options that affect performance, depending on your
> specific benchmark, other than these.
>
> good luck!
>
> greg k-h



--=20
Thanks,
Sekhar
