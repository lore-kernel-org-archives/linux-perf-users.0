Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E2361977;
	Fri, 24 Jul 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883082; cv=none; b=D5D0X1hhrkSRAH6PSL8lFmYEiJ4sM1/LcjBGBASkdvpypGKYdhrh7D/1GUXTD5ngljTvlNztrVjfs33tKbQOuCkCW7W0hrMIhbkmBxafTRhTipnve3SW1c/3HNpGIoeR4oNdB2IVZ2hZJF0vZmoFbKwAOqsJB8sXqERiteE1zok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883082; c=relaxed/simple;
	bh=X/pRRgf2MnCy4RgjEZuPLCYGHhBnIlSeh9RhCYlzZQ4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A3OdoLpHV1l7zF2bUU9Mo0H/q2ABeijPkltCUM8DU6MdfzM5qUJg30ZmperKPIjberR6vFldZ6cD8Tq6MT1VMOGQZFyfXOtJoS98DfXNCptSYOxiyoQjmZI7rb64j/K+I33vhwZ4eiN8vzWhfVKLMDfDctY/7NJ1Kq3gUov0b20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CUI8VOe6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CUI8VOe6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BwI2904371;
	Fri, 24 Jul 2026 08:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Sd5Blg
	l467+nUDqWKaYKvFJxK+5rfnMrBggWYh204M8=; b=CUI8VOe6Xq7Cw+ENRv4syu
	qU3k2jGp6U0riX1N+2F9W2JSK+hB/gstEKG6PhK0eiIr7LrQPKvb/nWlOrJXUZT9
	ZfLIyxrUmY6pxz8yq2BixNQ3dyn5hppAfvrqQoNQjkqAEsWokPSVaNykLUhegFqk
	ogiPTvLW+NHbUH1Mxku6YM/lxo1QBsz0ZClOdliH8awfw4hBoqOlLN3N2Cxm35Zp
	RnNk46B+/wKYiJEnTDDzp33zP3ThwZHNQym2YX1jo6Gce1jNJRB+5DKs12R5wNBh
	+GIVlzbdbpeLdzXZlIpguIELRrDlI2VCaCD4NAJIaNu1S16YsO+juwk7mMu5ZHow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abuwbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:51:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8ng2D011060;
	Fri, 24 Jul 2026 08:51:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gqyj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:51:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8pHaq39453016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:51:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99688200E7;
	Fri, 24 Jul 2026 08:51:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01BA5200F1;
	Fri, 24 Jul 2026 08:51:17 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:51:16 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 5/6] tools/perf: Add powerpc HTM auxtrace event
 processing support
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111851.C7DEF1F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 14:21:04 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E70D814F-7C31-4693-8802-1B0AC8754ABD@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-6-atrajeev@linux.ibm.com>
 <20260720111851.C7DEF1F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX4b4DL9ZvvzYb
 TpxbHtaGp2jWJQYX5Ykue1S/lvQTamp39dhFH1uGD1uSXfkU9hlBqBmop0yeCKsqGZuVKclGxCw
 912oFlBaY1WDgeRj/9+dUKh+O2qT53/b5e2uqF/Eq/8UmwCM6ZmxJ6rEtti5PqmV9jxgJ/oSxh2
 9x5ohZ5Ci+wIDjEvIhyUIsMYQlpfLSCoVcdF0KH79Z+Nepn1Wc/+5thag1HtJU+iL9vg0l3zE1G
 HXQbWkPAe5uXkSSjXJgij1zrnbCAz9lyRcmuvAGXxWpC0lnw7VqnXXNBKCkjvMW1cNdaKlM+TCn
 Mxh+mSSDBonZiQIWXmnud/5R3hVNSh4Q/UNMRftPjjh+odV8TMFNj3MRAYolrue9l1E6DLRDyYb
 A86xkGofK08fKU6bablAHIUtseyqbawnFOr6KPj7zzMhNAf6IAu+7dBaGhBeP2fa1bD+DXhEV18
 RJtgL2Gb5Y2JqaS+m7Q==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a632788 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=3Ybewh4sey4RPyLaHsYA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: lIsKrj1XryuZXkldeQcqNojOjrgAypGr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX/75cqw0m3YpX
 kCuDW6hRkrzzg+/6WtxAYp771IyZxBJJNGjq3u3VXYSxsy1flV078qkaDg5sVciUwfeS2SP1epp
 38QOM03lgiGE63/IVAXtli172/e4UOw=
X-Proofpoint-GUID: lIsKrj1XryuZXkldeQcqNojOjrgAypGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240078



> On 20 Jul 2026, at 4:48=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [Low] Implicit truncation of `__u64` to `size_t` on 32-bit =
architectures.
> - [Low] The `auxtrace_type` field in `struct powerpc_htm` is declared =
but never initialized.
> --
>=20
> --- Patch [5]: [PATCH V2 5/6] tools/perf: Add powerpc HTM auxtrace =
event processing support ---
> commit 87b8929025f59e2555a76806a3d33736b3cb7f18
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add powerpc HTM auxtrace event processing support
>=20
> This commit adds the PERF_AUXTRACE_POWERPC_HTM enum value to =
auxtrace.h and
> wires the dispatch in perf_event__process_auxtrace_info() to call
> powerpc_htm_process_auxtrace_info(). It also sets the =
auxtrace_info->type
> in htm_info_fill().
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> new file mode 100644
>> index 0000000000000..8d28d02031d6e
>> --- /dev/null
>> +++ b/tools/perf/util/powerpc-htm.c
>> @@ -0,0 +1,115 @@
> [ ... ]
>> +static void powerpc_htm_dump_event(size_t len)
>> +{
>> + const char *color =3D PERF_COLOR_BLUE;
>> +
>> + if (dump_trace) {
>> + color_fprintf(stdout, color,
>> + ". ... HTM PMU data: size %zu bytes\n", len);
>> + }
>> +}
> [ ... ]
>> +static int powerpc_htm_process_auxtrace_event(struct perf_session =
*session __maybe_unused,
>> +      union perf_event *event,
>> +      const struct perf_tool *tool __maybe_unused)
>> +{
>> + if (dump_trace)
>> + powerpc_htm_dump_event(event->auxtrace.size);
>=20
> [Severity: Low]
> Does this implicitly truncate event->auxtrace.size on 32-bit =
architectures?
>=20
> event->auxtrace.size is a __u64, but powerpc_htm_dump_event() accepts =
a
> size_t. This isn't a critical bug since it's only used for debug =
output,
> but could it result in printing a truncated size if the trace exceeds =
4GB?
Ok, will fix this in V3

Thanks
Athira
>=20
>> +
>> + return 0;
>> +}
> [ ... ]
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
>=20
> [Severity: Low]
> Is htm->auxtrace_type intentionally left uninitialized here?
>=20
> It is declared in struct powerpc_htm, but unlike other fields, it is =
not
> assigned auxtrace_info->type after the allocation.
>=20

The type will be set in patch 6

>> + htm->auxtrace.process_event =3D powerpc_htm_process_event;
>> + htm->auxtrace.process_auxtrace_event =3D =
powerpc_htm_process_auxtrace_event;
>> + htm->auxtrace.flush_events =3D powerpc_htm_flush;
>> + htm->auxtrace.free_events =3D powerpc_htm_free_events;
>> + htm->auxtrace.free =3D powerpc_htm_free;
>> + session->auxtrace =3D &htm->auxtrace;
>> +
>> + return 0;
>> +}
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720105218.14277-1-atrajeev@linux.ibm.c=
om?part=3D5

