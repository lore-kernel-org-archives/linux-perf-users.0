From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: compile error : about =?utf-8?Q?declar?=
 =?utf-8?B?YXRpb24gb2Yg4oCYcHRocmVhZF9hdHRyX3NldGFmZmluaXR5X25w4oCZ?=
Date: Sat, 28 Feb 2015 12:04:55 +0900
Message-ID: <20150228030454.GC15964@danjae>
References: <54EC3E3B.2040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42574 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbB1DFb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Feb 2015 22:05:31 -0500
Received: by pablj1 with SMTP id lj1so24947098pab.9
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2015 19:05:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54EC3E3B.2040702@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@kernel.org

(Adding Arnaldo and Jiri to CC.)

On Tue, Feb 24, 2015 at 06:02:51PM +0900, taeung wrote:
> Hi, Namhyung

Hi Taeung,

>=20
> After I pulled new changed source codes from 'perf/core' branch
> (https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git)
> ,when I compiled perf I've had a problem with error messages as below=
=2E
>=20
> (I'm using as below
> system : Ubuntu 14.04.2 LTS 64-bit
> kernel version : 3.13.0-40-generic)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> taeung ~/git/tip/tools/perf
>  :> make -j4
>=20
> ...(omitted)
>=20
> In file included from bench/futex-hash.c:17:0:
> bench/futex.h:73:19: error: conflicting types for
> =E2=80=98pthread_attr_setaffinity_np=E2=80=99
>  static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr,
>                    ^
> In file included from bench/futex.h:72:0,
>                  from bench/futex-hash.c:17:
> /usr/include/pthread.h:407:12: note: previous declaration of
> =E2=80=98pthread_attr_setaffinity_np=E2=80=99 was here
>  extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
>             ^

This means it failed to find pthread_attr_setaffinity_np() on the
feature test (so HAVE_PTHREAD_ATTR_SETAFFINITY_NP is not defined) but
it's actually available on your system.


> make[3]: *** [bench/futex-hash.o] Error 1
> make[2]: *** [bench] Error 2
> make[2]: *** Waiting for unfinished jobs....
>=20
> ...(omitted)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> But I modified 'tools/perf/config/feature-checks/Makefile' as Jirka s=
aid
> (https://lkml.org/lkml/2015/1/12/216)
> so I was able to compile perf.

No Jiri's advice was to add -lpthread, not remove _GNU_SOURCE define.
I guess adding -pthread instead of -lpthread might help..


>=20
>=20
> diff --git a/tools/perf/config/feature-checks/Makefile
> b/tools/perf/config/feature-checks/Makefile
> index b32ff33..42ac05a 100644
> --- a/tools/perf/config/feature-checks/Makefile
> +++ b/tools/perf/config/feature-checks/Makefile
> @@ -49,7 +49,7 @@ test-hello.bin:
>         $(BUILD)
>=20
>  test-pthread-attr-setaffinity-np.bin:
> -       $(BUILD) -D_GNU_SOURCE -Werror -lpthread
> +       $(BUILD) -Werror -lpthread
>=20
>  test-stackprotector-all.bin:
>         $(BUILD) -Werror -fstack-protector-all
>=20
>=20
> Is this patch right ?

I don't think so.  You'd better to find out the reason of the failure
in the feature test.

Thanks,
Namhyung
