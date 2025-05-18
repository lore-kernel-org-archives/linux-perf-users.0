Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1B39FD9;
	Sun, 18 May 2025 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747591929; cv=none; b=clvz5PK1QEB4QEz27VBpRifUJ9GBd/TQHZWCJOXRzZHcL8c1Rz/ZXi+8C2+px23au2YrpfaymQJ3WYTyXoPRk1JFMZYXKKUomN/3ch7U0/FFQx77bKoxxmhjNs05h/v9t/fxUHifJ0yb8gHTGuqbVrFbTkgDYDL2kWobC2V5gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747591929; c=relaxed/simple;
	bh=xLrfGRIolCn+y1r+mkvbyYvCu2T4QGg3/8reVJO2b2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhcUkbu8dWMjo3sY/WCPNuYZu/EgaN5R0jRxPr2YJAJax/De6nWrtuTCsbqpGdeM3VJg8W3bF9fk1cM4tsm1Cm2POElZ2F6cRoitiKhDi9kmjdGitDDX8NjcCMVT33t1iZHzboe1f3hklSuqp7Zy7f0nHqw3OuRfYGR/+kIskSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uysvgk5v; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uysvgk5v"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70cca430085so5220487b3.3;
        Sun, 18 May 2025 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747591926; x=1748196726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHn+msd7NQ+wMbD7YZtQnX8pW0NnLTWIdaNDr3YivAU=;
        b=Uysvgk5vBIb7HOtOPYxoD6IiahnB3tUFzoY4aOnOwQH1+g37VOaDxv+kuEoJPP0CaL
         KQ2n6OVIbUqPXqmxEMJ/av3cPHcpJ7SKK48AOGCV7sqMBJzULJtKttbUshKtz7FR14xK
         N91Ap+kz8AZd7FFG8jtc8vt6vsreZ8MPyT6Z54smgyaGIpx2h+xqm/R/2/PVdhNuHEEz
         WS3PUnLQeK8xHTNJQEAIhl7+2kkOPAidMDqcnq4BCLNMTkBAr9lg4XaPJzEYBFxiKl2u
         febhJha9eETavuR5wqzTbX8qCl6wiHY6mLW5ChJOdA5hkqE92pHbQeyeeb2A8vdZyZoE
         r7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747591926; x=1748196726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHn+msd7NQ+wMbD7YZtQnX8pW0NnLTWIdaNDr3YivAU=;
        b=F9KW4ryvW+O/12mcKUQLIzXrDVPytQUQ1F18AEEbNP8KsycFD6lkSaGm/x4Jz4cUV/
         rrce+hRZYyQbcKoEwTRQ6KIYpkpDv2jPSPQ2RMdlxrmDX1OvHU4cPmwPTTvEtgH42M7m
         pqrTs+IqQUEdoMbYWiKmxI/qD8V6AJrTijDSf5gm6sfArJ0j2cxGyED/D3+e7ui/RSAm
         W9wOg1iQDaJhCqXvUPtGbd7NvAsSv2REZ+/bOnkVqRpg8GN45hRF1cHIbUG+1H6nLoAo
         DB5iWPLU/PzaOC04BJcSUmQKORFK75nP/y2IZN1C9siMmee8kFKkJkMSuZjfOyvIBI2J
         QOCg==
X-Forwarded-Encrypted: i=1; AJvYcCWEGmRhr9pNTPWqOlbhdPRrEt05KYGBLSNOVC6ZzYcShx0/j+TO9/uzsrRGMPpnbiuSeeNrZvD5EvwHIA8=@vger.kernel.org, AJvYcCXRGqKii6QI/0mb6uiU3Jq2OscVFcikAhQSz/JooQHWSePu6te21g51bg7sHpqX9N3I2aar2lYZajIHHCHC9w74/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaedUh8WMmY++xZz2VFeLusNrJFFiVIWBjMLL5N2bKFDQo1Ng
	JV27L5N/kHW+0hwoHz1rq2z2GdA2OEDbGxJY6NlcsPYNMxOImjLL9ciN/4WsQT25yAVyO3o2Eg3
	NppqV5CVRpg93zIs62OZSsV1MN6sPRP4=
X-Gm-Gg: ASbGncue+w1Udb9u1mVIOci/yhfWROBBdwZAMwQ/tefe0B+6TDGUv3KUmXzHltfranp
	v4n1tGu0LX2NFZ0VmJA5oAOAjQphWW0nNmGfTuOaJhlIYzc0r/enlquNSJhtLNbFGqm6QmTFsdv
	es3WPtig05aBZus903xkUPw4p/Ji7H4HycS3RO9HtOeg==
X-Google-Smtp-Source: AGHT+IGE50CS8gt2jpoH952jZjCUyVs+crWub7hI76UX6jM9UkUopcnMA7SCZADbxyox5nTnz0xe6c7N4D+G+fKkzQc=
X-Received: by 2002:a05:690c:ed4:b0:708:21e9:a20d with SMTP id
 00721157ae682-70caafa9779mr142654417b3.16.1747591926464; Sun, 18 May 2025
 11:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517163230.1237469-1-howardchu95@gmail.com>
 <20250517163230.1237469-6-howardchu95@gmail.com> <aCoeM4qTk5YnGIsT@google.com>
In-Reply-To: <aCoeM4qTk5YnGIsT@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 18 May 2025 11:11:55 -0700
X-Gm-Features: AX0GCFtkO8mLJpOXKojWTdB5XqQg2vXOzejauZOW4x2PvyFGkHt4qxLwP-vlOME
Message-ID: <CAH0uvohjmuahjP1Xrz3h9FmK7R1zE_jP-czxt2s_5pPx_nMu2w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf test trace BTF: Use --sort-events in BTF
 general tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Sun, May 18, 2025 at 10:51=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, May 17, 2025 at 09:32:30AM -0700, Howard Chu wrote:
> > Without the '--sort-events' flag, perf trace doesn't receive and proces=
s
> > events based on their arrival time, thus PERF_RECORD_COMM event that
> > assigns the correct comm to a PID, may be delivered and processed after
> > regular samples, causing trace outputs not having a 'comm', e.g.
> > 'mv', instead, having the default PID placeholder, e.g. ':14514'.
> >
> > Hopefully this answers Namhyung's question in [1].
>
> Thanks, it makes sense.  Maybe it migrated to another CPU after exec.
>
> >
> > You can simply justify the statement with this diff:
> >
> > ---8<---
>
> Please do not use this in the format patch emails.  This makes git treat
> the following contents as commit body so it'll be added to the commit as
> if it's a valid change.  Maybe adding some spaces at the beginning of
> each line help.  But I think it's better if you publish it somewhere else
> and add a link instead.

Sorry. I will delete this scissor in v2.

Thanks,
Howard
