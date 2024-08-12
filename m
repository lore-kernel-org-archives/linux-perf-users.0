Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81619307B;
	Mon, 12 Aug 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493631; cv=none; b=lqnaSBTXraJBr1tt2Q6FkCt71WU+xn8/aykgW/t+nr7P2LS5wW3XPuQ0pBkf98q8teFXpMj9cpxScS8gFcn0ncjf7tSVZzIdy+uhyfyM9RtRfUqa4/cuaLVIM+rBJ7H0dEiaG7z6CyaSmBzJxcvA9ZK2HuttPkwYzS3NMXibbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493631; c=relaxed/simple;
	bh=nxgNnAm/Blyyo3y22sssUeR5HGVuPjk/8p0TU1NRykU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpwoI68BFrjqIvDNQrzE7bxbuGJTm0IpOy3rcz0oPsPjinG3yjvykpSXacJj/B8Mq96BxPSrk+nE1wxdFXY2FzODAtBvQqeOPa1953l7OGPJuVAyWLrRDHgi45j5QJPFthU/WM4Ep7ZKw5vUlpnD3PaG6NJ8cdi5RnfX2HG+U98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWmmZSkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWmmZSkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C7BC32782;
	Mon, 12 Aug 2024 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723493630;
	bh=nxgNnAm/Blyyo3y22sssUeR5HGVuPjk/8p0TU1NRykU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWmmZSkZBDwpdMYqZP1OkvctzLY2BDU1DcmQ/75/DepGKaYOHtYaqghDZ1occwmlJ
	 C3k4ahrqVCDTbY0rkYZt4oqOtbagTvf0DZa9r4zj9875cclGtB9654Fi/674DCteqc
	 Mk1sY2VO61WeewT8Tpv1Um2HpFpslglIMF3J9jL9LYWt6HnOd2Cx9jvU6uaQ/vNHqi
	 315j3ptsbz1JkQ2V1p+vVdiK88cfnX5YO73TspHWxu+L5Mwo50i4hLAMCOgMoqAIir
	 qulW7Zwf7agxATa3M2vAH/A443l3UCclZnV8BPJ7MCQe+owrbfWXNNI7K0B48NARcz
	 IucEri8V2QXQw==
Date: Mon, 12 Aug 2024 17:13:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: kan.liang@linux.intel.com, irogers@google.com, peterz@infradead.org,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V2 0/9] Support branch counters in block annotation
Message-ID: <Zrps-_ajW_zfze66@x1>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
 <Zrpk5a2GQl5i5APD@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zrpk5a2GQl5i5APD@google.com>

On Mon, Aug 12, 2024 at 12:39:17PM -0700, Namhyung Kim wrote:
> On Thu, Aug 08, 2024 at 12:33:15PM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > Kan Liang (9):
> >   perf report: Fix --total-cycles --stdio output error
> >   perf report: Remove the first overflow check for branch counters
> >   perf evlist: Save branch counters information
> >   perf annotate: Save branch counters for each block
> >   perf evsel: Assign abbr name for the branch counter events
> >   perf report: Display the branch counter histogram
> >   perf annotate: Display the branch counter histogram
> >   perf script: Add branch counters
> >   perf test: Add new test cases for the branch counter feature
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Clashed with something here, can you please take a look and rebase to
what is in perf-tools-next/perf-tools-next?

- Arnaldo

  ✓ [PATCH v2 9/9] perf test: Add new test cases for the branch counter feature
    + Acked-by: Namhyung Kim <namhyung@kernel.org> (✓ DKIM/kernel.org)
    + Reviewed-by: Andi Kleen <ak@linux.intel.com> (✓ DKIM/intel.com)
    + Link: https://lore.kernel.org/r/20240808193324.2027665-10-kan.liang@linux.intel.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/intel.com (From: kan.liang@linux.intel.com)
---
Total patches: 9
---
Cover: ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.cover
 Link: https://lore.kernel.org/r/20240808193324.2027665-1-kan.liang@linux.intel.com
 Base: not specified
       git am ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.mbx
Applying: perf report: Fix --total-cycles --stdio output error
Applying: perf report: Remove the first overflow check for branch counters
Applying: perf evlist: Save branch counters information
Applying: perf annotate: Save branch counters for each block
Applying: perf evsel: Assign abbr name for the branch counter events
Applying: perf report: Display the branch counter histogram
error: patch failed: tools/perf/util/annotate.h:551
error: tools/perf/util/annotate.h: patch does not apply
Patch failed at 0006 perf report: Display the branch counter histogram
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf-tools-next]$
