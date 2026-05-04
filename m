Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102871F3BA2
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923216; cv=none; b=H0aYha/ha3XlWvVcZNEyLZa/YIgu9rCn74ozgoexdJgJe6EFWSX6cOaOsLuV/MAiTUjVACC9RRp+ak4iOjxSROspwp5HV/zh0OPJGA8QJh5JmqZ09ku5704kGdfAZ5sQD/UDfAvTkGDM0mNoqkrGIJmLjp9JNRCzRpQauXeIQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923216; c=relaxed/simple;
	bh=cW+2SaOhK6BEo+RWanwaCexV36ofDriiP2uR+bEyFq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UqyWj2mlDDbJ/cT4Ng3JUI1S5KRRNe7l03+GRvVhXpHsAA8CnCwCkdlwlbfkDCDIQg24BPTmw+DQyGOpUUMe1UCximRZ/YlmM7cEB62tDYvu6OVGc3gXhbQn/Rg2Q7v5R9HRLCmx3XBsag2lFeH+Xq9M8bSx6lfRxriwRH623DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwzZQHjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwzZQHjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BD0C2BCB8;
	Mon,  4 May 2026 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777923215;
	bh=cW+2SaOhK6BEo+RWanwaCexV36ofDriiP2uR+bEyFq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gwzZQHjYSCZTAOdiuPQzCvCDWfo1XqsmpvS9jAvSc3KTi5EZUBc0YpziQvLyb2UZA
	 OFSSvUjYHztW+3ACpaa5NfNizN3h9vmIGMPft7/asEJKUmnrrwRqZQbZJFRoTMR4BJ
	 rbPtKYq2PHz/J9+4gjNpXpjHhlfQBrf0J6LRmRqtrnMNbg+2zYSfWfz8XOdnxzPBnz
	 jTW8ER3UUsCB9VX3XcjNRQ3E5JkK5fgXI8oiEnliWTfknrykoDPlxvCXK51nDuk6Wq
	 /30/2m5wqN9V4OBgy4+ZV+XdSu5Y8mYjj34J651i0pgUUOh/TM1ujzEqPTIEa6viZv
	 VFdnrL8ZBgC2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf build: Add make check-headers target
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503193137.27465-6-namhyung@kernel.org>
References: <20260503193137.27465-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 19:33:34 +0000
Message-Id: <20260504193335.81BD0C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `tools/include/uapi/README` documentation was not updated to=
 reflect the removal of the automated header synchronization check.
- [Low] The new `check-headers` target in `tools/perf/Makefile` is missing =
a `.PHONY` declaration.
--

commit dd1cd2c298920f9790f61d618060d62047bed876
Author: Namhyung Kim <namhyung@kernel.org>

perf build: Add make check-headers target

This commit removes the automated check-headers.sh script execution from
the default perf build and adds a dedicated check-headers Make target to
be called manually instead.

> As it's to improve perf trace beautifier to catch up new changes mostly
> in UAPIs, we can make it a separate build target and call it
> occasionally.

Does this change require an update to tools/include/uapi/README?

The README currently documents a "software-enforced copy-on-write mechanism"
that is "driven by non-fatal warnings on the tooling side build."=20

Since this is no longer automated during routine builds, developers might m=
iss
UAPI changes if they rely on the currently documented behavior.

> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile

[ ... ]

> @@ -111,6 +111,9 @@ build-test:
>  build-test-tarball:
>  	@$(MAKE) -f tests/make REUSE_FEATURES_DUMP=3D1 MK=3DMakefile SET_PARALL=
EL=3D1 --no-print-directory out
> =20
> +check-headers:
> +	@./check-headers.sh
> +

Should check-headers be added to the .PHONY declarations?

Since check-headers is a command target and does not produce an artifact by
that name, if a file or directory named check-headers is ever created in
tools/perf/, Make will consider the target up to date and silently skip
executing the script.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503193137.2746=
5-1-namhyung@kernel.org?part=3D5
