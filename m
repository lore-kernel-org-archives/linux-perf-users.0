Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33481A9F85;
	Sun, 26 Jul 2026 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047478; cv=none; b=VcTdy1MXQ59bJVxrGUk9R2tA5HEOLyA+K2RMK7a9kyEwikJTAvS392Nk1gYM5fujzuCfCUW4JuPqJKZxotPNWgGFxM2OC2bHV0iD/QQYuR2MmZLe7SKgPP+LuXVt+L3MlWAbVRDdWDgF6hT7SRfCyNyPJgJAEyNmt3WtBAgjPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047478; c=relaxed/simple;
	bh=Q2X9CVbPfBQVrZc5kSjc9LCszkvp+X2FyxRFTbpKmzQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mFpNziIMaRCNdlrV0IMAw4ARLB6K41wYKvMOWiZQ4dK5ZkS/jtfHMQBEDEQnISK2aRkAkap/nwPy8+7IIzu9GIWtD31zNFPX0MxNibwBC/he8iaF4UXxhdmnqf32lRnFSiSjvSKvT8fOQ9u2s8CtIF/NnedWXTQx1+L2O/KF2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DSeiGcM1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DSeiGcM1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5ltA82700409;
	Sun, 26 Jul 2026 06:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SLddse
	37STl3izopJEIds+yiud3qSM3jxGrQZ9FUCNs=; b=DSeiGcM1ehHjeimCoE3zlg
	j7DSRfAUYSV8UYMVp49VuzpUk/jh2QDz3ch6OAPsZLvIpt28/RKVL7Pq+D6Ouxs6
	yug7p3GJDLcjXePSNUlHhflSgcNgKXLooKw24NW7AWxa3BmmkPEH89mFYAInBACO
	0FcJBoLJ+LNSxvIFp/Ho40HTUULU4iN2Hk0xOKsYRvw+PZJi9jsTGTGYk2sjebgG
	r0x7JlQFhfliqsoqUTYNnLNZmfXwAqai+dnsd+kPp9WwdACrXyWuWwTIKwligzqk
	nAhvhCXHbKuPU/Q9GE8L2Ja+c17fgRbk+W57MecliSI35vXI3jLfpYXbHvdo9cnQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcjk83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 06:31:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q6QOBu011607;
	Sun, 26 Jul 2026 06:31:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh0mgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 06:31:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q6VCbT15729112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 06:31:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0D1E2014F;
	Sun, 26 Jul 2026 06:31:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 023A42014D;
	Sun, 26 Jul 2026 06:31:12 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.223.95])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Jul 2026 06:31:11 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V3 5/6] tools/perf: Add powerpc HTM auxtrace event
 processing support
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260725072144.E67CE1F000E9@smtp.kernel.org>
Date: Sun, 26 Jul 2026 12:00:59 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA35A5B4-3A86-4CB8-95CA-9D140F943044@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
 <20260725070747.81435-6-atrajeev@linux.ibm.com>
 <20260725072144.E67CE1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lOakcFlnVg-RPKAwRiaUwYwvQhGTUAZ2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1OSBTYWx0ZWRfX+RVGLXplHZ+v
 SUqong17vnMKDWEZKBx+AEW3Qaj6Cl9X+xNI1fiqIiuyMiKcTrvA9fiDFbi5xbJt/D+Z3hnloBU
 lSpGGFOoJxYQYmiylbs5hgX2m3B6Yvc=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a65a9b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=JjqluoYiYjL13acjXBUA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1OSBTYWx0ZWRfX1aVsmzxkl2Rn
 yYuPJViFrn3IOxqf7toJbtZfR4j/sJFUULB4i/iMC9WuorsoMNGKhghLqqTayDynkLT/sg+hqkO
 3m2mD4oLVqCmOMX5csediB2K93JL3grRv7sXPfHfINHhfGLCrZaAV/0RUPUP132goOqD6kcf5rh
 /zsjd/6BPWhSSlZXBQspoaV8Va5f+nVL/s2oXqLqWbi0ailahC7RofRTkwA5LSjAs1eSfIBRpAx
 GISdYz2+Wc/UwlC6kSe8kGJpTgYm4nR7gaWDO0m7ZXeaXVbwVG4LKPnHsj7HrMwICwu5prz1uTS
 TxSy25WqYjTOXzEEsz/ng26v9kfna1eaSucwAf4bPirLOpdqD95PLW4L1tmPl7eeOPWQhK86Ytn
 sai0+2SDGrSoUAx2XrbtACUaufmVadOaFtXolZRd2tBmyIyIxtDmPNIxLyCDvN1fc5HW25QqhuC
 jIhuXXIdm8ne5q/WpOw==
