Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EA3F54AB;
	Wed, 29 Apr 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471331; cv=none; b=VHvq4j1caDSo7UEK3QPc9lrQU4KGmM/LjOQXWTKReVPikccCk0/UeF9v/WZzglwBfGLjr63Gb2eB8YP7bbSTfZ0v6CeRrnTUs48IAG1CvytyaL1xz36E0EYjop2IQW2B1mw8tRvt6ir1fpmIA65dQXC/q7cZMa+DojimD4EDYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471331; c=relaxed/simple;
	bh=5b6xQ5QIRg32+U58seUM5hyPDH3QUyYKygKCA85v8VI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KUcpeoUU0yi6tcFD/i4jnCwFm96qpjuFPrib5ygOan5rGsiAswPOhAieEMDYSRxBQfDtN+2eOzWT7t0qBMFD93loZDB3NXwgEyWJi4vt5xDhTrNRUUNfDctiyA+MGpGezKAr6GAeN6ztpDMjDr7ljNrMC5ZSXUdXCWSeXz1Ijmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UordvJ5C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UordvJ5C"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCrlUh2932084;
	Wed, 29 Apr 2026 14:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NGBK9X
	R5itoVRN3BJlRIlUkLbPxNjCcnLZ9BJ3gPKf4=; b=UordvJ5Cv5W4NgoxtNnfQy
	xatsTsqNQfMA15rE3PuwCVFclGMxUpkDghWgFWxRYtYbdJLXTh4ov446Esb3HXaR
	hmUpwLxmlnWkAHpKpjNOX9d7/y7hCHtYauyOwCWvv9ulUliF2Z4xCvdrGM6KBO3x
	kZooSTw14iZZbuKkLv2qI1uXJR7WUfMClSFrD1Ojgy5qnIkdHp95EuNFC1BpPre/
	wf7iDrzPCtMKzbUVsAJNPLppIfVo2uQV3r4L4pBkBxtVKEg4Bfjkf6wtNii6aGST
	IlnQZ5qDUGqTAr9n36IqZjoI5UZD+x3sPrR40xG1m1OQNs4qxrQHSq5YG8eyTigw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rat8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:01:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TDrixe014822;
	Wed, 29 Apr 2026 14:01:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avxmkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:01:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TE1n1131261082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 14:01:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A715F20040;
	Wed, 29 Apr 2026 14:01:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C2792004B;
	Wed, 29 Apr 2026 14:01:46 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.18.91])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 14:01:46 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v1] perf sched stats: Fix segmentation faults in diff mode
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260428070811.1883202-1-irogers@google.com>
Date: Wed, 29 Apr 2026 19:31:32 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Venkat <venkat88@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2238F7E3-D50A-449A-B295-C3C996162FBD@linux.ibm.com>
References: <20260428070811.1883202-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Eso-JqtrBF4q8y5pLgXPgK2lmEDpxKj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MCBTYWx0ZWRfX4L9wki5SCFf1
 86KAc0PuFNb8OE3mqWvfw6Ya5z6wMXnQfi/UaifdFAREZ1OaAq6ps8kexQN1H5V0PuNMXt2eM0+
 JDYQxDHrNWVSBHCc7pMNpLI3JVVvweQp+cbsawXQxwwJPCils7pQg5J6WbubZuVY6tZrS5TcWgx
 jTEawseJy5eS0mn9afvKywgcHjRoVtu6ogh5QkbQvBtp2+MNo3stnFB3Ncgne4TDCsVmfRiBRCt
 6nhfvxh2K3Mtwf20fJFbcr4OcoMLeZFCavYaCqi6KgUbKK7QysRAZcqAagCZ+t6va415NPmxaCI
 +F9RIPVGEZGJzYZ3mQueIyoTgselBPmfgWadefNFAKW9Yvu6eWaSCKEBgTfK/B8KIqKmKJozOAJ
 e0imrVDeFNa+LH5Cad/gf5Qr1YUugzZRQSUhzVHuugSnA73+o6poSULbeS/HtHayOUkc8o2WegB
 OLnyiIYK5BUw++nfUqQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f20f51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=MeaIXWbqiAQ5k8bWzGYA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AJocXycCp0itUqltg68pewUhZVIRYgGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290140



