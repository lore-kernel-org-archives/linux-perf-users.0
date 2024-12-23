Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13628DA1;
	Mon, 23 Dec 2024 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983513; cv=none; b=X92ruAyF5A/3RHqW8WFoXrzKrmtPOrUSKlAnhMi+f9wyOBHKbBjC3K+WigCG2cTR0Vaam4Bchqa7Uk9viw7ZWvyBp0L7rHOE3hqrvgQ4IHekKtxiJv093Xu+nai/Uu3mXxMmtzuff27TTZ92LLsPFq3wGLn8n2/wJtl0UmW068o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983513; c=relaxed/simple;
	bh=UsYahmch1gKBsuoAkxq7nmbcCehd4gQrfxSHVui/7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvkNMob7iKhHtVqgPDijbtZZSwWvEWcoo2+Va+g2KDRXsiC+2ssIPCeG/zjEtMioGZX2ZAvvObLGUiGU4MywO3lJOedHG6XxA1Gtx8ES8p6kinwtNhBP5dRTls5SfcUrfgoRBCAK52WM496+W09PpyMBHXjXrV1u4sS/Keg824U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbukbRd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbukbRd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35612C4CED3;
	Mon, 23 Dec 2024 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734983512;
	bh=UsYahmch1gKBsuoAkxq7nmbcCehd4gQrfxSHVui/7cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbukbRd3j0uDU4sjhvZ03D95wYesC1b3OGrYWEYY4C+iMkExt0ZLHUEd8VD09c6pi
	 0leTnkbw7+v4NsmgWm4Tw9SMC2JDwv6cutONRDPHK2WLRJGdv2stFCua1RU3CiXQkV
	 0ii60ZyuZ65tXiRnUA7OcAbs3pTyvtryY28Te8Y3Rw4n2kmgNVLAg6i4zS3MHFae78
	 3bI2SRbEn6zau9vUob1dXLtn8wZulBppoFBQFwJhJf9ltd5bGJkc92VnIZgDci7uhP
	 TNQVbTmWngHiU27Lo4aR6QI8t2HOz+bu1sfeDL+WjjvIAlXWVirJ9SnqNy250NeRJK
	 S9o7Ur7p/IE4g==
Date: Mon, 23 Dec 2024 16:51:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Cc: Francesco Nigro <fnigro@redhat.com>, Ilan Green <igreen@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/5 v1] Processing java JIT dumps from containers
Message-ID: <Z2m_VVM-vXGVor_z@x1>
References: <20241206204828.507527-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206204828.507527-1-acme@kernel.org>

On Fri, Dec 06, 2024 at 05:48:23PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	This is trying to move the needle on supporting jitdump done
> from a container while perf is running from the outside, that is not
> working right now.
> 
> 	I tried to collect as much details on what is being done in the
> commit logs to document further work that needs to be done to support
> such a scenario in a streamlined way, but what in this patchkit at least
> helped in a real case, allowing us to get 'perf annotate' to work and
> confirm suspicions.

I'm going to apply this to perf-tools-next, please holler if you
disagree.

- Arnaldo
 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (5):
>   perf config: Fix trival typo 'an' -> 'can'
>   perf jitdump: Accept jitdump mmaps emitted from inside containers
>   perf namespaces: Introduce nsinfo__set_in_pidns()
>   perf jitdump: Fixup in_pidns member when java agent and 'perf record' are not in the same pidns
>   perf namespaces: Fixup the nsinfo__in_pidns() return type, its bool
> 
>  tools/perf/Documentation/perf-config.txt |  2 +-
>  tools/perf/util/jitdump.c                | 15 ++++++++++++---
>  tools/perf/util/namespaces.c             |  7 ++++++-
>  tools/perf/util/namespaces.h             |  3 ++-
>  4 files changed, 21 insertions(+), 6 deletions(-)
> 
> -- 
> 2.47.0
