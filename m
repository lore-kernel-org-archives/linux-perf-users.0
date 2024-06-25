Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C13C9B8;
	Tue, 25 Jun 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292068; cv=none; b=g8iFwLu5KfYLeyzFIOgbCDY4EJzrpkpoEGSl96qi3kwUhcjcViGbT/HYVnCr4OrI//fvOySMjcdpWnaBv8Bxv2HY5wXltpfKywbW9exdWqJEr9nsQrTtvXtR5gPInhbg4Ke3IP4Nz5ayvMOIY/Orwa2IAdYs4GzJFKpZ7DBaIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292068; c=relaxed/simple;
	bh=4Fqo5ZsXA00Syt4IyDqmkrXtJhhEceAEBc2ZwO2zK1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctLK5kiPDCbkulNm9UuC6/SHy3hUAigEmMMnhHbmeN+L5XedmPB9uGn/EAq5uWr13hXlWex8xDoluWkxk5T1Aqw401pPVwQvWdNUl8wk4WBFoIYY89k6XGj3ApQfuV2yMW/OXiM5enEzZTEzXAJIcx3THSGtKeXswn5hRB31Az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c7dd4586afso4007727a91.2;
        Mon, 24 Jun 2024 22:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719292067; x=1719896867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2nX4sSDQopBWz6aRvHp/UTHI+KNMfdJyvaF/IGRrxM=;
        b=sbLuciriUVBnCNYQFmBL0W5y/O6QdjDI7x3mF0GsTcNGfdRPrcjbXSZc6SeO5ILhbe
         3ls8pSlqk0mjdlSFlmjhJzWCy+zX6IQ2ZYyHZ867usDrZPaEvSTDztKafd6cmbVgpYys
         5t0SdCGPJYYoTK41AAPUaAGGcuavNz/C2s6YxBK6FSmEeIxM6+Ey0BFJagSl1/B+TXkt
         0a6PHo3aSpRBJkbQUj4URjCYUsFRbjT3zG5q7V6msxQPoQa+R0hbgA+h48n12/Bhfr5p
         M84o9wmtOuPxAFIIrWTq0VARtSleOPP2qJ2rHbWOhudIjQijLgW92wgV9f2V3rBMMp3j
         nM/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWvCMkGALZF5380cZzxwTy3zIdbUIwD7JxeD7sQU6QTmmKWDTMVUpO9NX0GW8EYMPGXKr6rpK8l7zk+ZWjCoiwJ1mliTlGs5p8I9b9x+vp5mS7rV0rUrEADNG0C1beCvbN4+OucRICC8b47GF79Q==
X-Gm-Message-State: AOJu0Yynf1plgSoZr29AopnJoMsyMvKyaU/KFT7boazPlraaOoktgw2K
	7cycFvFvjNfFKfuhtXX9U83qF+PHcSFiykicp6X1MP4AylGkHTGOxlwpAlH9zn64V0kNOxfYOwm
	IF3PRLWQMmXDtfOxsA7NzHaYUWZU=
X-Google-Smtp-Source: AGHT+IGFm7mfUBTFlBMD7JE8yMoXvMg9hBaeeZcqDS38d6qRn29qY54mjLRlh7VYVRE+6X+QjFF8mjr9yH1YrAGOu84=
X-Received: by 2002:a17:90b:3907:b0:2c7:ab33:e01 with SMTP id
 98e67ed59e1d1-2c8582090e6mr5388744a91.27.1719292066454; Mon, 24 Jun 2024
 22:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621170528.608772-1-namhyung@kernel.org> <20240621170528.608772-5-namhyung@kernel.org>
 <d4c5086a-908e-4246-a6ed-6a2223fe7813@linux.intel.com>
In-Reply-To: <d4c5086a-908e-4246-a6ed-6a2223fe7813@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 24 Jun 2024 22:07:35 -0700
Message-ID: <CAM9d7ciVF=36BaxzKmddvekimYar+X3ZSWKkk5Tu+vJRRxCx0w@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf mem: Fix a segfault with NULL event->name
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@cern.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kan,

On Fri, Jun 21, 2024 at 1:11=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-06-21 1:05 p.m., Namhyung Kim wrote:
> > Guilherme reported a crash in perf mem record.  It's because the
> > perf_mem_event->name was NULL on his machine.  It should just return
> > a NULL string when it has no format string in the name.
> >
> > But I'm not sure why it returns TRUE if it doesn't have event_name in
> > perf_pmu__mem_events_supported().
>
> AMD doesn't have the event_name.
>
> struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] =3D {
>         E(NULL,         NULL,           NULL,   false,  0),
>         E(NULL,         NULL,           NULL,   false,  0),
>         E("mem-ldst",   "%s//",         NULL,   false,  0),
> };
>
> It looks like as long as it's a "ibs_op" PMU, the mem event is always
> available. The "ibs_op" check has been moved into perf_pmu__arch_init().
> So the event_name is empty.
>
> The "e->tag" in the perf_pmu__mem_events_init() can help to skip the
> case  E(NULL,           NULL,           NULL,   false,  0).
> So the perf_pmu__mem_events_supported() returns TRUE for the !event_name.

Ok, thanks for the explanation!

Namhyung
