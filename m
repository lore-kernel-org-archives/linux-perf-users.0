Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F136EABE;
	Fri, 24 Jul 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882615; cv=none; b=DY4cgL284TuKyZHI8KS7nyCpLhjaUlXT+TyQJiFWl1+tiYENhND1lp2MDiKJAT2djWeBHRKFSCK3pcH/SSgA4WGZHBQPdMs9AU1Jnu+j9Fqa7q3CeiiTSkNlfI1wm3uOmmT5MEhjLIu4EQI7u2IZCPkx8o+QZ7QHUHe5LKAWjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882615; c=relaxed/simple;
	bh=6a3XgRxVH1CcMMPaja26ZcOvMwTDUR8h6ewB4GLE9yE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jm3KtDXFDokegOxmxh5PeQs1dzZZLxwTT2vVgjTN7hIn73wxjAp/MQtpKofn8WgVZfIhUjvuFCClFAUxUhIMJaRO4Rw6qTRViq40MfQHNUbgZzQfxTMAY4wwUE2QNtsQ8BFtg9FoJM4krA2AqL6qtd5jVOKTTBlON/+ds1RK3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jryjpe+1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jryjpe+1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5C394826990;
	Fri, 24 Jul 2026 08:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/KqXda
	sJ84lBiNsjemdBngzxGRijyDFIqUPBxKXNiCk=; b=Jryjpe+1h4BZq1BLQ7iMlQ
	SRLOGUXIzpeR5Ldy2WxyMr2gf+FFwm6ZzG4dtRtJTr5u0OEVNPFJjXeMkT438W8r
	qDBU+eXS5B/RJsGq0ewXzMPH9l/KreTT5e+vtJwwf/LmapUqO1cv/PVXP314buBn
	uGTpYo3PBAE8Q8LD6eavKPub5VkRPb4t+WvhCJa8e+RDTz7MUXJbBlu5GUE5um/S
	OyrPTbcUpiigxNmsZXRPWEBX3LWqmVy7nzsn+0WECYPV5cqmM5x9Su47p5YuYlhO
	CtUq3P5pPCjVJpZtggDVgGQPyUkGYPJmHeowyzJTn35DLdyz/b0KTQVROgo3vYng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kk7ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:43:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8Yaq2014393;
	Fri, 24 Jul 2026 08:43:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wg7wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:43:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8hU5t16843192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:43:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1485C200AF;
	Fri, 24 Jul 2026 08:43:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F2E2200AE;
	Fri, 24 Jul 2026 08:43:29 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:43:29 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720112059.DB20E1F000E9@smtp.kernel.org>
Date: Fri, 24 Jul 2026 14:13:17 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <32EF9C92-4BFB-4CA8-8FE2-5D0316B372B0@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-3-atrajeev@linux.ibm.com>
 <20260720112059.DB20E1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6325b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=L85Is7ZbPlCz9rsI8zcA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX6+4WTc3bLEKV
 fA8lvSxEQQPpzaoS99cKr+dB8QBuaIwNwkpStY9/V5udByj71Uyv0TRWaGEM3eteFjsaAkiJU+g
 AhZyShSdrNARzx1EpQ88GIQpA5irDZUbV0e0V+N9aBr//DW80XRb7rxSGOz48RYQgj8xMn2GpJZ
 xex1v8Ri+y2ENOy4PrdZ25qs+0PkmpOiufbt6rstUJ7qIr6CRgr2bXG47V88vmnoR3tzFQ9a0pA
 E/T4VCDyqRqemfpLFzBXcLbDJbBt6ZwgM2NoBxPV4m7h7n0hpVYemw2kY8tb2TtTPQdSDJtZxzX
 YIkfsc7kGCEJnsXwDaGU9HKW8JixWAeYhBGcStqlGgWltLadSPOsVyFnQXx+4k8sHV3MeE3YDOI
 aR8S7G80yfVzVdlVEY6gBGYga4SfGCWHC1VtqWFPx1+Pf2INh+hKXU4mJ5ZP5x6NgG3CSfvv8YQ
 CaA1KM5vFfMkHK076pA==
