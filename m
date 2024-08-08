Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457718E04A;
	Thu,  8 Aug 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125474; cv=none; b=K1RkJnoCbfv/BrzUd2Y0bUr25PTP8PeTs/TtPKp3BUoVVMgo1kJpcQpi8LL0qkpPg7mUkq5n1ujbQDuBjyhv9lNychqvP0dEaONnQLZW6oma5b2BaUqXxljHkl9HIjlCGiXq0OPa2//6brdgwjwYFHFSnBpK3xzl+weSRj0K3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125474; c=relaxed/simple;
	bh=dlBOxcBzszM9a26QCowrnCHLBygMV2d3k8m8ynT5nOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsUu/8hezBJttAlK2DTdm6IfbS5vX2iIRN9Nb7BTZQuB4IZvrIMge2frCpPMzsicBxtWaiQhTaT0RaV4iiz1NzPViztA5Z0X2RRE2NInpJ8Z3v95GKF1GwvxEywPnmmX2qpF9mvWvT38ONgzyAdY7SSmFUJ1pzABJvEhd1P1jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMutYaVi; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMutYaVi"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0e6cbec8caso927949276.1;
        Thu, 08 Aug 2024 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723125472; x=1723730272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbCqVb5c3ARBU1UzJZxnxP5hp6ETF544QjOnOlGCd+Q=;
        b=IMutYaViWGYO73LsM+E3ZixSr8OSw2rYbSLnc8cr8F75knfb+wMePF4B5nhiW5kWV9
         +dfNwVvvKwd1Tv7b0cEtMOgwnbVf/PvV7HOPHCdAvB2H4FDVTsvUY12ZX310U49hDVWW
         Z77VLFXYsrNpMtrYtjIZx6GFpKDW3xM6oo6iSwFFxKpODhh8HD563HqOAeh6SK5G0nnh
         CC1TAvBkz7rvHuYNsij1OH3Xwjx+FDq86z6XvdoHmV7ihuUJ9osajxiHU6W8btn9n08w
         ro/Z7fmVshpah0VzCQcCr7QhF5Dq6cpsl4/YE1zq1BaaEY3LKIqxguF0Gy8VAjrAMZNA
         9Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723125472; x=1723730272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbCqVb5c3ARBU1UzJZxnxP5hp6ETF544QjOnOlGCd+Q=;
        b=NZeUpSOYgI0tZzk0jAmXxuGxrqmbHFqJb98kTwN+CjYOMj+CzK7FPVOQCm+YRx+kEX
         otXG/xAHKZuvbxcsr6k+L6Uz7vukkXH+THcqHZkwmfOZqn7QtGzZhwGqNeP4/OpnBEDs
         r4YRVkoc5jCHuNoEOXyTKVHlEByzTwHAkTWb3xq+snDsgDShFt18hcxzjs9CFJkQgoGK
         uaBNdwgGw34+LmTcExz4zVkSzoVuAwpPxrfth0M67RmEB0N0gJW8uBsow1gkVTXaAawo
         CEPB/dUZJtPnHx7vhhnl6JCOmLRXsNMpCnVXeI/AGyRkcCrU2W5eAOgFXQlI2gbLAkc8
         iz4g==
X-Forwarded-Encrypted: i=1; AJvYcCXaGB+HOSDtG6mPnj+Rd0d2RFmFVL+JRQ6H3f1rw2iNEi2gsTVLIrePebaGarjySWnHZ3/IOLYDakrSgoCf1MDuY7pKzpAJYQ4eM+6ZqKpaKTGk1HmmJgNfN96mYUkgzhZiLTKGNVkjoqx0gYE3Jw==
X-Gm-Message-State: AOJu0YzVZD/UcKD/XoieiUsO7FUdq578TRnhzPNo3aNQqvpae8hRTLQ4
	QOXg2SJzdZm0fHegKgomd7Z5c50Rb6MxDBTMT+1ohGfG3VOXgoB8n5TWYYFa+EaF2/d5Ag/Lef0
	YUJarTf39gKy0mlkglPiAIAqufSA=
