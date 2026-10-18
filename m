Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C54D4882;
	Sun, 18 Oct 2026 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340800; cv=none; b=lWESyXEKwRNnvCrHfgBVZ8I7zPDnMiROedsGJybwUmG3iedRwY2D/P10AdSt0GaOrU319VeOHmqe5YF2GmTk6GATr5TzmyZCZPiFpJmwapvhIg7kOhBy0xONAMPPcIw8y+C9DPP8VBYlsCz32a8QtA6Mylrp+T6RGMYhJRUyxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340800; c=relaxed/simple;
	bh=OEEx0dlobv67lzd13O1rEYRQGAPQ98o8Kptz9a/PdS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqWX05gyZC7D/5TPAvvxdUXVEfv4EOZbHv67zFvuQIoocqqveR2tHYTlR9HHiEH6wmBctW8G4x7sym2bgVdX0pRgIxhotlNJdbqWx34F0LFXcHoVkzBDiGWxatHrlFqQmsN2oIktsWbe3MKk0TRJF9bDwLsR0kzfqvSOvvUmWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOGsMcZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOGsMcZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F721F000C4;
	Sun, 18 Oct 2026 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792340799;
	bh=gYsjcOuJ8RvseAN9vU8QaSbB2+GoxMgbSDabUxmiCWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cOGsMcZnBNAlfkRepca8DGGWX4PM6WzExH9LB8Y6/Uh5tDwoOoiJZ+mMbiHlrP5EQ
	 eN8GAQa9WhYsQaRGw21NmpZ9tt9R9C5oXoOwcN7uv/1lNjVuOQ7RdBdvZBQtDX3IEk
	 vvDFionoZbOg0Kby70+n2pwYjHz9gRN2qW3Sztj5QfR6iGdWdEw8X572GV27jrvnp+
	 baKefuKvJi4BO4Z6apYr42cUu4Etcke/eW0LfkE0iYXpPtQqwxgnxjrbCY32Yxr6Z6
	 G6QlKu4gDwjfVr2yp2WfGWyilZlYQ9PhaGcUYiWsrJFqmbsd/VNaV8hE9zYEwZr0KQ
	 05PqQPlc/xm4g==
Date: Sun, 18 Oct 2026 09:26:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] perf dso: Allow reading DSO data from an explicit
 file
Message-ID: <atTzPJJvR2-sqtJn@google.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com>
 <asbDJrY97tRqoPaR@google.com>
 <CA+w=M=TtAfiHVQqiwmchtsWwNeN5So5MxWW=82RRAUXHhg8D+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+w=M=TtAfiHVQqiwmchtsWwNeN5So5MxWW=82RRAUXHhg8D+A@mail.gmail.com>

Hello Alireza,

On Sun, Oct 18, 2026 at 08:09:41AM -0700, Alireza Haghdoost wrote:
> Hi Namhyung,
> 
> Sorry for the late reply, and thank you for the clarification.
> 
> On Wed, Oct 7, 2026 at 3:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I'm afraid it may confuse perf annotate where it needs to read binary
> > data from a file as well as lazy-load symbols from another.  I'm working
> > on cleaning up the relevant code and I'm reluctant to add 'path' to the
> > dso.  We have too many names for a DSO already. :)
> >
> > For a short term solution, I'm afraid you need to use dso__get_filename()
> > with symtab_type and read the file without using the data cache API.
> 
> I understand the concern about storing this path in the DSO. Perf
> annotate and the lazy loader can read different files. I will drop this
> patch in the next revision (v6).
> 
> For context, the v1 lazy loader kept one file descriptor open for each
> DSO. In your v1 review, you asked me to use dso__data_read_offset().
> This let the data cache control the open descriptors and close them
> when necessary.
> 
> Using dso__data_read_offset() also showed a problem with split
> debuginfo. The symbol name offsets refer to the symbol table file.
> However, the data cache opens the runtime binary. The same offset in
> these two files can contain different data. That is why I needed to
> tell the data cache to open the symbol table file.
> 
> I put this support in a separate patch after your v2 review requested
> that I split the exact-path DSO data-cache support into an independent
> split-debuginfo fix.
> 
> For v6 revision, the lazy loader will call dso__get_filename() with the symtab
> type. It will open the returned file, read the names with pread(), and
> close the file. Thus, it will not keep one descriptor open for each
> DSO. It will also not change the existing data cache.
> 
> This short-term solution can open the same file many times. It also
> cannot use one DSO cache entry for nearby names. However, later reads
> can usually use data that is still in the kernel page cache and avoid
> storage I/O. Therefore, the main additional costs are the open, close,
> and pread system calls.
> 
> The performance cost is small in the test profile. Eager loading takes
> 3.2 seconds. v5 lazy loading takes 1.4 seconds. v6 lazy loading takes
> 1.5 seconds. All three produce identical output.

Thanks for checking this!

> 
> > In the long term, I think it needs to pass a binary type arguments to
> > read data from the dso.  It'd clarify what users want to read and
> > support different files at the same time.
> 
> Ack. Your recent cleanup keeps the binary type separate from the symtab
> type during symbol loading. The DSO also has a separate debug-info type.
> These fields identify the files that a caller wants to read. The data
> cache does not use this information yet.
> 
> Unless you are already working on this part, I can send a separate
> series to make the data cache type-aware. The series will add a type
> argument to the read API and keep separate cache state for each backing
> file. I can then change the lazy loader to use the data cache again. I
> will keep this work separate from the lazy loader patch series.

Sounds good.  Please go ahead!

Thanks,
Namhyung

