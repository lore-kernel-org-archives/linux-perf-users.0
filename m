Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17853153828
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466094; cv=none; b=rA1PhbuFWbu4s81TLaCjsL2FbCjLhVZt5Uvry68CFWpfcw1Vx0DshSdWnwhn16teJDelBUOcIataNhu471GE+kaQQC+1UsVN2SgbGYNr95XYX8GMFje1xU743SU1qLdsI0x89yfogsBZJp9woaoxNtMFzIYBLZyhJjo6tjm3xZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466094; c=relaxed/simple;
	bh=PovcOEpVOIfFyfZ/BbhzW6l6CY0d1eqwHZnPib5bpWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh3U44ui0U/HNWJS5W6PyBpzd4aT7Ukig8MDGncB7i1Toc5IUa2H65s8kK8cPZU7s942mAEp9oLwXHPdmdJUHx9e5bt3yMkNJ7wCErUmblz/63eUrijp8LWs+k24Gs0i/EBVdkIv4YGDQItMIZds3PgHSutc+9yJfbRH6SHWOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2an9V1V; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2an9V1V"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d19702f977so35815ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739466092; x=1740070892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PovcOEpVOIfFyfZ/BbhzW6l6CY0d1eqwHZnPib5bpWM=;
        b=q2an9V1V5lUpdRUvmoNtMPY3YHxtR/J67JbcU07uX0r9OLdT542bZZy65uD9dqUUZa
         HOY9f/FTyNS7ZzK+Ht03rmd4QdhGf7CmH3fz+5gMEjYMF1wpRBaxlxY2bwaKyvfyPjlq
         X1Z0qQZtUNuaANIeV4ATJ2cdBShCfqCdLUccrYwknQg8Ik/VfxVplmRSBZTmqYKS38q0
         m3EQxZrGzbq21/Q4JWQgslTh48ZVtZ4ZN/yEQi/AF+kG9mgbljeIObrUI1ubFluyLpwC
         sHpWj7pwnlqfxGuT3JTi21oxEG+vCckMtHEuxnMx3NSsd6boNA7HeHRAk0k3FnmwZ+K1
         WB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466092; x=1740070892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PovcOEpVOIfFyfZ/BbhzW6l6CY0d1eqwHZnPib5bpWM=;
        b=jeWkHzjN/9RaKR8NGRhmN7zg5snsow/gF6Wuwc6V6IUPZPQhZs47m+uk6MhVaKlSTX
         bIBnUjzNI/MMDEpM0U7haLg0cq/hRH+UItCnwBK+B5xbyEfNuDRpXXR7UeN52+U4hgHF
         M55V2KGgeeN3FKJvLFbhEd7PHMQNYQxSxoQyxfXzaDfU5edmRcSK6UezjgIN2//mnne1
         gqBw5ZbTQE+e9IGF8CF9trIzg0LnIDgkFSn4fPlYhl2FE/y1gJyjM/ZiG49WVKamd/QZ
         CI8VxYTU0IvH/E0jyY48F9HyIrLboOLZsZbBtQlrmU/PNrG0fgMV/k7hxHgS+KFUqigp
         uE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7rPpvwTDXXjPbxP9h/BlhieNeJC59lJHA9W+/ZQAudif5ak2gxAstuIVFRO+1slaCs11VKw8YpzV4xGyqYroE@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+7Wli+BfQQTrZ04L32NsIS33z26czoYvS3SMWVEO9I+Eue/h
	OaxyG6mfq+NOC2l1Xo8sTMkMRpw1dlNjdQgBOb0ZN+MTwocVIdWm2qz9/2iBDmz6Ydg2fjMYnhK
	9v3GIyUEjIXfSjc5JkIao2CptumfqLTQemUGW
X-Gm-Gg: ASbGncvTENKG49PHxiI9oiP6JxpseP6c0RG6QIQlD7ymuHFAwsDJPIknnUMS4J4rAyH
	z/NGktFfAeWmqMBIi/lqblhwLbSNZSTxKm05qT8YTiP/qL0pYt5eXxYNDMhn012O+TTBytQ6VLc
	9otd781RYFmkj5QHNdb762STpg
X-Google-Smtp-Source: AGHT+IH49g8dK4O+NUmdJ4L6GhNQBsvBKLL75KwqbYoHNbteNRo3BPIVyHyWcctTgNrcd09gUinjpgsSxVg+3d92l/w=
X-Received: by 2002:a05:6e02:b23:b0:3d0:5855:85a3 with SMTP id
 e9e14a558f8ab-3d18cc90fa6mr4489825ab.8.1739466091369; Thu, 13 Feb 2025
 09:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211213031.114209-1-irogers@google.com> <7f17ddbe-6552-4702-acf3-f6fb3c2903c8@linux.intel.com>
In-Reply-To: <7f17ddbe-6552-4702-acf3-f6fb3c2903c8@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Feb 2025 09:01:19 -0800
X-Gm-Features: AWEUYZmcdcZgi3Y38xNs3y_jZ5VDgqFDvW5mAeSClKF0FQiiARbCgn-gOrDMPz8
Message-ID: <CAP-5=fVt-Ph28koDBCfZk1PbvUkQQeZEbebLZi1iiJm6GxBhBg@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] Intel vendor events and TMA 5.02 metrics
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 8:51=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-02-11 4:30 p.m., Ian Rogers wrote:
> > Update the Intel vendor events to the latest.
> > Update the metrics to TMA 5.02.
> > Add Arrowlake and Clearwaterforest support.
> > Add metrics for LNL and GNR.
> > Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> >
> > The perf json was generated using the script:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > with the generated json being in:
> > https://github.com/intel/perfmon/tree/main/scripts/perf
> >
> > Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> > <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
> > Weilin Wang <weilin.wang@intel.com>, Kan Liang
> > <kan.liang@linux.intel.com> and Thomas Falcon
> > <thomas.falcon@intel.com> for helping get this patch series together.
> >
>
> Thanks Ian!
>
> I run the tests on Arrow Lake. Everything looks good.
> Other patches looks good as well.
>
> Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks Thomas and Kan! It would be nice if this could land soon as I
want to do work on top of it. Specifically:
 - This update didn't move Ivybridge, Ivytown, Jaketown and
Sandybridge forward to TMA 5.02.
 - I'd like to incorporate event updates
(https://github.com/intel/perfmon/pull/288) into those updates.

Thanks,
Ian
