Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65431CF2B7;
	Thu, 22 Aug 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348981; cv=none; b=nwsR0Tnn07p3iA2YadW7UBxQFlDZhfrwSujB1aOM3tHDm91spC6LKf+jLwpUs5uhTUTSUWas4Wrv+RUNcMxw5ZjGHyRxeldtKOBy6yhjvSvqCRlHni5HogR+1Py8r57UOAc0i9gToL8GYsU+9wi98WkN/F1tLDmQjcTSsokfric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348981; c=relaxed/simple;
	bh=u08SxWemWJDzA5D25sAohXYrUeCGZcoPglqzdff1VQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7m+p2QhCxRmElWouIWzIIEvFbIfXr0x2Ve272gGPiaShhxq7+Jc7hBeGbiCNT6SguHfPe4Qxhe3+Wh0E3a/AJP0sV0OrLcncNFUODKbcIgg1UNbqbomjT6tTTeTW0CtTfhzhxAUEvBkR5tZVAJCP6uHU/pgti0dmsRgvuPgTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZyx3+l8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZyx3+l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACA3C4AF0F;
	Thu, 22 Aug 2024 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724348981;
	bh=u08SxWemWJDzA5D25sAohXYrUeCGZcoPglqzdff1VQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZyx3+l8olFxvVWAaaaIXhy+QEa22BliqHGrWd0+GiZvJbk7Zy+SuP7Ok6/NKwopO
	 pJT7QI/yMLMcpbBmBoMS9zv9yoTlaEd5Whu1C5MIXF6wRkS5M9BQOOaHmi4JQNZlmw
	 lANP3EIeUO5cTKDToBGD0E6rJ4zaIAOkJHEWFb0zSKYvvRCA4gowQLmFLuqLgFad7B
	 zAK4YA1tpUcRLHM0MwCEtkhVBEcyuDACZV19DAEWSVN0VN488QuJh199//IPgKSgVf
	 KMX/23tp67fiqulaoEW1f/yBsFnLTj34IsgpWT5l5qI2/zzJvEecb3K+5E8RkHbohC
	 NVON4rXsq2LWg==
Date: Thu, 22 Aug 2024 14:49:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] perf trace: Add
 trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
Message-ID: <Zsd6MgrCs0ybQ9EW@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-4-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815013626.935097-4-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:19AM +0800, Howard Chu wrote:
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
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 106 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 97076b962688..e7e8c89d9538 100644
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
> @@ -926,6 +927,23 @@ static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, str
>  	arg_fmt->type = btf__type_by_id(btf, id);
>  }
>  
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
>  static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
>  {
>  	const struct btf_type *bt = arg->fmt->type;
> @@ -3520,6 +3538,83 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
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
> @@ -3624,7 +3719,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  {
>  	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
>  	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> +	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);

At this point we still don't have that, right? I.e. building with this
patch, without the ones following it in your series, I get:

builtin-trace.c: In function ‘trace__init_syscalls_bpf_prog_array_maps’:
builtin-trace.c:3723:58: error: ‘struct <anonymous>’ has no member named ‘beauty_map_enter’
 3723 |         int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
      |                                                          ^
  CC      /tmp/build/perf-tools-next/tests/code-reading.o
  CC      /tmp/build/perf-tools-next/trace/beauty/clone.o
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
make[3]: *** Waiting for unfinished jobs....


So we need to squash the patch that introduces beauty_map_enter in the
augmented_raw_syscalls.bpf.c file to this one, so that we keep things
bisectable, I'll try to do that.

- Arnaldo
