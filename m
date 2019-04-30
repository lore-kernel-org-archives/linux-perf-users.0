From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Detecting libc in perf (was Re: perf tools build broken after
 v5.1-rc1)
Date: Tue, 30 Apr 2019 15:53:18 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A250601B@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <20190425214800.GC21829@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
 <20190430011818.GE7857@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "devel@uclibc-ng.org" <devel@uclibc-ng.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Rich Felker <dalias@libc.org>
List-Id: linux-perf-users.vger.kernel.org

On 4/29/19 6:18 PM, Arnaldo Carvalho de Melo wrote:=0A=
>>> Auto-detecting system features:=0A=
>>> ...                         dwarf: [ OFF ]=0A=
>>> ...            dwarf_getlocations: [ OFF ]=0A=
>>> ...                         glibc: [ on  ]=0A=
>> Not related to current issue, this run uses a uClibc toolchain and yet i=
t is=0A=
>> detecting glibc - doesn't seem right to me.=0A=
> Ok, I'll improve that, I think it just tries to detect a libc, yeah,=0A=
> see:=0A=
>=0A=
> [acme@quaco linux]$ cat tools/build/feature/test-glibc.c=0A=
> // SPDX-License-Identifier: GPL-2.0=0A=
> #include <stdlib.h>=0A=
>=0A=
> #if !defined(__UCLIBC__)=0A=
> #include <gnu/libc-version.h>=0A=
> #else=0A=
> #define XSTR(s) STR(s)=0A=
> #define STR(s) #s=0A=
> #endif=0A=
>=0A=
> int main(void)=0A=
> {=0A=
> #if !defined(__UCLIBC__)=0A=
> 	const char *version =3D gnu_get_libc_version();=0A=
> #else=0A=
> 	const char *version =3D XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);=0A=
> #endif=0A=
>=0A=
> 	return (long)version;=0A=
> }=0A=
> [acme@quaco linux]$=0A=
>=0A=
> [perfbuilder@59ca4b424ded /]$ grep __GLIBC__ /arc_gnu_2017.09-rc2_prebuil=
t_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/=
*.h=0A=
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-lin=
ux-uclibc/sysroot/usr/include/features.h:   The macros `__GNU_LIBRARY__', `=
__GLIBC__', and `__GLIBC_MINOR__' are=0A=
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-lin=
ux-uclibc/sysroot/usr/include/features.h:#define	__GLIBC__	2=0A=
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-lin=
ux-uclibc/sysroot/usr/include/features.h:	((__GLIBC__ << 16) + __GLIBC_MINO=
R__ >=3D ((maj) << 16) + (min))=0A=
> [perfbuilder@59ca4b424ded /]$=0A=
>=0A=
> Isn't that part of uClibc?=0A=
=0A=
Right you are. Per the big fat comment right above that code, this gross ha=
ck in=0A=
uclibc is unavoidable as applications tend to rely on that define.=0A=
So a better fix would be to check for various !GLIBC libs explicitly.=0A=
=0A=
#ifdef __UCLIBC__=0A=
=0A=
#elseif defined __MUSL__=0A=
=0A=
...=0A=
=0A=
Not pretty from app usage pov, but that seems to be the only sane way of do=
ing it.=0A=
=0A=
-Vineet=0A=
