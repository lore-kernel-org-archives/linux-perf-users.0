Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505088;
	b=cvtNoeLemYhe1R8FMO9oaWcDnHoPO9ptJbEO3efUhdYZOsvsCnQZBiMGAWBtUlTlJ82F
	 I8GmUchCuoepTWj+JgEJDEUg2OATNkVOj1Jg1g1hl9nyz99rvOmuKew8a0P2FvKkAk5sb
	 PFV6I0oKNVHqhmC5+QWGu70/lkDKN6hqXc0nzUhYSeEELLrPnMCJWQ3jMZzslPVtEUYDb
	 UvOs06rejhXt0XrbXrwuaLDr9KaGcohz7mtcB2ArUsB9gaZ89skGWtenBwNKWnM0RWYy9
	 z4g/0PjCw8iYBpPPhdRZur5Tdmv67mSXte/b3Sbb8PB9sLBsRQALrU4xFMII0KFdxww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505088;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Wq/26gYffQWL+jiAokQYaS/R45EGYtcFa5twXyVMoDE=;
	b=spIDLDQV1iFhCULsAPDorM7t4fLGxzLx6xsMcF8AheKFtPNatNVtwE3k+5bf/zHE0io1
	 MTVuFAuJ6+OtaN+Ylk8UVfWt7JL2UVSeHoGPccyEDJDY5qIek45v4SKGcikf5oJsC55ni
	 tQQ81ZT8U1HDbB/9tvC8jw5kYIDE3l2bbFRxGRUizMIX3hiR2MGaEMaI7Rq6Y7WeUWSiJ
	 LW2vMfaojVNi5Nf/vEHPSFhJEXLYedXeRMz5nPbV1QCdYzJ0bX8mInifJ4S+G8ytIH91s
	 SSoNxq7SW36KQ/Ens//SCOMI+ThFnlJw7pGntSMz6Aua7N/nU0m/JOMwKASkoDBxneQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DtRUqclW;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F20606A31E;
	Tue, 24 Nov 2026 07:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DtRUqclW
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34aed3825940;
	Tue, 24 Nov 2026 07:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wq/26g
	YffQWL+jiAokQYaS/R45EGYtcFa5twXyVMoDE=; b=DtRUqclW7+lU5eq0vNwM5E
	HGg/IYpmPo0UPc3XCWytwOrDkjp+MaH7KgnelMSOKyYIkG55qlZB83joDaKVQ8+w
	dIbwF+GpV2loozn0YUc+QfikD+3WBf5NayoyvJsd2LwndsLgEKHLGGVVfOyVSbZn
	2Hi93w6cpCEWD35x1FC1xvO8JimDsUaaHY6cYdpc7cQfRhG8EczgYmMzvV7MxlSl
	4M/IUGNtPRXRK0Id3rxEtY2z2GmLGVt2oj4znwoAO8v3U1We8qJs8NSXRP5veEvw
	RwSYanpyzsANCKazZP34mm884e7wy6+IwVa/4hVRpizNGOMN/pD2nkJSLfVnaWWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g36k21-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 07:24:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2nSs32087090;
	Tue, 24 Nov 2026 07:24:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vhu16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 07:24:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO7OMtG46662062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 07:24:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C5F2004D;
	Tue, 24 Nov 2026 07:24:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D1320049;
	Tue, 24 Nov 2026 07:24:20 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.12.120])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Nov 2026 07:24:19 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v1 05/13] perf stat: Preserve per-evsel CPU maps across
 stat record and report
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fXPCbPFhVeB6229hnHNpE4pFshQQQ7CfNyu-S9XUVi6Vg@mail.gmail.com>
Date: Tue, 24 Nov 2026 12:54:07 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Howard Chu <howardchu95@gmail.com>,
        Thomas Falcon <thomas.falcon@intel.com>,
        Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC70735A-5E41-4291-AE03-F0B2D4EEEC51@linux.ibm.com>
