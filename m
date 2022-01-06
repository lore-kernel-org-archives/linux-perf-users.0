Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D2EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jan 2022 10:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbiAFKvc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:51:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49728 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238114AbiAFKvb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jan 2022 05:51:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206AhOTO020225;
        Thu, 6 Jan 2022 10:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=aKAfyTb/KQB9i1BnqWNPS+4Y46mzgECx9UV+CBHckW8=;
 b=dPAh2mETSBE65SoyDZNKKMN6Rj/JlDKSlT/k6lduDnGkWR2UEkHfzcnBKsFsjf1lMEE/
 m3kes62Z9IVjY//rkTV75LyD8vBus7b3DOtLoBdWq2x/a5T0FePKTiofJRx2XeM8XR/2
 6VyJFzsXcBjXV97aKtEGOMTTEmgL1yoDGZn2A9Dr+7EN846BvpgGZiwAcb0zBp4OeEoI
 BXYFXhUg6Mj9xOrMV9Pqf172eLPLnFWpjkPh3M35THVa32ZN1J8e+G8/dtooJRAnhFxR
 c6ZGIumnxZtSGcHXbQW3ZG7a14hgya5uTNQxNJjDSpM8LNS+9ZnQeIU8GJZWdH5n85Zb BQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddxx1r3qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 10:51:19 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206AnLSg007312;
        Thu, 6 Jan 2022 10:51:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ddmwgbxw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 10:51:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206ApDHf37028102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 10:51:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5CCC42047;
        Thu,  6 Jan 2022 10:51:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73BB94204D;
        Thu,  6 Jan 2022 10:51:09 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.81.174])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Jan 2022 10:51:09 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V2 1/2] tools/perf: Include global and local variants for
 p_stage_cyc sort key
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <afd3af8c-a450-79b2-e678-e07766c5efd1@linux.ibm.com>
Date:   Thu, 6 Jan 2022 16:21:05 +0530
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, kajoljain <kjain@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nageswara Sastry <rnsastry@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FCC0543-29A8-455D-B2BC-299B332F45D2@linux.vnet.ibm.com>
References: <20211203022038.48240-1-atrajeev@linux.vnet.ibm.com>
 <Ya91LXxp13Nz3JyC@kernel.org>
 <afd3af8c-a450-79b2-e678-e07766c5efd1@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F2jx06B834OONkS91UowDF_hRYryQmVT
X-Proofpoint-ORIG-GUID: F2jx06B834OONkS91UowDF_hRYryQmVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_03,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060074
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 08-Dec-2021, at 9:21 AM, Nageswara Sastry <rnsastry@linux.ibm.com> =
wrote:
>=20
>=20
>=20
> On 07/12/21 8:22 pm, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Dec 03, 2021 at 07:50:37AM +0530, Athira Rajeev escreveu:
>>> Sort key p_stage_cyc is used to present the latency
>>> cycles spend in pipeline stages. perf tool has local
>>> p_stage_cyc sort key to display this info. There is no
>>> global variant available for this sort key. local variant
>>> shows latency in a sinlge sample, whereas, global value
>>> will be useful to present the total latency (sum of
>>> latencies) in the hist entry. It represents latency
>>> number multiplied by the number of samples.
>>>=20
>>> Add global (p_stage_cyc) and local variant
>>> (local_p_stage_cyc) for this sort key. Use the
>>> local_p_stage_cyc as default option for "mem" sort mode.
>>> Also add this to list of dynamic sort keys and made the
>>> "dynamic_headers" and "arch_specific_sort_keys" as static.
>>>=20
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>> Reported-by: Namhyung Kim <namhyung@kernel.org>
>> I got this for v1, does it stand for v2?
>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
>=20
>=20
> Tested with v2 also.

Hi Arnaldo,

If this patchset looks fine to you, can you please consider pulling it.

