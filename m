Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D58F6E;
	Fri, 13 Dec 2024 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054362; cv=none; b=sKEb0TdLWaktvMyP4ydpawa0ZOgvNL2CSrH52SZWckzvqVvk/A7z1Dq3rNM5kSR0g7w+RksN/YfPtj+SOFoX9tR2dBcMheBN9FibmV4RxuR7g8CKnImlr3fXyVb/7R/88b0zMmAUMosGr/nj+eKBbf98NR4iBPV8fSpzOOgWyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054362; c=relaxed/simple;
	bh=DQkbB4cllLviy0WjfVmB3HApYm34ssK4CyA4cmbSXjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNpmhe259lnAOq0dHfk5qQK7n6PVTPYw0y64Ru8bvRmRt/ZJrsk8QGOmihWMCpXvyraZRBuV61LEN+eI17pSvFySx1LLHBsVhqpZ0BZc8izjmoFM1+mYC9F0FPVAARiblYHQcY753SfFlR6ineNYvhZqWY3ZyuDTrV00Y8eHkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmXVaVjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmXVaVjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F039C4CECE;
	Fri, 13 Dec 2024 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734054362;
	bh=DQkbB4cllLviy0WjfVmB3HApYm34ssK4CyA4cmbSXjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmXVaVjEP7mHzbQrp7Nmicnzbt+MiJh5pcJ8YWiSDL1YtptNv4hCcAyQGrvI52fgf
	 4FcO5RrJ8+15OicbZVpXUU+NJYrdyWk5cYYJBnr5ATHVLFniYnkr/b9eLepKxPUfHX
	 RnxbZM6uU2yN3xuAjstGBSiJoi1RD5XQTv+3WVHd4CxNBusYDJVVclTHlcG64Js9X8
	 RbWnMekglA+nCnTssMPkSgGXaU3KO6bspMZ1gZAZhepSf1P2uFHRjtSIO4J/OSfRIx
	 cYEN7DK1voYmmjOJNSv6SsMTCQPYJvF9b+pcYWR28RX4PsYQ0S7E/xendFLEKtU5zR
	 Z4INJBRn/TuLA==
Date: Thu, 12 Dec 2024 17:46:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
Message-ID: <Z1uR2EhgfuzLL3a4@google.com>
References: <20241127212655.922196-1-namhyung@kernel.org>
 <CAP-5=fW5bbxXakiFuUAG-HTH2aH_hTXQjJp6o-bZcjcPvNmVrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW5bbxXakiFuUAG-HTH2aH_hTXQjJp6o-bZcjcPvNmVrA@mail.gmail.com>

On Thu, Dec 12, 2024 at 03:56:31PM -0800, Ian Rogers wrote:
> On Wed, Nov 27, 2024 at 1:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The sample data is 64-bit aligned basically but raw data starts with
> > 32-bit length field and data follows.  In perf_event__synthesize_sample
> > it treats the sample data as a 64-bit array.  And it needs some trick
> > to update the raw data properly.
> >
> > But it seems some compilers are not happy with this and the program dies
> > siliently.  I found the sample parsing test failed without any messages
> > on affected systems.
> >
> > Let's update the code to use a 32-bit pointer directly and make sure the
> > result is 64-bit aligned again.  No functional changes intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index a58444c4aed1f1ea..385383ef6cf1edaf 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
> >         }
> >
> >         if (type & PERF_SAMPLE_RAW) {
> > -               u.val32[0] = sample->raw_size;
> > -               *array = u.val64;
> > -               array = (void *)array + sizeof(u32);
> > +               u32 *array32 = (void *)array;
> > +
> > +               *array32 = sample->raw_size;
> > +               array32++;
> > +
> > +               memcpy(array32, sample->raw_data, sample->raw_size);
> > +               array = (void *)(array32 + (sample->raw_size / sizeof(u32)));
> >
> > -               memcpy(array, sample->raw_data, sample->raw_size);
> > -               array = (void *)array + sample->raw_size;
> > +               /* make sure the array is 64-bit aligned */
> > +               BUG_ON(((long)array) / sizeof(u64));
> 
> I think you intended:
> 
> BUG_ON(((long)array) % sizeof(u64));

Yep, fixed in v2.

https://lore.kernel.org/r/20241128010325.946897-1-namhyung@kernel.org

Thanks,
Namhyung

