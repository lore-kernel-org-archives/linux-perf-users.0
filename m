Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E5C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393E4610A6
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhIMUHl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243281AbhIMUHQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Sep 2021 16:07:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EB97610A6;
        Mon, 13 Sep 2021 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631563560;
        bh=H1Ln/UIOUi23uagnvlUj6K6ng4qZiD0iTlfs38td7b0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRqFmJK8t/8cXfyW5IL0BKSthn8HjoI26IHLpJAglSpoMe0I1ondJe4h2MpBk1m8p
         bmwD82lDr3Lu0B0NxAKaApPwbubEC9EpG4Hg1L0+lTNmlX590t2a+2hPlKS5ezqazY
         upeyPBq5HDYO/u1Dzx0lokFm28zQXi9GeNR3NXPIa1ppXDpzCC9Hdcvl9+yDuOGd+p
         ogHiWml3NYSVhZJOBZMw8NVCFm3HdntbjaTfydnYHnDVKfSDadZE26etGn/I2ZpZPX
         lDmT292VmRyl7KwGS4lnzcRhb4clcJaWJvKn9q/inqKrbRacqKdt3ZqXnmhb1wuFa2
         1JkfrGjkHsl4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19BB54038F; Mon, 13 Sep 2021 17:05:57 -0300 (-03)
Date:   Mon, 13 Sep 2021 17:05:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] tools/perf: Use long-running addr2line per dso
Message-ID: <YT+vJQFfSTE3EExF@kernel.org>
References: <20210910102307.2055484-1-tonyg@leastfixedpoint.com>
 <20210910225557.21651-1-tonyg@leastfixedpoint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910225557.21651-1-tonyg@leastfixedpoint.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Sep 11, 2021 at 12:55:57AM +0200, Tony Garnock-Jones escreveu:
> Invoking addr2line in a separate subprocess, one for each required
> lookup, takes a terribly long time. This patch introduces a
> long-running addr2line process for each dso, *DRAMATICALLY* speeding
> up runs of perf. What used to take tens of minutes now takes tens of
> seconds.
> 
> Debian bug report about this issue:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911815

Some minor issues, mostly to make the code more compact.

Thanks for working on this!

- Arnaldo
 
