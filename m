Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8543DA32;
	Tue, 20 Jan 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935007; cv=none; b=mbFJewpizk9mXaf3k9/NYfaWl0yHPqYVFFDLQ9Flxfo7HAAwoHsxkpOyUm5eEKm97nJI98SAfhKY1WKx+LDdfKYHHsW+gMtQa+7Bd5gVTtffZfThgb9IqHOIr4E2RDWGAZvqE73QmezIy9xsb1iVYlLX1raktpvt8k0woHgQpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935007; c=relaxed/simple;
	bh=RmGeyuXo1uW+F5wAFWT4FNRAvYpuDuojoTmkmG6thsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yzbz48GTE8SWtVq/8wAW6pG1falw7vVUDj5QdMW73/C+TTDr3P2BOxIu4z48zUG9ySl7LoV383U+eOWKj1xl3r2f1/ADHsUFET2DH+6iw/N4dGnTxp76oRr5YLzrLP/9Xl7rwLZWG7Xc6MK09if4jSm1p817iWOUYqzd4iBSsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMFr0HUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMFr0HUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20CAC19421;
	Tue, 20 Jan 2026 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935002;
	bh=RmGeyuXo1uW+F5wAFWT4FNRAvYpuDuojoTmkmG6thsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMFr0HUnW2gYIg+E4/T/nh+T/QfHDMc2TLB2/zszUt0HXKwvhCRhKh4lcMkeSr2Ne
	 AAWnRTO264ZmkDHhpojE9ivFIjL+XA73XMS5r+nNVLd7nonTTwtkPMmxSOji3WXASy
	 VSYLaCKzBf02zAAWW9tcwWC9QBfANo4NPsJznBVq6coq8SMiOHpFoKSiaZ/c0wJnLF
	 vclTuYh5uRyhvj90KnGJeh4pjcU+OgAFq0Awl0SbsRStoKqGhb4e8ah+XE//Tc7nSp
	 42nG8H7qsbqyoxTVwfbNmkswQXM9rx3sjGlQxnnNZ0s5ek61vtiB0LniK69jN8Q1tX
	 +V9Z+6Eh30Y6w==
Date: Tue, 20 Jan 2026 15:49:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Shimin Guo <shimin.guo@skydio.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org, Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH v1 08/23] perf perf_regs: Switch from arch string to int
 e_machine
Message-ID: <aW_OV72q5rAVrgRE@x1>
References: <20260117052849.2205545-1-irogers@google.com>
 <20260117052849.2205545-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117052849.2205545-9-irogers@google.com>

On Fri, Jan 16, 2026 at 09:28:34PM -0800, Ian Rogers wrote:
> The arch string requires multiple strcmp to identify things like the
> IP and SP. Switch to passing in an e_machine that in the bulk of cases
> is computed using a current thread load. The e_machine also allows
> identification of 32-bit vs 64-bit processes.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c                   |  17 ++-
>  tools/perf/util/evsel.c                       |  14 ++-
>  tools/perf/util/perf_regs.c                   | 105 +++++++++++-------

[ Include dwarf-regs.h to get conditional defines for EM_CSKY and EM_LOONGARCH, not available in old distros ]

- Arnaldo
