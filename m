Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F217B42B;
	Fri, 26 Jul 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997382; cv=none; b=EYK3wsLSjLNeSiaPNALwdc/YnhnqaMVV5O0SCS1QZXZdkG72NKgNWj5HN2uqAWbPZSms3sZ1S22TqDKlHw8aVyVF62JtVbb9hqwFxP5AH7Wb6/UejU+AqxpAcryUiVK92HRJAJ3M4mzISQw4y6BPBdr4m6ku0MG7HA0XDIA+eI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997382; c=relaxed/simple;
	bh=YHT0gCAfe7vSoB5g4PhAhOs3dRIK//M1hizU8ixT0PE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y6c6y0JzXRv/8D2DiryaY+8OgapSTP+81AA2QP1BZ4H7XuaZTNVKbA47FjIXXjvZoTxNVFnXRo5SNTYsB06mp45xhKE+ueg6YcNFGQdb7ly+6sFuDiuHB68zr2y1X8vQVhpXjNY/NrnzS03Jb6yplRXDcas3Dmx9CEHy7n+/WoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M+4AT28Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M+4AT28Q"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QAwf9E003662;
	Fri, 26 Jul 2024 12:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=p
	15WzI2u8N7/dEzLbfaZtqnf1Jm6m/GZIe0Hnx2j+Bg=; b=M+4AT28QZllfWkRSQ
	vNfpmHkI3bZR/u0o3u8gslPFth+faNlI1SiQx5d/gA4aWnX4Bn6cNB8Ijj60c1dd
	9JNPnN0XHhUzkYhVNLsQADNYgmp052d6oTP/+jVtB64QZmj98nhBQ48p3bqK0NEz
	lAUjrY50pQtBkCOAXIQvBZ7Xd8LqUOw/ZCzFSuWdk2wLjNFHrfmSA51Kt5GpkcGD
	4tfcBfEBIpdQSlXqpjyfaMIqsWH2hKmH68UphCEB/jiWB9ArJ9jdX9L5aetcvzIf
	pLZPvMZvUrvPIkCZCW9PvMrLPHNnaQdPhde2wJKLG9+peJMkI49DlfWZF5w31lWS
	IHzcg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40magxg8q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:36:00 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QCa0QY017392;
	Fri, 26 Jul 2024 12:36:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40magxg8py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:36:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46QASov5009111;
	Fri, 26 Jul 2024 12:35:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93ux7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 12:35:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46QCZrIL50266600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 12:35:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F462004B;
	Fri, 26 Jul 2024 12:35:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 473A82004D;
	Fri, 26 Jul 2024 12:35:50 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.118.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Jul 2024 12:35:50 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH V8 14/15] tools/perf: Add support to use libcapstone in
 powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZqFrhCguUd_8n-xa@x1>
Date: Fri, 26 Jul 2024 18:05:37 +0530
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <918E5168-1EA0-4A5F-81BB-0A7321E18274@linux.vnet.ibm.com>
References: <20240718084358.72242-1-atrajeev@linux.vnet.ibm.com>
 <20240718084358.72242-15-atrajeev@linux.vnet.ibm.com> <ZqFrhCguUd_8n-xa@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 93Rpim7puSAwC3qCRGcYdcm668m3WC3E
X-Proofpoint-GUID: HwdUcEHrg5a0AYVImWFcnoEQ6mOI22di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407260083



> On 25 Jul 2024, at 2:30=E2=80=AFAM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Thu, Jul 18, 2024 at 02:13:57PM +0530, Athira Rajeev wrote:
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
>>=20
>> Reviewed-and-tested-by: Kajol Jain <kjain@linux.ibm.com>
>> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> Is this building on ppc?
>=20

Hi Arnaldo

Yes, I did compile with and without capstone devel support also.
But didn=E2=80=99t hit the compilation issue.=20

...                             libcapstone: [ OFF ]
  LINK    perf


...                             libcapstone: [ on  ]
  LINK    perf


> Here, when building on a x86-64 machine with:
>=20
> ake -C tools/perf EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D1 =
O=3D/tmp/build/perf-tools-next/
>=20
> That I got to by the usual:
>=20
> make -C tools/perf build-test
>=20
> I get:
>=20
> util/disasm.c: In function =E2=80=98symbol__disassemble_capstone_powerpc=
=E2=80=99:
> util/disasm.c:1618:34: error: =E2=80=98struct dso=E2=80=99 has no =
member named =E2=80=98nsinfo=E2=80=99
> 1618 |         nsinfo__mountns_enter(dso->nsinfo, &nsc);
>      |                                  ^~
> make[4]: *** =
[/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: =
/tmp/build/perf-tools-next/util/disasm.o] Error 1
> make[3]: *** =
[/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: util] =
Error 2
> make[2]: *** [Makefile.perf:762: =
/tmp/build/perf-tools-next/perf-util-in.o] Error 2
> make[1]: *** [Makefile.perf:265: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>=20
> And then when looking at this changeset I noticed that you added a
> function and then only called it if:
>=20
> static int symbol__disassemble_capstone(char *filename, struct symbol =
*sym,
>                                        struct annotate_args *args)
> {
> @@ -1945,6 +2083,11 @@ int symbol__disassemble(struct symbol *sym, =
struct annotate_args *args)
>                        err =3D symbol__disassemble_raw(symfs_filename, =
sym, args);
>                        if (err =3D=3D 0)
>                                goto out_remove_tmp;
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +                       err =3D =
symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
> +                       if (err =3D=3D 0)
> +                               goto out_remove_tmp;
> +#endif
>                }
>        }
>=20
> but the symbol__disassemble_capstone_powerpc() is being =
unconditionally
> built, i.e. it is not surrounded by '#ifdef HAVE_LIBCAPSTONE_SUPPORT'
>=20
> And then there:
>=20
> dso->nsinfo
>=20
> It should have been:
>=20
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 2a1c657d6aa66cc2..99081f37c5daba60 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1615,7 +1615,7 @@ static int =
symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
>        if (args->options->objdump_path)
>                return -1;
>=20
> -       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> +       nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>        fd =3D open(filename, O_RDONLY);
>        nsinfo__mountns_exit(&nsc);
>        if (fd < 0)
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>=20
> So it is critical that you try using:
>=20
> make -C tools/perf build-test
>=20
> Before asking for review.
>=20
> Please do that next time.

Ok Arnaldo, Sure, I will ensure to follow this every time

Thanks,
Athira
>=20
> I'm fixing this up this time so that we can make progress.
>=20
> Best regards,
>=20
> - Arnaldo
>=20
>=20
>> ---
>> tools/perf/util/disasm.c | 143 =
+++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 143 insertions(+)
>>=20
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index a848e6f5f05a..63681df6482b 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1585,6 +1585,144 @@ static void print_capstone_detail(cs_insn =
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
>> @@ -1942,6 +2080,11 @@ int symbol__disassemble(struct symbol *sym, =
struct annotate_args *args)
>> err =3D symbol__disassemble_raw(symfs_filename, sym, args);
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

