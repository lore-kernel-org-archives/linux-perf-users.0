From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCHES] Fix 'perf top' breakage on architectures not providing
 get_cpuid() Re: perf top for arm64?
Date: Wed, 11 Dec 2019 15:54:40 +0100
Message-ID: <20191211145440.GD25474@krava>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
 <20191210195113.GD13965@kernel.org>
 <20191211133319.GA15181@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211133319.GA15181@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: John Garry <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linuxarm <linuxarm@huawei.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 11, 2019 at 10:33:19AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 10, 2019 at 04:51:13PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Dec 10, 2019 at 05:17:56PM +0000, John Garry escreveu:
> > > On 10/12/2019 17:08, Jiri Olsa wrote:
> > > > On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
> > > > > On 10/12/2019 16:36, Jiri Olsa wrote:
> > > > > > On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> > > > > > > I find to my surprise that "perf top" does not work for arm64=
:
>=20
> > > > > > > root@ubuntu:/home/john/linux# tools/perf/perf top
> > > > > > > Couldn't read the cpuid for this machine: No such file or dir=
ectory
>=20
> > > > > > there was recent change that check on cpuid and quits:
> > > > > >     608127f73779 perf top: Initialize perf_env->cpuid, needed b=
y the per arch annotation init routine
>=20
> > > > > ok, this is new code. I obviously didn't check the git history...
>=20
> > > > > But, apart from this, there are many other places where get_cpuid=
() is
> > > > > called. I wonder what else we're missing out on, and whether we s=
hould still
> > > > > add it.
>=20
> > > > right, I was just wondering how come vendor events are working for =
you,
> > > > but realized we have get_cpuid_str being called in there ;-)
>=20
> > > > I think we should add it as you have it prepared already,
> > > > could you post it with bigger changelog that would explain
> > > > where it's being used for arm?
>=20
> > > ok, I can look to do that.
>=20
> > > But, as you know, we still need to fix perf top for other architectur=
es
> > > affected.
>=20
> > Right, I need to make that just a pr_debug() message and then check in
> > the annotation code when that is needed to see if it is set, if not,
> > then show a popup error message and refuse to do whatever annotation
> > feature requires that.
>=20
> > Anyway, your patch should make sense and provide info that the ARM64
> > annotation may use now or in the future.
>=20
> So can you take a look at the two patches below and provide me Acked-by
> and/or Reviewed-by and/or Tested-by?

looks good to me, but don't have arm server at the moment..

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>=20
>=20
> From 53c6cde6a71a1a9283763bd2e938b229b50c2cd5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 11 Dec 2019 10:09:24 -0300
> Subject: [PATCH 1/2] perf arch: Make the default get_cpuid() return compa=
tible
>  error
>=20
> Some of the functions calling get_cpuid() propagate back the error it
> returns, and all are using errno (positive) values, make the weak
> default get_cpuid() function return ENOSYS to be consistent and to allow
> checking if this is an arch not providing this function or if a provided
> one is having trouble getting the cpuid, to decide if the warning should
> be provided to the user or just a debug message should be emitted.
>=20
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index becc2d109423..4d39a75551a0 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, con=
st char *cpuid)
>   */
>  int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unus=
ed)
>  {
> -=09return -1;
> +=09return ENOSYS; /* Not implemented */
>  }
> =20
>  static int write_cpuid(struct feat_fd *ff,
> --=20
> 2.21.0
>=20
> From c6c6a3e2eb6982e37294abcac389effd298cf730 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 11 Dec 2019 10:21:59 -0300
> Subject: [PATCH 2/2] perf top: Do not bail out when perf_env__read_cpuid(=
)
>  returns ENOSYS
>=20
> 'perf top' stopped working on hw architectures that do not provide a
> get_cpuid() implementation and thus fallback to the weak get_cpuid()
> default function.
>=20
> This is done because at annotation time we may need it in the arch
> specific annotation init routine, but that is only being used by arches
> that do provide a get_cpuid() implementation:
>=20
>   $ find tools/  -name "*.[ch]" | xargs grep 'evlist->env'
>   tools/perf/builtin-top.c:=09top.evlist->env =3D &perf_env;
>   tools/perf/util/evsel.c:=09=09return evsel->evlist->env;
>   tools/perf/util/s390-cpumsf.c:=09sf->machine_type =3D s390_cpumsf_get_t=
ype(session->evlist->env->cpuid);
>   tools/perf/util/header.c:=09session->evlist->env =3D &header->env;
>   tools/perf/util/sample-raw.c:=09const char *arch_pf =3D perf_env__arch(=
evlist->env);
>   $
>=20
>   $ find tools/perf/arch  -name "*.[ch]" | xargs grep -w get_cpuid
>   tools/perf/arch/x86/util/auxtrace.c:=09ret =3D get_cpuid(buffer, sizeof=
(buffer));
>   tools/perf/arch/x86/util/header.c:get_cpuid(char *buffer, size_t sz)
>   tools/perf/arch/powerpc/util/header.c:get_cpuid(char *buffer, size_t sz=
)
>   tools/perf/arch/s390/util/header.c: * Implementation of get_cpuid().
>   tools/perf/arch/s390/util/header.c:int get_cpuid(char *buffer, size_t s=
z)
>   tools/perf/arch/s390/util/header.c:=09if (buf && get_cpuid(buf, 128))
>   $
>=20
> For 'report' or 'script', i.e. tools working on perf.data files, that is
> setup while reading the header, its just top that needs to explicitely
> read it at tool start.
>=20
> Reported-by: John Garry <john.garry@huawei.com>
> Analysed-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-top.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index dc80044bc46f..795e353de095 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1568,9 +1568,13 @@ int cmd_top(int argc, const char **argv)
>  =09 */
>  =09status =3D perf_env__read_cpuid(&perf_env);
>  =09if (status) {
> -=09=09pr_err("Couldn't read the cpuid for this machine: %s\n",
> -=09=09       str_error_r(errno, errbuf, sizeof(errbuf)));
> -=09=09goto out_delete_evlist;
> +=09=09/*
> +=09=09 * Some arches do not provide a get_cpuid(), so just use pr_debug,=
 otherwise
> +=09=09 * warn the user explicitely.
> +=09=09 */
> +=09=09eprintf(status =3D=3D ENOSYS ? 1 : 0, verbose,
> +=09=09=09"Couldn't read the cpuid for this machine: %s\n",
> +=09=09=09str_error_r(errno, errbuf, sizeof(errbuf)));
>  =09}
>  =09top.evlist->env =3D &perf_env;
> =20
> --=20
> 2.21.0
>=20
