Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6F224B04
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128465; cv=none; b=WLfvfwHUO4Q4dBQOptaLZtpnOFSOUndbJ4BadyRlCz2W38VBJUjRTuVIasiUkDj7DcCAEJv87P8HgqPhs9N4Hf8AKY2JGVJyO43g0tKTZDDIji7UlhO+2vLwvmrNTyXAbfDMScHn99//0oOOMVMVjWxNjJlikPoxl7svHvEGv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128465; c=relaxed/simple;
	bh=3Dt56nKSyCanJiVlxRvkthqpChbl84aAfqu1J4HGQv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJn1n7iuuITmbJeC3tLw4hBf/OCXY0bctmRIvIW67TDmjME0W76B19okHZ8itGfrTryRa4lqBt8C958cbR+PCUFd4AueS4jMGbF7GbZ6wX76jvXMhUbjby6Qof90+9RpSIeR2RrK9vYsoxNNtB7TTr4uTEqPB1pMAl9h9s/CYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcRWYzqX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcRWYzqX"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecf99dd567so19414866d6.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746128463; x=1746733263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGjwIotwYx2XvIKhgDLZQr9CxiI0z5/EQ148mfVrAMU=;
        b=qcRWYzqXmWlvDroFrBBSgyBQIKokUgzXWdElPQdKBj2LtHtE2c3RhzCl9g2C1Jxe/Y
         aMI5sMnWEDNKHn3SGwsYKsntNX88ldT/5573gUTLEbzB1OTYQ/C6QJFuXSP6Ur/06Ycx
         ufwdFTb+xe17+IyGMH9KZyOWXBm0NrJk36YAZT81tuqkfY0r0v+GLj0FtbuuHS/A0/kj
         njCjJD93Xc9tJ3Xd+EkrlWif3nprlMZv+bjafqZTLl8nU7LE1iDnZyeIn9MJS8Q0ng/u
         +QE9DJTlgF264sapeOpYiy8KqxT1Swt2IXTpH+99FbAGxXKYVqzupIriRkwnTvnJUv5V
         kBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746128463; x=1746733263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGjwIotwYx2XvIKhgDLZQr9CxiI0z5/EQ148mfVrAMU=;
        b=svrbMjgihgtQhWy6ghnUSZxNJs883L89j8qvRHe/XKGF7Y2D49/neNFb/Fqm9eAOJA
         xpKzLq7PVskKVqTjufiRrBYB7sY9WVYpXwkTNbszIp+NSuP0F7IJPC6fVUYgu2/de+4a
         xOFH05FFl/JY3jv+GxIEPb8l4xuApmbxVuiVXw1RSpgCxQKRGC206vy8ZFcia1wKsrKs
         rQ3qqJT2Uu1xN4IDwY1Js37QDZYDS2Y6zau3Mw/FLfzn2U/+uim0jzA74Q4Epq0qNBsX
         FKXezPylnV015JBL28SGn1rvYjlYxFSsZBKHgBYX5RLB8cg5t6MHJeKaZnau8kHvq7zB
         X4hA==
X-Forwarded-Encrypted: i=1; AJvYcCXnkCX9ItG3/7TIByaEfnvhXLfUVLicKitAzSal7I2C3H+AgTJlvawxCv82Pij74/t691TS28dO9smiKeAEABWG@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKYTt6dir0IztCHVKSO5lkO4eViZLzv0kYPu7eQcBBRmw32y/
	6LqdsRR16AE5PQTeJg+S4pvTU6vUFrX+FIh+1zacD/il8YsEdQhiPaevc1mPl4HlbHRk0hBtb9A
	G+utr7eGPeA1wWPIllutnSNPKjaThU6mhDUs=
X-Gm-Gg: ASbGncuMqYhqJ+LEucpZoj3DcNtyqxWQ2zMjs9PBNCrqXMXaRkVZmfQRIq8LQQ2a4Oz
	RVKs1HRBxfFuD0ByVQT9VEukXd6ywv1KpgcricrJcbCsmVxV0I/uPk2mn+wP5ppfR5TM9Vv+lxz
	EyozpIpVSDRqlpI+ZKflRim3ZcslUuBKdV9ruukT36kMlztW6WygM=
X-Google-Smtp-Source: AGHT+IGmG4Q6q6A4+zcAS84FjPk+vhRIQTCiE8mwB+hojxIFoINeC3OH8FibnJUGPn2uTrcgIuHY8VK2eWaXjD7DrtQ=
X-Received: by 2002:ad4:5cee:0:b0:6e8:9e9c:d20f with SMTP id
 6a1803df08f44-6f51538dd01mr7400556d6.21.1746128462429; Thu, 01 May 2025
 12:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429213133.922495-1-yabinc@google.com> <a7c2ff21-4399-4cff-83d9-2fb0da0b5a08@linaro.org>
