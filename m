From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: perf tools build broken after v5.1-rc1
Date: Tue, 30 Apr 2019 18:12:35 +0200
Message-ID: <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkml <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 29, 2019 at 7:17 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 4/22/19 8:31 AM, Arnaldo Carvalho de Melo wrote:
> >> A quick fix for ARC will be to create our own version but I presume all existing
> >> arches using generic syscall abi are affected. Thoughts ? In lack of ideas I'll
> >> send out a patch for ARC.
> >>
> >> P.S. Why do we need the unistd.h duplication in tools directory, given it could
> >> have used the in-tree unistd headers directly ?
> > I have to write down the explanation and have it in a file, but we can't
> > use anything in the kernel from outside tools/ to avoid adding a burden
> > to kernel developers that would then have to make sure that the changes
> > that they make outside tools/ don't break things living there.
>
> That is a sound guiding principle in general but I don't agree here. unistd is
> backbone of kernel user interface it has to work and can't possibly be broken even
> when kernel devs add a new syscall is added or condition-alize existing one. So
> adding a copy - and deferring the propagation of in-kernel unistd to usersapce
> won't necessarily help with anything and it just adds the burden of keeping them
> in sync. Granted we won't necessarily need all the bleeding edge (new syscall
> updates) into that header, its still more work.

I think more importantly, it seems completely broken to sync a file from
asm-generic but not the arch specific file that includes it.

The 1a787fc5ba18ac7 commit copied over the changes for arm64, but
missed all the other architectures changed in c8ce48f06503 and the
related commits.

      Arnd
