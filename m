From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf, tools, script: Allow adding and removing fields
Date: Thu, 8 Jun 2017 11:34:22 -0300
Message-ID: <20170608143422.GI6949@kernel.org>
References: <20170602154810.15875-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdFHOe1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2017 10:34:27 -0400
Content-Disposition: inline
In-Reply-To: <20170602154810.15875-1-andi@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Em Fri, Jun 02, 2017 at 08:48:10AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> With perf script it is common that we just want to add or remove a field.
> Currently this requires figuring out the long list of default fields and
> specifying them first, and then adding/removing the new field.
> 
> This patch adds a new + - syntax to merely add or remove fields,
> that allows more succint and clearer command lines
> 
> For example to remove the comm field from PMU samples:
> 
> Previously
> 
> perf script -F tid,cpu,time,event,sym,ip,dso,period
> 	    0 [000] 504345.383126:          1 cycles:  ffffffff90060c66 native_write_msr ([kernel.kallsyms])
> 
> with the new syntax
> 
> perf script -F -comm
> 	    0 [000] 504345.383126:          1 cycles:  ffffffff90060c66 native_write_msr ([kernel.kallsyms])

Humm, its a nice feature, but the output used as an example doesn't show
any diff, cut'n'paste error?

Anyway, I tested it and will update that example with this:

---------------

  # perf record -a usleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.748 MB perf.data (14 samples) ]

Without a explicit field list specified via -F, defaults to:

  # perf script | head -2
              perf  6338 [000] 18467.058607:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
           swapper     0 [001] 18467.058617:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)

Which is equivalent to:

  # perf script -F comm,tid,cpu,time,period,event,ip,sym,dso | head -2
              perf  6338 [000] 18467.058607:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
           swapper     0 [001] 18467.058617:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
  #

So if we want to remove the comm, as in your original example, we would have to 
figure out the default field list and remove ' comm' from it:

  # perf script -F tid,cpu,time,period,event,ip,sym,dso | head -2
   6338 [000] 18467.058607:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
      0 [001] 18467.058617:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
  # 

With your patch this becomes simpler, one can remove fields by prefixing them
with '-':

  # perf script -F -comm | head -2
  6338 [000] 18467.058607:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
     0 [001] 18467.058617:          1 cycles:  ffffffff89060c36 native_write_msr (/lib/modules/4.11.0-rc8+/build/vmlinux)
  # 

-------------------

BTW, the '+' syntax is present in 'perf report -F', but we lack handling
'-', and it works for the whole list, i.e. it is not possible to add
some fields and remove others, would be good to look at both and
consolidate at some time, using your syntax, which is more powerful.

- Arnaldo
 
> The new syntax cannot be mixed with normal overriding.
> 
> v2: Fix example in description. Use tid vs pid. No functional
> changes.
> v3: Don't skip initialization when user specified explicit type.
> v4: Rebase. Remove empty line.
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-script.txt |  8 +++++++
>  tools/perf/builtin-script.c              | 37 +++++++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index cb0eda3925e6..4547120c6ad3 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -130,6 +130,14 @@ OPTIONS
>  	i.e., the specified fields apply to all event types if the type string
>  	is not given.
>  
> +	In addition to overriding fields, it is also possible to add or remove
> +	fields from the defaults. For example
> +
> +		-F -cpu,+insn
> +
> +	removes the cpu field and adds the insn field. Adding/removing fields
> +	cannot be mixed with normal overriding.
> +
>  	The arguments are processed in the order received. A later usage can
>  	reset a prior request. e.g.:
>  
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d05aec491cff..85c83cc3e994 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1727,6 +1727,7 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  	int rc = 0;
>  	char *str = strdup(arg);
>  	int type = -1;
> +	enum { DEFAULT, SET, ADD, REMOVE } change = DEFAULT;
>  
>  	if (!str)
>  		return -ENOMEM;
> @@ -1772,6 +1773,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  			goto out;
>  		}
>  
> +		/* Don't override defaults for +- */
> +		if (strchr(str, '+') || strchr(str, '-'))
> +			goto parse;
> +
>  		if (output_set_by_user())
>  			pr_warning("Overriding previous field request for all events.\n");
>  
> @@ -1782,13 +1787,30 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  		}
>  	}
>  
> +parse:
>  	for (tok = strtok_r(tok, ",", &strtok_saveptr); tok; tok = strtok_r(NULL, ",", &strtok_saveptr)) {
> +		if (*tok == '+') {
> +			if (change == SET)
> +				goto out_badmix;
> +			change = ADD;
> +			tok++;
> +		} else if (*tok == '-') {
> +			if (change == SET)
> +				goto out_badmix;
> +			change = REMOVE;
> +			tok++;
> +		} else {
> +			if (change != SET && change != DEFAULT)
> +				goto out_badmix;
> +			change = SET;
> +		}
> +
>  		for (i = 0; i < imax; ++i) {
>  			if (strcmp(tok, all_output_options[i].str) == 0)
>  				break;
>  		}
>  		if (i == imax && strcmp(tok, "flags") == 0) {
> -			print_flags = true;
> +			print_flags = change == REMOVE ? false : true;
>  			continue;
>  		}
>  		if (i == imax) {
> @@ -1805,8 +1827,12 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  				if (output[j].invalid_fields & all_output_options[i].field) {
>  					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
>  						   all_output_options[i].str, event_type(j));
> -				} else
> -					output[j].fields |= all_output_options[i].field;
> +				} else {
> +					if (change == REMOVE)
> +						output[j].fields &= ~all_output_options[i].field;
> +					else
> +						output[j].fields |= all_output_options[i].field;
> +				}
>  			}
>  		} else {
>  			if (output[type].invalid_fields & all_output_options[i].field) {
> @@ -1826,7 +1852,11 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  				 "Events will not be displayed.\n", event_type(type));
>  		}
>  	}
> +	goto out;
>  
> +out_badmix:
> +	fprintf(stderr, "Cannot mix +-field with overridden fields\n");
> +	rc = -EINVAL;
>  out:
>  	free(str);
>  	return rc;
> @@ -2444,6 +2474,7 @@ int cmd_script(int argc, const char **argv)
>  		     symbol__config_symfs),
>  	OPT_CALLBACK('F', "fields", NULL, "str",
>  		     "comma separated output fields prepend with 'type:'. "
> +		     "+field to add and -field to remove."
>  		     "Valid types: hw,sw,trace,raw. "
>  		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
>  		     "addr,symoff,period,iregs,brstack,brstacksym,flags,"
> -- 
> 2.9.4
