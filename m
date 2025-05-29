Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9563B9
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560875; cv=none; b=hxKqODv3ziVP0r2rPU40UZb7eW/n3UxkiD0MPbmlt07wPz4nY9ZFaahvzDmZUMMXHHogTWVCexC6IgDaU0mgPzO++H9SAfcend7Xh8hDgSLpgFP6mVS+Zkh0jNMh/A6o6zIlXbpFb8ruErhqR7Ub3S7BMpe10oGCJVWGntO8L9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560875; c=relaxed/simple;
	bh=MZXk35VJ8Le9CqGjyhGh9Yojgg0lxJHjMlJqlcRjJzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p74qh4CnnLj2cAJWBFSXDGT17tCWrb1zaskKdobD8H3tnmFV6E2AAMy2JznFzsH+c3eW7pmSwKmdbxfkzDFZsFerQA0cobcmt2aSy6acEazDXj0FdMUfbaT+p8yqKQfW3EXM1xRhXPX2hjZ4JNqxGXD/08MSISR2BUnY275Sw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfFoDOMK; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfFoDOMK"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e45dae6c8cso937477137.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748560872; x=1749165672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ3c+Wi2NmVMCqELDsVloOEHC7NYEmV32OBnWDhc4vg=;
        b=vfFoDOMKZY7Joks4oTwrMDcba7MBShiAvdujpZFzlRoMfP9u7MTkGOMDJ7C7DEL8dz
         RtfBBnmoCXC3kwmIivWKbjfeNlEo7rTCN786gQ3x00p9PzL13U9plakVkhE3h458hRel
         2ThqApGt08CSPw3qTTCQTRuK7VGGr92X3HSYyfBWke/jf2ctJ4tAkcUfu12kBXMuUca8
         ADqYgMfzMDqBY6bGoxgopycUi+dUZ23NmzdruzYeVHNHDZKMY1ACwSz0EfKpZfJyR2P6
         kUKfWbIjcbKBmfjUR6+R3sWOb2/OwDVyknYrglXmQNF54aW6eu1PtLwHPD/2dj5yJmJW
         ytFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748560872; x=1749165672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ3c+Wi2NmVMCqELDsVloOEHC7NYEmV32OBnWDhc4vg=;
        b=CbCAbWCkfIwecyFIWSS/rut0wM4ejPkUO2k/BEcnt98RCCjmIcuxPXuEqWL+c3fpjr
         fRSjWA1FCoEtfq7BeKMzrpNitX8jY/Ok+YMRhGdwHmCpnmSrqc9/DERVL4DHoOINRCkM
         RqjrOgJwSq3ULSn5UUHZlGRHVOjDED6x9RndQC1QqLpI3gE7/JKEtbpf4p9OT3LxQTgv
         xdXAPTgRrjLeKFfioQq9o2n4kqeF5StqbJYmWXGNS19mV7ztYB2vctX6xRWmeCfLDoax
         MPuIr0yU1cQXhROCNVK9SncnCrQWQlUIXghucX3k1x75J8/JqSCYbDbMdAiwp+zKaZJW
         iwsg==
X-Forwarded-Encrypted: i=1; AJvYcCUvfhxaqQkaAI6h2uSq/o2vk2rqfNF2GPqmAtCCTHwOvG9o5/4cqCU3dqhmExYiTzPPfALc9g4Tr8X76iaThiLv@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJNYoTMRzpdCld/O/H8ka8lNtQ0WzSzK3INkG1Ytb1x5EAkYx
	tvFyqrM+glTtiGpF1++UqfUqk1HcB98pD/S6K+X6R4Et5/dDCOIg8uu60db6inq/86Jo2/PMjBr
	rqowUErx5bi5+KA2B30lTTbWl9Anm5p002LqVg+x8
X-Gm-Gg: ASbGncugpTwmROqCBJ56cuHOZkZu5weYh/QgY/G5zX4d0eCOrm4lVhSbohii5txAoBr
	KfFgfl3fTFkbhP25NiAGfxVHbMCHVGidv5f6oXI4mXYYAfjQGWy/aJgGzRNuKzWcqjfp1/MZyqE
	aHdwhM5lQJqKBh3V8gNV/H+hbRJIfBruDz5XLg28dV42xLYU/wtnMunIMmhUQ5e+JrnbSUT+WhV
	Q==
X-Google-Smtp-Source: AGHT+IHJIZrfAvpKY/5wr0qNDI7tJLIOAGcHH/s3hT0bGXWqKuDPpcR8PAvDf6R0gNbFcBlmC8YVS8YdBkpjGsynf/g=
X-Received: by 2002:a05:6102:26c8:b0:4c1:9526:a636 with SMTP id
 ada2fe7eead31-4e6e410cc07mr1777490137.15.1748560872289; Thu, 29 May 2025
 16:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com> <CAP-5=fVn++LYR6PcRMf9wcBooALVHX2y=i_C6cLsDipN2EDsOg@mail.gmail.com>
In-Reply-To: <CAP-5=fVn++LYR6PcRMf9wcBooALVHX2y=i_C6cLsDipN2EDsOg@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 29 May 2025 16:21:01 -0700
X-Gm-Features: AX0GCFuI08MI_TydsQLHChdJJOb9OX44_XJRJWvHC2fCjLT41nw5dVTKyiiOFDs
Message-ID: <CAP_z_CguNu7KGL+-=WD-8LfZiKaLEe=R=Z6jgtXTr21AzKQNtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
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

Hi Ian,

On Thu, May 29, 2025 at 10:47=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> > +               bpf_metadata_event =3D &metadata->event->bpf_metadata;
> > +               *bpf_metadata_event =3D (struct perf_record_bpf_metadat=
a) {
> > +                       .header =3D {
> > +                               .type =3D PERF_RECORD_BPF_METADATA,
> > +                               .size =3D metadata->event_size,
>
> nit: Could we set the header.size in bpf_metadata_alloc to remove
> metadata->event_size. The code generally doesn't pass a pair of
> perf_event + size around as the size should be in the header.

I can do this initialization of metadata->event->bpf_metadata in
bpf_metadata_alloc(). I'll need to do a bit more work in
synthesize_perf_record_bpf_metadata() before I can get rid of
metadata->event_size, because it needs to allocate an additional
machine->id_hdr_size bytes (see below); I'd just have it get the
value out of metadata->event->header.size instead. Sound good?

Blake

> > +static int synthesize_perf_record_bpf_metadata(const struct bpf_metada=
ta *metadata,
> > +                                              const struct perf_tool *=
tool,
> > +                                              perf_event__handler_t pr=
ocess,
> > +                                              struct machine *machine)
> > +{
> > +       union perf_event *event;
> > +       int err =3D 0;
> > +
> > +       event =3D calloc(1, metadata->event_size + machine->id_hdr_size=
);
> > +       if (!event)
> > +               return -1;
> > +       memcpy(event, metadata->event, metadata->event_size);
> > +       memset((void *)event + event->header.size, 0, machine->id_hdr_s=
ize);
> > +       event->header.size +=3D machine->id_hdr_size;
> > +       for (__u32 index =3D 0; index < metadata->nr_prog_names; index+=
+) {
> > +               memcpy(event->bpf_metadata.prog_name,
> > +                      metadata->prog_names[index], BPF_PROG_NAME_LEN);
> > +               err =3D perf_tool__process_synth_event(tool, event, mac=
hine,
> > +                                                    process);
> > +               if (err !=3D 0)
> > +                       break;
> > +       }
> > +
> > +       free(event);
> > +       return err;
> > +}
