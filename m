Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0E3FDBF4;
	Fri, 15 May 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869237; cv=none; b=BCGuU8rXOOPyWNjsEKLzzZ+0NapkbJvoCUTG7HdjxxhLKuNb/qJx5zcdSrNXBUmvfk8x/uiVO480IbL/Y1YO/VUDqEYKxa27ETIMitrzwkUdRIDRZljuyU5lK37+2BvdqcuSrovgDgi5OcEeJof717ZXSGxGgq+da9yY2iJwzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869237; c=relaxed/simple;
	bh=nqssV7sZ/S3jHloOKYysjt9cDB/9LWCwSQ5/juatcwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/P9IFvXV2h84FBfs68cD+3EZjwxLnFuNu4DtH2VO7ekwaJSIlF7qR7Slhzpb1l9yW/JtVHEOvZEonL+WPMNBSwwaXkrTfyjiH0s/JP02c4K/jhLmxeJJlL42anMlq5uc1XOpM5hQtcqUsq4EwdVJBuGOOap43+MdqzHr/jcyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdCOZmMA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdCOZmMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BC2C2BCB0;
	Fri, 15 May 2026 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869237;
	bh=nqssV7sZ/S3jHloOKYysjt9cDB/9LWCwSQ5/juatcwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdCOZmMAoJQ2Vz7MwPrkliVBwwtwXz25FFAP/KH19ObbcyVb2B+emNiTxFmyrbLNZ
	 SXZhL3PbG3cqAJAxXnkhgxyEUJVT53a+5JkYr5foB/a3tndiA7JmK27LBFGsLUN6sn
	 BF74RBe9XwVa43wCiKCyyHe3/b7pFRilkmW0ALOD+F3rj8oS07IH/0IpHpK+/Yublg
	 ba98d7jaaSOxaZXJTA83SZaTtXN5h39F5HGBb/5Yti/cngFBtfY9o+fv3xId9Qtwp9
	 2mjz0rqEQtU7dFVof8zqpI8AOR7rRE4m7evIQqEh9bcraYyt2iMvhUtt+RydR6OcGw
	 TPfkgqjukO9ng==
Date: Fri, 15 May 2026 11:20:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, alex@ghiti.fr,
	alexandre.chartre@oracle.com, andrii@kernel.org,
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu,
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com,
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com,
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org,
	leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com,
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me,
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com,
	tglozar@redhat.com, thomas.falcon@intel.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 00/17] perf build: Reduce build time by nearly half
Message-ID: <agdj81gaSSWyJkQI@google.com>
References: <20260512174638.120445-1-irogers@google.com>
 <20260514163409.927816-1-irogers@google.com>
 <agZHYSFneOSIo8d5@google.com>
 <CAP-5=fUJFRcXFdpSy_X23NSU7zMp9SVZEqX+cEBsKP9YARGRvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUJFRcXFdpSy_X23NSU7zMp9SVZEqX+cEBsKP9YARGRvA@mail.gmail.com>

On Thu, May 14, 2026 at 03:23:34PM -0700, Ian Rogers wrote:
> On Thu, May 14, 2026 at 3:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, May 14, 2026 at 09:33:52AM -0700, Ian Rogers wrote:
> > > This patch series refactors Kbuild internals, BPF skeleton generation,
> > > Python AST pre-computation, and foundational tooling dependencies across
> > > the perf tool build system. By eliminating umbrella target synchronization
> > > barriers, decoupling static library prerequisites, parallelizing single-core
> > > script generators, and eradicating redundant feature checks, this series
> > > unlocks absolute theoretical peak multi-core concurrency during Kbuild startup.
> > >
> > > On a 28-core build workstation (make -j28 all from scratch), clean build
> > > latency improves by over 49%:
> > >
> > >   Before:
> > >     real    0m29.006s
> > >     user    2m46.019s
> > >     sys     0m30.610s
> > >
> > >   After:
> > >     real    0m14.782s
> > >     user    2m39.527s
> > >     sys     0m22.938s
> > >
> > > Saving 14.2 full seconds time per clean build. Furthermore, nothing to
> > > build incremental builds are improved by nearly 7x:
> > >
> > >   Before:
> > >     real    0m11.528s
> > >     user    0m9.633s
> > >     sys     0m6.965s
> > >
> > >   After:
> > >     real    0m1.729s
> > >     user    0m1.600s
> > >     sys     0m0.884s
> >
> > I've quickly checked it with latency profiling like below:
> >
> >   $ perf record --latency -- make -C tools/perf
> >
> >   $ perf report --latency -s comm
> >
> > The result looks like this.
> >
> > Before:
> >   #
> >   # Samples: 715K of event 'cpu/cycles/Pu'
> >   # Event count (approx.): 422452811481
> >   #
> >   #  Latency  Overhead  Command
> >   # ........  ........  ...............
> >   #
> >       45.28%    71.33%  cc1
> >       34.48%    16.92%  python3
> >       11.15%     2.21%  ld
> >        2.58%     1.51%  x86_64-linux-gn
> >        2.22%     0.99%  cc1plus
> >        0.71%     0.63%  sh
> >        0.69%     0.14%  llvm-config
> >        0.62%     0.56%  clang
> >        0.57%     4.40%  shellcheck
> >        0.44%     0.12%  perl
> >
> > After:
> >   #
> >   # Samples: 709K of event 'cpu/cycles/Pu'
> >   # Event count (approx.): 416654798495
> >   #
> >   #  Latency  Overhead  Command
> >   # ........  ........  ...............
> >   #
> >       64.99%    71.16%  cc1
> >       15.07%     1.81%  ld
> >        7.14%    17.59%  python3
> >        3.66%     1.53%  x86_64-linux-gn
> >        3.48%     0.75%  cc1plus
> >        1.11%     4.43%  shellcheck
> >        1.09%     0.74%  sh
> >        0.86%     0.59%  clang
> >        0.77%     0.12%  perl
> >        0.45%     0.23%  make
> >
> > Now I see a big drop in the latency from python.  And the llvm-config
> > doesn't show up in the top 10.
> 
> This looks good. What is "x86_64-linux-gn", and since we default off
> LIBPERL, why does perl show up in the commands?

I don't know exactly, but it seems we have some path to run perl during
the build even LIBPERL is off.  This is what `perf report --tasks` shows.

   3577076  3577076  3576925 |    sh
   3577077  3577077  3577076 |     make
   3577078  3577078  3577077 |      sh
   3577079  3577079  3577078 |       gcc
   3577081  3577081  3577079 |        cc1
   3577080  3577080  3577078 |       grep
   3577082  3577082  3577077 |      which
   3577083  3577083  3577077 |      sh
   3577084  3577084  3577083 |       perl
   3577085  3577085  3577077 |      sh
   3577086  3577086  3577085 |       perl
   3577087  3577087  3577086 |        pwd
   3577088  3577088  3577086 |        sh
   3577089  3577089  3577088 |         x86_64-linux-gn
   3577090  3577090  3577089 |          cc1

Thanks,
Namhyung

