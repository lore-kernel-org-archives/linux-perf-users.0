Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787F2D949C;
	Sat, 21 Mar 2026 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774067284; cv=none; b=hE7ZRFX5vzB+GkU8mqb4YhDz2kwbgviwQSMRYXXcF5A8F0cfKmPaBaTAIRfjOvJNvdVoUufJKUEBiE1xSczPbKbcVrx5gqZhosSoaQOneMo02jiwT+tH3hcjbggRLHW9ip5x1PHVL195V/RKwHQBccvlWNFhgmXdzcQo7KYzA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774067284; c=relaxed/simple;
	bh=LUTP6i9BS2uG8f8XkWUgCWZjm99yMzv9dreqbvdzfD8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZsR2vNWxxDBM4VyD/Suns4pobZKP4+sKJq+Jy6FUQIu2rtG1wQIQpZ4XbbH/y4KYpgY8Qg2q8SRX4I2DSCk9gN5xZI4aDGwF0t253rF3CvltbdWFP9wRGnTFduwQvaZM4hJ995hPtQsKds4m8humPdCdXF6uzcUIHBfQRS8S/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lrY/s+gx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lrY/s+gx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L41cZv252494;
	Sat, 21 Mar 2026 04:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RLTPyf
	iS6yyX506bZeA2+7Mr282q+2kd8C+dvGSxXZg=; b=lrY/s+gxHRimj58UdeLl+b
	VPj+pAEh3CsOEu4tY53KEQCP322vz4gZmivuEsr91UGFTUY2QP69vLbT+AyEvep/
	gDOnu9kpgET/f+6b1XjD/QcYu6FUbjfiLtiLDXmKxzbJN2cokTXh3IcA6eTe6VG9
	Bqhfy80515Qdts3F5dOQVnmy8ual9xep5b0KwAO+K3Jxsg0/qtTXWj7i0AF9A314
	v/c6wy7lSXA90Q2lFQj4343NGOqtT924BRMSCEHcAt5PUYUY/qD5NPACla/3bX+u
	Lf4YCvc39hljjW90F2r6hurgWTGwNacMTByZDgObywLZsDPEcZF/HMXvWfDQRz9w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq01je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 04:27:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62L44KIv012197;
	Sat, 21 Mar 2026 04:27:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0stjku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 04:27:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62L4Rfsh61800932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 04:27:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 593A020043;
	Sat, 21 Mar 2026 04:27:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1CD720040;
	Sat, 21 Mar 2026 04:27:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.219.203])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 21 Mar 2026 04:27:39 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v1] perf disasm: Fix potential use-after-free on fileloc
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260306191614.2064618-1-irogers@google.com>
Date: Sat, 21 Mar 2026 09:57:27 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3974DCAD-373F-4C30-8535-0FBF017B87D5@linux.ibm.com>
References: <20260306191614.2064618-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4honImEKex0Nbjt7ViPOMJD83OUOj-I2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDAzMiBTYWx0ZWRfX6sQblNlrgPYe
 uyxIpLFVqoI2P/oogbBwGi2Pfxdykbbt3NM9nmJWDHS7vJcUS5zr4DQ+rbG0I/b7UCzcOw5GI8Z
 E041RkHv243DQVVJ57sgtGK6oywong1jqNN9IKuFEiCOPItla734kWrT6gfBEO4hJF40g8vHTlf
 77DHi1aCgU7T3UwmKY3F3UnixE15OoFpv1I5+/OMYCYQhyQfkSBVcwka3UxpgCBDYBFTeGEC5Y8
 jhkRf1JH+hzGKqzwbJNnIRn2tWOv6l0xUDm5G3GF/VjnAHEQJ5vlxiMAoBr76uV7d76QUFoOA0m
 FB6yXf/rhcMLDGQ0DPiYHkN8VHWZmmOY1xwNc2vLBFfhrGXje1CBM6SAjaSmzOzgipA9HnaImZI
 HfUMdBsVRl2KVOZTvoDBW1EhWhQQYP2WUTkEgi1GRteiSxEfJ8SBreeBMK0jIoss93AgyE2Am0Y
 jCcTeYSI6mTGhaMdIyQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69be1e40 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=YBUY0weVTRBsY7Zb4J4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wBVT0l7pg1_mb17CrjcmpxkQk7EGKnZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210032



> On 7 Mar 2026, at 12:46=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> The fileloc is a copy of a pointer to a string but in places like
> symbol_disassemble__llvm this string appears to be freed setting up
> potential use-after-frees:
>=20
> llvm.c:
> ```
> dl =3D disasm_line__new(args);
> if (dl =3D=3D NULL)
> goto err;
>=20
> annotation_line__add(&dl->al, &notes->src->source);
>=20
> free(args->fileloc);
> ```
> disasm.c:
> ```
> static void annotation_line__init(struct annotation_line *al,
>  struct annotate_args *args,
>  int nr)
> {
> al->offset =3D args->offset;
> al->line =3D strdup(args->line);
> al->line_nr =3D args->line_nr;
> al->fileloc =3D args->fileloc;
> al->data_nr =3D nr;
> }
>=20
> struct disasm_line *disasm_line__new(struct annotate_args *args)
> {
> struct disasm_line *dl =3D NULL;
> struct annotation *notes =3D symbol__annotation(args->ms->sym);
> int nr =3D notes->src->nr_events;
>=20
> dl =3D zalloc(disasm_line_size(nr));
> if (!dl)
> return NULL;
>=20
> annotation_line__init(&dl->al, args, nr);
> ```
>=20
> Fix this by making the fileloc a copy of the underlying string in its
> init/exit.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> tools/perf/util/disasm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index ddcc488f2e5f..b83bc14f82e1 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -908,13 +908,14 @@ static void annotation_line__init(struct =
annotation_line *al,
> al->offset =3D args->offset;
> al->line =3D strdup(args->line);
> al->line_nr =3D args->line_nr;
> - al->fileloc =3D args->fileloc;
> + al->fileloc =3D args->fileloc ? strdup(args->fileloc) : NULL;
> al->data_nr =3D nr;
> }
>=20
> static void annotation_line__exit(struct annotation_line *al)
> {
> zfree_srcline(&al->path);
> + zfree(&al->fileloc);
Looks good to me.

Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com =
<mailto:atrajeev@linux.ibm.com>>

Thanks
Athira

> zfree(&al->line);
> zfree(&al->cycles);
> zfree(&al->br_cntr);
> --=20
> 2.53.0.473.g4a7958ca14-goog
>=20

