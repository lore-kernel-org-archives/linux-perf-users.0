From: Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 15/17] perf bpf-event: Add missing new line into pr_debug
 call
Date: Thu, 21 Feb 2019 07:12:13 +0000
Message-ID: <1883F478-13FB-49E8-A062-997678D94860@fb.com>
References: <20190221012549.4069-1-acme@kernel.org>
 <20190221012549.4069-16-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-16-acme@kernel.org>
Content-Language: en-US
Content-ID: <E46FE014399EDE47AC9FA03F09C18ABF@namprd15.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org



> On Feb 20, 2019, at 5:25 PM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> From: Jiri Olsa <jolsa@kernel.org>
>=20
> Add a missing new line into pr_debug call in perf_event__synthesize_bpf_e=
vents(),
> so that the error message does not screw the verbose output.
>=20
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Song Liu <songliubraving@fb.com>
> Link: http://lkml.kernel.org/r/20190220122800.864-5-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for fixing this.

Song

> ---
> tools/perf/util/bpf-event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 62dda96b0096..028c8ec1f62a 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_too=
l *tool,
> 				err =3D 0;
> 				break;
> 			}
> -			pr_debug("%s: can't get next program: %s%s",
> +			pr_debug("%s: can't get next program: %s%s\n",
> 				 __func__, strerror(errno),
> 				 errno =3D=3D EINVAL ? " -- kernel too old?" : "");
> 			/* don't report error on old kernel or EPERM  */
> --=20
> 2.19.1
>=20
