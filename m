Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DF2E7396;
	Sat,  8 Aug 2026 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161944; cv=none; b=S7EPwIsPd+w3AHKymzhAlG37S15dH1VAzffibtGhdgp00B4YFf/xUWV4U6L9Ec5DBwCaT8l9HeX7W3JH11CzgDmpdT4EGN69sXDI4sWI7Y7pjNv0OSEQ+iJLVCX2QSDnP83/P3YXUl/pukRqzjCsyJ5qu4vdRYKdDlk2hZTz+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161944; c=relaxed/simple;
	bh=pTzb7xx6jHjDgXAQZT9SpTcjFDW5z74J5OZNCf+GbXQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TQOl1QUji7Nb1FijdTOLCxTYzVv7xkkDyaiNQDsFfLIyPYeJ2Bb7uhV0ZAcoDOW3I1gQ5BzP2nnaNa4Y39Q5y6rj4FuIn0MN1ZhG70TBpLi0r90N7NgBdBz53RyiKNfIxDD4iJa5qqJNJw6XpjYiHRJjD2F3il0lUlrWF/L4tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFJd7f7z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFJd7f7z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67841R953373026;
	Sat, 8 Aug 2026 04:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IpzGms
	faFiX1M898TeUgu6kDvWdZIc0q97/2VIrQnRg=; b=ZFJd7f7z3y+USPFRaeycDa
	MGz2nivpBEUHU6JUuSzeyEd91hcTrYRnKuiAl5DMHR8SxPWJiMyR5G41FgbXHS2O
	dM3tFQWJg5rnzEoI5c3b8bDUU9XLA8I20/fGWNcxUhlEe9L2esrs8So1fxhNv5sU
	U03ro265QB8VLgLpFKhKCqPSFwOI3UTtieNIgyA0Nx6VDMnHMG2DM+EX9ZBokxvQ
	8rZYVj8eyHG/bNLr8llMN8AeF/4gSkUCM93i7XHVLeiifkCzQNhFPmbS8FWN/g6i
	Fx6iiY5C/lwRT9vm59njxri4YXvjD1dl05uNVlx9cis36qFIZNis6pcnOoXn+3nQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9025v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 04:05:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6783uLIN009439;
	Sat, 8 Aug 2026 04:05:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r2kwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 04:05:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67845d1739518558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 04:05:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DE1720043;
	Sat,  8 Aug 2026 04:05:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA4C720040;
	Sat,  8 Aug 2026 04:05:38 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.45])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 04:05:38 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V5 3/6] tools/perf: Add arch hook to drain remaining data
 before event close
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260807152010.B54701F00A3D@smtp.kernel.org>
Date: Sat, 8 Aug 2026 09:35:26 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <95D5E14C-A5F0-4282-B1C3-586A32E37493@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-4-atrajeev@linux.ibm.com>
 <20260807152010.B54701F00A3D@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o2B7omATG8jpbVYA0hX2RxSL9G7OTYhF
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a76ab16 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AWHx1f9aVwwyf6UXPzAA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAyOCBTYWx0ZWRfXzYIPMwttuBjB
 mHKbiDMWUzr2ZTYBm149ITE+zGsVYWyba7/HSyWvhRDHRtx3tX+bPlSgRXr7E+WP8jlfnk4tGZ3
 SePGeBa7MhQxV5n8u0nsrvPb4aKS0Nd/E+43p2JcQ3TBKCeN7RzRUnQwQAQobBBFhHya5VpdrQZ
 bAiJkhmpbD5QTJLBgBDp+oQo6jO0ccauus3vM784BGfmCnbA0/DqpBSzTz81OSgbiERH2m2ZdRS
 BooAGJ4dNNhVm+rFP2mU+MQf2KWBk3BCefCE4hOf5TKgpZXz/6edKGO1MzQm2P718DZFoFktcN8
 6ZHG3Yu5pRtrxFRrPF8mttV9hZAX09Xr+6jMgbOrYVTYkH5k3UZojn4iE8ht827o63kVjFChDYE
 2rUzZ/dCw6M+5RA7Fwq4/Csx3vUT2gdrFeopxfbbH3YVJe1PgQoodOFmUPTQSe0jj0zKa9f/0do
 YjguLxPV19xO0Yo0lAw==
X-Proofpoint-ORIG-GUID: o2B7omATG8jpbVYA0hX2RxSL9G7OTYhF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDAyOCBTYWx0ZWRfX9kG3glYg+bAd
 X3yC4e1iX5MzYangGryrocMK80qJ+7jws/v52tLalNXmi5sx8Z61Q9C8M5pGLozy4VWZ3UnaCYY
 ngBnXPDzHer6yHtOp7Ry6LLUdGnhEXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080028



