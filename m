Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F51DDA0E;
	Wed, 23 Jul 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286651; cv=none; b=fpDBCAJCqiQmFpQwFOcgzJ6QqAVycdWK8vJMawbxyahw/E/N33ZkQ97T4q858Cjr3HSYBDo3ol0zzSZI8k2GdQ94FqG2GFpO2rMly5DKwAo2Cr5ZNzdJqEv0HabDmx/fauPc0JKjQHKj0P3mwxuoyzGaFlEQYxOAcNrptH2tWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286651; c=relaxed/simple;
	bh=aT3dePDX5kED8uFvltRVKttJXB3VIAVrPdKJ+VRQTNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlIebgfIarTGwKle7lQwcYBQgvpFNTI3ahKYsbjmftFbgOldPPgjj86TOfLBETQqdOzIPh+5tsG5cAmS7PaR7l3hJi5jY/VAhLMVOeDKPCtl+Ma7wiDRG9IxT8ezApQcynjJPSsJwSKGvdSm3dCQroNohlH6bR3x7hcXcflqfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fysc24rd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fysc24rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A84C4CEE7;
	Wed, 23 Jul 2025 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286651;
	bh=aT3dePDX5kED8uFvltRVKttJXB3VIAVrPdKJ+VRQTNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fysc24rdUOqKOp/UVWpz3zEueTW8ts9yDqaULY8g9Q9M+ffCHUU5UWt1btWHxKMF6
	 YzT1AmR6Zo6UuVyIFwp2YvRWfybNMDn5QmE2oXIaD0IYp4pTg3Q3hCBZd1gxYQXXGE
	 ik0nL1LobZduP8Y5aDvqi65wuOKM03TdNVbHwWJ9B3LOU9mjKhAclIDRrmCCoelFf5
	 Zz1tEhbQeCoEPwbvnKoQ5u43J6SlQY/i4IdC0Txm6juQUMVXLoDmDfyGpcYQqqt//n
	 SI7HQLvuOrlN1hzRgP7Sp+AlB5jrxzMO+QaoZc+SwdmfSUznycHjAZk2NHvK0it2qq
	 sf+ombISl5O4Q==
Date: Wed, 23 Jul 2025 13:04:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 5/8] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aIEH99tRH8EoqBA5@x1>
References: <20250716050054.14130-1-namhyung@kernel.org>
 <20250716050054.14130-6-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716050054.14130-6-namhyung@kernel.org>

On Tue, Jul 15, 2025 at 10:00:51PM -0700, Namhyung Kim wrote:
> Until now, the --code-with-type option is available only on stdio.
> But it was an artifical limitation because of an implemention issue.
> 
> Implement the same logic in annotation_line__write() for stdio2/TUI.
> Make disasm_line__write() return the number of printed characters so
> that it can skip unnecessary operations when the screen is full.
> 
> Remove the limitation and update the man page.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  1 -
>  tools/perf/builtin-annotate.c              |  5 --
>  tools/perf/ui/browsers/annotate.c          |  6 +++
>  tools/perf/util/annotate.c                 | 61 +++++++++++++++++++---
>  4 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index 46090c5b42b4762f..547f1a2680185e3c 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -170,7 +170,6 @@ include::itrace.txt[]
>  
>  --code-with-type::
>  	Show data type info in code annotation (for memory instructions only).
> -	Currently it only works with --stdio option.
>  
>  
>  SEE ALSO
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 9833c2c82a2fee46..6debd725392db4a4 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
>  		symbol_conf.annotate_data_sample = true;
>  	} else if (annotate_opts.code_with_type) {
>  		symbol_conf.annotate_data_member = true;
> -
> -		if (!annotate.use_stdio) {
> -			pr_err("--code-with-type only works with --stdio.\n");
> -			goto out_delete;
> -		}
>  	}
>  
>  	setup_browser(true);
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 23bea5b165774ae7..cdee1969f3131a7c 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -4,6 +4,7 @@
>  #include "../ui.h"
>  #include "../../util/annotate.h"
>  #include "../../util/debug.h"
> +#include "../../util/debuginfo.h"
>  #include "../../util/dso.h"
>  #include "../../util/hist.h"
>  #include "../../util/sort.h"
> @@ -1101,6 +1102,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  
>  	ui_helpline__push("Press ESC to exit");
>  
> +	if (annotate_opts.code_with_type)
> +		browser.dbg = debuginfo__new(dso__long_name(dso));

