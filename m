From: Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [PATCH 4/8] perf evsel: Do not rely on errno values for
 precise_ip fallback
Date: Sat, 13 Jul 2019 15:42:40 +0300
Message-ID: <1563021760.12557.0@yandex.ru>
References: <20190708154207.11403-1-acme@kernel.org>
        <20190708154207.11403-5-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708154207.11403-5-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Quentin Monnet <quentin.monnet@netronome.com>, Kim Phillips <kim.phillips@amd.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Thank you very much! Just wondering, would it maybe worth to backport=20
the fix to stable kernel too?

=F7 =F0=CE, =C9=C0=CC 8, 2019 at 12:42, Arnaldo Carvalho de Melo=20
<acme@kernel.org> =CE=C1=D0=C9=D3=C1=CC:
> From: Jiri Olsa <jolsa@kernel.org>
>=20
> Konstantin reported problem with default perf record command, which
> fails on some AMD servers, because of the default maximum precise
> config.
>=20
> The current fallback mechanism counts on getting ENOTSUP errno for
> precise_ip fails, but that's not the case on some AMD servers.
>=20
> We can fix this by removing the errno check completely, because the
> precise_ip fallback is separated. We can just try  (if requested by
> evsel->precise_max) all possible precise_ip, and if one succeeds we=20
> win,
> if not, we continue with standard fallback.
>=20
> Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Link: http://lkml.kernel.org/r/20190703080949.10356-1-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/evsel.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4a5947625c5c..69beb9f80f07 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1785,14 +1785,8 @@ static int perf_event_open(struct perf_evsel=20
> *evsel,
>  		if (fd >=3D 0)
>  			break;
>=20
> -		/*
> -		 * Do quick precise_ip fallback if:
> -		 *  - there is precise_ip set in perf_event_attr
> -		 *  - maximum precise is requested
> -		 *  - sys_perf_event_open failed with ENOTSUP error,
> -		 *    which is associated with wrong precise_ip
> -		 */
> -		if (!precise_ip || !evsel->precise_max || (errno !=3D ENOTSUP))
> +		/* Do not try less precise if not requested. */
> +		if (!evsel->precise_max)
>  			break;
>=20
>  		/*
> --
> 2.20.1
>=20

=
