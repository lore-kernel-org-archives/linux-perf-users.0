Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454000;
	b=vb3P4xWtSb/zDUQGy07jCuegdRk7ZvkHVsG4uvDJ1RsRfm+RIFgDyGyMpfNfpwEp521a
	 UaIwi5gdcweBSwoUlW7TxDuP7b2X9OGUkwI5RQF9YUUG2M9YM7/8DfJgxQ74ult8yZ3RO
	 kBVuJpeJCvNbBKdbyK+HE2CAgOfFrK5u4VMtXWmEbH7QGTKicrnnQDA8684Iw02g3qXQ7
	 H0npNXFh4CB/+TTqt/NQXqtSFP8S5ivlY4T/bImsoFMP2Vd6KoOv6fsmmx5hT4izjpWXL
	 PmnxMr5Ka3MHe+GHYAf1M1HBWo8o7IBis6pG0ztmYoDQxFiPMG9JfmXoQarPc0uISXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZAOPVCuoKJRPnjDM6HJCeH3ec/F41DSYrkL0Eg5bCyo=;
	b=AI+isQOG+hh8MoklvgiduK896fDo2QPA9idogTRQ+GPr4iwzgGkoPKMRsX/nV95BM7w4
	 pFnrh4Av1Bh4sqHP8TxgyZ2w12niUkPBQqnKR5Bre8+YM1hflMFAyvNaPxtqI5UiJX7LR
	 Va9sljJz5kFC+A+kS3vOfZ8x5ow+KNplDQ0VgCKhrMbSVMR0kfgjLMCdoMjREDK9LIp5C
	 yYJRcurzBYzWmglCTS7mlDU/Tovft+acVNd/5085r9S2neteXWyUt31G4fSbPiU8oxoTf
	 KVW3ED83OAa3Xpox0jh5SNPmHVl2/kDFMxV7ETIOqXVxsUSMmgbbLTFVEMlBw+hKXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FnWPMZLg;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E7606A327;
	Mon, 23 Nov 2026 17:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A1E7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FnWPMZLg
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGYXhX062628;
	Mon, 23 Nov 2026 17:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZAOPVC
	uoKJRPnjDM6HJCeH3ec/F41DSYrkL0Eg5bCyo=; b=FnWPMZLgfeqYeDqxNLobYB
	0k0Inh9JDG8Utj0UJGb7SbFv6t6lWXIJ1nSsys5Fi5tkDzTtl2RQbw0hwJRrNYj9
	dWveNpq5b7gzhINDmtakY7JfPVu9aPESbPAcp2ylx4hM56cxqD3ePwcdi4j/5J6+
	6uCAgbCRVV2qtux18PZlTqyKQNwV2ysCSZbeiNeg9Z5OANcCcG6eEstVqP3S23mS
	pCc2x7YL40ODjwD88NTmaEnc8vh6DK3hTGVjxrqHqpwpoGJwz60syCITnfs+t8DN
	iDKDBti/2NHePrRMZvKjQVfGdlnXV3HCf9ZdCu40rOMXCWsXRxV5h5KsoKiFSYdg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa49uy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:12:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGJtvk3550440;
	Mon, 23 Nov 2026 17:12:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjymkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:12:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANHCp8p51118584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 17:12:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 931832004B;
	Mon, 23 Nov 2026 17:12:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08A520040;
	Mon, 23 Nov 2026 17:12:48 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.26.6])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Nov 2026 17:12:48 +0000 (GMT)
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
In-Reply-To: <20261123071913.653315-6-irogers@google.com>
Date: Mon, 23 Nov 2026 22:42:36 +0530
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
Message-Id: <3F569607-DA0C-47B3-823D-926D12D7FBC1@linux.ibm.com>
References: <20261123071913.653315-1-irogers@google.com>
 <20261123071913.653315-6-irogers@google.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfX8lCJpHmNJHIk
 aJfM4L/8txUo5tRkhLCnbazpAEc9lFqMH19UG7Lm2C4GyC/BY2PHPzNZwYpbW7V+DESXl7ttIgn
 tg7U+dTTzZyr4O1/Ka/UQ7jxQvjoZ51kd0PS4I1W3aOGPTDJ8A7+uX4OgLzL72Jd3uY1BVqQppo
 Yz+kiUbV7seeExC1t8XHEC0SEb7Z/HcIB/FRmm8Wkn8StUvE1LHpRYdl7Qn/wxtaBp9libRCZIt
 c3q6dz42FxPrPjNbRAU+0xgyFTbBkl2VnYzLPMqnUKZTB+zBe/FcpmrQHorIVThF4ZbxQXytKxS
 mzeccySNB+zKAyyfqhJPXySeZawqlQq2J7nzkLEsuZKFbJ8bYbMaF7+Sb3mhrU0iQ+q+GzE7sIi
 0BDNd7KViQtzj+n8M9B10STA2+JwmGmoepuYDg/I35SQUe0nrGQg1l4VyLEpVNAcrfzWbeST9Bb
 /wWgf5fI6PJIuOc0nNw==
