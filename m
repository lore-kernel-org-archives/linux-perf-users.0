Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA83A1B5
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094271; cv=none; b=ntyVXIySgK3AT9hUWTGhKnQjqnrs+2+mJa6Qo7qJfH1RBdgcvDtZLdwyXpJd1+2IYvTtAePqYfmhkWks0LyUNZVkZJsLkJXy4bWe/Ai2Xj+cv+YGtrBCAoSOZ4mW44zERzupsHgjr+ptKzvkXzGfumx8DtDSiEGp14ec8G4WN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094271; c=relaxed/simple;
	bh=e/WOcc5YwzUrzaZUa0B0/DFnb4S++PTFdHm0aYCqyIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glFAdmfHCl5CSSvE23j4/lu0K8kqVeyih495jBZiLnIBNFsD6NvnB+KOHcx7TA5ksE0egMPavjkdW3P39eUhXQR7MGpjzanxKquVk8HjV75eN4syrSAGnddrNc1ZfK8s5mgDyBghi4mSnimRIpLav/ZZFdHqB4jW5fdqJ4+ZBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCrV9E0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCrV9E0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B801F000FF;
	Sun,  4 Oct 2026 06:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094269;
	bh=ELuI+GhlApX/KgrpCYxMW+YDChXPcNvN6z2BuuECFlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RCrV9E0leB/atiGMPBz/RcDc3L3pZkfkDpkeOTv/nFEIBTPg1G9xi/dXlIWV+ofEP
	 zwbetDNcBS2O7EYd/41tCAsCSpl/2sk7wbeeAlvmxc1jCZvDwG+CaBEaRVL9K+Nfsz
	 NJiWaLSqS+TZz+Hho2D2f9sNVrAAtGi1Mf9lVBChkmiAa7KH/wddQJnjfwfjamT+MZ
	 ebWNoQsB9Rwxjwqqq3U0iJ9uWXyqWSA3gWVuxMacDmHJfvs7CRgcwZ5btXqqsncqJ3
	 rWQ8oLsoQOrOoEdJjrZ3br5Fk0svm1HNQv34ipjNqyxsyfnLYB1QD9qbDNFfGq3CBz
	 m1Bd4FEGGwkoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-8-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:11:09 +0000
Message-Id: <20261004061109.86B801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Now that --progress is being added for the stdio case, wire up its
> counterpart for the browsers: the TUI and GTK ones present progress of
> their own and there is no way to turn it off.  Install the no-op
> ui_progress ops, the ones already used until a backend sets theirs,
> after setup_browser() installed the ones of the browser in use.  The
> phases are still counted, nothing is shown for them, and no second
> option is needed for it: parse-options provides --no-progress as the
> negation of --progress, report.progress_set saying that it was asked
> for, report.progress being false both when nothing was asked for and
> when --no-progress was.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D7

