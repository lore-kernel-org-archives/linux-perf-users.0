From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3] perf tools: Work around lack of sched_getcpu in glibc
 < 2.6.
Date: Tue, 24 Mar 2015 09:21:58 +0900
Message-ID: <20150324002158.GL2782@sejong>
References: <20150320203828.GN16485@kernel.org>
 <1427137761-16119-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427137761-16119-1-git-send-email-vlee@twopensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Yann Droneaud <ydroneaud@opteya.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Vinson,

On Mon, Mar 23, 2015 at 12:09:16PM -0700, Vinson Lee wrote:
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

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/cloexec.c | 6 ++++++
>  tools/perf/util/cloexec.h | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
> index 6da965b..85b5238 100644
> --- a/tools/perf/util/cloexec.c
> +++ b/tools/perf/util/cloexec.c
> @@ -7,6 +7,12 @@
> =20
>  static unsigned long flag =3D PERF_FLAG_FD_CLOEXEC;
> =20
> +int __weak sched_getcpu(void)
> +{
> +	errno =3D ENOSYS;
> +	return -1;
> +}
> +
>  static int perf_flag_probe(void)
>  {
>  	/* use 'safest' configuration as used in perf_evsel__fallback() */
> diff --git a/tools/perf/util/cloexec.h b/tools/perf/util/cloexec.h
> index 94a5a7d..68888c2 100644
> --- a/tools/perf/util/cloexec.h
> +++ b/tools/perf/util/cloexec.h
> @@ -3,4 +3,10 @@
> =20
>  unsigned long perf_event_open_cloexec_flag(void);
> =20
> +#ifdef __GLIBC_PREREQ
> +#if !__GLIBC_PREREQ(2, 6)
> +extern int sched_getcpu(void) __THROW;
> +#endif
> +#endif
> +
>  #endif /* __PERF_CLOEXEC_H */
> --=20
> 1.8.2.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
