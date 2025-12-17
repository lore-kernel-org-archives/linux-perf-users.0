Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8CE1F03D2;
	Wed, 17 Dec 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985724; cv=none; b=BUFsaciQVcCp511G5JrZo9Kb4HHZD4vx78Osd+CWZFx4rEXcBoPccWZo4I4t1PazQBxV9S2Q+M04x4/t2nyX82aYu+x1s5RwsWFCH5h9SL9l2gMKYo1Km4n2rFz1VcGuEl9q48nE5qXBrJZVNFwZkqIxGJUNHrDREF0EqMG7hkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985724; c=relaxed/simple;
	bh=mGTvjCP67a7sqLAlPPGI62JJ/KHGZaK7PhiGCKVe/vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piBF3nx1E22zsvkm3bZH1yUFKO4JjjoOkzcEsMRffPzUouGrzOTNKMTn6TeDwrN/eup15t3iP9ewA1fBvFEvjIzgSeYJCMeDn/F+kwtPPBoOlJjSRxzFBQdu3iO0KrweCrNafwT2o7YS3TiHB9nEQzax5yBsqBTR9ZsuzaxkEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGg+IwRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGg+IwRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E26C4CEF5;
	Wed, 17 Dec 2025 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765985724;
	bh=mGTvjCP67a7sqLAlPPGI62JJ/KHGZaK7PhiGCKVe/vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGg+IwRNV5gLAGKaocp4Zguq67X/VZ0WfkHn52rmw+f2GrUuf31weXuVw+j/bLF6y
	 VZjiqa699MyMVaO/EPz8px9K8uxc067UV/Yld5s5n445irfywVW1WeZJXzp+wb426L
	 1QBVybHTZBZAaVBO+IFsNrQFDFjZNlcoFnkBCpSiLAHWOLphCxuqoaNIW/6JNgXPOR
	 CWbye4P3NZvqz+3NPMazhnpiZDXU5CfmHn6Yez3uzhMXaW5gV2JZO6Tbd2ONAtyaHv
	 LF/DN/NBKsuqM9Nb8ALMkhQ4xZXOyrNPI7SxqZQF8GStLe/YKxRzxwGKstLTqKGKXN
	 ixa6jIPawenNQ==
Date: Wed, 17 Dec 2025 07:35:22 -0800
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
Message-ID: <aULNulWRaFarbXCk@google.com>
References: <20251124073445.3709-1-hupu.gm@gmail.com>
 <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com>
 <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
 <20251211103957.GA4048253@e132581.arm.com>
 <CADHxFxRayyDK5qO3j-GtQAuWruk8UtQ-6EcvYb-3iKtE8ooJUQ@mail.gmail.com>
 <aUD1DXHh_PrCjZ96@google.com>
 <CADHxFxRrXP+vueYh=pMpGUWXCYUvrju0NO34SFUAB=okfDgpSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxRrXP+vueYh=pMpGUWXCYUvrju0NO34SFUAB=okfDgpSQ@mail.gmail.com>

Hello,

On Tue, Dec 16, 2025 at 08:29:04PM +0800, hupu wrote:
> Hi Namhyung,
> Thank you very much for your reply.
> 
> On Tue, Dec 16, 2025 at 1:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > > Indeed, as you mentioned in the early discussion, running the
> > > following commands on the host to install certain packages can
> > > successfully compile perf:
> > > > $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > > > $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cross
> > > > $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross
> >
> > At this point, I'm confused whether we are talking about general
> > cross-build or just BPF skeleton.  I agree with Leo that the skeleton
> > build should not require any host specific information rather than
> > vmlinux.h.
> >
> 
> I agree with this point. This is also what I was trying to express
> earlier: although installing some additional packages on the host can
> indeed make perf build successfully, in my view this approach is not
> an ideal solution.
> 
> > >
> > >
> > > However, I don’t think relying on the host build environment is the
> > > best approach, for several reasons:
> > >
> > > a) These commands install UAPI header files on the host, especially
> > > `linux-libc-dev-aarch64-cross` and `linux-libc-dev-arm64-cross`. These
> > > headers originate from the kernel source tree’s `include/uapi/` and
> > > `arch/arm64/include/uapi/` directories, and their versions are tied to
> > > the *HOST* kernel version. If the target kernel version is different,
> > > mismatches may cause compilation errors or even runtime failures.
> > >
> > > b) Even if `perf` can be compiled and run successfully now, there is
> > > no guarantee that the kernel source headers will always match the
> > > host-installed UAPI headers as the upstream kernel evolves.
> > >
> > > c) In scenarios where the host acts as a general build server and
> > > needs to build multiple target kernel versions, it is not possible to
> > > ensure that the host UAPI headers are compatible with all target
> > > versions.
> > >
> > > d) As you pointed out, `CLANG_SYS_INCLUDES` does include host headers,
> > > but it uses `-idirafter` instead of `-I`. This means the host headers
> > > have lower priority. This change was introduced in commit a2af0f6b8ef7
> > > ("perf build: Add system include paths to BPF builds"); as noted in
> > > the commit message, the preferred approach is to use kernel source
> > > headers rather than potentially older ones from the system.
> > >
> > >
> > > Based on this, I propose the following include order:
> > > - Prefer kernel source headers
> > >   [RFC] perf build: Use self-contained headers from kernel source when compiling
> > >   https://lore.kernel.org/all/20251124072310.3592-1-hupu.gm@gmail.com/
> > >
> > > - Allow users to specify header search paths matching the target
> > > kernel version (eg. via `EXTRA_BPF_FLAGS`)
> > >   [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
> > >   https://lore.kernel.org/all/20251013080609.2070555-1-hupu.gm@gmail.com/
> >
> > I'm ok with this part - not only to pass header search paths, it can do
> > anything user wants to add to the compiler.  You may want to send it out
> > in a separate thread with all comments addressed.
> >
> 
> Thank you very much for this suggestion. I understand that you would
> prefer to continue the discussion in a new, separate email thread, and
> I am happy to do so.
> 
> Before proceeding, I would like to clarify your intention to make sure
> I understand it correctly and avoid any misunderstanding. Since the
> discussion above involves two patches with different functionalities,
> I would like to confirm whether you would prefer me to combine these
> two patches into a single one, or to discuss and resend both patches
> together in a new separate email thread.

No, I just want EXTRA_BPF_FLAGS part.  Preferring the kernel source
would need more discussion.

Thanks,
Namhyung

