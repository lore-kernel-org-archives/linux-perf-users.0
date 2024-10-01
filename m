Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142D17FD;
	Tue,  1 Oct 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790460; cv=none; b=MAsCNTpKcebEtvE9nl4TKsGA1mLwSW73/tT0fd0kiaMl7BtVZ5HZe5B66HP0OmPXgTYu91+9gykrGE+yJjU62+VUlhJI2WFu6mb+Nly+YnC8FbThnrMOgcmisG9+XPMxX3fVbMbe4ZpO4Eq7orzssde1bUI5l/hn+0V+qEWCeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790460; c=relaxed/simple;
	bh=0jn4TDC/bQLfOe0qbgEV4FQhAg+YWFrs+MeKYkHuNnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd6wlKSqsZmIaI/DRVR7rYHgVQLdnih+4CVGJBUS/1O1o4k/Cr3OxfrWZSBO/IRGtfDuQrVHNtwx5UPpcHkExtIKXD/mOLLqSFYehAsUMdpokRNIfJeYT5mrwF3hacqcUXV97srFszDu4k2CXsnd5ESPTMt1P42wMajUzyTGQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdmhm3zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdmhm3zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B3C4CEC6;
	Tue,  1 Oct 2024 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727790459;
	bh=0jn4TDC/bQLfOe0qbgEV4FQhAg+YWFrs+MeKYkHuNnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdmhm3zf6n6esJYmKNAA55U54JVCWg8L6u3Hf5W9YHm3t4p1BcAKmWkL2+4ebO8aU
	 16RoVU0x6o48Nn7IQcqxUYllCqEfpJ9bYUGbn68T6GFjp5nIFiCU1nhBVIC1DxV9CT
	 k/xDoCW1E4Tp6gITnUiRmPzHz9avDbrh3uCikrK1sz1/+G7JZXQi5+dW6ZiGOmQL2G
	 ZN+QER7WMwdr+X2/6x+l6vAPWcyhfT1F7hAgA2ccoL2F6B2YB+osWjQfw7hE7AzTnc
	 GDj5E++OIRfwv7rEuD6DHmdZw69EaWCqXOfuQb4AvAJo/G1KfrU6p33DaM0/6IOmxv
	 pj1WXFHkS6zDQ==
Date: Tue, 1 Oct 2024 10:47:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dwarf-aux: Fix build with
 !HAVE_DWARF_GETLOCATIONS_SUPPORT
Message-ID: <Zvv9eBDrquBHBHhF@x1>
References: <20241001123625.1063153-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001123625.1063153-1-james.clark@linaro.org>

On Tue, Oct 01, 2024 at 01:36:25PM +0100, James Clark wrote:
> The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
> which gets picked up in a lot of places. Without
> HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
> errno.h to fix the following build error:
> 
>   In file included from util/disasm.h:8,
>                  from util/annotate.h:16,
>                  from builtin-top.c:23:
>   util/dwarf-aux.h: In function 'die_get_var_range':
>   util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in this function)
>     183 |  return -ENOTSUP;
>         |          ^~~~~~~
> 
> Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback function to handle arch specific instruction tracking")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/dwarf-aux.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 336a3a183a78..bd7505812569 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -9,6 +9,7 @@
>  #include <elfutils/libdw.h>
>  #include <elfutils/libdwfl.h>
>  #include <elfutils/version.h>
> +#include <errno.h>

Simple enough, thanks, applied to perf-tools/perf-tools.

- Arnaldo
  
>  struct strbuf;
>  
> -- 
> 2.34.1
> 
