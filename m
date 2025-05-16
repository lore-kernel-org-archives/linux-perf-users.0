Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21E274FF9;
	Fri, 16 May 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421395; cv=none; b=bWQFLUqoFD9xIL3oc5R9NOVNS+JTZr7a1U3GFH4FD48Z0zqWfDCPLEwjXVPr3ihR1KOZjkZYyqKeRbDWGew/OZ/wkhABkByq64O9g+JwzHJyoe2hDvw15O1Pmj/79p21INBvT2esIFiHLCIS7iFem/lt2OHS2WHZaHL0f/ZSBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421395; c=relaxed/simple;
	bh=uNG0lYFbRomhp9XrwBNobEPUMEkrXJy6x3p5Nv3YsCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etkYAFKiOyCKosMc9ClI6vXNdIl1JgYayr+QjHrUsDBrZKo+4/3ibFQ5n54VZeVDvsUKgypkOg7/PjJ/biJhp9AtPIWYp1nWu1ZvPNahBA+jyks23GiWt1Wd8VFBrQUOR99KMRepY7VXcRztQkzKs/KeTT8vVUjPKS2M0d2aJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnJZeOW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnJZeOW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B18C4CEED;
	Fri, 16 May 2025 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747421394;
	bh=uNG0lYFbRomhp9XrwBNobEPUMEkrXJy6x3p5Nv3YsCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnJZeOW31Tv56r4RvfEZU0XQPpTR7yEfpm/1gXd7Ub5wTviVBLUPPJ9+y+gJy45D4
	 XEjTuvl1sgxMtZjqoBUw0FW8841qFh3G6FJ0KzfFtkJN9qSIZCN463WehjJk+Gj2Sm
	 papRt0XrqVTZ9U1tf/J9nggXzryFb3my5QVa8es8UULuWtYMITqB9ls/mhV17wLY5J
	 I5VSfK4Luvm6P/R8yNfbo2FoYQsu2hNvQPMHFcSOVQysg9QYjIf+K1sfDwRek3grLM
	 4Npsiiub3Jal2Q/gk4ReoVX2/jRvxG1m+6I5DiHtq4CQYr8OtDUhHZIY2SkttV/+mA
	 Ji/monjBqzoXw==
Date: Fri, 16 May 2025 15:49:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test probe_vfs_getname: Correct probe line for
 updated kernel code
Message-ID: <aCeIz921q6ljJqmm@x1>
References: <20250516090532.916743-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516090532.916743-1-leo.yan@arm.com>

On Fri, May 16, 2025 at 10:05:32AM +0100, Leo Yan wrote:
> Since commit 611851010c74 ("fs: dedup handling of struct filename init
> and refcounts bumps"), the kernel has been refactored to use a new
> inline function initname(), moving name initialization into it.
> 
> As a result, the perf probe test can no longer find the source line that
> matches the defined regular expressions.  This causes the script to fail
> when attempting to add probes.
> 
> Update the regular expression to search for the call site of initname().

Well, I'd say we should add, not update, i.e. a new perf should continue
to work on an older kernel, so please consider the following patch.

- Arnaldo

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 89f72a4c818c712b..aa867e28eadc46bc 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,8 +13,17 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
-		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
+		# Please keep the older regexps so that this will pass on older kernels as well
+		# as in the most recent one.
+
+		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
+		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
+
+		if [ -z "$line" ] ; then
+			result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
+			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
+		fi
+
 		if [ -z "$line" ] ; then
 			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
 			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")

> This provides a valid source line number for adding the probe.
> 
> Fixes: 611851010c74 ("fs: dedup handling of struct filename init and refcounts bumps")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 89f72a4c818c..cbfdd2a62c6e 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,12 +13,8 @@ cleanup_probe_vfs_getname() {
>  add_probe_vfs_getname() {
>  	add_probe_verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
> -		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
> -		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
> -		if [ -z "$line" ] ; then
> -			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
> -			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
> -		fi
> +		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
> +		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
>  
>  		if [ -z "$line" ] ; then
>  			echo "Could not find probeable line"
> -- 
> 2.34.1
