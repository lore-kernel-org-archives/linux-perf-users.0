Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378B219E34;
	Tue, 12 Nov 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439131; cv=none; b=DXsVqvEFArMZ3VymjfbylZbAJSpKHQ0CnZa0SnHn6RgB479Z97Q3B1YEmUlT1LA37TO2P29wz+FWVqKezxo6L5BBo7Uafqp0hV4HtjU/YPRaWKWgIKUvMGDWLMjez0k7H5nC/+QVIaBmJzfJrYLddOGkhx5LAktN+aee5f066io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439131; c=relaxed/simple;
	bh=1H1g579p36XBsBnjA+xloBTJou1BmGuLy6WYc1tQyc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMZVbbRaacn3z9cZGLJvyVC+1yqVnQMd09sTZu52Fi36rwIax/FKJI9mkT/QXs4GIWGA8RbFhitNrk5dcKiDTCH6dZINyZk//FIf5ChAq/1sAzbcybG0Er0YsKqrQjzP6PqKy3ykBmJWxooX2g1JWpyeIc0IEqVGf3NX3pFZcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A71PAE1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A71PAE1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C27C4CED5;
	Tue, 12 Nov 2024 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439131;
	bh=1H1g579p36XBsBnjA+xloBTJou1BmGuLy6WYc1tQyc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A71PAE1OST6/q8RBvFI73yACeKJcbn4sTg/z3AEGvDD/WamMpcclK/ocJayd/Ut1R
	 ZpXRV5S94OuHw/RHWhQOpjIcI1YSBEHzDywAeINMk0G5U4rc89vVLUCnOoYO+9+yiw
	 MKl6wJ29H00/4Qjfl4OmLmKx1aMAjRu8T8537nB8fcX0d4xcbvItMSpweZU2WE1C1h
	 Esvs4qMVyRdCm3ITbKgRNzg/RHhfvi5v1oaFrYbnPl4hz24CHXk1uN++lU9LbIBTrB
	 YFbcBVCN1HMOyNCf8NWC/3ciGq8ILXi8l1NeoGJDe4NoBnZq4hn9ROWTmnjwjWXqmB
	 bEU033QycuxlA==
Date: Tue, 12 Nov 2024 16:18:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZzOqFTfgY_9CJfHb@x1>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <ZzOg3Xlq2jsG85XQ@x1>
 <ZzOpvzN-OTLZPyFh@x1>
 <ZzOp_b3Wm_kM7b0V@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzOp_b3Wm_kM7b0V@x1>

On Tue, Nov 12, 2024 at 04:18:27PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 12, 2024 at 04:17:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 12, 2024 at 03:39:25PM -0300, Arnaldo Carvalho de Melo wrote:
> > make: *** [Makefile:119: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > ⬢ [acme@toolbox perf-tools-next]$
> > 
> > I squashed the patch below and I'm trying to apply the other patches to do some
> > minimal testing on the feature itself, but the organization of the
> > patches needs some work.
> 
> Fails a few patches later, trying to fix it.

Sorry, forgot to add it:

⬢ [acme@toolbox perf-tools-next]$        git am ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
Applying: perf evsel: Assemble offcpu samples
Applying: perf record --off-cpu: Disable perf_event's callchain collection
Applying: perf script: Display off-cpu samples correctly
Applying: perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
error: patch failed: tools/perf/util/bpf_off_cpu.c:61
error: tools/perf/util/bpf_off_cpu.c: patch does not apply
Patch failed at 0004 perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢ [acme@toolbox perf-tools-next]$