Some error checking here to tell the user if debuginfo isn't available
and hints on how to get it in place?

> +
>  	browser.b.width = notes->src->widths.max_line_len;
>  	browser.b.nr_entries = notes->src->nr_entries;
>  	browser.b.entries = &notes->src->source;
> @@ -1111,6 +1115,8 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  
>  	ret = annotate_browser__run(&browser, evsel, hbt);
>  
> +	if (annotate_opts.code_with_type)
> +		debuginfo__delete(browser.dbg);

This is a local variable, so no need to zero browser.dbg after deleting
it, ok.

>  	if (not_annotated && !notes->src->tried_source)
>  		annotated_source__purge(notes->src);
>  
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index d69e406c1bc289cd..06ddc7a9f58722a4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
>  	};
>  	struct annotation_line *al;
>  
> +	if (annotate_opts.code_with_type) {
> +		evsel__get_arch(apd->evsel, &apd->arch);
> +		apd->dbg = debuginfo__new(dso__long_name(map__dso(apd->he->ms.map)));
> +	}
> +
>  	list_for_each_entry(al, &notes->src->source, node) {
>  		if (annotation_line__filter(al))
>  			continue;
> @@ -1370,6 +1375,9 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
>  		wops.first_line = false;
>  	}
>  
> +	if (annotate_opts.code_with_type)
> +		debuginfo__delete(apd->dbg);

But here it would be good to nullify apd->dbg?

> +
>  	return 0;
>  }
>  
> @@ -1743,7 +1751,7 @@ static double annotation_line__max_percent(struct annotation_line *al,
>  	return percent_max;
>  }
>  
> -static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> +static int disasm_line__write(struct disasm_line *dl, struct annotation *notes,
>  			       void *obj, char *bf, size_t size,
>  			       void (*obj__printf)(void *obj, const char *fmt, ...),
>  			       void (*obj__write_graph)(void *obj, int graph))
> @@ -1771,8 +1779,8 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
>  		obj__printf(obj, "  ");
>  	}
>  
> -	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
> -			       notes->src->widths.max_ins_name);
> +	return disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
> +				      notes->src->widths.max_ins_name);
>  }
>  
>  static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
> @@ -2116,11 +2124,52 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
>  
>  		width -= printed + 3;
>  
> -		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
> +		printed = disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf),
> +					     obj__printf, obj__write_graph);
> +
> +		obj__printf(obj, "%s", bf);
> +		width -= printed;
> +
> +		if (annotate_opts.code_with_type && apd->dbg) {
> +			struct annotated_data_type *data_type;
> +			int offset = 0;
> +
> +			data_type = __hist_entry__get_data_type(apd->he, apd->arch,
> +								apd->dbg,
> +								disasm_line(al),
> +								&offset);
> +			if (data_type && data_type != NO_TYPE) {
> +				char member[256];
> +
> +				printed = scnprintf(bf, sizeof(bf),
> +						    "\t\t# data-type: %s",
> +						    data_type->self.type_name);
>  
> -		obj__printf(obj, "%-*s", width, bf);
> +				if (data_type != &stackop_type &&
> +				    data_type != &canary_type &&
> +				    sizeof(bf) > (size_t)printed) {
> +					printed += scnprintf(bf + printed,
> +							     sizeof(bf) - printed,
> +							     " +%#x", offset);
> +				}
> +
> +				if (annotated_data_type__get_member_name(data_type,
> +									 member,
> +									 sizeof(member),
> +									 offset) &&
> +				    sizeof(bf) > (size_t)printed) {
> +					printed += scnprintf(bf + printed,
> +							     sizeof(bf) - printed,
> +							     " (%s)", member);
> +				}
>  
> -		(void)apd;
> +				obj__printf(obj, "%-*s", width, bf);
> +			} else {
> +				obj__printf(obj, "%-*s", width, " ");
> +			}
> +		} else {
> +			obj__printf(obj, "%-*s", width, " ");
> +		}
>  	}
>  
>  }
> -- 
> 2.50.0
> 