X-Proofpoint-ORIG-GUID: rEi5iwvboSDNRgCIpbWucdyD5-dETsdz
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b047417 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=Amtoao9nXyXCFzzJoSoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J1NJRTs_9sReyG57d6Kn8xttTPLULfRT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfX/7RbGiMLisy7
 MWptsP7AmQN3h949tdJDWx0Dl8D+GqxcePauHFROgfcmqvPJwPAhu2luCbXl9tRmwbf8wNOQnHt
 Xrk/6YgNaSzuTPrUR5GT1yKUf51m9O0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230068



> On 23 Nov 2026, at 12:49=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> Commit 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus") and
> commit 811082e4b668 ("perf parse-events: Support user CPUs mixed with
> threads/processes") separated an evsel's PMU cpumask (pmu_cpus) from =
the
> actual CPUs on which the event is opened (cpus) and taught
> __perf_evlist__propagate_maps() to collapse evsel->cpus to the "any =
CPU"
> (-1) map when user_requested_cpus is -1 and !evsel->requires_cpu.
>=20
> However, perf_event__synthesize_event_update_cpus() continued to
> serialize evsel->core.pmu_cpus instead of evsel->core.cpus, and
> perf_event__process_event_update() only populated evsel->core.pmu_cpus
> without setting evsel->core.cpus or evsel->core.requires_cpu. This =
broke
> perf stat record/report (and perf script) in two ways:
>=20
> 1. When recording an event opened per-CPU alongside a workload target
>   (where user_requested_cpus is -1), such as an event with a cpu=3D =
term,
>   an uncore counter, --bpf-counters, or a BPF-filtered counter,
>   PERF_RECORD_STAT events are written with concrete CPU numbers, but
>   perf stat report's perf_evlist__set_maps() collapses evsel->cpus to
>   -1 and fails with:
>=20
>     $ perf stat record -e 'task-clock/cpu=3D0/,task-clock' -- true
>     $ perf stat report
>     Invalid CPU 0 for event task-clock/cpu=3D0/.

Hi Ian

Thanks for the fix, verified the fix for "perf stat report". But I have =
one observation when using aggregation mode.

Working case with the fix:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

With the fix:

./perf stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ <workload>
./perf stat report

Perf stat report works fine
Also checked system wide.

Using -A:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Before broken commits 6d765f5f7ec6 and 811082e4b668,
./perf stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ <workload>
./perf stat report -A : this was working

    ./perf stat report -A

    Performance counter stats for '/root/perf-tools-next/tools/perf/perf =
stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ ./stream=E2=80=99: =20


    3,447,492,527,125      cycles/cpu=3D8/                               =
                 =20
    3,447,492,527,125      cycles/cpu=3D9/                               =
                          =20
     108.543826387 seconds time elapsed

On top of this patch, result looks like:
./perf stat report -A

 Performance counter stats for '/root/perf-tools-next/tools/perf/perf':


       2.119970008 seconds time elapsed

There are no counter line, only time elapsed. I am suspecting the change =
for perf_event__process_event_update needs update.
Ian,  have another query as well in the patch , adding them below.

>=20
> 2. In system-wide mode (-a), per-evsel CPU restrictions such as cpu=3D0
>   were overwritten by the full PMU cpumask during report, causing
>   perf stat report -A to report bogus <not counted> entries on every
>   other CPU.
>=20
> Fix perf_event__synthesize_event_update_cpus() to serialize
> evsel->core.cpus, and update perf_event__process_event_update() to
> populate evsel->core.cpus and set requires_cpu when the recorded CPU =
map
> does not use the "any CPU" (-1) placeholder. For backward =
compatibility
> with data files recorded by older perf binaries that wrote pmu_cpus =
for
> per-task (-1) counters, fall back to the "any CPU" map in
> perf_event__process_stat_event() if a -1 CPU stat event arrives for an
> evsel without -1 in its CPU map.
>=20
> Update the event_update unit test and stat.sh record/report/script =
tests
> to cover per-evsel CPU maps on workload targets.
>=20
> Fixes: 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus")
> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with =
threads/processes")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> tools/perf/tests/event_update.c    | 43 ++++++++++++++++++++++++++----
> tools/perf/tests/shell/stat.sh     | 16 +++++++++++
> tools/perf/util/evsel.c            |  2 +-
> tools/perf/util/header.c           |  5 ++++
> tools/perf/util/stat.c             | 18 +++++++++++++
> tools/perf/util/synthetic-events.c |  7 +++--
> 6 files changed, 83 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/perf/tests/event_update.c =
b/tools/perf/tests/event_update.c
> index 220cc0347747..bacf3c44c8e2 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
> #include <linux/compiler.h>
> #include <perf/cpumap.h>
> +#include <perf/evlist.h>
> #include <string.h>
> #include "cpumap.h"
> #include "evlist.h"
> @@ -58,13 +59,20 @@ static int process_event_name(const struct =
perf_tool *tool,
> return 0;
> }
>=20
> -static int process_event_cpus(const struct perf_tool *tool =
__maybe_unused,
> +struct event_cpus {
> + struct perf_tool tool;
> + struct evlist *evlist;
> +};
> +
> +static int process_event_cpus(const struct perf_tool *tool,
>      union perf_event *event,
>      struct perf_sample *sample __maybe_unused,
>      struct machine *machine __maybe_unused)
> {
> + struct event_cpus *tmp =3D container_of(tool, struct event_cpus, =
tool);
> struct perf_record_event_update *ev =3D (struct =
perf_record_event_update *)event;
> - struct perf_cpu_map *map;
> + struct perf_cpu_map *map, *any_cpu;
> + struct evsel *evsel;
>=20
> map =3D cpu_map__new_data(&ev->cpus.cpus);
>=20
> @@ -75,6 +83,26 @@ static int process_event_cpus(const struct =
perf_tool *tool __maybe_unused,
> TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 1).cpu =3D=3D 2);
> TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 2).cpu =3D=3D 3);
> perf_cpu_map__put(map);
> +
> + evsel =3D evlist__first(tmp->evlist);
> + perf_cpu_map__put(evsel->core.cpus);
> + evsel->core.cpus =3D NULL;
> + perf_cpu_map__put(evsel->core.pmu_cpus);
> + evsel->core.pmu_cpus =3D NULL;
> + evsel->core.requires_cpu =3D false;
> +
> + TEST_ASSERT_VAL("failed to process attr update cpus",
> + !perf_event__process_event_update(tool, event, &tmp->evlist));
> +
> + any_cpu =3D perf_cpu_map__new_any_cpu();
> + TEST_ASSERT_VAL("failed to allocate any_cpu map", any_cpu);
> + perf_evlist__set_maps(evlist__core(tmp->evlist), any_cpu, NULL);
> + perf_cpu_map__put(any_cpu);
> +
> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__nr(evsel->core.cpus) =3D=3D 3);
> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__cpu(evsel->core.cpus, 0).cpu =3D=3D 1);
> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__cpu(evsel->core.cpus, 1).cpu =3D=3D 2);
> + TEST_ASSERT_VAL("wrong processed cpus", =
perf_cpu_map__cpu(evsel->core.cpus, 2).cpu =3D=3D 3);
> return 0;
> }
>=20
> @@ -82,6 +110,7 @@ static int test__event_update(struct test_suite =
*test __maybe_unused, int subtes
> {
> struct evsel *evsel;
> struct event_name tmp;
> + struct event_cpus tmp_cpus;
> struct target target =3D {};
> struct evlist *evlist =3D evlist__new_default(&target, =
/*sample_callchains=3D*/false);
>=20
> @@ -111,11 +140,15 @@ static int test__event_update(struct test_suite =
*test __maybe_unused, int subtes
> TEST_ASSERT_VAL("failed to synthesize attr update name",
> !perf_event__synthesize_event_update_name(&tmp.tool, evsel, =
process_event_name));
>=20
> - perf_cpu_map__put(evsel->core.pmu_cpus);
> - evsel->core.pmu_cpus =3D perf_cpu_map__new("1,2,3");
> + perf_cpu_map__put(evsel->core.cpus);
> + evsel->core.cpus =3D perf_cpu_map__new("1,2,3");
> +
> + perf_tool__init(&tmp_cpus.tool, /*ordered_events=3D*/false);
> + tmp_cpus.evlist =3D evlist;
>=20
> TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> - !perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, =
process_event_cpus));
> + !perf_event__synthesize_event_update_cpus(&tmp_cpus.tool, evsel,
> +  process_event_cpus));
>=20
> evlist__put(evlist);
> return 0;
> diff --git a/tools/perf/tests/shell/stat.sh =
b/tools/perf/tests/shell/stat.sh
> index ac9e031831da..43a158ee3609 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -77,6 +77,14 @@ test_stat_record_report() {
>     err=3D1
>     return
>   fi
> +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
> +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o - =
true | \
> +    perf stat report -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
> +  then
> +    echo "stat record and report test [Failed per-evsel CPU]"
> +    err=3D1
> +    return
> +  fi
>   echo "stat record and report test [Success]"
> }
>=20
> @@ -89,6 +97,14 @@ test_stat_record_script() {
>     err=3D1
>     return
>   fi
> +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
> +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o - =
true | \
> +    perf script -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
> +  then
> +    echo "stat record and script test [Failed per-evsel CPU]"
> +    err=3D1
> +    return
> +  fi
>   echo "stat record and script test [Success]"
> }
>=20
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1f96c170d277..64daef4cc345 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1822,7 +1822,7 @@ void evsel__config(struct evsel *evsel, const =
struct record_opts *opts,
> attr->exclude_user   =3D 1;
> }
>=20
> - if (evsel->core.pmu_cpus || evsel->unit)
> + if (evsel->core.cpus || evsel->core.pmu_cpus || evsel->unit)
> evsel->core.attr.read_format |=3D PERF_FORMAT_ID;
>=20
> /*
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9eec6deee190..e9af99b8c0f8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -5962,6 +5962,11 @@ int perf_event__process_event_update(const =
struct perf_tool *tool __maybe_unused
> if (map) {
> perf_cpu_map__put(evsel->core.pmu_cpus);
> evsel->core.pmu_cpus =3D map;
> + if (!evsel->counts) {
> + perf_cpu_map__put(evsel->core.cpus);
> + evsel->core.cpus =3D perf_cpu_map__get(map);

Here pmu_cpus and core.cpus will point to same data ? When evsel->counts =
is zero, both will carry same =E2=80=9Cperf_cpu_map=E2=80=9D object.
So during report, the pmu_cpus will hold same contents as =E2=80=9Ccpus=E2=
=80=9D , which is record opened cpu map.
But ideally pmu_cpus should be having the PMU=E2=80=99s cpumask ?=20

Thanks
Athira

> + evsel->core.requires_cpu =3D !perf_cpu_map__has_any_cpu(map);
> + }
> } else
> pr_err("failed to get event_update cpus\n");
> break;
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 6da3dbbde0e2..429bfc339308 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -8,6 +8,7 @@
>=20
> #include <linux/err.h>
> #include <linux/zalloc.h>
> +#include <perf/cpumap.h>
>=20
> #include "counts.h"
> #include "cpumap.h"
> @@ -674,6 +675,23 @@ int perf_event__process_stat_event(const struct =
perf_tool *tool __maybe_unused,
> return -EINVAL;
> }
> cpu_map_idx =3D perf_cpu_map__idx(evsel__cpus(counter), (struct =
perf_cpu){.cpu =3D st->cpu});
> + if (cpu_map_idx =3D=3D -1 && (s32)st->cpu =3D=3D -1 && =
counter->counts &&
> +    evsel__nr_cpus(counter) > 0) {
> + /*
> + * Older perf tools wrote pmu_cpus instead of cpus in
> + * PERF_EVENT_UPDATE__CPUS, leaving per-task counters with a
> + * CPU list instead of the "any CPU" (-1) map used by their
> + * PERF_RECORD_STAT events.
> + */
> + struct perf_cpu_map *any_cpu =3D perf_cpu_map__new_any_cpu();
> +
> + if (any_cpu) {
> + perf_cpu_map__put(counter->core.cpus);
> + counter->core.cpus =3D any_cpu;
> + counter->core.requires_cpu =3D false;
> + cpu_map_idx =3D 0;
> + }
> + }
> if (cpu_map_idx =3D=3D -1) {
> pr_err("Invalid CPU %d for event %s.\n", st->cpu, =
evsel__name(counter));
> return -EINVAL;
> diff --git a/tools/perf/util/synthetic-events.c =
b/tools/perf/util/synthetic-events.c
> index 3c8d29f27fd9..b87d15a5be6a 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2234,10 +2234,13 @@ int =
perf_event__synthesize_event_update_name(const struct perf_tool *tool, =
struc
> int perf_event__synthesize_event_update_cpus(const struct perf_tool =
*tool, struct evsel *evsel,
>     perf_event__handler_t process)
> {
> - struct synthesize_cpu_map_data syn_data =3D { .map =3D =
evsel->core.pmu_cpus };
> + struct synthesize_cpu_map_data syn_data =3D { .map =3D =
evsel->core.cpus };
> struct perf_record_event_update *ev;
> int err;
>=20
> + if (!evsel->core.cpus)
> + return 0;
> +
> ev =3D cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header) =
+ 2 * sizeof(u64));
> if (!ev)
> return -ENOMEM;
> @@ -2315,7 +2318,7 @@ int perf_event__synthesize_extra_attr(const =
struct perf_tool *tool, struct evlis
> }
> }
>=20
> - if (evsel->core.pmu_cpus) {
> + if (evsel->core.cpus) {
> err =3D perf_event__synthesize_event_update_cpus(tool, evsel, =
process);
> if (err < 0) {
> pr_err("Couldn't synthesize evsel cpus.\n");
> --=20
> 2.56.1.750.gf70dc682cf-goog
>=20
>=20

