Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36294165F1A;
	Sat,  8 Aug 2026 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161063; cv=none; b=bGZoXjfWSX+uPTINKqG2wPbejRkKhJgpftX1h4Yf3Wd1qW4Md+6MUUTfZxwRiXIvXqpeZ0QA26voQsKSsepKCyoH9eGBYist5RnJ6E+TdwZ0M7/BSCIIhsitBPQZTtf4d/k4D9AxRc9JLJjjC+T8A40FvN49hidIQZH7TXMGxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161063; c=relaxed/simple;
	bh=YKlOFwwfoRHKSYtEmKwTtfm+QryBsgP9jQOBfDxPctI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZHEd/MTovsg4HQSaixrp7nDTD/2EOSZo3v3QHPH77Ofe7GkqaCh2DCBCKvgIh4G30yXb0AYCBJwUrYi6IqE51MH09XStWr5zlrpjxMmTe5DTe79KNhJU/H68AY+LI5wnkgPg7IWXx14FrczTM8Y6AYRwkLkSzEeFEXFS+8UHjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TslxBJSF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TslxBJSF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6783Z2fa3259842;
	Sat, 8 Aug 2026 03:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tIs542
	9RT+zt2oZJQk9HhekwBnXkcCt8D9pIpmjg83o=; b=TslxBJSFZdkbQkXmaBkCSb
	pUz2d4gs4RPBlmY22EggeTkcgTFGrLdyYY3rtOMGbfdP+hm9nvj+U5tdx7gLD+w0
	kEWJaV4SG5xHyeKT8fnz1+AIYGsC4W7WBX6M9TxKPiVLwmjjBIBn43FtE1VTokzy
	uHd0EWDUOtznrnc091/9cM3sJ/IS6Qksbx2AJD73qXnXgsraNa5UtzeMhI/oBd3a
	eBCvGpz5QT+CWsPO2fUwug9ofmfGK9tlJQoZOSUlyT62oxStofIU8dRMTfyRNs1V
	ucmS/LpnDZnEtOmGbFyduPWAAeuYnIll2cpDfT0OATCMjuB4lQaBcHoGvExX/7QA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2g112-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 03:51:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6783fFP8025806;
	Sat, 8 Aug 2026 03:51:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r2jpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 03:50:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6783owPm29229654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 03:50:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22ECD20043;
	Sat,  8 Aug 2026 03:50:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F85920040;
	Sat,  8 Aug 2026 03:50:57 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.45])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 03:50:57 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V5 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260807145958.2AEF21F00A3D@smtp.kernel.org>
Date: Sat, 8 Aug 2026 09:20:44 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <44FFDD84-E177-4824-9233-AE021E8ED3A5@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-3-atrajeev@linux.ibm.com>
 <20260807145958.2AEF21F00A3D@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a76a7a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=q_6GuL3v2PeAzwMcsi8A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: KlIrGZFdQV1Nf3CbsEmm5b6y7GGZah05
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAyNSBTYWx0ZWRfX90LmDQATpMvj
 7zT3ieE4bzIJvesoXIfI6s0c786+z+GIgKO5iZnDsx5iSKFZAwQ0JXQO5byW4HuWMH2Y51yeiyv
 /vRMf+c5nJz0AX044Df1kr64w1Cq0jKKxmOD3LNUDUt0sp+FeJRv8+1jT6xOkdMS2HWZs2OCmNc
 RXRWkvBVr3KktMY4JqSY2I4qotdK2WV64r3LQEE2Yo7g+CXDLNk4ObllJpa2lPIwgxe+wEkZ7k+
 IM7qtbospA49ANQq/fdr5nOW7W5wKEwFWPbCc/xawms6pqrwJlxaj+Hkvj9LZoUG6ETE+TsoGdH
 NASzvf0X2+VBqu5SE7Q2Fv4U0nqqZfK9VUvm+RewM9gM3/5951tQlfO9Rx/kSPZ9lRWtIzzPIgJ
 YsPugDGPdzHP5S7dz9iJGOnBn5UzVJNkF+JXii+zO0qHyWfOYGqnRPsMzdV6C/CTkOrl5+FYm0O
 Oj86LMASuk5rQf4LjWA==
X-Proofpoint-ORIG-GUID: KlIrGZFdQV1Nf3CbsEmm5b6y7GGZah05
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDAyNSBTYWx0ZWRfXxKFuc+Um1rN4
 a+QK+JHbbJnw9fF52yj3l3T74DGkZpj0+TIn+L11ZWgR03/U8b8V9pSy3pzmyqYdbwL8SURuejd
 QlkxcCR5Rn+gWvaWoDYtV7deYyox7I4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080025



