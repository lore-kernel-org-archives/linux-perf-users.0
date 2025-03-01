Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC83101DE;
	Sat,  1 Mar 2025 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788715; cv=none; b=kBZak/tGhWWAQhU56Pg79E27vsZCKvR7jla8t/AdPniYvCVgurUz9xNZ/UWx7u78oA+xoQrAMKNCE3S/BnkxAg9sCGghhw44M/CR1gYwK8luqn5YKdDHsznhFudWL58uSsnvFfsS2/9FF9hfYu3FvNoNWwjsNJP+k8QUwy8k1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788715; c=relaxed/simple;
	bh=XFbCzOr8x0mc18tDs3UGrvj7/ouKNDpWSIKYwUY499s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1a1DjG/CxHeCql832OWt5p+cqOhoXcPmHKfqwVk+iJkjkOb2dBRzACE+NY+BBOe2RYIThqKsJE2XYterjalLJRhPak8GhBJs+v3nqGmraIHEzYFvvrGfdPhKI6AO7AuEvAaMx3lV4DSdEvz4RYCnYrisHEPcK+stkaZ7vhCPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWrRSZV3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWrRSZV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD26C4CEEA;
	Sat,  1 Mar 2025 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740788715;
	bh=XFbCzOr8x0mc18tDs3UGrvj7/ouKNDpWSIKYwUY499s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HWrRSZV3nrp7Z8h7Pt4HeIHRsCK+4268yO2gzD0BIyMp5ru+YvoE6f7LRdyu0gMXp
	 iP1MPVSESLrvGY5vrvAXAZ1EJcuCICfqynVE9Wzx+3XpLtUdQm61PKOqlSdtgyIXGz
	 3pRxHa3mokJ3JQqneLYqCNJFxH5f+vsPcWEYcT7gkf9RYhetxWFYzRad/nMKzduHhL
	 PwOXR7xZXunJ9cLNU+4uNYRsNIibJJfx7dZdzjgDVxM3kikuViji8COc13MrJc9KZx
	 Iq72Hdy2dF+qENYVVX4xBOrJhDxWaGO+kPNSK+zn7N6P36Ad9NmwCWWxpZTt9SqbQq
	 3wQKS79KG1ZeA==
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-856295d1f6cso197336339f.3;
        Fri, 28 Feb 2025 16:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmN34+rktrt1YRXNd9V2nuouxC45RjoJwtdUGi0cBmroXFCDmX1SY2JGPBrR5mYY6bpuTskraewe2ESDQ=@vger.kernel.org, AJvYcCVnujSB0rKMORMIkpLCssTROhiomANQySDtRcFwU1+rgN8skS/ArMDk6e/PwVcr3DMMX9Z3m6ERnscQgl56YetcrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsmx5km+raN4M5YoTI4aASoCWp0C/xOp5AwTZcxtjq6KzLu4wA
	r1SeoWLvgeevcMemm7L37KMcl12B1GUMIAgTKMw6lia8g0UuG1hBYm7OimX3VYk+mgG9wwx6qw7
	GOfpwIHrw4zG0C01BiRBQNBxyOCo=
X-Google-Smtp-Source: AGHT+IGAp0GbHqRmi6hlPED+wTmAowfkgSomr4+J8+M5z34mjBfwhbZTMkguL3rXPh0edlmJoWRZwclgslkJCRmboY0=
X-Received: by 2002:a05:6e02:13af:b0:3d3:e536:308c with SMTP id
 e9e14a558f8ab-3d3e6e71ceemr59314225ab.8.1740788714543; Fri, 28 Feb 2025
 16:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227051718.1176930-1-namhyung@kernel.org> <CAPhsuW6wuBjCo9ygCFhyYimEHg5ZNtN7-Yd+gWuMJPTU781vFw@mail.gmail.com>
 <Z8JS2P-QwHcPUpTV@google.com>
In-Reply-To: <Z8JS2P-QwHcPUpTV@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 28 Feb 2025 16:25:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5JFP-QuE_HZBJm+RT+ytsV72ihP0g_CvByKB_S+fHV_g@mail.gmail.com>
X-Gm-Features: AQ5f1Jr2VUA2S9023QU5IkVaAbXI4g0PBBEnWq_T787XPOc8iygntsGUUGHqtUI
Message-ID: <CAPhsuW5JFP-QuE_HZBJm+RT+ytsV72ihP0g_CvByKB_S+fHV_g@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Skip BPF sideband event for userspace profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Feb 27, 2025 at 10:50:26AM -0800, Song Liu wrote:
> > On Wed, Feb 26, 2025 at 9:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > The BPF sideband information is tracked using a separate thread and
> > > evlist.  But it's only useful for profiling kernel and we can skip it
> > > when users profile their application only in userspace.
> > >
> > > It seems it already fails to open the sideband event in that case.
> > > Let's remove the noise in the verbose output anyway.
> > >
> > > Cc: Song Liu <song@kernel.org>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > This turns out to be more complicated than I thought. I actually
> > like v1 better.
>
> Sure, the complexity comes from moving the code to reduce the
> duplication.  But either is fine to me.
>
> Can I add your Acked-by to v1, then?

Yes, you can add to v1:

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song
