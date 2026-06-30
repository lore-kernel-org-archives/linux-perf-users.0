Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB01A6814
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863489; cv=none; b=AVmzpZlp3wYUppdFBlYOGnQAcEEnvXm2Io63iW9o7YpWl7ZDI4GTFaDP7bJZLVhZoBmL++HSm+xibqktnJpfM3PKtGB+NRVGxaBxpsFVIbyLX7kM42LPhnmk9PilCwXhNBUYr8/tIa4VMENmvApR2f8KXR0Fa1XG285yrguZmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863489; c=relaxed/simple;
	bh=uKOlecnXdz2uWJ0zM6nADXOeiTQcI9fDQN2HHHoyDcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5DMy6em8tZLEPP+hN1MKVJrIHvVgdFzHZJvZYU9Q56qec8R+hQakwOZqSC+E1MBgLT1Q5/wcuzYutELOE40RSnYuyduORGSsWsxfsSJZnvSCgx9cf+3Yp2CWJkJ1fxhvWK99AmHFSu49uWDd7H3VSKKozI4pGKiNpV1xUQ0gOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh4YOPYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh4YOPYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AC81F000E9;
	Tue, 30 Jun 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863487;
	bh=Ys3HTF0HtEMjTGHT8QzymQBzCbrL22ulM+MluqegyM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yh4YOPYM6o7d9y2jk5T4tP/Pt3523vFm/lyhhTWkJwv8vG6dvIEE3lgZiDPKxFvdj
	 9kl5L3hqVes6KpmsAvZDGLC/A5G/HGHNRO4rmL8rUuaVpXHKz+mnkQ4NE1yTyPEeDb
	 735rRFlKyOtMKBlPRma71Q61mrhb9d8/kyFY3QsmZqPUER6nJYJhXAdz7/yyLNkf6G
	 zZORasrzE0RGeNBiBj0I1imS6n7ivMME0LsogoWTVrF0FM4ULBcNx9PyNTMh2H2pog
	 /8HWiY4ukFNmTtbP8tzFm4l5w3qYy60CiEwHf3H7dz1TWmaH2IBrXUmHSj5OR/R4zq
	 MckxG3E6HPptg==
Date: Tue, 30 Jun 2026 16:51:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
	maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH v3] perf dso: Fix kallsyms DSO detection with fallback
 logic
Message-ID: <akRWfQB9lLwq2HsR@google.com>
References: <20260626161052.1024439-2-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626161052.1024439-2-tshah@linux.ibm.com>

On Fri, Jun 26, 2026 at 09:40:53PM +0530, Tanushree Shah wrote:
> The current kallsyms detection in dso__is_kallsyms() uses the
> dso_binary_type enum which fixes the issue of kallsyms being cached in
> the build-id cache for out-of-tree modules.
> 
> However, during build-id injection in perf record/inject, dso_binary_type
> has not been explicitly set yet,so dso__binary_type() returns
> DSO_BINARY_TYPE__NOT_FOUND instead of DSO_BINARY_TYPE__KALLSYMS for the
> kernel DSO. The current check then fails to identify it as kallsyms,
> causing build-id symlinks to not be created in ~/.debug/.build-id/ and
> perf archive to fail with "Cannot stat" errors.
> 
> Steps to reproduce the issue:
> 1. rm -rf ~/.debug/.build-id
> 2. perf record sleep 1
> 3. perf archive
> 
> Fix by falling back to matching long_name against the known kallsyms
> strings explicitly when binary_type is not yet set
> (== DSO_BINARY_TYPE__NOT_FOUND). Use strcmp() for exact matching of
> fixed names and strict validation for guest kallsyms with embedded PID
> to prevent path traversal attacks.
> 
> Fixes: ebf0b332732d ("perf dso: fix dso__is_kallsyms() check")
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> ---
> v2 -> v3: Replace strncmp() prefix matching with strcmp() for fixed
>           kallsyms names and add is_guest_kallsyms_pid_name() to
>           strictly validate guest kallsyms with PID format, preventing
>           path traversal attacks.
> 
> v1 -> v2: Rename DSO__NAME_GUEST_KALLSYMS to DSO__PREFIX_GUEST_KALLSYMS
>           to reflect that it is a prefix, not a full name.
> 
> v1: https://lore.kernel.org/all/20260410071225.708005-2-tshah@linux.ibm.com/
> 
>  tools/perf/util/dso.h | 57 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index ede691e9a249..8763e6f65316 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -9,6 +9,7 @@
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <linux/bitops.h>
> +#include <string.h>
>  #include "build-id.h"
>  #include "debuginfo.h"
>  #include "mutex.h"
> @@ -20,6 +21,40 @@ struct perf_env;
>  
>  #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
>  #define DSO__NAME_KCORE		"[kernel.kcore]"
> +#define DSO__NAME_GUEST_KALLSYMS		"[guest.kernel.kallsyms]"
> +#define DSO__NAME_GUEST_KALLSYMS_PID_PREFIX	"[guest.kernel.kallsyms."
> +
> +/*
> + * Validate names of the form "[guest.kernel.kallsyms.<pid>]", where
> + * <pid> is the PID of the guest VM and varies per guest, so it
> + * cannot be matched with strcmp() against a fixed string.
> + *
> + * Every character after the fixed prefix must be a decimal digit,
> + * with ']' immediately terminating the digit run and nothing
> + * following it. This rules out '/', "..", or any other character
> + * being smuggled into the name.
> + */
> +static inline bool is_guest_kallsyms_pid_name(const char *name)
> +{
> +	const size_t prefix_len = sizeof(DSO__NAME_GUEST_KALLSYMS_PID_PREFIX) - 1;
> +	size_t digits;
> +
> +	if (strncmp(name, DSO__NAME_GUEST_KALLSYMS_PID_PREFIX, prefix_len) != 0)
> +		return false;
> +
> +	digits = strspn(name + prefix_len, "0123456789");
> +	if (digits == 0)
> +		return false;
> +
> +	/* ']' must terminate the digit run, with nothing trailing it */
> +	if (name[prefix_len + digits] != ']')
> +		return false;
> +
> +	if (name[prefix_len + digits + 1] != '\0')
> +		return false;
> +
> +	return true;
> +}
>  
>  /**
>   * enum dso_binary_type - The kind of DSO generally associated with a memory
> @@ -914,8 +949,28 @@ static inline bool dso__is_kcore(const struct dso *dso)
>  static inline bool dso__is_kallsyms(const struct dso *dso)
>  {
>  	enum dso_binary_type bt = dso__binary_type(dso);

I have to check its usage carefully but any chance dso__symtab_type(dso)
instead produces better results?


> +	const char *name;
> +
> +	if (bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS)
> +		return true;
> +
> +	if (bt != DSO_BINARY_TYPE__NOT_FOUND)
> +		return false;
> +
> +	if (!RC_CHK_ACCESS(dso)->kernel)

I think the proper wrapper is dso__kernel().


> +		return false;
> +
> +	name = RC_CHK_ACCESS(dso)->long_name;

And dso__long_name().

Thanks,
Namhyung


> +	if (!name)
> +		return false;
> +
> +	if (!strcmp(name, DSO__NAME_KALLSYMS))
> +		return true;
> +
> +	if (!strcmp(name, DSO__NAME_GUEST_KALLSYMS))
> +		return true;
>  
> -	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
> +	return is_guest_kallsyms_pid_name(name);
>  }
>  
>  bool dso__is_object_file(const struct dso *dso);
> -- 
> 2.47.3
> 
