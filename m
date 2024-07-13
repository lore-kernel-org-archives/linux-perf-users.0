Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF8125B9
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jul 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893783; cv=none; b=CZWwwPmCtJ9Kv0c/1AJ0CATLCSwS1IZd3POMvABSbjxReNZitWeD8D0flyfATFYIwuY2kjqVeJx6ieajXS4jXHJKlijLZjrDwjFCG/+oMuwyXsXHpq3v+kFktFQfcL3I74gmCxxpjmcCVnvd5Wk4tYdxiUAXMJVj7uyvOwOH42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893783; c=relaxed/simple;
	bh=5uvcupYR7awnH3XH0cOPI+t8qYQqovgQVhxa1mHpMvg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m2YvpA7RNTa4yNqKslzNlc+7jSKDwYxUq0JrdiVS7lz2WIIhfmagoJHe7WQymI1EdmnCF0Ri3yGMwlHOsYwW9pvGZtgZBDtW/ykQMpgFHyv934rmwoF6uNIZPLHW0pn3LQN6bN2Dsp7FoeyJPcSjv+oe0JbZtFwD0AklM/gGthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SliWteLd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SliWteLd"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DHwBZS021286;
	Sat, 13 Jul 2024 18:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=G
	tUPYMhq8SG/cV3PiYlu6VByMSxaIvwbK9rqSxS8en8=; b=SliWteLdH3CK3fDsP
	liO6f36ZHo7c88y6CCAiwR8EsL8aX7dQw8fSk1q/zE/4PSLT5ity3dddW+tF2FI6
	XAcFY8FeVwqw0Kvb6zlMgFLd6n6zUP6+Pdk+cW8qUwLQ4YmsDeKWzPztI6iLYGtF
	2jxWD07xdt0HowGgXfAhPi+HXj8OLhOpJfXbgYG351MQiYE51OTaD7/NRJwZCw3K
	WygdVEvSHoCfU7U/abTy24pyp9/Y/p7+63LCl9lfoc7381f2/o6u62B7vHuTpyqJ
	kLmJLuRggAijrzdFzUBHa2A1mun4mVTGYG6wcEUn7o71WtlVXwuKlw+PuoLfWIE+
	grfgQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8fg5q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 18:02:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DFRMBQ010190;
	Sat, 13 Jul 2024 18:02:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40bqxksdu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 18:02:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DI2oJT46203354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 18:02:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2544920043;
	Sat, 13 Jul 2024 18:02:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654FC20040;
	Sat, 13 Jul 2024 18:02:49 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.49.134])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 13 Jul 2024 18:02:49 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v5 1/2] perf script: Fix perf script -F +metric
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240713155443.1665378-1-ak@linux.intel.com>
Date: Sat, 13 Jul 2024 23:32:37 +0530
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA123DCE-7607-45A8-987B-34F42B3D9E7B@linux.vnet.ibm.com>
References: <20240713155443.1665378-1-ak@linux.intel.com>
To: Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CbOMP9Z5ihm7xXD2k4Ze5tkp22kDhTrB
X-Proofpoint-GUID: CbOMP9Z5ihm7xXD2k4Ze5tkp22kDhTrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_14,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407130135



> On 13 Jul 2024, at 9:24=E2=80=AFPM, Andi Kleen <ak@linux.intel.com> =
wrote:
>=20
> This fixes a regression with perf script -F +metric originally caused =
by :
>=20
> commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> Author: Ian Rogers <irogers@google.com>
> Date:   Sun Feb 19 01:28:46 2023 -0800
>=20
>    perf metric: Directly use counts rather than saved_value
>=20
> In the perf script environment the evsel wouldn't allocate an aggr
> values array, which led to a -1 reference because the metric
> evaluation would try to reference NULL - 1 (for aggr_idx)
>=20
> Give the perf script evsels a single CPU aggr setup. That's
> enough because the groups are always contiguous, so no need
> to store more than one CPU's worth of values.
>=20
> Before
>=20
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> % perf script -F +metric
> Segmentation fault (core dumped)
>=20
> After:
>=20
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> ...
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
> % perf script -F +metric
>       perf-exec 1847557 264658.180789:       3009       cycles:  =
ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
>       perf-exec 1847557 264658.180789:        382 instructions:  =
ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
>       perf-exec 1847557 264658.180789:         metric:    0.13  insn =
per cycle
> ...
>=20
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Hi Andi,

I tested this on powerpc.  It fails.
Version 4 had worked for me. But version 5 fails with segfault

# ./perf record -e '{cycles,instructions}:S' perf bench mem memcpy
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 1MB bytes ...

      25.699013 GB/sec
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.012 MB perf.data (24 samples) ]

# ./perf script -F +metric
Segmentation fault (core dumped)

Adding results from perf test also:

# ./perf test -v "perf script tests=E2=80=9D

script metric test
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.379 MB =
/tmp/perf-test-script.6I9EykwokH/perf.data (8050 samples) ]
/linux/tools/perf/tests/shell/script.sh: line 93: 2280279 Segmentation =
fault      (core dumped) perf script -i "${perfdatafile}" -F +metric > =
$scriptoutput
--- Cleaning up ---
---- end(-1) ----
 93: perf script tests                                               : =
FAILED!

I am trying on top of tmp.perf-tools-next acme tree

# git log --oneline -n 2
7f1c0c721699 (HEAD -> try) Add a test case for perf script -F +metric
cadd820159b3 perf script: Fix perf script -F +metric

Thanks
Athira

>=20

> ----
>=20
> v2: Reformat code
> v3: Work around bogus warning
> v4: Set up aggr map only for metrics case to keep perf stat record
> working
> ---
> tools/perf/builtin-script.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..33b5c7af5071 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2127,23 +2127,29 @@ static void perf_sample__fprint_metric(struct =
perf_script *script,
> };
> struct evsel *ev2;
> u64 val;
> + struct cpu_aggr_map *map;
>=20
> if (!evsel->stats)
> evlist__alloc_stats(&stat_config, script->session->evlist, =
/*alloc_raw=3D*/false);
> if (evsel_script(leader)->gnum++ =3D=3D 0)
> perf_stat__reset_shadow_stats();
> val =3D sample->period * evsel->scale;
> + map =3D stat_config.aggr_map;
> + stat_config.aggr_map =3D &(struct cpu_aggr_map){ .nr =3D 1 };
> + /* Always use CPU 0 storage because the groups are contiguous. */
> + evsel->stats->aggr[0].counts.val =3D val;
> evsel_script(evsel)->val =3D val;
> if (evsel_script(leader)->gnum =3D=3D leader->core.nr_members) {
> for_each_group_member (ev2, leader) {
> perf_stat__print_shadow_stats(&stat_config, ev2,
>      evsel_script(ev2)->val,
> -      sample->cpu,
> +      0,
>      &ctx,
>      NULL);
> }
> evsel_script(leader)->gnum =3D 0;
> }
> + stat_config.aggr_map =3D map;
> }
>=20
> static bool show_event(struct perf_sample *sample,
> --=20
> 2.45.2
>=20
>=20

