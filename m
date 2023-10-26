Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52D3B786
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f79Ub/QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC2BC433C8;
	Thu, 26 Oct 2023 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698349646;
	bh=MwQPMIMfLju9W8L1OJ77trHSmgP8n3dFt7oafLKIjcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f79Ub/QXHvbOpsyTgVsPLPEgk02zke2reNzB4gPQt5q6pa0UfY43C0nd0arO7R3LG
	 hLBQmH6xxGvLomWF+pog7DJlmdJPM5iGxBUXxUB13TofYU9s4eK12b2MBD/OBBevXH
	 BnKpTBhJa6rHfYYkqMFYfxRFgwnGOlz7Dg70dxNYrVdNJR8pz4qQdz+x5+gankkzDQ
	 9dMza4OxnIb86ls0kqc4o40M8ybupA/0Fn96xyLZ1ex0zWU5ggJwUPaku8gzZ0oUxG
	 6JWJtMLD9OgL9ihX3ZhTlo1UFLGbp4WMd9u35XcZEFGqaOu7iallY3WGUO7zh6N72S
	 oc8UA6sXGE8/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CA3064035D; Thu, 26 Oct 2023 16:47:23 -0300 (-03)
Date: Thu, 26 Oct 2023 16:47:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to
 rlimit__increase_nofile
Message-ID: <ZTrCS5Z3PZAmfPdV@kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023033144.1011896-1-yangjihong1@huawei.com>
X-Url: http://acmel.wordpress.com

Em Mon, Oct 23, 2023 at 03:31:44AM +0000, Yang Jihong escreveu:
> evsel__increase_rlimit() helper does nothing with evsel, and description
> of the functionality is inaccurate, rename it and move to util/rlimit.c.
 
> By the way, fix a checkppatch warning about misplaced license tag:
 
>   WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>   #160: FILE: tools/perf/util/rlimit.h:3:
>   /* SPDX-License-Identifier: LGPL-2.1 */
 
> No functional change.

Please run 'perf test' before sending patches upstream, I'm checking if
what is in perf-tools-next/perf-tools-next is building and I noticed
this:

⬢[acme@toolbox perf-tools-next]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 14: 'import perf' in python                                         :
--- start ---
test child forked, pid 2912462
python usage test: "echo "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
test child finished with -1
---- end ----
'import perf' in python: FAILED!
⬢[acme@toolbox perf-tools-next]$

The following patch cures it, Namhyung, can you please fold it and force
push perf-tools-next/perf-tools-next or let me know if you prefer that I
submit a patch fixing this separately.

- Arnaldo

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 26e1c8d973ea0b95..593b660ec75e24e1 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -40,6 +40,7 @@ util/rwsem.c
 util/hashmap.c
 util/perf_regs.c
 util/fncache.c
+util/rlimit.c
 util/perf-regs-arch/perf_regs_aarch64.c
 util/perf-regs-arch/perf_regs_arm.c
 util/perf-regs-arch/perf_regs_csky.c
