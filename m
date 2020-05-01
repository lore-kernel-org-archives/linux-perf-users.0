From: Arnaldo Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 5/8] perf evlist: Allow reusing the side band thread for more purposes
Date: Fri, 01 May 2020 08:31:16 -0300
Message-ID: <C4CDADE1-82F4-4033-A9C7-F411C2D7DC28@gmail.com>
References: <20200429131106.27974-1-acme@kernel.org> <20200429131106.27974-6-acme@kernel.org> <20200501112552.GC1789042@krava>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200501112552.GC1789042@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org



On May 1, 2020 8:25:52 AM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wrote:
>On Wed, Apr 29, 2020 at 10:11:03AM -0300, Arnaldo Carvalho de Melo
>wrote:
>> From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>>=20
>> I=2Ee=2E so far we had just one event in that side band thread, a dummy
>one
>> with attr=2Ebpf_event set, so that 'perf record' can go ahead and ask
>the
>> kernel for further information about BPF programs being loaded=2E
>>=20
>> Allow for more than one event to be there, so that we can use it as
>> well for the upcoming --switch-output-event feature=2E
>>=20
>> Cc: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>> Cc: Jiri Olsa <jolsa@kernel=2Eorg>
>> Cc: Namhyung Kim <namhyung@kernel=2Eorg>
>> Cc: Song Liu <songliubraving@fb=2Ecom>
>> Link:
>http://lore=2Ekernel=2Eorg/lkml/20200427211935=2E25789-7-acme@kernel=2Eor=
g
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---
>>  tools/perf/util/evlist=2Ec | 22 ++++++++++++++++++++++
>>  tools/perf/util/evlist=2Eh |  1 +
>>  2 files changed, 23 insertions(+)
>>=20
>> diff --git a/tools/perf/util/evlist=2Ec b/tools/perf/util/evlist=2Ec
>> index 1d0d36da223b=2E=2E849058766757 100644
>> --- a/tools/perf/util/evlist=2Ec
>> +++ b/tools/perf/util/evlist=2Ec
>> @@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void
>*arg)
>>  	return NULL;
>>  }
>> =20
>> +void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb,
>void *data)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		evsel->core=2Eattr=2Esample_id_all	  =3D 1;
>> +		evsel->core=2Eattr=2Ewatermark	  =3D 1;
>> +		evsel->core=2Eattr=2Ewakeup_watermark =3D 1;
>> +		evsel->side_band=2Ecb   =3D cb;
>> +		evsel->side_band=2Edata =3D data;
>> +	}
>> +}
>> +
>>  int perf_evlist__start_sb_thread(struct evlist *evlist,
>>  				 struct target *target)
>>  {
>> @@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist
>*evlist,
>>  	if (perf_evlist__create_maps(evlist, target))
>>  		goto out_delete_evlist;
>> =20
>> +	if (evlist->core=2Enr_entries > 1) {
>> +		bool can_sample_identifier =3D perf_can_sample_identifier();
>
>I just found this breaks python, because perf_can_sample_identifier
>is defined in util/record=2Ec

Yeah, I noticed it too, will fix

>
>	19: 'import perf' in python                               :
>	--- start ---
>	test child forked, pid 1808205
>	Traceback (most recent call last):
>	  File "<stdin>", line 1, in <module>
>	ImportError: python/perf=2Eso: undefined symbol:
>perf_can_sample_identifier
>	test child finished with -1
>	---- end ----
>	'import perf' in python: FAILED!
>
>jirka

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
