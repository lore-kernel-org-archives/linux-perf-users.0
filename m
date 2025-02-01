Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC571CA84
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395069; cv=none; b=FhcEav+GLPKu+Usw2D9FgTQkKKMYKlTsv9fLO5NXTP0ry08vMK9eHBxp3WehGGOee37Dtjhgxi0cL9HhjHaRG5izOkvEDzk3dCMY3LqKz+KdsZO/TtKHp+beLe5rXmZENUN8B4iTUHr7uaFy+0RsUP1SkAlYzcdxB/Ya/j2mO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395069; c=relaxed/simple;
	bh=SgNo8dH5am/Elmp34JE6+4MLU/zt2EJOyQSfeys07SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0Nee4jnDaBXEJ+MIA4ZMNyVT6IrzTrglB3qjt9zxxeNf6KpzUWrCzXnKU1WtkICPHxq4Qd6D3QM5L9lpXCclJ/mptTjWhThWqVlLxLWa2Bq9Mu0Yp6yXYYLdTbQofAAczefYQiuNLYrCjiLeyzhvMCpux70iLkkHkAgIDOjqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOB9KnB6; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOB9KnB6"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so100175ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738395067; x=1738999867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM3mbDCaJDKjormPBcnpJQHSUi6Z+Si4pw0PsB2e6Kk=;
        b=GOB9KnB6C+HGRHLFWTCuivIZC6GZKKwAJe2YD9u8/k95BFTZmLevqwTW9IfZpFL4Yg
         YCbdFDduD99yUqil2WMqHEKcLNUSniFdupqEjgeIezZwJJ8S+S3rUWS3lRIlfsdgNJuV
         deJ5EY7mQPpSxZmufGqJAwI3ILFSAMMWvr22clXhUtzSq424fy0Lj/I/UGrd/5Nji4sf
         v91mNDU9TfQZj7SCkBsvJD2d9TNHeSH94omcpqRxSuFmtOQlo+MuTYaHHGnPyheZ1KXL
         Xu3+O91KMZUdc4ToywsnqlEkLSqJFDD69EMtA+elWZgAvxOW4cpmv9OjWc9U7hCxV/iM
         5FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738395067; x=1738999867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM3mbDCaJDKjormPBcnpJQHSUi6Z+Si4pw0PsB2e6Kk=;
        b=G0p21q+b23mjJX/KJmi0xDrI1LIz5NTLSWp1e2xlfj8aZe+iDx0CFJxpxeOga3sNC5
         vH8h055qOizmNV98RwciFakvYieUBhoSDwYxAchIqcBnX7ljqOOBRF2f9yTPz8L7enUy
         g3HhLZdKhM6ESRdciMFr68LyREs2yr6ZsEb7z+KP1OadvJhyb3dqNYAnQMWAdDsWyLku
         se8QHHnB35jEGPtBezcJ6TU00jSHTAJvbfSbS/h37G3EZZYmBv+faaKx+yPmxou8X3Qg
         +Dnq9QzV/VE9tFfFg5XnSkCmxERgP59BJIwSCrUKOiflzefT50Ek0Evm+na1B3wPwcRg
         sFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3c9jwVR7L5cN7mbCB4LcVFiwHlGARe+CyUdJRztt6WB3aFm3AGGK2d6cMXtAB4CbPg/96BbAV9z4iyI2kmzp+@vger.kernel.org
X-Gm-Message-State: AOJu0YywUs1WDKEtOg+U9C1Sp+mcE/zZM+zBIWXiVNE1TbXeR5wfgnwA
	OdEFA9zLZeSK2XLc1GjfZPlzInXayk9kxWpxYbxnMroFZqrt7jNYnMIp4e/q0MjmMdZXwCC7ti6
	NVYfzpfyb47lSkCng2a80B7XK3snxgkLMHluy
X-Gm-Gg: ASbGnculytlwIPxOhd7tNXq6YtIh+E5DxGQM3yUcVaQjjL5CtBSgzjeOQDKnaYkD2HG
	zkuDvFPKAmGZyQAbexJqO+6GcXouMCZAHxiCVx5xx5jJHvfw7SPa3G03k+6nYIbFAJSbjc26JqA
	==
X-Google-Smtp-Source: AGHT+IFefJ0bMTwlTbF8utr4Ee0XY0RrdbEhXib2ltNlkpJ8mBkO5F0k4YXI4CDokapAhcfwEMqPsfi7EgBjOM9tpCA=
X-Received: by 2002:a05:6e02:1562:b0:3cf:ade6:7ffb with SMTP id
 e9e14a558f8ab-3d02035d59cmr1954505ab.28.1738395067080; Fri, 31 Jan 2025
 23:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123074659.698123-1-irogers@google.com> <20250123074659.698123-4-irogers@google.com>
 <cdb39365-60c3-470d-b632-abe3d730c5ce@linux.intel.com>
In-Reply-To: <cdb39365-60c3-470d-b632-abe3d730c5ce@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Jan 2025 23:30:55 -0800
X-Gm-Features: AWEUYZkBn6G2ExYgx9XCGap5XicLjbUPwl6TZKk8Esx5MXxHbKeT3RR4XdTSdbM
Message-ID: <CAP-5=fUKJw0uPSjUG1FhY8jJrUOYV+q9zXe-qE=h-0rQ+gXw-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] perf pmu: Rename name matching for no suffix or
 wildcard variants
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:29=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
> On 2025-01-23 2:46 a.m., Ian Rogers wrote:
[ snip ]
> >  /**
> > - * pmu_uncore_alias_match - does name match the PMU name?
> > - * @pmu_name: the json struct pmu_event name. This may lack a suffix (=
which
> > + * perf_pmu__match_ignoring_suffix_uncore - Does the pmu_name match to=
k ignoring
> > + *                                          any trailing suffix on pmu=
_name and
> > + *                                          tok?  The Suffix must be i=
n form
> > + *                                          tok_{digits}, or tok{digit=
s}.
> > + * @pmu_name: The pmu_name with possible suffix.
> > + * @tok: The possible match to pmu_name.
> > + */
> > +static bool perf_pmu__match_ignoring_suffix_uncore(const char *pmu_nam=
e, const char *tok)
> > +{
> > +     size_t pmu_name_len, tok_len;
> > +
>
>         if (!pmu_name)
>                 return false;
>
> I got a segmentfault when I try the code because of a NULL pmu_name.

Thanks for testing! I'll add the extra check. I think it may be
redundant with other event parsing changes that aren't merged in the
main tree.

Ian
