From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: Scheduler benchmarks
Date: Tue, 18 Aug 2020 23:23:20 +0530
Message-ID: <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com> <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200818173656.GA748290@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> > On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> > >
> > > On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > > > On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > > > >
> > > > > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > I=E2=80=99ve two identical Linux systems with only kernel diffe=
rences.
> > > > >
> > > > > What are the differences in the kernels?
> > >
> > > You didn't answer this question, is this the same kernel source being
> > > compared here?  Same version?  Same compiler?  Everything identical?
> > Both systems are having exactly the same hardware configuration.
> > Compiler and kernel versions are different. One system has Ubuntu
> > 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
> > the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
> > version 7.5.0).
>
> Those are _very_ different kernel versions, with many years and tens of
> thousands of different changes between them.
>
> Hopefully the newer kernel is faster, so just stick with that :)
But unfortunately the newer kernel is very slow, that is the reason
for starting this investigation :)
Any type of help,  and guidelines to dive deeper will be highly appreciated=
.

>
> greg k-h



--=20
Thanks,
Sekhar
