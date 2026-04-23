Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D3611E
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920273; cv=none; b=XIw1r9otL8h4hBRC/34tfq6LyPVFWvdt2W7pXZuD9aV7dlKPgEVE+kJHzIp5M3xgBhNgAeLR3MPqI2aEQ4s+s5dbxx4bB1cqNtw/5WZFSZ2eIoGEIWo1B4vPJzgfABXDfmZOpUDTuiAGgmjRqJQ696knAdDB4ew6g/tmbxTIeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920273; c=relaxed/simple;
	bh=cXgiyADC2NaCrzqJz/LS/rdwhw7CIre9hNXEYCTNs5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o3+wE3Zi9GM/cR4TvxU6gFtFXTUvA3E3vymwL+RmZSN7ZGrJShU90buHRn95u0WihYWwi/trha5SHBjgQPhC6YiwgQ1Nzvhy2HOvkDm+4YmbuTvvrplXjhW3wDMzMrUVYo/Twlgp7oKz/2SgAOZEQyp6sQzsmwKwyhkaWwYgpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhfaSs8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhfaSs8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D36CC2BCB2;
	Thu, 23 Apr 2026 04:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776920272;
	bh=cXgiyADC2NaCrzqJz/LS/rdwhw7CIre9hNXEYCTNs5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RhfaSs8P5+Gh7Z8ZToDUGke04i0lvG6NX9DAC6VqxZBxCnPH3SbKcIl8/ZC2VnjyJ
	 snzy8oLAddY/ESH5PvFqUVkMk9u6x2KgPQOzF9B/Og6kKf04XWp1OIB/NKC5YUUft3
	 vyQKyH6mopbKvpq7fidJAvY/qILiP/Ba0Q49HpDWi8OQ41/IcKErjjnO9CZ34C/b4D
	 rgF0oAsmnW1r01BhDquJU/h33YE2VGwBpnZHldvFRd6JHHUPn0ectjlUwAvu+38WF3
	 Y1PKrHh2FtIbDuyJV5XYdeF91DMwSXDjaiQNX6HHoYf9Dm3y2xA45OeUFgfD07FqfI
	 hMFZ5klKAH+Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 56/58] perf script: Refactor to support standalone
 scripts and remove legacy features
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-57-irogers@google.com>
References: <20260423035526.1537178-57-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:57:51 +0000
Message-Id: <20260423045752.6D36CC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unintended fallthrough to event processing loop when waitpid() is =
interrupted or fails.
- [Medium] Memory leak when parsing script descriptions containing both com=
ments and description tags.
--

commit d419707ea0a6d06c32b882daeda66df529a86bef
Author: Ian Rogers <irogers@google.com>

perf script: Refactor to support standalone scripts and remove legacy featu=
res

This commit removes the legacy gen-script option, updates the script
search to look directly in the python directory, and launches standalone
scripts using fork and execvp. It also cleans up references to scripting_op=
s.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3630,13 +3723,15 @@ static int read_script_info(struct script_desc *d=
esc, const char *filename)
>  		if (!strncmp(p, "description:", strlen("description:"))) {
>  			p +=3D strlen("description:");
>  			desc->half_liner =3D strdup(skip_spaces(p));
> -			continue;
> +			found_description =3D true;
> +			break;
>  		}
> =20
> -		if (!strncmp(p, "args:", strlen("args:"))) {
> -			p +=3D strlen("args:");
> -			desc->args =3D strdup(skip_spaces(p));
> -			continue;
> +		if (!found_description && strlen(p) > 0 &&
> +		    strncmp(p, "SPDX-License-Identifier", 23)) {
> +			desc->half_liner =3D strdup(p);
> +			found_description =3D true;
> +			// Don't break, maybe we find a better "description:" later!
>  		}

Can this leak the memory allocated for the fallback description?=20

If the loop continues to search for a better description tag and finds one=
=20
later, it appears desc->half_liner is overwritten with a new strdup()=20
without freeing the previous allocation.

[ ... ]

> @@ -4253,149 +4235,54 @@ int cmd_script(int argc, const char **argv)
[ ... ]
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

What happens if waitpid() is interrupted by a signal, such as EINTR, or=20
otherwise fails?

If the condition evaluates to false, execution will fall out of the if bloc=
k=20
and continue. Does this unintentionally allow the parent process to keep=20
executing the rest of cmd_script() and process perf.data natively, instead=
=20
of returning an error or retrying the wait?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D56
