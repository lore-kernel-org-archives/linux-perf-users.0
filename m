Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03012581;
	Tue, 25 Jun 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274101; cv=none; b=BAcKmDxq/uvZdvdjQ5iC4dYwsKBB3N1Pe+f5McXojNX1BwAAExVYMy9Qjre6UlNaqWcCxba2kxK8K2AY4hQphbnAQ0K8ZAboCH3ZRxS0v5a+7hV29Jv4koRs6SQK9Fbk9B1tB4DwtMAsL34TL4BF7DgNm18qLVWdpIy22FHL1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274101; c=relaxed/simple;
	bh=Z1ymqVurKMGJhAdz+Smjwd5aS+D3jPtOq7UUWfHem/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcVJ1VhJAmHsfKe3UJVW7m9Be/puaeo10F9w5NvGep3aXRGeLoHAxVw2nPEU9FkLWs6KaQKHrXQ1CykyAfzq1p6MLrycHfSYS4V8mKydpA8v0Zd5iK2/+umGwh/BLMk0gHX146RNmdGWdrXIqwdYpkCor+iFjueVxkuHJR42IKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HygrTUzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HygrTUzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4401C2BBFC;
	Tue, 25 Jun 2024 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274100;
	bh=Z1ymqVurKMGJhAdz+Smjwd5aS+D3jPtOq7UUWfHem/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HygrTUzgGlihHXceCpNZ2WhNQ1SjDQdU/PbyIFof+TkUoM7myS4qPoo0g8JDJX82R
	 QwiQvl/PJpnj8hAkZgD8lk+HsYcLLyYx7D0ieXdOAycYnemyCy/6LcHi7al326RNVV
	 nH4E6pu8S81cF39+HIXcszPee7NwDUWQPgwrvLpVRpD0FijrIDXHWozhnqC+xYDsSN
	 AxFYu1ag9fm0hcDUABGsM3ewhQQiijolkbMR21bgxUEme67Gmp6ohrEmToK1UXo9gb
	 EPpqq0ASLldj82wY0jr8BRJKD5dv5AF2jXaWDRKRzjoyZIkCaq49Jcr9nKVhkVVN5G
	 tKZB8oRYwiDxg==
Date: Mon, 24 Jun 2024 17:08:18 -0700
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
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/4] perf: disasm: use build_id_path if fallback failed
Message-ID: <ZnoKcoHtjvJgjETL@google.com>
References: <20240618015530.3699434-1-changbin.du@huawei.com>
 <20240618015530.3699434-3-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618015530.3699434-3-changbin.du@huawei.com>

Hello,

On Tue, Jun 18, 2024 at 09:55:28AM +0800, Changbin Du wrote:
> If we can not fallback for special dso (vmlinx and vdso), use the
> build_id_path found previously.
> 
> To make change easy, this change first refactors the code by extracting
> two functions read_buildid_linkname() and fallback_filename().

Can you please split the refactoring from the actual change?  It'd be
easier to review and to maintain the code.

Thanks,
Namhyung

> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/disasm.c | 121 ++++++++++++++++++++++++---------------
>  1 file changed, 75 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 442e9802a772..3075daa61916 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1092,14 +1092,72 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
>  	return 0;
>  }
>  
> -static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size)
> +static int read_buildid_linkname(char *filename, char *linkname, size_t linkname_size)
>  {
> -	char linkname[PATH_MAX];
> -	char *build_id_filename;
>  	char *build_id_path = NULL;
>  	char *pos;
>  	int len;
>  
> +	build_id_path = strdup(filename);
> +	if (!build_id_path)
> +		return ENOMEM;
> +
> +	/*
> +	 * old style build-id cache has name of XX/XXXXXXX.. while
> +	 * new style has XX/XXXXXXX../{elf,kallsyms,vdso}.
> +	 * extract the build-id part of dirname in the new style only.
> +	 */
> +	pos = strrchr(build_id_path, '/');
> +	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
> +		dirname(build_id_path);
> +
> +	len = readlink(build_id_path, linkname, linkname_size);
> +	if (len < 0) {
> +		free(build_id_path);
> +		return -1;
> +	}
> +
> +	linkname[len] = '\0';
> +	free(build_id_path);
> +	return 0;
> +}
> +
> +static int fallback_filename(struct dso *dso, char *filename, size_t filename_size)
> +{
> +	char filepath[PATH_MAX];
> +
> +	/*
> +	 * If we don't have build-ids or the build-id file isn't in the
> +	 * cache, or is just a kallsyms file, well, lets hope that this
> +	 * DSO is the same as when 'perf record' ran.
> +	 */
> +	if ((dso__kernel(dso) || dso__is_vdso(dso)) && dso__long_name(dso)[0] == '/')
> +		snprintf(filepath, sizeof(filepath), "%s", dso__long_name(dso));
> +	else
> +		__symbol__join_symfs(filepath, sizeof(filepath), dso__long_name(dso));
> +
> +	mutex_lock(dso__lock(dso));
> +	if (access(filepath, R_OK) && errno == ENOENT && dso__nsinfo(dso)) {
> +		char *new_name = dso__filename_with_chroot(dso, filepath);
> +		if (new_name) {
> +			strlcpy(filepath, new_name, sizeof(filepath));
> +			free(new_name);
> +		}
> +	}
> +	mutex_unlock(dso__lock(dso));
> +
> +	if (access(filepath, R_OK) && errno == ENOENT)
> +		return ENOENT;
> +
> +	snprintf(filename, filename_size, "%s", filepath);
> +	return 0;
> +}
> +
> +static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size)
> +{
> +	char linkname[PATH_MAX];
> +	char *build_id_filename;
> +
>  	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
>  	    !dso__is_kcore(dso))
>  		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
> @@ -1111,57 +1169,28 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	} else {
>  		if (dso__has_build_id(dso))
>  			return ENOMEM;
> -		goto fallback;
> +		return fallback_filename(dso, filename, filename_size);
>  	}
>  
> -	build_id_path = strdup(filename);
> -	if (!build_id_path)
> -		return ENOMEM;
> -
> -	/*
> -	 * old style build-id cache has name of XX/XXXXXXX.. while
> -	 * new style has XX/XXXXXXX../{elf,kallsyms,vdso}.
> -	 * extract the build-id part of dirname in the new style only.
> -	 */
> -	pos = strrchr(build_id_path, '/');
> -	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
> -		dirname(build_id_path);
> +	if (access(filename, R_OK))
> +		return fallback_filename(dso, filename, filename_size);
>  
> -	if (dso__is_kcore(dso))
> +	if (dso__is_kcore(dso) || dso__is_vdso(dso))
>  		goto fallback;
>  
> -	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
> -	if (len < 0)
> -		goto fallback;
> +	if (!read_buildid_linkname(filename, linkname, sizeof(linkname) - 1) &&
> +	    (!strstr(linkname, DSO__NAME_KALLSYMS) && !strstr(linkname, DSO__NAME_VDSO))) {
> +		/* not kallsysms or vdso, use build_id path found above */
> +		goto out;
> +	}
>  
> -	linkname[len] = '\0';
> -	if (strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO) ||
> -		access(filename, R_OK)) {
>  fallback:
> -		/*
> -		 * If we don't have build-ids or the build-id file isn't in the
> -		 * cache, or is just a kallsyms file, well, lets hope that this
> -		 * DSO is the same as when 'perf record' ran.
> -		 */
> -		if ((dso__kernel(dso) || dso__is_vdso(dso)) && dso__long_name(dso)[0] == '/')
> -			snprintf(filename, filename_size, "%s", dso__long_name(dso));
> -		else
> -			__symbol__join_symfs(filename, filename_size, dso__long_name(dso));
> -
> -		mutex_lock(dso__lock(dso));
> -		if (access(filename, R_OK) && errno == ENOENT && dso__nsinfo(dso)) {
> -			char *new_name = dso__filename_with_chroot(dso, filename);
> -			if (new_name) {
> -				strlcpy(filename, new_name, filename_size);
> -				free(new_name);
> -			}
> -		}
> -		mutex_unlock(dso__lock(dso));
> -	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
> -		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
> +	if (fallback_filename(dso, filename, filename_size)) {
> +		/* if fallback failed, use build_id path found above */
> +out:
> +		if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
> +			dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
>  	}
> -
> -	free(build_id_path);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
