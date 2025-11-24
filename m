Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16A2FAC14
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983277; cv=none; b=aUJAW3GJb69AibK7KPeS2apo/ZwunQutWbMUV8fSqdpSoW56UA42H174dx69/L9YojvZyumtutjWePiL3ulqi/cN/iLyb+u/TeBQ/uvQjIZf7SkE28nZyDNRhFc+m3keHvZoR3vxGEaMXR3B8eFJBG9RWS5QPZsZcoTSiWkiQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983277; c=relaxed/simple;
	bh=UDYnqMPmk8zxdXrmVMYEg9hGtStGiwrnHHzIJ9wLNdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jDCX5xZj3cB/6MXHhu0cS4mf0ENTI1lx7b7uXtmJuXVN+9ETxvp0cCP47eVsgLARp/1RlRrE3QaKN57LbGk9FPQyrVS0czMKyKjSQf/nLzDfu8G0Dxth8c1nsQp9JHWx4PjZgTn4y2mKiZM/IY3cY1qTiQpfoU8P5h9k5tBgUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nOMBCiO0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOMBCiO0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47774d3536dso32087495e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763983272; x=1764588072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0H3bDeefntMFs3ZygJJdRj1o0VerEyUOKPiBVExpg4=;
        b=nOMBCiO0i10YNQMCVS3nCjvo1zdw2qU2s8TTjLU6y0OMHjxQ864SvTyXav1Qd1ARrf
         jzpLbyd4lIkM6AN5SJJ0MqA5SU0RaPOW8LZCCXuLaPZuoGuTWN1c1Ivdo2ZmAEC8rD05
         f4q2vhq/a9andm0M4vj+sY+A/PaOFg7n9eRQp9E7VpOGScaasTjfSNZY87XI8pDQt7En
         C+E6Jj/c5Cpe8YfHGJCxUhCjOVBaED7NvFmyNGx9iTMZwTIY8kUvhBCxom4lRp+w7Uas
         8fc9u47QvzNP3qxnkvSmG9mhOhg3wqIfO5uKM/ja/nV+kp7oEjSds5mX/kQwXSxZiI0I
         NGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983272; x=1764588072;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0H3bDeefntMFs3ZygJJdRj1o0VerEyUOKPiBVExpg4=;
        b=XiqTX2jD8RKx+KSomFCUFSOOKSNw/gW/9i6Htp5LugrE73/ejMOWolkCbw9F2/w3Pl
         Qos/2zVJ3j3+JJZoXWgR3jagJv2Zu52er558OjTKza9P4OkrA9F0ZIMKWWeSkhdRP5am
         7ydDr4yVk0FVljUAPNKEosnXhFxQhLuh2UVMrNxDLpVRjOHg4NveSZqASHX2w0LDNVgX
         4j0KQGBXB2NbXDTf2miq7RyUC/zA9kd7HDJUuGO+zWg1J/ai+GACTXBIh7cLCQJp0VTS
         SBJbbvzsIz4lXtkxkvRwC6BpikRaEPRmLQamoTEuWb3rxpYIZFqXEV1PqeIt7k1Im2Qf
         0n1g==
X-Forwarded-Encrypted: i=1; AJvYcCXBXwddKYy22rHtp9gBYk49DnBHEyIvT14YED3OT/nXeM2OUnEgXNRu/v1eJj5PbedkFHqekRDv2OAiN+Y8Dr5J@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwwKKsjRC4MwcismlWDlLxAQkMQmskt2YayUk3I3Oll8MKM8s
	nuSiTJXpKBqZMCterQArOR3e2zJg7VqYKvtaAAujLyTBx4r4IJ8C7M4VT0s7Xt5eJ8M=
X-Gm-Gg: ASbGncuqkydgouiki2Lqy6zqO0Gs7a+kf2CR5RbvsDjMnMHBcZ6QenZRQErJnvmPZCW
	Hylnej317exZHyR+fJcj01JSRR/Tb1z/3Qg2+0VoAkGJPoMntmmwFkvaY5LW1Qb6ijxrorewyPz
	dQfRmTVLJi09yOAXmfk2JL9PP0fYNS+1pF2AKn7/HAL9mDVU55bZB1c2mslaxnjm5ETCi1V1Bo+
	9oI6RALEIcOGVlQ+8Nkolw+cRvdpC80UyYcRSLt33n7JyALqEUHgtsz4SlGWsjjwe7PmtLSoN+X
	mbInIC+dmacg3uhswut3yV9MuDXJQzVYfL4g2NXxmN6GXN2FoYO+dmEx1QDpd+mGB8llvdtW8pC
	iuuzmFLliYTSCuLSGM1arIn6Yw7U08gaBQVimlKmodvhtrN1/o49yT1sm4b42BmXc64xZLsDGuN
	/52Wo3HBK2I1dXRnZT
X-Google-Smtp-Source: AGHT+IHYoQc71H56lVZWqW7Arwy9p9zIAgQJqGBPX91deQ7/Eby2G7XZsgg4V4fWlnjSx9jFdBiJOw==
X-Received: by 2002:a05:600c:6d52:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477b9ee479dmr93057155e9.10.1763983272031;
        Mon, 24 Nov 2025 03:21:12 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcbca9sm148088435e9.6.2025.11.24.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:21:11 -0800 (PST)
