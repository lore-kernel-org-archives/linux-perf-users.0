Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFD191;
	Sat,  2 Nov 2024 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730507887; cv=none; b=tWps2T7Cbk3+GTpvaWHQfXP+SFtVkmjYqbZtiXoed+fU1b3slT7daw3cN+hlQ6DzVF8EVhVL4dkw0jxnJ/c8s7sLaafc9UOibh5miuG+xDoSrnSlW2yfz7RA/m3R4IAdLVm6FDlaZeGIAZCo1PofevogjWPDBc5Iiq7rsSioNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730507887; c=relaxed/simple;
	bh=JFK1OHVqTofEDq3leWsTvT03TNJPeYi4cNAO7FLcsmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HePn47fGifjYi8WWHEZO4Fuyy5vVPChMOoNHHGCXlGjHLPB2h/h+wvdAovSrwZ6SHloAFb5uBt+PrOemy5PUv6GSLq95QFbTpd2NZ7rwRc2zfn1iilExoe47LO1X0TiKl9BXBg25P5mFMoZrarl0oIoQ8Mp9mANSzFMxcZg3wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAeSHjuF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAeSHjuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235ADC4CECD;
	Sat,  2 Nov 2024 00:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730507886;
	bh=JFK1OHVqTofEDq3leWsTvT03TNJPeYi4cNAO7FLcsmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAeSHjuFr/X2PgBrC0GfOEsdFPZxqJBmAWFhVXHBgM3PGf7XjVv1tSYNKnDw+uQgq
	 qFVkobVEevn7EAuCMxmdjqYa2cWjdlJVswgtuZfZoJpXrHZ69YuaKZRrPL5YWFh8dZ
	 CCYAV31482ubwjKopaSTbOmBtxmHkqHl/g8lG0saeDJo6OqdSRhkIgILl9lk3T4ez8
	 92ZzOzWNs3eQMeoV8wN6PIGYI1oP9q/t8yBIhJAKD22kjVXdXBvJngdN0NGQCx2LTK
	 n2DMLz7la9GdqttmpeCafpiFxQjHbhxt3KJIrYJDj28FkVH5hY9fl1Fz0lP1ldWL8c
	 Wy3IgO3bX2bmA==
Date: Fri, 1 Nov 2024 21:38:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf trace: avoid garbage when not printing a trace
 event's arguments
Message-ID: <ZyV0a6e_46R9pmQw@x1>
References: <20241101005338.5846-1-benjamin@engflow.com>
 <20241101172714.84386-1-benjamin@engflow.com>
 <CAH0uvohNO517GAD7XH-VvUvU+dPdeZBKDw0Teij50sAPSe9sCQ@mail.gmail.com>
 <ZyVIgKcAuqZSYYB1@x1>
 <CAEmfU+ufKWoJLvhksPzADMKkbinV37Tv1KODU6RdJfBM9Juy7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmfU+ufKWoJLvhksPzADMKkbinV37Tv1KODU6RdJfBM9Juy7w@mail.gmail.com>

On Fri, Nov 01, 2024 at 02:41:46PM -0700, Benjamin Peterson wrote:
> On Fri, Nov 1, 2024 at 2:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > I haven't tested it yet, just in my mind :-)

> > The patch looks ok and seems to fix a real problem, my only concern, a
> > pet peeve, was that it, in addition to fixing a real problem, did an
> > unrelated change, the "Remove the return value...", that part looks like
> > a distraction, something that shouldn't be there.
 
> In my mind, it was related because both the bug and the odd return
> value arise from incorrect counting of the number of written bytes.

> Obviously, the fix is what I care about, so feel free to strip out the
> return value change on import, or I can resend.

The point is to try to focus on the fix, and do just what is needed for
that. Everything else ends up being a distraction.

- Arnaldo
