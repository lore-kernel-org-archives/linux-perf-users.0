Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E6154C19;
	Tue, 25 Jun 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319540; cv=none; b=reKCV0TZC29dvLMBfVUS5x5zk7VcI6yNcaV/1JD5z3rW5rMQP28BKd3+J2aIVN49Gu5b4KLfZJkvYQnzfYjonpzdWs+lbV8hddOrWaX8CxwZpJjmCg6cPrAbWc3UvcX78N/L9cgC4GFr4vc/uvIqNCALS8gK69dBDN00fVCk/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319540; c=relaxed/simple;
	bh=4ZWttj0aUmZyY3bzyHNRZNBQwOPpnVBkrTLe7LB817U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VUg5QRRf3c8DinvxPODgjTivhvAtwg3RGlMXSCfQVMbm4LEJcnJenMKxLBNuNLan4zN7mmDQsF6CCwXY0I5lxbh7/lDP51vgHvKTXJkhSinyrAEqh2igBwYmGS2pkTUns+sdzGkpEEy6vrgaP1Ju3rOiyaRgFydgiP936iycRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=msBpKMZf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="msBpKMZf"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCShFr018850;
	Tue, 25 Jun 2024 12:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=y
	JBXOnVNKSt/1Y7byd2t+4YUwrBpTFGNSuACL++Te1s=; b=msBpKMZfL/MXpVLF7
	EDckWd+HkF3bGSwLSM0cCB9DCus5FYmLtlC6KEB0UkYTQJpspmaXDFqJ+AG2808c
	N+v8SRgmsiXV4s9kNbLeqj1kgWqO+N6jxi39RihBU5N+obniB1rvOki5fRZPpJLM
	tv0hoE9j3L49FdYYUuHU1/OowAdeFmR8P9i15YpYx+mFb78CP/PNm0NbZbmSmm2E
	prrroyUUfM0LMdQxVF/teLTmifwVpb/KQgeZnM+PMUolOLodly0yveu17NQg7My8
	EBR4PNgHa4Yd7Yps+bfLGWVOajW0l8S6R1LvFTkdsyUZ19/WU/8EJw855Fqc+04v
	qHG5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yywx5g14h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:45:26 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45PCjPlU013140;
	Tue, 25 Jun 2024 12:45:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yywx5g14e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:45:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45PAhDBd018156;
	Tue, 25 Jun 2024 12:45:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xu6kjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:45:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PCjJwp50135392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 12:45:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36DF32004B;
	Tue, 25 Jun 2024 12:45:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD1A20040;
	Tue, 25 Jun 2024 12:45:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.30.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 12:45:16 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [V4 14/16] tools/perf: Add support to find global register
 variables using find_data_type_global_reg
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Znpg3Op3X73xIqYD@google.com>
Date: Tue, 25 Jun 2024 18:15:05 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E011370-F49C-4F4D-805D-3F1F6D09DD0A@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-15-atrajeev@linux.vnet.ibm.com>
 <Znpg3Op3X73xIqYD@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BhTbfrahmaEEC11cmc5RHa-GBJgNuo5r
X-Proofpoint-ORIG-GUID: Kt9mrbxnKPCG6h282oVFGSCLneBnyKNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250091



