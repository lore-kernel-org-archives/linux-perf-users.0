Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Nov 2021 09:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbhK2JTg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Nov 2021 04:19:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231185AbhK2JRf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Nov 2021 04:17:35 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8MQGu034968;
        Mon, 29 Nov 2021 09:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=zfy7txCX8icJqgWirtGA8JlQac2z2PVMzuMJRFIcZxQ=;
 b=tAVrmr7XHrkoSoS48GkRy++YIziLnBjAqk6aTk7kv97biy0DtixXSBousmtX8ZmSw2/c
 qvJd84u96BLp7Une+KCme1K0EEN+8iZOPfEoKkyDsU/MSVs7XeD8J4aOh0NHCddFlk7z
 sFvQSN3cEWnRvygkZ5ABAi8yzyaGxOh9jb84fnJxL2Txu/kmfZresmZgU2iJqzA6q458
 JYz+4UFr9nguiRikHaQm4irkRpKMk7BuVIzCmkD0yC+kxO4QZRjabqyuIEiNJ9i0waJU
 BUa1gG4kMaWH3D//CTErK5XRWmIUgUP/wO8aHfzO3GhxERxUfCiu+8/CiRusqTvCBu8i zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmu9x16k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 09:14:04 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AT8QQUu004896;
        Mon, 29 Nov 2021 09:14:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmu9x16jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 09:14:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AT92pgc032408;
        Mon, 29 Nov 2021 09:14:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ckca9a0gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 09:14:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AT96XXM63701386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 09:06:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ECA0A405C;
        Mon, 29 Nov 2021 09:13:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E023A405F;
        Mon, 29 Nov 2021 09:13:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.92.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Nov 2021 09:13:52 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] tools/perf: Include global and local variants for
 p_stage_cyc sort key
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <YaOvsDAnuS+mXnrf@krava>
Date:   Mon, 29 Nov 2021 14:43:48 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F095C610-FAEC-4764-9046-4392B3C9F37A@linux.vnet.ibm.com>
References: <20211125024851.22895-1-atrajeev@linux.vnet.ibm.com>
 <YaOvsDAnuS+mXnrf@krava>
To:     Jiri Olsa <jolsa@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uUNSOyfBB0jTUYgMzy4njsGMA3002kY0
X-Proofpoint-GUID: ZbYASzno20qWDSFSlFS8VqsAUVhpQnsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_06,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 28-Nov-2021, at 10:04 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Nov 25, 2021 at 08:18:50AM +0530, Athira Rajeev wrote:
>> Sort key p_stage_cyc is used to present the latency
>> cycles spend in pipeline stages. perf tool has local
>> p_stage_cyc sort key to display this info. There is no
>> global variant available for this sort key. local variant
>> shows latency in a sinlge sample, whereas, global value
>> will be useful to present the total latency (sum of
>> latencies) in the hist entry. It represents latency
>> number multiplied by the number of samples.
>>=20
>> Add global (p_stage_cyc) and local variant
>> (local_p_stage_cyc) for this sort key. Use the
>> local_p_stage_cyc as default option for "mem" sort mode.
>> Also add this to list of dynamic sort keys.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Reported-by: Namhyung Kim <namhyung@kernel.org>
>=20
> I can't apply this to Arnaldo's perf/core, could you please rebase?
>=20
> patching file util/hist.c
> patching file util/hist.h
> patching file util/sort.c
> Hunk #3 FAILED at 1392.
> Hunk #4 succeeded at 1878 (offset 20 lines).
> 1 out of 4 hunks FAILED -- saving rejects to file util/sort.c.rej
> patching file util/sort.h
>=20
> thanks,
> jirka

Hi Jiri,

Thanks for checking this patch.=20

Actually these changes are on top of three other fixes from Namhyung =
which are already part of upstream. Below are the commits.

