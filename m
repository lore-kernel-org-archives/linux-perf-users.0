Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A045BE3;
	Mon, 26 Jan 2026 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463353; cv=none; b=VAs1cC9zIL9Da0NXaI3f/m4Uk3yiOMiFm2DNw4VcPyJOj5sLRToAtTVVb/ZwvPdzurY/3mul7RWdsqydFrLZoX1u5FJK6CIiFx11jiDwu1v67va8pfvert5VMHvrrOVhlNyto3K1TjI669FH4P9chYylvCFOvIUwi0cLdTfLWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463353; c=relaxed/simple;
	bh=dLnj9X0boGFdgIegZi8+CUt86oC98tvUP8Gqf9B+KEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIcrBXFo+w7RCRr5uInUiDwU26s41wPoG4nzSBchx0pbRbGxjLxwPK9eopzsuLg2IZ8jqvduhCmkIfj+E/u9TRpIw7jd55AUePyVUdm1Nr0xxMWjpmwsKhpnEHSFRlbpoCFFheZaFoGk/mQhfSlrj4AQ/tKqOmkCzvWu5hBru3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuzothNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuzothNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E548FC116C6;
	Mon, 26 Jan 2026 21:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769463352;
	bh=dLnj9X0boGFdgIegZi8+CUt86oC98tvUP8Gqf9B+KEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuzothNEt9ijGzSzGxNYnvAIRxfq96Q7eWkveQf6CAZo7/VDRVJIYkuP3Vtwu2soG
	 YaYADDyZd9yUNUxD/nEb7Y3ow8nu12iiMpxMzZ5brGJaEzPkRKUoQxAVd/oAjvRF3j
	 GdWpVAcxGDDFmu6SYcu1N2b9LJD5cgH4u37e1jmEQFgdz0jJB80zwkg94aNGXvVif9
	 7kOeZnqUBJvtehVnQN75TsQD6yOWRa0UEdUDMOpECMas4kEEcNZpSCtAX1mMD7NzZA
	 jAVOHZoConLWyu7Vzvmu70Qdp4iAYkbgKnxW2fLNgGrb44f23rAlvh/Q7wYF5IzPon
	 Mv9oVgL7GD5vA==
Date: Mon, 26 Jan 2026 18:35:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>, Andi Kleen <ak@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf more ELF machine usage
Message-ID: <aXfeNfYgDVXhkrKM@x1>
References: <20260124001611.1332019-1-irogers@google.com>
 <aXfUFBfCQ4m_DFrx@x1>
 <aXfUNewGdbqqQL18@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXfUNewGdbqqQL18@x1>

On Mon, Jan 26, 2026 at 05:53:09PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jan 26, 2026 at 05:52:39PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 23, 2026 at 04:16:08PM -0800, Ian Rogers wrote:
> > > Switch 3 more cases where the perf_env arch was being used to
> > > determine the architecture type and switch to using the ELF
> > > machine. This includes the addition of minimal instruction parsing in
> > > perf script for architectures other than x86, or x86 when
> > > cross-platform.
> > > 
> > > Note: this series will conflict with the e_flags series:
> > > https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@google.com/
> > > that adds an additional out argument to thread__e_machine. In all the
> > > cases here that argument should be NULL. So:
> > >   thread__e_machine(thread, machine)
> > > becomes:
> > >   thread__e_machine(thread, machine, /*e_flags=*/NULL)
> > 
> > This one isn't applying.
> 
> ⬢ [acme@toolbx perf-tools-next]$        git am ./20260123_irogers_perf_more_elf_machine_usage.mbx
> Applying: perf script: Fix script_fetch_insn for more than just x86
> Applying: perf callchain: Switch callchain_param_setup from an arch to an e_machine

So, please try to refresh it with what is in tmp.perf-tools-next now.

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -10
0a6fb6604746c92b (HEAD -> perf-tools-next, x1/perf-tools-next, x1/HEAD, perf-tools-next/tmp.perf-tools-next, five/perf-tools-next, five/HEAD, acme/tmp.perf-tools-next) perf session: Print all machines in session dump
2becdd163ab37c9d perf unwind-libdw: Wire up e_flags for CSKY
0403930f7b1534e3 perf perf_regs: Accurately compute register names for CSKY
4e66527f8859a661 perf thread: Add optional e_flags output argument to thread__e_machine
7d0ebeb6c0f735d4 perf dso: Factor out e_machine reading for use in thread
76b2cf07a6d2a836 perf vendor events amd: Fix Zen 5 MAB allocation events
008603bda19b2968 perf test: Fix test perf evlist for z/VM s390x
dda5f926a1006c73 perf annotate: Fix BUILD_NONDISTRO=1 missing args->ms conversions to pointer
9966b382d06733f7 tools headers: Don't check arm64's unistd.h
129bb23a6f7d0226 Revert "perf tools: Fix arm64 build by generating unistd_64.h"
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
