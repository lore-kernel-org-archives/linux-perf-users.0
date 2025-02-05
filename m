Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C7214809;
	Wed,  5 Feb 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789581; cv=none; b=pD4bYogylq6cSjVIC5+e1PIPeGDQM7wvmaLT4Zd7qnLC/aeWTYDwBB0eYssNiJH4ull+nLX6DDc01QWGFBgWyrOKbT0lvL2yHqJJLITCm4fBFghRZYOl5zbSWLa4S37Esl2SDdjiK/M4EOqOQqmfw7MMQlvZsO5uvokb57hE07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789581; c=relaxed/simple;
	bh=AiIPzFi3NtjILcKsr5MTO5wUE8lC7N3CQFTazXuzfOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWjDAubekhqL5WT8J88JhZC7O/9Qidpf1ResUzWhJdC/wkk2CMjVXdwNIAnurAyNV3QCvVix27zJAaBkkR1S+/0yRfpoN6O/SucnrOaM8zXNurhYP2k419Oo9fkLOAUQ5MIUNJv+EMgRRiQVih9tr2oAJxbo6oLZFbYspYDANHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEXpXVQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEXpXVQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E890C4CED1;
	Wed,  5 Feb 2025 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738789580;
	bh=AiIPzFi3NtjILcKsr5MTO5wUE8lC7N3CQFTazXuzfOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEXpXVQJXLZDx2sYQq5jypGAHbIziQLEkbkjfWq7acTr6O6EYn38ygVa4Q3NiLiIN
	 GiZ8dJt8qTcRNyDpLMU7isBB8C4ToZsXEQPT2/c6hKX7pgzXxPc1+OPYpfMEk/2/QC
	 AtXDUQoboZfrfuYy3NzdpysOIOD9LufAwBUJ6QLPU1bIBvG6HlevsRRhOFA+KAsu77
	 IT8/g2xahraIH62SEdhhzeMCLGxemSO80mtO3rAE1VjeBPBXnSqqrty0VvObSoNYlA
	 TIo+JFp5JiC0uR5DItBrfR8kF32QhcBfAGYc5olUmND2nd6KA6mVGTBBy42omniBX3
	 KM4QzjjM1h19A==
Date: Wed, 5 Feb 2025 13:06:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol: Add rust v0 demangling support
Message-ID: <Z6PSyvPJ09b3pfPE@google.com>
References: <20250129193037.573431-1-irogers@google.com>
 <f500ef21-5c87-4c60-8453-d98ee637a60c@app.fastmail.com>
 <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>

Hello,

On Mon, Feb 03, 2025 at 09:20:30AM -0800, Ian Rogers wrote:
> On Thu, Jan 30, 2025 at 11:35 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Ian,
> >
> > Thanks so much for working on this!
> >
> > Only did a quick skim. Seems like it'd be nice to reuse the official
> > demangler now that we know about it. Will be interesting to
> > see how that gets packaged for distros.
> 
> I think the best solution is to use the official demangler but in
> general we'd like fewer rather than more library dependencies. For
> example your initial comments were to work to make the coupling with
> capstone and LLVM disassemblers more loose via dlopen:
> https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/
> 
> Thinking through the options (note I'm not doing Rust things and so my
> level of skin in the game is minimal):
> 1) stay as we are - well this is a mess as there is no v0 support and
> the legacy support comes from libbfd/libiberty.
> 2) option (1) plus this change cleaned up - there's still the mess
> with the legacy support, which is probably more important given v0
> isn't widely adopted.
> 3) wait for the official demangler to be packaged as a library and
> depend upon it, add testing from here - solves legacy and v0 issues,
> but brings in an extra library dependency to the build. Timeline not
> clear.
> 4) "contribute"/copy-paste the official demangler into perf tree and
> do like (3). Perhaps remove the forked file when a dependable library
> exists (there's some precedent for this with how libtraceevent was in
> and then removed from the linux tree) - solves the timeline, not great
> to fork the official demangler, so far not heard from the author Ariel
> Ben-Yehuda and I would strongly prefer they contribute rather than I
> copy-paste it.

Agreed.  I'm hesitant to add this change to perf code base without
commitment of the Rust community.

Thanks,
Namhyung

> 
> For (3) and (4) it is probably a good idea to engage the Rust folks in:
> https://github.com/rust-lang/rust/issues/60705
> 
> Having broken Rust demangling seems like a high priority issue for the
> perf tool.
