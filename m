Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB91CAA4;
	Tue, 22 Jul 2025 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156391; cv=none; b=o8RlB4DsH2nSqZl6p8WvOIKuAUXKDFyqPK4U71PHiY012P8VHEPlTiOe/ZeDAaTykT0x9CVNKnEhhzQYcBrrmAMYy7tn171bPDQsQDJZntcaqq5Pi3r63Q0UmsYRgup41DR0pkVpfN2aP/nLhr8AWRwLMhW/5GZ9AiLShEHgUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156391; c=relaxed/simple;
	bh=ad6zVFEWTXoS7B5hRyZw1sZ6+Wc2KApbQaX938jAh54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjNpdevcuvwguf8lhd59nrpYaH3wTTD6SobIhWKPu/dPjZdcF4Z0YKVDppwRYT2T8Ux9f5GBJiV9ioCoI0KJB7elsOKTlNaok2yJ32Yr0oFfyN6RNyeg7KrrVK11UQjKhRYGFIZ21svoML3awI7EZjPV+5/HPEnv50PPpq2tVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9wjqbNv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9wjqbNv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e64b430daso53966997b3.3;
        Mon, 21 Jul 2025 20:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156389; x=1753761189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+4A4Wcwmx0vcAwCCnC1T75w7LAAjengjw+UcaUHyos=;
        b=J9wjqbNvs1ujHe2j2foTkbZbllgv/kXKEeQtzjcCCCJ7vX0imXGEHlW4uaE6C3TlXU
         pZmnJQpWyP7TFl5NDXe7U9/5OkrL8V548iwUPrMBi7rfdasDDpOAYiSu02p9WA3SyX3d
         EXt02lwjN+U9iyoGsXjWnsQ1NFmT5jB22Y82DXEElaq5cbA78G+q6QPaknbbPmeNpmJu
         eG4zaZbHB3j5huFKTEIMNwrVzvOk6NZh1GGnByQJ0IQnkI6r2wi5EbMaK1gQsOEZtn62
         tLeZ+vEiS58GLXKjBX8XWrJ0aQVYxGPZ7If0rD95rc0qkA/WvBhRIIdiDyO9iHSz86Op
         KSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156389; x=1753761189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+4A4Wcwmx0vcAwCCnC1T75w7LAAjengjw+UcaUHyos=;
        b=Z/r4qlW7nZ95KrWtr5D/OdggaicuxHxl89rIggQQ0X3wmKwn02PnC40YUQAWidvqLd
         86K0pOsJE+xi6iHvTZBueHwjKrtLI6cXxBlhnhmmhbx0RH4hVu5k+PN8J9z1Bktheqou
         1YFKkSyxbCPuEUzSaC3igHJjAz5lhz8YO0PtjgB0Y6vAAOGFOAi8s8pkWXORX/HMvQLz
         XgxAUMFKVaAwFJs/iFjmwxIqgUxuvdnaqxAW/TD0FQjgaSSbM57a+X9NSoMPD2CP/paD
         oTNGM6TTtTKqbxXRNzkSbhAfgCluKhXrI95dHKRyLOA45SRYFKINMYHcc9klR1A5P/dv
         8WGg==
X-Forwarded-Encrypted: i=1; AJvYcCULF8j2cbFJAK5Yv36KddfjyoxS4lX36gitompLZWmiS4iofEXL7BRnvgop6hOdRWFnUtHFE09dQvgRSMk=@vger.kernel.org, AJvYcCWxmxVNxQc8j8HFX2S83xdXr2GATpFtdN0QiXG4ZZTurhSfBgoEdmxVQ0upGRK+SgR0dOYmKz+wriciAP05dFWpEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXE0a/USP+vp6WjuNOQhcT2v88X1X7XfZ7JAh+4pnXpgmXvlX
	riRFcmwKDEypc3M3CW2UopFnWVIYU/iBXtQU6u6rGFWx4v0+1hRlNn9HjZ+fcMsGeLu6sMdxKw6
	2KTaRqDhnvrhd7YQzpAQ2Ijtew3yn/1s=
