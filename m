Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136E1A9FAA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877281; cv=none; b=lT92DDJAiO7SB8rGlWFheUM+69Fi9hhKmlVCxuEC19naEcK4H0mY62r//nE6Mpo/HGABraVYC41WlCtCbSBqr/qaHVR6nv0U7LbsWiscHl8qulBvQyKPAOVz5yWzsOmTTAjTLhHJsqGAe4dOK3sKheiJoGqcyNr6F8YHCp2NkrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877281; c=relaxed/simple;
	bh=V971rbLQUZQnQVuAZm+zKetiUdJadS2WXLurvGZmeUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QNHEFioL6wsgyK7MxlKV3Tf7DIoPsEqpgnM3aXD105/cru5CNNAP1HvfucZy7hpIaId1kFMXrMT66pYGuJwcxW63IKpdHLoaCF7jQUMAdeBmdwUy7AfdR7jpcxKQOiBAMQjRk045wdk4f3ojpTxCFN7qgbl2hRHAxyBOs/GGiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+tZtxRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+tZtxRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E66FC2BCB8;
	Mon,  4 May 2026 06:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777877280;
	bh=V971rbLQUZQnQVuAZm+zKetiUdJadS2WXLurvGZmeUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n+tZtxRvt8eWKblEFNsGP2Pr5BypOle7/JDwO3AOOwpv2yXYPYDHS2yAMAAeIWArB
	 hTVBi7Q2xE2VvNR9WbP6j7PRdXKZY+jFQPtJqY+BjmSxnOTw0v8Pub+Tv4o+qaZ1Tp
	 oX+mgkwrXXhCkHo6VB/oQyQKe9kX4WIPES/ePFa/ZY4Lndyh6FhU4Lzws0dZhI2BTh
	 FTvbgtm16n5KCfk4VmrCCRst0FVgzDS7/SBfA+Fa5WnzGO7JMvwtjAzv95Xgb3xtEt
	 24ZCBT788LHsvx4sgsFXxnMI0W4SAv2dMeDS8MwlbHEjHAz9tpUWZARYFzcyWgHJMw
	 h0IaF0HLHcgIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf build: Remove NO_GTK2 build test
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504062758.92001-3-namhyung@kernel.org>
References: <20260504062758.92001-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 06:47:59 +0000
Message-Id: <20260504064800.8E66FC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit removes the `NO_GTK2` test cases but fails to add `ma=
ke_with_gtk2` to the `run` list, leaving the opt-in GTK2 build entirely unt=
ested.
--

commit a080179ce5f6a893edba859d130afb3b6367e133
Author: Namhyung Kim <namhyung@kernel.org>

perf build: Remove NO_GTK2 build test

This commit removes the obsolete NO_GTK2 build targets since GTK2 support
was previously made opt-in. It updates the build-test configuration by
removing make_no_gtk2, make_no_ui, and updating make_minimal.

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 6587dc326d1b..dbd7c86a2dcc 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
[ ... ]
> @@ -153,8 +151,6 @@ run +=3D make_libperl
>  run +=3D make_no_libpython
>  run +=3D make_no_scripts
>  run +=3D make_no_slang
> -run +=3D make_no_gtk2
> -run +=3D make_no_ui
>  run +=3D make_no_demangle
>  run +=3D make_no_libelf
>  run +=3D make_no_libdw

Does this leave the GTK2 build entirely untested?

The commit message states "we need to pass GTK2=3D1 to enable it. Let's
update the build-test configuration for that."

However, after removing these targets, there doesn't appear to be a
corresponding addition to the run list (such as run +=3D make_with_gtk2)
to actually test the opt-in GTK2 build path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504062758.9200=
1-1-namhyung@kernel.org?part=3D3
