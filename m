Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E83BF689
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027354; cv=pass; b=I+I4iKXWJGJ2AhrRAC7XpautrRYyM/oUPUayK1JWhwO5Ob73UC2Idp6CoCp8gVB+UoNQKAV7XzteFnJ44fG3V5ozAGDGnk3Ctt9j7/LeQQ7TMWCfXVStt6XQy35PfbP1SlCfvypDuws3k282ok5yQdGsJJ9brdukrMsRQ9EHjnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027354; c=relaxed/simple;
	bh=j+01ydAtRI8DHadPciUjhKOMH6chUdmVtiPy0zraNZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnpXe3CxhZC8goUfSrMd3buQBECCtBrwk6HZNkxx13dgT0xGJHPwZire9eutvvfj8EKu7p26qTxN8TKj+pvItPI0gpsVUHg0QQB4JK7H955OjrDVosnaha1vtdsj6dg1pWkCXBuGmxXMkfdTLmv7crDd3n+SIM4XlHvL0owbYXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iuhznmj0; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iuhznmj0"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so91951cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787027351; cv=none;
        d=google.com; s=arc-20260327;
        b=i9JSm9BFsrxPgZSO4lcj66zGPWYpd0ewyp8hfnRE6Ddahbzl+81Ugfum9IJzPKbaz5
         gdzsaht5EOvtI5EOmyVmxBozuTxbY5TXTSOyeclKkWoYwtBJGUH1Ib04ywaIuCtqTKAG
         RE37BvoUHg8gR02XsVTCxgKXXBp82pMpaQcGWIm/bafF5nOrd4DeTbWafU3ib34/mtJG
         Znh3DlV/mEHcQe9tPN1ujX7buLcIgUElaxJ2asA2GHO1w3IXAUw1xIia+DFHYoAaXs5k
         NXB5LCx/yppP+3bvkfSoNsS1v85tVaFQLmFiveH7zIkba6K3ChyhYjXtvuQIUsTQQ/DJ
         yjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZkZLzIxyThcC4GHLxCxBhaWRICfBEvejtPlUSSGma0=;
        fh=Dfyg69OKeT+kywOQZi3fEk/ctmi518QaTII846MwKbE=;
        b=nnY7q9MNRNavJlO4/NM9zYQum2P5ZNm8ZQKLKP2k/bEPI5Nm8lPJsnbqTmhcl1erwW
         G5FAMjlfgxFXBOnhxYhsWq8YJPL+yNWEUfxGyEIiTNSt2HwsJhfsBtK+iNFTUAfyWA/t
         2wchuDso/L1CvjRvBKaAe9x2+8vu3IFL1YHobSUHtBCg4H22QTRDsx3LCgDvPDcmZJnA
         V+lBE8cBq7EwEavgW1nG6qsY9vgrXOqBJbE803p0WnH6PucOROxD1w8qOH2IN9lYSYbX
         92XlirbAOUadfzbCX1VuEQ6FekVkUV7rWrHHUk2EgJQACsVii4kwiJtJUVTiy62uv5mS
         OEIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787027351; x=1787632151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZkZLzIxyThcC4GHLxCxBhaWRICfBEvejtPlUSSGma0=;
        b=Iuhznmj0lrOt6g4lmKxyFqEf718vV5XM/FHgFfk2tFml3tIS4IEsIZpA+QGNYXD6FU
         ClqO0M1BTnSjl/88HmT1XTNbqLY0I9qAAEK7NQqwA1VKJ/+s/n/VkuN3DQUwXTqNquBh
         tnpvG9nOR76fDFyVjzHLKJM4h4+MozDfdWMlZhygP0AhAOlvMhkAN4blAQ9otHqemH5E
         lbPpQxrMUj+DdtJg+zKt/k1AndEoyHL17Ms8TVfmFjobnYjHotfca6QdjilI08bhROZZ
         a0YkLyPBBzKLSdkZ3ZmfJ978UKJn+JtO2RU0WthNRN/1saDJ9re98K0Ttt39Fqzm6TcC
         Ptsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027351; x=1787632151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZkZLzIxyThcC4GHLxCxBhaWRICfBEvejtPlUSSGma0=;
        b=BoumovrMLgEyxZ9dP5CxRpNMMfz0M7Qdjce8KugkS3YRZ3GHyvSU+yZ37mLCzm9KcP
         Sc+WuzSMugeABCqpomAwb1PDzTnrJthQLo84UndwL9Wz2QDG7EiSbSW6vMJ3w7xMjDN9
         YzHVG7PGCHlcBghHVUaZVj1wp18K/S9NL7oGhULRb0Sx9IzSqorzLVvguUiVOOulPlF0
         HVJ7P69WC8CnIUu2HmXYPA7q56pYe5WkFlG0jvkjD6q6wyI3/SJOSjV2/dts8+QKExU4
         irj/xIQ5aq9P86v5dqzL5CId/NJNIv1hHIF1slqKosp/ODAaVe856GkZsfinPz7q9LP7
         GMhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsBQ8nCPBhpkofEknTE9svWTH0EgWtpP985aXa18HPuxwbKhcy9lOJ0fWSHJp16JpP0z7pS8m4eLMgAI4veLTr@vger.kernel.org
