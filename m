Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2F30569D;
	Mon, 20 Jul 2026 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537321; cv=none; b=UZwrkN4BhQMX4Dtl/rmudv/msh2kDIPO/KBNWux3y0KceXbqH6II0uwADRy9sL9IYmejRMSpGrX7tqpsGSQ/WytEGwygF2krCKXqZragq/wzq3HPrWGlLPtIbwODyV5dlIXH0QWJN9nWpEHgsKzFY6QsBSq2uQTtcSXlxxrQ+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537321; c=relaxed/simple;
	bh=r060hofSI2fnEUDbidqATmuOeeBsbTloh98+pWnYtpA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uNxLDgblv+bvi58qJyhbn+4Fd5I86e5ZoFAU+qhnfx3wapx3Y3ydnUyt6sY2cFAO+KF3pbQ3ehEqdF0OjikfUm8x65U2neCRZolypCvd7qFDLPOfywdO/rHPEXLnc68cNj6/HXR+Zk2dmJAfxnSaBq3UnwvzoOVOJt6JiKoe2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=etI0Rt6F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="etI0Rt6F"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6gDRd1462520;
	Mon, 20 Jul 2026 08:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NSmaue
	0KF4Xwt0g007VbODh46GQvkgw0DzvmGHzq3AY=; b=etI0Rt6FyG0x7dgxOM4ism
	LDQ1lhHDBspV5SAcGhTdcbJLwvIZiwtjbs4XmYlMXp3WuEiz0cP7NbYJB4SIBNw9
	/FsPJjYQc7d5K/WiEUagE0PzU0v+tgTiUoG+MaRL4s67S6MZ/oHXomLry8mxeQst
	7C9MX3DxnwOQfCBn5LPxiEaeYi1oBpWUCLeMMugu+FevtN7bHNpNePELNYun8DoN
	GJt9S4cBd42rRrsN0j7Ey/780ZGQ3vaatYVIMv9qsah9zr6SVEFau40il8hB0f0q
	puD64BRz/c2LtgvTeKx76SGDCOjZsl4JDi8lxaN+IuA1PJr9WT/G6Mtv6YIaUPWQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab6k6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:48:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8YZxn029980;
	Mon, 20 Jul 2026 08:48:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpvyna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:48:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8maFM61473134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:48:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7086B2004D;
	Mon, 20 Jul 2026 08:48:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C962620040;
	Mon, 20 Jul 2026 08:48:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 08:48:35 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 2/9] tools/perf: Add CONFIG_AUXTRACE support for HTM pmu
 on powerpc
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701085549.4A3F01F00A3A@smtp.kernel.org>
Date: Mon, 20 Jul 2026 14:18:23 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A868B5FE-5068-478D-B1C0-4287BCAADD24@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-3-atrajeev@linux.ibm.com>
 <20260701085549.4A3F01F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX4Kg3NW/zpL61
 kjKS0wNxho7TLkqESQOosyBTMlMb/BTYbo/GiO6ernYlF4NLgYyu6BKjZvvz2ANgaD+3zK6RKVN
 VXM7s/2J7/5VHJtA2nscMoGsT+thyJ67EeZWIm46wtujPkoKRWZHUS85TgjHsvMOtkiLFSuR9tU
 AadP1pHrH1ZeULmPSbM0AJm9gbIVt9WnmHM3lozLxOVMHiXK4pcuFMJndDuX2GSGw+SMIFiHosj
 VLxFoLKtIvdLcPCJoP1l4KkkM47k1ocE4ky5OXmHVTrMGuUlLBj6v0pKsT/zNUce3L/1FiJ8tok
 Lr37TOOl5q2r1U9xvVWH1bcXt1YEmqogPh5GdXh8r5qf/h4pPNl8Rf1vieMo23/JJp4qMfhYj9U
 eD4FujicQ9MxJmvN1w+xGMlLpxJ2Kw7EJxMQs5/KnPZG/wVqWDsoCM/ek4b+Sopd0YF0KdndSXM
 R52tAm8siTeVcbkLdgw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5de0e7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=EUgGRY2LcNHpJoO2JnEA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: i6MhlqfWh3-8I9iNkoK_G4a_RlqYzHdT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX4Tp4o1MtiiRD
 AK41crmyygxa1ZTlSPkX5eoGO3O4p4ieG6Lm845T0l+UQ8ttUUITHg3kwledGRGTNTGr+ZkTIu9
 ptcdrW9NsGPVCGRhgFRzgS8FN3OFyrY=
X-Proofpoint-GUID: i6MhlqfWh3-8I9iNkoK_G4a_RlqYzHdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096



> On 1 Jul 2026, at 2:25=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
>=20
> New issues:
> - [Medium] Missing explicit inclusions of POSIX standard headers =
`<stdlib.h>` and `<limits.h>` for standard libc symbols.
> - [Medium] Memory allocation failure during HTM auxtrace =
initialization is silently dropped, causing a broken recording state.