References: <20261123071913.653315-1-irogers@google.com>
 <20261123071913.653315-6-irogers@google.com>
 <3F569607-DA0C-47B3-823D-926D12D7FBC1@linux.ibm.com>
 <CAP-5=fXPCbPFhVeB6229hnHNpE4pFshQQQ7CfNyu-S9XUVi6Vg@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b053baa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=dxuJdaAIUQLOc8D-FxwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOCBTYWx0ZWRfXyLx6k9oRWYSY
 U0w1lVa1PpQI50mgUocMvG1dWIb/Ue+7x65Nm3qU/I95si5+CKKukjXoIR30w67vYgXQ0GJiFKc
 uExLDC6OeCH47WZVPCLECsmeDji/iws=
X-Proofpoint-ORIG-GUID: OpBJAo4ysX_5GUQq1VzthZG1mb66FzGc
X-Proofpoint-GUID: QGmPD_5_C9UMGoQZbGd34FkiB5UB7Ypt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOCBTYWx0ZWRfX2fmZF+C1PiMt
 Eu5ujPlgbcojArNwCmVGCVUHr/IBTYKCDvA9ISYH2jYpz/wZ/Edoqjk/ZVRYWHjysR1Pf4uYH9P
 iYjRwv+RaYs3Ey/FpBvZRtcTaTYqqUqxOGbnI2dQO4PmqanK0lZax44a7OBgESQ6QDgCocLMert
 TfFwXyc7AzaGDj+0Zh7oJZLkiCMtw6AQwZCyTZ2kTmktQ5j5JU4eMLkkF/NnV89qqsQGgEuaw1X
 zz9OqLNBXR4zAitFbNuWQk1zb6zquadx12CK+9hCW/b30iViJldoGiAObe17ocGI/F1ZHfTUNee
 lXPdmHQypmh96uSWPuRelWp3eqZjvqm5TbS8q/Uuj8rz+ix5+vfEqsvU3iIr9J2nOEifesXUHuG
 UTa+gY+a1b5cdoxHNWCaTxzXdYsnU04ec0ZKalpBZeOWSJLE1C1LcWx3SFgt+qdxeLhqtCagEJ2
 nKbVqL6zYj+vmXQUN+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240028