X-Proofpoint-ORIG-GUID: GhCz6GqBUrAZNXWSnYM-IUE_A1fdMuSj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX5QugmRSd488u
 BWaUTy4baMzpqdnsVyumUaOStha7smYrd/ufw8KQo3qPTPVGoCEb0BcrnZL4vqSsG0UlWEJSJXM
 737Dt7R64MLH2kdiADTTzTO76gSYh4c=
X-Proofpoint-GUID: GhCz6GqBUrAZNXWSnYM-IUE_A1fdMuSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240078



> On 20 Jul 2026, at 4:50=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Uninitialized auxtrace_info->type causes perf.data corruption =
and breaks bisectability.
> - [High] aux_watermark is set to the full size of the ring buffer, =
risking trace data loss.
> --
>=20
> --- Patch [2]: [PATCH V2 2/6] tools/perf: Add AUXTRACE recording =
support for powerpc HTM ---
> commit 90e77eef6274098986791263120e8c79ee34c0b9
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add AUXTRACE recording support for powerpc HTM
>=20
> Adds powerpc perf tool support for HTM PMU AUXTRACE recording. =
Introduces
> htm_recording_init() and related auxtrace callbacks to create
> PERF_RECORD_AUXTRACE records for HTM data. Updates =
auxtrace_record__init()
> to detect HTM events.
>=20
>> diff --git a/tools/perf/arch/powerpc/util/htm.c =
b/tools/perf/arch/powerpc/util/htm.c
>> new file mode 100644
>> index 0000000000000..07b496e4be2fb
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/htm.c
>=20
> [ ... ]
>=20
>> +static int
>> +htm_recording_options(struct auxtrace_record *itr __maybe_unused,
>> +      struct evlist *evlist,
>> +      struct record_opts *opts)
>> +{
>> + struct evsel *pos;
>> +
>> + opts->full_auxtrace =3D true;
>> +
>> + if (!opts->auxtrace_mmap_pages) {
>> + opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
>> + if (opts->mmap_pages =3D=3D UINT_MAX)
>> + opts->mmap_pages =3D KiB(256) / page_size;
>> + }
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + if (!pos->name || !strstarts(pos->name, "htm"))
>> + continue;
>> + pos->core.attr.aux_watermark =3D
>> + opts->auxtrace_mmap_pages * (size_t)page_size;
>=20
> [Severity: High]
> Does setting the watermark to the full size of the ring buffer risk =
hardware
> trace data loss?
>=20
> By setting the watermark equal to the entire buffer size, the wakeup =
only
> fires when the buffer is 100% full. Because scheduling the user-space =
perf
> tool and reading the buffer introduces latency, any hardware trace =
data
> generated during this window might be dropped due to a lack of buffer
> headroom.

Thanks for this feedback. I will address this change in V3
>=20
>> + pos->core.attr.freq =3D 0;
>> + pos->core.attr.sample_type |=3D PERF_SAMPLE_RAW;
>> + pos->needs_auxtrace_mmap =3D true;
>> + }
>> +
>> + return 0;
>> +}
>=20
> [ ... ]
>=20
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
>> + // To set: auxtrace_info->type
>> + auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] =3D =
htm_r->evsel->core.attr.type;
>=20
> [Severity: High]
> Does leaving auxtrace_info->type uninitialized break bisectability by
> generating corrupted perf.data files?
>=20
> Because the type is left uninitialized (defaulting to =
PERF_AUXTRACE_UNKNOWN)
> before the auxtrace info data is written to the stream, this might =
create
> trace files that cannot be read by `perf report` at this commit.
Patch 5 is handling the setting of =E2=80=9Ctype=E2=80=9D, I will move =
that to patch 2 in next version

Thanks
Athira
>=20
>> + auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] =3D expected_n;
>> +
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720105218.14277-1-atrajeev@linux.ibm.c=
om?part=3D2

