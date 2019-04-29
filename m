From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: perf tools build broken after v5.1-rc1
Date: Mon, 29 Apr 2019 17:17:50 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Arnd Bergmann <arnd@arndb.de>, lkml <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

On 4/22/19 8:31 AM, Arnaldo Carvalho de Melo wrote:=0A=
>> A quick fix for ARC will be to create our own version but I presume all =
existing=0A=
>> arches using generic syscall abi are affected. Thoughts ? In lack of ide=
as I'll=0A=
>> send out a patch for ARC.=0A=
>>=0A=
>> P.S. Why do we need the unistd.h duplication in tools directory, given i=
t could=0A=
>> have used the in-tree unistd headers directly ?=0A=
> I have to write down the explanation and have it in a file, but we can't=
=0A=
> use anything in the kernel from outside tools/ to avoid adding a burden=
=0A=
> to kernel developers that would then have to make sure that the changes=
=0A=
> that they make outside tools/ don't break things living there.=0A=
=0A=
That is a sound guiding principle in general but I don't agree here. unistd=
 is=0A=
backbone of kernel user interface it has to work and can't possibly be brok=
en even=0A=
when kernel devs add a new syscall is added or condition-alize existing one=
. So=0A=
adding a copy - and deferring the propagation of in-kernel unistd to usersa=
pce=0A=
won't necessarily help with anything and it just adds the burden of keeping=
 them=0A=
in sync. Granted we won't necessarily need all the bleeding edge (new sysca=
ll=0A=
updates) into that header, its still more work.=0A=
