Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62D372EDD;
	Tue, 29 Sep 2026 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726298; cv=none; b=PMZCzIpfTmsH+DzB8bfbO+G7tGjswanwgFnD1s0eaHOVF8Rbkw2TqTVuXXJnPTe1GfVQo7Ab38G6Dk28M9cS5hXoamH+Bp7f4rY5pkTdFcDWRzN9HxsO+SY4NJPmTxKEzSKgJj029ZAiPVk/TIy6rL/S5FT9wVq+7cmN9htHkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726298; c=relaxed/simple;
	bh=c7MoQ0McuuWc5hSvRsoKsLhQpIvXSpZ1py4o7MufjE0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tTJDuqXhaQK9WP4RO2rIoJJFenOhE7fIAOj0pgXYn/5fsL2pIBrpqkLE1Yc6E2PUMVLTw/oVVjTAbf+VM5vWDQKHk7qIq7JHeceDYuZqrywLtlqJJUQjSaUWwgFGqy+t6eeK+wgt8cPEgoUZDzBzqkoid796gmnhhIfEa1OUuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjTZO47C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjTZO47C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356B01F000FF;
	Tue, 29 Sep 2026 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726296;
	bh=kJtbXgOmUBQQmBkKV/prrCPczHPcLI1tyn/KSadxlnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SjTZO47CxVHRnnhWyZqWRGIwx5oQ/Z02pb4YyCKZoFsEO9Gh+x4xdps7wWLsnAxtr
	 psyFdlrKKXp9k5l6sZ/ByK5OFyYux5mpbyuY4CVwNaIDXEvhAc2Nd4Hl5jfW3q76Kw
	 rzKRHDLV69q4Sh1AhdPgYAg/VfVTsaiaEQtCZ2z+v5cjdAg6FBdQUSf0iVCE8rka6P
	 41JZZewK7BEASloNvL0OjuZhGkQCXKp/P4jFnZA9YbKLqvhkuDMyfUyJ5vHTW7Iv8H
	 bkA1FYCh4TjsUPrrSSPdObFlj8f53gEgy5nHOwYtaKoPy4eipcPBl9Q+f4tGJcqpsk
	 Tlw2J2sakYFhQ==
Date: Wed, 30 Sep 2026 08:58:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, James Clark <james.clark@linaro.org>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 8/8] perf tools: Update debuginfo__new() to take DSO
Message-Id: <20260930085811.bf08e4fa082f4f303b7fe817@kernel.org>
In-Reply-To: <20260929011139.53242-9-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
	<20260929011139.53242-9-namhyung@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 18:11:39 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> It should be the common case to get debuginfo from existing DSOs.
> Now dso__debuginfo() calls it with its debuginfo type to avoid the
> unnecessary loop to find the location of debug file.
> 
> Update existing function to debuginfo__from_path() for clarity.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/debuginfo.c   | 28 ++++++++++++++++++----------
>  tools/perf/util/debuginfo.h   | 13 +++++++++++--
>  tools/perf/util/dso.c         | 11 ++---------
>  tools/perf/util/probe-event.c |  4 ++--
>  4 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index fc2640dcd29d3aaa..db188c397d63880c 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -91,13 +91,27 @@ static struct debuginfo *__debuginfo__new(const char *path)
>  	return dbg;
>  }
>  
> -struct debuginfo *debuginfo__new(const char *path)
> +struct debuginfo *debuginfo__new(struct dso *dso)
> +{
> +	struct debuginfo *dinfo;
> +	char *path;
> +	bool decomp = false;
> +
> +	dso__find_dbginfo_type(dso);
> +	path = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
> +	if (path == NULL)
> +		return NULL;
> +
> +	dinfo = __debuginfo__new(path);
> +	dso__put_filename(dso, path, decomp);
> +	return dinfo;
> +}
> +
> +struct debuginfo *debuginfo__from_path(const char *path)
>  {
>  	struct dso *dso;
>  	struct debuginfo *dinfo;
>  	struct build_id bid = { .size = 0 };
> -	char *filename;
> -	bool decomp = false;
>  
>  	/* Try to open distro debuginfo files */
>  	dso = dso__new(path);
> @@ -112,13 +126,7 @@ struct debuginfo *debuginfo__new(const char *path)
>  	if (filename__read_build_id(path, &bid) > 0)
>  		dso__set_build_id(dso, &bid);
>  
> -	dso__find_dbginfo_type(dso);
> -	filename = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
> -	if (filename == NULL)
> -		return NULL;
> -
> -	dinfo = __debuginfo__new(filename);
> -	dso__put_filename(dso, filename, decomp);
> +	dinfo = debuginfo__new(dso);
>  	dso__put(dso);
>  
>  	return dinfo;
> diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
> index a52d69932815cd72..ade40d54ea125988 100644
> --- a/tools/perf/util/debuginfo.h
> +++ b/tools/perf/util/debuginfo.h
> @@ -18,8 +18,12 @@ struct debuginfo {
>  	const unsigned char	*build_id;
>  };
>  
> +struct dso;
> +
>  /* This also tries to open distro debuginfo */
> -struct debuginfo *debuginfo__new(const char *path);
> +struct debuginfo *debuginfo__from_path(const char *path);
> +/* Create a debuginfo using information in DSO */
> +struct debuginfo *debuginfo__new(struct dso *dso);
>  void debuginfo__delete(struct debuginfo *dbg);
>  
>  int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
> @@ -31,7 +35,12 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
>  struct debuginfo {
>  };
>  
> -static inline struct debuginfo *debuginfo__new(const char *path __maybe_unused)
> +static inline struct debuginfo *debuginfo__from_path(const char *path __maybe_unused)
> +{
> +	return NULL;
> +}
> +
> +static inline struct debuginfo *debuginfo__new(struct dso *dso __maybe_unused)
>  {
>  	return NULL;
>  }
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e4a2a0ea38823b5f..d3017c82ffb5f4b1 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -2086,17 +2086,10 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
>  
>  struct debuginfo *dso__debuginfo(struct dso *dso)
>  {
> -	char *name;
> -	bool decomp = false;
> -	struct debuginfo *dinfo = NULL;
> +	struct debuginfo *dinfo;
>  
>  	mutex_lock(dso__lock(dso));
> -
> -	name = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
> -	if (name) {
> -		dinfo = debuginfo__new(name);
> -		dso__put_filename(dso, name, decomp);
> -	}
> +	dinfo = debuginfo__new(dso);
>  	mutex_unlock(dso__lock(dso));
>  	return dinfo;
>  }
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 11ae4a09412c9bd9..1534280c0c1d59cb 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -519,7 +519,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
>  		pr_debug("Load debuginfo from debuginfod (%s)\n", path);
>  
>  	nsinfo__mountns_enter(nsi, &nsc);
> -	ret = debuginfo__new((const char *)path);
> +	ret = debuginfo__from_path((const char *)path);
>  	nsinfo__mountns_exit(&nsc);
>  	return ret;
>  }
> @@ -567,7 +567,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
>  		path = dso__long_name(dso);
>  	}
>  	nsinfo__mountns_enter(nsi, &nsc);
> -	ret = debuginfo__new(path);
> +	ret = debuginfo__from_path(path);
>  	if (!ret && !silent) {
>  		pr_warning("The %s file has no debug information.\n", path);
>  		if (!module || !strtailcmp(path, ".ko"))
> -- 
> 2.55.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