In-Reply-To: <a7c2ff21-4399-4cff-83d9-2fb0da0b5a08@linaro.org>
From: Yabin Cui <yabinc@google.com>
Date: Thu, 1 May 2025 12:40:50 -0700
X-Gm-Features: ATxdqUHhwNwpEdxYYpxc7dOP4rb5LoVMEh7OUs5FnZ9i5VfeUpLDEgFZmftWHkY
Message-ID: <CALJ9ZPParuzroQmPGuz5YR94R=AHEw+gFp1NOdrsUer_MBmvsw@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Allocate non-contiguous AUX pages by default
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 3:47=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 29/04/2025 10:31 pm, Yabin Cui wrote:
> > perf always allocates contiguous AUX pages based on aux_watermark.
> > However, this contiguous allocation doesn't benefit all PMUs. For
> > instance, ARM SPE and TRBE operate with virtual pages, and Coresight
> > ETR allocates a separate buffer. For these PMUs, allocating contiguous
> > AUX pages unnecessarily exacerbates memory fragmentation. This
> > fragmentation can prevent their use on long-running devices.
> >
> > This patch modifies the perf driver to allocate non-contiguous AUX
> > pages by default. For PMUs that can benefit from contiguous pages (
> > Intel PT and BTS), a new PMU capability, PERF_PMU_CAP_AUX_PREFER_LARGE
> > is introduced to maintain their existing behavior.
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> > Changes since v1:
> > In v1, default is preferring contiguous pages, and add a flag to
> > allocate non-contiguous pages. In v2, default is allocating
> > non-contiguous pages, and add a flag to prefer contiguous pages.
> >
> > v1 patchset:
> > perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
> > cs_etm
> >
> >   arch/x86/events/intel/bts.c |  3 ++-
> >   arch/x86/events/intel/pt.c  |  3 ++-
> >   include/linux/perf_event.h  |  1 +
> >   kernel/events/ring_buffer.c | 18 +++++++++++-------
> >   4 files changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> > index a95e6c91c4d7..9129f00e4b9f 100644
> > --- a/arch/x86/events/intel/bts.c
> > +++ b/arch/x86/events/intel/bts.c
> > @@ -625,7 +625,8 @@ static __init int bts_init(void)
> >               return -ENOMEM;
> >
> >       bts_pmu.capabilities    =3D PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP=
_ITRACE |
> > -                               PERF_PMU_CAP_EXCLUSIVE;
> > +                               PERF_PMU_CAP_EXCLUSIVE |
> > +                               PERF_PMU_CAP_AUX_PREFER_LARGE;
> >       bts_pmu.task_ctx_nr     =3D perf_sw_context;
> >       bts_pmu.event_init      =3D bts_event_init;
> >       bts_pmu.add             =3D bts_event_add;
> > diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> > index fa37565f6418..37179e813b8c 100644
> > --- a/arch/x86/events/intel/pt.c
> > +++ b/arch/x86/events/intel/pt.c
> > @@ -1866,7 +1866,8 @@ static __init int pt_init(void)
> >
> >       pt_pmu.pmu.capabilities         |=3D PERF_PMU_CAP_EXCLUSIVE |
> >                                          PERF_PMU_CAP_ITRACE |
> > -                                        PERF_PMU_CAP_AUX_PAUSE;
> > +                                        PERF_PMU_CAP_AUX_PAUSE |
> > +                                        PERF_PMU_CAP_AUX_PREFER_LARGE;
> >       pt_pmu.pmu.attr_groups           =3D pt_attr_groups;
> >       pt_pmu.pmu.task_ctx_nr           =3D perf_sw_context;
> >       pt_pmu.pmu.event_init            =3D pt_event_init;
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 0069ba6866a4..56d77348c511 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
> >   #define PERF_PMU_CAP_AUX_OUTPUT                     0x0080
> >   #define PERF_PMU_CAP_EXTENDED_HW_TYPE               0x0100
> >   #define PERF_PMU_CAP_AUX_PAUSE                      0x0200
> > +#define PERF_PMU_CAP_AUX_PREFER_LARGE                0x0400
> >
> >   /**
> >    * pmu::scope
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 5130b119d0ae..d76249ce4f17 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -679,7 +679,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct per=
f_event *event,
> >   {
> >       bool overwrite =3D !(flags & RING_BUFFER_WRITABLE);
> >       int node =3D (event->cpu =3D=3D -1) ? -1 : cpu_to_node(event->cpu=
);
> > -     int ret =3D -ENOMEM, max_order;
> > +     int ret =3D -ENOMEM, max_order =3D 0;
> >
> >       if (!has_aux(event))
> >               return -EOPNOTSUPP;
> > @@ -689,8 +689,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct per=
f_event *event,
> >
> >       if (!overwrite) {
> >               /*
> > -              * Watermark defaults to half the buffer, and so does the
> > -              * max_order, to aid PMU drivers in double buffering.
> > +              * Watermark defaults to half the buffer, to aid PMU driv=
ers
> > +              * in double buffering.
> >                */
> >               if (!watermark)
> >                       watermark =3D min_t(unsigned long,
> > @@ -698,16 +698,20 @@ int rb_alloc_aux(struct perf_buffer *rb, struct p=
erf_event *event,
> >                                         (unsigned long)nr_pages << (PAG=
E_SHIFT - 1));
> >
> >               /*
> > -              * Use aux_watermark as the basis for chunking to
> > +              * For PMUs that prefer large contiguous buffers,
> > +              * use aux_watermark as the basis for chunking to
> >                * help PMU drivers honor the watermark.
> >                */
> > -             max_order =3D get_order(watermark);
> > +             if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PREFER_LA=
RGE)
> > +                     max_order =3D get_order(watermark);
> >       } else {
> >               /*
> > -              * We need to start with the max_order that fits in nr_pa=
ges,
> > +              * For PMUs that prefer large contiguous buffers,
> > +              * we need to start with the max_order that fits in nr_pa=
ges,
> >                * not the other way around, hence ilog2() and not get_or=
der.
> >                */
> > -             max_order =3D ilog2(nr_pages);
> > +             if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PREFER_LA=
RGE)
> > +                     max_order =3D ilog2(nr_pages);
>
> Doesn't this one need to be 'PERF_PMU_CAP_AUX_PREFER_LARGE |
> PERF_PMU_CAP_AUX_NO_SG', otherwise the NO_SG test further down doesn't
> work for devices that only have NO_SG and not PREFER_LARGE.
>
> NO_SG implies PREFER_LARGE behavior, except that NO_SG additionally hard
> fails if it can't do it in one alloc. But I think you shouldn't have to
> set them both to get the correct behavior.
>
Thanks for pointing it out! I made the change in v3 patch.
