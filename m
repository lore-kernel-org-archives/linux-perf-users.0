From: Greg KH <greg@kroah.com>
Subject: Re: Scheduler benchmarks
Date: Wed, 19 Aug 2020 18:47:35 +0200
Message-ID: <20200819164735.GA3698439@kroah.com>
References: <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
 <20200819104254.GA41946@kroah.com>
 <135393.1597855432@turing-police>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <135393.1597855432@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: Muni Sekhar <munisekharrms@gmail.com>, peter enderborg <peter.enderborg@sony.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Aug 19, 2020 at 12:43:52PM -0400, Valdis Klētnieks wrote:
> On Wed, 19 Aug 2020 12:42:54 +0200, Greg KH said:
> > Look up Spectre and Meltdown for many many examples of what happened and
> > what went wrong with chip designs and how we had to fix these things in
> > the kernel a few years ago.
> 
> And I'm sure that nobody sane thinks we're done with security holes
> caused by speculative execution... :)

Hah, not at all, the patches keep flowing in, as do the microcode
updates...
