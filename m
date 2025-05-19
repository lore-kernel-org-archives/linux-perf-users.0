Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6222690F4;
	Mon, 19 May 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643735; cv=none; b=Jr0m42k7YLLCuW6AINT3HRVglSuWjYdsjqOTd9UweKRDJajrbD05c9OPGHlN6DN9siwTc7RVIUd09m4stIe3qoJJnszWru/RtQJhH/r3JnScokMO/p8LJqMSlvL5+HnM2mtsKk4deHr/SZusnyjSJQyiJteLXjrTAY9OEm/53KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643735; c=relaxed/simple;
	bh=YUoMEn93nAO88K9IbCoI8bOPO2Y4Oh7dNF5L0fwzwrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrDHzH9S9InYhvZc9j5/Z/HcqWylNIM8m306k5Z04xNsqHyoj09ipiS3UKSzvDU9r1nbBrMyJHAOpS6Q63XnNg0LBb02ZQlvsrFkqwOWey8VD7cCSCczmMSevT8HbzcJy8oLqT1vUcpeSs2NsbMHfBu9Nxjcf8So9Ty2EieypWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6D3F2403;
	Mon, 19 May 2025 01:35:19 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E1283F5A1;
	Mon, 19 May 2025 01:35:32 -0700 (PDT)
Date: Mon, 19 May 2025 09:35:28 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test probe_vfs_getname: Correct probe line for
 updated kernel code
Message-ID: <20250519083528.GJ412060@e132581.arm.com>
References: <20250516090532.916743-1-leo.yan@arm.com>
 <aCeIz921q6ljJqmm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCeIz921q6ljJqmm@x1>

On Fri, May 16, 2025 at 03:49:51PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 16, 2025 at 10:05:32AM +0100, Leo Yan wrote:

[...]

> Well, I'd say we should add, not update, i.e. a new perf should continue
> to work on an older kernel, so please consider the following patch.

The change is fine with me. I sent patch v2 based on the idea.

Thanks a lot for suggestion!

Leo

> - Arnaldo
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 89f72a4c818c712b..aa867e28eadc46bc 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,8 +13,17 @@ cleanup_probe_vfs_getname() {
>  add_probe_vfs_getname() {
>  	add_probe_verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
> -		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
> -		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
> +		# Please keep the older regexps so that this will pass on older kernels as well
> +		# as in the most recent one.
> +
> +		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
> +		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
> +
> +		if [ -z "$line" ] ; then
> +			result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
> +			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
> +		fi
> +
>  		if [ -z "$line" ] ; then
>  			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
>  			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
