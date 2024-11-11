Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF925777;
	Mon, 11 Nov 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345879; cv=none; b=HftTrAq3XvUTmpVUmxMP6DPaiJW4TuYJFrZabdWCf1rUFb6WJVJ9KtpM59JPoAR8LfAHPAbQsOjR+Bnu+NEC0zaJ/EEwR4eT35LCg5PBNexPj8q1P29O27jAlisXjLEF8VLdaEqqnHs9HtFDxATp+bCuiREMwxA0DwCtEpZqinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345879; c=relaxed/simple;
	bh=xh1BIOn6bTtRRTvFH8GTfXspQZ3u7OOmcZloPlJEqzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPuOWddTzqc/6A4PDsrfEIEg8eKCjn8LIVohfkUNPkX47m6S8pCbas0qGyCEGemB+OoSvlmv4hHc0zhXiYLuKgsDBTZzffuo+uMyWxybN++LmGf7isao4R8rWk7jfMMvohpfjGgAXJ/UWSs/KrlF60Io9t+/Mun7DLWZ8ZgH58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7SdwfcC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7SdwfcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75B9C4CECF;
	Mon, 11 Nov 2024 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731345878;
	bh=xh1BIOn6bTtRRTvFH8GTfXspQZ3u7OOmcZloPlJEqzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7SdwfcCZ3ubq69yN1nbJKfM59dgwusxM0Nr07mp/DfRjE0q9Dm5M4V910i6+0zig
	 B3064haTYJl1ikMfYeiBGaO8rPiROP3EUemOmBJr+KM1ZkgVb5YQjsNGe1jNhJ+vFL
	 sMa2iQ6YJbQrUv3qe9vaU3WPVbsbg88tstsKRtOeU5szHqA0P1EcgewVDocswyDJy3
	 WIXI/8jlS9xW9IWIpMUqpMEdj6AhSafO30AH7rrcZokHIUlF3JArAy/ckhrXWTn8fD
	 wGDjDLNnJ0dByciB0UqKcX6QehSs8NYPEVUHtG7+ALokrDm5U7uAErDgvFsE9UO0Ze
	 zHZXWQoDjJ/dA==
Date: Mon, 11 Nov 2024 14:24:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Subject: Re: [PATCH 3/3] perf disasm: Allow configuring what disassemblers to
 use
Message-ID: <ZzI90g83cGIKSUDu@x1>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-4-acme@kernel.org>
 <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>

On Mon, Nov 11, 2024 at 08:27:38AM -0800, Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 7:18 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > The perf tools annotation code used for a long time parsing the output
> > of binutils's objdump (or its reimplementations, like llvm's) to then
> > parse and augment it with samples, allow navigation, etc.

> > More recently disassemblers from the capstone and llvm (libraries, not
> > parsing the output of tools using those libraries to mimic binutils's
> > objdump output) were introduced.

> > So when all those methods are available, there is a static preference
> > for a series of attempts of disassembling a binary, with the 'llvm,
> > capstone, objdump' sequence being hard coded.

> So it LLVM is the preference can we just switch to using the LLVM ELF
> libraries, etc? :-) I was a bit surprised to see LLVM as preferable to

I'd have to look up the discussion to see how this ended up being the
default when LLVM is available, but when I wanted to have source code
intermixed with it and noticed that the LLVM output doesn't have it,
that lead me to try to make this selectable so that we can go from one
to the other when needing something not available in one of them.

On my todo list, and here Steinar could help, is to check if we an have
source code intermixed with the llvm based disassembler, like we have
with the objdump based one.

> capstone, which feels more agnostic in the LLVM vs GCC/binutils wars.
> Fwiw, I'm happy with LLVM being the preference.

<SNIP>

> > After adding a way to select the disassembler from the command line a
> > 'perf test' comparing the output of the various diassemblers should be
> > introduced, to test these codebases.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Steinar H. Gunderson <sesse@google.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks!

- Arnaldo
