Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACE223DEB;
	Thu, 24 Apr 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499175; cv=none; b=Gfd9ve476cgPbeu8UvWtmJAT4aCheNUwnt73nSby7XyEW5+xmgKPxu82G/jA3SLE8ELPTwpLD+lYl6XxaLbGG00RFVjL1QF5pXJ8Np3ydtujVe0tTqFdoKZRnkxkNSCoEpERlwMngDchFt8Xj/f1nB52RqzdhOZhV2rOn1SKH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499175; c=relaxed/simple;
	bh=NiPxK2PAkqHQHtt6tVW15Ph4yur9V0c9mCXoTiiQ0GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGINuCLfaMcg7FoDbsF3YZjDxiuZzHGjBCbGgwpE0H1u6PxFazvOTGscsipDLA0uRr2HRi1zp+StJnzEOUV8iN/7TodsGHm1yIBgaH4anEpMPjgqmqZjpILo0B48DkGNbUKo18OhPtX7mDX00kgrbYkdxVAucoyAwnfup+9XhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0KoM9YP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0KoM9YP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0690DC4CEE3;
	Thu, 24 Apr 2025 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745499173;
	bh=NiPxK2PAkqHQHtt6tVW15Ph4yur9V0c9mCXoTiiQ0GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0KoM9YPLGLI4Cye3b8euvv5bBXM8sNMH/3W3e60sV6J5VQvx49HVIKSu/I4kGsPC
	 qsm2LeGbgRKUzuYovMYZMGEMFc0f2AcqiuZl4dZULcVBZFAC/9asNpFN4ESb0LyZnH
	 t+cBbby43JNG3n08XAD79qFdNoaCprkT9M+7bxvsYCyM8l3timuC9G63tYvca9tl5T
	 xTUEt2rQ5ZrAFHOldusLaBKa8ZypLkCvtNuA8rxwxvBXRSH/n66IZYxDQmDyR/GsUU
	 TMnPsBsBu71N3bkt2BK8hdEbQxX2LH7KVp0UXdBgHoTpYEb5ipR9+N3T8kqVPKZ2TP
	 YRV83UqpYworw==
Date: Thu, 24 Apr 2025 09:52:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dvyukov@google.com, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf report: Skip unsupported new event types
Message-ID: <aAo0IoT0xV4HysKk@x1>
References: <20250414173921.2905822-1-ctshao@google.com>
 <CAP-5=fUJip8odShuUVCnwQg9MrMLVdCWjGdSFfUxWubfQYBy1g@mail.gmail.com>
 <CAJpZYjV1Z_A08A1GSTLZwo7BCaJNGGD+Q06w2A1Uc9p1ihT=Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjV1Z_A08A1GSTLZwo7BCaJNGGD+Q06w2A1Uc9p1ihT=Tg@mail.gmail.com>

On Wed, Apr 23, 2025 at 03:46:21PM -0700, Chun-Tse Shao wrote:
> Ping.

Thanks for the ping, I just applied it with these changes, please check,

Thanks,

- Arnaldo

⬢ [acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ba32f8461a4b6438..81cc56503a2d0f51 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1645,7 +1645,7 @@ static s64 perf_session__process_event(struct perf_session *session,
                        return -EINVAL;
 
                /* This perf is outdated and does not support the latest event type. */
-               ui__warning("Unsupported type %u, please considering update perf.\n",
+               ui__warning("Unsupported header type %u, please consider updating perf.\n",
                            event->header.type);
                /* Skip unsupported event by returning its size. */
                return event->header.size;
⬢ [acme@toolbox perf-tools-next]$
 
> Thanks,
> CT
> 
> 
> On Mon, Apr 14, 2025 at 10:43 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Apr 14, 2025 at 10:39 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > >
> > > `perf report` currently halts with an error when encountering
> > > unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
> > > This patch modifies the behavior to skip these samples and continue
> > > processing the remaining events. Additionally, stops reporting if the
> > > new event size is not 8-byte aligned.
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/util/session.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > > index 60fb9997ea0d..ba32f8461a4b 100644
> > > --- a/tools/perf/util/session.c
> > > +++ b/tools/perf/util/session.c
> > > @@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct perf_session *session,
> > >         if (session->header.needs_swap)
> > >                 event_swap(event, evlist__sample_id_all(evlist));
> > >
> > > -       if (event->header.type >= PERF_RECORD_HEADER_MAX)
> > > -               return -EINVAL;
> > > +       if (event->header.type >= PERF_RECORD_HEADER_MAX) {
> > > +               /* perf should not support unaligned event, stop here. */
> > > +               if (event->header.size % sizeof(u64))
> > > +                       return -EINVAL;
> > > +
> > > +               /* This perf is outdated and does not support the latest event type. */
> > > +               ui__warning("Unsupported type %u, please considering update perf.\n",
> > > +                           event->header.type);
> > > +               /* Skip unsupported event by returning its size. */
> > > +               return event->header.size;
> > > +       }
> > >
> > >         events_stats__inc(&evlist->stats, event->header.type);
> > >
> > > --
> > > 2.49.0.604.gff1f9ca942-goog
> > >
