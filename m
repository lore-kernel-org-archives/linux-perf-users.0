Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80A1DED5B
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052288; cv=none; b=YVf6EL/KQ6ENRjBfmwsvuCoQWIIM4wyTAOhEcZFdlQer+H3eHliOyEqEyDMv6UvQl7H60m0W8orZZ8kzFOLD5qNmCVW7ISua4lidaJ5aOANgJRvgWtKMxQxyZup8p1+U1XIq3ax3O8qeq/AbVJ78rmn1cYrQGFEdy2ssy1Tb8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052288; c=relaxed/simple;
	bh=FhJOEsfidd9sA5Zm/8YZ105wjIPsd/ifwWwFwBUSpd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jaun3rz2m9NB+LCn+aW+XmrMy86lRQDjh8j37BtmR1Z0HfQDdFumDUox1cGgXprNW0kPEKiOgsoYiRLlUh1k3NrIdNuYLN9iiJFAJbrxLGBfz4b4c/ZAjFrRDeONwznX042kUKIGV8nToaw605FLnLlyyb4N+xGAx1R2MDspr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtcUkSwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtcUkSwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A83C19425;
	Fri, 24 Apr 2026 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052287;
	bh=FhJOEsfidd9sA5Zm/8YZ105wjIPsd/ifwWwFwBUSpd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VtcUkSweaXAV90cqtQaKUsFGow9eJYgKwchuRDL9UDp0aS+nWsex0Bken1EZ0nO1g
	 HmLlZDbIDiSfgCVplS9/X2xG6/liZWMkoB4jK4Q1RxBXJt4Ga9IFZvyzRBQ/YKKR/9
	 UIHygrmXyyMeKwwevv2ZO6xONY0Ml08Sq36LTYLZiHn9iJPCDgbvPG0XFT0IUbFDET
	 J0ECG//dX8gnZagZmQXpngIrAvw3vRTgsJoB9jXZJaPpX4UCzL0A3caR612+oI8rLc
	 V2qEl8wTTRqJpIygtdZdpI2AYvRmKoXho2mGPnQVcz/DAFUcu6bXtL0dkpCm0FaQsj
	 fkGuiyS5TXVUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 56/58] perf script: Refactor to support standalone
 scripts and remove legacy features
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-57-irogers@google.com>
References: <20260424164721.2229025-57-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:38:07 +0000
Message-Id: <20260424173807.96A83C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unhandled waitpid() failure causes fall-through to unintended trac=
e event processing.
- [Medium] Memory leak in read_script_info() due to un-freed string allocat=
ions when parsing descriptions.
--

commit a9d5ccc903f5f6a0818669d88a426ab7c03198db
Author: Ian Rogers <irogers@google.com>
Subject: perf script: Refactor to support standalone scripts and remove leg=
acy features

This commit refactors perf script to support standalone Python scripts,
removing legacy scripting features and options. It allows launching scripts
directly via fork and execvp while skipping the event processing loop.

> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
[ ... ]
> @@ -3608,15 +3659,57 @@ static int read_script_info(struct script_desc *d=
esc, const char *filename)
[ ... ]
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
[ ... ]
>  		if (!strncmp(p, "description:", strlen("description:"))) {
>  			p +=3D strlen("description:");
>  			desc->half_liner =3D strdup(skip_spaces(p));
> +			found_description =3D true;
> +			break;
>  		}
> =20
> +		if (!found_description && strlen(p) > 0 &&
> +		    strncmp(p, "SPDX-License-Identifier", 23)) {
> +			desc->half_liner =3D strdup(p);
> +			found_description =3D true;
> +			// Don't break, maybe we find a better "description:" later!
>  		}

If a script contains multiple description-like elements, such as a fallback
SPDX comment followed by an explicit "description:" line, does this code le=
ak
the memory allocated for desc->half_liner?

Since the outer loop continues when "SPDX-License-Identifier" is matched
without breaking, a subsequent match on "description:" will overwrite the
desc->half_liner pointer without freeing the previously allocated string.

[ ... ]
> @@ -4253,149 +4235,54 @@ int cmd_script(int argc, const char **argv)
[ ... ]
> +	if (script_name) {
> +		pid_t pid =3D fork();
>  		if (pid < 0) {
> +			pr_err("failed to fork\n");
> +			return -errno;
>  		}
> +		if (pid =3D=3D 0) { /* child */
[ ... ]
> +			execvp(script_name, (char **)__argv);
> +			pr_err("failed to execute script '%s': %s\n", script_name, strerror(e=
rrno));
> +			exit(-errno);
> +		} else { /* parent */
> +			int status =3D 0;
> +
> +			if (waitpid(pid, &status, 0) =3D=3D pid) {
> +				if (WIFEXITED(status))
> +					return WEXITSTATUS(status);
> +				else
> +					return -1;
>  			}
>  		}
>  	}
> =20
>  	if (dlfilter_file) {

What happens if waitpid() fails or is interrupted by a signal, returning -1
with errno set to EINTR?

Because there is no else branch or early return on failure, would execution
fall out of the waitpid() block and continue to the rest of cmd_script()?

If this fall-through occurs, it looks like the parent process would incorre=
ctly
initialize a session and begin parsing and dumping trace events concurrently
with the child script, rather than safely exiting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D56
