Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB50856E056;
	Wed,  9 Sep 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965427; cv=none; b=DEkAY6YVJHFWHbPEx4bKwaopboNvIz8Br5vDMXY1yKtCock3bU7YGD0owU2Hor+TsoiG/+5q1M2sZ3jubhxTtUfnxzupUzZDh2DfGWHrnhwpkTn8kYYixvA3ZP4UPITIrzEYdxk5sKhO/JsujitKPfkcVmbV2q4Nr3OGafSAtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965427; c=relaxed/simple;
	bh=ZBBPndz1fW7NuLQ71yvYcEakQmFLnfPAhhQsq5ssCq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR+Zp3y1knHzIzz5uL2uVb1Empv+RxLqrgvqDtYbBK8+7C/mk3t09trVYIbb1Dca/cPtTXsezgxr+SuhvWJogGjr/f13W0icm6sxj2/cppePW3XqjJZpSE4wCnV3V66jfpPDRQo/rRyX9yvjBXeD7Ul0QLS3Lnr0a9jDSAFeSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEBkTrum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEBkTrum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC231F00ADB;
	Wed,  9 Sep 2026 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965426;
	bh=+osS1iwoLcBfFmAbGsFKJXyRFHqPINgGxFsDWgPyCTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iEBkTrumhQZdhL6aTpIUNIrFm9+DAKFfF/MtkC3/5gVfDRl/h3JSXoTHnNDhIQawo
	 75lb/zFilcCwGCcox4hRnKMvyvwjiyskSr4AjAdj2iCG0VkvgR37fUOdsaUs+S1zQX
	 TyqL2PqwFw/1wztEOxwVPuxp/nuUPM5rnUYpEYeO0LPJCxt9Lb4/QYr+GfeCrdpFll
	 kPuZw1Xd9K70lE+/bIBmiykIqykJv7Rg7o5adkLuICZ07yjetlRIY3KrwCGN+89riZ
	 68gFOtPntHlHbrpTL0sSyiFxB43PanmSSf8NN1Cr22ffnxy5q3QkKAS4pLcxpXiFkg
	 NATjkfZgXlp/A==
Date: Wed, 9 Sep 2026 10:50:23 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 02/26] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
Message-ID: <aqFyLznYVOiPPIeR@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <aca3c51ca091bdf0c4b49b0721fbbf78a05abcf1.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aca3c51ca091bdf0c4b49b0721fbbf78a05abcf1.1788872630.git.wutengda@huaweicloud.com>

On Tue, Sep 08, 2026 at 01:05:05PM +0000, Tengda Wu wrote:
> The operands of 'adrp' instructions parsed by libllvm are currently
> represented as raw immediates rather than the "address <symbol+offset>"
> format used by objdump. This inconsistency causes arm64_mov__parse()
> to fail when parsing these instructions during post-processing.
> 
> Example of the mismatch:
>   Current: adrp  x18, 8014
>   Objdump: adrp  x18, ffff800081f5f000 <this_cpu_vector>
> 
> Fix this by manually extracting the target address from the raw adrp
> instruction via symbol_lookup_callback(). The address is then converted
> to a specific symbol during symbol__disassemble_llvm() and formatted
> to match objdump's output, ensuring compatibility with existing
> parsers.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
