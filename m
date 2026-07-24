Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356839CD14;
	Fri, 24 Jul 2026 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876213; cv=none; b=Qex/LTz70iEwdnoL0cZ/+ox+J/4j1L/WpT5bZgeBkQEizDXMrDLnaVZP/5qE6Iu3Qp1SRQ5s4m9+IfuITneyC02CdSQYGLw/pRKD7TkztCEKqplvg98VpYtRLTAlaiUSWp2lsQ3i82ydGHqRcMy0ov0mXP5iZVa9/wDsnFb2mSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876213; c=relaxed/simple;
	bh=E4o1nACX0fMHBGQfg67hBoEI53EKlE9pDcfufBrT7Qg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ACSpb+NSZyMd8AXa7Ls82JV2pQjGEr8sQd5m/YTY8UOKUtxNx+mlnBcNf5/YWx0wY+3yVKFb0fKMjW/mcLmel+x/nkgzp/h+biXeDXBOUUTELopcYpiUvbgFrENAQSzDBOfH41F2DQEwyCeyYIIEwWMxMr7g7eYygm0/5ipQ+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WRbPK/aF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WRbPK/aF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bjvb919834;
	Fri, 24 Jul 2026 06:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FOKGD2
	OdAJAqK+oZz5kgnsgDgPnNP2/mPIIZntuINWk=; b=WRbPK/aFJWIwddIXwzrKbn
	3Wcfug30Zb68qdHqSWKPpTFQPHp65sCz04F2cmw1LDpLeiopCRY1VPMCmLuPg+Kp
	SB3mETmdg328zgoWJPgHF27NfWw/g2UWIUVUuFaTdsBA59fHIeLrliwdNZDIlWaA
	hFet14oM68kAN98hfbTmWa60JshV0zZ0nnwG5GP3dlQYzEFyKBYaSuVMiNaEkkjx
	7iAAIGnRaAFk71uVdIkwEE0MgJqHjYBm7mILZsau5wtuvorP5lQQKp+tGPztOA9W
	sU+S/UUMA5Ys1CS7JZvBFG0EiO4h4XPtf4yq6fvr5xG1yO3V/nliuDw8/7KYOabg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791bexe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:56:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O6nfA4020253;
	Fri, 24 Jul 2026 06:56:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyqhr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:56:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O6umko43123144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 06:56:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6119220118;
	Fri, 24 Jul 2026 06:56:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 773B520116;
	Fri, 24 Jul 2026 06:56:47 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 06:56:47 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 1/6] powerpc/perf: Add HTM PMU driver to expose
 Hardware Trace Macro data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720110046.137431F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 12:26:28 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <51AF4901-BA6C-4141-B959-383CAB94BF6D@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-2-atrajeev@linux.ibm.com>
 <20260720110046.137431F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1wWnmqIEwIS7GaFASoKLG8Tpn-_VljQt
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a630cb3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=NSNkc0CIhrotLbplJWQA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX1924q0Vnyedr
 AO84V7CfkWPhyWUg0vkewzAG2rkmNgiC3IeEeu/KHDAHuehoe46qYpqLVPlcyFLicPRh+XYIJsr
 iu4xs/6SDzHCHi4s/JqK12yGattF+Jk=
X-Proofpoint-GUID: 1wWnmqIEwIS7GaFASoKLG8Tpn-_VljQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfXzPkciXNCjYI6
 2QY4D4lltECWuNGUMCAC5h3qGaCryOZIx5bFxAYNBlfTVD7GLex90N8YsCzEjoKUvu5KNiHpxaL
 llTx3rhUbwpnnFhuFW8yuP6cbgcgpyqT2uTz06Nbbpkp7Dy8R/AYU+2Athb+/J1vEK3+dju4Tmi
 jdzQQMrRpQEgfNieuqP4PDR/RoAW3i2aj31JfStBv8hXlMmudsed6XSFTGo8TEKSUO6iJJg0f6i
 D9bt7RmMInHWb2qZQAFOY3J+B+x7/pgMlSwPs67OopqreogeduBRKq0YnDDLKrlf2gYtagNbHF1
 QZRQTXpQI/DOyttuFmiTIC3A1fpkvr7HC3teOPkgRdwZmAgCryeoZ6MYtlWV5BYUSxEinGqBsBL
 TeR5zuILaFe+aIj7fTLERbVByPOXm9i1QAaqU4NpC7vmjaJy5xqxbvuCg91OMavU8GZBdAej5+b
 FL2oWGjQX4goMGB2h+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240059



