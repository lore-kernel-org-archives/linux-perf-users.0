Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E23358D1
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630734; cv=none; b=ne1//T0vz3EwbCuC3m/buGbKatHAexLklCy2WHXns94IpetW2pDO7Wznz8f726H58aXJQYz1pxcjog/zBJqHYIWybr6YbDDDljIS7LEh9eB2E7+eYC+sThYiwqJ1bAy9xS2WwM4kaRI5oQl/u1Zup4oq21BkqgFfVJX48TTQ1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630734; c=relaxed/simple;
	bh=72WxtAVZWVZaFoShtwS5ShIjKjBHOhhX3zWaleEeFc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfvwcHLusv6wDnmqyHx24qqi1XMUjH9M/vpSM/Kid+0MB6DIIsiOk8Rx90NxG3f4yMHe9YG4sciM0m/h440wqtcbADxucTvGJuhMT3PuhbJpm0uKAEHRv4mkfT7vafWx1fzqAAhhC7Cc6++jCGLbe9iLjSwxxKxGo1/z3F9YGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFN4Bvqa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tyBIXgb8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFN4Bvqa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tyBIXgb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767630730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWAk/D1swbf3R9JheCkOi2Y+A/7sdldSEEFWRTI7Edk=;
	b=PFN4BvqamTqL8G+8T3vTzdchN0FRdJ5BRBcAA6ydqa8JsZ3P74z0wRm8mnowuMGh8lxV2H
	BBppvp924TPtOifjpyL9thYDaT87OXBWtMj54oMmQPTY/sHN/TViVTsVN55RhRmpO7xNUY
	kc+B5ZqtOztDYdNqExuxhvjxN5gthd8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-J5cHsLyRP7ag-9kMsS9CWQ-1; Mon, 05 Jan 2026 11:32:09 -0500
X-MC-Unique: J5cHsLyRP7ag-9kMsS9CWQ-1
X-Mimecast-MFC-AGG-ID: J5cHsLyRP7ag-9kMsS9CWQ_1767630728
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5942c1f786aso24979e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jan 2026 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767630727; x=1768235527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWAk/D1swbf3R9JheCkOi2Y+A/7sdldSEEFWRTI7Edk=;
        b=tyBIXgb8iebhEwt4gkHyp6ZBT1+wOM1h85Eqd+/8U97m4mzEMpFCYLHYONA6g9zSBL
         nbUeTRQzQ1Nfq8Oyvy4AmqZqXs+6BWklj+gF86c8mRJDJscsryMwANbJgVNkWs3Ff5Kk
         OLwiU5WaXNJtypLgWp4Aeq8HBssjKiwrvM3Wpc2iMf79Akn8wx2MqCaN29yG2YMsy5hX
         iEcdoteZvYUXWwGFsboJzORf4tX+Ud6wv7p6tLHEr8LmdfG7YKIELwvdPGdA7B5/bJGf
         NcO04YLvu6EIlNnj7X28/IbxvmFR5zSXHP5sebKZTwG/UNEss//Mb4bQaRPD2N3z2CJj
         xLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630727; x=1768235527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWAk/D1swbf3R9JheCkOi2Y+A/7sdldSEEFWRTI7Edk=;
        b=rf4jqgOUBlxPb/Zd65L3NopjN3PHr/dZE0wb+IeTfjE5OZwtPVhsOQZAU5MLf2qRjN
         wQPTDuhjc8H2wGhrPFW+4L6yKrYumXgCJWfv5CydcsHLDWmUk521WEa1Vrbf6QNuFFZI
         59rM9xPe1hUCq4ybOK10tRgH+oREgjQp5ZhCb1oP+UfldjQyiyyR/EvY1qoA2TTgmF+z
         fsi/yFGzSRsFm0A6e9k0Z2gHVXdgD6ihZceb/13t8hHfbq2zjhaNXshYHi72bkv0qqS4
         nMjx9TQW+3PDOq2EVPEFuEe7o9Eq9sLIMLyC7igSVo5pfK5RT6oVAmnSzgFMJVTC0Oeg
         WEnA==
X-Forwarded-Encrypted: i=1; AJvYcCUsiWozbHsmTWTEOYY+iTomiyGRsfyvoyXg2AXR1xt5Ll8P7iy/PyrEMMuttaCQF8A7gSeKg8wGQmfRBBpSjRR3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/2ccqiPnBJoYwFfj2RJcQ0MkFOpevUR9sGUva9o6VOmWv0QE
	+a2r36L6qSqbtygzUkEHHeyzlXBPPOBQ8B2GndbWDMM5fyhHfcmu5SHRx4h1jWZp5wwGFGuTGFm
	gegRimiBxOeTD90hZKugktZS4Q7FZL7dq/yT+97Os3wRPf1LsdB4VUbB5Zaey3KqcJ7c/B0MSas
	jijLj1yv1i+6PEolhD5g+XH1hZ0yNK4RBUWPR81tlWws6IMA==
