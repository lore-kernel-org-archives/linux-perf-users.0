Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B51509AB
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646860; cv=none; b=GDbh5xAwunqYqwQA91d3O0mFV6ejjhAfJh8Edc2OwWe/zTLcwDYUZP7olb/tBLaqEYnD5a8viWxrSUuqntyvOrBg9BkhFkBjcrh9kYQWj/ds7sgxpoZQfrmZaRYrjRuWcAlhSAzzXkIi6FW+WHYhG0raVf/AWDw7fED9PYbggxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646860; c=relaxed/simple;
	bh=7VhZP0AvhEPtlFZDviM5bIGFu4nDncCbrGJ1+SxdOzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LXRiHAIs5ttPs1a+5i53orYF+2T2uRiYmd6KCjugfKn7dVs0+xgXqszGdX7S74jRovFGpbK8nkPBriEpl7S6g6IN1Ek+1TYqdZXW6L7KJpLoRvwFa7zrVfAdEec9A2NLnwW1rG2aYl1LPnS0ixSr6FqQK3VFGpk7JzMX3Tl59Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4nY8Rw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4nY8Rw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC87C2BCB5;
	Mon, 20 Apr 2026 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646860;
	bh=7VhZP0AvhEPtlFZDviM5bIGFu4nDncCbrGJ1+SxdOzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=c4nY8Rw2ubVMGfrOoaM/z23Mf/2gMVxyRVVHmCSdb6Pqb4yQkCfzAaHg43e/qjGzI
	 ckzP4KEOExzUn3Acq7TxehlTgHSDHR5H80ajllYQQbqTYtSsTiK4hSrFhuKXa8gA4v
	 1npf2x6Gpf8eed+7ytYl7UhScLn1o4VWTIhGBpyQoHon4CcokfT+uP5DgjN4pWWr0L
	 hPrn6pph0dGT6V29M2lxPSOmQyAPsnFhtq1itEnwgC4GNJUObPDEeOXv80JRzJjXam
	 bC5u1wciLEOGmn/H1BXzW9xleo7G+m08WOxK9P9lb5jk89HhvNquvUBZBeol9MHHN/
	 t9pnsMK7N5wZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 56/58] perf script: Refactor to support standalone
 scripts and remove legacy features
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-57-irogers@google.com>
References: <20260419235911.2186050-57-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 01:00:59 +0000
Message-Id: <20260420010059.DBC87C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Stack buffer overflow in find_script due to incorrect strncat size=
 argument
- [High] Uninitialized status variable evaluated due to missing EINTR check=
 on waitpid
- [High] execvp bypasses the verified local script by searching $PATH
- [High] Standalone scripts lose parsed command-line options like input file
- [High] The 'record' and 'report' subcommands are broken because they are =
intercepted but not implemented
- [Medium] Premature loop termination completely breaks script description =
parsing
- [Medium] Silent failure when standalone scripts fail to execute
--

commit f5e516bb31de707c57e0bd54b45bd5f67d067656
Author: Ian Rogers <irogers@google.com>

perf script: Refactor to support standalone scripts and remove legacy featu=
res

