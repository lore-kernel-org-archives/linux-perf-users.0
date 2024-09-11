Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59314D6F7;
	Wed, 11 Sep 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041862; cv=none; b=h4txNcA1xLdSLsoA2DvhFGLD0Yc5v9Tvi6RV5+iab6b22J+uMdzusn12DacQ50J832QoHxhLp/Iln3TPioYpsmMSzd/qnIEBI2dGTe+yULptoQyYNYl/L531wEhcPUj8flxhZ4d2OqzSyN2E/1M5cuqp/c48gwMxLGfvMATaDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041862; c=relaxed/simple;
	bh=VEZOeYHdd4jM2M8LfxT86GB3Nj8PUvIPCHuAzaLiNYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2JIUvQCf6EyfU92n6H7uqBiPi81RwmrQnc59RvQfyPpK4SiDG14/KK8DG60FmtpxOiBkKcnG4vv2tCm3PKEFjFsZseVJ7rthWKqfB96q0p8EIfONJr+TEjo9IM4/i3Z2vgNSpnjL2CgtOMGcbBXzpB9XRnBpPA5Pfj08agk9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSvhXJ3k; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSvhXJ3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041861; x=1757577861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VEZOeYHdd4jM2M8LfxT86GB3Nj8PUvIPCHuAzaLiNYw=;
  b=hSvhXJ3kk/a1POJzE+mBHW9lInxgi5+OsunHiKThVamAJ1cH/fOP/KZ0
   loIdT26bWy8Wd/fQA2TJ/Tou6ynWtY1uhQZCGIVzSguRUfZ61C85C4Ndr
   tqSIdMurga5pAGu16I8IPXWgo+s2k3+VYllRiK3AkR2OQHujUlzRYt68v
   G4hm8xONjczvFD7p4CiLspCcRnY13bR2fdqrvJYRQFGtGPAcgDlnC75tB
   G552fYPDhlTps9aJH8oV+0NLA3yVdSZLF8ojHdXeE8qWcxCDiTIun1zQO
   uFFhuANqN87NiH5W6pXVFCjlQs3Y1YJzTKDDifJrzicZeD/PH93hj2mg0
   w==;
X-CSE-ConnectionGUID: VW8P8QfJQzaCf6z9+UUdtg==
X-CSE-MsgGUID: p2X6rtaMSradcHf2s7R+Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24321145"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24321145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:04:21 -0700
X-CSE-ConnectionGUID: rM1kOUhyQbm8wu6+SlxVJQ==
X-CSE-MsgGUID: e467FPJ+T2yJc39+pzaEwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="97989852"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:04:15 -0700
Message-ID: <9b2b5b0e-727c-4e74-8337-875498941de2@intel.com>
Date: Wed, 11 Sep 2024 11:04:10 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] perf: build-id: add support for build-id cache
 vdso debug
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
 <20240725021549.880167-6-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725021549.880167-6-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 05:15, Changbin Du wrote:
> This try to add debugging vdso elf to build-id cache the same as normal
> objects. Later we will extend this to find local debugging vdso from
> special paths.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/build-id.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 83a1581e8cf1..5bda47de5cf2 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -259,8 +259,8 @@ static bool build_id_cache__valid_id(char *sbuild_id)
>  static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
>  					    bool is_debug)
>  {
> -	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : (is_debug ?
> -	    "debug" : "elf"));
> +	return is_kallsyms ? "kallsyms" : (is_debug ? "debug" : (is_vdso ?
> +		"vdso" : "elf"));
>  }
>  
>  char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
> @@ -701,13 +701,12 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>  	 * file itself may not be very useful to users of our tools without a
>  	 * symtab.
>  	 */
> -	if (!is_kallsyms && !is_vdso &&
> -	    strncmp(".ko", name + strlen(name) - 3, 3)) {
> +	if (!is_kallsyms && strncmp(".ko", name + strlen(name) - 3, 3)) {
>  		debugfile = build_id_cache__find_debug(sbuild_id, nsi, root_dir);
>  		if (debugfile) {
>  			zfree(&filename);
>  			if (asprintf(&filename, "%s/%s", dir_name,
> -			    build_id_cache__basename(false, false, true)) < 0) {
> +			    build_id_cache__basename(false, is_vdso, true)) < 0) {
>  				filename = NULL;
>  				goto out_free;
>  			}