X-Gm-Gg: ASbGncu2ClFs3mfOrs2Vsr0VscAuwGuMGEfYp5uxWKGcDggtlr8uxGlSS5XnBCEF7AN
	ySCihmTz4NJgbJHNlf2ppgBxL1Qd+g1781G3PlOkF2ypl23+XthvLiDPBfKNOSQk5PHfMrALlKc
	h1dnUEMBpWeGegOw82FvTZcbSdSqR6BhydipiEk81lu/trf7ytdkLbnBBIxar1EQySPFR8V1ooP
	bHLQ/6uJGlwW7UuFg==
X-Google-Smtp-Source: AGHT+IE2FkHxdrwRPSB7f1DXPrRY4tIYyDgF/3RU5l1sRBiDems9bE84T4ajYrT80tKcsAE4Nmrz8g+X4HTBOTPFxGA=
X-Received: by 2002:a05:690c:48c4:b0:70e:2d17:84b3 with SMTP id
 00721157ae682-71837547df4mr306229807b3.37.1753156388642; Mon, 21 Jul 2025
 20:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGjUpI1yNjEhSiAq@brak3rDesk> <CAG+54DZQC+-6E-P3D4BUtVujNegL1qKpcB5SGh28+rX5hrHFiw@mail.gmail.com>
 <2025071801-driveway-curly-698c@gregkh>
In-Reply-To: <2025071801-driveway-curly-698c@gregkh>
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
Date: Tue, 22 Jul 2025 09:22:57 +0530
X-Gm-Features: Ac12FXyMU8t_OUOIvb1DtwpsQJHRb5Os8gf_VjBQVLO8HO3XkJ8g8JphfHbx7A8
Message-ID: <CAG+54DZS36Lp3Wc2nh+uSR14GPOWK+LJePp-jW1oB13uGtiSHw@mail.gmail.com>
Subject: Re: [PATCH] arc:kernel:perf_event.c : replaced sprintf with sysfs_emit()
To: Greg KH <greg@kroah.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, vgupta@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:18=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> On Fri, Jul 18, 2025 at 03:57:20PM +0530, Rujra Bhatt wrote:
> > Hi,
> >
> > On Sat, Jul 5, 2025 at 1:00=E2=80=AFPM Rujra Bhatt <braker.noob.kernel@=
gmail.com> wrote:
> > >
> > > Replaced sprintf() with sysfs_emit() in sysfs*_show() function in
> > > perf_event.c file to follow the kernel's guidelines from
> > > documentation/filesystems/sysfs.rst
> > > This will improve consistency, safety, and makes it easier to maintai=
n
> > > and update in future.
> > >
> > > Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
> > > ---
> > >  arch/arc/kernel/perf_event.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_even=
t.c
> > > index ed6d4f0cd621..424ec072c441 100644
> > > --- a/arch/arc/kernel/perf_event.c
> > > +++ b/arch/arc/kernel/perf_event.c
> > > @@ -648,7 +648,7 @@ static ssize_t arc_pmu_events_sysfs_show(struct d=
evice *dev,
> > >         struct perf_pmu_events_attr *pmu_attr;
> > >
> > >         pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, =
attr);
> > > -       return sprintf(page, "event=3D0x%04llx\n", pmu_attr->id);
> > > +       return sysfs_emit(page, "event=3D0x%04llx\n", pmu_attr->id);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.43.0
> > >
> >
> > Gentle reminder for the replacement of sprintf() with the sysfs_emit(),=
 kindly
> > review it.
>
> Why is this required?  There is no bug in the current code, so no need
> to change it at all.  Please just use sysfs_emit() for new sysfs files,
> no need to churn the tree and change all existing entries, otherwise we
> would have done this a long time ago when we introduced these functions.
>

Hi Greg,
I appreciate your feedback.

I wanted to bring the formatting in line with the
latest guidance, especially since sysfs_emit() has become the recommended
method for sysfs output. I see now, though, that I should restrict myself t=
o
using that helper only in the context of genuine bug fixes or in the course
of adding features.
I'll make sure to only use sysfs_emit() for new sysfs entries or when
modifying existing files for actual bugs or feature changes,
as per your guidance.

Thank you so much for pointing this out.

regards,
Rujra Bhatt
