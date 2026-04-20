Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28621C16A
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645902; cv=none; b=MYn1ao3YUSbD6+6aBpaapk8LYuyB41dy1vdw+MDtDWGcuM0yBUKtYsclsNEV6ZIm/td1VdjmT7VF8INeyAoC26AMidTvV9NMLpjGlg9qpz7cecpiE7PaQ19OKOqoMf53RTUjugRRn8b4kvhdg1UgF9NF5PgIdhMB9yM+KKpoX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645902; c=relaxed/simple;
	bh=VGpwMCAMo0bWJP5cfLo/xCewRV9o3COdhWSB+F7kOv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lmj73CtDGhrCTEjlBI+cnJ9DYkg4/xDeN+MC6WezO5RKk0iOj+xwE2mBpMyw8vjeae7PABkK1al5ySLOctTXPgJk374+1qnW4nt0WURIVut9I3X3XRC7hvKrrEJy5lCGohD9KF03H6/ZQN5CPchYKHbcIZiQ/YKMW7C4rATiLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctiJbbqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctiJbbqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6670C2BCAF;
	Mon, 20 Apr 2026 00:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645901;
	bh=VGpwMCAMo0bWJP5cfLo/xCewRV9o3COdhWSB+F7kOv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ctiJbbqpyT5+Ky/+H5z+UqX2J7p9VBjE4svL6E3PpdIHmcA/VtCgVsoVUJktyjkNi
	 KMaZ5vYCUgxkSM0gbwGO45CyCbssc5Jlh07tgA8IWegddGfHfadQQ71TF2z9/c60+S
	 /HcdhDEVJB3JMjgKCzfKIfp4BJeVIZdAL2xFVbs1rxaX3mkOjWrI5eQcUsmq70oq2v
	 Dh20Z/bju0Zpl/E/r52qyKuw+aohggDGkrOEL8wZUtK5ovHpOeCabWKqUMyJUPkClL
	 H88l9nj8f6/1uoYAA02yLowzlLibpnxB289b4QugVFA9B058JCb28OSZiOK8IdKVDa
	 LURFb0sZKpYpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 57/58] perf Documentation: Update for standalone
 Python scripts and remove obsolete data
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-58-irogers@google.com>
References: <20260419235911.2186050-58-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:45:01 +0000
Message-Id: <20260420004501.A6670C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The documented standalone Python script model breaks all standard =
`perf script` command-line filtering options (e.g., `--cpu`, `--time`, `--p=
id`).
- [Medium] The commit message claims to remove the link to perf-script-pyth=
on in perf-script.txt, but it was retained.
--

commit acb52943132d8618b045a0dd53ad8a5d4cdff814
Author: Ian Rogers <irogers@google.com>

perf Documentation: Update for standalone Python scripts and remove obsolet=
e data

This commit removes obsolete documentation for perf-script-perl and updates
perf-script-python.txt to describe the new standalone Python script usage
with the perf module. It also removes documentation for options that no
longer apply.

> - Remove links to perf-script-perl and perf-script-python in
>   perf-script.txt.

This isn't a bug, but does this commit message accurately reflect the chang=
es?
The diff shows that while the link to perf-script-perl was removed, the link
to perf-script-python was retained in the SEE ALSO section of perf-script.t=
xt.

> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 200ea25891d88..93ed1ea704c95 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -9,10 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'perf script' [<options>]
> -'perf script' [<options>] record <script> [<record-options>] <command>
> -'perf script' [<options>] report <script> [script-args]
> -'perf script' [<options>] <script> <required-script-args> [<record-optio=
ns>] <command>
> -'perf script' [<options>] <top-script> [script-args]
> +'perf script' [<options>] <script> [script-args]

Under the new standalone script architecture, how are standard command-line
filtering options (such as --cpu, --time, or --pid) applied to the trace
processing?

While this limitation appears to have been introduced by the previous patch
in the series that refactored the script execution model, this commit
documents the new behavior.

Since perf script spawns the Python script as a separate process, it
doesn't appear to pass these parsed filters to the spawned process through
arguments or environment variables.

Looking at the new perf.session Python API, it initializes a fresh
perf_session and processes all events directly from perf.data without
native support or parameters for applying these filters.

Will users executing a command like 'perf script --cpu 0 myscript.py' have
their filters silently ignored, causing the script to process the entire
trace instead of the requested subset?

[ ... ]

> @@ -543,6 +486,5 @@ include::guest-files.txt[]
> =20
>  SEE ALSO
>  --------
> -linkperf:perf-record[1], linkperf:perf-script-perl[1],
> -linkperf:perf-script-python[1], linkperf:perf-intel-pt[1],
> -linkperf:perf-dlfilter[1]
> +linkperf:perf-record[1], linkperf:perf-script-python[1],
> +linkperf:perf-intel-pt[1], linkperf:perf-dlfilter[1]

This is the section where linkperf:perf-script-python[1] remains, contrary
to the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D57