> On 25 Jun 2024, at 11:47=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Fri, Jun 14, 2024 at 10:56:29PM +0530, Athira Rajeev wrote:
>> There are cases where define a global register variable and associate =
it
>> with a specified register. Example, in powerpc, two registers are
>> defined to represent variable:
>> 1. r13: represents local_paca
>> register struct paca_struct *local_paca asm("r13");
>>=20
>> 2. r1: represents stack_pointer
>> register void *__stack_pointer asm("r1");
>>=20
>> These regs are present in dwarf debug as DW_OP_reg as part of =
variables
>> in the cu_die (compile unit). These are not present in die search =
done
>> in the list of nested scopes since these are global register =
variables.
>>=20
>> Example for local_paca represented by r13:
>>=20
>> <<>>
>> <1><18dc6b4>: Abbrev Number: 128 (DW_TAG_variable)
>>    <18dc6b6>   DW_AT_name        : (indirect string, offset: 0x3861): =
local_paca
>>    <18dc6ba>   DW_AT_decl_file   : 48
>>    <18dc6bb>   DW_AT_decl_line   : 36
>>    <18dc6bc>   DW_AT_decl_column : 30
>>    <18dc6bd>   DW_AT_type        : <0x18dc6c3>
>>    <18dc6c1>   DW_AT_external    : 1
>>    <18dc6c1>   DW_AT_location    : 1 byte block: 5d    (DW_OP_reg13 =
(r13))
>>=20
>> <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
>>    <18dc6c4>   DW_AT_byte_size   : 8
>>    <18dc6c4>   DW_AT_type        : <0x18dc353>
>>=20
>> Where  DW_AT_type : <0x18dc6c3> further points to :
>>=20
>> <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
>>    <18dc6c4>   DW_AT_byte_size   : 8
>>    <18dc6c4>   DW_AT_type        : <0x18dc353>
>>=20
>> which belongs to:
>>=20
>> <1><18dc353>: Abbrev Number: 67 (DW_TAG_structure_type)
>>    <18dc354>   DW_AT_name        : (indirect string, offset: 0x56cd): =
paca_struct
>>    <18dc358>   DW_AT_byte_size   : 2944
>>    <18dc35a>   DW_AT_alignment   : 128
>>    <18dc35b>   DW_AT_decl_file   : 48
>>    <18dc35c>   DW_AT_decl_line   : 61
>>    <18dc35d>   DW_AT_decl_column : 8
>>    <18dc35d>   DW_AT_sibling     : <0x18dc6b4>
>> <<>>
>>=20
>> Similar is case with "r1".
>>=20
>> <<>>
>> <1><18dd772>: Abbrev Number: 129 (DW_TAG_variable)
>>    <18dd774>   DW_AT_name        : (indirect string, offset: 0x11ba): =
current_stack_pointer
>>    <18dd778>   DW_AT_decl_file   : 51
>>    <18dd779>   DW_AT_decl_line   : 1468
>>    <18dd77b>   DW_AT_decl_column : 24
>>    <18dd77c>   DW_AT_type        : <0x18da5cd>
>>    <18dd780>   DW_AT_external    : 1
>>    <18dd780>   DW_AT_location    : 1 byte block: 51    (DW_OP_reg1 =
(r1))
>>=20
>> where 18da5cd is:
>>=20
>> <1><18da5cd>: Abbrev Number: 47 (DW_TAG_base_type)
>>    <18da5ce>   DW_AT_byte_size   : 8
>>    <18da5cf>   DW_AT_encoding    : 7   (unsigned)
>>    <18da5d0>   DW_AT_name        : (indirect string, offset: 0x55c7): =
long unsigned int
>> <<>>
>>=20
>> To identify data type for these two special cases, iterate over
>> variables in the CU die (Compile Unit) and match it with the =
register.
>> If the variable is a base type, ie die_get_real_type will return NULL
>> here, set offset to zero. With the changes, data type for =
"paca_struct"
>> and "long unsigned int" for r1 is identified.
>>=20
>> Snippet from ./perf report -s type,type_off
>>=20
>>    12.85%  long unsigned int  long unsigned int +0 (no field)
>>     4.68%  struct paca_struct  struct paca_struct +2312 (__current)
>>     4.57%  struct paca_struct  struct paca_struct +2354 =
(irq_soft_mask)
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/annotate-data.c      | 40 =
++++++++++++++++++++++++++++
>> tools/perf/util/annotate.c           |  8 ++++++
>> tools/perf/util/annotate.h           |  1 +
>> tools/perf/util/include/dwarf-regs.h |  1 +
>> 4 files changed, 50 insertions(+)
>>=20
>> diff --git a/tools/perf/util/annotate-data.c =
b/tools/perf/util/annotate-data.c
>> index 734acdd8c4b7..82232f2d8e16 100644
>> --- a/tools/perf/util/annotate-data.c
>> +++ b/tools/perf/util/annotate-data.c
>> @@ -1170,6 +1170,40 @@ static int find_data_type_block(struct =
data_loc_info *dloc,
>> return ret;
>> }
>>=20
>> +/*
>> + * Handle cases where define a global register variable and
>> + * associate it with a specified register. These regs are
>> + * present in dwarf debug as DW_OP_reg as part of variables
>> + * in the cu_die (compile unit). Iterate over variables in the
>> + * cu_die and match with reg to identify data type die.
>=20
> Ok, if they always point to the same type, you may cache the result =
and
> avoid the repeated search everytime.
Ok
>=20
>> + */
>> +static int find_data_type_global_reg(struct data_loc_info *dloc, int =
reg, Dwarf_Die *cu_die,
>> + Dwarf_Die *type_die)
>> +{
>> + Dwarf_Die vr_die;
>> + int ret =3D -1;
>> + struct die_var_type *var_types =3D NULL;
>> +
>> + die_collect_vars(cu_die, &var_types);
>> + while (var_types) {
>> + if (var_types->reg =3D=3D reg) {
>> + if (dwarf_offdie(dloc->di->dbg, var_types->die_off, &vr_die)) {
>> + if (die_get_real_type(&vr_die, type_die) =3D=3D NULL) {
>> + dloc->type_offset =3D 0;
>> + dwarf_offdie(dloc->di->dbg, var_types->die_off, type_die);
>> + }
>> + pr_debug_type_name(type_die, TSR_KIND_TYPE);
>> + ret =3D 0;
>> + pr_debug_dtp("found by CU for %s (die:%#lx)\n",
>> + dwarf_diename(type_die), (long)dwarf_dieoffset(type_die));
>> + }
>> + break;
>> + }
>> + var_types =3D var_types->next;
>> + }
>=20
> Please add 'delete_var_types(var_types);' here.
>=20
> Thanks,
> Namhyung

Sure, will make these changes in V5

Thanks
Athira
>=20
>=20
>> + return ret;
>> +}
>> +
>> /* The result will be saved in @type_die */
>> static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die =
*type_die)
>> {
>> @@ -1217,6 +1251,12 @@ static int find_data_type_die(struct =
data_loc_info *dloc, Dwarf_Die *type_die)
>> pr_debug_dtp("CU for %s (die:%#lx)\n",
>>      dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
>>=20
>> + if (loc->reg_type =3D=3D DWARF_REG_GLOBAL) {
>> + ret =3D find_data_type_global_reg(dloc, reg, &cu_die, type_die);
>> + if (!ret)
>> + goto out;
>> + }
>> +
>> if (reg =3D=3D DWARF_REG_PC) {
>> if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
>> &offset, type_die)) {
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index bfa6420dc4b9..c7e4fd16e8b4 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2431,6 +2431,14 @@ struct annotated_data_type =
*hist_entry__get_data_type(struct hist_entry *he)
>> op_loc->reg1 =3D DWARF_REG_PC;
>> }
>>=20
>> + /* Global reg variable 13 and 1
>> +  * assign to DWARF_REG_GLOBAL
>> +  */
>> + if (arch__is(arch, "powerpc")) {
>> + if ((op_loc->reg1 =3D=3D 13) || (op_loc->reg1 =3D=3D 1))
>> + op_loc->reg_type =3D DWARF_REG_GLOBAL;
>> + }
>> +
>> mem_type =3D find_data_type(&dloc);
>>=20
>> if (mem_type =3D=3D NULL && is_stack_canary(arch, op_loc)) {
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index 9ba772f46270..ad69842a8ebc 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -475,6 +475,7 @@ struct annotated_op_loc {
>> bool mem_ref;
>> bool multi_regs;
>> bool imm;
>> + int reg_type;
>> };
>>=20
>> enum annotated_insn_ops {
>> diff --git a/tools/perf/util/include/dwarf-regs.h =
b/tools/perf/util/include/dwarf-regs.h
>> index 7ea39362ecaf..a873c906a86b 100644
>> --- a/tools/perf/util/include/dwarf-regs.h
>> +++ b/tools/perf/util/include/dwarf-regs.h
>> @@ -5,6 +5,7 @@
>>=20
>> #define DWARF_REG_PC  0xd3af9c /* random number */
>> #define DWARF_REG_FB  0xd3affb /* random number */
>> +#define DWARF_REG_GLOBAL 0xd3affc /* random number */
>>=20
>> #ifdef HAVE_DWARF_SUPPORT
>> const char *get_arch_regstr(unsigned int n);
>> --=20
>> 2.43.0


