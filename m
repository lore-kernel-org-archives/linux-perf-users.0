From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Thu, 19 Mar 2015 11:13:04 +0100
Message-ID: <20150319101304.GC6363@krava>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
 <1426720316-7470-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426720316-7470-1-git-send-email-vlee@twopensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Mar 18, 2015 at 04:11:52PM -0700, Vinson Lee wrote:
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
> index 6da965b..285bd70 100644
> --- a/tools/perf/util/cloexec.c
> +++ b/tools/perf/util/cloexec.c
> @@ -7,6 +7,16 @@
> =20
>  static unsigned long flag =3D PERF_FLAG_FD_CLOEXEC;
> =20
> +#ifdef __GLIBC_PREREQ
> +#if !__GLIBC_PREREQ(2, 6)
> +static int sched_getcpu(void)
> +{
> +	errno =3D ENOSYS;
> +	return -1;
> +}
> +#endif
> +#endif

you could mark it as __weak and get rid of those ifdef's
like we do for strlcpy in utilpath.c

jirka