Thanks
Athira
>=20
>=20
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
>=20
>>> ---
>>> Changelog:
>>> v1 -> v2:
>>>  Addressed review comments from Jiri by making the
>>>  "dynamic_headers" and "arch_specific_sort_keys"
>>>  as static.
>>>=20
>>>  tools/perf/util/hist.c |  4 +++-
>>>  tools/perf/util/hist.h |  3 ++-
>>>  tools/perf/util/sort.c | 34 +++++++++++++++++++++++++---------
>>>  tools/perf/util/sort.h |  3 ++-
>>>  4 files changed, 32 insertions(+), 12 deletions(-)
>>>=20
>>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>>> index b776465e04ef..0a8033b09e28 100644
>>> --- a/tools/perf/util/hist.c
>>> +++ b/tools/perf/util/hist.c
>>> @@ -211,7 +211,9 @@ void hists__calc_col_len(struct hists *hists, =
struct hist_entry *h)
>>>  	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
>>>  	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
>>>  	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
>>> -	hists__new_col_len(hists, HISTC_P_STAGE_CYC, 13);
>>> +	hists__new_col_len(hists, HISTC_LOCAL_P_STAGE_CYC, 13);
>>> +	hists__new_col_len(hists, HISTC_GLOBAL_P_STAGE_CYC, 13);
>>> +
>>>  	if (symbol_conf.nanosecs)
>>>  		hists__new_col_len(hists, HISTC_TIME, 16);
>>>  	else
>>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>>> index 621f35ae1efa..2a15e22fb89c 100644
>>> --- a/tools/perf/util/hist.h
>>> +++ b/tools/perf/util/hist.h
>>> @@ -75,7 +75,8 @@ enum hist_column {
>>>  	HISTC_MEM_BLOCKED,
>>>  	HISTC_LOCAL_INS_LAT,
>>>  	HISTC_GLOBAL_INS_LAT,
>>> -	HISTC_P_STAGE_CYC,
>>> +	HISTC_LOCAL_P_STAGE_CYC,
>>> +	HISTC_GLOBAL_P_STAGE_CYC,
>>>  	HISTC_NR_COLS, /* Last entry */
>>>  };
>>>  diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>>> index a111065b484e..e417e47f51b9 100644
>>> --- a/tools/perf/util/sort.c
>>> +++ b/tools/perf/util/sort.c
>>> @@ -37,7 +37,7 @@ const char	default_parent_pattern[] =3D =
"^sys_|^do_page_fault";
>>>  const char	*parent_pattern =3D default_parent_pattern;
>>>  const char	*default_sort_order =3D "comm,dso,symbol";
>>>  const char	default_branch_sort_order[] =3D =
"comm,dso_from,symbol_from,symbol_to,cycles";
>>> -const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,=
local_ins_lat,p_stage_cyc";
>>> +const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,=
local_ins_lat,local_p_stage_cyc";
>>>  const char	default_top_sort_order[] =3D "dso,symbol";
>>>  const char	default_diff_sort_order[] =3D "dso,symbol";
>>>  const char	default_tracepoint_sort_order[] =3D "trace";
>>> @@ -46,8 +46,8 @@ const char	*field_order;
>>>  regex_t		ignore_callees_regex;
>>>  int		have_ignore_callees =3D 0;
>>>  enum sort_mode	sort__mode =3D SORT_MODE__NORMAL;
>>> -const char	*dynamic_headers[] =3D {"local_ins_lat", "p_stage_cyc"};
>>> -const char	*arch_specific_sort_keys[] =3D {"p_stage_cyc"};
>>> +static const char *const dynamic_headers[] =3D {"local_ins_lat", =
"ins_lat", "local_p_stage_cyc", "p_stage_cyc"};
>>> +static const char *const arch_specific_sort_keys[] =3D =
{"local_p_stage_cyc", "p_stage_cyc"};
>>>    /*
>>>   * Replaces all occurrences of a char used with the:
>>> @@ -1392,22 +1392,37 @@ struct sort_entry sort_global_ins_lat =3D {
>>>  };
>>>    static int64_t
>>> -sort__global_p_stage_cyc_cmp(struct hist_entry *left, struct =
hist_entry *right)
>>> +sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry =
*right)
>>>  {
>>>  	return left->p_stage_cyc - right->p_stage_cyc;
>>>  }
>>>  +static int hist_entry__global_p_stage_cyc_snprintf(struct =
hist_entry *he, char *bf,
>>> +					size_t size, unsigned int width)
>>> +{
>>> +	return repsep_snprintf(bf, size, "%-*u", width,
>>> +			he->p_stage_cyc * he->stat.nr_events);
>>> +}
>>> +
>>> +
>>>  static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, =
char *bf,
>>>  					size_t size, unsigned int width)
>>>  {
>>>  	return repsep_snprintf(bf, size, "%-*u", width, =
he->p_stage_cyc);
>>>  }
>>>  -struct sort_entry sort_p_stage_cyc =3D {
>>> -	.se_header      =3D "Pipeline Stage Cycle",
>>> -	.se_cmp         =3D sort__global_p_stage_cyc_cmp,
>>> +struct sort_entry sort_local_p_stage_cyc =3D {
>>> +	.se_header      =3D "Local Pipeline Stage Cycle",
>>> +	.se_cmp         =3D sort__p_stage_cyc_cmp,
>>>  	.se_snprintf	=3D hist_entry__p_stage_cyc_snprintf,
>>> -	.se_width_idx	=3D HISTC_P_STAGE_CYC,
>>> +	.se_width_idx	=3D HISTC_LOCAL_P_STAGE_CYC,
>>> +};
>>> +
>>> +struct sort_entry sort_global_p_stage_cyc =3D {
>>> +	.se_header      =3D "Pipeline Stage Cycle",
>>> +	.se_cmp         =3D sort__p_stage_cyc_cmp,
>>> +	.se_snprintf    =3D hist_entry__global_p_stage_cyc_snprintf,
>>> +	.se_width_idx   =3D HISTC_GLOBAL_P_STAGE_CYC,
>>>  };
>>>    struct sort_entry sort_mem_daddr_sym =3D {
>>> @@ -1858,7 +1873,8 @@ static struct sort_dimension =
common_sort_dimensions[] =3D {
>>>  	DIM(SORT_CODE_PAGE_SIZE, "code_page_size", sort_code_page_size),
>>>  	DIM(SORT_LOCAL_INS_LAT, "local_ins_lat", sort_local_ins_lat),
>>>  	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
>>> -	DIM(SORT_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_p_stage_cyc),
>>> +	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", =
sort_local_p_stage_cyc),
>>> +	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", =
sort_global_p_stage_cyc),
>>>  };
>>>    #undef DIM
>>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>>> index 7b7145501933..f994261888e1 100644
>>> --- a/tools/perf/util/sort.h
>>> +++ b/tools/perf/util/sort.h
>>> @@ -235,7 +235,8 @@ enum sort_type {
>>>  	SORT_CODE_PAGE_SIZE,
>>>  	SORT_LOCAL_INS_LAT,
>>>  	SORT_GLOBAL_INS_LAT,
>>> -	SORT_PIPELINE_STAGE_CYC,
>>> +	SORT_LOCAL_PIPELINE_STAGE_CYC,
>>> +	SORT_GLOBAL_PIPELINE_STAGE_CYC,
>>>    	/* branch stack specific sort keys */
>>>  	__SORT_BRANCH_STACK,
>>> --=20
>>> 2.33.0
>=20
> --=20
> Thanks and Regards
> R.Nageswara Sastry

