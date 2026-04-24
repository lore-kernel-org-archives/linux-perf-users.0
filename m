Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69050262808
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051855; cv=none; b=SGRUmAA5c15hOopBYrgQ7HXFesvYHrebJVJmdlzjAJJzr/G7tIQDNoPCFc95wQfDWV03IJuWgPjmz512cfmD6RKxPFhw18jP/f76QcD0F0+uPXdF9FajC7iNEIQC52bcQZdK1wAfxT9aurPuoOWPSa/GpGsJUYNGG2GIweiI68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051855; c=relaxed/simple;
	bh=3ntN14HzLQyb0HD6i7VunBMDzBfSD758QFAq5NEl7VU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdFRgV/Sl4FCB4S3k+lUFLYlv7nkfZso8Leyn6AItb/ndobCuXfvM+Rypph0M9F5S3NasXqRVkWPMlNStM3lZ3jsu4FfFGMJigtkVrhsBjVZ4Aq7yuyio+5iq9H//BEHSfkHYjF1581mMtUoLnCyP6nRuJfkzMzBPCXfbjtzXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNfbzkdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNfbzkdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ED0C19425;
	Fri, 24 Apr 2026 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051855;
	bh=3ntN14HzLQyb0HD6i7VunBMDzBfSD758QFAq5NEl7VU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eNfbzkdqGaZnVduY8r+lwgtBk1BbcaYkYR4L6iVrMaWxM8CMAGRyd4+bz5MD900+V
	 e7sCHNApdMGelWaKXAgUqgLP2EMldTfXO1w0n3MDTUQyaHILHXoKmQu5Z/4KY20vAR
	 56YNZVQvfoPtZRx03HmJcjWMPE7TMr4smwwXwYOW6mY+ozBkJNgcOrgCBjuL+EJFis
	 He34JTe+pWSq38slUBOdm55bPqtdUg6dG1UFBsHUlf/RNqtFwsmN2IsWjpMEiCTYI1
	 iT1HyGAPdoO7z5w2xq6XbRvS/vBETX8S2TrXir43YPHe2CQaRk9AdKEQwDKxit618U
	 H4mMPgs6t5weg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 57/58] perf Documentation: Update for standalone
 Python scripts and remove obsolete data
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-58-irogers@google.com>
References: <20260424164721.2229025-58-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:30:53 +0000
Message-Id: <20260424173055.13ED0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Low] The rewritten `perf-script-python.txt` drastically under-documents =
the attributes of the `Sample Object`.
- [Low] Obsolete tip referring to the removed '-g' option in tips.txt.
- [Low] Dangling reference to 'perf script report mode' in perf-script.txt.
--

commit 5be26cdce292df0900056c86e7f08c9c434bea21
Author: Ian Rogers <irogers@google.com>

perf Documentation: Update for standalone Python scripts and remove obsolet=
e data

This commit rewrites perf-script-python.txt to describe standalone script
usage with the perf module. It also removes obsolete documentation for the =
-g
and -s options in perf-script.txt, and drops the obsolete perf-script-perl.=
txt.

> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf=
/Documentation/perf-script-python.txt
> index 27a1cac6fe7638..9293057cee8e2d 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
[ ... ]
> -SUPPORTED FIELDS
> -----------------
> -
> -Currently supported fields:
> -
> -ev_name, comm, id, stream_id, pid, tid, cpu, ip, time, period, phys_addr,
> -addr, symbol, symoff, dso, time_enabled, time_running, values, callchain,
> -brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
> -weight, transaction, raw_buf, attr, cpumode.
[ ... ]
> +### Sample Object
> =20
> +Passed to the callback function in `perf.session`.
> =20
> +- `evsel`: The event selector (name of the event).
> +- `sample_cpu`: The CPU on which the event occurred.
> +- `sample_time`: The timestamp of the event.
> +- `sample_pid`: The PID of the process.
> +- `sample_tid`: The TID of the thread.
> +- `raw_buf`: Raw buffer containing event specific data.

Does the new documentation intentionally omit the comprehensive list of sup=
ported
fields?

The C-extension (tools/perf/util/python.c) still exports many fields like
sample_ip, sample_addr, sample_phys_addr, brstack, and callchain, which are
actively used by scripts (e.g., intel-pt-events.py). The rewritten section
appears to drastically under-document the attributes of the Sample Object.

> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 200ea25891d88d..93ed1ea704c950 100644
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

Since the concept of 'report mode' has been excised here and in the
DESCRIPTION, should the documentation for the --show-info option in this fi=
le
also be updated?

It currently contains the dangling reference: "It can only be used with
the perf script report mode."

> @@ -90,18 +44,7 @@ OPTIONS
>  --list=3D::
>          Display a list of available trace scripts.
> =20
> --s ['lang']::
> ---script=3D::
> -        Process trace data with the given script ([lang]:script[.ext]).
> -	If the string 'lang' is specified in place of a script name, a
> -        list of supported languages will be displayed instead.
> =20
> --g::
> ---gen-script=3D::
> -	Generate a starter script. If a language is given then the
> -        script is named perf-script.[ext] according to the
> -        language. If a file path is given then python is used for
> -        files ending '.py' and perl used for files ending '.pl'.

Is it also necessary to remove the obsolete tip from
tools/perf/Documentation/tips.txt?

It still suggests using the removed -g option: "Generate a script for your
data: perf script -g <lang>".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D57
