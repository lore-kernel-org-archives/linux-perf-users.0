Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795554021;
	b=MnZMng7F/tnmK7PAik93swdzOUKwop2BPDG3Y9YsyIpekCtWpqkBeLJRhZCSwdXW4ta1
	 bxq5knTAN2rAPoUHs4JKE07uU0P1Xr78rd5tMZKZjA5Zg3s/AzQzJLPAXTLiOQPz06Msq
	 6zVm7KcDEzkLWuV8kZAo7i3u0U6w1+zonteQbBEjdtqay1uEjL5llUjlUXgrLAni9iJid
	 Maa7P0srpmjwN1x1aacQ5iQYnc1y9yGg0hq2elhWQvnFKQ9yIJ3VIOCkaP5g7IjT2jce8
	 +AyKhs2gsxEKU8wAZhbpEh/cl1yW6dW2Ds/fhS36eXRBFRDCWzWIB+1NcJODOfHkzCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
	b=yos/IOn+DwWH6jDlYPA2T0wBtsRCr7dY2Toneh0TQvyXfsW48bYFYAjfqNslmJp3Sn4E
	 jT/xTRMcSihUStEEy1gGoUZVfanYPR78HhEEKDW+hLD9LMmKanwJDZxZLw3Ptmw34YnEi
	 J8FJFWnGKfmbSDRcfJLfbtrUrE2KzsIrDyglJXcgJkaDEV5XpzlExNZTWOitgDSQMTddt
	 +nwHiI/TH2rjgJ4BlY5+e7vgU/QR2cc9iwu5HgEXSWnyhpPNeTUWl+kvFLaKgQ+FqnsZI
	 hlvhZm/lb7ezkOIYeMd2L0qFR19OPsJ96DR0Ik/PJGrKknCMkVS+Q536WcLMwlL7cGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GJtYiR3R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CD606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4CD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GJtYiR3R
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55be673e029so949231cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 13:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795554020; cv=none;
        d=google.com; s=arc-20260327;
        b=MMduVx96OsJBwXDRs96n4IVVgHqdyrxfxNYfzSdCHmuvXFmo39yIHO0T92HzGw0thR
         HGVKy/MARBbPvXa5fd/y9J7kiytvybkGxzYtc29ndbAYdCOgR2wBgdZ9anu4m2YXwoPK
         t+pqfxNDdRblVAurcEGlDu19cPC/PFMp5V7sYZxDiGF+45Bn9k8WkGJR75/gJyrUO7m2
         v4V9/vn4nsA/7tXfMH7V7jH15RnbScJ5ykuMNp0sx81g6WbaDDPtxpuwI+8O9Hd2H2yW
         OCKw3pe+hqlSFH70ov94rgV0WinPdNFDNHHo1U12fmkkk+V63JxyCjwdFdYhEFRvgSHA
         qLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
        fh=Nm33FLGiDkMhtFXWDktFbN8tVMIj2mEaqHtdhKoHAH8=;
        b=iMBWJiMPO3+Se5t37e6GVIcytADZhpT+Jxr6oI0C05rKH6Zr4WTcX2hrhVT/NgTJpn
         zgjpK3SU6A5aaU8uYp9DVrp9RL2b/gm8X1vHD4barOGpVxu2WwsO+l7fPU/rLXiLHxEZ
         kUbLh3HYB6J927uvX2pTN54a17++Qpk+EeBsRZHq2qhLLcCJqiU3m7oJiAWvD/D9pqKv
         iX1LlV4ZOjEuFOhhqgP0Zfarx0csHqHZg1R1zdxjf1qAhmBWgAH3tRmvaYj2vtnyYwYx
         Fau1Jax0dLoD0Xk8LhX3l+mdZU0rXxkNpvTsjV0woatbW1K4HVzqwU1kYFI4xVHyjZMm
         PvKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795554020; x=1796158820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
        b=GJtYiR3Rp5d21pM1eit1vwUjg9DtAdTjyG73Eec1SXS8BjdFWzjBUE6l7LyjFkaogd
         ht9d4ym8UqcALr/3fAivC1esY0lcWUgDVVOyCf81+iRnF3d8eJ6msirInV+doCr1kC+1
         49h2xbv1EAB5ji716yA6/GUt55bq21BFn1OWaGUGU/u4022/6YXWZwy5FDsVK6DZ4MnP
         iBnlkQhXKrJJGwlc9KINKAuOT5bjkIShsmF5bj14/OKxy4gwENJl+4nwMXCkHd6cQ5nm
         cgrOEQeida4AdPc4A7aUHteS33n8Rn8rKspbnnZcj/V9xZErVGt7g4UsH+cKbb9RxUPU
         KLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554020; x=1796158820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lR8uZlGrdT5E7Fg86uJus+YwC92m7WGmkDym3E/bOzM=;
        b=mcD2gRJPsNbOOZxJ11hk3ElIb0cmKrsV161Rt2HOIaHF7pUVzp3jF0HNuTUKVspoTB
         SjYWUE/+syMO8ZEkAr3UBjStY69EgjdLVL3Us0dQ23WihMUA/XwdY/Xl6/9DRXFrMMeo
         xRG7dibBnUxWGvypW+yibZFuFDRIcIdNdRkS0WE6vTzo88Hb+Aoh/Zy5OukyEDAonxm0
         l96/n7qNcn6MsrG3JHNZuIxMg1ZJOOuyn/Pa8twD2v3EXbSjWQ0ZW/dbFIUzJJAthBnB
         SXCCbZkxHbqT/6jaTd18t/Jt1Nsx4xD7viWmljxDzWPYO4h/qvEP+qepXD1GzuwCY+NP
         2wwg==
