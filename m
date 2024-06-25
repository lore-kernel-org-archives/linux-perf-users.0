Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C811156646;
	Tue, 25 Jun 2024 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319514; cv=none; b=l37G3XiWenbEJMC+4OvLlecUJjPfYDtCNQRaGqcExOAwuE0aw9Y6LEihwwmp5VGUydXDDM7iDinJerY24JQOIOjVpDfONJzh5gzFrpwgKuBGirYEeKFGBhDUk69z5WofpWrdTVsH8R+PebRp/1Cul9cOQhwq3gcb5SCkLD8+mD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319514; c=relaxed/simple;
	bh=NIcz5W/n+MFJRX5s8toQ4gzV8mgK+nFbuwWKrKoF2ms=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GnyQ1iV6lMl4wfy0+KVRP5Vo0l4GGLTeS/ki8QGOP05Xjod7h/Q2kUoMiDpzOTZAH8HGn9m7iHpH22QsmF2e+w7rMbBFTL/Dmr/yf6JBZfnbeyo+t9sZtsNqOmhW6LX5YTqkcFrZnfBIqHDs/A2Vwrj9IqCPNiWSRYog4aFRy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E0HxDbNB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E0HxDbNB"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCQX7X001443;
	Tue, 25 Jun 2024 12:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=6
	/2vMiF4J1YzzRy8Gc4zvEvrOGJvN7cr0ikt7QqDWqg=; b=E0HxDbNBQclKVyzFg
	4UeETjkd22bv3+UEZ0CWHGl27fd/0x6e/SQieF5lAeprtawLiF7ME4tAYdlCwlNr
	DE1D+H+1kPElDYnaEl0K0N3JzakRNEJXbie2UocJ9cOshqlSFZbPbFiHapwHGs68
	MUw6oUhMbBuwOJsPaoKG9LuqxUo0N150bKI22Vm/+Jw+ztVmOPeuFSvmIliWzf26
	Vo5x+ZxoJJ6BX1jVy2WAi+tLJnYhTLaHZBTirxPmxfUfzXOXe/W0lIyeFuyFhXL6
	flJi82vS/5+2eMha4FCIchrkOBCwKwfDDXUpnj7lJUVbjvXPCJlfRBvu4D3LmxDK
	c9ibA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua4ge0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:45:02 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45PCj18E030092;
	Tue, 25 Jun 2024 12:45:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua4ge0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:45:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45PBZ6V9000564;
	Tue, 25 Jun 2024 12:45:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaemx98p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:45:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PCisBc21234154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 12:44:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB7820040;
	Tue, 25 Jun 2024 12:44:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1670D20043;
	Tue, 25 Jun 2024 12:44:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.30.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 12:44:51 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [V4 13/16] tools/perf: Add support to use libcapstone in powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Znpe2BHCUXvfR5Bk@google.com>
Date: Tue, 25 Jun 2024 18:14:40 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B0AD7C5-A4E8-41D1-B80A-80B84D48D8CE@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-14-atrajeev@linux.vnet.ibm.com>
 <Znpe2BHCUXvfR5Bk@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u-1JEkET-Kn4YiByrS7zFuF3vU2H7f54
X-Proofpoint-ORIG-GUID: 1QZcYEVsD8ndLG5V1pUN1LqPWSu_86Iy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250091



> On 25 Jun 2024, at 11:38=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Fri, Jun 14, 2024 at 10:56:28PM +0530, Athira Rajeev wrote:
>> Now perf uses the capstone library to disassemble the instructions in
>> x86. capstone is used (if available) for perf annotate to speed up.
>> Currently it only supports x86 architecture. Patch includes changes =
to
>> enable this in powerpc. For now, only for data type sort keys, this
>> method is used and only binary code (raw instruction) is read. This =
is
>> because powerpc approach to understand instructions and reg fields =
uses
>> raw instruction. The "cs_disasm" is currently not enabled. While
>> attempting to do cs_disasm, observation is that some of the =
instructions
>> were not identified (ex: extswsli, maddld) and it had to fallback to =
use
>> objdump. Hence enabling "cs_disasm" is added in comment section as a
>> TODO for powerpc.
>=20
> Well.. I'm not sure if I understand it correctly but it seems this
> function effectively does nothing more than the raw disassemble.
> Can we simply drop this patch for now?  Or did I miss something?
>=20
> Thanks,
> Namhyung

Hi Namhyung

Responded to this in previous patch ( for Patch number 3 )=20

Thanks
Athira

