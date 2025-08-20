Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063571BC4E;
	Wed, 20 Aug 2025 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716094; cv=none; b=YhQv+wEUYTwr9899VbOVsgydLxx4k3J1YlTeSoHeUnux/GW/RJs7vjz3dN5pGWnxRF6AWr4kD11g1ZyhKWQ4QkOczktJa7tOWBXhxIzyNv55Ebc6eU7zGbWhj0TIFrjn6RpCy5DsX91v0tRozLykx1hsV/Nv717FAl84q1xn0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716094; c=relaxed/simple;
	bh=wl3iwnE/eHNLAeTrFaFOB88YHL+idesNYrQ128g2vAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs12FzvkKDY29aYJoWdEKY7y8BJI0tO5LhzeIJUumAnTSooxqn0h87Q9Z0HHg89dS4OM357m5IlXpS7pKUaTEQf4vzxZ28JsHgamAfMLbLyl/mjYrK4JU1fvzY5O9g2tBuDbP9jYFyASodqy2RWGyrJ2pIVtab19OCJgK/i31d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/fcumCW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/fcumCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D62C4CEE7;
	Wed, 20 Aug 2025 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716093;
	bh=wl3iwnE/eHNLAeTrFaFOB88YHL+idesNYrQ128g2vAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/fcumCWFk3YE20q0c0XUMa3uyW7eJnFBXpIC73zq3pDSBjePAom1k6EOIjHPahqg
	 ibrre3rBY/3ytHNnQyAGGVQt0KdLxYK9yqZWYJse9i0m/ccd64fPGnSppknUArXrs8
	 pMeY9wp7qaHuuMCR9cmB9wP8pEQWOWkVcDzZWpkGfMClmEzYI77L0UqJlaG1l9EQlt
	 wKc1Nu2oFn8PCcSNkRZD+dEiTLflHcVzEsigl2LJrZuPw5I+OBblu0JycrcZZdIARO
	 Tc3dTEuTnUKDxszCoWZjhWIbl7RBsSDSIdZqcd2VLTVv3rHfbUnbG5ORLV0UcaOD9D
	 gN20dAh0zsOjg==
Date: Wed, 20 Aug 2025 15:54:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/12] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aKYZ-dhGJvWoIres@x1>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <20250816031635.25318-8-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250816031635.25318-8-namhyung@kernel.org>

On Fri, Aug 15, 2025 at 08:16:30PM -0700, Namhyung Kim wrote:
> Until now, the --code-with-type option is available only on stdio.
> But it was an artifical limitation because of an implemention issue.
> 
> Implement the same logic in annotation_line__write() for stdio2/TUI
> and remove the limitation and update the man page.

Samples: 54K of event 'cycles:P', 4000 Hz, Event count (approx.): 25749717559
poll_idle  /usr/lib/debug/lib/modules/6.15.9-201.fc42.x86_64/vmlinux [Percent: local period]
Percent │      mov     %rdi,%rbx                                                                                                                                        ▒
        │    → call    local_clock_noinstr              # data-type: (stack operation)                                                                                  ▒
        │      andb    $0xfb,(%rbx)             # data-type: struct cpuidle_device +0 (registered:1)                                                                    ▒
        │      mov     %rax,%rbp                                                                                                                                        ▒
        │    → call    *0x1342a22(%rip)        # ffffffff8384f778 <pv_ops+0xf8>         # data-type: (stack operation)                                                  ▒
        │      mov     current_task,%r14                # data-type: struct task_struct* +0                                                                             ▒
        │      lock    orb     $0x20,0x2(%r14)          # data-type: struct task_struct +0x2 (thread_info.flags)                                                        ▒
        │      mov     (%r14),%rax              # data-type: struct task_struct +0 (thread_info.flags)                                                                  ▒
        │      test    $0x8,%al                                                                                                                                         ▒
        │    ↓ jne     6d                                                                                                                                               ▒
        │      mov     %r12,%rdi                                                                                                                                        ▒
        │      mov     %rbx,%rsi                                                                                                                                        ▒
        │    → call    cpuidle_poll_time                # data-type: (stack operation)                                                                                  ▒
        │      mov     %rax,%r12                                                                                                                                        ▒
        │49:   mov     $0xc9,%eax                                                                                                                                       ▒
   0.75 │4e:   mov     (%r14),%rdx              # data-type: struct task_struct +0 (thread_info.flags)                                                                  ▒
   0.42 │      and     $0x8,%edx                                                                                                                                        ▒
        │    ↓ jne     6d                                                                                                                                               ▒
  97.81 │      pause                                                                                                                                                    ▒
   0.70 │      sub     $0x1,%eax                                                                                                                                        ▒
   0.04 │    ↑ jne     4e                                                                                                                                               ▒
   0.14 │    → call    local_clock_noinstr              # data-type: (stack operation)                                                                                  ▒
   0.01 │      sub     %rbp,%rax                                                                                                                                        ▒
   0.05 │      cmp     %rax,%r12                                                                                                                                        ▒
        │    ↑ jae     49                                                                                                                                               ▒
        │      orb     $0x4,(%rbx)              # data-type: struct cpuidle_device +0 (registered:1)                                                                    ▒
        │6d: → call    *0x13429cd(%rip)        # ffffffff8384f770 <pv_ops+0xf0>         # data-type: (stack operation)                                                  ▒
        │      lock    andb    $0xdf,0x2(%r14)          # data-type: struct task_struct +0x2 (thread_info.flags)                                                        ▒
        │      mov     (%r14),%rax              # data-type: struct task_struct +0 (thread_info.flags) 