X-Forwarded-Encrypted: i=1; AL+hErE/zK0mULXigSbZf+2HA0xgPLV7WrX/ZR1sn1r6gS9b5iFZueOwezwKND6QMjKwrhlskLkonlzp5lhCqPipEFkY@vger.kernel.org
X-Gm-Message-State: APuU4Z+HP1YA5ae1qMsR5W6+cjGUw3Sf8ib7lJVsDR0Tl9JyCfalnxww
	KXRrDvUGH/i5XhKref8Tf8tLKU2YhHqnAHfm/H/hBkPRLWhx86NUlQY4ZicslgLiGnuZJEt6Dtx
	tI6N++9QxIgouIHteF5baUKZQl3lbVxG0H9IsBHTU
X-Gm-Gg: AZFdTZfE2AilPM0Lt8htGNXcogI38LmiF6KPO8yAEilJp/kkf5N5Bff6Sf2PTSnZozd
	/cytSRiJAPk2MpbtdjHQmFcqJ+n0VROg8cKRAHXNZh1yCmrpmCjTKc5VQzgBf37JjBSf85v++3P
	cMIdsEbUQLgp53Ly1OPgIGegCOoC9LScdJ8+6qun5aeek5QDqk9YotqyRoC76G82tp13RHKqIbi
	le89G40V66Do2seEfWMe/oRmJhgQ50wRQ6brHigVjSOH2+dPdg9mSK6CtGMxllXPT8H5t7xoWR3
	qOS7OvKwb5vdyfRxiAH7TXTVLRN3FcB7t60TaTcnznRbfmzink0X+rOeSQMbWgF9R3OJsm4bINb
	OLmcgJIHOLX31+eVQiFrMl8+ctjl8G9jllD8tIgLorNA/jKqh/FB4tD6Uc/gEZ7Ienn8=
X-Received: by 2002:ac8:6f05:0:b0:55d:74e6:e03 with SMTP id
 d75a77b69052e-55d87eb573emr70187881cf.0.1795554018819; Tue, 24 Nov 2026
 13:00:18 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com> <20261116074414.3174737-4-irogers@google.com>
 <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
In-Reply-To: <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Nov 2026 13:00:06 -0800
X-Gm-Features: Aa3M54pdXM1oIOYL32K8_t7w7fCY8XhU-lLpLLFWOFQ3DDBOcdGlds-hyc2pHCM
Message-ID: <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to UAPI
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:36=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 16 Nov 2026, at 1:13=E2=80=AFPM, Ian Rogers <irogers@google.com> wro=
te:
> >
> > Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> > PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> >
> > For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> > PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> > set), encode a deduplicated table of variable-length build IDs
> > (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> > u8 data[size]; } entries padded to 8-byte alignment) and an array of
> > 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> > 0x00 for unresolved user addresses and 0xff for kernel/context entries)=
.
> > In common cases where multiple callchain frames belong to the same
> > binary, each unique build ID is encoded only once.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
> > 1 file changed, 54 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_=
event.h
> > index deb7c42d109b..775420ed9aee 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -165,8 +165,10 @@ enum perf_event_sample_format {
> > PERF_SAMPLE_DATA_PAGE_SIZE =3D 1U << 22,
> > PERF_SAMPLE_CODE_PAGE_SIZE =3D 1U << 23,
> > PERF_SAMPLE_WEIGHT_STRUCT =3D 1U << 24,
> > + PERF_SAMPLE_BUILD_ID_OFFSET =3D 1U << 25,
> > + PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET =3D 1U << 26,
> >
> > - PERF_SAMPLE_MAX =3D 1U << 25, /* non-ABI */
> > + PERF_SAMPLE_MAX =3D 1U << 27, /* non-ABI */
> > };
> >
> > #define PERF_SAMPLE_WEIGHT_TYPE (PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGH=
T_STRUCT)
> > @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
> >  *
> >  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precis=
e events
> >  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> > - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> > + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
> > + *                                         PERF_RECORD_CALLCHAIN_DEFER=
RED events
> >  *
> >  *
> >  * PERF_RECORD_MISC_EXACT_IP:
> > @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
> >  *   Indicates that thread was preempted in TASK_RUNNING state.
> >  *
> >  * PERF_RECORD_MISC_MMAP_BUILD_ID:
> > - *   Indicates that mmap2 event carries build ID data.
> > + *   Indicates that mmap2 or deferred callchain event carries build ID=
 data.
