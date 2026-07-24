Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1553D9527;
	Fri, 24 Jul 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882756; cv=none; b=qSgj1YytWx2j5p8Z47ivroOedLVhtPyWlSKxlNXAhjCdcPa7fKyQPJ2MCXdclxdxpnm1rijjXwNbTYfhO3uJlkPpPo8afoetR3rlflOJaP6tReytJVfEchBFLn3QWwcetDCH3EbzgyDKOttrcjDvmdzdvX+HrGpqqAe1sYL3QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882756; c=relaxed/simple;
	bh=M30PfnP+AeqLyexrvNACk6zIkmEcmuGequlHDnfKhG8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QDmRo5aCrXtl6AxNGO+EfIsVFvv9qaHFfNsWDbY0WxKKYOV1l2UJob5LJu6e6l+4povG3B902p15Ao/Zf6B9Nr0QMiNNf+Ajx51VIfbdbwQ2CphcPOUD0mC4aDYxNJlscLBXxQcgK+elEklJGrGtiLY15bwRS2y7PTZ9twzg+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RRWk1ATI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RRWk1ATI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bra2920034;
	Fri, 24 Jul 2026 08:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gZ2oWc
	aT3NooseVa21zRz2on3po7RbMVMEA7BNoaVeA=; b=RRWk1ATI6hsUeqzjEBEmyd
	iUEvisolCoUj6PlpLCOlMe46Igwom3urpary+QXGfsr1L7vceKO1VIntMf9fm1d1
	vttBv61iYAP8YqgTZoo7RhSMTQce3PUl3F8gZzqTp89mLOyYViPGPI8QtA5Kl1eO
	qzqH1BAYLnEGr1HyRDul1cmlR0JkdB7stPviiubsGxDETKn5uOLFM0aPuDcgjJxI
	M2+C47Cd2k23wheQGfaDlVRs8IHjPB9qgPtAwiM9+UP6nwafadNDeIJtSztROKDO
	s+FVzPKJg7OsjocwHGQ4Tk+6PIfPETqBMPTzy52/828YCZc0zXvIkYMIANPEqNtA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791buuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:45:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8JeE7027048;
	Fri, 24 Jul 2026 08:45:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk85aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:45:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8jpOi42336662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:45:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3962200B2;
	Fri, 24 Jul 2026 08:45:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57EBA200B1;
	Fri, 24 Jul 2026 08:45:50 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:45:50 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 3/6] tools/perf: Add arch hook to drain remaining data
 before event close
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111601.BD9411F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 14:15:38 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64592992-3113-42E5-9EB6-D76E0DA298F7@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-4-atrajeev@linux.ibm.com>
 <20260720111601.BD9411F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R7Hkcgd5lsjPc7a14gemXqc3vQCARoCY
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a632642 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=qAqu8QXVZi8EA707AhwA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX0DvZug3gOjcD
 9A8FVAbVITQvfgvvDpwkJYR6i9m4sLii8wdOCN8raMp1dgCGXvRjtb7LQnfZ/e7KpwHPCbo8pTw
 gTr3E2dDUd85zfL+ZeXkHB+9exU0FXc=
X-Proofpoint-GUID: R7Hkcgd5lsjPc7a14gemXqc3vQCARoCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX/3jqKzlv7i0w
 28gLHQfoeL1ZdU/kjB8a9h+joKbowWpRYhjbqvn7hq7LpukgdRUeeQJRpQwlx9FHlmzWrBwcLyX
 rpBr1w9fLO5RUEIjXGMGri3W0ESCjwj7p3WLQKU8G6Tho7mNEQNyschVS0KdsEoMvsJQ6ulGkUw
 5haQBcqw6FfiQ5dh0/d/XsgCTNINeidj4/kwWIUNhzdzd0nj95Hipy73CTM/mXhrbaBZmag4Trj
 cOOQkgwke2K7XZaaczKlNy36wT16cLHVftXd8IV5I1rP4z4R5ZoaevLvl0oB8RKg2aMIcPNogBT
 4+EZfI3W4Un06PU85srbceGQdL8IOgFSrb6VaS/Hm6UB2mFIzdFqQ7DEolemZjkfpdOBw8q2JKW
 lK1lXLZbS9s2r+fpXM3eSZu63DfhRU0P7XOuwmJsm8Z0y7qlxyKe/nXKC9WUdXM9dzIi+Pu/dGu
 LiRxTxSd4Ae8u7I/2Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240078



