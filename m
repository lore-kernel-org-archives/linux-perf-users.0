Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC54165F1A;
	Sat,  8 Aug 2026 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786162201; cv=none; b=cSo8zzQJ7ziHF9VxOqbKXuTQ9Gp98gHcPg398TfcD3flf2gZpbTKdQ79XX6jt96qbWvnwytwLZDpfD9Jsb1/hMwfaLTyjwLXOzT0yel/l88X99CK2fhdn29s52CcxJNJchIaEAiRZZ/IIPRGgXKr/iTbhLbMZoae1A0EaPpbxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786162201; c=relaxed/simple;
	bh=bbrDhwWfR7qf2GMD9CdQJvFTmTkPENmcbhPrnGWOE2E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=b6HzbJ2WuEL1l6zpBtIN5Yd7mY3/CJ5W3W0cGpZqblY94fEJfLrEk7WeUqPK74uJd5AsrNOSWF5IcrvDrhRpwFIFrJ1z2vzwa4Pec6UZQyI07nLqBvHdnJ1G8SIQh8TKMNTQ3grmNLasqtr5bj7NHdA6IcAVsrUf34DGjQ2OxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqCdTK6D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqCdTK6D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678488AV3385819;
	Sat, 8 Aug 2026 04:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A/LFQr
	Gt6OD5nd7lb6yeNuwY4eksK3qvayVjeDYGEaU=; b=OqCdTK6D637PIMtpE5UZGM
	hMUPZTMdYhJljYUIA243heiAb3/DVsaZtWhzVPmejyxI7thvH22hDSOR+M0sBzJ8
	a9aXZT6gbYnR88fGlFdwroTeLrcJkWB4pU5OphZzRhnWP2PRlOm8wSqhKVFhjLGr
	ISv9wRlyuh+Le07rg6J6vYc+D+iyVG89QYqggRMk3vFnLtgUHxiHrTLrjWs/+txx
	B+TkhfjzSSzuhsi3HELgeNrHpSMUFzY/UJ0s9woli0/shreLPUaK27LWjnso0uvv
	jHewmLmBYuk6BJlbMT3lGFAOWcT5zt7lNIT+LU6zZG1MuqZiRaXceo+EIEghAweA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq902jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 04:09:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6783ufDi017871;
	Sat, 8 Aug 2026 04:09:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kjh50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 04:09:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67849tov51446200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 04:09:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90ACD20043;
	Sat,  8 Aug 2026 04:09:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECB8920040;
	Sat,  8 Aug 2026 04:09:54 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.45])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 04:09:54 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V5 5/6] tools/perf: Add powerpc HTM auxtrace event
 processing support
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260807153320.BD5121F00A3D@smtp.kernel.org>
Date: Sat, 8 Aug 2026 09:39:42 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E0ACB04-F138-4E25-B921-8C536882495B@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-6-atrajeev@linux.ibm.com>
 <20260807153320.BD5121F00A3D@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c9plv2Oj-zVFuqb24JyholtBDtZiK941
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a76ac16 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=_cqto0BUdNIvm84bEp8A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAyOCBTYWx0ZWRfX8mNMIEvwCAP9
 sxKs8SylOLdANfET06llhlEsezDdIEKb8PeDVnbXrMmyWkaW4HgWTrsmiLNOWLYs1Ro6NejI6q9
 opAa7IL/QfzF9q78T3yLz5rowM/Dg73fR+LwY8ZckiDhhcGjdl/j06oCCjh/I786sGi5xBxsWm1
 h/tS9uERUhmqZdfk+nJfTY+I8VLL40+ifWjAfI5are9Cuh/LYre0cAkJLj/6SoY5y3AI+YYR6Fa
 fLW7pLrp8SCYdgUhcm3olZjisupWkLXAShu8wuy8w00b/VkU9/FCcp0rDwJgggzXhXssW8/PVyE
 +qVjXucXO8zGD/pDmDdBP2dVP+45Kx56Adb2HcvEjYyOzaX5IJWTPTGa7c2u3B5rR15PQH6Y8ve
 GbFM1ma+I1XPIIXBSBsaBox9zEhWpKm0eBShCJ+Q0fyreJ1dbjTiaR2G629RXRuPkwN0AWj3/wj
 XgaDfh3CvPNxFpT675Q==
X-Proofpoint-ORIG-GUID: c9plv2Oj-zVFuqb24JyholtBDtZiK941
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDAyOCBTYWx0ZWRfX+3XqpkYLxIdQ
 5TohRl+VIMWM4P9z8dhmmhb1T1Uybo9TPECKnUsKDctaNLfp01P5SrmqzK5VStBaP/IdAW+l6MP
 dN0MQ5Koi+hXvYxxH/p3+eD+KjJU49A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080028



> On 7 Aug 2026, at 9:03=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
>=20
> Pre-existing issues:
> - [Medium] If multiple `PERF_RECORD_AUXTRACE_INFO` events are =
encountered, `session->auxtrace` is overwritten without freeing the =
previously allocated structures, leading to a memory leak.
> --
>=20
> --- Patch [5]: [PATCH V5 5/6] tools/perf: Add powerpc HTM auxtrace =
event processing support ---
> commit bdf509e26b28cea056c3306c8b70fad62802e9ca
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add powerpc HTM auxtrace event processing support
>=20
> Add the powerpc-htm.c decode stub and wire the dispatch in
> perf_event__process_auxtrace_info() to call
> powerpc_htm_process_auxtrace_info().
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> new file mode 100644
>> index 0000000000000..0ef7ecd18c6f3
>> --- /dev/null
>> +++ b/tools/perf/util/powerpc-htm.c
> [ ... ]
>> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
>> +      struct perf_session *session)
>> +{
>> + struct perf_record_auxtrace_info *auxtrace_info =3D =
&event->auxtrace_info;
>> + struct powerpc_htm *htm;
>> + int err;
> [ ... ]
>> + htm =3D zalloc(sizeof(struct powerpc_htm));
>> + if (!htm)
>> + return -ENOMEM;
>> +
>> + err =3D auxtrace_queues__init(&htm->queues);
>> + if (err) {
>> + free(htm);
>> + return err;
>> + }
>> +
>> + htm->session =3D session;
>> + htm->machine =3D &session->machines.host;
>> + htm->auxtrace.process_event =3D powerpc_htm_process_event;
>> + htm->auxtrace.process_auxtrace_event =3D =
powerpc_htm_process_auxtrace_event;
>> + htm->auxtrace.flush_events =3D powerpc_htm_flush;
>> + htm->auxtrace.free_events =3D powerpc_htm_free_events;
>> + htm->auxtrace.free =3D powerpc_htm_free;
>> + session->auxtrace =3D &htm->auxtrace;
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but if multiple
> PERF_RECORD_AUXTRACE_INFO events are encountered in
> powerpc_htm_process_auxtrace_info(), does this overwrite =
session->auxtrace
> without freeing the previously allocated structures?
>=20
> Could a maliciously crafted perf.data file containing multiple such =
events
> trigger a memory leak here?

Thank you for the review. You are correct that this is a pre-existing =
pattern, not something introduced by this patch.=20
I will check this and send a separate fix patch to handle this.

Thanks
Athira

>=20
>> +
>> + return 0;
>> +}
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260807144135.2607-1-atrajeev@linux.ibm.co=
m?part=3D5

