Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567E77102;
	Thu,  9 Jan 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457150; cv=none; b=DpVEKJ1vBKLI8kslcnRVRWt+UOlmpPQXFnB+carDLvEwpe5259UQ8keO0azCjB+/f4dWZ2ZfUZlfpxJGdHOFY0UhrFPaIpgN02FumtJOvWqE/HfDa/Pe9yfhQdcey5oq5vI391zLvbizjR6B5U96u2mDexqLDSExq8IGp++wk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457150; c=relaxed/simple;
	bh=TCAiQGvm7z2TGTHIP9IMrFPbrSJmvnu/nSl/JEwMepk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js74Qqt0qjnmPX1RQWChHYuYRGu+gAu6ptGajr7iUMCx2qnXHWLpbTX5XGVCHyPiJCKsGgC0HWrQmjqEjhiMErAqxv2OTVD4x446XJkP0h4URv1stom0dTWPi5YbjY8mw6NFoTQsy2jYZlULBfxiQN94EUmfx1AMzhYgdDwDvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5iA+EkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5iA+EkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240BBC4CED2;
	Thu,  9 Jan 2025 21:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736457149;
	bh=TCAiQGvm7z2TGTHIP9IMrFPbrSJmvnu/nSl/JEwMepk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5iA+EkN4/VcJxmj3OzvnYd9M2XZVbC9l2+UjdDUjkypqpb/h/wdHyVOJPut9TXFb
	 5UdX+FvD3luhlTk02oWk0hYLzT6+baY6raVZCvRiDxThC3CpG6TH0UP4YpUWGWmKwZ
	 LnTre4wo6g3Al/c5H0ewFdolbyzNwb5V1kpBGMAeiV1Rxob2fsn42y5vw+D/cgfdem
	 LrSL5g9f5oidFLVfXFc3q62IrfyYHvzG4Tgd1In9844O+I68Rt6uYLolwVz7/7SxOy
	 c17xhdqaSAJDI2B1cc92wUUbgiqtoRDmIgFoTLANQOWgNj7cjBK8Vr2xry/Siuywmk
	 6A8Mi/m4/txEw==
Date: Thu, 9 Jan 2025 18:12:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol-elf: Avoid a weak cxx_demangle_sym
 function
Message-ID: <Z4A7uhizNDptyxNE@x1>
References: <20241119031754.1021858-1-irogers@google.com>
 <CAP-5=fWBEGj-bKnfF3bi+qy3nzrV+oWzDj-0M5bRe2kQSsJ2Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWBEGj-bKnfF3bi+qy3nzrV+oWzDj-0M5bRe2kQSsJ2Tw@mail.gmail.com>

On Thu, Jan 09, 2025 at 09:58:34AM -0800, Ian Rogers wrote:
> On Mon, Nov 18, 2024 at 7:17 PM Ian Rogers <irogers@google.com> wrote:
> >
> > cxx_demangle_sym is weak in case demangle-cxx.c replaces the
> > definition in symbol-elf.c. When demangle-cxx.c is built
> > HAVE_CXA_DEMANGLE_SUPPORT is defined, as such the define can be used
> > to avoid a weak symbol. As weak symbols are outside of the C standard
> > their use can lead to strange behaviors, in particular with LTO, as
> > well as causing issues to be hidden at link time.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo
