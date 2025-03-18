Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F181A2658;
	Tue, 18 Mar 2025 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274823; cv=none; b=HZQUzSyZoK7n4d3fbNImJlXqe6aDzy84rzRY2bgF/xAiiUHHAqWmHaOg0JhLeunSgM7FflfQkV+o4EF8iVOZ80XDytVCTPf+i+pPbxzUCv7hm96XkxpMDsO03I7XaYFO8d6BoC50FQzaYI1hon879Nj9M+u0zjS4Aghupi10+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274823; c=relaxed/simple;
	bh=FpqEoMvLZZbzDNMQjsR3ddD0f7hqt+e//jLM7cJCWOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6wC7OhhP7eu+xsiDHo45S+tmsKoVuJoLDLeCjEaUYna5A2cC2Bd9o5CLnugVWlwkfOF9fAKjOuxw0kQ1MkD8Odc4Qbbr9W8qE/tc/amK4CRwaENnUZ/Yq1Jz2go97RzXusD0g0V3EwqgeSeY1vxnhJ3sH7t4XMGgbMcFz5FWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NorVFyOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NorVFyOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A6FC4CEDD;
	Tue, 18 Mar 2025 05:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742274820;
	bh=FpqEoMvLZZbzDNMQjsR3ddD0f7hqt+e//jLM7cJCWOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NorVFyOhoHI5PdssCyTHuQHwG1QwuCoY5c//MwEtZBzeugCKBlhRIecfGKbkB5nA0
	 vbZF2WrVp85g9aOvIJT5rWAdu8r5IRhgCoS/g7j1gEEuw51Ac1XrBySUR9zni4ZQYS
	 n4DBWGOEroTqH9iTNOB33ugKsNMJQWGg7GOHWVb+tuua7E2rkoj14JLlHs57i7SVDh
	 3QKLWMsLInudcwMSzLJZaOc/W30qU/JWu7iQadWeUYfUbv8jmFv5XAirC1oZTAfI8f
	 qh9c63YPO2WojH/F+jd5swC0pDiRYyH+NUSrxCe0+L6E8DJnDa7u4cbG1V8IhkZwPt
	 zDPlJ3PlT7Fqg==
Date: Mon, 17 Mar 2025 22:13:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9kBAhEKKphn8JL6@google.com>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
 <Z9hLKsZOfouM3K7H@x1>
 <Z9hR8M-SQ5TD2qMX@google.com>
 <Z9iHiTv_ud6GEhJh@x1>
 <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>
 <Z9iY7HFebiSaWZJQ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9iY7HFebiSaWZJQ@x1>

Hello,

On Mon, Mar 17, 2025 at 06:49:32PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Mar 17, 2025 at 02:45:39PM -0700, Chun-Tse Shao wrote:
> > On Mon, Mar 17, 2025 at 1:35 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> > > > On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > Checking the discussion and the patch.
> > > > >
> > > > > My first impression yesterday when I saw this on the smartphone was: how
> > > > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> > > > > ignore it while emitting a warning, since it can be skipped and then
> > > > > what we will get a partial view?
> > > > >
> > > > > Having some session output showing how an older perf binary handles
> > > > > PERF_RECORD_COMPRESS2 would be informative.
> > > >
> > > > I think it'll show the below warning:
> > > >
> > > >   <offset> [<size>]: failed to process type: 83
> > >
> > > Right that is what I got:
> > >
> > > ⬢ [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/perf.data.ck8
> > > 0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
> > > ⬢ [acme@toolbox perf-tools-next]$
> > >
> > > I think we should change that to something more informative, like:
> > >
> > > 0xbf0 [0x250]: failed to process unknown type 83, please update perf.

That would be nice, but there are cases it can fail even without new
record formats.  So it should also check if the type number is greater
than or equal to the max.

> > >
> > > And then does it stop at that record it doesn't grok?
> > >
> > >         if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
> > >                 pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> > >                        head, event->header.size, event->header.type);
> > >                 err = -EINVAL;
> > >                 goto out_err;
> > >         }
> > >
> > >         head += size;
> > >
> > > So we're stopping there.
> > >
> > > Maybe we can just warn and skip?
> > 
> > Thank you Arnaldo, it is a good suggestion and I will work on this later.
> 
> Thank you for considering that, really appreciated!

It would be hard to process misaligned data though.  Probably we also
want to add a check to make sure it's properly aligned.

Thanks,
Namhyung

> 
> perf deals with so much stuff and code flux that all the help that we
> can get is what is needed for it to continue to be relevant and useful.
> 
> After all what is the point of a tool that produces bad results? :-)
> 
> - Arnaldo
> 
> > -CT
> > 
> > >
> > > Anyway, the series as is seems ok.
> > >
> > > I'll test a bit more and send my Tested-by
> > >
> > > - Arnaldo