> On 7 Aug 2026, at 8:29=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Heap buffer overflow in htm_info_fill() due to undersized =
PERF_RECORD_AUXTRACE_INFO allocation for HTM evsels covering multiple =
CPUs.
> - [Low] Missing explicit inclusion of `<string.h>` for `strcmp()`, =
violating musl libc compatibility guidelines.
> --
>=20
> --- Patch [2]: [PATCH V5 2/6] tools/perf: Add AUXTRACE recording =
support for powerpc HTM ---
> commit 36cc90227b9052ae32b72e6b7df67e4e6bc7ac1e
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add AUXTRACE recording support for powerpc HTM
>=20
> Add powerpc perf tool support for the HTM PMU AUXTRACE recording path.
> Introduce htm_recording_init() and the associated auxtrace callbacks =
so
> perf record can create PERF_RECORD_AUXTRACE records for HTM data.
>=20
>> diff --git a/tools/perf/arch/powerpc/util/htm.c =
b/tools/perf/arch/powerpc/util/htm.c
>> new file mode 100644
>> index 0000000000000..d2fdef4880320
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/htm.c
>> @@ -0,0 +1,185 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HTM AUX tracing support
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/string.h>
>> +#include <linux/zalloc.h>
>=20
> [Severity: Low]
> This isn't a bug, but this file uses strcmp() which is declared in =
<string.h>.
> Does this code need to explicitly include <string.h> to avoid relying =
on
> implicit inclusion, which might cause build failures in strictly =
conformant
> musl libc environments?
>=20
> [ ... ]
>=20
>> +/* Count htm evsels in the evlist */
>> +static int htm_nr_events(struct evlist *evlist)
>> +{
>> + struct evsel *pos;
>> + int n =3D 0;
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + if (!strcmp(evsel__pmu_name(pos), "htm"))
>> + n++;
>> + }
>> + return n;
>> +}
>> +
>> +static size_t htm_info_priv_size(struct auxtrace_record *itr =
__maybe_unused,
>> + struct evlist *evlist)
>> +{
>> + return HTM_AUXTRACE_PRIV_SIZE(htm_nr_events(evlist));
>> +}
>=20
> [ ... ]
>=20
>> +/*
>> + * Fill the PERF_RECORD_AUXTRACE_INFO private data with:
>> + *   priv[POWERPC_HTM_PMU_TYPE]   =3D pmu->type of the first htm =
evsel
>> + *   priv[POWERPC_HTM_NUM_EVENTS] =3D total number of HTM CPU =
entries
>> + *   priv[POWERPC_HTM_EVENT_DATA + n*2]     =3D CPU number for nth =
entry
>> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] =3D attr.config for nth =
entry
>> + *
>> + * One entry is written per CPU in each evsel's cpu map.  An evsel =
opened
>> + * with -C 0,1,2 contributes three entries (one per CPU), each =
carrying
>> + * the same attr.config.  The decode side uses event->auxtrace.cpu =
to look
>> + * up the matching config and derive (node, chip, core) for the =
output
>> + * file name.
>> + */
>> +static int
>> +htm_info_fill(struct auxtrace_record *itr,
>> +      struct perf_session *session,
>> +      struct perf_record_auxtrace_info *auxtrace_info,
>> +      size_t priv_size)
>> +{
>> + struct htm_recording *htm_r =3D container_of(itr, struct =
htm_recording, itr);
>> + struct evlist *evlist =3D session->evlist;
>> + struct evsel *pos;
>> + int n =3D 0;
>> + int expected_n =3D htm_nr_events(evlist);
>> +
>> + if (priv_size !=3D HTM_AUXTRACE_PRIV_SIZE(expected_n))
>> + return -EINVAL;
>> +
>> + auxtrace_info->type =3D PERF_AUXTRACE_POWERPC_HTM;
>> + auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] =3D =
htm_r->evsel->core.attr.type;
>> + auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] =3D expected_n;
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + struct perf_cpu_map *cpus;
>> + int i, nr;
>> +
>> + if (strcmp(evsel__pmu_name(pos), "htm"))
>> + continue;
>> +
>> + /*
>> + * Emit one (cpu, config) entry for every CPU in this evsel's
>> + * map.  perf record -C 0,1,2 creates one evsel with a
>> + * three-entry cpu map; each CPU gets its own AUX buffer and
>> + * must be individually mapped so the decoder can match
>> + * event->auxtrace.cpu to the correct (node, chip, core).
>> + */
>> + cpus =3D evsel__cpus(pos);
>> + nr =3D cpus ? perf_cpu_map__nr(cpus) : 0;
>> +
>> + if (nr > 0) {
>> + for (i =3D 0; i < nr; i++) {
>> + int cpu =3D perf_cpu_map__cpu(cpus, i).cpu;
>> +
>> + auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     =3D cpu;
>> + auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =3D
>> + pos->core.attr.config;
>> + n++;
>=20
> [Severity: High]
> Does this code overflow the auxtrace_info->priv[] array when an HTM =
evsel
> covers multiple CPUs?
>=20
> The auxtrace_info->priv[] buffer size is calculated by htm_nr_events() =
above,
> which only counts the total number of HTM evsels. If a user runs perf =
record
> with a CPU list (e.g., -C 0,1,2), there might be only 1 evsel, =
resulting in
> space allocated for a single (cpu, config) pair.
>=20
> However, this loop iterates over the CPU map and writes a pair for =
every CPU
> in that evsel (e.g., 3 CPUs), incrementing n past the allocated size.
Thanks for the review
Will address this in next version

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260807144135.2607-1-atrajeev@linux.ibm.co=
m?part=3D2