X-Gm-Message-State: AOJu0YzqB5UKDlr/Em8m5YYlviQUYDbRtj1mZ6ualg3EuYxVjENGCqKD
	ZM4T1Di9rcyYf/+Vfd/pzcFHapnB6Cg73agc/ebchEoPifdsMqWTuJfgg8S8Pd5od3etDzAqzyR
	5xAk5yFO3+KStdOgotIM1h23LXW3LcSEyDrKUSI8M
X-Gm-Gg: AR+sD12QUhhJRXfj6862jD5rNCD7ce5LqZ+LbIgAuxOxOw7nY06mrftBXmzyhugp5X1
	z2pd+4EKENC7hqY/SG5mZ1Hr3sYz5S4Eq5Aceb3wF+DrL9JS6oOiYkEdPoaZ0rMDuMh1nhU9A7a
	j5YQXdt0+lCCqRp1p9jJhyWzu8ohSbF1fVHgwqlVGob1Mzir9rev98W7L64KQceB4gn3+lsJ4/6
	N3Y5MZ1M7WaEAzhRWtdDxTtbBm1u/vvQJfXR+t3gmD7tivhAfxApA6/oaxps1rX/cZ0oD9/IZ5u
	6Ljt7EpWTxUhS1Mm8OSgckcRD7H7dJKcB/i2XUztoY1DtQ==
X-Received: by 2002:ac8:6905:0:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52dc60e1294mr5153071cf.13.1787027350021; Mon, 17 Aug 2026
 21:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065606.27532-1-liuqi@hygon.cn> <20260804065606.27532-3-liuqi@hygon.cn>
 <CAP-5=fX0nXLsMZMRYb9PHd=OF47BG9RVDPBxnsoFg=yM9NgWOg@mail.gmail.com> <7694c07c-cfa8-4b5e-a2e4-046f8df94a3a@hygon.cn>
In-Reply-To: <7694c07c-cfa8-4b5e-a2e4-046f8df94a3a@hygon.cn>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 21:28:58 -0700
X-Gm-Features: AcwNN1XSO2OFVjETvIgJ_V00yUGSsTN34Ksp03hwdeVdBZXjXHA-PyIHue0W7io
Message-ID: <CAP-5=fUWh_1WnMuGV7KO2DB1xdzfxuTuE1KG_e-KS+nqB3t=VA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] perf vendor events hygon: Add Hygon Data Fabric
 PMU events and metrics
To: Qi Liu <liuqi@hygon.cn>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, sandipan.das@amd.com, 
	ravi.bangoria@amd.com, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lijing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 8:12=E2=80=AFPM Qi Liu <liuqi@hygon.cn> wrote:
