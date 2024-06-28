Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3F1C0071;
	Fri, 28 Jun 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585862; cv=none; b=O5baoACA34+QYlr8g99+SEAW++RrnpAmTZ9TKiwV4/TI3RPTXHodhxBJyYoP+dMjMxRS9b6DPpugaCkfHa7Fm8MPAIM9ZU9T3Lms2ymzXOB5hfDliOhm05xk2G+euppe77z26KCDMRFGHRPAlX2jzZhhBRnfrOZTd7sW0Gx/MwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585862; c=relaxed/simple;
	bh=DPnX3IbiB9EeaV89mCNU0omiYHuBP2uAG+cJEVzg6VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk+grIT8Jv1jXikZk9Oxz7oI4IwIxfqBMi5rrCAF++Sc5HY2UUMsoxQQoyQbELq1zbN0b9NJ4RyZqgxDhXi8mkepApencLlh90HIgmevuPxbXqI9gGe/IOcKKrT2gB0MizaXbrpvRLV8wdacZYGCbfmHfI7tmUtfol5zH1V1ucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRowEG1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRowEG1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C153C116B1;
	Fri, 28 Jun 2024 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719585862;
	bh=DPnX3IbiB9EeaV89mCNU0omiYHuBP2uAG+cJEVzg6VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRowEG1KQOia1GaCQEbrEHvcP3Hs79sunvyvAvBUy0+BXWqZhtFpSErYxK4Keo27F
	 9vC17BhgXtbiutnc800E9GVy79m4PeXSZVUIMHbjKASNFVM3GdAAvqYBHbzUEWVC7h
	 M+WUXdakBp6S8GjWc7rgA3bbbcJyfiM6gd6FCvt5yo5Esj+5qJgxDm8zmKFker9W53
	 fWAOpPded/mKpIy2RFR1cFgLRPnj5sdLdadcHpwq/lWpaqEfJeYB2bMmE9Nv5z9Vzm
	 aKD1dguthhFiPxwvUbrancHaGiZH7P+VxnVWEnZCjM3Fq1JSAz8p+SrLcMZTtkCr0C
	 NM6mJXiwmakdA==
Date: Fri, 28 Jun 2024 11:44:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 5/8] perf test: Add landlock workload
Message-ID: <Zn7MQUmGaZNLkrqy@x1>
References: <20240624181345.124764-1-howardchu95@gmail.com>
 <20240624181345.124764-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624181345.124764-6-howardchu95@gmail.com>

On Tue, Jun 25, 2024 at 02:13:42AM +0800, Howard Chu wrote:
> We'll use it to add a regression test for the BTF augmentation of enum
> arguments for tracepoints in 'perf trace':
> 
>   root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
>        0.000 ( 0.009 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd8e258594, flags: 45) = -1 EINVAL (Invalid argument)
>        0.011 ( 0.002 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd8e2585a0, flags: 45) = -1 EINVAL (Invalid argument)
>   root@x1:~#
> 
> Committer notes:
> 
> It was agreed on the discussion (see Link below) to shorten then name of
> the workload from 'landlock_add_rule' to 'landlock', and I moved it to a
> separate patch.

I'm not being able to apply this specific patch:

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20240624181345.124764-1-howardchu95@gmail.com
Grabbing thread from lore.kernel.org/all/20240624181345.124764-1-howardchu95@gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Nothing matching that query.
Analyzing 10 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v3 1/8] perf trace: Fix iteration of syscall ids in syscalltbl->entries
    + Link: https://lore.kernel.org/r/20240624181345.124764-2-howardchu95@gmail.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v3 2/8] perf trace: BTF-based enum pretty printing for syscall args
    + Link: https://lore.kernel.org/r/20240624181345.124764-3-howardchu95@gmail.com
  ✓ [PATCH v3 3/8] perf trace: Augment non-syscall tracepoints with enum arguments with BTF
    + Link: https://lore.kernel.org/r/20240624181345.124764-4-howardchu95@gmail.com
  ✓ [PATCH v3 4/8] perf trace: Filter enum arguments with enum names
    + Link: https://lore.kernel.org/r/20240624181345.124764-5-howardchu95@gmail.com
  ✓ [PATCH v3 5/8] perf test: Add landlock workload
    + Link: https://lore.kernel.org/r/20240624181345.124764-6-howardchu95@gmail.com
  ✓ [PATCH v3 6/8] perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'
    + Link: https://lore.kernel.org/r/20240624181345.124764-7-howardchu95@gmail.com
  ✓ [PATCH v3 7/8] perf trace: Introduce trace__btf_scnprintf()
    + Link: https://lore.kernel.org/r/20240624181345.124764-8-howardchu95@gmail.com
  ✓ [PATCH v3 8/8] perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
    + Link: https://lore.kernel.org/r/20240624181345.124764-9-howardchu95@gmail.com
  ---
  ✓ Signed: DKIM/gmail.com
---
Total patches: 8
---
Cover: ./v3_20240625_howardchu95_perf_trace_augment_enum_arguments_with_btf.cover
 Link: https://lore.kernel.org/r/20240624181345.124764-1-howardchu95@gmail.com
 Base: not specified
       git am ./v3_20240625_howardchu95_perf_trace_augment_enum_arguments_with_btf.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./v3_20240625_howardchu95_perf_trace_augment_enum_arguments_with_btf.mbx
Applying: perf trace: Fix iteration of syscall ids in syscalltbl->entries
Applying: perf trace: BTF-based enum pretty printing for syscall args
Applying: perf trace: Augment non-syscall tracepoints with enum arguments with BTF
Applying: perf trace: Filter enum arguments with enum names
Applying: perf test: Add landlock workload
error: patch failed: tools/perf/tests/workloads/Build:6
error: tools/perf/tests/workloads/Build: patch does not apply
Patch failed at 0005 perf test: Add landlock workload
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢[acme@toolbox perf-tools-next]$

I'm checking what is this, perhaps I'm using a more recent
perf-tools-next/perf-tools-next with changes to that
tools/perf/tests/workloads/Build file...

⬢[acme@toolbox perf-tools-next]$ git log --oneline -5 tools/perf/tests/workloads/Build
1dad99af1a8211e2 perf test: Make tests its own library
3dfc01fe9d12a1e8 perf test: Add 'datasym' test workload
a104f0ea99d846df perf test: Add 'brstack' test workload
39281709a6e2301a perf test: Add 'sqrtloop' test workload
41522f7442905814 perf test: Add 'leafloop' test workload
⬢[acme@toolbox perf-tools-next]$ 

Yeah, we need to rebase on top of what we have in
perf-tools-next/perf-tools-next, probably something minor.

- Arnaldo