This commit refactors the perf script command to support running standalone
scripts directly via fork and execvp. It also removes legacy scripting
features, updating the script search path to look directly in the python
directory.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c0949556d1bbb..8d8bfbd321f42 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
[ ... ]
>  /* Find script file relative to current directory or exec path */
>  static char *find_script(const char *script)
>  {
>  	char path[PATH_MAX];
> +	char *exec_path;
> =20
> -	if (!scripting_ops) {
> -		const char *ext =3D strrchr(script, '.');
> +	if (access(script, R_OK) =3D=3D 0)
> +		goto found;
> =20
[ ... ]
> +	exec_path =3D get_argv_exec_path();
> +	if (!exec_path)
> +		return NULL;
> =20
> +	snprintf(path, sizeof(path), "%s/python/%s", exec_path, script);
> +	free(exec_path);
> +	script =3D path;
> =20
> +	if (access(path, R_OK) =3D=3D 0)
> +		goto found;
> =20
> +	/* Try with .py suffix. */
> +	strncat(path, ".py", sizeof(path) - 1);

Does this code overflow path[]?

The third argument to strncat specifies the maximum number of characters to
append from the source string, not the remaining capacity of the destination
buffer. Because path is populated by snprintf right before, if the string
length reaches PATH_MAX - 1, strncat will blindly append 3 characters plus a
null terminator out of bounds, overwriting stack memory.

> +
> +	if (access(script, R_OK) =3D=3D 0)
> +		goto found;
> +
> +	/* Failure to find script. */
> +	return NULL;
> +
> +found:
>  	return strdup(script);
>  }
[ ... ]
> @@ -3608,15 +3651,59 @@ static int read_script_info(struct script_desc *d=
esc, const char *filename)
>  {
>  	char line[BUFSIZ], *p;
>  	FILE *fp;
> +	bool in_docstring =3D false;
> +	bool found_description =3D false;
> =20
>  	fp =3D fopen(filename, "r");
>  	if (!fp)
>  		return -1;
> =20
>  	while (fgets(line, sizeof(line), fp)) {
> +		static const char * const triple_quote_str[] =3D {
> +			"\"\"\"",
> +			"'''",
> +			"r\"\"\"",
> +		};
>  		p =3D skip_spaces(line);
>  		if (strlen(p) =3D=3D 0)
>  			continue;
> +
> +		if (in_docstring) {
> +			if (strlen(p) && p[strlen(p) - 1] =3D=3D '\n')
> +				p[strlen(p) - 1] =3D '\0';
> +			desc->half_liner =3D strdup(skip_spaces(p));
> +			in_docstring =3D false;
> +			found_description =3D true;
> +			break;
> +		}
> +
> +
> +		for (size_t i =3D 0; i < ARRAY_SIZE(triple_quote_str); i++) {
> +			const char *quote =3D triple_quote_str[i];
> +
> +			if (!strstarts(p, quote))
> +				continue;
> +
> +			p +=3D strlen(quote);
> +			p =3D skip_spaces(p);
> +			if (strlen(p) > 0) {
> +				if (p[strlen(p) - 1] =3D=3D '\n')
> +					p[strlen(p) - 1] =3D '\0';
> +				p =3D skip_spaces(p);
> +				if (str_ends_with(p, quote))
> +					p[strlen(p) - strlen(quote)] =3D '\0';
> +				desc->half_liner =3D strdup(skip_spaces(p));
> +				found_description =3D true;
> +				break;
> +			}
> +			in_docstring =3D true;
> +			break;
> +		}
> +		if (found_description)
> +			break;

Is it possible this loop terminates prematurely?

If a comment line is an SPDX identifier, it is stored as a fallback descrip=
tion
and found_description is set to true below. However, at the top of the fgets
loop (right after checking triple_quote_str), this check will cause the loop
to terminate immediately on the next iteration. This entirely defeats the
comment further down that suggests it should keep looking for a better
description: tag.

> +		if (in_docstring)
> +			continue;
> +
[ ... ]
> @@ -4198,7 +4193,6 @@ int cmd_script(int argc, const char **argv)
> =20
>  	perf_set_singlethreaded();
> =20
> -	setup_scripting();
> =20
>  	argc =3D parse_options_subcommand(argc, argv, options, script_subcomman=
ds, script_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);

If "record" and "report" are removed from cmd_script, shouldn't they be
removed from the script_subcommands array as well?

Because "record" and "report" are left in the script_subcommands array,
parse_options_subcommand intercepts these as valid subcommands, leaving
argv[0] as "record". The logic then attempts to find and execute a script
literally named "record", failing with "Couldn't find script 'record'" and
breaking the documented subcommand functionality.

Also, since parse_options_subcommand consumes global options (like -i),
wouldn't the standalone scripts lose these parsed command-line options?
The remaining arguments are passed to the standalone script via execvp,
but the standalone script never receives the -i flag and might fall
back to default files, silently breaking the user's intent to process a
specific input file.

[ ... ]
> +	if (script_name) {
> +		pid_t pid =3D fork();
>  		if (pid < 0) {
> -			perror("failed to fork");
> -			return -1;
> +			pr_err("failed to fork\n");
> +			return -errno;
>  		}
> -
> -		if (!pid) {
> +		if (pid =3D=3D 0) { /* child */
> +			__argv =3D calloc(argc + 2, sizeof(const char *));
>  			j =3D 0;
[ ... ]
>  			if (!__argv) {
> +				exit(-ENOMEM);
>  			}
> -
> -			__argv[j++] =3D "/bin/sh";
> -			__argv[j++] =3D rec_script_path;
[ ... ]
> +			__argv[j++] =3D script_name;
> +			for (i =3D 0; i < argc; i++)
>  				__argv[j++] =3D argv[i];
>  			__argv[j++] =3D NULL;
> =20
> -			execvp("/bin/sh", (char **)__argv);
> -			free(__argv);
> -			exit(-1);
> -		}
> -
[ ... ]
> +			execvp(script_name, (char **)__argv);

If a user specifies a script without a slash (e.g. myscript.py), find_script
verifies its local existence using access(script, R_OK) and returns the str=
ing
unmodified. However, execvp() searches the system $PATH. If . is not in $PA=
TH,
won't execvp either fail with ENOENT or execute a completely different
myscript.py located elsewhere in the system, bypassing the verified local f=
ile?

Additionally, if execvp fails to launch a script (e.g. because the script l=
acks
execute permissions or a valid shebang, which were not required by the prev=
ious
embedded interpreter), does it silently fail? The child process seems to
execute exit(-errno) without printing any error message to stderr, leaving
the user with a generic non-zero exit code and no diagnostic information.

> +			exit(-errno);
> +		} else { /* parent */
> +			int status;
> =20
> -		j =3D 0;
[ ... ]
> +			waitpid(pid, &status, 0);

Does this code evaluate an uninitialized status variable?

If waitpid is interrupted by a signal (e.g. SIGINT), it returns -1 and sets
errno to EINTR, leaving the stack variable status uninitialized. The code
then immediately evaluates WIFEXITED(status), reading garbage memory. This
undefined behavior can cause perf script to prematurely return an arbitrary
exit code, abandoning the standalone script process in the background.

> +			if (WIFEXITED(status)) {
> +				return WEXITSTATUS(status);
> +			} else {
> +				return -1;
>  			}
>  		}
> -

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D56