Some suggestions:

Align the # data-type: annotations.

Remove the "data-type: " part, just uses space and it should be obvious
what that type refers to.

At some point, if we can do it super cheaply, maybe BTF, do this by
default.

The 'T' hotkey looks great, but perhaps we should have more visibility
for it? Like what I suggested in:

https://lore.kernel.org/all/aBvx-J-ISifmw0NS@google.com/T/#u

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  1 -
>  tools/perf/builtin-annotate.c              |  5 ---
>  tools/perf/ui/browsers/annotate.c          |  6 +++
>  tools/perf/util/annotate.c                 | 47 ++++++++++++++++++++--
>  4 files changed, 50 insertions(+), 9 deletions(-)
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
> index 5d57d2913f3d9a33..646f43b0f7c4c9b0 100644
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
> index 3e8b111e3f12b030..e5b35336f0d33d7e 100644
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
> @@ -1119,6 +1120,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  
>  	ui_helpline__push("Press ESC to exit");
>  
> +	if (annotate_opts.code_with_type)
> +		browser.dbg = debuginfo__new(dso__long_name(dso));
> +
>  	browser.b.width = notes->src->widths.max_line_len;
>  	browser.b.nr_entries = notes->src->nr_entries;
>  	browser.b.entries = &notes->src->source;
> @@ -1129,6 +1133,8 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  
>  	ret = annotate_browser__run(&browser, evsel, hbt);
>  
> +	if (annotate_opts.code_with_type)
> +		debuginfo__delete(browser.dbg);
>  	if (not_annotated && !notes->src->tried_source)
>  		annotated_source__purge(notes->src);
>  
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 698bc4f559e83043..99e976d254493de2 100644
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
> +
>  	return 0;
>  }
>  
> @@ -1935,6 +1943,36 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
>  	return -ENOMEM;
>  }
>  
> +static int disasm_line__snprint_type_info(struct disasm_line *dl,
> +					  char *buf, int len,
> +					  struct annotation_print_data *apd)
> +{
> +	struct annotated_data_type *data_type;
> +	char member[256];
> +	int offset = 0;
> +	int printed;
> +
> +	scnprintf(buf, len, " ");
> +
> +	if (!annotate_opts.code_with_type || apd->dbg == NULL)
> +		return 1;
> +
> +	data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
> +	if (data_type == NULL || data_type == NO_TYPE)
> +		return 1;
> +
> +	printed = scnprintf(buf, len, "\t\t# data-type: %s", data_type->self.type_name);
> +
> +	if (data_type != &stackop_type && data_type != &canary_type && len > printed)
> +		printed += scnprintf(buf + printed, len - printed, " +%#x", offset);
> +
> +	if (annotated_data_type__get_member_name(data_type, member, sizeof(member), offset) &&
> +	    len > printed) {
> +		printed += scnprintf(buf + printed, len - printed, " (%s)", member);
> +	}
> +	return printed;
> +}
> +
>  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
>  			    const struct annotation_write_ops *wops,
>  			    struct annotation_print_data *apd)
> @@ -2118,11 +2156,14 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
>  
>  		width -= printed;
>  
> -		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
> +		printed = disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf),
> +					     obj__printf, obj__write_graph);
>  
> -		obj__printf(obj, "%-*s", width, bf);
> +		obj__printf(obj, "%s", bf);
> +		width -= printed;
>  
> -		(void)apd;
> +		disasm_line__snprint_type_info(disasm_line(al), bf, sizeof(bf), apd);
> +		obj__printf(obj, "%-*s", width, bf);
>  	}
>  
>  }
> -- 
> 2.50.1
