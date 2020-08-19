From: Greg KH <greg@kroah.com>
Subject: Re: Scheduler benchmarks
Date: Wed, 19 Aug 2020 12:42:54 +0200
Message-ID: <20200819104254.GA41946@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: peter enderborg <peter.enderborg@sony.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Aug 19, 2020 at 03:46:06PM +0530, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 11:45 PM peter enderborg
> <peter.enderborg@sony.com> wrote:
> >
> > On 8/18/20 7:53 PM, Muni Sekhar wrote:
> > > On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
> > >> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> > >>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> > >>>> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > >>>>> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > >>>>>> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > >>>>>>> Hi all,
> > >>>>>>>
> > >>>>>>> I’ve two identical Linux systems with only kernel differences.
> > >>>>>> What are the differences in the kernels?
> > >>>> You didn't answer this question, is this the same kernel source being
> > >>>> compared here?  Same version?  Same compiler?  Everything identical?
> > >>> Both systems are having exactly the same hardware configuration.
> > >>> Compiler and kernel versions are different. One system has Ubuntu
> > >>> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
> > >>> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
> > >>> version 7.5.0).
> > >> Those are _very_ different kernel versions, with many years and tens of
> > >> thousands of different changes between them.
> > >>
> > >> Hopefully the newer kernel is faster, so just stick with that :)
> > > But unfortunately the newer kernel is very slow, that is the reason
> > > for starting this investigation :)
> > > Any type of help,  and guidelines to dive deeper will be highly appreciated.
> >
> > On the 4.4 kernel you dont have
> >
> > +CONFIG_RETPOLINE=y
> > +CONFIG_INTEL_RDT=y
> Thanks! That is helpful. Yes, I see 4.4 kernel don't have the above
> two config options.
> What analysis can be done to narrow down the root cause?

"root cause" is you are comparing a kernel without any spectre/meltdown
mitigations, with one that has it.

Those mitigations are known to have a huge slowdown on some
benchmarks/workloads, as you have shown here.

If you don't like this, you can disable these changes on newer kernels,
if you really really know what you are doing, but I strongly do not
recommend it.

Also you can complain to your hardware vendors for selling you broken
hardware :)

> Any example of reference could be helpful to understand.

Look up Spectre and Meltdown for many many examples of what happened and
what went wrong with chip designs and how we had to fix these things in
the kernel a few years ago.

greg k-h
