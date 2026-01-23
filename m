Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169B3EBF3D;
	Fri, 23 Jan 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190433; cv=none; b=BgughVGn+s7AO2p0SZgWhFv4LB3e3qHK8Ivk6JRkwujGocgge4Dbr4jFDBnY+BGYt3duIlswXKmjeitPo+K4sb2aYoFncDtfIIP49t++wYkdl4PY06ylVwT9kJ06RPlqI6mc2flpizAkDYrOaj+rSi/tJToJH/K7akMdXLoVoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190433; c=relaxed/simple;
	bh=Fvul9cTQTipTMlqs6XhjhLKNYQVXUkoZrLxvwUon1vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7IXveq7dBKRXV7CGYDGKqAlpYTcEhAG/ubs+Xns+4Sx883e56n+w3mxWIJQl058/9NlByqP8BNvF7O4Iv8Dqb3qSWSJmG649v4ZjE35KCagtCjIMZgXiBR4CX3GI/jUWyTThL2TIvObjoKa1DBpcHj5HoOyxtQxtipONAvTRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnJs6i5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnJs6i5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E4DC4CEF1;
	Fri, 23 Jan 2026 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190432;
	bh=Fvul9cTQTipTMlqs6XhjhLKNYQVXUkoZrLxvwUon1vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnJs6i5cTHOlKaNlU87cLSBa8KHPBnahqPMdwuu7AmNbJl+0lAV32DFm2xxVfJ+s1
	 M2VjiYN269iF/Fz1hKsagkuBCbTtBLNmI4o76vHdDNuWy/vP5qfM2NmJrjsyIOGpPz
	 oTtEljWa8LRkKv211KZkl0aIhoPn1LelEFGMrNm/2rbvJtBG7YzZmU8K7BwP43X2yn
	 1wBqL6mh9sWW8eYykQfWb4HzEVFhMmOcgdtcmohtx/ru/FspacPOjG336TlE1GCTPo
	 coPzT9tMq0lspF7y77DhDjko2h+ZmGKtWz/GJJj+42BGTI1U9g+GPumXQVn5Jhy7gw
	 sGkBR+CQRM/Lw==
Date: Fri, 23 Jan 2026 14:47:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Zecheng Li <zecheng@google.com>, Tianyou Li <tianyou.li@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Shimin Guo <shimin.guo@skydio.com>,
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 11/12] perf disasm: Refactor arch__find and
 initialization of arch structs
Message-ID: <aXO0Hao8t-McaAU3@x1>
References: <20260122213516.671089-1-irogers@google.com>
 <20260122213516.671089-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122213516.671089-12-irogers@google.com>

On Thu, Jan 22, 2026 at 01:35:15PM -0800, Ian Rogers wrote:
> Switch arch__find to using an ELF machine number rather than a
> string. Rather than an array of fixed size arch structs turn the init
> functions into new functions indexed by the ELF machine they
> correspond to. This allows data to be stored with a struct arch with
> the container_of trick, so the priv variable can be removed. Switch to
> using the thread to find the arch rather than the evsel as the evsel
> only has limited notions of the running thread upon which disassembly
> is performed. Factor out the e_machine and e_flags into their own
> struct to make them easier to pass around.

Added:

⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 46740d1e58580004..4f60726247d62764 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <ctype.h>
+#include <elf.h>
+#ifndef EF_CSKY_ABIMASK
+#define EF_CSKY_ABIMASK        0XF0000000
+#endif
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>


With:

    [ Include elf.h for EM_CSKY and friends and also conditionally define EM_CSKY_ABIMASK for old distros ]

