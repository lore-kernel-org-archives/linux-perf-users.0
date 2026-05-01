Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EA1FE471;
	Fri,  1 May 2026 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648597; cv=none; b=UB/S6QBQzKJxxNvG3EJSe/Za5Pw/8tFq41FU39ErySYYTgWqtuL1aZ6HE/O0n8H9GC7fYcWXdSOBwYzCsd6c7S1g/OajdpAE8o4yeF3xeXBcuajaPGtnPI+Qf2m2t6H5roT4j2MM0uIleV1VLUDichIRxJyogMN1AfmzEyxm+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648597; c=relaxed/simple;
	bh=xtWnVHt8Dc3tgrScc7+tknI22lkW21lXqZyIPH5bLkA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RvfFMZVs+siOUoaqdhTh87y6X+OeP1keZ7xqlCYMStecdxapi5J+BxK0ly5L/8dW+TwmsQvuXoJ+VpNDWE6ot3MTeSOyDaWvx/B5zNXyreGG5wGNhsewEnMvy+RS0GVFR6BLjKteEb6hgzSXe19yuZBKHdh2oH1WiDB6qqn3vXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EKErc5KE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EKErc5KE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6413U3hi3663208;
	Fri, 1 May 2026 15:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3gH/Xt
	lh03JVH9rG7W3dBHO39/vivBkCHrIpIths0nI=; b=EKErc5KEcRvkgI3dufMluz
	a5mEFgS7l5YwHTA7Lz51/FFFeVrbwtdKVvsBQdWMaMNIIughCA/CaBNW5mwyKsb0
	9L8zZpp/wtQLgmeg/KS0TIzqy1zsYbAdU0sjEwQ2/6x7uC/UwCNb69dwYp7bIrF2
	GUDwKCB8Jht4I1tIp5uqMGBpwhcYc82LZeva3J9VpAB8uwdSbMJrO8/ZUZAnOS+x
	rnyD+VCXK7Bp7PYSDSGMMLDZkG/dCXnjR6RB4lx27RaNk+Mo0xJQGWYMQJsIWxsx
	DHTmLR6s7wf+F5BYtMq7KEtQdugRhngT5oU2l++Ci9iBbY4G21Fao692/JM+PbJQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1k3bn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 15:16:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641F9BcP031547;
	Fri, 1 May 2026 15:16:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqr29a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 15:16:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641FGKYw49283554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 15:16:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2786A2004B;
	Fri,  1 May 2026 15:16:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D10720040;
	Fri,  1 May 2026 15:16:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.19.167])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  1 May 2026 15:16:16 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2] perf sched stats: Fix segmentation faults in diff mode
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260429173931.2700115-1-irogers@google.com>
Date: Fri, 1 May 2026 20:46:02 +0530
Cc: acme@kernel.org, james.clark@linaro.org, namhyung@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, venkat88@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <562086F5-BD1A-4310-81FD-D078F2CFA1D4@linux.ibm.com>
References: <20260428070811.1883202-1-irogers@google.com>
 <20260429173931.2700115-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE0NCBTYWx0ZWRfX8pSE7GOlGAwO
 V0gWM4Cx8RXHbNyTqTAlPOQMZ6fOxffP8kN+5hZRJkYN+XbVIpkUbyVxyqfCjCGsyc0h3UVuG+A
 ERR2ZQeivpowNh0qTob7Q3IAtOCuHacu1ZB2I81Hd3gPAAbT8c41A13ysDeEy9k4IB2hgcBWZL8
 UYzqorihiHPspB8S/wupKmJs+31UZclyQK+vWHbZoOSXFZi8ONMmd4dRL8IDYUzexMH2plke3iN
 eMX4AwMHE1Fyw7P3oemzv0hb6jNeAs+CNjyufudEW7r2HmynaaDCRTq0StZOw3gui7XcRFStOuD
 V1KFTof2v0/vwY+iwnV58kSv7IaLDfyK0t4d2P04zZw0cqSv7d9OfKOpfT5swuIAU4qn1tLa+zA
 dc+7B1ma6RXnuC4wawVLU7b8g3Xs0eP59AI3/1n5kJwNk8/0HFh0YbPameoZ5w66kfrLoaQTIg9
 iKzyopyUTKv6c0RXCnA==
X-Proofpoint-GUID: BIRymgkRAO1ulLSO6g1D15-idWV32N_U
X-Proofpoint-ORIG-GUID: e5ehz4rt6jyiHHpUOH0MUy6FLP3LwrRa
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f4c3c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=j4GVZYSJ8cVcvWpmox0A:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010144