> On 7 Aug 2026, at 8:50=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [High] The `record__final_aux_data()` drain loop can spin infinitely =
during system-wide or attached-process tracing because it is called =
before disabling events, allowing the active PMU to continuously =
generate new data. Furthermore, if the main loop exits via early break, =
events are never explicitly disabled.
> --
>=20
> --- Patch [3]: [PATCH V5 3/6] tools/perf: Add arch hook to drain =
remaining data before event close ---
> commit a89566ddd972102f4f5d6b30845f8dc3daa34fb4
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add arch hook to drain remaining data before event close
>=20
> This commit introduces a mechanism to drain remaining AUX data before =
closing
> event file descriptors. It uses a weak architecture hook to check for =
pending
> data and retries reading until progress stalls.
>=20
>> diff --git a/tools/perf/builtin-record.c =
b/tools/perf/builtin-record.c
>> index e915390556752..10f73aa2612ca 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>=20
> [ ... ]
>=20
>> @@ -2425,6 +2428,57 @@ static unsigned long record__waking(struct =
record *rec)
>> return waking;
>> }
>>=20
>> +/*
>> + * Weak arch hook called by record__final_data().
>> + * Returns 1 if the arch PMU driver still has records pending (the =
caller
>> + * will call record__mmap_read_all() and retry), 0 when done.
>> + * Implementations use perf_evsel__read() so this must be called =
while
>> + * events are still ACTIVE (before evlist__disable()).
>> + */
>> +__weak int arch_perf_record__need_read(struct evlist *evlist =
__maybe_unused)
>> +{
>> + return 0;
>> +}
>> +
>> +static void record__final_aux_data(struct record *rec)
>> +{
>=20
> [ ... ]
>=20
>> + if (record__bytes_written(rec) =3D=3D last_bytes_written) {
>> + if (++retries >=3D FINAL_DATA_MAX_RETRIES) {
>> + pr_warning("Final AUX data drain made no forward progress after %d =
retries.\n",
>> +   FINAL_DATA_MAX_RETRIES);
>> + break;
>> + }
>> + usleep(1000); /* 1 ms: let AUX ring buffer consumer advance */
>> + } else {
>> + retries =3D 0;
>> + usleep(100);
>> + }
>> + }
>> +}
>=20
> [ ... ]
>=20
>> @@ -2852,11 +2906,22 @@ static int __cmd_record(struct record *rec, =
int argc, const char **argv)
>> /*
>> * When perf is starting the traced process, at the end events
>> * die with the process and we wait for that. Thus no need to
>> * disable events in this case.
>> */
>> if (done && !disabled && !target__none(&opts->target)) {
>> trigger_off(&auxtrace_snapshot_trigger);
>> + if (rec->opts.full_auxtrace)
>> + record__final_aux_data(rec);
>> evlist__disable(rec->evlist);
>> disabled =3D true;
>> }
>> }
>=20
> [Severity: High]
> Could this lead to an infinite loop during system-wide or =
attached-process
> tracing?
>=20
> Because record__final_aux_data() is called before evlist__disable(), =
the
> events are still active and generating new data.
>=20
> If the workload is continuously generating data, =
record__bytes_written()
> will constantly increase, resetting the retry counter to 0 in the
> record__final_aux_data() loop we see above.
>=20
> Would it be possible to disable the events first, and then drain the
> remaining data?

Thanks for the review.

record__final_aux_data() is called before evlist__disable() by design, =
for two reasons:
-  arch_perf_record__need_read() in powerpc callback is using =
perf_evsel__read() which requires an active event fd. Reading a disabled =
fd returns 0 immediately, which arch_perf_record__need_read() would =
interpret as =E2=80=9Cread complete", and not proceeding to further =
reads
- The driver needing this callback is expected to handle the event =
disable or disable of tracing before read.
- In case of powerpc callback which is using =
arch_perf_record__need_read() , issues an evsel read and  the read =
callback in PMU freezes the hardware trace buffer before dumping it. So =
its made sure there won't be infinite loop

I will update the comments documenting these details for any future =
architecture wiring a PMU into this hook.


>=20
>> + /*
>> + * If the loop exited without entering the in-loop disable block
>> + * (early break, or child workload where target__none is true and
>> + * the block is never reached), drain any remaining AUX data now.
>> + * Events are still live at this point.
>> + */
>> + if ((target__none(&opts->target) || !disabled) && =
rec->opts.full_auxtrace)
>> + record__final_aux_data(rec);
>=20
> [Severity: High]
> If the main loop exits via an early break and this fallback block is =
reached,
> does this leave the events permanently active?
>=20
> Since evlist__disable() is never called in this path, we might spin
> infinitely in record__final_aux_data() for the same reason mentioned =
above,
> continuously reading newly generated data.

Thanks again for the review

For an early break, example:
if (hits =3D=3D thread->samples) {
                        if (done || draining)
                                break;


We reaches to :

        /*
         * If the loop exited without entering the in-loop disable block
         * (early break, or child workload where target__none is true =
and
         * the block is never reached), drain any remaining AUX data =
now.
         * Events are still live at this point.
         */
        if ((target__none(&opts->target) || !disabled) && =
rec->opts.full_auxtrace)
                record__final_aux_data(rec);

The reason for having record__final_aux_data without disable is conveyed =
in above response,
But after this , we do call evlist__disable in the out_child and =
out_child_no_flush

out_child:
        evlist__disable(rec->evlist);
        record__stop_threads(rec);
        record__mmap_read_all(rec, true);
        goto out_free_threads;
out_child_no_flush:
        /* mmap read already failed =E2=80=94 retrying would just fail =
again */
        evlist__disable(rec->evlist);
        record__stop_threads(rec);

So this won=E2=80=99t leave any event permanently active

Thanks
Athira


>=20
>> trigger_off(&auxtrace_snapshot_trigger);
>> trigger_off(&switch_output_trigger);
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260807144135.2607-1-atrajeev@linux.ibm.co=
m?part=3D3

