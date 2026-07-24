Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC63D0932;
	Fri, 24 Jul 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882549; cv=none; b=fHaIbbiHUq6/qKd5hifKvPbi+9rGibcgMv/h7agrRbruzM4mVIJ1zPbYKxAVkNwAml5APQ/nvD0fMHtHV/FSTZ4EbeAmdRrb+mHD94bbGnJPM8VCgfyFjc75yWJUzybB1mIgNemj8rwv4vXz1JxWPZGO5IOeSBhYUIWYroipRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882549; c=relaxed/simple;
	bh=tmIcnL+hRPlOC1SCwtiq9N3h4IICMCzcQ+jcybtrTO0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m4qrylcm6p87LRvc9pvV9tLf1Cqki1GPSG7Cr7qTbmzcLYZ0gn4MnrhrzkHuAvvk013dmICJBVSyskheSAQaJ1adhywVxqLmCmEO35oZGdQBZ0ojOOodyIUbxBBq13onLGLzL/HK2Ew4Cv9oZLkpc7BfFsJSnS8pfH2EcTz2Rpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P9Gc/qan; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P9Gc/qan"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5C6Nw904751;
	Fri, 24 Jul 2026 08:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tmIcnL
	+hRPlOC1SCwtiq9N3h4IICMCzcQ+jcybtrTO0=; b=P9Gc/qanKg8X7mC9GbaTTd
	cL2GWqazs/cL+Hc//8mL9QLEfa7zFySTdVnuFs4QjJPvJY069EZv0oV4hfG4TeEZ
	sZt4HM1QdW6rEuE1SPsnuGAwda1YRj9P2D500uN5D2hglWTIM1qhPdiYzxY+ZDxv
	EcLIafDstD7BoEmbFz8Kem2dhJT+kAIkCkQTZwNwebgBJzyyBsgc8hpXOmbCqrj/
	I1gEf8rheJ53+wZ6NldGM6ZqM0bwznzXZhinCsE1kRCLzgr7emITOAq+xC4u+IHl
	u+uzUUTRRF+w+lVvz9Nov9B1qpd68SG84T4eeqd9nbDyqx2VNECOgrq38xZo1Z1Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abuvdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:42:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8YZlp016586;
	Fri, 24 Jul 2026 08:42:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqgagr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:42:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8gORP46465374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:42:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E98E32009D;
	Fri, 24 Jul 2026 08:42:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52D832009F;
	Fri, 24 Jul 2026 08:42:23 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:42:23 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init
 into a separate file
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111554.990641F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 14:12:11 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FCD0CEA-4180-4459-A290-92505185279E@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-2-atrajeev@linux.ibm.com>
 <20260720111554.990641F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX1TzkgKxobDZ9
 JBSC8qQN0o9Zg91nm2X/ANrogMTuHxnlA0KdQzDXHLG5v2dokW96IuyBpLWc7P0FrYdCoyOq1Ar
 Yx6qHld2lnueah42C2EDZeP7N0mNBRakG2DHtE1If2/kxar34q3I1VndfeM87QFtK8LCzqypAq/
 Y+gur44Df4tJrVKS1ZgqpF1gjv0hD9Ng3pK9Us+azJ6fRQYcpGSb8MEHZJxvgQNLPOyhP6WmgSr
 PS5PP9Jz1XAsvIYiLZ5GdKkTxJuaYPYwM4SNWPR0I8IBBb9hOfiSmxC7aRTQr3ZRU8nbmfZE0ai
 wkMLZwFBcQHuiRRhFPYCaHuPKq2nFXsFJ8hjweOueCkto1ZKCIU8VD24sFexFB2pTHvWLG2nkMF
 l2uC8r6VfmGHSXObMVIpKATnJ2bp5nD2FJusKL3OVhmAjXTACLPUjFO7sjq/KzMgq1TPvmNMeUd
 gspzultbn4S1Pie5SYg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a632572 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Wg5sC3xKm85lGnTnmkcA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: wE7YNyoi4JKq4kRCwS4j0ngLm01cNN4g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX6+FhXTvnJmue
 f2T2GeGwhw1/p7OBzJouBXg/1eeLbKFaaJnZ/GBp+eyqq4SYvh0JXq6QUw3pucwkfcT3Q9Qnsfs
 hqri3/N+wOYynuPesvhPeLUNQpEK41k=
X-Proofpoint-GUID: wE7YNyoi4JKq4kRCwS4j0ngLm01cNN4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240078



> On 20 Jul 2026, at 4:45=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [Medium] The newly added file `vpa-dtl.c` uses `zalloc()` but fails =
to include `<linux/zalloc.h>`. On 64-bit platforms like PowerPC, this =
implicit declaration causes the compiler to assume `zalloc` returns =
`int`, leading to the truncation of the upper 32 bits of the returned =
64-bit pointer.
> --
>=20
> --- Patch [1]: [PATCH V2 1/6] tools/perf: Move powerpc VPA-DTL =
auxtrace init into a separate file ---
> commit 36d571f8cc56fc84bd8c942791167ff968206898
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
>=20
> This commit extracts the VPA-DTL auxtrace recording initializer into a =
new
> file, vpa-dtl.c. It reduces auxtrace.c to a thin dispatch layer to =
prepare
> for HTM recording.
>=20
>> diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c =
b/tools/perf/arch/powerpc/util/vpa-dtl.c
>> new file mode 100644
>> index 0000000000000..fde388d874775
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
>> @@ -0,0 +1,95 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * VPA DTL AUX tracing support
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/string.h>
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <limits.h>
>> +#include "../../util/cpumap.h"
>> +#include "../../util/evsel.h"
>> +#include "../../util/evlist.h"
>> +#include "../../util/session.h"
>> +#include "../../util/util.h"
>> +#include "../../util/debug.h"
>> +#include "../../util/auxtrace.h"
>> +#include "../../util/powerpc-vpadtl.h"
>> +#include "../../util/record.h"
>> +#include <internal/lib.h> // page_size
>=20
> [ ... ]
>=20
>> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, =
int *err)
>> +{
>> + struct auxtrace_record *aux;
>> +
>> + /*
>> + * To obtain the auxtrace buffer file descriptor, the auxtrace event
>> + * must come first.
>> + */
>> + evlist__to_front(pos->evlist, pos);
>> +
>> + aux =3D zalloc(sizeof(*aux));
>=20
> [Severity: Medium]
> Is the <linux/zalloc.h> include missing from the headers at the top of =
the
> file?
>=20
> Since zalloc is used here without a declaration, the compiler will =
treat it
> as implicitly declared and returning an int. On 64-bit platforms like =
PowerPC,
> this truncates the upper 32 bits of the returned pointer, which could =
result
> in a segmentation fault at runtime.
>=20

Sure, will be fixed in V3

Thanks
Athira

>> + if (aux =3D=3D NULL) {
>> + pr_debug("aux record allocation failed (-ENOMEM)\n");
>> + *err =3D -ENOMEM;
>> + return NULL;
>> + }
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720105218.14277-1-atrajeev@linux.ibm.c=
om?part=3D1

