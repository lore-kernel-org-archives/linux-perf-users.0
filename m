Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720D36194B;
	Sun, 26 Jul 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049299; cv=none; b=VgIlK8OYXAEoDN2fGbcRUvel67McyLYwsPHJIjmY8Y2iAFUE6jljggjuS+f86dwJCzWEVpNviV1YzBVnCJd6Da9csIS4E9Oo4bgTq3gX6HEi5iNyJjW+Hh+JQ4KrhWILKGTRJf7HspI2dnFbsEFlXorQ7Qmol8YkNx2THU7Y8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049299; c=relaxed/simple;
	bh=cV0d+56vc8t2ZHOU0s1IuznweQFi9SL0j0tfDRtb9qc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tGuD1auwzLt271h7sOPiZBs3racML/V0vct72BkeTAz3UxQ2dEypV5VBqo1cIvkWunZcDSlAXtuVBfB0JNO0Oru+/ndCBbOTrE6++nZWRtSWNwMrdohqJb64vNNAELwgpHdcw2aRjGyTqbWS1Y79bmQdhI1rf+UilXeMYjmxafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bAxiq9Zu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bAxiq9Zu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5m9Cc2573300;
	Sun, 26 Jul 2026 07:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3p5/Zb
	kGOOJEvll/YHSOEJPOcd7S5sgfIbtzldmknB8=; b=bAxiq9ZuJgW34U8h17kbd/
	zZDupa8C1uSBaQh0+snibex6/2ysCxH56i2iCEmjEbqfz4+1olxswPzpxtbUWbJL
	FUeza4j1wAxf0VDQJv5pM1DQKyAnTNMUzA32hqeFuWWm2nXQ8Niuh9NPsY/W+oa8
	bSwB9G8hQsQxdA0U22U7YiI29Zp1ET2j+0t3gWZcf7bmXH51/Yd7uigHqYQj8kqg
	Sf4kl+u+K9/91mSEjw44lf6WBOnKrWE/sD/hd8efYnu+l6z1AmlGyztjl5pGb1Yb
	ZqP4+5GOl09cOC4PSaNZDAEZXrA0ahJGaV8ij9x/wdlaqzHUlZ9Dt/b+NeZdmS5w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0namxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 07:01:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q6uGro008283;
	Sun, 26 Jul 2026 07:01:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq0xa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 07:01:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q71X8j30540210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 07:01:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B467201EC;
	Sun, 26 Jul 2026 06:43:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0902201E9;
	Sun, 26 Jul 2026 06:43:58 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.223.95])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Jul 2026 06:43:58 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V3 1/6] powerpc/perf: Add HTM PMU driver to expose
 Hardware Trace Macro data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260725074548.2B8B21F000E9@smtp.kernel.org>
Date: Sun, 26 Jul 2026 12:13:46 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A4689E5-1984-4EED-8D0B-F96F74AF348A@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
 <20260725065942.78839-2-atrajeev@linux.ibm.com>
 <20260725074548.2B8B21F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA2NSBTYWx0ZWRfX3fnAJWoIFh3c
 mVGR7tZcAJxGumR3q+ty+h/DgVdp/bk14QT23/Rq93jsbjoLXOHRw9ta8sLD06B0ary4YV44snY
 qTRqfJhCCM5fVmmEtNCDQpDNTUlhjQE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA2NSBTYWx0ZWRfXw5hT9DKbh5uZ
 lWJwLOgpzipS6jOPFxWjKszsbojrvTRWPlr4o3MgwKGlkCD0watTuYHP5YhkqAlsaCvN1lxVBoB
 svlMLDNpyTwx4mVSyYxd1vXJR3jSfd/b0z49nlSlEfuK35x35tHBJxlaiQZlovLEa7SH+CXOT2W
 EEU+b5o8PUq9qE+5LTtAOJyr0RTjtvZb3tZrKxJu+2R0GB2w+QRJoUa8JYqaUilKrBXtrZ/zlCA
 Wnl1YxjHQLeK17LzITDoh5BzsRDfCClIyFWTkvrNLZy77a5d5KWmJdF5S5xJT9sDNB+itrV/adr
 jNYo+Z4wN/ZQhF0oaABpS5Zqr5sHqpqMkcE8KLx/jWIISYAkDHGIzSfNNu7BcBklpiLSK/9wIuD
 6XJ7zJDGnqkHF++qk1ebsonZbYJ72yHcOC/la/BexOP2D2R3tVHFKfp25r98C2ZC7UdQbHFb0v1
 8J0GaHnJMFfcKXmCnEQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a65b0d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=P0IwbnMn8OnG9rG40gcA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: yeMb4_7P2Qeh1100LjvS2E8sx0rrK9j4
