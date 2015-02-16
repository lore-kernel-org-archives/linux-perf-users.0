From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] perf tools: Work around lack of sched_getcpu in glibc <
 2.6.
Date: Mon, 16 Feb 2015 21:50:15 +0100
Message-ID: <1424119815.32606.14.camel@opteya.com>
References: <1423879609-4373-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ou.quest-ce.net ([195.154.187.82]:49461 "EHLO ou.quest-ce.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbbBPUuq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Feb 2015 15:50:46 -0500
In-Reply-To: <1423879609-4373-1-git-send-email-vlee@twopensource.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vinson Lee <vlee@twopensource.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>

Hi,

Le vendredi 13 f=C3=A9vrier 2015 =C3=A0 18:06 -0800, Vinson Lee a =C3=A9=
crit :
> From: Vinson Lee <vlee@twitter.com>
>=20
> This patch fixes this build error with glibc < 2.6.
>=20
>   CC       util/cloexec.o
> cc1: warnings being treated as errors
> util/cloexec.c: In function =E2=80=98perf_flag_probe=E2=80=99:
> util/cloexec.c:24: error: implicit declaration of function
> =E2=80=98sched_getcpu=E2=80=99
> util/cloexec.c:24: error: nested extern declaration of =E2=80=98sched=
_getcpu=E2=80=99
> make: *** [util/cloexec.o] Error 1
>=20
> Cc: stable@vger.kernel.org # 3.18+
> Signed-off-by: Vinson Lee <vlee@twitter.com>
> ---
>  tools/perf/util/cloexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
> index 47b78b3..3738924 100644
> --- a/tools/perf/util/cloexec.c
> +++ b/tools/perf/util/cloexec.c
> @@ -7,6 +7,12 @@
> =20
>  static unsigned long flag =3D PERF_FLAG_FD_CLOEXEC;
> =20
> +#ifdef __GLIBC_PREREQ
> +#if __GLIBC_PREREQ(2, 6)
> +#define HAVE_SCHED_GETCPU
> +#endif
> +#endif
> +

OK

>  static int perf_flag_probe(void)
>  {
>  	/* use 'safest' configuration as used in perf_evsel__fallback() */
> @@ -21,9 +27,13 @@ static int perf_flag_probe(void)
>  	pid_t pid =3D -1;
>  	char sbuf[STRERR_BUFSIZE];
> =20
> +#ifdef HAVE_SCHED_GETCPU
>  	cpu =3D sched_getcpu();
>  	if (cpu < 0)
>  		cpu =3D 0;
> +#else
> +	cpu =3D 0;
> +#endif
> =20
>  	while (1) {
>  		/* check cloexec flag */

I've reviewed the use of __GLIBC_PREREQ(2, 6), but not whether using cp=
u
=3D 0 is OK if sched_getcpu() is not available.

Reviewed-by: Yann Droneaud <ydroneaud@opteya.com>

Regards.

--=20
Yann Droneaud
OPTEYA