X-Google-Smtp-Source: AGHT+IEEk08qtgIgSqPUGUMAfa6V5mIX2slIFMVDA9F1AC5vh1NI6XXqGrrOfM2+JASKNqw+lHVSEx7/cLqQcDCSsAA=
X-Received: by 2002:a05:6902:2405:b0:e0b:daca:4ec7 with SMTP id
 3f1490d57ef6-e0e9da95289mr2227362276.2.1723125471716; Thu, 08 Aug 2024
 06:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-9-howardchu95@gmail.com> <ZrQI1w1B3hnWbd6j@google.com>
In-Reply-To: <ZrQI1w1B3hnWbd6j@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 8 Aug 2024 21:57:40 +0800
Message-ID: <CAH0uvoiL2LWTVCiEfbuuY+QfjznHB2wsREJGi1kL5rGdQtuThg@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] perf header: Add field 'embed'
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 8, 2024 at 7:52=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 11:38:42PM +0800, Howard Chu wrote:
> > We have to save the embedded data's sample type for it to be consumed
> > correctly by perf script or perf report.
> >
> > This will approach most definitely break some perf.data convertor.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/header.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 55e9553861d0..d60e77d5c25c 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -80,6 +80,7 @@ const char perf_version_string[] =3D PERF_VERSION;
> >
> >  struct perf_file_attr {
> >       struct perf_event_attr  attr;
> > +     __u64 embed;
>
> Can we just set bpf_output.attr correctly and get rid of this?

"I think this is ugly as well. I believe I can sneak sample_type_embed
into struct perf_event_attr without side effects, but some hacks are
needed. Firstly, the __u64 inherit field can be used to store __u64
sample_type_embed. If BPF output can be collected, we can guarantee
that inherit is 0 (remember when parsing the off-CPU time event, we
used bpf-output/no-inherit=3D1,name=3D%s/), so we are certain about its
value. And since it's also a u64, sample_type_embed will fit.
Additionally, it isn't used much in the userspace perf tool (nothing
related to parsing and visualization), so maybe after
perf_event_open(), we can overwrite it."

But that will lead to another question of mine, do you think we should
make this 'sample_type_embed' thing only for off-cpu, or there's a
possibility for scaling? The reason why I ask this question is because
there are things that's not API-ish in this patch, such as overwriting
the 'inherit' for sample_type_embed, it's clearly a hack. I don't have
enough foresight on this matter. Could you please provide some
insight? This could impact the direction of my programming. For
example, if it's only used by off-cpu, the implementation could likely
become much simpler.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
>
> >       struct perf_file_section        ids;
> >  };
> >
> > @@ -3713,6 +3714,7 @@ static int perf_session__do_write_header(struct p=
erf_session *session,
> >               }
> >               f_attr =3D (struct perf_file_attr){
> >                       .attr =3D evsel->core.attr,
> > +                     .embed =3D evsel->sample_type_embed,
> >                       .ids  =3D {
> >                               .offset =3D evsel->id_offset,
> >                               .size   =3D evsel->core.ids * sizeof(u64)=
,
> > @@ -4147,6 +4149,14 @@ static int read_attr(int fd, struct perf_header =
*ph,
> >
> >               ret =3D readn(fd, ptr, left);
> >       }
> > +
> > +     ret =3D readn(fd, &f_attr->embed, sizeof(f_attr->embed));
> > +     if (ret <=3D 0) {
> > +             pr_debug("failed to read %d bytes of embedded sample type=
\n",
> > +                      (int)sizeof(f_attr->embed));
> > +             return -1;
> > +     }
> > +
> >       /* read perf_file_section, ids are read in caller */
> >       ret =3D readn(fd, &f_attr->ids, sizeof(f_attr->ids));
> >
> > @@ -4272,6 +4282,8 @@ int perf_session__read_header(struct perf_session=
 *session, int repipe_fd)
> >               tmp =3D lseek(fd, 0, SEEK_CUR);
> >               evsel =3D evsel__new(&f_attr.attr);
> >
> > +             evsel->sample_type_embed =3D f_attr.embed;
> > +
> >               if (evsel =3D=3D NULL)
> >                       goto out_delete_evlist;
> >
> > --
> > 2.45.2
> >
