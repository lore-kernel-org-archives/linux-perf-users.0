Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4091176AAD;
	Mon,  9 Sep 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911151; cv=none; b=ujCIQvtoefCVsca9jNx1eNDFwVTakhsQGGayOETeag9MNUFm2oEMcyE4W9dN/mZ6qNGkJSfqQ69SwDXX6iHZresasCrgtGHqkBwIkCt6/8NLbnUD6Kg8YO8BIhGx1rc6viiycDwnj7HumJcC1hZk/x4aJlU5ZstSPvAMU6g6/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911151; c=relaxed/simple;
	bh=FwR2Y2Cu3oguvArUlQalbWar75hW7Mk8bgbZikdOfLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e20fdEsjUEG0KtQ2g6N+FMxYCDTX7ikk9ubKd1Qaf7iTBZonyShL9HfTuO9gZW03KFkIRdN+byPYMEHQvzTGq/PSKccDeWvb9+ziAdtNQKDCuHag3vqZIkEM51fNhWxtvIbTrokVRTkA40OZ/lm2r+6zN8yWiGiB4YTFUvABgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXKKMwFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXKKMwFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC7C4CEC5;
	Mon,  9 Sep 2024 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911151;
	bh=FwR2Y2Cu3oguvArUlQalbWar75hW7Mk8bgbZikdOfLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXKKMwFJ/qd19Xy7XRmVZMytqKgzUImIJueRXuFCAdXU3ZAcwvJLqRiO1Q39YSkgK
	 8qrDZaZjQJry6KH5ed8TYDkJSg2GA+Jq1Fv7x1RGPNWRz35f4CTiCJab6j+WIOuwpo
	 pkUHPlK3Scqm/DXkJzG9Y6jBrzSkMR3oS9fLHAxghfWPDDKLiJN1bbSdMZPgzxCLfs
	 2fYDO5gpiDUD/mn6WDCmS9gFT+fsFdorxrj2QoLMod34JsLuzStjiHBXddiZIwQg2P
	 BG/qCKymAoYyu96oCdl15N0DHh4gQAbBqqQa9D9ySuUtOGpGQ1Xp/rQcA2aVNRmvBk
	 jX7mEP6EiFAVg==
Date: Mon, 9 Sep 2024 16:45:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/8] perf trace: Add trace__bpf_sys_enter_beauty_map()
 to prepare for fetching data in BPF
Message-ID: <Zt9Qa_znFmHADff1@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824163322.60796-3-howardchu95@gmail.com>

On Sun, Aug 25, 2024 at 12:33:16AM +0800, Howard Chu wrote:
> Set up beauty_map, load it to BPF, in such format: if argument No.3 is a
> struct of size 32 bytes (of syscall number 114) beauty_map[114][2] = 32;
> 
> if argument No.3 is a string (of syscall number 114) beauty_map[114][2] =
> 1;
> 
> if argument No.3 is a buffer, its size is indicated by argument No.4 (of
> syscall number 114) beauty_map[114][2] = -4; /* -1 ~ -6, we'll read this
> buffer size in BPF  */
> 
> Committer notes:
> 
> Moved syscall_arg_fmt__cache_btf_struct() from a ifdef
> HAVE_LIBBPF_SUPPORT to closer to where it is used, that is ifdef'ed on
> HAVE_BPF_SKEL and thus breaks the build when building with
> BUILD_BPF_SKEL=0, as detected using 'make -C tools/perf build-test'.