X-Proofpoint-GUID: lOakcFlnVg-RPKAwRiaUwYwvQhGTUAZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260059



> On 25 Jul 2026, at 12:51=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] The file `powerpc-htm.c` calls `zalloc()` but fails to =
include `<linux/zalloc.h>`, resulting in an implicit function =
declaration.
> - [Low] The file `powerpc-htm.c` embeds `struct auxtrace_queues` and =
calls its API but fails to directly include `"auxtrace.h"`, relying on =
brittle implicit inclusion.
> --
>=20
> --- Patch [5]: [PATCH V3 5/6] tools/perf: Add powerpc HTM auxtrace =
event processing support ---
> commit 306ea78646ef6e5fe95dbad9977aff1241d1027a
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add powerpc HTM auxtrace event processing support
>=20
> This commit adds the powerpc-htm.c decode stub for powerpc HTM =
auxtrace.
> It wires the dispatch in perf_event__process_auxtrace_info() to call
> powerpc_htm_process_auxtrace_info().
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/tools/perf/util/powerpc-htm.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <inttypes.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <endian.h>
>> +#include "util/evsel.h"
>> +#include "util/evlist.h"
>> +#include "util/session.h"
>> +#include "color.h"
>> +#include "powerpc-htm.h"
>> +#include "debug.h"
>> +#include "sample.h"
>> +
>> +struct powerpc_htm {
>> + struct auxtrace auxtrace;
>> + struct auxtrace_queues queues;
>=20
> [Severity: Low]
> Should this file explicitly include "auxtrace.h"?
>=20
> The code embeds struct auxtrace_queues here, and later calls
> auxtrace_queues__init(), both of which are defined in "auxtrace.h". =
Relying
> on implicit inclusion (for example, through "util/evlist.h") currently =
works
> but could break the build if intermediate headers are refactored in =
the
> future.
>=20
> [ ... ]
>=20
>> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
>> +      struct perf_session *session)
>> +{
>> + struct perf_record_auxtrace_info *auxtrace_info =3D =
&event->auxtrace_info;
>> + struct powerpc_htm *htm;
>> + int err;
>> +
>> + if (auxtrace_info->header.size < sizeof(struct =
perf_record_auxtrace_info) +
>> + HTM_AUXTRACE_PRIV_FIXED)
>> + return -EINVAL;
>> +
>> + htm =3D zalloc(sizeof(struct powerpc_htm));
>=20
> [Severity: High]
> Does this implicit function declaration cause a build failure or =
pointer
> truncation?
>=20
> The function zalloc() is used here, but <linux/zalloc.h> is not =
included in
> this file. Because the kernel build system uses -Werror, this missing =
header
> could trigger a build failure.
>=20
> If -Werror were disabled, the compiler would assume zalloc() returns a =
32-bit
> integer. On 64-bit architectures like PowerPC, this truncates the =
64-bit
> pointer. When extended back to 64 bits during assignment, the higher =
bits are
> lost, which could result in a segmentation fault upon dereference.
>=20
> Should <linux/zalloc.h> be included to ensure the return type is =
properly
> defined?

Sure, V4 will have changes to add zalloc.h and auxtrace.h

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260725070747.81435-1-atrajeev@linux.ibm.c=
om?part=3D5

