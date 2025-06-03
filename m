Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965171F4297
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986089; cv=none; b=PXVwaXMpdzCVZ+44kMqwznEniF99FN1ex/EYdSV3JLZhEGgYxw01G8wJ81gQDJVR1QNH/QKTJ1LcYrSApanShE/a1yBFCPEJej0gPoRiIBJWs9m+WZrJdwagidJ/sPdOe9Rmy0utII2E/AI0Q6YUa5oXc9XOGIqbk++h/0NYWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986089; c=relaxed/simple;
	bh=SUcs4ezYKO4bL6n9M4wwGaW5Kl1QdqF5O9xTiMlCOnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcdMa0k4xcO9+9X8UFm40S+0txyNGQMUUQXog7DVGyqaFXK4bIju/XvJ333vT6aZ5WMwWijFx8eUCv2arAnwnPR7QZp0hGys8iLQtHJx+G3b6lKC3eXdWt7Hg8v7HAErkYlXvQUxd/Z8+0ul8evqK/WfP5s0/Pv0KUPIlYCtY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwhqI0r8; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwhqI0r8"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87ded9c6eb4so213028241.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748986086; x=1749590886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5ojcrIVgkEfEi/wrMb1iM7XDB/HOb9H8wYORbOpMVQ=;
        b=iwhqI0r8XS3h1hEGLDhnfCwmGPoyGdchSnRZLiox3uJLwpl2rP1TXJrOx0kGiiv1Qv
         2GVoTI6ZlK3uy1lGaIvGkb7tI5E0SXWYhIq8wDMjd9cZbtXxLqQhqLMaIEIapn1elmgf
         k5zTJdSWS7Du+bfs2pAV3eku5B89zshzEMRWLEiFEYnuBftYHk/bHbi/P4s6By+CQSrK
         SpigI0/PHr8bGJfoSSxDoGjlDgZMO52gNGvyO70mNHLvxNpreRnxF8sO4gAGKGOQzTlq
         nn7pQb+NuDC6ZBgp0CSuWzI/X1cmsFL0LTwwh1RrZcDtmgHXy6scv5AaPF4rkCBnyOC2
         Rf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748986086; x=1749590886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5ojcrIVgkEfEi/wrMb1iM7XDB/HOb9H8wYORbOpMVQ=;
        b=fawplWu+wf9sX4d8JqijmjHMCdXib6I7ihPwaYHfJqfdVYEAbnyz6/summ5D74CRtp
         Dul2xxnZ6HlYvVArXm1yBOFAUONu9k3BSwgPHCSLqjJvgau7bNOwKO0YJgv/O64BaCYs
         zKZRZ55q8ZpatON7XhnqhQ9t7Xt573BY4+OdYJr5xIQZouchcLHVb+r83pQQslu2cXx9
         WMZhdD1WxlXBGtiOYSXt1Z0hjSVLfgMmOry7ZnkVZ3W94qo2JHSn0KZlDpwwEbXrEm0Q
         fuSwrVXTac5YDdm86GY5exreCqbe52t9OSGad5Wj8X8zHzxJOQX1lTOmS4gZIBBkrO9Q
         NC3A==
X-Forwarded-Encrypted: i=1; AJvYcCW4KJxrfqKcpquh1k+ZiKF/4qTOgoNCyp93Dtr0fHB4TfGa0V30uMMUo+Iufe4hH12N5CyIagrXtfoFWNEBJC3o@vger.kernel.org
X-Gm-Message-State: AOJu0YxzN2ayRrZuEFCml/UaTOLxcFX8kX0miNt7dSN6gYIyNiOQj3pu
	5AofIY6vF7nfZ2PkfVYm044DOpGsMEaUp4QM7KbIyTm4J7L2Rg1cIBzANnEd2V1e83alLuHjj7N
	zLZ92D0O9fe5R7E2Lp4GGst2zYGfR0qNJ0K/upRpR
X-Gm-Gg: ASbGncu40J2aPMOXP+I+RkAeZ50CneJDepyI0vtYy3cLFQtnFdppgly+4iPh9+Vjem/
	/8kJvJFAbIds1m9Op07lZM86jT7reE/WnZn5P+fX2I9ytUefhNytx0QwXAxgSMmRYlwYcn2Ul02
	zfoPxdHkbD2JrIGXY+FhrZgFtsQHCZFjU2ItmiZ45YRTsrH75/yGJsD/DINTJTnljm8orzy0d3w
	j6xGl16w36e
