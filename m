Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8281C69D;
	Tue, 20 May 2025 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756357; cv=none; b=JoNSOot66njcmIX4B3p2caIzx51/fuctYxQnvroWS7BVJiBOinZYCE21QmRJCC86e8ZH/UVDr5UiXgR0DMYPNf36iUbvr3ZdZJB9K2Zw+P1qezcUHVyTkQXoELZw2ZWmZRJj/RxfC5fQEoU9Jnbl2liUIRnQ3bVLPqC1Rwi0dw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756357; c=relaxed/simple;
	bh=mmgg73v2jzwkpcaoNnwqn6tjFg4oJjClM289A0Fi0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkI3SMpVOgxBoNeK+8uMBEGoW1FuBc5vE1dhMkYPCkm+S4W796ZwWFS74ixsMvpxwJEukyeLtHOiQJkHB5fquLcH0R3BI8w2ycVwrXxFNmxNRgbRZJfb/PRymNWMcRFxsa1T/9aRqzjxWJkgt1sQ+nbydHn3s+caDoUJurlqVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb0KetSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb0KetSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BF9C4CEE9;
	Tue, 20 May 2025 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756356;
	bh=mmgg73v2jzwkpcaoNnwqn6tjFg4oJjClM289A0Fi0Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb0KetSSys8o5YRXMNo0ePTvTcD0X1Dq7V20AuMoON7KdJnku7V+9MCd/5n35G4wN
	 FJ2lA4aeCjCq+PyduCwBZc9lPPof78DOMYJw4itfvgrdsik14XgVTdbDrfqf/5qJRd
	 0QwtGWVoYqQXy14WUrmEVnJWuIbR/eHhS+ENqKVqPGdA/f7XMOZxniMCYeikBnwJaU
	 cniAOksalB3jBk8twlxmBqofEGPAu68FLpVdVuwJxWIR1T4/1lcSPTp4+Pm1hf3oFq
	 GJGSp70ZjSCNMDxj58i5pZwEx6y2kBEFrxYOT2fJMkSlNsSurFYn1fhiw5ePFmI918
	 HtFAaeUSZoTow==
Date: Tue, 20 May 2025 12:52:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
Message-ID: <aCylQUlY3W7rbZAs@x1>
References: <20250519214126.1652491-1-acme@kernel.org>
 <CAMZ6RqJUf=LpczMNu9WwLik9i-4tJHYENvM3d15nxjNM+_vc5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJUf=LpczMNu9WwLik9i-4tJHYENvM3d15nxjNM+_vc5w@mail.gmail.com>

On Tue, May 20, 2025 at 09:44:05AM +0900, Vincent Mailhol wrote:
> On Tue. 20 May 2025 at 06:41, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >         Updating some kernel headers with the kernel sources.

> >   tools headers: Synchronize uapi/linux/bits.h with the kernel sources
> >   tools headers compiler: Pick the const_true() define from the kernel
> >     sources
> >   tools headers: Synchronize linux/bits.h with the kernel sources
 
> Note that there are new upcoming changes in bits.h and build_bug.h
> which are queue in the bitmap tree:
 
>   https://github.com/norov/linux/commits/bitmap-for-next/
 
> So, if you prefer, you can wait for the beginning of the merge windows
> when the above changes will be merged and do the sync with all those
> changes (this is just a suggestion, I am not objecting to this series
> in any way).

I think there is value in doing it now, as it clears up the build
warnings and solves already one prep work that syncing would entail,
namely the inclusion of const_true() in the tools compiler.h file.

I think I can take your "I am not objecting to this series in any way."
as an Acked-by?

Thanks!

- Arnaldo
