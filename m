From: Song Liu <songliubraving@fb.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Date: Wed, 3 Apr 2019 18:59:51 +0000
Message-ID: <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
References: <20190403143738.GB32001@krava> <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
 <124332A9-146A-446F-A82A-910C8319170E@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <124332A9-146A-446F-A82A-910C8319170E@fb.com>
Content-Language: en-US
Content-ID: <548D2E056D721F49BDB858F1DD886E8E@namprd15.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org



> On Apr 3, 2019, at 11:55 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Apr 3, 2019, at 11:50 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmai=
l.com> wrote:
>>=20
>> Em Wed, Apr 03, 2019 at 04:27:56PM +0000, Song Liu escreveu:
>>>=20
>>>=20
>>>> On Apr 3, 2019, at 8:15 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gma=
il.com> wrote:
>>>>=20
>>>> Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>>>>> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
>>>>>> hi,
>>>>>> perf script --call-trace stop working for me recently,
>>>>>> and displays only user space functions
>>>>>>=20
>>>>>> I bisected that to:
>>>>>> 7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF pro=
grams
>>>>>>=20
>>>>>> data from following comands will display user space functions only:
>>>>>> # perf-with-kcore record pt -e intel_pt// -- ls
>>>>>> # perf-with-kcore script pt --call-trace
>>>>>>=20
>>>>>> when I disable the bpf synthesizing (patch below), kernel functions =
are back
>>>>>>=20
>>>>>> I guess the new events mess up with intel_pt decoder somehow
>>>>>=20
>>>>> I.e. I'm adding the patch below to my perf/urgent branch.
>>>>=20
>>>> Song, that is what I have, can I have your Acked-by and please conside=
r
>>>> taking a look at the bug Jiri reported,
>>>>=20
>>>> Thanks,
>>>>=20
>>>> - Arnaldo
>>>=20
>>> Current logic with --no-bpf-event is to generate PERF_RECORD_KSYMBOL, b=
ut not
>>> PERF_RECORD_BPF_EVENT:
>>=20
>> I see... The opts is done later, after querying the kernel for existing
>> BPF programs so that at least the KSYMBOL ones can be generated. So I'll
>> keep it as is, no need for this patch.
>>=20
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootlin.c=
om_linux_v5.1-2Drc3_source_tools_perf_util_bpf-2Devent.c-23L254&d=3DDwIBAg&=
c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&=
m=3D8ITYgIrqFBIy1uQFQPHrsX5kBX5RlmhwcknKYJa2eGs&s=3DMdB2zA9JstwC93qKEonsfTQ=
eQYiw-yeOLbPxm3QMRo8&e=3D
>>>=20
>>> I will look into the intel_pt problem.=20
>>=20
>> Ok.
>>=20
>>> In the meanwhile, let's fix it for now.=20
>>=20
>> I'll wait a bit.
>=20
> I guess something like this might be a better fix? (Sorry for missing=20
> commit message):
>=20
> diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
> index e32628cd20a7..741430a35dca 100644
> --- i/tools/perf/util/map.c
> +++ w/tools/perf/util/map.c
> @@ -261,6 +261,12 @@ bool __map__is_extra_kernel_map(const struct map *ma=
p)
>        return kmap && kmap->name[0];
> }
>=20
> +bool __map__is_bpf_prog(const struct map *map)
> +{
> +       const char *name =3D map->dso->short_name;
> +       return name && (strstr(name, "bpf_prog_") =3D=3D name);
> +}
> +
> bool map__has_symbols(const struct map *map)
> {
>        return dso__has_symbols(map->dso);
> diff --git i/tools/perf/util/map.h w/tools/perf/util/map.h
> index 0e20749f2c55..01079f1f4375 100644
> --- i/tools/perf/util/map.h
> +++ w/tools/perf/util/map.h
> @@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map=
, const char *symbol_name,
>=20
> bool __map__is_kernel(const struct map *map);
> bool __map__is_extra_kernel_map(const struct map *map);
> +bool __map__is_bpf_prog(const struct map *map);
>=20
> static inline bool __map__is_kmodule(const struct map *map)
> {
> -       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map)=
;
> +       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map)=
 &&
