Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765354F81;
	Mon, 23 Dec 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971535; cv=none; b=CW88nUK37IOnBcgQZ2OOT5+YG/irfD5/gAsPmOe/zsNEJANlzwouW+djJdObyh3XmrD3em04aqv1O4Pom+zpW6gB56oegKSS3GmQdcegx5nHX0aEkswNTLRJ+iZ0urqtKC0adVXOy6cyGrWaQGj047VBXEdX7OpKvMxM22OOmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971535; c=relaxed/simple;
	bh=7XMq0jhnOR66Hv7p/l4b8inDvTNTBeDT4xndXKIadFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COz0mZ/Rk/IxEdz6lGDpU1bfTwh5SkYip4CB3aNRAv9BqI7Dz2bd62iGRfj5S0GLARi22FPUH9XKwtfVx1fnkG0iMC3vdOI/HL8m/QJf6POhMsD4sN3EgOfUNbhzTDV1RcsKNWe3kcfsFWwI6tccChAgO3sf/PlqF8pU0FPPm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoDdaUat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoDdaUat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CDFC4CED3;
	Mon, 23 Dec 2024 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734971535;
	bh=7XMq0jhnOR66Hv7p/l4b8inDvTNTBeDT4xndXKIadFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoDdaUat1iDq58RrBVUMFFnOEy/j9DESOGiia3dJIW8dgwSlSNI4yT1Vz3qkRedgd
	 k/BP99mdETBZcygu+Xozpdf9UQSPdnKgmZZ9E4KhVCf+2YkAwLE6Sh8JkRCCf+qCIc
	 P2LW0zkc0ZhFIkIe2S/Wi6WRrLBQT9hNPIf/kvN1J/lhWzwRcgNjEPP0BEN+TcNJKM
	 J8EoS6jCR7jmZ8B7IBhlx/fCPUB7+OoNWl5jgP65733n5hlE/xAoeZS+ymatiqbnMd
	 6bwc9Io4sb3LY1gHviyoXNw3U47N1/KS+ptzhh3JGeWGSgLLkJdLAt1YNO37lhjyME
	 ntyP8/Uze6WfQ==
Date: Mon, 23 Dec 2024 13:32:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux@treblig.org
Cc: irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused is_executable_file
Message-ID: <Z2mQjAIwBcx4_Pm0@x1>
References: <20241222215831.283248-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241222215831.283248-1-linux@treblig.org>

On Sun, Dec 22, 2024 at 09:58:31PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> is_executable_file()  has been unused since 2022's
> commit 7391db645938 ("perf test: Refactor shell tests allowing subdirs")
> 
> Remove it.

Did you patch this on:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

?

That function is still there, so I'll fixup your patch, keep your
credits and test it all.

Thanks,

- Arnaldo

⬢ [acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20241222215831.283248-1-linux@treblig.org
Grabbing thread from lore.kernel.org/all/20241222215831.283248-1-linux@treblig.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] perf tools: Remove unused is_executable_file
    + Link: https://lore.kernel.org/r/20241222215831.283248-1-linux@treblig.org
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/treblig.org
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20241222215831.283248-1-linux@treblig.org
 Base: not specified
       git am ./20241222_linux_perf_tools_remove_unused_is_executable_file.mbx
⬢ [acme@toolbox perf-tools-next]$        git am ./20241222_linux_perf_tools_remove_unused_is_executable_file.mbx
Applying: perf tools: Remove unused is_executable_file
error: patch failed: tools/perf/util/path.h:12
error: tools/perf/util/path.h: patch does not apply
Patch failed at 0001 perf tools: Remove unused is_executable_file
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢ [acme@toolbox perf-tools-next]$