> On 24 Nov 2026, at 9:53=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Mon, Nov 23, 2026 at 9:13=E2=80=AFAM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 23 Nov 2026, at 12:49=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>>>=20
>>> Commit 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus") =
and
>>> commit 811082e4b668 ("perf parse-events: Support user CPUs mixed =
with
>>> threads/processes") separated an evsel's PMU cpumask (pmu_cpus) from =
the
>>> actual CPUs on which the event is opened (cpus) and taught
>>> __perf_evlist__propagate_maps() to collapse evsel->cpus to the "any =
CPU"
>>> (-1) map when user_requested_cpus is -1 and !evsel->requires_cpu.
>>>=20
>>> However, perf_event__synthesize_event_update_cpus() continued to
>>> serialize evsel->core.pmu_cpus instead of evsel->core.cpus, and
>>> perf_event__process_event_update() only populated =
evsel->core.pmu_cpus
>>> without setting evsel->core.cpus or evsel->core.requires_cpu. This =
broke
>>> perf stat record/report (and perf script) in two ways:
>>>=20
>>> 1. When recording an event opened per-CPU alongside a workload =
target
>>>  (where user_requested_cpus is -1), such as an event with a cpu=3D =
term,
>>>  an uncore counter, --bpf-counters, or a BPF-filtered counter,
>>>  PERF_RECORD_STAT events are written with concrete CPU numbers, but
>>>  perf stat report's perf_evlist__set_maps() collapses evsel->cpus to
>>>  -1 and fails with:
>>>=20
>>>    $ perf stat record -e 'task-clock/cpu=3D0/,task-clock' -- true
>>>    $ perf stat report
>>>    Invalid CPU 0 for event task-clock/cpu=3D0/.
>>=20
>> Hi Ian
>>=20
>> Thanks for the fix, verified the fix for "perf stat report". But I =
have one observation when using aggregation mode.
>>=20
>> Working case with the fix:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> With the fix:
>>=20
>> ./perf stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ <workload>
>> ./perf stat report
>>=20
>> Perf stat report works fine
>> Also checked system wide.
>>=20
>> Using -A:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Before broken commits 6d765f5f7ec6 and 811082e4b668,
>> ./perf stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ <workload>
>> ./perf stat report -A : this was working
>>=20
>>    ./perf stat report -A
>>=20
>>    Performance counter stats for =
'/root/perf-tools-next/tools/perf/perf stat record -e =
cycles/cpu=3D8/,cycles/cpu=3D9/ ./stream=E2=80=99:
>>=20
>>=20
>>    3,447,492,527,125      cycles/cpu=3D8/
>>    3,447,492,527,125      cycles/cpu=3D9/
>>     108.543826387 seconds time elapsed
>>=20
>> On top of this patch, result looks like:
>> ./perf stat report -A
>>=20
>> Performance counter stats for =
'/root/perf-tools-next/tools/perf/perf':
>>=20
>>=20
>>       2.119970008 seconds time elapsed
>>=20
>> There are no counter line, only time elapsed. I am suspecting the =
change for perf_event__process_event_update needs update.
>> Ian,  have another query as well in the patch , adding them below.
>=20
> Thanks for testing and catching this!
>=20
> Before commit 811082e4b668, __perf_evlist__propagate_maps() clobbered
> cycles/cpu=3D8/ and cycles/cpu=3D9/ to the "any CPU" (-1) map when =
recording
> a workload without -a, so both counters recorded CPU -1 (which is why
> both reported identical task-wide totals with no CPU8/CPU9 column).
>=20
> With per-evsel CPUs preserved on workload targets, =
evlist->user_requested_cpus
> (written to PERF_RECORD_CPU_MAP) is still the "any CPU" (-1) map while
> evlist->all_cpus holds {8, 9}. perf_stat_init_aggr_mode_file() and
> perf_stat_init_aggr_mode() built stat_config.aggr_map from
> user_requested_cpus (-1) rather than falling back to all_cpus, so CPU =
8
> and CPU 9 had no entries in aggr_map and were skipped during -A =
output.
> Also process_stat_config_event() checked =
perf_cpu_map__is_empty(st->cpus)
> instead of checking whether all_cpus only contains -1 for pure task =
data.
>=20
> I've updated patch 5 in v2 to fall back to evlist->all_cpus when
> user_requested_cpus is the "any CPU" (-1) map (and check all_cpus in
> process_stat_config_event()), so 'perf stat report -A' now displays =
the
> CPU8 and CPU9 counter lines, and added a '-A' test case in stat.sh.

Hi Ian

Sure, Thanks for responding and considering the changes.
Will watch out for V2 and check the new changes.

Thanks
Athira
>=20
>>>=20
>>> 2. In system-wide mode (-a), per-evsel CPU restrictions such as =
cpu=3D0
>>>  were overwritten by the full PMU cpumask during report, causing
>>>  perf stat report -A to report bogus <not counted> entries on every
>>>  other CPU.
>>>=20
>>> Fix perf_event__synthesize_event_update_cpus() to serialize
>>> evsel->core.cpus, and update perf_event__process_event_update() to
>>> populate evsel->core.cpus and set requires_cpu when the recorded CPU =
map
>>> does not use the "any CPU" (-1) placeholder. For backward =
compatibility
>>> with data files recorded by older perf binaries that wrote pmu_cpus =
for
>>> per-task (-1) counters, fall back to the "any CPU" map in
>>> perf_event__process_stat_event() if a -1 CPU stat event arrives for =
an
>>> evsel without -1 in its CPU map.
>>>=20
>>> Update the event_update unit test and stat.sh record/report/script =
tests
>>> to cover per-evsel CPU maps on workload targets.
>>>=20
>>> Fixes: 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus")
>>> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed =
with threads/processes")
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> tools/perf/tests/event_update.c    | 43 =
++++++++++++++++++++++++++----
>>> tools/perf/tests/shell/stat.sh     | 16 +++++++++++
>>> tools/perf/util/evsel.c            |  2 +-
>>> tools/perf/util/header.c           |  5 ++++
>>> tools/perf/util/stat.c             | 18 +++++++++++++
>>> tools/perf/util/synthetic-events.c |  7 +++--
>>> 6 files changed, 83 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/tools/perf/tests/event_update.c =
b/tools/perf/tests/event_update.c
>>> index 220cc0347747..bacf3c44c8e2 100644
>>> --- a/tools/perf/tests/event_update.c
>>> +++ b/tools/perf/tests/event_update.c
>>> @@ -1,6 +1,7 @@
>>> // SPDX-License-Identifier: GPL-2.0
>>> #include <linux/compiler.h>
>>> #include <perf/cpumap.h>
>>> +#include <perf/evlist.h>
>>> #include <string.h>
>>> #include "cpumap.h"
>>> #include "evlist.h"
>>> @@ -58,13 +59,20 @@ static int process_event_name(const struct =
perf_tool *tool,
>>> return 0;
>>> }
>>>=20
>>> -static int process_event_cpus(const struct perf_tool *tool =
__maybe_unused,
>>> +struct event_cpus {
>>> + struct perf_tool tool;
>>> + struct evlist *evlist;
>>> +};
>>> +
>>> +static int process_event_cpus(const struct perf_tool *tool,
>>>     union perf_event *event,
>>>     struct perf_sample *sample __maybe_unused,
>>>     struct machine *machine __maybe_unused)
>>> {
>>> + struct event_cpus *tmp =3D container_of(tool, struct event_cpus, =
tool);
>>> struct perf_record_event_update *ev =3D (struct =
perf_record_event_update *)event;
>>> - struct perf_cpu_map *map;
>>> + struct perf_cpu_map *map, *any_cpu;
>>> + struct evsel *evsel;
>>>=20
>>> map =3D cpu_map__new_data(&ev->cpus.cpus);
>>>=20
>>> @@ -75,6 +83,26 @@ static int process_event_cpus(const struct =
perf_tool *tool __maybe_unused,
>>> TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 1).cpu =3D=3D =
2);
>>> TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 2).cpu =3D=3D =
3);
>>> perf_cpu_map__put(map);
>>> +
>>> + evsel =3D evlist__first(tmp->evlist);
>>> + perf_cpu_map__put(evsel->core.cpus);
>>> + evsel->core.cpus =3D NULL;
>>> + perf_cpu_map__put(evsel->core.pmu_cpus);
>>> + evsel->core.pmu_cpus =3D NULL;
>>> + evsel->core.requires_cpu =3D false;
>>> +
>>> + TEST_ASSERT_VAL("failed to process attr update cpus",
>>> + !perf_event__process_event_update(tool, event, &tmp->evlist));
>>> +
>>> + any_cpu =3D perf_cpu_map__new_any_cpu();
>>> + TEST_ASSERT_VAL("failed to allocate any_cpu map", any_cpu);
>>> + perf_evlist__set_maps(evlist__core(tmp->evlist), any_cpu, NULL);
>>> + perf_cpu_map__put(any_cpu);
>>> +
>>> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__nr(evsel->core.cpus) =3D=3D 3);
>>> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__cpu(evsel->core.cpus, 0).cpu =3D=3D 1);
>>> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__cpu(evsel->core.cpus, 1).cpu =3D=3D 2);
>>> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__cpu(evsel->core.cpus, 2).cpu =3D=3D 3);
>>> return 0;
>>> }
>>>=20
>>> @@ -82,6 +110,7 @@ static int test__event_update(struct test_suite =
*test __maybe_unused, int subtes
>>> {
>>> struct evsel *evsel;
>>> struct event_name tmp;
>>> + struct event_cpus tmp_cpus;
>>> struct target target =3D {};
>>> struct evlist *evlist =3D evlist__new_default(&target, =
/*sample_callchains=3D*/false);
>>>=20
>>> @@ -111,11 +140,15 @@ static int test__event_update(struct =
test_suite *test __maybe_unused, int subtes
>>> TEST_ASSERT_VAL("failed to synthesize attr update name",
>>> !perf_event__synthesize_event_update_name(&tmp.tool, evsel, =
process_event_name));
>>>=20
>>> - perf_cpu_map__put(evsel->core.pmu_cpus);
>>> - evsel->core.pmu_cpus =3D perf_cpu_map__new("1,2,3");
>>> + perf_cpu_map__put(evsel->core.cpus);
>>> + evsel->core.cpus =3D perf_cpu_map__new("1,2,3");
>>> +
>>> + perf_tool__init(&tmp_cpus.tool, /*ordered_events=3D*/false);
>>> + tmp_cpus.evlist =3D evlist;
>>>=20
>>> TEST_ASSERT_VAL("failed to synthesize attr update cpus",
>>> - !perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, =
process_event_cpus));
>>> + !perf_event__synthesize_event_update_cpus(&tmp_cpus.tool, evsel,
>>> +  process_event_cpus));
>>>=20
>>> evlist__put(evlist);
>>> return 0;
>>> diff --git a/tools/perf/tests/shell/stat.sh =
b/tools/perf/tests/shell/stat.sh
>>> index ac9e031831da..43a158ee3609 100755
>>> --- a/tools/perf/tests/shell/stat.sh
>>> +++ b/tools/perf/tests/shell/stat.sh
>>> @@ -77,6 +77,14 @@ test_stat_record_report() {
>>>    err=3D1
>>>    return
>>>  fi
>>> +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
>>> +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o =
- true | \
>>> +    perf stat report -i - 2>&1 | grep -E -q =
"task-clock/cpu=3D${cpu}/"
>>> +  then
>>> +    echo "stat record and report test [Failed per-evsel CPU]"
>>> +    err=3D1
>>> +    return
>>> +  fi
>>>  echo "stat record and report test [Success]"
>>> }
>>>=20
>>> @@ -89,6 +97,14 @@ test_stat_record_script() {
>>>    err=3D1
>>>    return
>>>  fi
>>> +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
>>> +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o =
- true | \
>>> +    perf script -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
>>> +  then
>>> +    echo "stat record and script test [Failed per-evsel CPU]"
>>> +    err=3D1
>>> +    return
>>> +  fi
>>>  echo "stat record and script test [Success]"
>>> }
>>>=20
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 1f96c170d277..64daef4cc345 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -1822,7 +1822,7 @@ void evsel__config(struct evsel *evsel, const =
struct record_opts *opts,
>>> attr->exclude_user   =3D 1;
>>> }
>>>=20
>>> - if (evsel->core.pmu_cpus || evsel->unit)
>>> + if (evsel->core.cpus || evsel->core.pmu_cpus || evsel->unit)
>>> evsel->core.attr.read_format |=3D PERF_FORMAT_ID;
>>>=20
>>> /*
>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>> index 9eec6deee190..e9af99b8c0f8 100644
>>> --- a/tools/perf/util/header.c
>>> +++ b/tools/perf/util/header.c
>>> @@ -5962,6 +5962,11 @@ int perf_event__process_event_update(const =
struct perf_tool *tool __maybe_unused
>>> if (map) {
>>> perf_cpu_map__put(evsel->core.pmu_cpus);
>>> evsel->core.pmu_cpus =3D map;
>>> + if (!evsel->counts) {
>>> + perf_cpu_map__put(evsel->core.cpus);
>>> + evsel->core.cpus =3D perf_cpu_map__get(map);
>>=20
>> Here pmu_cpus and core.cpus will point to same data ? When =
evsel->counts is zero, both will carry same =E2=80=9Cperf_cpu_map=E2=80=9D=
 object.
>> So during report, the pmu_cpus will hold same contents as =E2=80=9Ccpus=
=E2=80=9D , which is record opened cpu map.
>> But ideally pmu_cpus should be having the PMU=E2=80=99s cpumask ?
>=20
> perf.data only carries a single PERF_EVENT_UPDATE__CPUS record (not a
> separate PMU cpumask), and during 'perf stat report' the evsels are
> reconstructed from PERF_RECORD_HEADER_ATTR rather than parsed against
> the reporting machine's local sysfs PMUs (which may be a different =
host
> with different online CPUs). When set_maps() calls
> __perf_evlist__propagate_maps(), non-"any CPU" evsel->cpus is
> intersected with evsel->pmu_cpus, so pmu_cpus needs to cover the
> recorded CPUs to avoid intersecting them away.
>=20
> However, when map is the "any CPU" (-1) placeholder, pmu_cpus =
shouldn't
> be set to {-1}. In v2 I've guarded the pmu_cpus assignment with
> !perf_cpu_map__has_any_cpu(map) and added a comment explaining why
> pmu_cpus is populated from concrete recorded CPU maps.

Sure, having a comment will help.
>=20
> Thanks,
> Ian
>=20
>> Thanks
>> Athira
>>=20
>>> + evsel->core.requires_cpu =3D !perf_cpu_map__has_any_cpu(map);
>>> + }
>>> } else
>>> pr_err("failed to get event_update cpus\n");
>>> break;
>>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>>> index 6da3dbbde0e2..429bfc339308 100644
>>> --- a/tools/perf/util/stat.c
>>> +++ b/tools/perf/util/stat.c
>>> @@ -8,6 +8,7 @@
>>>=20
>>> #include <linux/err.h>
>>> #include <linux/zalloc.h>
>>> +#include <perf/cpumap.h>
>>>=20
>>> #include "counts.h"
>>> #include "cpumap.h"
>>> @@ -674,6 +675,23 @@ int perf_event__process_stat_event(const struct =
perf_tool *tool __maybe_unused,
>>> return -EINVAL;
>>> }
>>> cpu_map_idx =3D perf_cpu_map__idx(evsel__cpus(counter), (struct =
perf_cpu){.cpu =3D st->cpu});
>>> + if (cpu_map_idx =3D=3D -1 && (s32)st->cpu =3D=3D -1 && =
counter->counts &&
>>> +    evsel__nr_cpus(counter) > 0) {
>>> + /*
>>> + * Older perf tools wrote pmu_cpus instead of cpus in
>>> + * PERF_EVENT_UPDATE__CPUS, leaving per-task counters with a
>>> + * CPU list instead of the "any CPU" (-1) map used by their
>>> + * PERF_RECORD_STAT events.
>>> + */
>>> + struct perf_cpu_map *any_cpu =3D perf_cpu_map__new_any_cpu();
>>> +
>>> + if (any_cpu) {
>>> + perf_cpu_map__put(counter->core.cpus);
>>> + counter->core.cpus =3D any_cpu;
>>> + counter->core.requires_cpu =3D false;
>>> + cpu_map_idx =3D 0;
>>> + }
>>> + }
>>> if (cpu_map_idx =3D=3D -1) {
>>> pr_err("Invalid CPU %d for event %s.\n", st->cpu, =
evsel__name(counter));
>>> return -EINVAL;
>>> diff --git a/tools/perf/util/synthetic-events.c =
b/tools/perf/util/synthetic-events.c
>>> index 3c8d29f27fd9..b87d15a5be6a 100644
>>> --- a/tools/perf/util/synthetic-events.c
>>> +++ b/tools/perf/util/synthetic-events.c
>>> @@ -2234,10 +2234,13 @@ int =
perf_event__synthesize_event_update_name(const struct perf_tool *tool, =
struc
>>> int perf_event__synthesize_event_update_cpus(const struct perf_tool =
*tool, struct evsel *evsel,
>>>    perf_event__handler_t process)
>>> {
>>> - struct synthesize_cpu_map_data syn_data =3D { .map =3D =
evsel->core.pmu_cpus };
>>> + struct synthesize_cpu_map_data syn_data =3D { .map =3D =
evsel->core.cpus };
>>> struct perf_record_event_update *ev;
>>> int err;
>>>=20
>>> + if (!evsel->core.cpus)
>>> + return 0;
>>> +
>>> ev =3D cpu_map_data__alloc(&syn_data, sizeof(struct =
perf_event_header) + 2 * sizeof(u64));
>>> if (!ev)
>>> return -ENOMEM;
>>> @@ -2315,7 +2318,7 @@ int perf_event__synthesize_extra_attr(const =
struct perf_tool *tool, struct evlis
>>> }
>>> }
>>>=20
>>> - if (evsel->core.pmu_cpus) {
>>> + if (evsel->core.cpus) {
>>> err =3D perf_event__synthesize_event_update_cpus(tool, evsel, =
process);
>>> if (err < 0) {
>>> pr_err("Couldn't synthesize evsel cpus.\n");
>>> --
>>> 2.56.1.750.gf70dc682cf-goog