> On 29 Apr 2026, at 11:09=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> Address several segmentation fault vectors in `perf sched stats diff`:
>=20
> 1. In `get_all_cpu_stats()`, added `assert(!list_empty(head))` to =
prevent
>   unsafe `list_first_entry()` calls on empty lists, fixed =
uninitialized
>   variable `ret`, and added `list_is_last` check when iterating =
domains to
>   prevent out-of-bounds reads during parallel list traversal.
>=20
> 2. In `show_schedstat_data()`, added NULL checks for `cd_map1` and =
`cd_map2`
>   to gracefully handle invalid or empty data files.
>=20
> 3. Added parallel iteration termination checks using `list_is_last()` =
in
>   `show_schedstat_data()` for both domain and CPU lists to safely =
terminate
>   at the end of each list when files contain a different number of =
CPUs
>   or domains.
>=20
> 4. Added CPU bounds checks (`cs1->cpu >=3D nr1` and `cs2->cpu >=3D =
nr2`) in
>   `show_schedstat_data()` to prevent out-of-bounds reads from =
`cd_map1` and
>   `cd_map2` when comparing files from machines with different CPU =
counts.
>=20
> 5. Added NULL checks for `cd_info1` and `cd_info2` to prevent crashes =
when
>   a CPU has data samples but no corresponding domain info in the =
header.
>=20
> 6. Added domain bounds checks (`ds1->domain >=3D cd_info1->nr_domains` =
and
>   `ds2->domain >=3D cd_info2->nr_domains`) to prevent out-of-bounds =
array
>   accesses in the domains array.
>=20
> 7. Added NULL checks for `dinfo1` and `dinfo2` in =
`show_schedstat_data()`
>   to prevent crashes when a domain has no corresponding domain info.
>=20
> 8. Zero-initialized the `perf_data` array in =
`perf_sched__schedstat_diff()`
>   to prevent stack garbage from causing `perf_data_file__fd()` to =
attempt
>   to use a NULL `fptr` when `use_stdio` happened to be non-zero.
>=20
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Reduce indentation and variable scopes. Hopefully address feedback
>    from James Clark.
>=20
> Previously this patch was part of a large perf script refactor:
> =
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

Tested-by: Athira Rajeev <atrajeev@linux.ibm.com =
<mailto:atrajeev@linux.ibm.com>>

