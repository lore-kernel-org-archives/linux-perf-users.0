Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830F2DC32D;
	Wed, 20 Aug 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726057; cv=none; b=qhm9rw3x4VJQwJ5JTRz6tHxCLMj6w7imTvyKrD4ESK6C5e8y8OIu7DFwVK3+R+f2HtqgVKcaOgpcoTIMtAVDFNFnBCDQ6UkRLSzHqEchmwEfeVW1iZ5cKuGKeiAsqP5tiCUiu0esOwo3uwSwuJ1eMGPEstCauW8sc9vcKrXNxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726057; c=relaxed/simple;
	bh=oDw28D3aQR3jAC01L4+9zN4szMeSl06K1tKTSdrq4S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkwiNCnFIPKHVFGmBi+DdwzkCMEz8fbj5EGJjmLAMPU7EU5t4/1vtlurNszfuHsP7zDbqi2IxqLdV8QcG9NarKUFxHaTAIs8JoodbAJ5TtZTIaRmtfw0KzIhpOpmkN+yztDcq1lk2MTax3IScj7MlzIgcZ9IHhmFd8h7x2iPOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX745Hq3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX745Hq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D01C4CEE7;
	Wed, 20 Aug 2025 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755726057;
	bh=oDw28D3aQR3jAC01L4+9zN4szMeSl06K1tKTSdrq4S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FX745Hq3KtdkB/ELuwWOlr2iNlgKMhYw3sGGNvb0FiRHN2vutcQ8wm6BavhTsB7oT
	 KSdVoxl5kzGZprTp4raN/7nzFhjrDQk9eyuSKiz1NXqYGDmWEnRgjGLKnqjOWJt46E
	 wH+TfX1qycAHsep5zCaa58XnTdwrDMcqVPG9oB2MJlrY5Per6j1E7oPYb0+8tdFyv9
	 oEjyzXKNwO7pquE36QIGh1mGfWqn4SgSHYuJDE36qTuWBHvE5Btl692KsM0KZU9Mog
	 CBylXhe9Y7q+9/9l/l/wNe8LkXJu4HNEPlmHlE2yjwoSV0W3rRk5zY+pR7pUXVTPNO
	 2DFKlIg+kbMgA==
Date: Wed, 20 Aug 2025 18:40:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET v5 00/12] perf annotate: Support --code-with-type on
 TUI
Message-ID: <aKZA5bE1ibDMJpuw@x1>
References: <20250816031635.25318-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>

On Fri, Aug 15, 2025 at 08:16:23PM -0700, Namhyung Kim wrote:
> 
> Hello,
> 
> The --code-with-type option is to show normal annotate output with type
> information.  It was supported only on --stdio, but this change adds it
> to TUI as well.
> 
> Arnaldo, please tell me if you still don't like the
> __hist_entry__tui_annotate() but I don't have a better idea for now.

Not a problem, I tested everything, all seems to work as advertised.

The minor suggestions I made I can do while merging, if you don't mind
and agree with them.

Please let me know.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> v5 changes)
>  * use a copy of hist entry for perf top  (Ian)
>  * split disasm_line__write() change  (Ian)
>  * constify annotation_write_ops parameter  (Ian)
>  * update printed length calculation  (Ian)
>  * remove annotation_print_data.start
>  * add a hashmap to skip duplicate processing
> 
> v4 changes)
>  * add dso__debuginfo() helper  (Ian)
> 
> v3 changes)
>  * hide stack operation and stack canary by default
> 
> v2 changes)
>  * use 'T' key to toggle data type display  (Arnaldo)
>  * display '[Type]' in the title line when it's enabled  (Arnaldo)
>  * show warning when debug info is not available  (Arnaldo)
>  * fix a typo  (Arnaldo)
> 
> Actually the command line option sets the default behavior and users can
> change it by pressing 'T' key in the TUI annotate browser.
> 
> The code is also available at 'perf/annotate-code-type-tui-v5' branch at
> https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (12):
>   perf annotate: Rename to __hist_entry__tui_annotate()
>   perf annotate: Remove annotation_print_data.start
>   perf annotate: Remove __annotation_line__write()
>   perf annotate: Pass annotation_print_data to annotation_line__write()
>   perf annotate: Simplify width calculation in annotation_line__write()
>   perf annotate: Return printed number from disasm_line__write()
>   perf annotate: Add --code-with-type support for TUI
>   perf annotate: Add 'T' hot key to toggle data type display
>   perf annotate: Show warning when debuginfo is not available
>   perf annotate: Hide data-type for stack operation and canary
>   perf annotate: Add dso__debuginfo() helper
>   perf annotate: Use a hashmap to save type data
> 
>  tools/perf/Documentation/perf-annotate.txt |   1 -
>  tools/perf/builtin-annotate.c              |   5 -
>  tools/perf/ui/browsers/annotate.c          | 117 ++++++++++++--
>  tools/perf/ui/browsers/hists.c             |   2 +-
>  tools/perf/util/annotate.c                 | 178 +++++++++++++++------
>  tools/perf/util/annotate.h                 |  29 ++--
>  tools/perf/util/dso.h                      |  21 +++
>  tools/perf/util/hist.h                     |  12 +-
>  8 files changed, 273 insertions(+), 92 deletions(-)
> 
> -- 
> 2.50.1