Message-ID: <e40ffa7e-f4d1-4a60-a63b-d48916b15dba@linaro.org>
Date: Mon, 24 Nov 2025 11:21:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: Ian Rogers <irogers@google.com>
References: <20251122093934.94971-1-irogers@google.com>
Content-Language: en-US
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251122093934.94971-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/11/2025 9:39 am, Ian Rogers wrote:
> Add an implementation of addr2line that uses libdw. Other addr2line
> implementations or, in the case of forking addr2line, slow. Add an

"are slow"?

Other that that:

Reviewed-by: James Clark <james.clark@linaro.org>

> implementation that caches the libdw information in the dso and uses
> it to find the file and line number information.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/Build     |   1 +
>   tools/perf/util/dso.c     |   2 +
>   tools/perf/util/dso.h     |  11 +++
>   tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++++++
>   tools/perf/util/libdw.h   |  60 +++++++++++++++++
>   tools/perf/util/srcline.c |   5 ++
>   6 files changed, 215 insertions(+)
>   create mode 100644 tools/perf/util/libdw.c
>   create mode 100644 tools/perf/util/libdw.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1c2a43e1dc68..2bed6274e248 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
>   perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
>   perf-util-$(CONFIG_LIBDW) += debuginfo.o
>   perf-util-$(CONFIG_LIBDW) += annotate-data.o
> +perf-util-$(CONFIG_LIBDW) += libdw.o
>   
>   perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 344e689567ee..06980844c014 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -32,6 +32,7 @@
>   #include "string2.h"
>   #include "vdso.h"
>   #include "annotate-data.h"
> +#include "libdw.h"
>   
>   static const char * const debuglink_paths[] = {
>   	"%.0s%s",
> @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
>   	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
>   	dso_cache__free(dso);
>   	dso__free_a2l(dso);
> +	dso__free_a2l_libdw(dso);
>   	dso__free_symsrc_filename(dso);
>   	nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
>   	mutex_destroy(dso__lock(dso));
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index f8ccb9816b89..4aee23775054 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
>   	const char	 *short_name;
>   	const char	 *long_name;
>   	void		 *a2l;
> +	void		 *a2l_libdw;
>   	char		 *symsrc_filename;
>   #if defined(__powerpc__)
>   	void		*dwfl;			/* DWARF debug info */
> @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, void *val)
>   	RC_CHK_ACCESS(dso)->a2l = val;
>   }
>   
> +static inline void *dso__a2l_libdw(const struct dso *dso)
> +{
> +	return RC_CHK_ACCESS(dso)->a2l_libdw;
> +}
> +
> +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> +{
> +	RC_CHK_ACCESS(dso)->a2l_libdw = val;
> +}
> +
>   static inline unsigned int dso__a2l_fails(const struct dso *dso)
>   {
>   	return RC_CHK_ACCESS(dso)->a2l_fails;
> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> new file mode 100644
> index 000000000000..c4331fa8e1a3
> --- /dev/null
> +++ b/tools/perf/util/libdw.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "dso.h"
> +#include "libdw.h"
> +#include "srcline.h"
> +#include "symbol.h"
> +#include "dwarf-aux.h"
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <elfutils/libdwfl.h>
> +
> +void dso__free_a2l_libdw(struct dso *dso)
> +{
> +	Dwfl *dwfl = dso__a2l_libdw(dso);
> +
> +	if (dwfl) {
> +		dwfl_end(dwfl);
> +		dso__set_a2l_libdw(dso, NULL);
> +	}
> +}
> +
> +int libdw__addr2line(const char *dso_name, u64 addr,
> +		     char **file, unsigned int *line_nr,
> +		     struct dso *dso, bool unwind_inlines,
> +		     struct inline_node *node, struct symbol *sym)
> +{
> +	static const Dwfl_Callbacks offline_callbacks = {
> +		.find_debuginfo = dwfl_standard_find_debuginfo,
> +		.section_address = dwfl_offline_section_address,
> +		.find_elf = dwfl_build_id_find_elf,
> +	};
> +	Dwfl *dwfl = dso__a2l_libdw(dso);
> +	Dwfl_Module *mod;
> +	Dwfl_Line *dwline;
> +	Dwarf_Addr bias;
> +	const char *src;
> +	int lineno;
> +
> +	if (!dwfl) {
> +		/*
> +		 * Initialize Dwfl session.
> +		 * We need to open the DSO file to report it to libdw.
> +		 */
> +		int fd;
> +
> +		fd = open(dso_name, O_RDONLY);
> +		if (fd < 0)
> +			return 0;
> +
> +		dwfl = dwfl_begin(&offline_callbacks);
> +		if (!dwfl) {
> +			close(fd);
> +			return 0;
> +		}
> +
> +		/*
> +		 * If the report is successful, the file descriptor fd is consumed
> +		 * and closed by the Dwfl. If not, it is not closed.
> +		 */
> +		mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
> +		if (!mod) {
> +			dwfl_end(dwfl);
> +			close(fd);
> +			return 0;
> +		}
> +
> +		dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
> +		dso__set_a2l_libdw(dso, dwfl);
> +	} else {
> +		/* Dwfl session already initialized, get module for address. */
> +		mod = dwfl_addrmodule(dwfl, addr);
> +	}
> +
> +	if (!mod)
> +		return 0;
> +
> +	/* Find source line information for the address. */
> +	dwline = dwfl_module_getsrc(mod, addr);
> +	if (!dwline)
> +		return 0;
> +
> +	/* Get line information. */
> +	src = dwfl_lineinfo(dwline, &addr, &lineno, /*col=*/NULL, /*mtime=*/NULL, /*length=*/NULL);
> +
> +	if (file)
> +		*file = src ? strdup(src) : NULL;
> +	if (line_nr)
> +		*line_nr = lineno;
> +
> +	/* Optionally unwind inline function call chain. */
> +	if (unwind_inlines && node && src) {
> +		Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr, &bias);
> +		Dwarf_Die *scopes = NULL;
> +		int nscopes;
> +
> +		if (!cudie)
> +			return 1;
> +
> +		nscopes = die_get_scopes(cudie, addr, &scopes);
> +		if (nscopes > 0) {
> +			int i;
> +			const char *call_file = src;
> +			unsigned int call_line = lineno;
> +
> +			for (i = 0; i < nscopes; i++) {
> +				Dwarf_Die *die = &scopes[i];
> +				struct symbol *inline_sym;
> +				char *srcline = NULL;
> +				int tag = dwarf_tag(die);
> +
> +				/* We are interested in inlined subroutines. */
> +				if (tag != DW_TAG_inlined_subroutine &&
> +				    tag != DW_TAG_subprogram)
> +					continue;
> +
> +				inline_sym = new_inline_sym(dso, sym, dwarf_diename(die));
> +
> +				if (call_file)
> +					srcline = srcline_from_fileline(call_file, call_line);
> +
> +				inline_list__append(inline_sym, srcline, node);
> +
> +				/* Update call site for next level. */
> +				if (tag == DW_TAG_inlined_subroutine) {
> +					call_file = die_get_call_file(die);
> +					call_line = die_get_call_lineno(die);
> +				} else {
> +					/* Reached the root subprogram. */
> +					break;
> +				}
> +			}
> +			free(scopes);
> +		}
> +	}
> +
> +	return 1;
> +}
> diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> new file mode 100644
> index 000000000000..0f8d7b4a11a5
> --- /dev/null
> +++ b/tools/perf/util/libdw.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef PERF_LIBDW_H
> +#define PERF_LIBDW_H
> +
> +#include <linux/types.h>
> +
> +struct dso;
> +struct inline_node;
> +struct symbol;
> +
> +#ifdef HAVE_LIBDW_SUPPORT
> +/*
> + * libdw__addr2line - Convert address to source location using libdw
> + * @dso_name: Name of the DSO
> + * @addr: Address to resolve
> + * @file: Pointer to return filename (caller must free)
> + * @line_nr: Pointer to return line number
> + * @dso: The dso struct
> + * @unwind_inlines: Whether to unwind inline function calls
> + * @node: Inline node list to append to
> + * @sym: The symbol associated with the address
> + *
> + * This function initializes a Dwfl context for the DSO if not already present,
> + * finds the source line information for the given address, and optionally
> + * resolves inline function call chains.
> + *
> + * Returns 1 on success (found), 0 on failure (not found).
> + */
> +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> +		     unsigned int *line_nr, struct dso *dso,
> +		     bool unwind_inlines, struct inline_node *node,
> +		     struct symbol *sym);
> +
> +/*
> + * dso__free_a2l_libdw - Free libdw resources associated with the DSO
> + * @dso: The dso to free resources for
> + *
> + * This function cleans up the Dwfl context used for addr2line lookups.
> + */
> +void dso__free_a2l_libdw(struct dso *dso);
> +
> +#else /* HAVE_LIBDW_SUPPORT */
> +
> +static inline int libdw__addr2line(const char *dso_name __maybe_unused,
> +				   u64 addr __maybe_unused, char **file __maybe_unused,
> +				   unsigned int *line_nr __maybe_unused,
> +				   struct dso *dso __maybe_unused,
> +				   bool unwind_inlines __maybe_unused,
> +				   struct inline_node *node __maybe_unused,
> +				   struct symbol *sym __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
> +{
> +}
> +#endif /* HAVE_LIBDW_SUPPORT */
> +
> +#endif /* PERF_LIBDW_H */
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 27c0966611ab..4b456c4d4138 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -6,6 +6,7 @@
>   #include "libbfd.h"
>   #include "llvm.h"
>   #include "symbol.h"
> +#include "libdw.h"
>   
>   #include <inttypes.h>
>   #include <string.h>
> @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
>   {
>   	int ret;
>   
> +	ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
> +	if (ret > 0)
> +		return ret;
> +
>   	ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
>   	if (ret > 0)
>   		return ret;