> >  */
> > #define PERF_RECORD_MISC_EXACT_IP (1 << 14)
> > #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT (1 << 14)
> > @@ -1095,6 +1098,38 @@ enum perf_event_type {
> > * { u64 code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
> > * { u64 size;
> > *  char data[size]; } && PERF_SAMPLE_AUX
> > + * { union {
> > + * struct {
> > + * struct perf_build_id bid;
> > + * u64 offset;
> > + * };
> > + * struct {
> > + * u64 zero;
> > + * u64 context;
> > + * u64 cookie;
> > + * u64 ip;
> > + * }; && attr.defer_callchain
> > + *  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
> > + * { u32 nr_build_ids;
> > + *  u32 nr_offsets;
> > + *  struct {
> > + * u8 size;
> > + * u8 data[size];
> > + *  }[nr_build_ids];
> > + *  u8 pad[];
> > + *  u64 offsets[nr_offsets];
> > + *  #
> > + *  # Entries in offsets[] include PERF_CONTEXT_* markers (which
> > + *  # have top 8 bits 0xff). Kernel/hypervisor entries (after
> > + *  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
> > + *  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
> > + *  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
> > + *  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
> > + *  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
> > + *  # encode a 1-based index (1..254) into the build_ids table and
> > + *  # the lower 56 bits for the DSO file offset, or 0x00 for an
> > + *  # unresolved user virtual address.
>
> Hi Ian,
>
> On PERF_SAMPLE_BUILD_ID_OFFSET, the layout comment doesn't say what is
> written in the non-resolved cases. For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFF=
SET
> it is clear: kernel entries are raw 64-bit values, unresolved user entrie=
s
> have 0x00 in the top byte, and resolved user entries carry the table inde=
x
> and the 56-bit file offset.
>
> For the PERF_SAMPLE_BUILD_ID_OFFSET form, could the comment state:
>
>  - What is written for a kernel IP? (e.g. bid.size =3D=3D 0 and offset =
=3D=3D raw IP?)
>  - What is written for an unresolved user IP? If bid.size =3D=3D 0, does
>    =E2=80=9Coffset=E2=80=9D hold the raw virtual address?

Yes, in both non-user (e.g. kernel/hypervisor) and unresolved user IP
cases, bid is zeroed (bid.size =3D=3D 0) and offset holds the raw
instruction pointer / virtual address. When attr.defer_callchain
defers a user IP, the union carries zero =3D=3D 0 (so bid.size =3D=3D 0),
context =3D=3D PERF_CONTEXT_USER_DEFERRED, the stitching cookie, and the
raw user IP.

I've expanded the PERF_SAMPLE_BUILD_ID_OFFSET comment in Patch 03 for
v4 to explicitly document all of these cases.

Thanks,
Ian

> Thanks,
> Athira
>
>
> > + * } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
> > * };
> > */
> > PERF_RECORD_SAMPLE =3D 9,
> > @@ -1306,8 +1341,22 @@ enum perf_event_type {
> > * struct {
> > * struct perf_event_header header;
> > * u64 cookie;
> > - * u64 nr;
> > - * u64 ips[nr];
> > + * union {
> > + * struct {
> > + * u64 nr;
> > + * u64 ips[nr];
> > + * };
> > + * struct {
> > + * u32 nr_build_ids;
> > + * u32 nr_offsets;
> > + * struct {
> > + * u8 size;
> > + * u8 data[size];
> > + * }[nr_build_ids];
> > + * u8 pad[];
> > + * u64 offsets[nr_offsets];
> > + * }; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
> > + * };
> > * struct sample_id sample_id;
> > * };
> > */
> > --
> > 2.56.1.703.gf848ed807c-goog
> >
> >
>
