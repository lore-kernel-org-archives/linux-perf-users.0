Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408C35948
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560149; cv=none; b=qoxBj/c23PLH5+02dktcRjNBwtj2Vgsxs7ggvmG0ZftbEivieqjI38jWYvX+xd6GUMM4k6rCb8bwkx2i0uRHvXSK/6FvhvelnIBq5/IdpWcLk83RFGz802rkPcA51vHVXEgCR+fJRMYpMPegdhfO450pH08mIJE8S+R3OImDIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560149; c=relaxed/simple;
	bh=gfK8yw5GZtFA1H4YDR+ZEscz5dgSAagi9RjzBHcTiHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzWObEE9T3ipdg7Y5e5kRtspl46bkt+ai2HPMgaxVQCU2GOxFeeEkFOsJC56Wf6ce/zqnk5ozUYbfMVbnIG6Gcy88qBRgsNodbQrvqBR8Bn4wynEGj/aiEcd5nMGNtk1C8U1NALn95T6rW9Ua53IXWNhx4HUUafwaj1o2DWPrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbzCHOgf; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbzCHOgf"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso6485ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734560147; x=1735164947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iEyY7H5QyR4V3sDp8DxPOt1LhhOuR956xQLjdTOQCg=;
        b=bbzCHOgf1USq/c7j8CXlP8WxsEZsGUg9wFuAqgDrm63Okr4tOZo8BL+/x9TB9uv9w2
         V9s90qJUIxeaP09Ww0D2CpW2ks/8UUiJDdYQ2epIrkNnWDys7OOYyHPAG19NX2SSaZ4+
         7EQDasRnZaLqBNO3MU7N608lMUVOQVLjUNVkuiTIMvaMvHT+sLfOqxYMwNn7eVYt0otD
         Qng/HEujoITTORkbiYmAwoOPFbX7W3U7T2phQc/n8lJfS5ct4NsiD05SHUwjSGjysM7X
         ygS//r67gNGhFoj1D7PeCoPiX8DJOHCe7zHYHclpm1zzRN9z5uYA7UIrKYtuv+FgHgC3
         1ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560147; x=1735164947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iEyY7H5QyR4V3sDp8DxPOt1LhhOuR956xQLjdTOQCg=;
        b=BTXLathfRWIFL2p8qSeLUXs9t+fPuo/VSRiUieAscQmPEzCVgwxX2U4o+tMZ9fi36S
         W3lFJjT25xYbPap7OU8Ubgy2ud8Van2DnYp3LY5EmC2DTiQ6i9OQBeGltLaGjav8Ovev
         lVBe4jvBQJD3wZFjG+dzX/Kw1odfn4Dg5V3ncNXmNC3ATHFsVy8xpLD/47Pm6bo00uyn
         oR0KckwbNn0ftB17gAHhtFZtX2QpBxvxz0Vt0LSw4f2N8Iq+ONAnIu7O3HyW4sXyFSLC
         /P0aDQfCMmHxZnkaKPjvotdf7UEBUlryZ7d1Q0nBAZy3z/WKV5wQyrbvqfQeP7gsxb6k
         Lp7g==
X-Forwarded-Encrypted: i=1; AJvYcCXKIC4Oi4DcC5mq9BbEYp9J1+KyzinDDIqIiSgUnK7iafsbHLwnVp2WDO/8RdtJ+u/A4EkG/9MiwAqeWWY0pmMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxrobXIQXJxzibvAgMjIwnj+6An5RUhvXV7/5CKa6f+43ReBH2M
	efeSKKxm/1PPoMbB935k1kl+dbrp4mSgmY+nKeAKfvi3q7oGtkGOXqYZBsqbHq7UYaUd0MBnQxT
	CnrgBWrZJK4VpbTXSn6b2UyUXAMWT6Cy3wfNO
X-Gm-Gg: ASbGncsQaVy2EZx8HdoHqyQ4P2CxaUQj55nDiuGP5cK8d9WzxXHNiPdKUxzTnN9tVO5
	D9XNnFl6tf5vrZXszVISnxh3vJJYZD0p97CSiqws=
X-Google-Smtp-Source: AGHT+IFktz1kwfxf4wUpOJemBhnW9Ni462vER14JJB6O86RIw6Jbvtmg0HyEiDJcph5Hz+YLVxPRSuGQMRTV+4e0lbw=
X-Received: by 2002:a92:b05:0:b0:3a7:a629:b0dc with SMTP id
 e9e14a558f8ab-3c0579abb83mr841425ab.2.1734560147055; Wed, 18 Dec 2024
 14:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218220453.203069-1-namhyung@kernel.org>
In-Reply-To: <20241218220453.203069-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 14:15:35 -0800
Message-ID: <CAP-5=fX2Pj+Gv89LoO8SakqwVoaiT2A9BZEKmLjnbYmc4ZRo4w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fixup end address of modules
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Blake Jones <blakejones@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> In machine__create_module(), it reads /proc/modules to get a list of
> modules in the system.  The file shows the start address (of text) and
> the size of the module so it uses the info to reconstruct system memory
> maps for symbol resolution.
>
> But module memory consists of multiple segments and they can be
> scaterred.  Currently perf tools assume they are contiguous and see some

nit: s/scaterred/scattered/

> overlaps.  This can confuse the tool when it finds a map containing a
> given address.
>
> As we mostly care about the function symbols in the text segment, it can
> fixup the size or end address of modules when there's an overlap.  We
> can use maps__fixup_end() which updates the end address using the start
> address of the next map.
>
> Ideally it should be able to track other segments (like data/rodata),
> but that would require some changes in /proc/modules IMHO.
>
> Reported-by: Blake Jones <blakejones@google.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 27d5345d2b307a97..8bb34689e3ceeec4 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1468,6 +1468,8 @@ static int machine__create_modules(struct machine *=
machine)
>         if (modules__parse(modules, machine, machine__create_module))
>                 return -1;
>
> +       maps__fixup_end(machine__kernel_maps(machine));
> +
>         if (!machine__set_modules_path(machine))
>                 return 0;
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>