X-Proofpoint-ORIG-GUID: yeMb4_7P2Qeh1100LjvS2E8sx0rrK9j4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260065



> On 25 Jul 2026, at 1:15=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Returning -ENODEV from pmu->add() does not act as a hard =
failure, causing a continuous retry loop that floods the hypervisor.
> - [Medium] Ignored PERF_EF_RELOAD and PERF_EF_UPDATE flags break =
frequency-based unthrottling and fail to prevent context-switch =
interruption.
> --
>=20
> --- Patch [1]: [PATCH V3 1/6] powerpc/perf: Add HTM PMU driver to =
expose Hardware Trace Macro data ---
> commit e3070ea34290d3e6db9f94435894d38b1866fb0b
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data
>=20
> This commit adds a new "htm" Performance Monitoring Unit (PMU) driver =
to
> expose Hardware Trace Macro (HTM) control via the perf interface. It
> configures the trace using the H_HTM hypervisor call with a 28-bit =
packed
> event configuration. The driver tracks tracing state to manage start, =
stop,
> add, and del operations and attempts to handle hypervisor errors.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> new file mode 100644
>> index 0000000000000..4e4c924ecfd05
>> --- /dev/null
>> +++ b/arch/powerpc/perf/htm-perf.c
>=20
> [ ... ]
>=20
>> @@ -201,15 +201,6 @@ static int htm_event_init(struct perf_event =
*event)
>>=20
>> static void htm_event_start(struct perf_event *event, int flags)
>> {
>> int rc, ret, retries =3D 0;
>> struct htm_config cfg;
>> struct htm_target_id *target =3D event->pmu_private;
>>=20
>> /*
>> * Ignore context-switch re-enables. The perf core passes
>> * PERF_EF_RELOAD on context-switch-in. HTM tracing is
>> * continuous at hardware level, no hcall needed.
>> */
>> if (flags & PERF_EF_RELOAD)
>> return;
>=20
> [Severity: Medium]
> Does ignoring PERF_EF_RELOAD here break unthrottling for =
frequency-based
> events?
Thanks for all the feedback.

Frequency based attribute is not applicable for HTM pmu.
it doesn't use frequency mode,
it uses PERF_SAMPLE_RAW + AUX.=20
PERF_EF_RELOAD for unthrottling is not applicable.

>=20
> When an event opened in frequency mode is unthrottled, the core =
restarts it
> by calling event->pmu->start(event, PERF_EF_RELOAD). Will ignoring =
this flag
> leave the hardware trace permanently halted?
>=20
> Also, does ignoring this flag actually prevent context switches from =
stopping
> the hardware? Context-switch-in calls pmu->add(event, PERF_EF_START), =
which
> this driver translates to htm_event_start(event, 0), and =
context-switch-out
> calls pmu->del(event, 0), translated to htm_event_stop(event, 0). Will =
the
> hardware still be interrupted on every context switch despite these =
checks?

The driver is protected from context-switch add/del callbacks by =
.task_ctx_nr =3D perf_invalid_context.=20
perf_event_open() rejects any attempt to open an HTM event against a =
specific task .
HTM events can only be opened CPU-wide. CPU-wide events live in =
cpuctx->ctx, not task->perf_event_ctxp.=20
perf_event_context_sched_out/in() only walks task->perf_event_ctxp and =
returns immediately
if it is NULL, which it is for any task with no task-context events. =
Therefore pmu->add() and pmu->del()
Won=E2=80=99t be called on context switch for HTM events.=20

>=20
> [ ... ]
>=20
>> @@ -235,15 +235,6 @@ static void htm_event_start(struct perf_event =
*event, int flags)
>> static void htm_event_stop(struct perf_event *event, int flags)
>> {
>> int rc, ret, retries =3D 0;
>> struct htm_config cfg;
>> struct htm_target_id *target =3D event->pmu_private;
>>=20
>> /*
>> * Ignore context-switch-out stops. The perf core passes
>> * PERF_EF_UPDATE on context-switch-out. Do not stop the hcall.
>> */
>> if (flags & PERF_EF_UPDATE)
>> return;
>=20
> [Severity: Medium]
> Does ignoring PERF_EF_UPDATE here prevent the core from correctly =
stopping
> the event during dynamic frequency adjustments?
>=20
> [ ... ]
>=20
>> @@ -275,15 +275,6 @@ static void htm_event_stop(struct perf_event =
*event, int flags)
>> static int htm_event_add(struct perf_event *event, int flags)
>> {
>> int rc, ret, retries =3D 0;
>> unsigned long param1 =3D -1, param2 =3D -1;
>> struct htm_target_id *target =3D event->pmu_private;
>> struct htm_config cfg =3D target->cfg;
>>=20
>> /*
>> * pmu->add() is invoked in an atomic context with interrupts disabled
>> * and hardware context locks held. sleeping is impossible.  Only =
retry
>> * on transient H_BUSY. On H_LONG_BUSY_* (-EAGAIN) and other errors, =
the
>> * loop exits and we return -ENODEV, which is a hard failure: the perf
>> * core will not reschedule the event. Returning -EAGAIN here would =
cause
>> * the perf core to re-queue the event and call pmu->add() again on =
every
>> * context switch, flooding the hypervisor with H_HTM_OP_CONFIGURE =
hcalls
>> * exactly when it has requested a long backoff delay.
>> */
>> do {
>> rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
>>       cfg.coreindexonchip, cfg.htmtype,
>>       H_HTM_OP_CONFIGURE, param1, param2, 0);
>> ret =3D htm_return_check(rc);
>> } while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
>>=20
>> if (ret <=3D 0)
>> return -ENODEV;
>=20
> [Severity: High]
> Does returning -ENODEV here actually prevent the core from =
rescheduling the
> event?
>=20
> Looking at event_sched_in() in kernel/events/core.c, any non-zero =
return
> code from pmu->add() is overridden to -EAGAIN and the event state is =
set to
> inactive:
>=20
> kernel/events/core.c:event_sched_in() {
>    ...
>    if (event->pmu->add(event, PERF_EF_START)) {
>        perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
>        event->oncpu =3D -1;
>        ret =3D -EAGAIN;
>        goto out;
>    }
>    ...
> }
>=20
> Will this cause the multiplexing logic to retry scheduling on the next =
timer
> tick, creating an infinite loop that floods the hypervisor with =
configure
> hcalls exactly when it requested a long backoff delay?

You are correct =E2=80=94 thank you. event_sched_in() converts any =
non-zero pmu->add() return to -EAGAIN and leaves the event as =
PERF_EVENT_STATE_INACTIVE, which is eligible for mux rescheduling. The =
comment in the patch describes the intended behaviour but the mechanism =
doesn't achieve it. The fix is to return 0 and call =
perf_event_disable_inatomic() instead, which schedules a deferred =
disable that sets PERF_EVENT_STATE_OFF =E2=80=94 permanently excluded =
from the mux. We will fix this in the next revision.

Thanks
Athira


>=20
> Should this instead return 0 and call perf_event_disable_inatomic() so =
the
> core processes the disable request and marks it PERF_EVENT_STATE_OFF?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260725065942.78839-1-atrajeev@linux.ibm.c=
om?part=3D1