> Hi Ian=EF=BC=8C
>
> Thanks for your reply:)
>
> On 8/18/2026 6:12 AM, Ian Rogers wrote:
> > On Tue, Aug 4, 2026 at 12:00=E2=80=AFAM Qi Liu <liuqi@hygon.cn> wrote:
> >>
> >> Add perf JSON event definitions and metrics for the Hygon Data Fabric =
(DF)
> >> uncore PMU.
> >>
> >> Signed-off-by: Qi Liu <liuqi@hygon.cn>
> >> ---
> >>   tools/perf/pmu-events/Build                   |   2 +-
> >>   .../arch/x86/hygonm1/data-fabric.json         |  87 ++++++++++
> >>   .../arch/x86/hygonm4/data-fabric.json         | 122 ++++++++++++++
> >>   .../arch/x86/hygonm6/data-fabric.json         | 154 ++++++++++++++++=
++
> >>   tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
> >>   tools/perf/pmu-events/jevents.py              |   2 +
> >>   6 files changed, 369 insertions(+), 1 deletion(-)
> >>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabri=
c.json
> >>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabri=
c.json
> >>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabri=
c.json
> >>
> >> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> >> index 372773b998e4..79a9b4cad202 100644
> >> --- a/tools/perf/pmu-events/Build
> >> +++ b/tools/perf/pmu-events/Build
> >> @@ -95,7 +95,7 @@ endif
> >>
> >>   ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
> >>   # Generate Intel Json
> >> -INTELS :=3D $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -=
v mapfile.csv)
> >> +INTELS :=3D $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -=
v hygon|grep -v mapfile.csv)
> >>   INTEL_METRICS =3D $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.=
json)
> >>   INTEL_METRICGROUPS =3D $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-met=
ricgroups.json)
> >>   GEN_JSON +=3D $(INTEL_METRICS) $(INTEL_METRICGROUPS)
> >> diff --git a/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json b=
/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
> >> new file mode 100644
> >> index 000000000000..99c243bd9ba0
> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
> >> @@ -0,0 +1,87 @@
> >> +[
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_0",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS0",
> >
> > Does "Data (64B)" mean that each count should be scaled by 64 and the
> > units are bytes? In which case adding:
> > "ScaleUnit": "64Bytes",
> > Would cause the count to be multiplied by 64 in the perf stat output
> > and the unit Bytes to be added.
> >
> Thank you for pointing this out. Yes, for these CPU memory-request events=
, Data
> (64B) means that each count represents a 64-byte data unit. I will add
> "ScaleUnit": "64Bytes" so that perf stat reports the scaled value in Byte=
s.
>
> The I/O request events are different: each request may carry either 32B o=
r 64B,
> so I will keep those unscaled and retain the separate minimum/maximum ban=
dwidth
> metrics.

Sounds good to me. Fwiw, in other drivers I've scaled by 64 and then
when the bandwidth is below expectations the explanation are 32B
requests.

> > Would it be possible to define terms like CS0?
> Thank you. I will replace uses such as CS0 with Coherent Slave 0 (CS0) in=
 the
> event descriptions.

Thanks for adding the definition! The Linux coding style advocates
against adding new usage of the term slave:
https://www.kernel.org/doc/Documentation/process/coding-style.rst
Maybe subordinate to keep the initials the same.

> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_1",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS1",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_0",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS0",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_1",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS1",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_0",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS0",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_1",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS1",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_0",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS0",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_1",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS1",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "MetricName": "cpu_memory_bandwidth",
> >> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 +=
 cpu_write_requests_cs_0 + cpu_write_requests_cs_1) * 64 / (duration_time *=
 1e6)",
> >> +    "BriefDescription": "Total CPU memory access bandwidth",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  },
> >> +  {
> >> +    "MetricName": "io_memory_max_bandwidth",
> >> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + i=
o_write_requests_cs_0 + io_write_requests_cs_1) * 64 / (duration_time * 1e6=
)",
> >> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth =
(upper bound, assuming 64B per request. Actual inbound I/O requests may be =
32B or 64B)",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  },
> >> +  {
> >> +    "MetricName": "io_memory_min_bandwidth",
> >> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + i=
o_write_requests_cs_0 + io_write_requests_cs_1) * 32 / (duration_time * 1e6=
)",
> >> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth =
(lower bound, assuming 32B per request. Actual inbound I/O requests may be =
32B or 64B)",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  }
> >> +]
> >> diff --git a/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json b=
/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
> >> new file mode 100644
> >> index 000000000000..f32dcea7061c
> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
> >> @@ -0,0 +1,122 @@
> >> +[
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_0",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS0",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_1",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS1",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_2",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS2",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_0",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS0",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_1",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS1",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_2",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS2",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_0",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS0",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_1",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS1",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_2",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS2",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_0",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS0",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_1",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS1",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_2",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS2",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "MetricName": "cpu_memory_bandwidth",
> >> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 +=
 cpu_read_requests_cs_2 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1=
 + cpu_write_requests_cs_2) * 64 / (duration_time * 1e6)",