X-Gm-Gg: AY/fxX4T7VLrlsuW1jVMr3akwdYEzBVjQ8q1+Q7nddh6AqvqyKZhyY6y7lBMF+miRfS
	8LFAsEhsyTtwDIwXvjrn6lQ0uOXV9KdEla5lP4wADJ7Kf1xSAPNRsPEUBYT0OxdXdawIR/0Sf0X
	Jk22hRkm61ez0BWzNBOkqaQf+XVKiNqglqVwrFy0y3Hb0b3AdgiOu/+QSzhLRN6w957UgbnJmQx
	VnMGRphw4Wfgjl7T5SgRLqqhkNb
X-Received: by 2002:a05:6512:2350:b0:598:ee62:32de with SMTP id 2adb3069b0e04-59b65257e39mr117489e87.24.1767630726891;
        Mon, 05 Jan 2026 08:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0dl60w4m5VsAYidttfXbla+NufMq+G1L30F/ijcpCvejF/rWD72xkcJFb60dSmjonAQFtGqZG8c8VlfaMHiU=
X-Received: by 2002:a05:6512:2350:b0:598:ee62:32de with SMTP id
 2adb3069b0e04-59b65257e39mr117453e87.24.1767630724945; Mon, 05 Jan 2026
 08:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216211541.111795-2-ashelat@redhat.com> <96a09496-f3df-415b-95d1-92ceda06dd03@linaro.org>
In-Reply-To: <96a09496-f3df-415b-95d1-92ceda06dd03@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Mon, 5 Jan 2026 11:31:53 -0500
X-Gm-Features: AQt7F2pGSYg2YmqSHAAozDOVZexDygzuwwpZ1YHOJORLgQtVpgkFQrMWGebDkng
Message-ID: <CA+G8DhJPyXaqUz2Rz6FzmQm=GgqFSUiqei2eJa+m1+H+5_vCSw@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc/perf: Fix perf record -d sample loss on
 non-marked events
To: James Clark <james.clark@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, dapeng1.mi@linux.intel.com, mpetlan@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Wed, Dec 17, 2025 at 7:34=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/12/2025 23:15, Anubhav Shelat wrote:
> > Previously, when running "perf record -d" on powerpc, perf would drop a=
ll
> > samples that were not load or store instructions. This is because of an
> > overly aggressive check introduced in 2ffb26afa642 ("arch/powerpc/perf:
> > Check the instruction type before creating sample with perf_mem_data_sr=
c")
> > which drops samples when the SIER instruction value is considered
> > reserved (0 or 7 in ISA 3.0, and 0 in ISA 3.1).
> >
> > This happens because
> > 1) "perf record -d" sets PERF_SAMPLE_DATA_SRC for general sampling.
> > 2) When sampling non-memory instructions, the SIER instruction type is =
0.
> > 3) record_and_restart drops anything with SIER instruction type 0.
> >
> > "perf mem record" uses marked events by setting MMCRA_SAMPLE_ENABLE
> > which samples load/store instructions, so a sample with SIER instructio=
n
> > type of 0 would be an anomaly and should be dropped. So fix this issue =
by
> > loosening the check to only include marked events. For non-marked
> > events, the sample is kept and isa207_get_mem_data_src initializes
> > data_src to 0, preserving the original fix in 2ffb26afa642.
> >
> > Fixes: 2ffb26afa642 ("arch/powerpc/perf: Check the instruction type
> > before creating sample with perf_mem_data_src")
> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > ---
> >   arch/powerpc/perf/core-book3s.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-b=
ook3s.c
> > index 8b0081441f85..bd44b83db9ec 100644
> > --- a/arch/powerpc/perf/core-book3s.c
> > +++ b/arch/powerpc/perf/core-book3s.c
> > @@ -2304,10 +2304,11 @@ static void record_and_restart(struct perf_even=
t *event, unsigned long val,
> >        * In ISA v3.0 and before values "0" and "7" are considered reser=
ved.
> >        * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
> >        * Drop the sample if "type" has reserved values for this field w=
ith a
> > -      * ISA version check.
> > +      * ISA version check for marked events.
> >        */
> >       if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> > -                     ppmu->get_mem_data_src) {
> > +                     ppmu->get_mem_data_src &&
> > +                     (regs->dsisr & MMCRA_SAMPLE_ENABLE)) {
> >               val =3D (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
> >               if (val =3D=3D 0 || (val =3D=3D 7 && !cpu_has_feature(CPU=
_FTR_ARCH_31))) {
> >                       record =3D 0;
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>

