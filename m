Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7311DB55C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386352; cv=none; b=j9RUrjQLDhjkLNO3C4GFMkS3aCXlAghaGKdYbtAvi+iifIwVFaPCyN0ei75HT3GW9ArzcYDsAvBPZdI3LMLCGwVSROJ8ykdMDKP4BcsQ+ZkIIecJ8IIjMiEc5qH9RQUM9tPVtBNBhE6vJLp5yLUDQI/+YahksJ6mG4sBnaUBgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386352; c=relaxed/simple;
	bh=nPUxNA18dRFKw1Hf39el/o3O7fObZnn+n2YDiXOi4Ko=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AbHgp8cWzzvvuliI04sXexxPLMN7kuNX5GIcO4ER02sIwwv+Q00isRbShrIEQq9IGUwJjSJvQTHHoqfd+5FHnyluPWQksek1hOC/cnl2KL1dYcC9eCserj53vpGxigX4x9bWuo90ooUIUdfXHMvJk5LQjz/KIXzSOkk+d6+Qlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3BVV1NR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3BVV1NR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2DZ3H020695;
	Mon, 24 Feb 2025 08:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KpF9cK
	csLSyASM9/BGkVWDKdXxHzxtKg3wQBIdnTkng=; b=E3BVV1NRJyRTxMLLgXxW5o
	5Re639XA9lEF3tiRBYlOPzd2yBW49uFDQr5gIRJvlRUMJ9fhaCBatTDFCsLjPXM+
	Pu6jUG7Ab2eiQmnZJnyMoJcwvjxm1KlGBS9CxLdCOyz7YcI0WY2anMhjT1nDuyk0
	8t5nCQiQS4lidhxzdKrEKmaaNqXC/EwUDZutlorts7oLBkHqdbt2VBejE0ZmWKl/
	mkazn3Pwx2vYy7FyOhf7+GJcPcrvGFD0FQp4XUijv4UyjVQ1oFjNDIp/2v2I27qs
	GeDqNBeo4VQhFUkVDyzckthldjvvZdxbI9noebx8/hD5ITEhaz41E3XYcaFDP/YQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta1vc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 08:38:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51O8TjKm031336;
	Mon, 24 Feb 2025 08:38:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta1vc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 08:38:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O73qH9012918;
	Mon, 24 Feb 2025 08:38:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsefbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 08:38:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51O8cpTK29491866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:38:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3EEC20040;
	Mon, 24 Feb 2025 08:38:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A0A92004D;
	Mon, 24 Feb 2025 08:38:45 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.246.12])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Feb 2025 08:38:44 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] tools/perf: Pick the correct dwarf die while adding probe
 point for a function
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <Z7ULfdJXKWG0u9uY@google.com>
Date: Mon, 24 Feb 2025 14:08:31 +0530
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB04064D-EF06-403A-8155-9D6B7318EE2B@linux.ibm.com>
References: <20250212131949.68706-1-atrajeev@linux.vnet.ibm.com>
 <Z7ULfdJXKWG0u9uY@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XGqawxnATVerqEZfqg8isy3StmrcYaLo
X-Proofpoint-ORIG-GUID: AhJJAekdKuPhonofBWwugz_aVm7NR-N3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240061



