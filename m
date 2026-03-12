Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317602F39C2
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339971; cv=none; b=iOnJIDqsvlb5DWebvvsY54dzgmtddpQBM7NtacSmyn2H2GpW3DxfRQGxWfw25bEtaGF757q2CIt6iFnIX/0XIW9jpxsve4YbA97rTY8XGgDkNxSaN8YBqKpU0hx1XtZKHS0h9r3Kb+rT20wl96N6n9xgyEgM1CZmOfwzTZB5b3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339971; c=relaxed/simple;
	bh=u1pIwC/EKI9304Fc/zBcFgNRA5YUMRDSIpORIzKnMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDqkAe/ZZfYnFBepCNsFnGpezwar6+VX6uum8xEEw1z02ISyooPBF4hG4jAKCYSWDXB/EtLRPyL86Dr/Es4/7BhHFHCWRmApCiTFK/SJES2lQPJy++od/JhmhI9KAUl6SZHI2HE2KOq/6o4a0WLgZYnSCjSAY0stcmabfLGofZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW+q0OEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW+q0OEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9CBC4CEF7;
	Thu, 12 Mar 2026 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773339970;
	bh=u1pIwC/EKI9304Fc/zBcFgNRA5YUMRDSIpORIzKnMy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tW+q0OEhOfwpy4bqhwtI1MTgYCLrTGyaBFvJylXelodwYmli8FetROWtvZN5nBevI
	 ASOyEMMeT5/Z0qBNjM3jHT3U+1MD7CICfmRK0HGNiajMrVwiSEz+B6pyHRXQuZkNHe
	 117ncpKkEtbnYFdhZp6xp6cIHwVwqKx1+w6C0IrXTnynw11YC1j3WcEMByrdaVUEBl
	 +PZ0TFtbzqiHyeYwZZsJI+zkxBCUirqYkV1S8oIiNr48WYXLnI9ImktCdcn3G1Z0u/
	 qqxympEj5oU2X8TdjbEIpywRqlcnlZWNsWIRdAoa38frO3AkDK/NNELycCDG1e29QQ
	 2+1ZwNwiOgMOg==
Date: Thu, 12 Mar 2026 11:26:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org,
	irogers@google.com, mpetlan@redhat.com
Subject: Re: [PATCH v6 0/7] Introduce structure for shell tests
Message-ID: <abMFQbTSW5jwpAa2@google.com>
References: <20260309155728.98026-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309155728.98026-1-jbrnak@redhat.com>

Hello,

On Mon, Mar 09, 2026 at 04:57:21PM +0100, Jakub Brnak wrote:
> Hi,
> 
> Sending the next revision of patches for perftool-testsuite structure
> setup which incorporates the changes in Patch 4 suggested by Ian.

Can you please add a documentation for the directory structure, setup,
log and other details?

Thanks,
Namhyung

> 
> Thanks,
> Jakub
> 
> Link to v5: https://lore.kernel.org/linux-perf-users/20251125155648.197527-1-jbrnak@redhat.com/
> 
> Changes since v5:
> Patch 4: fixed log deletion logic to ensure logs are only removed after
> all tests (including those executed in parallel) have fully completed
> 
> Jakub Brnak (7):
>   perf tests: Create a structure for shell tests
>   perf test: Provide setup for the shell test suite
>   perftool-testsuite: Add empty setup for base_probe
>   perf test: Introduce storing logs for shell tests
>   perf test: Format log directories for shell tests
>   perf test: Remove perftool drivers
>   perf test: Fix relative path for 'stderr-whitelist.txt'
> 
>  tools/perf/tests/builtin-test.c               | 141 ++++++++-
>  tools/perf/tests/shell/base_probe/setup.sh    |  13 +
>  .../tests/shell/base_report/test_basic.sh     |   6 +-
>  .../tests/shell/perftool-testsuite_probe.sh   |  24 --
>  .../tests/shell/perftool-testsuite_report.sh  |  23 --
>  tools/perf/tests/tests-scripts.c              | 289 +++++++++++++++---
>  tools/perf/tests/tests-scripts.h              |  17 ++
>  tools/perf/tests/tests.h                      |   8 +-
>  8 files changed, 413 insertions(+), 108 deletions(-)
>  create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> 
> -- 
> 2.52.0
> 
