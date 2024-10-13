Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5174433B0;
	Sun, 13 Oct 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802755; cv=none; b=Fm2CFR+CO318QwX0DcYokGsE9ZkVkVU0sVCpfieKDG1js5QQtjTeMS+tFqMz+sRGghYuIwcR/9ejIQ1GRfE7npf7hJgv/RbgW2rH8StDFWD9e45xnA5nplCiP6f+tmmPpoDWhW4w9sBFlGvckTfGFVent4+ZhJqg3DxPemWPBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802755; c=relaxed/simple;
	bh=UBQpIsCScdSEfvsW5uKRCtJgDVeA9RWJCiiczOXMxMY=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=ChMerbSzDgzXtVcY0T8QkI2Q29LRapWBYGhCnskV1AbjGvBQmZl5THfNIgZaX/KWpKgu+UrPfYthLrpiNIVAGecPCC4ivbgV1krD7x7bzC5zZLkvAG+dX9wlXucNWrQPkreOOPBh2d8eLDBXvJPzeyZIlowiJh1mq3M29SKZnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D+JXunNW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D+JXunNW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49D6oBjb020742;
	Sun, 13 Oct 2024 06:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=Hc5/yC0qfodQc6nwRh31StCFzKFQtvidnJ8OmobZNt0=; b=D+JXunNWaXjL
	vrKxCR1kToEgeGMRIRD7uGvCOy/GVub9vmSp9OwTMNiyxXpQL/oOwvCVSCJ4AW8K
	gur4Ixx8Efm9qYpRWmNP5n+ub96B/7C9GsUw8B/C7dUspIGVLe3eELFzlHDZqvxr
	JyKrr6WuQYpE+Dq1zhBEd1/Dm9YUhmQkB2xRX4I32g/YUm+2YDL52pmmcTWVtVT9
	AoTDEr5DAogiJ2x14qQUVi91RAEQhwISg1i0zL+Xu6Q066zrm7QyO6IRi6Cv5wg0
	dUmCDNSHeS3tvEKFTXkxDev7zYQbi2vAnxJsAe/qMihPpWSzHFaWMCcqTiWzU6Yi
	xbsVeg6j7Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42899kr0dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 06:58:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49D6wiJW002893;
	Sun, 13 Oct 2024 06:58:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42899kr0da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 06:58:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49D5eHpO006674;
	Sun, 13 Oct 2024 06:58:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283erh34g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 06:58:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49D6wgQ950004374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 06:58:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E6520043;
	Sun, 13 Oct 2024 06:58:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3491420040;
	Sun, 13 Oct 2024 06:58:33 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.243.56])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 13 Oct 2024 06:58:32 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <DB114AFD-C80A-4789-80EC-715F7B0CC6A1@linux.vnet.ibm.com>
Date: Sun, 13 Oct 2024 12:28:17 +0530
Cc: acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, howardchu95@gmail.com,
        irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
        kan.liang@linux.intel.com, leo.yan@linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tmricht@linux.ibm.com, vmolnaro@redhat.com, weilin.wang@intel.com,
        zegao2021@gmail.com, zhaimingbing@cmss.chinamobile.com
Message-Id: <8E57ABD1-96C8-4120-8EDB-4D4C09C1ADE2@linux.vnet.ibm.com>
References: <172857541969.1131797.2693392463657578240.b4-ty@kernel.org>
 <20241011064824.1432562-1-namhyung@kernel.org>
 <DB114AFD-C80A-4789-80EC-715F7B0CC6A1@linux.vnet.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1X8uocQsaThVqmsQ5oepzanxoDV-k8y8
X-Proofpoint-ORIG-GUID: Fl8a-YrS_QLyQ-l6Fg6rTjwkurEZXrz4
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
 definitions=2024-10-13_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410130049



> On 13 Oct 2024, at 11:08=E2=80=AFAM, Athira Rajeev <atrajeev@linux.vnet.i=
bm.com> wrote:
>=20
>=20
>=20
>> On 11 Oct 2024, at 12:18=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>>=20
>> On 2024-10-10 15:50 -0700, Namhyung Kim wrote:
>>> On Tue, 01 Oct 2024 10:19:47 -0700, Ian Rogers wrote:
>>>> The path detection for "Setup struct perf_event_attr" test is brittle
>>>> and leads to the test frequently not running. Running shell tests is
>>>> reasonably robust, so make the test a shell test. Move the test files
>>>> to reflect this.
>>>>=20
>>>> Ian Rogers (3):
>>>> perf test: Add a shell wrapper for "Setup struct perf_event_attr"
>>>> perf test: Remove C test wrapper for attr.py
>>>> perf test: Move attr files into shell directory where they are used
>>>>=20
>>>> [...]
>>>=20
>>> Applied to perf-tools-next, thanks!
>>=20
>> Dropped from perf-tools-next due to build failures on PPC.
>>=20
>> https://lore.kernel.org/r/20241011102330.02bece12@canb.auug.org.au
>=20
> Hi Namhyung
>=20
> I am checking this on powerpc. Will respond with the findings
>=20
> Thanks
> Athira

I tried on tmp.perf-tools-next branch from git://git.kernel.org/pub/scm/lin=
ux/kernel/git/perf/perf-tools-next.git

But hit a patch apply issue in second patch

error: patch failed: tools/perf/tests/tests.h:83
error: tools/perf/tests/tests.h: patch does not apply

Applied this change separately and hit the compilation error reported by St=
ephen

As suggested by Ian , tried below change and it did solve the compilation i=
ssue

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 37c338b0f8b2..cc5c919dcd0f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -6,6 +6,11 @@
  * copyright notes.
  */
  +/* Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to sele=
ct
+ * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
+ */
+#define __SANE_USERSPACE_TYPES__
+
 #include <byteswap.h>
 #include <errno.h>
 #include <inttypes.h>

I could also verify running the test as well

# ./perf test attribute
 65: Perf attribute expectations test                                : Ok


With the change above,

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linu=
x.vnet.ibm.com>>

Thanks
Athira


>>=20
>> Thanks,
>> Namhyung