> On 19 Feb 2025, at 4:06=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Added Masami.
>=20
> On Wed, Feb 12, 2025 at 06:49:49PM +0530, Athira Rajeev wrote:
>> Perf probe on vfs_fstatat fails as below on a powerpc system
>>=20
>> ./perf probe -nf --max-probes=3D512 -a 'vfs_fstatat $params'
>> Segmentation fault (core dumped)
>>=20
>> This is observed while running perftool-testsuite_probe testcase.
>>=20
>> While running with verbose, its observed that segfault happens
>> at:
>>=20
>>   synthesize_probe_trace_arg ()
>>   synthesize_probe_trace_command ()
>>   probe_file.add_event ()
>>   apply_perf_probe_events ()
>>   __cmd_probe ()
>>   cmd_probe ()
>>   run_builtin ()
>>   handle_internal_command ()
>>   main ()
>>=20
>> Code in synthesize_probe_trace_arg() access a null value and results =
in
>> segfault. Data structure which is null:
>> struct probe_trace_arg arg->value
>>=20
>> We are hitting a case where arg->value is null in probe point:
>> "vfs_fstatat $params". This is happening since 'commit e896474fe485
>> ("getname_maybe_null() - the third variant of pathname copy-in")'
>> Before the commit, probe point for vfs_fstatat was getting added only
>> for one location:
>>=20
>> Writing event: p:probe/vfs_fstatat _text+6345404 dfd=3D%gpr3:s32 =
filename=3D%gpr4:x64 stat=3D%gpr5:x64 flags=3D%gpr6:s32
>>=20
>> With this change, vfs_fstatat code is inlined for other locations in =
the
>> code:
>> Probe point found: __do_sys_lstat64+48
>> Probe point found: __do_sys_stat64+48
>> Probe point found: __do_sys_newlstat+48
>> Probe point found: __do_sys_newstat+48
>> Probe point found: vfs_fstatat+0
>>=20
>> When trying to find matching dwarf information entry (DIE)
>> from the debuginfo, the code incorrectly picks DIE which is
>> not referring to vfs_fstatat. Snippet from dwarf entry in vmlinux
>> debuginfo file.
>>=20
>> The main abstract die is:
>> <1><4214883>: Abbrev Number: 147 (DW_TAG_subprogram)
>>    <4214885>   DW_AT_external    : 1
>>    <4214885>   DW_AT_name        : (indirect string, offset: =
0x17b9f3): vfs_fstatat
>>=20
>> With formal parameters:
>> <2><4214896>: Abbrev Number: 51 (DW_TAG_formal_parameter)
>>    <4214897>   DW_AT_name        : dfd
>> <2><42148a3>: Abbrev Number: 23 (DW_TAG_formal_parameter)
>>    <42148a4>   DW_AT_name        : (indirect string, offset: =
0x8fda9): filename
>> <2><42148b0>: Abbrev Number: 23 (DW_TAG_formal_parameter)
>>    <42148b1>   DW_AT_name        : (indirect string, offset: =
0x16bd9c): stat
>> <2><42148bd>: Abbrev Number: 23 (DW_TAG_formal_parameter)
>>    <42148be>   DW_AT_name        : (indirect string, offset: =
0x39832b): flags
>>=20
>> While collecting variables/parameters for a probe point, the function
>> copy_variables_cb() also looks at dwarf debug entries based on the
>> instruction address. Snippet
>>=20
>>        if (dwarf_haspc(die_mem, vf->pf->addr))
>>                return DIE_FIND_CB_CONTINUE;
>>        else
>>                return DIE_FIND_CB_SIBLING;
>>=20
>> But incase of inlined function instance for vfs_fstatat, there are =
two
>> entries which has the instruction address entry point as same.
>>=20
>> Instance 1: which is for vfs_fstatat and DW_AT_abstract_origin points =
to
>> 0x4214883 (reference above for main abstract die)
>>=20
>> <3><42131fa>: Abbrev Number: 59 (DW_TAG_inlined_subroutine)
>>    <42131fb>   DW_AT_abstract_origin: <0x4214883>
>>    <42131ff>   DW_AT_entry_pc    : 0xc00000000062b1e0
>>=20
>> Instance 2: which is not for vfs_fstatat but for getname
>>=20
>> <5><4213270>: Abbrev Number: 39 (DW_TAG_inlined_subroutine)
>>    <4213271>   DW_AT_abstract_origin: <0x4215b6b>
>>    <4213275>   DW_AT_entry_pc    : 0xc00000000062b1e0
>>=20
>> But the copy_variables_cb() continues to add parameters from second
>> instance also based on the dwarf_haspc() check. This results in
>> formal parameters for getname also appended to params. But while
>> filling in the args->value for these parameters, since these args
>> are not part of dwarf with offset "42131fa". Hence value will be
>> null. This incorrect args results in segfault when value field is
>> accessed.
>>=20
>> Save the Dwarf_Die which is the actual DW_TAG_subprogram as part of
>> "struct probe_finder". In copy_variables_cb(), include check to make
>> sure the DW_AT_abstract_origin points to the correct entry if the
>> dwarf_haspc() matches the instruction address.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/probe-finder.c | 21 ++++++++++++++++++---
>> tools/perf/util/probe-finder.h |  1 +
>> 2 files changed, 19 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tools/perf/util/probe-finder.c =
b/tools/perf/util/probe-finder.c
>> index 1e769b68da37..361086a7adae 100644
>> --- a/tools/perf/util/probe-finder.c
>> +++ b/tools/perf/util/probe-finder.c
>> @@ -973,6 +973,7 @@ static int probe_point_search_cb(Dwarf_Die =
*sp_die, void *data)
>> pr_debug("Matched function: %s [%lx]\n", dwarf_diename(sp_die),
>>  (unsigned long)dwarf_dieoffset(sp_die));
>> pf->fname =3D fname;
>> + memcpy(&pf->abstract_die, sp_die, sizeof(Dwarf_Die));
>=20
> Maybe just saving dieoffset is fine.
>=20
> Thanks,
> Namhyung
Thanks for checking the patch Namhyung.

