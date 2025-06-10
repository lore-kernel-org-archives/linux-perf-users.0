Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D78282FA;
	Tue, 10 Jun 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590938; cv=none; b=qfkC4D0kF3JmZm2J6w6WhdcIkJ3SrgF2vPkAbBPGbdesKU1MVmns3ChwkFN32USD92XaSNFDqZITixHp8ZAk+yhVAnI1CnTSUN+gzyoRjdVNsdu6ucAkOvf8rqd8Csao39bkJB3RZNXsDkOzqwtqM1Z5CcVvqcc+wYJH1c/h/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590938; c=relaxed/simple;
	bh=4jlHEBvCUIKK0y1nievx0icWbWSW6pRbq6+2yts7pig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olijoxgslu5ERvYBlLIhzR+neNvTG+hgiTbFlITqZ0ouo/CUxWKHXX1jHLViQQhAlDcwvvvFG5kQfP1qbjQFsWqE1FxBjfcgIZH//1uq8aiEyvdSMmz8TXNemPDVOlX11sT5Lcy2kz60BiWazDnl7d9aMrK4RN9z9ZfUxcggRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snJI6iMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snJI6iMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B6BC4CEED;
	Tue, 10 Jun 2025 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749590937;
	bh=4jlHEBvCUIKK0y1nievx0icWbWSW6pRbq6+2yts7pig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snJI6iMJDN4bQD8zSpaA4srJ/clNCmrQazao9Bi2klr8JjgDkRZwN1ZOaodZETn5T
	 Q+NrCCTeRp7i7uIUncLNHmAYwI7DjlqtD3/nfylShiplY1jbkx9dlCNeNtNSZpzbud
	 1XOddvXvmc+ss2xROvLjvtIrDFQXsySbj9TOuQSFfVMr5BSzBbXM2o+/4SvqyIIpzU
	 82HRKB/udazzucyDOqQRd2uhNupFnef8fh7MhXzjE9WgeBLvzb5xBe9lF6E4sC3SYv
	 Mn3NX38bXQvoMo+uSpcJmqOfWGG2NS7bTrZZDkPZKybsd/z0kDuyMBsEEac5NNHd2z
	 q/F0J+HOCQHow==
Date: Tue, 10 Jun 2025 14:28:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Julian Vetter <julian@outer-limits.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	Kan <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Remove the check for packed_struct.h header
Message-ID: <aEijl0Xdk9NRJhdN@google.com>
References: <20250603133635.3685397-1-julian@outer-limits.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603133635.3685397-1-julian@outer-limits.org>

Hello,

On Tue, Jun 03, 2025 at 03:36:35PM +0200, Julian Vetter wrote:
> The functions in the header 'unaligned/packed_struct.h' were deprecated,
> and not used anymore, thus the header was removed. So, we can also
> remove the check in 'check-headers.sh'.

Can you please provide the commit ID that removed the header?

Thanks,
Namhyung

> 
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>  tools/perf/check-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index e9fab20e9330..cee372312974 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -188,7 +188,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
>  check arch/x86/include/asm/amd/ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
>  check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
> -check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
> +check include/linux/unaligned.h '-I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
>  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
> -- 
> 2.34.1
> 
