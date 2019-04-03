From: Song Liu <songliubraving@fb.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Date: Wed, 3 Apr 2019 17:05:02 +0000
Message-ID: <4EA3EF29-6D79-4F79-B1AD-0B6C12A5FF97@fb.com>
References: <20190403143738.GB32001@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403143738.GB32001@krava>
Content-Language: en-US
Content-ID: <C01B5A517BD4664FB4AB7595DC37932F@namprd15.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, "acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org



> On Apr 3, 2019, at 7:37 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> hi,
> perf script --call-trace stop working for me recently,
> and displays only user space functions
>=20
> I bisected that to:
>  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF program=
s
>=20
> data from following comands will display user space functions only:
>  # perf-with-kcore record pt -e intel_pt// -- ls
>  # perf-with-kcore script pt --call-trace

Seems the following are ok (upstream as-is)?

./perf record -e intel_pt// -- ls
./perf script --call-trace

Jiri, could you please verify this? (Sorry I am new to perf-with-kcore).=20

Thanks,
Song

>=20
> when I disable the bpf synthesizing (patch below), kernel functions are b=
ack
>=20
> I guess the new events mess up with intel_pt decoder somehow
>=20
>=20
> thanks,
> jirka
>=20
>=20
> ---
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4e2d953d4bc5..3daa78bc6549 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec,=
 bool tail)
> 		return err;
> 	}
>=20
> +#if 0
> 	err =3D perf_event__synthesize_bpf_events(session, process_synthesized_e=
vent,
> 						machine, opts);
> 	if (err < 0)
> 		pr_warning("Couldn't synthesize bpf events.\n");
> +#endif
>=20
> 	err =3D __machine__synthesize_threads(machine, tool, &opts->target, rec-=
>evlist->threads,
> 					    process_synthesized_event, opts->sample_address,
