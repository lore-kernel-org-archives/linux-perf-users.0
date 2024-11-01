Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFFB156880;
	Fri,  1 Nov 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489713; cv=none; b=vFYRWT5ivAWg4vTdCFHLdFQzw1N42KVBmn5SMkXX28AYozbhoqqc+Hgn2P1o/uE2scDQ3/ZxSOy6ceTvxHAYBMeQLquazeAOFjscoUtZ2CNFb8ythwmhKnJ/Zdgxcrpx8fnfm85s4SwFQHzbh8camxtv/Kknnom6LE+rUW+ChSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489713; c=relaxed/simple;
	bh=q6SXcTHXCTXBGwlW3/5+N4Hlf+y87fpz3fCr/0g8z1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIY0n8HXobvtkeCB+o/bAyx/Xun8vuL26YQ7uyx5PrbCWfByQ585CT7EXs3W9fgCHnmOYpMF4m8CzLw5b4EcBKZ7GElQ0G8PKcwJuQxOYaIkL6uUqVvovYexYW4WN324cnv9qW4RWZf3kod4mIC9YsWimzXP7pxr4kFhd6/KM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKPOyqtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKPOyqtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB04C4CECD;
	Fri,  1 Nov 2024 19:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489713;
	bh=q6SXcTHXCTXBGwlW3/5+N4Hlf+y87fpz3fCr/0g8z1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKPOyqtInd+ududObXfkqcJhzbQ98lScx05OqXh3zHwWjz2BnPVXAJJspgxo3t3g3
	 8vC5beRPTwny8A0EX1qC3MIwtfWirYkZpuFxj3wtz8KTJ5LyGJuR8zMgyQw2GB3Gb5
	 NmOKv0IXDY9pJZ17rT3olsFX/3ZbWWuBmPzdUcQO3AwqfAy9JVBRCF7YC9ttwhKqwf
	 Bp6+pFVwrFL+afltUjChZqXwDTFiCuhdX14SHs4utjy5RoFRubWzgV318ofH0hVCyn
	 CBu60GTUlsNZ9zpIo3WlXbylBBLClzZEGwRA5Dq1InDXII8EIPltUy8aijzD+KFtqe
	 n5AXEfxi95lJQ==
Date: Fri, 1 Nov 2024 12:35:10 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101193510.53xj5ybz6vyyqb37@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
 <20241101190908.GV29862@gate.crashing.org>
 <20241101193305.afwfopg4ryrrgxfb@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101193305.afwfopg4ryrrgxfb@jpoimboe>

On Fri, Nov 01, 2024 at 12:33:07PM -0700, Josh Poimboeuf wrote:
> On Fri, Nov 01, 2024 at 02:09:08PM -0500, Segher Boessenkool wrote:
> > On Thu, Oct 31, 2024 at 04:03:13PM -0700, Josh Poimboeuf wrote:
> > > Actually I just double checked and even the kernel's ELF loader assumes
> > > that each executable has only a single text start+end address pair.
> > 
> > Huh?  What makes you think that?  There can be many executable PT_LOAD
> > segments in each and every binary.
> 
> Right, but for executables (not shared libraries) the kernel seems to
> assume they're contiguous?  See the 'start_code' and 'end_code'
> variables in load_elf_binary() load_elf_interp().

Typo, see load_elf_binary (not load_elf_interp).

-- 
Josh