> >> +    "MetricConstraint": "NO_GROUP_EVENTS",
> >> +    "BriefDescription": "Total CPU memory access bandwidth",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  },
> >> +  {
> >> +    "MetricName": "io_memory_max_bandwidth",
> >> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + i=
o_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io=
_write_requests_cs_2) * 64 / (duration_time * 1e6)",
> >> +    "MetricConstraint": "NO_GROUP_EVENTS",
> >> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth =
(upper bound, assuming 64B per request. Actual inbound I/O requests may be =
32B or 64B)",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  },
> >> +  {
> >> +    "MetricName": "io_memory_min_bandwidth",
> >> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + i=
o_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io=
_write_requests_cs_2) * 32 / (duration_time * 1e6)",
> >> +    "MetricConstraint": "NO_GROUP_EVENTS",
> >> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth =
(lower bound, assuming 32B per request. Actual inbound I/O requests may be =
32B or 64B)",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  }
> >> +]
> >> diff --git a/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json b=
/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> >> new file mode 100644
> >> index 000000000000..bff5c0959d82
> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> >> @@ -0,0 +1,154 @@
> >> +[
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_0",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS0",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_1",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS1",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_2",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS2",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_read_requests_cs_3",
> >> +    "BriefDescription": "The number of CPU read requests to memory: D=
ata (64B): CS3",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x07",
> >> +    "ConstId": "0x3",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_0",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS0",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_1",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS1",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_2",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS2",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "cpu_write_requests_cs_3",
> >> +    "BriefDescription": "The number of CPU write requests to memory: =
Data (64B): CS3",
> >> +    "EventCode": "0x2",
> >> +    "UMask": "0x08",
> >> +    "ConstId": "0x3",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_0",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS0",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_1",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS1",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_2",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS2",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_read_requests_cs_3",
> >> +    "BriefDescription": "The number of inbound I/O read requests to m=
emory: Data (32B or 64B): CS3",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x0F",
> >> +    "ConstId": "0x3",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_0",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS0",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x0",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_1",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS1",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x1",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_2",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS2",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x2",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "EventName": "io_write_requests_cs_3",
> >> +    "BriefDescription": "The number of inbound I/O write requests to =
memory: Data (32B or 64B): CS3",
> >> +    "EventCode": "0x3",
> >> +    "UMask": "0x70",
> >> +    "ConstId": "0x3",
> >> +    "Unit": "HYGON_DF"
> >> +  },
> >> +  {
> >> +    "MetricName": "cpu_memory_bandwidth",
> >> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 +=
 cpu_read_requests_cs_2 + cpu_read_requests_cs_3 + cpu_write_requests_cs_0 =
+ cpu_write_requests_cs_1 + cpu_write_requests_cs_2 + cpu_write_requests_cs=
_3) * 64 / (duration_time * 1e6)",
> >> +    "MetricConstraint": "NO_GROUP_EVENTS",
> >> +    "BriefDescription": "Total CPU memory access bandwidth",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  },
> >> +  {
> >> +    "MetricName": "io_memory_max_bandwidth",
> >> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + i=
o_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_=
write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 64=
 / (duration_time * 1e6)",
> >> +    "MetricConstraint": "NO_GROUP_EVENTS",
> >> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth =
(upper bound, assuming 64B per request. Actual inbound I/O requests may be =
32B or 64B)",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  },
> >> +  {
> >> +    "MetricName": "io_memory_min_bandwidth",
> >> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + i=
o_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_=
write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 32=
 / (duration_time * 1e6)",
> >> +    "MetricConstraint": "NO_GROUP_EVENTS",
> >> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth =
(lower bound, assuming 32B per request. Actual inbound I/O requests may be =
32B or 64B)",
> >> +    "MetricGroup": "DF_Memory_BW",
> >> +    "ScaleUnit": "1MB/s"
> >> +  }
> >> +]
> >> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/p=
mu-events/arch/x86/mapfile.csv
> >> index 50a403b429b1..ba17117245d1 100644
> >> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> >> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> >> @@ -45,3 +45,6 @@ AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,=
amdzen3,core
> >>   AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
> >>   AuthenticAMD-26-([12467][[:xdigit:]]|[[:xdigit:]]),v1,amdzen5,core
> >>   AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen6,core
> >> +HygonGenuine-24-[0123],v1,hygonm1,core
> >> +HygonGenuine-24-[45],v1,hygonm4,core
> >> +HygonGenuine-24-(1[012345678]|[6789ABCDEF]),v1,hygonm6,core
> >> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/=
jevents.py
> >> index 376dc2d24162..63ae3a763a4f 100755
> >> --- a/tools/perf/pmu-events/jevents.py
> >> +++ b/tools/perf/pmu-events/jevents.py
> >> @@ -294,6 +294,7 @@ class JsonEvent:
> >>             'L3PMC': 'amd_l3',
> >>             'DFPMC': 'amd_df',
> >>             'UMCPMC': 'amd_umc',
> >> +          'HYGON_DF': 'hygon_df',
> >>             'cpu_core': 'cpu_core',
> >>             'cpu_atom': 'cpu_atom',
> >>             'ali_drw': 'ali_drw',
> >> @@ -390,6 +391,7 @@ class JsonEvent:
> >>           ('Invert', 'inv=3D'),
> >>           ('SampleAfterValue', 'period=3D'),
> >>           ('UMask', 'umask=3D'),
> >> +        ('ConstId', 'constid=3D'),
> >
> > Is Const a shortening of Constant? It seems a little redundant in the
> > format name. Would CsId be more intention revealing? I don't know what
> > CS means, but this at least looks a little more intuitive to me than
> > Constant :-)
> >
> Thank you for the suggestion. ConstId stands for Component Select ID. It
> identifies the selected Data Fabric component instance, and I agree that =
the
> current name is not particularly intuitive. I will rename it to CompId
> (Component ID) in the next revision.

Many thanks!
Ian

> Thanks,
> Qi> Thanks,
> > Ian
> >
> >>           ('NodeType', 'type=3D'),
> >>           ('RdWrMask', 'rdwrmask=3D'),
> >>           ('EnAllCores', 'enallcores=3D'),
> >> --
> >> 2.34.1
> >>
> >>
> >>
> >
>
>