> Signed-off-by: Tony Garnock-Jones <tonyg@leastfixedpoint.com>
> 
> ---
> Changes since v2:
>  - remove redundant initializations to 0 and NULL
>  - use terminology "record" instead of "stanza" for input from addr2line
> 
> Changes since v1:
>  - use "subcmd/run-command.h" machinery instead of socketpair/fork/exec directly
> 
> 
>  tools/perf/util/srcline.c | 376 ++++++++++++++++++++++++++++----------
>  1 file changed, 276 insertions(+), 100 deletions(-)
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 5b7d6c16d33f..3e591bd0b7c4 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <inttypes.h>
> +#include <signal.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/types.h>
>  
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> @@ -15,6 +17,7 @@
>  #include "srcline.h"
>  #include "string2.h"
>  #include "symbol.h"
> +#include "subcmd/run-command.h"
>  
>  bool srcline_full_filename;
>  
> @@ -119,6 +122,8 @@ static struct symbol *new_inline_sym(struct dso *dso,
>  	return inline_sym;
>  }
>  
> +#define MAX_INLINE_NEST 1024
> +
>  #ifdef HAVE_LIBBFD_SUPPORT
>  
>  /*
> @@ -273,8 +278,6 @@ static void addr2line_cleanup(struct a2l_data *a2l)
>  	free(a2l);
>  }
>  
> -#define MAX_INLINE_NEST 1024
> -
>  static int inline_list__append_dso_a2l(struct dso *dso,
>  				       struct inline_node *node,
>  				       struct symbol *sym)
> @@ -361,26 +364,14 @@ void dso__free_a2l(struct dso *dso)
>  	dso->a2l = NULL;
>  }
>  
> -static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
> -					struct dso *dso, struct symbol *sym)
> -{
> -	struct inline_node *node;
> -
> -	node = zalloc(sizeof(*node));
> -	if (node == NULL) {
> -		perror("not enough memory for the inline node");
> -		return NULL;
> -	}
> -
> -	INIT_LIST_HEAD(&node->val);
> -	node->addr = addr;
> -
> -	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
> -	return node;
> -}
> -
>  #else /* HAVE_LIBBFD_SUPPORT */
>  
> +struct a2l_subprocess {
> +	struct child_process addr2line;
> +	FILE *to_child;
> +	FILE *from_child;
> +};
> +
>  static int filename_split(char *filename, unsigned int *line_nr)
>  {
>  	char *sep;
> @@ -402,114 +393,299 @@ static int filename_split(char *filename, unsigned int *line_nr)
>  	return 0;
>  }
>  
> +static void addr2line_subprocess_cleanup(struct a2l_subprocess *a2l)
> +{
> +	if (a2l->addr2line.pid != -1) {
> +		kill(a2l->addr2line.pid, SIGKILL);
> +		finish_command(&a2l->addr2line); /* ignore result, we don't care */
> +		a2l->addr2line.pid = -1;
> +	}
> +
> +	if (a2l->to_child != NULL) {
> +		fclose(a2l->to_child);
> +		a2l->to_child = NULL;
> +	}
> +
> +	if (a2l->from_child != NULL) {
> +		fclose(a2l->from_child);
> +		a2l->from_child = NULL;
> +	}
> +
> +	free(a2l);
> +}
> +
> +static struct a2l_subprocess *addr2line_subprocess_init(const char *path)
> +{
> +	const char *argv[] = { "addr2line", "-e", path, "-i", "-f", NULL };
> +	struct a2l_subprocess *a2l = NULL;

Why initialize it to NULL only to a few lines down initialize it to
zalloc()?

Please combine both lines, i.e.:

	struct a2l_subprocess *a2l = zalloc(sizeof(*a2l));

> +	int start_command_status = 0;
> +
> +	a2l = zalloc(sizeof(*a2l));
> +	if (a2l == NULL)
> +		goto out;
> +
> +	a2l->to_child = NULL;
> +	a2l->from_child = NULL;
> +
> +	a2l->addr2line.pid = -1;
> +	a2l->addr2line.in = -1;
> +	a2l->addr2line.out = -1;
> +	a2l->addr2line.no_stderr = 1;
> +
> +	a2l->addr2line.argv = argv;
> +	start_command_status = start_command(&a2l->addr2line);
> +	a2l->addr2line.argv = NULL; /* it's not used after start_command; avoid dangling pointers */
> +
> +	if (start_command_status != 0) {
> +		pr_warning("could not start addr2line for %s: start_command return code %d\n",
> +			   path,
> +			   start_command_status);
> +		goto out;
> +	}
> +
> +	a2l->to_child = fdopen(a2l->addr2line.in, "w");
> +	if (a2l->to_child == NULL) {
> +		pr_warning("could not open write-stream to addr2line of %s\n", path);
> +		goto out;
> +	}
> +
> +	a2l->from_child = fdopen(a2l->addr2line.out, "r");
> +	if (a2l->from_child == NULL) {
> +		pr_warning("could not open read-stream from addr2line of %s\n", path);
> +		goto out;
> +	}
> +
> +	return a2l;
> +
> +out:
> +	if (a2l)
> +		addr2line_subprocess_cleanup(a2l);
> +
> +	return NULL;
> +}
> +
> +static int read_addr2line_record(struct a2l_subprocess *a2l,
> +				 char **function,
> +				 char **filename,
> +				 unsigned int *line_nr)
> +{
> +	/*
> +	 * Returns:
> +	 * -1 ==> error
> +	 * 0 ==> sentinel (or other ill-formed) record read
> +	 * 1 ==> a genuine record read
> +	 */
> +	char *line = NULL;
> +	size_t line_len = 0;
> +	unsigned int dummy_line_nr = 0;
> +	int ret = -1;
> +
> +	if (function != NULL && *function != NULL) {
> +		free(*function);
> +		*function = NULL;

We have zfree() for that, i.e. just call: zfree(function);

> +	}
> +
> +	if (filename != NULL && *filename != NULL) {
> +		free(*filename);
> +		*filename = NULL;

Ditto

> +	}
> +
> +	if (line_nr != NULL)
> +		*line_nr = 0;
> +
> +	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
> +		goto error;
> +
> +	if (function != NULL)
> +		*function = strdup(strim(line));
> +
> +	free(line);
> +	line = NULL;

Ditto

> +	line_len = 0;
> +
> +	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
> +		goto error;
> +
> +	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0) {
> +		ret = 0;
> +		goto error;
> +	}
> +
> +	if (filename != NULL)
> +		*filename = strdup(line);
> +
> +	free(line);
> +	line = NULL;

