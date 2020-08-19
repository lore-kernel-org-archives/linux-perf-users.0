From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: Scheduler benchmarks
Date: Wed, 19 Aug 2020 15:46:06 +0530
Message-ID: <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com> <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com> <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter enderborg <peter.enderborg@sony.com>
Cc: Greg KH <greg@kroah.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 18, 2020 at 11:45 PM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 8/18/20 7:53 PM, Muni Sekhar wrote:
> > On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
> >> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> >>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> >>>> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> >>>>> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> >>>>>> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> I=E2=80=99ve two identical Linux systems with only kernel differe=
nces.
> >>>>>> What are the differences in the kernels?
> >>>> You didn't answer this question, is this the same kernel source bein=
g
> >>>> compared here?  Same version?  Same compiler?  Everything identical?
> >>> Both systems are having exactly the same hardware configuration.
> >>> Compiler and kernel versions are different. One system has Ubuntu
> >>> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel an=
d
> >>> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gc=
c
> >>> version 7.5.0).
> >> Those are _very_ different kernel versions, with many years and tens o=
f
> >> thousands of different changes between them.
> >>
> >> Hopefully the newer kernel is faster, so just stick with that :)
> > But unfortunately the newer kernel is very slow, that is the reason
> > for starting this investigation :)
> > Any type of help,  and guidelines to dive deeper will be highly appreci=
ated.
>
> On the 4.4 kernel you dont have
>
> +CONFIG_RETPOLINE=3Dy
> +CONFIG_INTEL_RDT=3Dy
Thanks! That is helpful. Yes, I see 4.4 kernel don't have the above
two config options.
What analysis can be done to narrow down the root cause?
Any example of reference could be helpful to understand.

>
> And your base is very different two.
>
> Try to use mainline on both system and see.
>
> You can also use the same base kernel version from ubuntu and
>
> run your test.
>
>
> >> greg k-h
> >
> >
>


--=20
Thanks,
Sekhar