X-Google-Smtp-Source: AGHT+IGPufNgxZrRK47SQJAnzsbGTLBiIYxDJo93U7kPRNqPTlaECeMfrKAn6BbuqZ9O026msMwFSfTvqVvkhwFCr2A=
X-Received: by 2002:a05:6102:6a8b:b0:4e1:ec70:536 with SMTP id
 ada2fe7eead31-4e73604f86bmr3729726137.4.1748986086263; Tue, 03 Jun 2025
 14:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com> <aD9Xxhwqpm8BDeKe@google.com>
In-Reply-To: <aD9Xxhwqpm8BDeKe@google.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 14:27:53 -0700
X-Gm-Features: AX0GCFvoOAekprdEsevG7NvEGepKfhZ3n_z3bWQsEz8WhnhItGs9NEkTscTn2Ng
Message-ID: <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Tue, Jun 3, 2025 at 1:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, May 21, 2025 at 03:27:24PM -0700, Blake Jones wrote:
> > Look for .rodata maps, find ones with 'bpf_metadata_' variables, extrac=
t
> > their values as strings, and create a new PERF_RECORD_BPF_METADATA
> > synthetic event using that data. The code gets invoked from the existin=
g
> > routine perf_event__synthesize_one_bpf_prog().
>
> It would be great if you can show an example how those metadata is
> constructed and shared between BPF programs.

I've added the following to my commit message:

| For example, a BPF program with the following variables:
|
|     const char bpf_metadata_version[] SEC(".rodata") =3D "3.14159";
|     int bpf_metadata_value[] SEC(".rodata") =3D 42;
|
| would generate a PERF_RECORD_BPF_METADATA record with:
|
|     .prog_name        =3D <BPF program name, e.g. "bpf_prog_a1b2c3_foo">
|     .nr_entries       =3D 2
|     .entries[0].key   =3D "version"
|     .entries[0].value =3D "3.14159"
|     .entries[1].key   =3D "value"
|     .entries[1].value =3D "42"
|
| Each of the BPF programs and subprograms that share those variables would
| get a distinct PERF_RECORD_BPF_METADATA record, with the ".prog_name" sho=
wing
| the name of each program or subprogram. The prog_name is deliberately the
| same as the ".name" field in the corresponding PERF_RECORD_KSYMBOL record=
.

> IIUC the metadata is collected for each BPF program which may have
> multiple subprograms.  Then this patch creates multiple PERF_RECORD_
> BPF_METADATA for each subprogram, right?
>
> Can it be shared using the BPF program ID?

In theory, yes, it could be shared. But I want to be able to correlate them
with the corresponding PERF_RECORD_KSYMBOL events, and KSYMBOL events for
subprograms don't have the full-program ID, so I wouldn't be able to do tha=
t.

> > +     rodata =3D calloc(1, map_info.value_size);
>
> You can use 'zalloc()' instead, in other places too.

Fixed, thanks.

> > +void bpf_metadata_free(struct bpf_metadata *metadata)
> > +{
> > +     if (metadata =3D=3D NULL)
> > +             return;
> > +     for (__u32 index =3D 0; index < metadata->nr_prog_names; index++)
> > +             free(metadata->prog_names[index]);
> > +     if (metadata->prog_names !=3D NULL)
> > +             free(metadata->prog_names);
> > +     if (metadata->event !=3D NULL)
> > +             free(metadata->event);
>
> No need to NULL change for free().

I've removed the NULL checks.

> > +static int synthesize_perf_record_bpf_metadata(
> > [...]
> > +     for (__u32 index =3D 0; index < metadata->nr_prog_names; index++)=
 {
> > +             memcpy(event->bpf_metadata.prog_name,
> > +                    metadata->prog_names[index], BPF_PROG_NAME_LEN);
>
> Is it possible to call synthesize_bpf_prog_name() directly to the
> event->bpf_metadata.prog_name instead of saving it metadata->prog_names?

Not with the way the code is currently structured - we need the BTF data
to call synthesize_bpf_prog_name(), and that's allocated and freed inside
of bpf_metadata_create().

Blake
