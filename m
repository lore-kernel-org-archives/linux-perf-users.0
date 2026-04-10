Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83A38C414
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851292; cv=none; b=c2DXh70CuMHqYAte1JG0+vPtNgP5woqlIOdKVBotRRfFZ055hgVwG+nNeUdr6jxRCreKvMfA8Ez8dOeS43kd5bCjMOy+Sc+pq+4MFCbOVz/EQ9EkolzELVD7XiADMWPpJZX9sMqIPvKxGlj9Nnqyc9M8HC3RBXnz8yIMj46ufgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851292; c=relaxed/simple;
	bh=RSxKsmoEAuMp+QGMdZURWruw7M8meI4PslaC8c+YCFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zkn88fF5yLr0myjedSh44tvfeO0U965NQFfLVBQ0tOZ99faEkTHbXkY3piySB3KoSdZiTJWManfm/aeNp/YrFtC3EH6Ehtd3k1dtY1LgHIbBKR/OtP1Cyvw9Ez5EOgUEEsNZk3PZkdPnHDgfhSrZn8sqDMSievtiPc5Y9W110AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BslJJIf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BslJJIf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3BEC19421;
	Fri, 10 Apr 2026 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775851291;
	bh=RSxKsmoEAuMp+QGMdZURWruw7M8meI4PslaC8c+YCFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BslJJIf8ehFg1hV4MEgHqtWy83JbkPjrfQT9b9wa54E2S7U1Iz1Jy0TvExbDm8wxz
	 AjVQvuKHxQOgwLUmWLZrywYGpNq6k+csaLJDEnOTilSOfDFIN5DEpl1QPtkMhbg/V+
	 NF2+VvivSx+K+UUERS+ys4TadqKJhqkZYF9abONNF/HvqGzqP3GYS9+IEe3BmuOgQ1
	 9dkltr/HopDe5lEO18c4b3ypaY7yaWR6choIsi+A2PscVarosgxyPVvwqUWFPZnL2Y
	 ByC+fZRzQBstNgo6H93zSD9DWaf5YDsvqB1Vt7IKDRjk1XcD5GYQnJ2T9W6aCZzyFb
	 YmKGAPz+Cjp9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/annotate: Fix missing branch counter column in
 TUI mode
Reply-To: sashiko@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410194000.219846-2-thomas.falcon@intel.com>
References: <20260410194000.219846-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 20:01:30 +0000
Message-Id: <20260410200131.1E3BEC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The branch counter column is now enabled in standard stdio mode =
where it cannot be populated, resulting in a useless empty column in the ou=
tput.
--

commit afd424a34255fcd5587246caa606560bc9b916c8
Author: Thomas Falcon <thomas.falcon@intel.com>

perf/annotate: Fix missing branch counter column in TUI mode

This commit moves the check for enabling the branch counter column into
__cmd_annotate() so it occurs after events have been processed and the
counter is updated.

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 5e57b78548f42..7fe23b05306f8 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -563,6 +563,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
>  	if (ret)
>  		goto out;
> =20
> +	if (session->evlist->nr_br_cntr > 0)
> +		annotate_opts.show_br_cntr =3D true;
> +

Will this cause an empty branch counter column to be displayed in standard
stdio mode?

The original code restricted this check to TUI and stdio2 modes where
use_browser =3D=3D 1 or annotate.use_stdio2 is true. By moving the assignme=
nt
here, it becomes unconditional.

In standard stdio mode, process_branch_callback() is skipped when adding
samples, so branch stack data is not aggregated into the annotation notes.
This leaves the counter data at 0 for all instructions. Could this result
in the output rendering the column title but printing only empty spaces for
all the rows?

[ ... ]

> @@ -928,8 +931,6 @@ int cmd_annotate(int argc, const char **argv)
>  	 */
>  	if ((use_browser =3D=3D 1 || annotate.use_stdio2) && annotate.has_br_st=
ack) {
>  		sort__mode =3D SORT_MODE__BRANCH;
> -		if (annotate.session->evlist->nr_br_cntr > 0)
> -			annotate_opts.show_br_cntr =3D true;
>  	}
> =20
>  	if (setup_sorting(/*evlist=3D*/NULL, perf_session__env(annotate.session=
)) < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410194000.2198=
46-1-thomas.falcon@intel.com?part=3D2
