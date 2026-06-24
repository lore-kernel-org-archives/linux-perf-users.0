Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5DE555;
	Wed, 24 Jun 2026 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782261172; cv=none; b=Odyin0AdLVZ+zXEJvx0tg1fIkvGguoQJ5JrlACzVfhbYUx04WqGmdLSdoZvFPkeM4atDoETU66tYEj8TmVt5S4cQAtITvjFtR21fr7NsBrU6m6GZ2OCQqPjfkmaE9JKGgyVk3V93O77xrUvDXNuSyhQ+ApJHnrYO0jsflNH4sNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782261172; c=relaxed/simple;
	bh=WDe2wd0eTcVPN6N0OQpT9u117Vrkm3Y6jhk91ZO/IEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyUv7ZnN1qc76f+vLi64s4mbx52hHlr9y86ltA55amWtj6xo56sRThX5X4wn9V+PLffwZWs482Oxkq6CJzLpfB1J9qtHIec5o5rLsqb2SpjqxrIYpyOkMclniGpUzBEf21zO7Rwi+ScUdAc2kS5+fLaYM58K1FCRTmHfwTJC3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Drhtps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Drhtps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA91F000E9;
	Wed, 24 Jun 2026 00:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782261171;
	bh=D0vJm7TrmJDtMD34uO3HtPk+9rLILwVFrlu4mhlaaAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4Drhtps7ZMnZiZMn2ZHbul8maw3v/iGvqpSNOvpNRT/lQuvVRSF3a7uxA9isKgkY
	 OToOFQnFKnzKdMcp9EPhEtJX5eWr9H5/G6aHp9/IV/UFUu7FqdNE0YszS4TBbhgJ+e
	 tHR9wwdnR4ZkbIBAroICumDpa5oE0cibZlp5nx84T4OmxmQhQGFsF/Nv7GR2BidHHC
	 J30pRBxvbQ8CERGdvHnqCsHZd/Yy1fRL4VXON1eFzx3UUak4J6MopThoLFONYfatlh
	 n8MLfJ1Uot0lpzjZA69V8CAonJvto/UQs30nH0QzJu3bWF6g3/RB31s6iA74qdkF8D
	 gq3W9xLTIhrLg==
Date: Tue, 23 Jun 2026 21:32:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf bench bpf: Add missing .gitignore file
Message-ID: <ajslsBPoAPMioSeW@x1>
References: <ajsfSkRm0T7J2eF3@x1>
 <ajskevFfXGkVt-si@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajskevFfXGkVt-si@google.com>

On Tue, Jun 23, 2026 at 05:27:38PM -0700, Namhyung Kim wrote:
> On Tue, Jun 23, 2026 at 09:05:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > +++ b/tools/perf/bench/bpf_skel/.gitignore
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +.tmp
> > +*.skel.h
> > +vmlinux.h
 
> I think it's enough to add '*.skel.h' only as other files are still
> under util/bpf_skel.  But having others would not be harmful.
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

⬢ [acme@toolbx perf-tools]$ ls -la tools/perf/bench/bpf_skel/.tmp
total 8
drwxr-xr-x. 1 acme acme   36 Jun 23 21:01 .
drwxr-xr-x. 1 acme acme  102 Jun 23 21:01 ..
-rw-r--r--. 1 acme acme 7840 Jun 23 21:01 bench_uprobe.bpf.o
⬢ [acme@toolbx perf-tools]$ 

.tmp is created as well.

- Arnaldo
