Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BF2AE66;
	Sat, 20 Jul 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464509; cv=none; b=K7OI5d+mBEOrYhA5wZlbpt1S80R6LAzKSngcE3iRIhFvycFbsGEXjwNNSPInT3GNRgHKiOHqb7zebhIrl+mgKymIBBwpKBir7e/+Ad52YOUFM7E1oJShVlzOR/lHTv9x7F7UotOTKiyjV8kH85E1tCd7IiZCxA/rsoApJwnX11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464509; c=relaxed/simple;
	bh=GDCswwZ3H6I9fVzq00wGUmivOr1Aqnil1dVgdZeaD5g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=airLQ3dbAACT+jahafW/2pOfZXnuRdqP6cgqIyHorHLyu9TXc9EOa38RVkPX8onUIi61v+bLEYw/F42tcRrUscNwu0t+0q38ZXqM2Gl8FDrFyjTRtBhOlBY6x7B24jgsES0PVzuenCSBsyU8cagiW9AqLhsomCgcEvppnRT81Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AFOpsB4l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFOpsB4l"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46K8TF2p000568;
	Sat, 20 Jul 2024 08:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=z
	Zchxu4XLpL2mSRCqdmQcK3h6G3JuMmYv+otXvOO7ac=; b=AFOpsB4lAC33yNllg
	YcNZ1gX0f4t/fxbcI0RrcX5griFwY8Khu2lD6A3dOshIIIbGfHsEWFk7oml9G7Cc
	iE8pmG3NaQRFxRdMvaUzPdRZRM9WGul6t97R8txAhtITA3UQn+VXpWdW8vcgpY0P
	VZ2Zcwl9aOmXQI6HSVOU41VsYI+18b85uOFwGJ06S0EAB+mYU2lPJ+GYepDNdAon
	sgZv/RtG1Q6LDz+EGp/OEptsfKasQWJ+W1hEihiqwtpg1BYn0F3J1JntaaFPYVY7
	EjuAbnSbi/MJw6QlV2nRUyaeUwrgYzZPfIDN/vzsNcgDiTPWImmDIwrB4zFeLg9A
	rcR5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40g9rn006v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jul 2024 08:34:43 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46K8YgDk008989;
	Sat, 20 Jul 2024 08:34:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40g9rn006s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jul 2024 08:34:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46K8GtbP012992;
	Sat, 20 Jul 2024 08:34:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40g5rjrw80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jul 2024 08:34:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46K8YbNK21496362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 08:34:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114D020145;
	Sat, 20 Jul 2024 08:08:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DC4120143;
	Sat, 20 Jul 2024 08:08:44 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.87.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 20 Jul 2024 08:08:43 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240719081651.24853-1-eric.lin@sifive.com>
Date: Sat, 20 Jul 2024 13:38:29 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com,
        greentime.hu@sifive.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
References: <20240719081651.24853-1-eric.lin@sifive.com>
To: Eric Lin <eric.lin@sifive.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2lrzAoEmrKtjPRizi6AfHKsVw0Z0w4My
X-Proofpoint-ORIG-GUID: L5hdSVftiMQdyi3MiEApUuo3rYk8W0uP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407200060



> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> =
wrote:
>=20
> Currently, if vendor JSON files have two duplicate event names,
> the "perf list" command will trigger a segfault.
>=20
> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> pmu_events_table__num_events() gets the number of JSON events
> from table_pmu->num_entries, which includes duplicate events
> if there are duplicate event names in the JSON files.

Hi Eric,

Let us consider there are duplicate event names in the JSON files, say :

metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2

If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=9D =
will list only one entry for pmu_cache_miss with may be 0x1/0x2 as event =
code ?
Can you check the result to confirm what =E2=80=9Cperf list=E2=80=9D =
will list in this case ? If it=E2=80=99s going to have only one entry in =
perf list, does it mean there are two event codes for pmu_cache_miss and =
it can work with either of the event code ?

If it happens to be a mistake in json file to have duplicate entry with =
different event code (ex: with some broken commit), I am thinking if the =
better fix is to keep only the valid entry in json file ?

Thanks
Athira

>=20
> perf_pmu__for_each_event() adds JSON events to the pmu->alias
> list and copies sevent data to the aliases array. However, the
> pmu->alias list does not contain duplicate events, as
> perf_pmu__new_alias() checks if the name was already created.
>=20
> When sorting the alias data, if there are two duplicate events,
> it causes a segfault in cmp_sevent() due to invalid aliases in
> the aliases array.
>=20
> To avoid such segfault caused by duplicate event names in the
> JSON files, the len should be updated before sorting the aliases.
>=20
> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> ---
> tools/perf/util/pmus.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b9b4c5eb5002..e38c3fd4d1ff 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct =
print_callbacks *print_cb, void *p
> {
> struct perf_pmu *pmu;
> int printed =3D 0;
> - int len;
> + size_t len, j;
> struct sevent *aliases;
> struct events_callback_state state;
> bool skip_duplicate_pmus =3D =
print_cb->skip_duplicate_pmus(print_state);
> @@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct =
print_callbacks *print_cb, void *p
> perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
> perf_pmus__print_pmu_events__callback);
> }
> + len =3D state.index;
> qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> - for (int j =3D 0; j < len; j++) {
> + for (j =3D 0; j < len; j++) {
> /* Skip duplicates */
> if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> continue;
> --=20
> 2.43.2
>=20
>=20

