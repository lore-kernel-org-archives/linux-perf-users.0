Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DC17BBF;
	Mon, 17 Mar 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243044; cv=none; b=POYDmJMPpXQ9uUWed6owq1a3fYnEUypsY3mCkEqNvxBRVS+SH+zrx+iYKuAlpxeSgxDpf9nAkwRjbMidkTtPHpbgTfxInINbxWTqIk2Z+858T3k9Y/4MqrM80H3pZkMsPGkOSrGeA6S19ylop2yxRDbWkvBKiVj2d5bR39Nk2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243044; c=relaxed/simple;
	bh=7wiR+gIArNL2z74k6ec6JpFPzazGuy6Kgrr6V0hYra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feYZUEbHL5D7VwkEo28At+4VCokBf4K1Rmr07CA8x510tqgH/jdSyXUqERgoWf5UCpRvD7dVoQ0JDWZ3Dw6aLJ7yCvQBPvgYyjpOTsrG8Ppga/AdzVxyt1z2prHZeeHuM69KwQx+d3soouy6lcuFCg+AkE7JXtTzslztiwEjjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch4sgKMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch4sgKMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0212C4CEED;
	Mon, 17 Mar 2025 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742243043;
	bh=7wiR+gIArNL2z74k6ec6JpFPzazGuy6Kgrr6V0hYra0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch4sgKMxH3QkI0T4iaeDOQiqN6eOJI4i9gtMO2Y4d2ja3c2qfiOMjHX04K135Mx6n
	 tn5A41wKFkF7GqIpaDuVWFqT2M6ZGPdjeUROcnfkNkpEhkdm+EMSx3FdkjiEQzTsvr
	 0BbEyWS1BtwfEdfBYJEY7kJ19kiVobiGc7SdN5a0hrINhGsWCmtZfIpQmiGgLvMJBW
	 /4JGJtXu+/+XMS2KrnJvupBNpj73Rzar9w/6vleMq5r1ZoKtI21B6sktA70QmmzkZE
	 pRUnmL+yh08LAA5FCj0ZOh22sa+2du1OkuqUcE3J2ZoNqLwZTvSMPSNX/lQOLYTjO/
	 KqOwOpL40gJ8Q==
Date: Mon, 17 Mar 2025 17:24:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Chun-Tse Shao <ctshao@google.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com,
	leo.yan@arm.com, james.clark@linaro.org,
	christophe.leroy@csgroup.eu, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9iE4Dv3Eo3rhj6M@x1>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
 <Z9hLKsZOfouM3K7H@x1>
 <CAP-5=fXOBp1F0eXbgjyjZd0K-=trqugmROttwSWT_M393HxeEQ@mail.gmail.com>
 <Z9h5pS4DyLaNp3tO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9h5pS4DyLaNp3tO@x1>

On Mon, Mar 17, 2025 at 04:36:05PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Mar 17, 2025 at 09:32:46AM -0700, Ian Rogers wrote:
> > On Mon, Mar 17, 2025 at 9:17 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Fri, Mar 14, 2025 at 06:27:05PM -0700, Namhyung Kim wrote:
> > > > > On Mon, Mar 03, 2025 at 10:32:40AM -0800, Chun-Tse Shao wrote:
> > > > > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> > > > > > asan runtime error:
> > >
> > > > > >   # Build with asan
> > > > > >   $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
> > > > > >   # Test success with many asan runtime errors:
> > > > > >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
> > > > > >    83: Zstd perf.data compression/decompression:
> > > > > >   ...
> > > > > >   util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
> > > > > >   0x7f69e3f99653: note: pointer points here
> > > > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> > > > > >                 ^
> > > > > >   util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
> > > > > >   0x7f69e3f99653: note: pointer points here
> > > > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> > > > > >                 ^
> > > > > >   ...
> > >
> > > > > > Since there is no way to align compressed data in zstd compression, this
> > > > > > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> > > > > > `data_size` to specify the actual compressed data size. The
> > > > > > `header.size` contains the total record size, including the padding at
> > > > > > the end to make it 8-byte aligned.
> > >
> > > > > > Tested with `Zstd perf.data compression/decompression`
> > >
> > > > > Looks good to me.
> > >
> > > > > Arnaldo, are you ok with adding a new record type for this?
> > >
> > > > Checking the discussion and the patch.
> > >
> > > My first impression yesterday when I saw this on the smartphone was: how
> > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> > > ignore it while emitting a warning, since it can be skipped and then
> > > what we will get a partial view?
> > >
> > > Having some session output showing how an older perf binary handles
> > > PERF_RECORD_COMPRESS2 would be informative.
> > >
> > > I'll try to reproduce/test this all...
> > 
> > I'm not sure we've worried about old perfs being able to read new
> > perf.data files, but we've worried about new perfs being able to read
> > old perf.data files. So if a change is additive, which this change is,
> > then nothing should be impacted.
> 
> Right, its difficult to make it work both ways, even with testing, but
> by 'work' I mean that new stuff should be ignored by older versions,
> i.e. records skipped and then the results will surely be different.
> 
> So I'm just curious how older tools will handle these new files and to,
> if not that super difficult, to improve how we handle unknown records so
> that in the future, when we add new stuff, we mention that this is
> something not handled, please use a new tool.
>  
> > My thoughts are this way as this patch:
> > https://lore.kernel.org/all/20220614143353.1559597-7-irogers@google.com/
> > changed most perf.data cpumap encodings in a way that old perfs won't
> > be able to handle.
>  
> > Perhaps testing/documentation should be present for this kind of thing.
> 
> Right, but in this specific case it should be a matter of telling the
> user that the header.type PERF_RECORD_COMPRESS2 isn't supported and that
> the user should try and update their tool.
> 
> But now back to figuring out how to generate PERF_RECORD_COMPRESS is
> generated, use it, then apply this patch, and then see if how the old
> tool copes.

Which is present in this series, we have even a perf test shell for it,
so happy to not having figured that before :-)

  # Build with asan
  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
  # Test success with many asan runtime errors:
  $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
   83: Zstd perf.data compression/decompression:
 
> So documentation is also lacking in suggesting that enumerating the
> steps needed to test before/after is greatly appreciated.
> 
> - Arnaldo