> On 20 Jul 2026, at 4:30=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [High] Hardware Resource Leak on H_LONG_BUSY_* in Teardown Paths
> - [High] Missing Global Target Collision Detection
> - [High] Hypervisor HCALL Flooding via Misunderstood pmu->add =
Semantics
> --
>=20
> --- Patch [1]: [PATCH V2 1/6] powerpc/perf: Add HTM PMU driver to =
expose Hardware Trace Macro data ---
> commit 5f73062ed0507987b187b59e32b4100e6330618a
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data
>=20
> The H_HTM hypervisor call (hcall) provides an interface to the =
Hardware
> Trace Macro (HTM) function on POWER systems.  HTM captures =
hardware-level
> trace data for a specific node/chip/core target within a logical =
partition.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> new file mode 100644
>> index 0000000000000..5d3aa9c7fd8d1
>> --- /dev/null
>> +++ b/arch/powerpc/perf/htm-perf.c
>=20
> [ ... ]
>=20
>> +static ssize_t htm_return_check(int rc)
>> +{
>> + switch (rc) {
>> + case H_SUCCESS:
>> + case H_PARTIAL:
>> + return 1;
>> + case H_NOT_AVAILABLE:
>> + return 0;
>> + case H_BUSY:
>> + /* Transient busy: retry loop will spin up to MAX_RETRIES */
>> + return -EBUSY;
>> + case H_LONG_BUSY_ORDER_1_MSEC:
>> + case H_LONG_BUSY_ORDER_10_MSEC:
>> + case H_LONG_BUSY_ORDER_100_MSEC:
>> + case H_LONG_BUSY_ORDER_1_SEC:
>> + case H_LONG_BUSY_ORDER_10_SEC:
>> + case H_LONG_BUSY_ORDER_100_SEC:
>> + /*
>> + * Hypervisor requests a long delay before retry (1ms-100s).
>> + * Spinning in a kernel retry loop for this duration risks
>> + * deadlocks in atomic contexts.  Return -EAGAIN so callers
>> + * exit immediately; the operation will fail and userspace
>> + * can retry the perf_event_open() call.
>> + * Note: all retry loops check ret =3D=3D -EBUSY only, so
>> + * -EAGAIN exits without retrying, this is intentional.
>> + */
>> + return -EAGAIN;
>=20
> [Severity: High]
> The comment mentions that returning -EAGAIN will cause the =
perf_event_open()
> call to fail so userspace can retry. Is this accurate for paths called
> during event scheduling?
>=20
> When htm_return_check() is called from htm_event_add(), -EAGAIN is =
returned
> to the perf core's pmu->add() caller (event_sched_in). The perf core =
treats
> -EAGAIN from pmu->add as a transient scheduling failure and will =
repeatedly
> attempt to schedule the event on subsequent timer ticks or context =
switches.
>=20
> Will this flood the hypervisor with H_HTM_OP_CONFIGURE hcalls exactly =
when
> it is requesting a long backoff delay?
>=20

Thanks for the feedback
I will be sending a V3 with handles possibility of long repeated attempt =
by not using
EAGAIN

> [ ... ]
>=20
>> +static int htm_event_init(struct perf_event *event)
>> +{
>> + u64 config =3D event->attr.config;
>> + struct htm_config cfg;
>> +
>> + if (event->attr.inherit)
>> + return -EOPNOTSUPP;
>=20
> [ ... ]
>=20
>> + parse_htm_config(config, &cfg);
>> + switch (cfg.htmtype) {
>> + case HTM_CORE:
>> + case HTM_NEST:
>> + break;
>> + default:
>> + return -EINVAL;
>> + }
>> +
>> + /* Allocate per-event private state; freed via event->destroy */
>> + event->pmu_private =3D kzalloc(sizeof(struct htm_target_id), =
GFP_KERNEL);
>> + if (!event->pmu_private)
>> + return -ENOMEM;
>=20
> [Severity: High]
> Does this missing global target collision detection allow hardware =
state
> corruption?
>=20
> The driver sets PERF_PMU_CAP_EXCLUSIVE, but the perf core only =
enforces this
> within the same per-CPU context. If two users concurrently create =
events for
> the exact same HTM hardware resource (identical node/chip/core) on =
different
> CPUs, they would bypass that check.
>=20
> Without a global registry of active targets here in htm_event_init(), =
could
> conflicting hcalls be issued to the identical hardware resource, =
clobbering
> the hypervisor configuration?

I am handling this in patch 2
Will mention this specifically in V3

>=20
> [ ... ]
>=20
>> +static void htm_event_stop(struct perf_event *event, int flags)
>> +{
>> + int rc, ret, retries =3D 0;
>> + struct htm_config cfg;
>> + struct htm_target_id *target =3D event->pmu_private;
>> +
>> + /*
>> + * Ignore context-switch-out stops. The perf core passes
>> + * PERF_EF_UPDATE on context-switch-out. Do not stop the hcall.
>> + */
>> + if (flags & PERF_EF_UPDATE)
>> + return;
>> +
>> + /* Not tracing, nothing to stop */
>> + if (target->tracing_active =3D=3D HTM_TRACING_INACTIVE)
>> + return;
>> +
>> + cfg =3D target->cfg;
>> +
>> + /* Only retry on transient H_BUSY; H_LONG_BUSY_* (-EAGAIN) exits =
immediately */
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, =
cfg.nodalchipindex,
>> +       cfg.coreindexonchip, cfg.htmtype,
>> +       H_HTM_OP_STOP, 0, 0, 0);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
>=20
> [Severity: High]
> If the hypervisor returns H_LONG_BUSY_* (which maps to -EAGAIN), the =
loop
> exits immediately. Since htm_event_stop() returns void, it cannot =
defer
> the cleanup or notify the perf core. Does this permanently leave the =
trace
> started in the hypervisor?

V3 will address change to:
- best handle the fail and log the error if still any HTM =
configure/deconfigure/start/stop fails.
- Update the approach in comments too

Thanks
Athira
>=20
> [ ... ]
>=20
>> +static int htm_event_add(struct perf_event *event, int flags)
>> +{
>=20
> [ ... ]
>=20
>> + /*
>> + * Start tracing via the .start callback so the standard
>> + * PERF_EF_START / ioctl(ENABLE) path is honoured.
>> + */
>> + if (flags & PERF_EF_START) {
>> + htm_event_start(event, 0); /* flags=3D0: not a context switch */
>> + if (target->tracing_active =3D=3D HTM_TRACING_INACTIVE) {
>> + /* Start failed, deconfigure to avoid resource leak */
>> + retries =3D 0;
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex,
>> +       cfg.nodalchipindex, cfg.coreindexonchip,
>> +       cfg.htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
>> + return -EIO;
>> + }
>> + }
>> +
>> + return 0;
>> +}
>=20
> [Severity: High]
> Similar to htm_event_stop(), if H_HTM_OP_DECONFIGURE returns a long =
busy
> status here in the error rollback path, the retry loop exits =
immediately
> and returns -EIO. Does this leak the configured hypervisor resource?
>=20
>> +
>> +static void htm_event_del(struct perf_event *event, int flags)
>> +{
>> + int rc, ret, retries =3D 0;
>> + struct htm_target_id *target =3D event->pmu_private;
>> + struct htm_config cfg =3D target->cfg;
>> +
>> + /* Stop tracing, flags=3D0 so htm_event_stop issues the hcall */
>> + htm_event_stop(event, 0);
>> +
>> + /* Deconfigure */
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, =
cfg.nodalchipindex,
>> +       cfg.coreindexonchip, cfg.htmtype,
>> +       H_HTM_OP_DECONFIGURE, 0, 0, 0);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
>=20
> [Severity: High]
> If this loop exits on -EAGAIN, the resource is silently abandoned =
without
> deferring cleanup. The kernel will then free event->pmu_private during
> event->destroy. Could this result in a permanent leak of shared =
hypervisor
> HTM resources, potentially leading to a denial of service for hardware
> tracing?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720104447.11843-1-atrajeev@linux.ibm.c=
om?part=3D1

