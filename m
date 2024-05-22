Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63846AF;
	Wed, 22 May 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410808; cv=none; b=TDvBgJGhd4JrgbTy/7lne2XDiTEVRY5M4wTFxY4pOrprudXp6gnhAH2quOq1cVAJkL7s+OQgxVqGNgBAd5rmrieeVv/ORyYAYc5pnn7gcxyBXR9g82OcPAIoCplfReDZDTrQu5u0SmoG2eBbu+BLvwfVCpg7/HDLLB0wVpfuohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410808; c=relaxed/simple;
	bh=BCjxQzbn20nyPwhzAgkTQNH8QQzf2kk/km4bFVtfCLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC8Xa+nCTTF/RmlHIow2zHQIjfT0pN/IJLORzUyRtvPUEOgx0Q6u8TX3C405HS7ARuHaYBJ9HE8HqQ/c+YhO7zt+/rODo3S7w/FABHNydKUL+7e6PrsviTJ08UHvJ/PDVk232fKBwZVJQ554n+3S1kPqIyXubq69O5NDVPhyZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-67af6c66159so172266a12.1;
        Wed, 22 May 2024 13:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716410806; x=1717015606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCDpp4dfVi1mi3RI+GYsmKmEatc2rnWyzxqydBcc32M=;
        b=ka9014O14YTlrR0H2QDUvb9kdHBZB/NdqKoFYxyRLXFaLxZm3lNK9QWsNAmqZ84Vvs
         GMGkXkpZhg7hRgWCJ+LEvoRti1fuWXxsHMGjoxmSnlqXa/7z59aEQri+MlohnTTZO0XJ
         iO1GYX+szqRgPWnqYKSkmdy/yybXWSD5LTsmwzYsXyY9yP2r684KuwXJUVWh1Z5G64UY
         8LqpnvYCOnjYsbvBq4WKmpf3XyTQrjLBIBMN8sOrjOcsDdAENgA2eJcN1YowFz0Fz/oa
         /qTXL8Q81MZiSGHrdSC1U5xz1ZO1tIYC5glTo34Antmh+LC2Ug+6+NXP7pMtVs3ibVfH
         bupw==
X-Forwarded-Encrypted: i=1; AJvYcCXrhjoor9hGrvBsdBW/qnZbJIM8A5+IlneKTjQawaQ/483b4psJwAnJC0Fz5+U31AnHordsYknCE8SyjTsdLsuAfVdszid3XKLFrElEOCdotOWPk/ytZoOZ5ovjdr6WSn9R+XuBoPtk+RiAUY4p8Q==
X-Gm-Message-State: AOJu0YzSHNceXN+vs5QJLlmWvesd5vqFBOwcXzzhGCSqdoSw0MKbwMlL
	xyGTEEsW3Dk5QFQWqKE9tmjHaG4Iy07ANh1ISo9kcVKO8WrMij+q22zrPAfxp0nitfSJiJ6A6Kp
	eqXRXNH+gSOC3IVmDl8kdAGfRs2U=
X-Google-Smtp-Source: AGHT+IHkZj8HgZHS6FLzOZApxr1xOvklngZG43iL5plwOL72BUQNONA4qQmDE5zE7QjH8cnn8DMXBT19P54h/SBjSqI=
X-Received: by 2002:a17:90a:f109:b0:2bd:d67b:6bf3 with SMTP id
 98e67ed59e1d1-2bddcf226famr498303a91.20.1716410806477; Wed, 22 May 2024
 13:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520083048.322863-1-sesse@google.com> <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>
 <Zk5Mi7SliDOd8uO4@google.com>
In-Reply-To: <Zk5Mi7SliDOd8uO4@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 13:46:35 -0700
Message-ID: <CAM9d7cjjH63CC8r-z33P4SCWw3x4NMxuSC1CovVHqpp-zXSf6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 12:50=E2=80=AFPM Steinar H. Gunderson <sesse@google=
.com> wrote:
>
> On Wed, May 22, 2024 at 10:27:06AM -0700, Namhyung Kim wrote:
> > I think it should support other DWARF use cases like
> > unwinding and type info?
>
> I don't actually know. I had a look, but could really only find
> documentation for _writing_ DWARF info. However, I've hardly used LLVM
> before, so it's entirely possible that I missed something.

Oh ok.  I guess it should be able to read when it knows how to write. :)
But anyway they are separate, nice-to-have issues.  I think we can
add them later.

>
> > I remember bfd objdump is sometimes faster than llvm-objdump
> > especially when no line numbers are requested IIRC.
>
> Hm, I've never seen that. But it's impossible to say for sure
> that no such case exists, of course.
>
> > Anyway, nice work.  Maybe we can implement other use cases
> > using LLVM and reduce the dependencies.
>
> It's possible to remove the libbfd dependency entirely if that's a goal,
> at least, but I don't know what the current thinking is. I'll be happy
> to take a stab at it (I guess it's possible to test the PE support with
> WINE fairly easily?).

Great!  Personally I found libbfd is hard to read (and use).  Hope
that libllvm is better in that pov.  I'm not sure if we all want to
remove the libbfd dependency but at least we can select one of
them at build time.  Maybe the same for libelf and libdw(fl) too.

>
> I found out that if compiling with an older compiler, LLVM changes to
> llvm::Optional and doesn't have .value_or(), so I need to fix that
> (the patch is trivial, but it means I need to post a v5, I guess).
> Is there anything else I need to do after that to get this merged?

Having symbol enumeration and demangling with LLVM would
be nice but not required to merge this work.  I'll take a deeper
look next week.  Please post v5.

Thanks,
Namhyung
