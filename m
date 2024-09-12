Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B054185B5D;
	Thu, 12 Sep 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142221; cv=none; b=lNgG+t5RNskwTYJJ3fo5JNf1V0MIUjn9xsA2FGNCPVMD6RMQTFZfr/zmtFrQF93DJVGT9OX88q22SVjC0jCl/FnwyptXUhNlPXWpIgYQs3dhGv9uDR+8iJMLfiKMEPdzcZRTz4OPvWQuj+g7y/nrDLmVp7HZyOKO9Q/7kxLctlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142221; c=relaxed/simple;
	bh=A8wdww0er5ggmgsXROiK3rdoHRp09oG2Pjf7dwwm9NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boOqOBsGrXBHkmI3Fvf0MhYT6CioTbuJMMtkrYEBpnXR8uiCrxvcmjGrOCnVuink/Hxj2TlW7yrHJwBkn8Q4QF/z1IqOCmtYNcAb0uj5DtPrSGP/dkpHqZE81/R9sk4Dnf1ZsY2u+spwrJKTqqs4DHEd4kAWxRVbhUcD9KCkjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCQ7S4he; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCQ7S4he"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726142220; x=1757678220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A8wdww0er5ggmgsXROiK3rdoHRp09oG2Pjf7dwwm9NY=;
  b=bCQ7S4hef/zknA+bGBORiVwhA3nk3UWpgUxEuUi5G2oWKxYKQbmo7VQY
   6LTvxTrlaQfHnlJEXktdM+eBD8sZ2EVrQtVq3+0xOrLpvYtqBSmz7KkVs
   0Bb97Or9YAI22jQQFxPwlNDKIsp26Xr0i5beiMDC15OBGTIb2tXVAMdmT
   SW3m9L59Hbq43Gpa8/2hRS/MPZzlMarEGMfQwiq2UcDhbSg9Ys2sRr9uG
   /kezysaT8aRopLOFUktKiecBwmqSQXiCthspRg+MVRoztxD0Z4V9spNfC
   dAsBB9ro8l3fej/6mIvRdF98f/hMxZyrnYLwJeJFnSM7ZAVjQy1pPyDP8
   A==;
X-CSE-ConnectionGUID: uToR0xCfRIyLm2n55YTQGQ==
X-CSE-MsgGUID: UUzkjtooRbKAEd5uXjfawg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24523085"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="24523085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:56:59 -0700
X-CSE-ConnectionGUID: Q1eY3NHzSlymKWiT6qGHuw==
X-CSE-MsgGUID: egwhfoWOTxGumbwUsEdiew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="98386471"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.26.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:56:55 -0700
Message-ID: <096d999a-780b-446d-aaed-0415411003a8@intel.com>
Date: Thu, 12 Sep 2024 14:56:49 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf buildid-cache: recognize vdso when adding files
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240912111623.2213105-1-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240912111623.2213105-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/24 14:16, Changbin Du wrote:
> Identify vdso by file name matching. The vdso objects have name
> as vdso[32,64].so[.dbg].
> 
> $ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg
> 
> Without this change, added vdso using above command actually will never
> be used.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

I realized my example was overly convoluted since to
overwrite the existing buildid cache entry the --update
option could simply be used.  However, that needs another
change:

diff --git a/tools/perf/builtin-buildid-cache.c
b/tools/perf/builtin-buildid-cache.c
index 08de05e2aaae3..69f43460d007f 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -353,7 +353,7 @@ static int build_id_cache__update_file(const char
*filename, struct nsinfo *nsi)

 	if (!err)
 		err = build_id_cache__add_s(sbuild_id, filename, nsi, false,
-					    false);
+					    filename_is_vdso(filename));

 	pr_debug("Updating %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");

With that you can add:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>


> 
> ---
> This patch is separated from the series "perf: Support searching local
> debugging vdso or specify vdso path in cmdline".
> ---
>  tools/perf/builtin-buildid-cache.c | 32 +++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index b0511d16aeb6..08de05e2aaae 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -172,6 +172,36 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
>  	return 0;
>  }
>  
> +static bool filename_is_vdso(const char *filename)
> +{
> +	bool is_vdso = false;
> +	char *fname, *bname;
> +	static const char * const vdso_names[] = {
> +		"vdso.so", "vdso32.so", "vdso64.so", "vdsox32.so"
> +	};
> +
> +	fname = strdup(filename);
> +	if (!fname) {
> +		pr_err("no memory\n");
> +		return false;
> +	}
> +
> +	bname = basename(fname);
> +	if (!bname)
> +		goto out;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(vdso_names); i++) {
> +		if (strstarts(bname, vdso_names[i])) {
> +			is_vdso = true;
> +			break;
> +		}
> +	}
> +
> +out:
> +	free(fname);
> +	return is_vdso;
> +}
> +
>  static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>  {
>  	char sbuild_id[SBUILD_ID_SIZE];
> @@ -189,7 +219,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>  
>  	build_id__sprintf(&bid, sbuild_id);
>  	err = build_id_cache__add_s(sbuild_id, filename, nsi,
> -				    false, false);
> +				    false, filename_is_vdso(filename));
>  	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
>  		 err ? "FAIL" : "Ok");
>  	return err;