> On 28 Apr 2026, at 12:38=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> Address several segmentation fault vectors in `perf sched stats diff`:
>=20
> 1. When processing invalid or empty data files, the CPU domain maps =
may
>   be NULL. Added NULL checks for `cd_map1` and `cd_map2` in
>   `show_schedstat_data()` to fail gracefully.
>=20
> 2. When files contain a different number of CPUs or domains, the =
parallel
>   list iteration in `show_schedstat_data()` could wrap around the list
>   heads and dereference invalid memory. Added `list_is_last` checks
>   to safely terminate iteration at the end of each list.
>=20
> 3. When summarizing CPU statistics in `get_all_cpu_stats()`, parallel =
list
>   iteration over domains could similarly wrap around if a CPU has more
>   domains than the first CPU. Added `list_is_last` check to prevent =
this.
>=20
> 4. Added bounds checks for `cs1->cpu` and `cs2->cpu` against `nr1` and
>   `nr2` (passed from `env->nr_cpus_avail`) to prevent out-of-bounds
>   reads from `cd_map1` and `cd_map2` when processing data from =
machines
>   with different CPU configurations.
>=20
> 5. Added NULL checks for `cd_info1` and `cd_info2` in =
`show_schedstat_data()`
>   to prevent crashes when a CPU has samples in the data file but no
>   corresponding domain info in the header (which leaves the map entry =
NULL).
>=20
> 6. Added NULL checks for `dinfo1` and `dinfo2` in =
`show_schedstat_data()`
>   to prevent crashes when a domain is present in the list but has no
>   corresponding info in the CPU domain map (which leaves the entry =
NULL).
>=20
> 7. Zero-initialized the `perf_data` array in =
`perf_sched__schedstat_diff()`
>   to prevent stack garbage from causing `perf_data_file__fd()` to =
attempt
>   to use a NULL `fptr` when `use_stdio` happened to be non-zero.
>=20
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Previously this patch was part of a large perf script refactor:
> =
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/
> ---
> tools/perf/builtin-sched.c | 95 +++++++++++++++++++++++++++++++-------
> 1 file changed, 79 insertions(+), 16 deletions(-)
>=20
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..9ecda631b3ab 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4212,12 +4212,20 @@ static int get_all_cpu_stats(struct list_head =
*head)
>=20
> cnt++;
> summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
> - tdptr =3D list_first_entry(&summary_head->domain_head, struct =
schedstat_domain,
> - domain_list);
> + if (!list_empty(&summary_head->domain_head))
> + tdptr =3D list_first_entry(&summary_head->domain_head, struct =
schedstat_domain,
> + domain_list);
> + else
> + tdptr =3D NULL;
>=20
> list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> - summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> - tdptr =3D list_next_entry(tdptr, domain_list);
> + if (tdptr) {
> + summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> + if (list_is_last(&tdptr->domain_list, &summary_head->domain_head))
> + tdptr =3D NULL;
> + else
> + tdptr =3D list_next_entry(tdptr, domain_list);
> + }
> }
> }
>=20
> @@ -4225,8 +4233,8 @@ static int get_all_cpu_stats(struct list_head =
*head)
> return ret;
> }
>=20
> -static int show_schedstat_data(struct list_head *head1, struct =
cpu_domain_map **cd_map1,
> -       struct list_head *head2, struct cpu_domain_map **cd_map2,
> +static int show_schedstat_data(struct list_head *head1, struct =
cpu_domain_map **cd_map1, int nr1,
> +       struct list_head *head2, struct cpu_domain_map **cd_map2, int =
nr2,
>       bool summary_only)
> {
> struct schedstat_cpu *cptr1 =3D list_first_entry(head1, struct =
schedstat_cpu, cpu_list);
> @@ -4238,6 +4246,15 @@ static int show_schedstat_data(struct list_head =
*head1, struct cpu_domain_map **
> bool is_summary =3D true;
> int ret =3D 0;
>=20
> + if (!cd_map1) {
> + pr_err("Error: CPU domain map 1 is missing.\n");
> + return -1;
> + }
> + if (head2 && !cd_map2) {
> + pr_err("Error: CPU domain map 2 is missing.\n");
> + return -1;
> + }
> +
> printf("Description\n");
> print_separator2(SEP_LEN, "", 0);
> printf("%-30s-> %s\n", "DESC", "Description of the field");
> @@ -4269,12 +4286,33 @@ static int show_schedstat_data(struct =
list_head *head1, struct cpu_domain_map **
> struct cpu_domain_map *cd_info1 =3D NULL, *cd_info2 =3D NULL;
>=20
> cs1 =3D cptr1->cpu_data;
> + cs2 =3D NULL;
> + dptr2 =3D NULL;
> + if (cs1->cpu >=3D (u32)nr1) {
> + pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
> + return -1;
> + }
> cd_info1 =3D cd_map1[cs1->cpu];
> + if (!cd_info1) {
> + pr_err("Error: CPU %d domain info is missing in map 1.\n", =
cs1->cpu);
> + return -1;
> + }
> if (cptr2) {
> cs2 =3D cptr2->cpu_data;
> + if (cs2->cpu >=3D (u32)nr2) {
> + pr_err("Error: CPU %d exceeds domain map size %d\n", cs2->cpu, nr2);
> + return -1;
> + }
> cd_info2 =3D cd_map2[cs2->cpu];
> - dptr2 =3D list_first_entry(&cptr2->domain_head, struct =
schedstat_domain,
> - domain_list);
> + if (!cd_info2) {
> + pr_err("Error: CPU %d domain info is missing in map 2.\n", =
cs2->cpu);
> + return -1;
> + }
> + if (!list_empty(&cptr2->domain_head))
> + dptr2 =3D list_first_entry(&cptr2->domain_head, struct =
schedstat_domain,
> + domain_list);
> + else
> + dptr2 =3D NULL;
> }
>=20
> if (cs2 && cs1->cpu !=3D cs2->cpu) {
> @@ -4302,10 +4340,26 @@ static int show_schedstat_data(struct =
list_head *head1, struct cpu_domain_map **
> struct domain_info *dinfo1 =3D NULL, *dinfo2 =3D NULL;
>=20
> ds1 =3D dptr1->domain_data;
> + if (ds1->domain >=3D cd_info1->nr_domains) {
> + pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map =
1.\n", ds1->domain, cd_info1->nr_domains, cs1->cpu);
> + return -1;
> + }
> dinfo1 =3D cd_info1->domains[ds1->domain];
> + if (!dinfo1) {
> + pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n", =
ds1->domain, cs1->cpu);
> + return -1;
> + }
> if (dptr2) {
> ds2 =3D dptr2->domain_data;
> + if (ds2->domain >=3D cd_info2->nr_domains) {
> + pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map =
2.\n", ds2->domain, cd_info2->nr_domains, cs2->cpu);
> + return -1;
> + }
> dinfo2 =3D cd_info2->domains[ds2->domain];
> + if (!dinfo2) {
> + pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n", =
ds2->domain, cs2->cpu);
> + return -1;
> + }
> }
>=20
> if (dinfo2 && dinfo1->domain !=3D dinfo2->domain) {
> @@ -4334,14 +4388,22 @@ static int show_schedstat_data(struct =
list_head *head1, struct cpu_domain_map **
> print_domain_stats(ds1, ds2, jiffies1, jiffies2);
> print_separator2(SEP_LEN, "", 0);
>=20
> - if (dptr2)
> - dptr2 =3D list_next_entry(dptr2, domain_list);
> + if (dptr2) {
> + if (list_is_last(&dptr2->domain_list, &cptr2->domain_head))
> + dptr2 =3D NULL;
> + else
> + dptr2 =3D list_next_entry(dptr2, domain_list);
> + }
> }
> if (summary_only)
> break;
>=20
> - if (cptr2)
> - cptr2 =3D list_next_entry(cptr2, cpu_list);
> + if (cptr2) {
> + if (list_is_last(&cptr2->cpu_list, head2))
> + cptr2 =3D NULL;
> + else
> + cptr2 =3D list_next_entry(cptr2, cpu_list);
> + }
>=20
> is_summary =3D false;
> }
> @@ -4523,7 +4585,7 @@ static int perf_sched__schedstat_report(struct =
perf_sched *sched)
> }
>=20
> cd_map =3D session->header.env.cpu_domain;
> - err =3D show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> + err =3D show_schedstat_data(&cpu_head, cd_map, =
session->header.env.nr_cpus_avail, NULL, NULL, 0, false);
> }
>=20
> out:
> @@ -4538,7 +4600,7 @@ static int perf_sched__schedstat_diff(struct =
perf_sched *sched,
> struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
> struct list_head cpu_head_ses0, cpu_head_ses1;
> struct perf_session *session[2];
> - struct perf_data data[2];
> + struct perf_data data[2] =3D {0};

Hi Ian

Thanks for these fixes.

I had sent a fix for only above change ( perf_data initialization ) : =
https://lore.kernel.org/linux-perf-users/20260422173545.73144-1-atrajeev@l=
inux.ibm.com/
Since that change is already covered in this patch. Tested with this =
patch and verified it covers the fix

Before the patch:

# for i in {0..20}; do ./perf test "perf sched stats tests"; done
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
FAILED!
 92: perf sched stats tests                                          : =
FAILED!
 92: perf sched stats tests                                          : =
FAILED!


After this fix

# for i in {0..20}; do ./perf test "perf sched stats tests"; done
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok


Tested-by : Athira Rajeev <atrajeev@linux.ibm.com =
<mailto:atrajeev@linux.ibm.com>>

Thanks
Athira
> int ret =3D 0, err =3D 0;
> static const char *defaults[] =3D {
> "perf.data.old",
> @@ -4610,7 +4672,8 @@ static int perf_sched__schedstat_diff(struct =
perf_sched *sched,
> goto out_delete_ses0;
> }
>=20
> - show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, =
cd_map1, true);
> + show_schedstat_data(&cpu_head_ses0, cd_map0, =
session[0]->header.env.nr_cpus_avail,
> +    &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, =
true);
>=20
> out_delete_ses1:
> free_schedstat(&cpu_head_ses1);
> @@ -4720,7 +4783,7 @@ static int perf_sched__schedstat_live(struct =
perf_sched *sched,
> goto out;
> }
>=20
> - show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> + show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
> free_cpu_domain_info(cd_map, sv, nr);
> out:
> free_schedstat(&cpu_head);
> --=20
> 2.54.0.545.g6539524ca2-goog
>=20

