Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7130FF28;
	Tue, 16 Dec 2025 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864721; cv=none; b=ZewRPDdwhCjnBcVP1pyDlHhX3Om7dC2RmRrlwMrHSa0o9P36uPuAqQlsf8eyc7SLLswLLplentlQ1mR23mb940Ae01Efe7CVCTmhxuf+6v7bgX/vP3mg2/CMe5Nt/TeVy72Brwv+TRUh4PFlk8G7an8pAwJvlHxt9WiA/gRi3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864721; c=relaxed/simple;
	bh=jXPmhm72CV3dKewlBv8S34ZCradhhBDjrU9I/5DvHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr4uAo44sY682Mrwz0hXOcnm5yspDYV5v3IwyIRxOPLeUzVOalccQzJW8UfHEqbIKOaH5bCeoGb/w3c6BA1TJzwF02IfLWZZRSVSfZNBR1TZ5yU+VGSRES5BlK0//svDDM4naxLw844e3T/dQa4B/86kpqGZMXDQ4r4/nU16Ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXaY+N9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXaY+N9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F42C4CEF1;
	Tue, 16 Dec 2025 05:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765864720;
	bh=jXPmhm72CV3dKewlBv8S34ZCradhhBDjrU9I/5DvHa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXaY+N9nVq0vmLVXdpw/Y2sMeQuLNZ28qZczZVNRvgK4AnrEklj68S1KGTkNjoRmZ
	 a+jf9pfulRcfQa3M9I+SwA0Fkw02mhEInbe5OMeRMWoY1g/rMeqQ84bY4gHfrg2gkH
	 CCveRNjTEs3b3IuUgvscK+WfzhEcKxagA+VW+onB17ot7iGV85deiKCY+EIdwPkNnG
	 4OMyxhIHIQj6Lc8ttcIQ9X910caqSv+afYbBmyceW6fO6o7THxK5zFBiyrt/iGSE2W
	 p/AcYh+mXqHqr8GlAl1XC0QVx7iwF6lyY02Y/HKQOBsE95t8WAMU1YLh8D3/hR5xyz
	 1qVY8ALOFrZ6g==
Date: Mon, 15 Dec 2025 21:58:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: Leo Yan <leo.yan@arm.com>, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <aUD1DXHh_PrCjZ96@google.com>
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com>
 <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com>
 <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
 <20251211103957.GA4048253@e132581.arm.com>
 <CADHxFxRayyDK5qO3j-GtQAuWruk8UtQ-6EcvYb-3iKtE8ooJUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxRayyDK5qO3j-GtQAuWruk8UtQ-6EcvYb-3iKtE8ooJUQ@mail.gmail.com>

Hello,

On Fri, Dec 12, 2025 at 02:12:09PM +0800, hupu wrote:
> Hi Leo,
> On Thu, Dec 11, 2025 at 6:40 PM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Wed, Nov 26, 2025 at 09:44:02PM +0800, hupu wrote:
> >
> > Please don't spam on mailing list as you did. It is really bad practice.
> > You could find resources [1][2] to learn upstreaming and co-work on the
> > ML.
> >
> 
> I apologize for the inconvenience caused by my frequent emails. I only
> hoped to bring this nearly two-month-long discussion to a conclusion
> sooner.

Sorry for the delay.  But sometimes it takes time to get a consensus in
an open discussion.  And it's been in a merge window + travelling for
LPC 2025.  Please don't hurry up.

