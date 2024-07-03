Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A8136643;
	Wed,  3 Jul 2024 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048709; cv=none; b=ARbKkRWCRoxIY0F3ny5ExUXsCVRZmtTvZgAlGpnqF4hKJmoXZTY5/5z7Y+miCV+eXiPJXWdoa+Vz76H5LMA32mb5svz2qkLRC3qjwyM7bIFXXH+paw7/uE5YOYIuHmRIq9Gg4PWS+fr/eHPfd3xucgRc01Ly9m27j0JP8blOisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048709; c=relaxed/simple;
	bh=leq8VNyokdvpQStEdxb0BGwQSSksYqqYCuQZSbBzsQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlqkcyPNbIkHWR9ZzpeNpRY3NZpldwRzl552R2HQKvK7gCrS+CTDBB15FDSLzAtDBPwR9PizIom8EeCOVcrMiwQLUyTo5AIGtazfPBuhIqiO3oTL9ztfvn/hpTdfDtBHjOS70JtAV4ab5c+gICwLBSmYVjNZ/+Tgdl2wMcjiFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp/WzDVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp/WzDVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0EAC2BD10;
	Wed,  3 Jul 2024 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720048708;
	bh=leq8VNyokdvpQStEdxb0BGwQSSksYqqYCuQZSbBzsQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bp/WzDVC4BdTUPn2o2qlmwUR55Hld+30vDvwX7VrDHWNYUeDB+bvBPG+OpCn1W8su
	 0C6In+U+QOJra838+j9XuCsk0SNM4tMBV7aQ8L8xTK5JxSGUnEoOwu5+hyNcStpns7
	 p9usbd70QPW0pzUVHK1F6LlZDZ4+HImnLM7JN8uXjXksLExKUbAoRSPkLp2ty8VCTz
	 0rojh20k7YeJjpEydGkG78SVu/uWoWNvE+Sek6dWoC8koBT2KsN0xX2xY78rWLkSNE
	 2BzIhr0e+nrVgM6ZEZJ7YUNqVJQWCt62Dk5UgwvOEvvDzcDPt+94agNEM50NHxjsFX
	 WpBaoDWtfZ4uQ==
Date: Wed, 3 Jul 2024 16:18:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v5 8/8] perf buildid-cache: recognize vdso when adding
 files
Message-ID: <ZoXcQunHBf0Z1JIW@google.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
 <20240702041837.5306-9-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702041837.5306-9-changbin.du@huawei.com>

Hello,

On Tue, Jul 02, 2024 at 12:18:37PM +0800, Changbin Du wrote:
> Identify vdso by file name matching. The vdso objects have name
> as vdso[32,64].so[.dbg].
> 
> $ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg
> 
> Without this change, adding vdso using above command actually will never
> be used.

Can we handle /tmp/perf-vdso.so-XXXXXX too?

Thanks,
Namhyung

> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
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
> +		return false;
> +	}
> +
> +	bname = basename(fname);
> +	if (!bname)
> +		return false;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(vdso_names); i++) {
> +		if (!strncmp(bname, vdso_names[i], strlen(vdso_names[i])))
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
> -- 
> 2.34.1
> 