Ditto

> +	line_len = 0;
> +
> +	return 1;
> +
> +error:
> +	if (line != NULL)
> +		free(line);

free accepts NULL so just do:

	free(line);

> +	if (function != NULL && *function != NULL) {
> +		free(*function);
> +		*function = NULL;

		zfree(function);

> +	}
> +	if (filename != NULL && *filename != NULL) {
> +		free(*filename);
> +		*filename = NULL;

		zfree(filename);

And then in both cases you can remove the {} as its just one line

> +	}
> +	return ret;
> +}
> +
> +static int inline_list__append_record(struct dso *dso,
> +				      struct inline_node *node,
> +				      struct symbol *sym,
> +				      const char *function,
> +				      const char *filename,
> +				      unsigned int line_nr)
> +{
> +	struct symbol *inline_sym = new_inline_sym(dso, sym, function);
> +
> +	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), node);
> +}
> +
>  static int addr2line(const char *dso_name, u64 addr,
>  		     char **file, unsigned int *line_nr,
> -		     struct dso *dso __maybe_unused,
> -		     bool unwind_inlines __maybe_unused,
> -		     struct inline_node *node __maybe_unused,
> +		     struct dso *dso,
> +		     bool unwind_inlines,
> +		     struct inline_node *node,
>  		     struct symbol *sym __maybe_unused)
>  {
> -	FILE *fp;
> -	char cmd[PATH_MAX];
> -	char *filename = NULL;
> -	size_t len;
> +	struct a2l_subprocess *a2l = dso->a2l;
> +	char *record_function = NULL;
> +	char *record_filename = NULL;
> +	unsigned int record_line_nr = 0;
> +	int record_status = -1;
>  	int ret = 0;
> +	size_t inline_count = 0;
>  
> -	scnprintf(cmd, sizeof(cmd), "addr2line -e %s %016"PRIx64,
> -		  dso_name, addr);
> +	if (!a2l) {
> +		dso->a2l = addr2line_subprocess_init(dso_name);
> +		a2l = dso->a2l;
> +	}
>  
> -	fp = popen(cmd, "r");
> -	if (fp == NULL) {
> -		pr_warning("popen failed for %s\n", dso_name);
> -		return 0;
> +	if (a2l == NULL) {
> +		if (!symbol_conf.disable_add2line_warn)
> +			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
> +		goto out;
>  	}
>  
> -	if (getline(&filename, &len, fp) < 0 || !len) {
> -		pr_warning("addr2line has no output for %s\n", dso_name);
> +	/*
> +	 * Send our request and then *deliberately* send something that can't be interpreted as
> +	 * a valid address to ask addr2line about (namely, ","). This causes addr2line to first
> +	 * write out the answer to our request, in an unbounded/unknown number of records, and
> +	 * then to write out the lines "??" and "??:0", so that we can detect when it has
> +	 * finished giving us anything useful. We have to be careful about the first record,
> +	 * though, because it may be genuinely unknown, in which case we'll get two sets of
> +	 * "??"/"??:0" lines.
> +	 */
> +	if (fprintf(a2l->to_child, "%016"PRIx64"\n,\n", addr) < 0 || fflush(a2l->to_child) != 0) {
> +		pr_warning("%s %s: could not send request\n", __func__, dso_name);
>  		goto out;
>  	}
>  
> -	ret = filename_split(filename, line_nr);
> -	if (ret != 1) {
> -		free(filename);
> +	switch (read_addr2line_record(a2l, &record_function, &record_filename, &record_line_nr)) {
> +	case -1:
> +		pr_warning("%s %s: could not read first record\n", __func__, dso_name);
>  		goto out;
> +	case 0:
> +		/*
> +		 * The first record was invalid, so return failure, but first read another
> +		 * record, since we asked a junk question and have to clear the answer out.
> +		 */
> +		switch (read_addr2line_record(a2l, NULL, NULL, NULL)) {
> +		case -1:
> +			pr_warning("%s %s: could not read delimiter record\n", __func__, dso_name);
> +			break;
> +		case 0:
> +			/* As expected. */
> +			break;
> +		default:
> +			pr_warning("%s %s: unexpected record instead of sentinel",
> +				   __func__, dso_name);
> +			break;
> +		}
> +		goto out;
> +	default:
> +		break;
> +	}
> +
> +	if (file) {
> +		*file = strdup(record_filename);
> +		ret = 1;
> +	}
> +	if (line_nr)
> +		*line_nr = record_line_nr;
> +
> +	if (unwind_inlines) {
> +		if (node && inline_list__append_record(dso, node, sym,
> +						       record_function,
> +						       record_filename,
> +						       record_line_nr)) {
> +			ret = 0;
> +			goto out;
> +		}
>  	}
>  
> -	*file = filename;
> +	/* We have to read the records even if we don't care about the inline info. */
> +	while ((record_status = read_addr2line_record(a2l,
> +						      &record_function,
> +						      &record_filename,
> +						      &record_line_nr)) == 1) {
> +		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
> +			if (inline_list__append_record(dso, node, sym,
> +						       record_function,
> +						       record_filename,
> +						       record_line_nr)) {
> +				ret = 0;
> +				goto out;
> +			}
> +			ret = 1; /* found at least one inline frame */
> +		}
> +	}
>  
>  out:
> -	pclose(fp);
> +	if (record_function != NULL)
> +		free(record_function);


free accepts NULL, remove the if line

> +	if (record_filename != NULL)
> +		free(record_filename);

Ditto

>  	return ret;
>  }
>  
> -void dso__free_a2l(struct dso *dso __maybe_unused)
> +void dso__free_a2l(struct dso *dso)
>  {
> -}
> +	struct a2l_subprocess *a2l = dso->a2l;
>  
> -static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
> -					struct dso *dso __maybe_unused,
> -					struct symbol *sym)
> -{
> -	FILE *fp;
> -	char cmd[PATH_MAX];
> -	struct inline_node *node;
> -	char *filename = NULL;
> -	char *funcname = NULL;
> -	size_t filelen, funclen;
> -	unsigned int line_nr = 0;
> -
> -	scnprintf(cmd, sizeof(cmd), "addr2line -e %s -i -f %016"PRIx64,
> -		  dso_name, addr);
> -
> -	fp = popen(cmd, "r");
> -	if (fp == NULL) {
> -		pr_err("popen failed for %s\n", dso_name);
> -		return NULL;
> -	}
> -
> -	node = zalloc(sizeof(*node));
> -	if (node == NULL) {
> -		perror("not enough memory for the inline node");
> -		goto out;
> -	}
> -
> -	INIT_LIST_HEAD(&node->val);
> -	node->addr = addr;
> -
> -	/* addr2line -f generates two lines for each inlined functions */
> -	while (getline(&funcname, &funclen, fp) != -1) {
> -		char *srcline;
> -		struct symbol *inline_sym;
> -
> -		strim(funcname);
> -
> -		if (getline(&filename, &filelen, fp) == -1)
> -			goto out;
> -
> -		if (filename_split(filename, &line_nr) != 1)
> -			goto out;
> -
> -		srcline = srcline_from_fileline(filename, line_nr);
> -		inline_sym = new_inline_sym(dso, sym, funcname);
> -
> -		if (inline_list__append(inline_sym, srcline, node) != 0) {
> -			free(srcline);
> -			if (inline_sym && inline_sym->inlined)
> -				symbol__delete(inline_sym);
> -			goto out;
> -		}
> -	}
> +	if (!a2l)
> +		return;
>  
> -out:
> -	pclose(fp);
> -	free(filename);
> -	free(funcname);
> +	addr2line_subprocess_cleanup(a2l);
>  
> -	return node;
> +	dso->a2l = NULL;
>  }
>  
>  #endif /* HAVE_LIBBFD_SUPPORT */
>  
> +static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
> +					struct dso *dso, struct symbol *sym)
> +{
> +	struct inline_node *node;
> +
> +	node = zalloc(sizeof(*node));
> +	if (node == NULL) {
> +		perror("not enough memory for the inline node");
> +		return NULL;
> +	}
> +
> +	INIT_LIST_HEAD(&node->val);
> +	node->addr = addr;
> +
> +	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
> +	return node;
> +}
> +
>  /*
>   * Number of addr2line failures (without success) before disabling it for that
>   * dso.
> -- 
> 2.33.0

-- 

- Arnaldo
