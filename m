Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EE18BBB7
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377435; cv=none; b=BFxKvnc7CsLW5mUvTKdCK2LOE7WzstNglJner3VlVuuMB5mgfE9il0xZuGNiRrhPqdt9gNdbhAMWU0MSerch8xjgBPZsVmbQlBQOHnOC7OqWC8qvNN8iDL/2Bfg6fuNPF/2aunWxJIc54Cbo/aT4pppyVUqdZS/VEI/W3jeBf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377435; c=relaxed/simple;
	bh=wG+ZqFZjx2koR9PC6R37gcmv2PZdXiGlevdAnXtZKRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDEC2d5lfE7LI/BzzQCSMmAxhslsMpUN50aQ96h6N3bycOebc6PVR/s7QrgRiMSE7vcH4BZauACa4kb6POdn9ukuCb8ylAeTbyzIsKldEJaNPjSAL2k1yon5JkaqJG00drxo+bv7EEaB6bKyI63Ek0LE67t/sWeXtTOmEtuShyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxMlasA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxMlasA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C682C4CECD;
	Tue,  3 Sep 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377434;
	bh=wG+ZqFZjx2koR9PC6R37gcmv2PZdXiGlevdAnXtZKRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxMlasA/Pg7dqkBexqJxTQ8QYsU+is78O8fHV65/k7Ci9DO0s0JwdtPzyTj8/dLl8
	 jk2a+h0md4qa2bs/xrEmq6YfnkK7+LrX95QuzgaIOZYK7Anp0QGMRPWJRUOPqk08Uk
	 Nikct/G0xSfzDZS5wGLEPvtA7ByiCmThMNKTZh7cIe1ClfNVhlIJhkVVMBFgmvPRV+
	 OdpWCbzGrxI6T6ZNwg2HnEcqiloQp/CCAjo82e//mjgpuBrrN1RsMrR0kX6IN7MD87
	 FEOkiq2w0XyOQBIxGlxwO6mWvlN0tHft/BYPAk+WiSIutmbK2iMxFSxmGB+DpPrTDM
	 E+nl230bC05CA==
Date: Tue, 3 Sep 2024 12:30:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v13 0/7] Introduce perf check subcommand
Message-ID: <ZtcrldaM-QfckxWL@x1>
References: <20240718085957.550858-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240718085957.550858-1-adityag@linux.ibm.com>

On Thu, Jul 18, 2024 at 02:29:50PM +0530, Aditya Gupta wrote:
> The Problem
> ===========
> 
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
> 
>     perf version --build-options | grep " on .* HAVE_FEATURE"
> 
> This relies on the output of perf version, and is a common pattern in tests.
> 
> Proposed solution
> =================
> 
> As suggested by contributors in:
> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> 
> Introduce a subcommand "perf check feature", with which
> scripts can test for presence of a feature or multiple features, such as:

I tried to resume reviewing/testing but:

Total patches: 7
---
Cover: ./v13_20240718_adityag_introduce_perf_check_subcommand.cover
 Link: https://lore.kernel.org/r/20240718085957.550858-1-adityag@linux.ibm.com
 Base: not specified
       git am ./v13_20240718_adityag_introduce_perf_check_subcommand.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./v13_20240718_adityag_introduce_perf_check_subcommand.mbx
Applying: tools/lib/subcmd: Don't free the usage string
Applying: perf check: Introduce 'check' subcommand
Applying: perf version: Update --build-options to use 'supported_features' array
error: patch failed: tools/perf/builtin-version.c:46
error: tools/perf/builtin-version.c: patch does not apply
Patch failed at 0003 perf version: Update --build-options to use 'supported_features' array
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢[acme@toolbox perf-tools-next]$