Thanks
Athira
> ---
> tools/perf/builtin-sched.c | 144 +++++++++++++++++++++++++++----------
> 1 file changed, 106 insertions(+), 38 deletions(-)
>=20
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..e67241415255 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4170,40 +4170,40 @@ static void summarize_schedstat_domain(struct =
schedstat_domain *summary_domain,
>  */
> static int get_all_cpu_stats(struct list_head *head)
> {
> - struct schedstat_cpu *cptr =3D list_first_entry(head, struct =
schedstat_cpu, cpu_list);
> - struct schedstat_cpu *summary_head =3D NULL;
> - struct perf_record_schedstat_domain *ds;
> - struct perf_record_schedstat_cpu *cs;
> - struct schedstat_domain *dptr, *tdptr;
> + struct schedstat_cpu *cptr, *summary_head;
> + struct schedstat_domain *dptr;
> bool is_last =3D false;
> int cnt =3D 1;
> - int ret =3D 0;
>=20
> - if (cptr) {
> - summary_head =3D zalloc(sizeof(*summary_head));
> - if (!summary_head)
> - return -ENOMEM;
> + assert(!list_empty(head));
> + cptr =3D list_first_entry(head, struct schedstat_cpu, cpu_list);
>=20
> - summary_head->cpu_data =3D zalloc(sizeof(*cs));
> - memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
> + summary_head =3D zalloc(sizeof(*summary_head));
> + if (!summary_head)
> + return -ENOMEM;
>=20
> - INIT_LIST_HEAD(&summary_head->domain_head);
> + summary_head->cpu_data =3D zalloc(sizeof(*summary_head->cpu_data));
> + memcpy(summary_head->cpu_data, cptr->cpu_data, =
sizeof(*summary_head->cpu_data));
>=20
> - list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> - tdptr =3D zalloc(sizeof(*tdptr));
> - if (!tdptr)
> - return -ENOMEM;
> + INIT_LIST_HEAD(&summary_head->domain_head);
>=20
> - tdptr->domain_data =3D zalloc(sizeof(*ds));
> - if (!tdptr->domain_data)
> - return -ENOMEM;
> + list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> + struct schedstat_domain *tdptr =3D zalloc(sizeof(*tdptr));
>=20
> - memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
> - list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
> - }
> + if (!tdptr)
> + return -ENOMEM;
> +
> + tdptr->domain_data =3D zalloc(sizeof(*tdptr->domain_data));
> + if (!tdptr->domain_data)
> + return -ENOMEM;
> +
> + memcpy(tdptr->domain_data, dptr->domain_data, =
sizeof(*tdptr->domain_data));
> + list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
> }
>=20
> list_for_each_entry(cptr, head, cpu_list) {
> + struct schedstat_domain *tdptr;
> +
> if (list_is_first(&cptr->cpu_list, head))
> continue;
>=20
> @@ -4212,32 +4212,47 @@ static int get_all_cpu_stats(struct list_head =
*head)
>=20
> cnt++;
> summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
> + if (list_empty(&summary_head->domain_head))
> + continue;
> +
> tdptr =3D list_first_entry(&summary_head->domain_head, struct =
schedstat_domain,
> domain_list);
>=20
> list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> + if (list_is_last(&tdptr->domain_list, &summary_head->domain_head)) {
> + tdptr =3D NULL;
> + break;
> + }
> tdptr =3D list_next_entry(tdptr, domain_list);
> }
> }
>=20
> list_add(&summary_head->cpu_list, head);
> - return ret;
> + return 0;
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
> struct perf_record_schedstat_domain *ds1 =3D NULL, *ds2 =3D NULL;
> - struct perf_record_schedstat_cpu *cs1 =3D NULL, *cs2 =3D NULL;
> struct schedstat_domain *dptr1 =3D NULL, *dptr2 =3D NULL;
> struct schedstat_cpu *cptr2 =3D NULL;
> __u64 jiffies1 =3D 0, jiffies2 =3D 0;
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
> @@ -4267,14 +4282,36 @@ static int show_schedstat_data(struct =
list_head *head1, struct cpu_domain_map **
>=20
> list_for_each_entry(cptr1, head1, cpu_list) {
> struct cpu_domain_map *cd_info1 =3D NULL, *cd_info2 =3D NULL;
> + struct perf_record_schedstat_cpu *cs1 =3D cptr1->cpu_data;
> + struct perf_record_schedstat_cpu *cs2 =3D NULL;
>=20
> - cs1 =3D cptr1->cpu_data;
> + dptr2 =3D NULL;
> + if (cs1->cpu >=3D (u32)nr1) {
> + pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
> + return -1;
> + }
> cd_info1 =3D cd_map1[cs1->cpu];
> + if (!cd_info1) {
> + pr_err("Error: CPU %d domain info is missing in map 1.\n",
> +       cs1->cpu);
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
> + pr_err("Error: CPU %d domain info is missing in map 2.\n",
> +       cs2->cpu);
> + return -1;
> + }
> + if (!list_empty(&cptr2->domain_head))
> + dptr2 =3D list_first_entry(&cptr2->domain_head,
> + struct schedstat_domain,
> + domain_list);
> }
>=20
> if (cs2 && cs1->cpu !=3D cs2->cpu) {
> @@ -4302,10 +4339,30 @@ static int show_schedstat_data(struct =
list_head *head1, struct cpu_domain_map **
> struct domain_info *dinfo1 =3D NULL, *dinfo2 =3D NULL;
>=20
> ds1 =3D dptr1->domain_data;
> + if (ds1->domain >=3D cd_info1->nr_domains) {
> + pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map =
1.\n",
> +       ds1->domain, cd_info1->nr_domains, cs1->cpu);
> + return -1;
> + }
> dinfo1 =3D cd_info1->domains[ds1->domain];
> + if (!dinfo1) {
> + pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n",
> +       ds1->domain, cs1->cpu);
> + return -1;
> + }
> if (dptr2) {
> ds2 =3D dptr2->domain_data;
> + if (ds2->domain >=3D cd_info2->nr_domains) {
> + pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map =
2.\n",
> +       ds2->domain, cd_info2->nr_domains, cs2->cpu);
> + return -1;
> + }
> dinfo2 =3D cd_info2->domains[ds2->domain];
> + if (!dinfo2) {
> + pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n",
> +       ds2->domain, cs2->cpu);
> + return -1;
> + }
> }
>=20
> if (dinfo2 && dinfo1->domain !=3D dinfo2->domain) {
> @@ -4334,14 +4391,22 @@ static int show_schedstat_data(struct =
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
> @@ -4523,7 +4588,9 @@ static int perf_sched__schedstat_report(struct =
perf_sched *sched)
> }
>=20
> cd_map =3D session->header.env.cpu_domain;
> - err =3D show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> + err =3D show_schedstat_data(&cpu_head, cd_map,
> +  session->header.env.nr_cpus_avail,
> +  NULL, NULL, 0, false);
> }
>=20
> out:
> @@ -4538,7 +4605,7 @@ static int perf_sched__schedstat_diff(struct =
perf_sched *sched,
> struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
> struct list_head cpu_head_ses0, cpu_head_ses1;
> struct perf_session *session[2];
> - struct perf_data data[2];
> + struct perf_data data[2] =3D {0};
> int ret =3D 0, err =3D 0;
> static const char *defaults[] =3D {
> "perf.data.old",
> @@ -4610,7 +4677,8 @@ static int perf_sched__schedstat_diff(struct =
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
> @@ -4720,7 +4788,7 @@ static int perf_sched__schedstat_live(struct =
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