Sure I will make that change in V2

Hi Masami,
Looking for your valuable comments on this fix patch, if the change =
looks good to you ?

Thanks
Athira
>=20
>=20
>> if (pp->line) { /* Function relative line */
>> dwarf_decl_line(sp_die, &pf->lno);
>> pf->lno +=3D pp->line;
>> @@ -1179,6 +1180,8 @@ static int copy_variables_cb(Dwarf_Die =
*die_mem, void *data)
>> struct local_vars_finder *vf =3D data;
>> struct probe_finder *pf =3D vf->pf;
>> int tag;
>> + Dwarf_Attribute attr;
>> + Dwarf_Die var_die;
>>=20
>> tag =3D dwarf_tag(die_mem);
>> if (tag =3D=3D DW_TAG_formal_parameter ||
>> @@ -1196,10 +1199,22 @@ static int copy_variables_cb(Dwarf_Die =
*die_mem, void *data)
>> }
>> }
>>=20
>> - if (dwarf_haspc(die_mem, vf->pf->addr))
>> + if (dwarf_haspc(die_mem, vf->pf->addr)) {
>> + /*
>> +  * when DW_AT_entry_pc contains instruction address,
>> +  * also check if the DW_AT_abstract_origin of die_mem
>> +  * points to correct die.
>> +  */
>> + if (dwarf_attr(die_mem, DW_AT_abstract_origin, &attr)) {
>> + dwarf_formref_die(&attr, &var_die);
>> + if (dwarf_dieoffset(&pf->abstract_die) !=3D =
dwarf_dieoffset(&var_die))
>> + goto out;
>> + }
>> return DIE_FIND_CB_CONTINUE;
>> - else
>> - return DIE_FIND_CB_SIBLING;
>> + }
>> +
>> +out:
>> + return DIE_FIND_CB_SIBLING;
>> }
>>=20
>> static int expand_probe_args(Dwarf_Die *sc_die, struct probe_finder =
*pf,
>> diff --git a/tools/perf/util/probe-finder.h =
b/tools/perf/util/probe-finder.h
>> index dcf6cc1e1cbe..b3039635c94e 100644
>> --- a/tools/perf/util/probe-finder.h
>> +++ b/tools/perf/util/probe-finder.h
>> @@ -63,6 +63,7 @@ struct probe_finder {
>> const char *fname; /* Real file name */
>> Dwarf_Die cu_die; /* Current CU */
>> Dwarf_Die sp_die;
>> + Dwarf_Die abstract_die;
>> struct intlist *lcache; /* Line cache for lazy match */
>>=20
>> /* For variable searching */
>> --=20
>> 2.43.5