> +               !__map__is_bpf_prog(map);
> }
>=20
> bool map__has_symbols(const struct map *map);
>=20
> Thanks,
> Song

Actually, it should be something like this:

diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
index e32628cd20a7..31cd23612529 100644
--- i/tools/perf/util/map.c
+++ w/tools/perf/util/map.c
@@ -261,6 +261,11 @@ bool __map__is_extra_kernel_map(const struct map *map)
        return kmap && kmap->name[0];
 }

+bool __map__is_bpf_prog(const struct map *map)
+{
+       return map->dso->binary_type =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO;
+}
+
 bool map__has_symbols(const struct map *map)
 {
        return dso__has_symbols(map->dso);
diff --git i/tools/perf/util/map.h w/tools/perf/util/map.h
index 0e20749f2c55..01079f1f4375 100644
--- i/tools/perf/util/map.h
+++ w/tools/perf/util/map.h
@@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, =
const char *symbol_name,

 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
+bool __map__is_bpf_prog(const struct map *map);

 static inline bool __map__is_kmodule(const struct map *map)
 {
-       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
+       return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &=
&
+               !__map__is_bpf_prog(map);
 }

 bool map__has_symbols(const struct map *map);


>=20
>>=20
>>> Acked-by: Song Liu <songliubraving@fb.com>
>>>=20
>>> Thanks,=20
>>> Song
>>>=20
>>>=20
>>>> commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>> Date:   Wed Apr 3 12:05:15 2019 -0300
>>>>=20
>>>>  perf record: Do not synthesize BPF records when --no-bpf-event is use=
d
>>>>=20
>>>>  By default we synthesize and ask the kernel for BPF events, having a
>>>>  --no-bpf-event option to disable that, which can be useful, for
>>>>  instance, if there are still bugs in that code, which seems to be the
>>>>  case as reported by Jiri Olsa in:
>>>>=20
>>>>    "[BUG] perf: intel_pt won't display kernel function"
>>>>    https://lore.kernel.org/lkml/20190403143738.GB32001@krava
>>>>=20
>>>>  So add the check for record_opts.no_bpf_event when considering
>>>>  synthesizing BPF events for pre-existing BPF programs in 'perf record=
'.
>>>>=20
>>>>  The reported bug needs further analysis and is a separate matter.
>>>>=20
>>>>  Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>  Cc: Alexei Starovoitov <ast@kernel.org>
>>>>  Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>>>  Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>>  Cc: Jiri Olsa <jolsa@kernel.org>
>>>>  Cc: Martin KaFai Lau <kafai@fb.com>
>>>>  Cc: Namhyung Kim <namhyung@kernel.org>
>>>>  Cc: Peter Zijlstra <peterz@infradead.org>
>>>>  Cc: Song Liu <songliubraving@fb.com>
>>>>  Cc: Yonghong Song <yhs@fb.com>
>>>>  Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded=
 BPF programs")
>>>>  Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
>>>>  Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>=20
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 4e2d953d4bc5..17d772f192ad 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *r=
ec, bool tail)
>>>> 		return err;
>>>> 	}
>>>>=20
>>>> -	err =3D perf_event__synthesize_bpf_events(session, process_synthesiz=
ed_event,
>>>> -						machine, opts);
>>>> -	if (err < 0)
>>>> -		pr_warning("Couldn't synthesize bpf events.\n");
>>>> +	if (!opts->no_bpf_event) {
>>>> +		err =3D perf_event__synthesize_bpf_events(session, process_synthesi=
zed_event, machine, opts);
>>>> +		if (err < 0)
>>>> +			pr_warning("Couldn't synthesize bpf events.\n");
>>>> +	}
>>>>=20
>>>> 	err =3D __machine__synthesize_threads(machine, tool, &opts->target, r=
ec->evlist->threads,
>>>> 					    process_synthesized_event, opts->sample_address,
>>=20
>> --=20
>>=20
>> - Arnaldo