Here we have to have this:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba7b1338123dc5f1..588305b26a064edf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3572,6 +3572,10 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigne
        for (i = 0, field = sc->args; field; ++i, field = field->next) {
                struct_offset = strstr(field->type, "struct ");
 
+               // XXX We're only collecting pointer payloads _from_ user space
+               if (!sc->arg_fmt[i].from_user)
+                       continue;
+
                if (field->flags & TEP_FIELD_IS_POINTER && struct_offset) { /* struct */
                        struct_offset += 7;

I added some patches before this one that add that .from_user field and
marks the syscall args that flow from user to kernel space, we'll
probably need to tune that a bit, but then its "better" not to collect
old contents of buffers in syscalls that flows from kernel to userspace
than to lose the opportunity to collect data flowing from user to kernel
space.

I.e. its better to not show something useful than to show something
misleading/utterly bogus.

- Arnaldo

> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20240815013626.935097-4-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 106 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d6ca541fdc78..c26eab196623 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -113,6 +113,7 @@ struct syscall_arg_fmt {
>  	bool	   show_zero;
>  #ifdef HAVE_LIBBPF_SUPPORT
>  	const struct btf_type *type;
> +	int	   type_id; /* used in btf_dump */
>  #endif
>  };
>  
> @@ -3446,6 +3447,23 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
>  }
>  
>  #ifdef HAVE_BPF_SKEL
> +static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
> +{
> +       int id;
> +
> +	if (arg_fmt->type != NULL)
> +		return -1;
> +
> +       id = btf__find_by_name(btf, type);
> +       if (id < 0)
> +		return -1;
> +
> +       arg_fmt->type    = btf__type_by_id(btf, id);
> +       arg_fmt->type_id = id;
> +
> +       return 0;
> +}
> +
>  static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
>  {
>  	struct bpf_program *pos, *prog = NULL;
> @@ -3521,6 +3539,83 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
>  	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
>  }
>  
> +static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
> +{
> +	struct tep_format_field *field;
> +	struct syscall *sc = trace__syscall_info(trace, NULL, key);
> +	const struct btf_type *bt;
> +	char *struct_offset, *tmp, name[32];
> +	bool can_augment = false;
> +	int i, cnt;
> +
> +	if (sc == NULL)
> +		return -1;
> +
> +	trace__load_vmlinux_btf(trace);
> +	if (trace->btf == NULL)
> +		return -1;
> +
> +	for (i = 0, field = sc->args; field; ++i, field = field->next) {
> +		struct_offset = strstr(field->type, "struct ");
> +
> +		if (field->flags & TEP_FIELD_IS_POINTER && struct_offset) { /* struct */
> +			struct_offset += 7;
> +
> +			/* for 'struct foo *', we only want 'foo' */
> +			for (tmp = struct_offset, cnt = 0; *tmp != ' ' && *tmp != '\0'; ++tmp, ++cnt) {
> +			}
> +
> +			strncpy(name, struct_offset, cnt);
> +			name[cnt] = '\0';
> +
> +			/* cache struct's btf_type and type_id */
> +			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name))
> +				continue;
> +
> +			bt = sc->arg_fmt[i].type;
> +			beauty_array[i] = bt->size;
> +			can_augment = true;
> +		} else if (field->flags & TEP_FIELD_IS_POINTER && /* string */
> +		    strcmp(field->type, "const char *") == 0 &&
> +		    (strstr(field->name, "name") ||
> +		     strstr(field->name, "path") ||
> +		     strstr(field->name, "file") ||
> +		     strstr(field->name, "root") ||
> +		     strstr(field->name, "key") ||
> +		     strstr(field->name, "special") ||
> +		     strstr(field->name, "type") ||
> +		     strstr(field->name, "description"))) {
> +			beauty_array[i] = 1;
> +			can_augment = true;
> +		} else if (field->flags & TEP_FIELD_IS_POINTER && /* buffer */
> +			   strstr(field->type, "char *") &&
> +			   (strstr(field->name, "buf") ||
> +			    strstr(field->name, "val") ||
> +			    strstr(field->name, "msg"))) {
> +			int j;
> +			struct tep_format_field *field_tmp;
> +
> +			/* find the size of the buffer that appears in pairs with buf */
> +			for (j = 0, field_tmp = sc->args; field_tmp; ++j, field_tmp = field_tmp->next) {
> +				if (!(field_tmp->flags & TEP_FIELD_IS_POINTER) && /* only integers */
> +				    (strstr(field_tmp->name, "count") ||
> +				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
> +				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
> +					 /* filename's got 'len' in it, we don't want that */
> +					beauty_array[i] = -(j + 1);
> +					can_augment = true;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (can_augment)
> +		return 0;
> +
> +	return -1;
> +}
> +
>  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
>  {
>  	struct tep_format_field *field, *candidate_field;
> @@ -3625,7 +3720,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  {
>  	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
>  	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> +	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
>  	int err = 0;
> +	unsigned int beauty_array[6];
>  
>  	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
>  		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
> @@ -3644,6 +3741,15 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
>  		if (err)
>  			break;
> +
> +		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
> +		memset(beauty_array, 0, sizeof(beauty_array));
> +		err = trace__bpf_sys_enter_beauty_map(trace, key, (unsigned int *)beauty_array);
> +		if (err)
> +			continue;
> +		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
> +		if (err)
> +			break;
>  	}
>  
>  	/*
> -- 
> 2.45.2
