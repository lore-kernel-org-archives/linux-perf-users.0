Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE029CF6;
	Thu, 12 Sep 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143270; cv=none; b=RklRFwYcW/Kxdd9USibMBihsoe1Cf0zR/zhXPJGLz5n4096Vp9BWAX5EEkVfeWlnrZIa9bjO2MJekac2tnjOe7YrMzSTv7ImIQZOzCa8o3LHUhcr+urp1lz+yK7AqyFON1HVZzr4AmV3farWLL8SRy/aHtAHqtyr2LuzbGVQUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143270; c=relaxed/simple;
	bh=LDj2BB55PD5Fd6BGi69vq4kA8GqCGYuml3ehTb4uRjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4c6RWcI13RWkazmEi3npC9n5p8iXoQbU0s9Czu19paVC4U2IlQf05zuozyq0XhuTyBwk2B4lEUSH9USZdpAvXMtG6qI9iWtttbksZim5BDl7++1o89ievBcESqoS0P8GM2o2cD3gK/SH2QaYQHvp1MQLMjfJXLXowsfhv+C46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKrsQ3dG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKrsQ3dG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EE3C4CEC4;
	Thu, 12 Sep 2024 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726143270;
	bh=LDj2BB55PD5Fd6BGi69vq4kA8GqCGYuml3ehTb4uRjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKrsQ3dGHSRyiTPrgsdPrNPmodaASDBZv1AAGOimmjSpiYPKc5Bsk3WhrsPhtSxWN
	 zK1W0NmS4DrYmC6cW4/8BumcPumPGZBuAZpkIsdn0UIF0ojw5dOfJi/FGk74XWMB6Z
	 /AP3ZGP3m6PMpXw30hww681wBZ/TAqJ9aqjzlcP7IKhzpleqkISe5mK5jlGjNSCm/f
	 o3ft+DXhOg5JQ99MEKfJybAdXM6DozvENtSHRRGRB3Uv6tbloOosOhZo22B26F4pCa
	 JaQUkemGRAfMKLa8MiX+w1/u9JrNJLgCCgw88k88lvAY2eCh5xDjTAA3F2fvJdtPl9
	 CilbJuOAD+MlA==
Date: Thu, 12 Sep 2024 09:14:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf buildid-cache: recognize vdso when adding files
Message-ID: <ZuLbImKneZj2afcm@x1>
References: <20240912120303.2294175-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912120303.2294175-1-changbin.du@huawei.com>

On Thu, Sep 12, 2024 at 08:03:03PM +0800, Changbin Du wrote:
> Identify vdso by file name matching. The vdso objects have name
> as vdso[32,64].so[.dbg].
> 
> $ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg
> 
> Without this change, added vdso using above command actually will never
> be used.
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>


Thanks, applied to perf-tools-next,

- Arnaldo
 
> ---
> This patch is separated from the series "perf: Support searching local
> debugging vdso or specify vdso path in cmdline".
> 
> v2: also update build_id_cache__update_file().
> ---
>  tools/perf/builtin-buildid-cache.c | 34 ++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index b0511d16aeb6..69f43460d007 100644
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
> @@ -323,7 +353,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
>  
>  	if (!err)
>  		err = build_id_cache__add_s(sbuild_id, filename, nsi, false,
> -					    false);
> +					    filename_is_vdso(filename));
>  
>  	pr_debug("Updating %s %s: %s\n", sbuild_id, filename,
>  		 err ? "FAIL" : "Ok");
> -- 
> 2.34.1
