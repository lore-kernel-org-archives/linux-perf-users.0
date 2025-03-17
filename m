Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9117BBF;
	Mon, 17 Mar 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248176; cv=none; b=DSLKRyoew19nHCln1pWwKyuOUcr/BHIC0geHuXvQAoyNv9UWrW0HWe4flkqP8Qc+yVTPXZpzrqdRej7j767Lw+2Dp00T+D/RcwUpxZHQPeZGd+GqHpMZ92usx+XjikX3Kgtojyr0dOLDTAR/q7iR8wymyCvxAYH0ugXBjlhoYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248176; c=relaxed/simple;
	bh=/wCYfE+EMp9V72QENhOztlDP5qRyAb44a7nwShdYS8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gos3jYPnHwkGjEyILE1RCVdX7uo/FjYCaSYwyvVvuY/Vwp6WTYcIvJmx5Qc0rwyJPk8XZ2i4hxM0f6X8QUQRBwzpOGnjfaQGxdrwl0UxEJ2X3kwv6SzqwgsKkmD1vvV0G6iNtA8sqi2WVu5+PmQlreazKVozzlxLNSUzmRLA8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGrlYqRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGrlYqRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0D8C4CEE3;
	Mon, 17 Mar 2025 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742248175;
	bh=/wCYfE+EMp9V72QENhOztlDP5qRyAb44a7nwShdYS8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGrlYqRLPbU3622gBUWiSv+gWGG73cchyje6hdi/yt5+3wl7HIgcm+TNpWA+vpyyG
	 lxQ1ZWWRk+YC0sk3iGAm/RdaoATRwKWZGVv2S0zFrSYJi9115w/vN8MBlOLyY9ZkAR
	 Akq59Ti+RC/7u8M1KP13BVcy2D5WBp20z+dXd0L0lUjQOzTyFc1yp6UO9CAlAcUIvt
	 Jz6BEEo3H73pDQJ2pQDSXCWVY1h/MC6ZHx29zTm6tlAhHF3d+z80lvGJzMr289Qb81
	 h3SJKwHTgLd/ZCsfQ4m+flL5zDA8yWeskfblIx7bMjn1jZqA6Em4yUmr/++S76pjW3
	 d/mxuAdt66D6Q==
Date: Mon, 17 Mar 2025 18:49:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9iY7HFebiSaWZJQ@x1>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
 <Z9hLKsZOfouM3K7H@x1>
 <Z9hR8M-SQ5TD2qMX@google.com>
 <Z9iHiTv_ud6GEhJh@x1>
 <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>

On Mon, Mar 17, 2025 at 02:45:39PM -0700, Chun-Tse Shao wrote:
> On Mon, Mar 17, 2025 at 1:35 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> > > On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Checking the discussion and the patch.
> > > >
> > > > My first impression yesterday when I saw this on the smartphone was: how
> > > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> > > > ignore it while emitting a warning, since it can be skipped and then
> > > > what we will get a partial view?
> > > >
> > > > Having some session output showing how an older perf binary handles
> > > > PERF_RECORD_COMPRESS2 would be informative.
> > >
> > > I think it'll show the below warning:
> > >
> > >   <offset> [<size>]: failed to process type: 83
> >
> > Right that is what I got:
> >
> > ⬢ [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/perf.data.ck8
> > 0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
> > ⬢ [acme@toolbox perf-tools-next]$
> >
> > I think we should change that to something more informative, like:
> >
> > 0xbf0 [0x250]: failed to process unknown type 83, please update perf.
> >
> > And then does it stop at that record it doesn't grok?
> >
> >         if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
> >                 pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> >                        head, event->header.size, event->header.type);
> >                 err = -EINVAL;
> >                 goto out_err;
> >         }
> >
> >         head += size;
> >
> > So we're stopping there.
> >
> > Maybe we can just warn and skip?
> 
> Thank you Arnaldo, it is a good suggestion and I will work on this later.

Thank you for considering that, really appreciated!

perf deals with so much stuff and code flux that all the help that we
can get is what is needed for it to continue to be relevant and useful.

After all what is the point of a tool that produces bad results? :-)

- Arnaldo

> -CT
> 
> >
> > Anyway, the series as is seems ok.
> >
> > I'll test a bit more and send my Tested-by
> >
> > - Arnaldo