> On 20 Jul 2026, at 4:46=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 4 potential =
issue(s) to consider:
> - [Medium] `record__final_data()` fails to drain architecture-specific =
data and falsely aborts in parallel trace streaming mode due to =
incorrect byte tracking and thread-local mmap limitations.
> - [Medium] The final data drain hook is completely bypassed on normal =
exit if the normal event ring buffer is empty when the termination =
signal is evaluated.
> - [Medium] The final data drain loop aborts on the first empty read =
pass, failing to wait for asynchronous PMU data to arrive.
> - [Medium] The force-abort mechanism `if (done > 1)` inside =
`record__final_data()` is mathematically impossible and will never =
successfully abort a stuck drain loop.
> --
>=20
> --- Patch [3]: [PATCH V2 3/6] tools/perf: Add arch hook to drain =
remaining data before event close ---
> commit 912498764cf4d44940ef92ba0d9b5b3fa62c31b4
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add arch hook to drain remaining data before event close
>=20
> This patch adds a weak architecture hook to allow collecting remaining
> PMU-specific data before events are disabled and closed. It introduces
> a loop in the record command to perform additional read passes when =
the
> architecture reports pending data.
>=20
>> diff --git a/tools/perf/builtin-record.c =
b/tools/perf/builtin-record.c
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
> [ ... ]
>> @@ -2425,6 +2425,45 @@ static unsigned long record__waking(struct =
record *rec)
>> return waking;
>> }
>>=20
>> +/*
>> + * Weak symbol - architecture can override to indicate if more
>> + * data needs to be collected before finishing output.
>> + *
>> + * Returns: 1 if more data exists, 0 if collection is complete
>> + */
>> +__weak int arch_perf_record__need_read(struct evlist *evlist =
__maybe_unused)
>> +{
>> + return 0;  /* Default: no arch-specific data to collect */
>> +}
>> +
>> +static void record__final_data(struct record *rec)
>> +{
>> + u64 last_bytes_written =3D 0;
>> + /*
>> + * Collect any remaining architecture-specific data.
>> + * The arch code checks if more data exists, and we do the actual
>> + * reading here since we have access to record__mmap_read_all().
>> + * This code performs the additional read pass while events are
>> + * still live.
>> + */
>> + while (arch_perf_record__need_read(rec->evlist)) {
>> + /* If user presses Ctrl+C again during draining, abort cleanly */
>> + if (done > 1)
>> + break;
>=20
> [Severity: Medium]
> Is it possible for this abort condition to trigger? Looking at =
sig_handler()
> for SIGINT, the variable done is set to 1 directly:
>=20
> sig_handler() {
>    ...
>    done =3D 1;
>    ...
> }
>=20
> Since done is never incremented, could this block of code fail to =
force-abort
> if the PMU gets stuck during the drain?

I will add a sighandler variable to catch this in V3
>=20
>> +
>> + last_bytes_written =3D rec->bytes_written;
>> +
>> + if (record__mmap_read_all(rec, true) < 0)
>> + break;
>> +
>> + if (rec->bytes_written =3D=3D last_bytes_written) {
>> + pr_warning("Final data drain made no forward progress.\n");
>> + break;
>> + }
>=20
> [Severity: Medium]
> Does this check properly account for multithreaded mode? In parallel =
trace
> streaming mode, worker threads maintain their own mmaps, write to =
their own
> files, and increment rec->thread_bytes_written instead of =
rec->bytes_written.
> Additionally, when record__mmap_read_all() is invoked from the main =
thread,
> it only drains mmaps assigned to the main thread. Will this cause the =
loop
> to abort prematurely with a false warning when running with multiple =
threads?

V3 will address this by using : record__bytes_written(rec)
>=20
> Also, if the first non-blocking read pass yields no data because the =
hardware
> needs a moment to flush asynchronous data, the loop breaks immediately =
here.
> Does this bypass the usleep(100) and defeat the purpose of waiting for =
the
> pending data?
Will change this approach to handle retry in V3

>=20
>> + usleep(100);
>> + }
>> +}
>> +
> [ ... ]
>> @@ -2845,6 +2885,11 @@ static int __cmd_record(struct record *rec, =
int argc, const char **argv)
>> done =3D 1;
>> }
>>=20
>> + if (done && !disabled && !final_data_drained) {
>> + record__final_data(rec);
>> + final_data_drained =3D true;
>> + }
>> +
>> /*
>> * When perf is starting the traced process, at the end events
>> * die with the process and we wait for that. Thus no need to
>=20
> [Severity: Medium]
> If done is set to 1 by a termination signal (like SIGINT) and the =
subsequent
> read pass yields no normal events, will we ever reach this newly added =
code?
>=20
> Looking earlier in the polling loop of __cmd_record():
>=20
>    if (hits =3D=3D thread->samples) {
>        if (done || draining)
>            break;
>        ...
>=20
> The break statement exits the loop completely. Does this mean that for
> low-frequency workloads, if the ring buffer happens to be empty when =
the
> signal is evaluated, the final data drain hook is completely bypassed?
Thanks for pointing out these catches, I will send a V3 addressing these

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720105218.14277-1-atrajeev@linux.ibm.c=
om?part=3D3