>=20
> Pre-existing issues:
> - [High] Directly accessing `pos->name` with `strstarts()` causes a =
segmentation fault when the event name is NULL.

I will have these fixed in V2

Thanks
Athira
> --
>=20
> commit d4675d2351298802a38f0a4941c6bb4d86a4ed1f
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add CONFIG_AUXTRACE support for HTM pmu on powerpc
>=20
> The powerpc PMU collecting Hardware Trace Macro (HTM) entries makes =
use of
> AUX support in perf infrastructure. The PMU driver has the =
functionality
> to collect trace entries in the aux buffer. On the tools side, this =
data
> is made available as PERF_RECORD_AUXTRACE records. This record is
> generated by "perf record" command. To enable the creation of
> PERF_RECORD_AUXTRACE, add functions to initialize auxtrace records ie
> "htm_recording_init()". Fill in fields for other callbacks like
> info_priv_size, info_fill, free, recording options etc. Add header =
file
> to define htm pmu specific details.
>=20
>> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c =
b/tools/perf/arch/powerpc/util/auxtrace.c
>> index 0053526329e0e..ec84f8876a4ad 100644
>> --- a/tools/perf/arch/powerpc/util/auxtrace.c
>> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
>> @@ -31,13 +33,19 @@ struct auxtrace_record =
*auxtrace_record__init(struct evlist *evlist,
>> found_vpa_dtl =3D 1;
>> pos->needs_auxtrace_mmap =3D true;
>> break;
>> + } else if (strstarts(pos->name, "htm")) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does accessing =
pos->name
> directly cause a segmentation fault if the event name is NULL?
>=20
> If a standard hardware event is parsed without an explicit name (like
> "perf record -e cycles"), the name remains NULL until it is lazily =
generated
> via evsel__name(). Evaluating strncmp(NULL, "htm", 3) inside =
strstarts()
> would crash.
>=20
> Since this patch duplicates this pattern here and in =
htm_recording_options(),
> should we use evsel__name() or check for NULL first?
>=20
>> + found_htm =3D 1;
>> + pos->needs_auxtrace_mmap =3D true;
>> + break;
>> }
>> }
>>=20
>> if (found_vpa_dtl)
>> return vpa_dtl_recording_init(pos);
>> + else if (found_htm)
>> + return htm_recording_init(pos);
>=20
> [Severity: Medium]
> If htm_recording_init() fails to allocate memory, it returns NULL. =
Since we
> don't update the *err parameter before returning, does this propagate =
a false
> success to the caller?
>=20
> If *err remains 0, builtin-record.c might assume auxtrace is simply =
not
> required and continue recording, silently dropping the HTM trace data =
instead
> of aborting with -ENOMEM.
>=20
>> else {
>> - *err =3D -EINVAL;
>> + *err =3D 0;
>> return NULL;
>> }
>> }
>=20
>> diff --git a/tools/perf/arch/powerpc/util/htm.c =
b/tools/perf/arch/powerpc/util/htm.c
>> new file mode 100644
>> index 0000000000000..cc733f45ac9b0
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/htm.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HTM support
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/bitops.h>
>> +#include <linux/log2.h>
>> +#include <linux/string.h>
>> +#include <time.h>
>> +
>> +#include "../../util/cpumap.h"
>> +#include "../../util/evsel.h"
>> +#include "../../util/evlist.h"
>> +#include "../../util/session.h"
>> +#include "../../util/util.h"
>> +#include "../../util/pmu.h"
>> +#include "../../util/debug.h"
>> +#include "../../util/auxtrace.h"
>> +#include "../../util/powerpc-htm.h"
>> +#include "../../util/record.h"
>> +#include <internal/lib.h> // page_size
>> +#include <errno.h>
>=20
> [Severity: Medium]
> Are we missing the explicit inclusions of <stdlib.h> and <limits.h> =
here?
>=20
> This file uses UINT_MAX in htm_recording_options() and free() in =
htm_free().
> Without directly including <limits.h> and <stdlib.h>, building the =
perf tools
> with musl libc might fail due to missing declarations.
>=20
> [ ... ]
>=20
>> + /*
>> + * Set auxtrace_mmap_pages to minimum
>> + * two pages
>> + */
>> + if (!opts->auxtrace_mmap_pages) {
>> + opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
>> + if (opts->mmap_pages =3D=3D UINT_MAX)
>> + opts->mmap_pages =3D KiB(256) / page_size;
>> + }
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + if (strstarts(pos->name, "htm")) {
>=20
> [Severity: High]
> This is a pre-existing issue, but as mentioned above, this could crash =
if
> pos->name is NULL.
>=20
>> + pos->needs_auxtrace_mmap =3D true;
>> + pos->core.attr.aux_watermark =3D opts->auxtrace_mmap_pages * =
(size_t)page_size;
>> + break;
>> + }
>> + }
>> +
>> + return 0;
>> +}
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701084115.80383-1-atrajeev@linux.ibm.c=
om?part=3D2

