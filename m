Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283357E9
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608638; cv=none; b=G9PNbLdRHj52wGALHLCpBrQXN5Zc3oOdYKL4QHq1ezGAIrcVCa199uh3NI1rhkQF1qW4ieaT51vIQZCg8ZRH+acY9L4gjhxGICu4WsDEt3+HBlZYmEhIV6vDb/hMs5ltrlGt8eCgiHEADmmPRoreOjfY6SMgGKtUPjpFSqFyG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608638; c=relaxed/simple;
	bh=ovshN1wx0a96KhMF9SL4r+sZ/ZF7IW6XTXVoM6eCEcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsOi17LcAJ7VFB1CIJMzrLvhkVQYVY/GPzQRVtZVElWz2VLZ5goQ4Mp0Gx2UmVp0bCzhBOn35q/RKiRSiMX/yRMuwf+8+QiwljO0hjWI8uvOoIRFSpjtEPGO4dhvBdRSvtNzOVGFwsJFsLCKSFyycOzRz6mw/uA5XeBu1bP+J8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUdWpZ4a; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUdWpZ4a"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572afdee2a8so4103a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714608635; x=1715213435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwZn/EUbFT2DPFnhsId0ig3pCxb4PHt3FC6NZeLlmsQ=;
        b=vUdWpZ4a8UQBFUrAOStD4Ajn8XzyBJNzDrlovrNNtJx0WQScXzKY8dbr2EFujfWjA2
         iAuKKnZJkdAuuq6/92NwdGel3JtXBfJj+K4PgVLW6d2HQqpoDeEVxJMfPjgF/QMnV+UR
         zzc/siVPKn7LjGR1xpUAapcvex8oxEBbs14rnAjTLtSXL/E0j6k9kGhjmZFCpyuCROxE
         AoKVD/Ko0gEJzlW1UkqWJh+4XbyMGJWzHzZdhFFSZGlsBcYNeLCyxIojAcEwiGvbTQjd
         u2pkD1G1qMNaYmIrfZYD6e7OI+CocRqX/FA/WGUeWa7UD2T6qWfcnqYb3YmRVHY0Mf4P
         Tleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714608635; x=1715213435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwZn/EUbFT2DPFnhsId0ig3pCxb4PHt3FC6NZeLlmsQ=;
        b=Q7OUVn19G2QiSO6UGaeF5OO9BdWJpftTflTs3mbfPUc/Jl9pjtlMFres4gcmpPr/YP
         9Yy+1BVXl8dlHwXCebVZ8bvQw0EDFwtwRT+ogOA9PYmEjT0o81mwHD4oMVvJudTFxF3k
         0ldykELob02rtFf17NLG4EFErIXNzTDjObYucqkCKewhQYZo+iR5xZqEOk0skOsQJlEq
         OOXHwkXPaMwc6jCuBUVUzHhNhvshM2DZHLFmOHksS+R5Bq2rZwOZbfUBaFJgwWFBtQIo
         7xEBDuqDZmJfPJCQhIhtjiQ2KLRuRJd5IEsXc9knARl5G9oYBZ+H1nnxu8CLQ/pP8VPt
         l43A==
X-Forwarded-Encrypted: i=1; AJvYcCXAUBPHMvIHVOP4Q0iqY52KtMUN6nMi6dpnNTc2W2H2OsmqebNIpTF6M1vVPPZpwzfSV02fWqGwTfYcLV7qQzmNonpZtEftkKpR/7kOUKy9lg==
X-Gm-Message-State: AOJu0Yxq7trEdCGdEyifrCOcJcwT3rZovAkl/KczD4H5+gKBY1ZnFMET
	4ygNVKDhazoiZAaCFPIMEwtYKbDME9TcJOGtlS46x3PUVOSTV08dJrGmtu9Z/nwhGWEIm6om2gJ
	gHpXzVqjIy2ObNeq9XSXRh3DU4SyYHFcL6+k=
X-Google-Smtp-Source: AGHT+IGXxESh50ssJnC6i1zqM0O1KLj5H6YYS74AtopmqIJoZqReo1GbCyMQD/hmHR26LkVeojEGMSE0nGet60ValFE=
X-Received: by 2002:a05:6402:1206:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-572bb76b9d6mr84865a12.2.1714608635272; Wed, 01 May 2024
 17:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425220509.1751260-1-yabinc@google.com> <CAM9d7cjQQ3AU7LFXYHEYukwSB9CvFQPtSzg3anfVg=maCP56AA@mail.gmail.com>
In-Reply-To: <CAM9d7cjQQ3AU7LFXYHEYukwSB9CvFQPtSzg3anfVg=maCP56AA@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Wed, 1 May 2024 17:10:23 -0700
Message-ID: <CALJ9ZPP-6bB4f4UP0Ydtsfty-PMRti_MqjZz5uazDXjuFtQsRQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Trim dyn_size if raw data is absent
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namyung,

Thanks for reviewing the patch! Fixing the callsites is a better idea.
I have sent a v2 patch with name [PATCH v2] perf/core: Save raw sample
data conditionally based on sample type.
Rejecting tracepoint events without PERF_SAMPLE_RAW will break my use
case in Android. So I hope we don't do that.

Thanks,
Yabin






On Mon, Apr 29, 2024 at 2:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Yabin,
>
> CC-ing the bpf list.
>
> On Thu, Apr 25, 2024 at 3:05=E2=80=AFPM Yabin Cui <yabinc@google.com> wro=
te:
> >
> > Currently, perf_tp_event() always allocates space for raw sample data,
> > even when the PERF_SAMPLE_RAW flag is not set. This leads to unused
> > spaces within generated sample records.
> >
> > This patch reduces dyn_size when PERF_SAMPLE_RAW is not present,
> > ensuring sample records use only the necessary amount of space.
>
> Right, it seems bpf-output and tracepoint events set the flags without
> checking PERF_SAMPLE_RAW.  Can you fix the callsites instead?
> Or we can add perf_event argument to perf_sample_save_raw_data()
> and check the flag inside.
>
> We might reject the output data when it's not opened with the flag.
> But I'm afraid it might break some existing BPF programs.
>
> Thanks,
> Namhyung
>
> >
> > Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper=
")
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> >  kernel/events/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 724e6d7e128f..d68ecdc264d3 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7688,6 +7688,10 @@ void perf_prepare_sample(struct perf_sample_data=
 *data,
> >                 data->raw =3D NULL;
> >                 data->dyn_size +=3D sizeof(u64);
> >                 data->sample_flags |=3D PERF_SAMPLE_RAW;
> > +       } else if ((data->sample_flags & ~sample_type) & PERF_SAMPLE_RA=
W) {
> > +               data->dyn_size -=3D data->raw->size + sizeof(u32);
> > +               data->raw =3D NULL;
> > +               data->sample_flags &=3D ~PERF_SAMPLE_RAW;
> >         }
> >
> >         if (filtered_sample_type & PERF_SAMPLE_BRANCH_STACK) {
> > --
> > 2.44.0.769.g3c40516874-goog
> >