>=20
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/disasm.c | 143 =
+++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 143 insertions(+)
>>=20
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index 43743ca4bdc9..987bff9f71c3 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1592,6 +1592,144 @@ static void print_capstone_detail(cs_insn =
*insn, char *buf, size_t len,
>> }
>> }
>>=20
>> +static int symbol__disassemble_capstone_powerpc(char *filename, =
struct symbol *sym,
>> + struct annotate_args *args)
>> +{
>> + struct annotation *notes =3D symbol__annotation(sym);
>> + struct map *map =3D args->ms.map;
>> + struct dso *dso =3D map__dso(map);
>> + struct nscookie nsc;
>> + u64 start =3D map__rip_2objdump(map, sym->start);
>> + u64 end =3D map__rip_2objdump(map, sym->end);
>> + u64 len =3D end - start;
>> + u64 offset;
>> + int i, fd, count;
>> + bool is_64bit =3D false;
>> + bool needs_cs_close =3D false;
>> + u8 *buf =3D NULL;
>> + struct find_file_offset_data data =3D {
>> + .ip =3D start,
>> + };
>> + csh handle;
>> + char disasm_buf[512];
>> + struct disasm_line *dl;
>> + u32 *line;
>> + bool disassembler_style =3D false;
>> +
>> + if (args->options->objdump_path)
>> + return -1;
>> +
>> + nsinfo__mountns_enter(dso->nsinfo, &nsc);
>> + fd =3D open(filename, O_RDONLY);
>> + nsinfo__mountns_exit(&nsc);
>> + if (fd < 0)
>> + return -1;
>> +
>> + if (file__read_maps(fd, /*exe=3D*/true, find_file_offset, &data,
>> +    &is_64bit) =3D=3D 0)
>> + goto err;
>> +
>> + if (!args->options->disassembler_style ||
>> + !strcmp(args->options->disassembler_style, "att"))
>> + disassembler_style =3D true;
>> +
>> + if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, =
disassembler_style) < 0)
>> + goto err;
>> +
>> + needs_cs_close =3D true;
>> +
>> + buf =3D malloc(len);
>> + if (buf =3D=3D NULL)
>> + goto err;
>> +
>> + count =3D pread(fd, buf, len, data.offset);
>> + close(fd);
>> + fd =3D -1;
>> +
>> + if ((u64)count !=3D len)
>> + goto err;
>> +
>> + line =3D (u32 *)buf;
>> +
>> + /* add the function address and name */
>> + scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
>> +  start, sym->name);
>> +
>> + args->offset =3D -1;
>> + args->line =3D disasm_buf;
>> + args->line_nr =3D 0;
>> + args->fileloc =3D NULL;
>> + args->ms.sym =3D sym;
>> +
>> + dl =3D disasm_line__new(args);
>> + if (dl =3D=3D NULL)
>> + goto err;
>> +
>> + annotation_line__add(&dl->al, &notes->src->source);
>> +
>> + /*
>> + * TODO: enable disassm for powerpc
>> + * count =3D cs_disasm(handle, buf, len, start, len, &insn);
>> + *
>> + * For now, only binary code is saved in disassembled line
>> + * to be used in "type" and "typeoff" sort keys. Each raw code
>> + * is 32 bit instruction. So use "len/4" to get the number of
>> + * entries.
>> + */
>> + count =3D len/4;
>> +
>> + for (i =3D 0, offset =3D 0; i < count; i++) {
>> + args->offset =3D offset;
>> + sprintf(args->line, "%x", line[i]);
>> +
>> + dl =3D disasm_line__new(args);
>> + if (dl =3D=3D NULL)
>> + goto err;
>> +
>> + annotation_line__add(&dl->al, &notes->src->source);
>> +
>> + offset +=3D 4;
>> + }
>> +
>> + /* It failed in the middle */
>> + if (offset !=3D len) {
>> + struct list_head *list =3D &notes->src->source;
>> +
>> + /* Discard all lines and fallback to objdump */
>> + while (!list_empty(list)) {
>> + dl =3D list_first_entry(list, struct disasm_line, al.node);
>> +
>> + list_del_init(&dl->al.node);
>> + disasm_line__free(dl);
>> + }
>> + count =3D -1;
>> + }
>> +
>> +out:
>> + if (needs_cs_close)
>> + cs_close(&handle);
>> + free(buf);
>> + return count < 0 ? count : 0;
>> +
>> +err:
>> + if (fd >=3D 0)
>> + close(fd);
>> + if (needs_cs_close) {
>> + struct disasm_line *tmp;
>> +
>> + /*
>> + * It probably failed in the middle of the above loop.
>> + * Release any resources it might add.
>> + */
>> + list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
>> + list_del(&dl->al.node);
>> + free(dl);
>> + }
>> + }
>> + count =3D -1;
>> + goto out;
>> +}
>> +
>> static int symbol__disassemble_capstone(char *filename, struct symbol =
*sym,
>> struct annotate_args *args)
>> {
>> @@ -1949,6 +2087,11 @@ int symbol__disassemble(struct symbol *sym, =
struct annotate_args *args)
>> err =3D symbol__disassemble_dso(symfs_filename, sym, args);
>> if (err =3D=3D 0)
>> goto out_remove_tmp;
>> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
>> + err =3D symbol__disassemble_capstone_powerpc(symfs_filename, sym, =
args);
>> + if (err =3D=3D 0)
>> + goto out_remove_tmp;
>> +#endif
>> }
>> }
>>=20
>> --=20
>> 2.43.0
>>=20
>=20

