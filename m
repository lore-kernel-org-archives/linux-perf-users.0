From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Linux 4.3-rc1 build error =?utf-8?Q?wi?=
 =?utf-8?Q?th_older_elfutils_=22util=2Fsymbol-elf=2Ec=3A41=3A5=3A_error=3A?=
 =?utf-8?Q?_no_previous_prototype_for_=E2=80=98elf=5Fgetphdrnum=E2=80=99?=
 =?utf-8?Q?=22?=
Date: Thu, 17 Sep 2015 11:37:08 -0300
Message-ID: <20150917143708.GL11551@kernel.org>
References: <CAHTgTXVPtzyRuW5tYGuC4Ssxpzgc8uFvnXirbvtrCXbJ7f9RnA@mail.gmail.com>
 <55FA5D8F.6000502@intel.com>
 <20150917140619.GK11551@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34985 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbbIQOhM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Sep 2015 10:37:12 -0400
Content-Disposition: inline
In-Reply-To: <20150917140619.GK11551@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Vinson Lee <vlee@twopensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Victor Kamensky <victor.kamensky@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Em Thu, Sep 17, 2015 at 11:06:19AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Thu, Sep 17, 2015 at 09:28:31AM +0300, Adrian Hunter escreveu:
> > On 17/09/15 01:10, Vinson Lee wrote:
> > > With Linux 4.3-rc1 I get a perf build error using toolchains with
> > > older elfutils.
> > >=20
> > > The following build error occurs on both CentOS 5.11 (elfutils 0.=
137)
> > > and Ubuntu 10.04.4 (elfutils 0.143).
> > >=20
> > >   CC       util/symbol-elf.o
> > > cc1: warnings being treated as errors
> > > util/symbol-elf.c:41: error: no previous prototype for =E2=80=98e=
lf_getphdrnum=E2=80=99
> >=20
> > commit f785f2357673d520a0b7b468973cdd197f336494
> > removed the 'static' qualifier, presumably because there
> > are cases where the prototype is in the header but the function is
> > not in the library.
> >=20
> > AFAICT gcc accepts multiple prototypes so long as they are the same
> > so just adding the prototype should be ok i.e.
>=20
> But that looks like a bandaid :-\
>=20
> The comment I made in f785f2357673d520a0b7b468973cdd197f336494 was no=
t
> clear enough, now I'm the one trying to figure out why I did that... =
Duh
> :-\
>=20
> I.e. if:
>=20
> "HAVE_ELF_GETPHDRNUM_SUPPORT is false" we shouldn't have any prototyp=
e
> for that elf_getphdrnum function, i.e. the fact that it is in libelf.=
h
> should mean that it is present, how come the feature test for it fail=
ed,
> i.e. HAVE_ELF_GETPHDRNUM_SUPPORT wasn't defined?

So, on RHEL5.11 (aka, I guess, CentOS 5.11):

  [acme@rhel5 linux]$ cat /etc/redhat-release=20
  Red Hat Enterprise Linux Server release 5.11 (Tikanga)
  [acme@rhel5 linux]$ rpm -q elfutils
  elfutils-0.137-3.el5
  [acme@rhel5 linux]$ cat /tmp/build/perf/feature/test-libelf-getphdrnu=
m.make.output
  cc1: warnings being treated as errors
  test-libelf-getphdrnum.c: In function =E2=80=98main=E2=80=99:
  test-libelf-getphdrnum.c:7: warning: implicit declaration of function=
 =E2=80=98elf_getphdrnum=E2=80=99
  [acme@rhel5 linux]$

If I revert my patch, it builds... I am now building this in more
systems while trying to get my head around how
HAVE_ELF_GETPHDRNUM_SUPPORT can be false while elf_getphdrnum() is
defined.

- Arnaldo