> 
> 
> > > The eBPF skeleton is compiled via clang --target=bpf, and its header
> > > file search paths mainly come from BPF_INCLUDE and TOOLS_UAPI_INCLUDE.
> > > It also uses '-idirafter' to include the host’s /usr/local/include and
> > > /usr/include directories in the search path. This process is not
> > > directly coupled with cross-compilation managed via pkg-config, which
> > > means PKG_CONFIG_SYSROOT_DIR does not affect how the skeleton resolves
> > > its headers.
> >
> > Based on my limited knowledge, Clang does not provide its own headers.
> > It needs to rely on GCC's headers for compilation.  I do see the
> > Makefile does right thing for finding headers:
> >
> >   Makefile.perf:1203: ***
> >   CLANG_SYS_INCLUDES=-idirafter /usr/lib/llvm-18/lib/clang/18/include
> >   -idirafter /usr/local/include
> >   -idirafter /usr/bin/../lib/gcc-cross/aarch64-linux-gnu/14/../../../../aarch64-linux-gnu/include
> >   -idirafter /usr/include/aarch64-linux-gnu
> >   -idirafter /usr/include
> >
> > It is mess to add some random include paths and feed to clang.  We
> > already have provided a reliable way for building eBPF skelton program
> > - keep in mind, eBPF skeleton program is not any aarch64 cross
> > compilation, we just use clang for building bpf target.
> >
> > My understanding is you don't have a sane setting up on your local
> > building env.
> >
> 
> Although I have explained my view in earlier emails, it seems the
> discussion has returned to the initial state.
> 
> Indeed, as you mentioned in the early discussion, running the
> following commands on the host to install certain packages can
> successfully compile perf:
> > $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cross
> > $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross

At this point, I'm confused whether we are talking about general
cross-build or just BPF skeleton.  I agree with Leo that the skeleton
build should not require any host specific information rather than
vmlinux.h.

> 
> 
> However, I don’t think relying on the host build environment is the
> best approach, for several reasons:
> 
> a) These commands install UAPI header files on the host, especially
> `linux-libc-dev-aarch64-cross` and `linux-libc-dev-arm64-cross`. These
> headers originate from the kernel source tree’s `include/uapi/` and
> `arch/arm64/include/uapi/` directories, and their versions are tied to
> the *HOST* kernel version. If the target kernel version is different,
> mismatches may cause compilation errors or even runtime failures.
> 
> b) Even if `perf` can be compiled and run successfully now, there is
> no guarantee that the kernel source headers will always match the
> host-installed UAPI headers as the upstream kernel evolves.
> 
> c) In scenarios where the host acts as a general build server and
> needs to build multiple target kernel versions, it is not possible to
> ensure that the host UAPI headers are compatible with all target
> versions.
> 
> d) As you pointed out, `CLANG_SYS_INCLUDES` does include host headers,
> but it uses `-idirafter` instead of `-I`. This means the host headers
> have lower priority. This change was introduced in commit a2af0f6b8ef7
> ("perf build: Add system include paths to BPF builds"); as noted in
> the commit message, the preferred approach is to use kernel source
> headers rather than potentially older ones from the system.
> 
> 
> Based on this, I propose the following include order:
> - Prefer kernel source headers
>   [RFC] perf build: Use self-contained headers from kernel source when compiling
>   https://lore.kernel.org/all/20251124072310.3592-1-hupu.gm@gmail.com/
> 
> - Allow users to specify header search paths matching the target
> kernel version (eg. via `EXTRA_BPF_FLAGS`)
>   [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
>   https://lore.kernel.org/all/20251013080609.2070555-1-hupu.gm@gmail.com/

I'm ok with this part - not only to pass header search paths, it can do
anything user wants to add to the compiler.  You may want to send it out
in a separate thread with all comments addressed.

> 
> - Fall back to the host build environment only if necessary
> 
> 
> In summary, while relying on the host build environment can fix the
> current build issue, I believe it is not the optimal solution.
> 
> Anyway, regardless of the final decision, I will respect it. Before
> concluding, I hope we can explore this further and involve more
> maintainers in the discussion. As for your comment, "you don't have a
> sane setting up on your local building env", I am not yet fully
> convinced by this reason.
> 
> Lastly, I once again apologize for any disturbance caused by my
> frequent emails, and I sincerely thank both you and Namhyung for your
> involvement throughout this process. I also hope this discussion will
> attract more attention so that additional maintainers can participate.

Thanks for your understanding,
Namhyung

