Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6A13A265;
	Wed, 11 Sep 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041933; cv=none; b=bWjxTwk9dYXGfvN2vAHcrcu3/17HG0lY2iGijqF14yrJCjsgaNhX9ladu7uMbsmaGmDr732FZxHFbdp/d3jFCnPZ+oALyF5kRgggx9dlsB1aAs4eDbE0uhroX5C7eK+r4lAg5uncYZnwHGstSJMTXOhUNvV2f/zSSYdonUyrocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041933; c=relaxed/simple;
	bh=/ETTyYJZAtrlhlGoUsbijw1LRkWz+eoO3Dx3PvHOT1k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bdVQf6FNhHO9rkEtii6KPdQxj5mIqSbQj5nfF5lUX7OPh1I1Pmzft296Xm5iB48di/A0JNKsqRFEZuwm1u7kDqnwC3sl1jy5NWb+apJUDrpc5kCTl8xQevy2z5TZYSXR+KrX/thXXHf+og+sJo97WvE+jSgN9Wr6pWsF3RyXxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMAQzrIm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMAQzrIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041932; x=1757577932;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=/ETTyYJZAtrlhlGoUsbijw1LRkWz+eoO3Dx3PvHOT1k=;
  b=jMAQzrImp4KZuQ6+apCtgGeLGEjqxW+rC/5maY5Q1LmIJdSKjn5Qrcfc
   FrBLpU3csqTJM8eNs9aXQZzaGr0CnPmZDUE+yq2O/wh48Oz0gHs0wy0Lk
   mW7hjGC8u+cDqulEMtLXMsjgJetzp039Ut+BCvg9FMvZVNvo7+s2eFDu6
   e+JM45Yr95fFV8kw6KVdqr2ci5VoHOkFle3VJYYWYv/b6S0hr5jzP33Ab
   SI75dNRd0easnJHdeA1aBKFG9l7LlN+ni+V+GStonFYPfwrSYQ3FtS15J
   SUPnUp4exUEEjsDABzgeR0W37p5GgdUPKmFXO4F14rU2V7vTYCF9KNiio
   w==;
X-CSE-ConnectionGUID: 8FxekmKIS8ywwcXJeyJ8lg==
X-CSE-MsgGUID: 97wxra2lTcmbcfTss4oTtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28565970"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="28565970"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:05:30 -0700
X-CSE-ConnectionGUID: zBTBcCDSS7mQlT+bFuzpTg==
X-CSE-MsgGUID: f/tysCQgQjOPqLaYPiqLGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67790972"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:05:26 -0700
Message-ID: <68f29f30-f0f8-4cda-a99a-68f51838dcd7@intel.com>
Date: Wed, 11 Sep 2024 11:05:20 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 8/8] perf buildid-cache: recognize vdso when adding
 files
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
References: <20240725021549.880167-1-changbin.du@huawei.com>
 <20240725021549.880167-9-changbin.du@huawei.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725021549.880167-9-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 05:15, Changbin Du wrote:
> Identify vdso by file name matching. The vdso objects have name
> as vdso[32,64].so[.dbg].
> 
> $ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg
> 
> Without this change, adding vdso using above command actually will never
> be used.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

A couple of comments, but address those then add:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-buildid-cache.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index b0511d16aeb6..8edea9044a65 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -172,6 +172,30 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
>  	return 0;
>  }
>  
> +static bool filename_is_vdso(const char *filename)
> +{
> +	char *fname, *bname;
> +	static const char * const vdso_names[] = {
> +		"vdso.so", "vdso32.so", "vdso64.so", "vdsox32.so"
> +	};
> +
> +	fname = strdup(filename);
> +	if (!fname) {
> +		pr_err("no mememory\n");

mememory -> memory

> +		return false;
> +	}

fname is never freed.

> +
> +	bname = basename(fname);
> +	if (!bname)
> +		return false;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(vdso_names); i++) {

'unsigned' is unnecessary

> +		if (!strncmp(bname, vdso_names[i], strlen(vdso_names[i])))

Use strstarts()

> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>  {
>  	char sbuild_id[SBUILD_ID_SIZE];
> @@ -189,7 +213,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>  
>  	build_id__sprintf(&bid, sbuild_id);
>  	err = build_id_cache__add_s(sbuild_id, filename, nsi,
> -				    false, false);
> +				    false, filename_is_vdso(filename));
>  	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
>  		 err ? "FAIL" : "Ok");
>  	return err;

