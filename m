From: Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [PATCH] perf stat: Honour --timeout for forked workloads
Date: Wed, 15 Apr 2020 19:46:57 +0300
Message-ID: <2996611.mvXUDI8C0e@constantine-n61ja>
References: <20200415153803.GB20324@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200415153803.GB20324@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>

On =D1=81=D1=80=D0=B5=D0=B4=D0=B0, 15 =D0=B0=D0=BF=D1=80=D0=B5=D0=BB=D1=8F =
2020 =D0=B3. 18:38:03 MSK Arnaldo Carvalho de Melo wrote:
> Hi guys,
>=20
> 	Please take a look and give this your acks, Tested-by, etc.
>=20
> Thanks,
>=20
> - Arnaldo
>=20
> ----
>=20
> When --timeout is used and a workload is specified to be started by
> 'perf stat', i.e.
>=20
>   $ perf stat --timeout 1000 sleep 1h
>=20
> The --timeout wasn't being honoured, i.e. the workload, 'sleep 1h' in
> the above example, should be terminated after 1000ms, but it wasn't,
> 'perf stat' was waiting for it to finish.
>=20
> Fix it by sending a SIGTERM when the timeout expires.
>=20
> Now it works:
>=20
>   # perf stat -e cycles --timeout 1234 sleep 1h
>   sleep: Terminated
>=20
>    Performance counter stats for 'sleep 1h':
>=20
>            1,066,692      cycles
>=20
>          1.234314838 seconds time elapsed
>=20
>          0.000750000 seconds user
>          0.000000000 seconds sys
>=20
>   #
>=20
> Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D207243
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-stat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..9207b6c45475 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -686,8 +686,11 @@ static int __run_perf_stat(int argc, const char **ar=
gv,
> int run_idx) break;
>  			}
>  		}
> -		if (child_pid !=3D -1)
> +		if (child_pid !=3D -1) {
> +			if (timeout)
> +				kill(child_pid, SIGTERM);
>  			wait4(child_pid, &status, 0,=20
&stat_config.ru_data);
> +		}
>=20
>  		if (workload_exec_errno) {
>  			const char *emsg =3D=20
str_error_r(workload_exec_errno, msg, sizeof(msg));


=2D-=20
=D0=98=D0=BD=D0=B6=D0=B5=D0=BD=D0=B5=D1=80-=D1=80=D0=B0=D0=B7=D1=80=D0=B0=
=D0=B1=D0=BE=D1=82=D1=87=D0=B8=D0=BA =D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=
=D0=BD=D1=82=D0=B8=D0=BD =D0=A5=D0=B0=D1=80=D0=BB=D0=B0=D0=BC=D0=BE=D0=B2