784e8adda4cd ("perf sort: Fix the 'weight' sort key behavior=E2=80=9D)
4d03c75363ee ("perf sort: Fix the 'ins_lat' sort key behavior=E2=80=9D)
db4b28402909 ("perf sort: Fix the 'p_stage_cyc' sort key behavior=E2=80=9D=
)

I checked in Arnaldo=E2=80=99s perf/core, but these commits are not =
there. But I could see them in 'tmp.perf/urgent'
I think perf/core is not yet updated.

Thanks
Athira Rajeev

>=20
>> ---
>> tools/perf/util/hist.c |  4 +++-
>> tools/perf/util/hist.h |  3 ++-
>> tools/perf/util/sort.c | 34 +++++++++++++++++++++++++---------
>> tools/perf/util/sort.h |  3 ++-
>> 4 files changed, 32 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index b776465e04ef..0a8033b09e28 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -211,7 +211,9 @@ void hists__calc_col_len(struct hists *hists, =
struct hist_entry *h)
>> 	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
>> 	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
>> 	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
>> -	hists__new_col_len(hists, HISTC_P_STAGE_CYC, 13);
>> +	hists__new_col_len(hists, HISTC_LOCAL_P_STAGE_CYC, 13);
>> +	hists__new_col_len(hists, HISTC_GLOBAL_P_STAGE_CYC, 13);
>> +
>> 	if (symbol_conf.nanosecs)
>> 		hists__new_col_len(hists, HISTC_TIME, 16);
>> 	else
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 5343b62476e6..2752ce681108 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -75,7 +75,8 @@ enum hist_column {
>> 	HISTC_MEM_BLOCKED,
>> 	HISTC_LOCAL_INS_LAT,
>> 	HISTC_GLOBAL_INS_LAT,
>> -	HISTC_P_STAGE_CYC,
>> +	HISTC_LOCAL_P_STAGE_CYC,
>> +	HISTC_GLOBAL_P_STAGE_CYC,
>> 	HISTC_NR_COLS, /* Last entry */
>> };
>>=20
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index e9216a292a04..e978f7883e07 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -37,7 +37,7 @@ const char	default_parent_pattern[] =3D =
"^sys_|^do_page_fault";
>> const char	*parent_pattern =3D default_parent_pattern;
>> const char	*default_sort_order =3D "comm,dso,symbol";
>> const char	default_branch_sort_order[] =3D =
"comm,dso_from,symbol_from,symbol_to,cycles";
>> -const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,=
local_ins_lat,p_stage_cyc";
>> +const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,=
local_ins_lat,local_p_stage_cyc";
>> const char	default_top_sort_order[] =3D "dso,symbol";
>> const char	default_diff_sort_order[] =3D "dso,symbol";
>> const char	default_tracepoint_sort_order[] =3D "trace";
>> @@ -46,8 +46,8 @@ const char	*field_order;
>> regex_t		ignore_callees_regex;
>> int		have_ignore_callees =3D 0;
>> enum sort_mode	sort__mode =3D SORT_MODE__NORMAL;
>> -const char	*dynamic_headers[] =3D {"local_ins_lat", "p_stage_cyc"};
>> -const char	*arch_specific_sort_keys[] =3D {"p_stage_cyc"};
>> +const char	*dynamic_headers[] =3D {"local_ins_lat", "ins_lat", =
"local_p_stage_cyc", "p_stage_cyc"};
>> +const char	*arch_specific_sort_keys[] =3D {"local_p_stage_cyc", =
"p_stage_cyc"};
>>=20
>> /*
>>  * Replaces all occurrences of a char used with the:
>> @@ -1392,22 +1392,37 @@ struct sort_entry sort_global_ins_lat =3D {
>> };
>>=20
>> static int64_t
>> -sort__global_p_stage_cyc_cmp(struct hist_entry *left, struct =
hist_entry *right)
>> +sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry =
*right)
>> {
>> 	return left->p_stage_cyc - right->p_stage_cyc;
>> }
>>=20
>> +static int hist_entry__global_p_stage_cyc_snprintf(struct hist_entry =
*he, char *bf,
>> +					size_t size, unsigned int width)
>> +{
>> +	return repsep_snprintf(bf, size, "%-*u", width,
>> +			he->p_stage_cyc * he->stat.nr_events);
>> +}
>> +
>> +
>> static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, =
char *bf,
>> 					size_t size, unsigned int width)
>> {
>> 	return repsep_snprintf(bf, size, "%-*u", width, =
he->p_stage_cyc);
>> }
>>=20
>> -struct sort_entry sort_p_stage_cyc =3D {
>> -	.se_header      =3D "Pipeline Stage Cycle",
>> -	.se_cmp         =3D sort__global_p_stage_cyc_cmp,
>> +struct sort_entry sort_local_p_stage_cyc =3D {
>> +	.se_header      =3D "Local Pipeline Stage Cycle",
>> +	.se_cmp         =3D sort__p_stage_cyc_cmp,
>> 	.se_snprintf	=3D hist_entry__p_stage_cyc_snprintf,
>> -	.se_width_idx	=3D HISTC_P_STAGE_CYC,
>> +	.se_width_idx	=3D HISTC_LOCAL_P_STAGE_CYC,
>> +};
>> +
>> +struct sort_entry sort_global_p_stage_cyc =3D {
>> +	.se_header      =3D "Pipeline Stage Cycle",
>> +	.se_cmp         =3D sort__p_stage_cyc_cmp,
>> +	.se_snprintf    =3D hist_entry__global_p_stage_cyc_snprintf,
>> +	.se_width_idx   =3D HISTC_GLOBAL_P_STAGE_CYC,
>> };
>>=20
>> struct sort_entry sort_mem_daddr_sym =3D {
>> @@ -1858,7 +1873,8 @@ static struct sort_dimension =
common_sort_dimensions[] =3D {
>> 	DIM(SORT_CODE_PAGE_SIZE, "code_page_size", sort_code_page_size),
>> 	DIM(SORT_LOCAL_INS_LAT, "local_ins_lat", sort_local_ins_lat),
>> 	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
>> -	DIM(SORT_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_p_stage_cyc),
>> +	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", =
sort_local_p_stage_cyc),
>> +	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", =
sort_global_p_stage_cyc),
>> };
>>=20
>> #undef DIM
>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>> index 3c7518378d62..83abe5e6812a 100644
>> --- a/tools/perf/util/sort.h
>> +++ b/tools/perf/util/sort.h
>> @@ -235,7 +235,8 @@ enum sort_type {
>> 	SORT_CODE_PAGE_SIZE,
>> 	SORT_LOCAL_INS_LAT,
>> 	SORT_GLOBAL_INS_LAT,
>> -	SORT_PIPELINE_STAGE_CYC,
>> +	SORT_LOCAL_PIPELINE_STAGE_CYC,
>> +	SORT_GLOBAL_PIPELINE_STAGE_CYC,
>>=20
>> 	/* branch stack specific sort keys */
>> 	__SORT_BRANCH_STACK,
>> --=20
>> 2.27.0

