Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523A1B21B0;
	Tue, 15 Oct 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000878; cv=none; b=KUw3+x+5/luB7P5p8HLDK9ycEKMs5nz1gtMv1SbRZdblQAMI5ZQMbdtRy5JqzMXWV7GuVR5hhpVgVJs6RwoGa3clksEd8iJ5n1TWV4SNhm3/fX3MDHHAD23GlZRCddyDGBPc7WOcgTmFFxnQRpbltGS2pPcKXQAkn9qPhdWWbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000878; c=relaxed/simple;
	bh=Z0r/dHXVc0QwsPI8hR1fwuilSJ5GLHg7hj5KGYDBVCs=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=C9yUbAe/wldffsWp1Kwx9wA5ReVtHqOI5bIOoyqFauvuMdel/kojPMRhPNvRiablAUnAn9mkKXvrvg7WbPO5vOSgeJbQjcbBW1YmIY8BaxhmrM3bwGGmkE4TnR7NptFp1biGmP9lDIGkB9Brd2xrrtA2oEsKAT+DMBSyPt92Gxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+pMv31Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+pMv31Z"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDJYLB007785;
	Tue, 15 Oct 2024 13:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mB1V9/
	hfZslMHKfRFaMtUHr1ZjB11GLtBtGZqeB7D+E=; b=J+pMv31ZDjpem9k8+S4yNz
	q5ZRSRSzroOVTYQvC3RhAHyEWMERTfUK5dwDxnnpld2HuvsFS404+EtUPdbHsdrH
	xU9Cp62iNUyPCnjOmW5MRW1TVHc+HxE/Lpvb7LueyLEIwMa5E9hGRbWZJ4jdqDeG
	FjC1w6U20MWYv0El6j9afVcEXtj/EaLty//DOcX+3hN3vh0oQQojr0XfihTLI/LG
	FJC9j00+KsJQXBUTXtzdjET6FZsMMGvK9lORpz5iHFN63+2wlHSNlxiTS1AG0oNn
	6m5hQg6JMtmP4O/lroYPsJsfUfnH6EHwrdvirQWiMZcm+mBiqEmI3bfjl98ZtzqA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429s68g6hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:55:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FDtq3g014593;
	Tue, 15 Oct 2024 13:55:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429s68g6ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:55:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCC8Vd005936;
	Tue, 15 Oct 2024 13:55:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650uth0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:55:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FDtoTw51511662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 13:55:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1E5B2004B;
	Tue, 15 Oct 2024 13:55:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F302C20043;
	Tue, 15 Oct 2024 13:55:43 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.243.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 13:55:43 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH 2/3] perf disasm: Use disasm_line__free() to properly free
 disasm_line
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241014114248.212711-2-lihuafei1@huawei.com>
Date: Tue, 15 Oct 2024 19:25:29 +0530
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        kjain@linux.ibm.com, sesse@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <90BD7422-B738-4A35-8D45-51212E17716C@linux.vnet.ibm.com>
References: <20241014114248.212711-1-lihuafei1@huawei.com>
 <20241014114248.212711-2-lihuafei1@huawei.com>
To: Li Huafei <lihuafei1@huawei.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qc84fsz6gJrz586ldqe9TYoXSK7dYkOX
X-Proofpoint-ORIG-GUID: 8Ryjo94gFxI5NyUXif-eZdDhmwsOP6Sl
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150094



> On 14 Oct 2024, at 5:12=E2=80=AFPM, Li Huafei <lihuafei1@huawei.com> wrot=
e:
>=20
> The structure disasm_line contains members that require dynamically
> allocated memory and need to be freed correctly using
> disasm_line__free().
>=20
> This patch fixes the incorrect freeing in
> symbol__disassemble_capstone_powerpc().  Also, since cs_disasm is not
> enabled, it does not need to handle the situation described in
> symbol__disassemble_capstone() where "offset !=3D len" may occur due to
> unknown instructions.
>=20
> Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in po=
werpc")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

For the patches

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linu=
x.vnet.ibm.com>>

Thanks
Athira
> ---
> tools/perf/util/disasm.c | 16 +---------------
> 1 file changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 42222d61ceb5..40d99f4d5cc7 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1580,20 +1580,6 @@ static int symbol__disassemble_capstone_powerpc(ch=
ar *filename, struct symbol *s
> offset +=3D 4;
> }
>=20
> - /* It failed in the middle */
> - if (offset !=3D len) {
> - struct list_head *list =3D &notes->src->source;
> -
> - /* Discard all lines and fallback to objdump */
> - while (!list_empty(list)) {
> - dl =3D list_first_entry(list, struct disasm_line, al.node);
> -
> - list_del_init(&dl->al.node);
> - disasm_line__free(dl);
> - }
> - count =3D -1;
> - }
> -
> out:
> if (needs_cs_close)
> cs_close(&handle);
> @@ -1612,7 +1598,7 @@ static int symbol__disassemble_capstone_powerpc(cha=
r *filename, struct symbol *s
> */
> list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
> list_del(&dl->al.node);
> - free(dl);
> + disasm_line__free(dl);
> }
> }
> count =3D -1;
> --=20
> 2.25.1
>=20

