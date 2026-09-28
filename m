Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBA3939C2
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620761; cv=none; b=IaXy9zV8URG2PguJSrWQUU6YUpnt9SPGsVZTd++c/93RPOgwOXS15Mcg5WKAOTfO5GOXwI4+rgyAjq5csBgaH5JDYl2kSNEkAD8NQf4xNpyTPL4uJG+mGDgezU6H3pza8pESpwYmrKZS86SY/oqnpPFtQ9SmXsdKWErB4NPlkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620761; c=relaxed/simple;
	bh=g/S9zrd4yk37VHPo6I+tjPW6fOCkQ6gHycoGTXQpHjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VSxVO7vcoT87dj+75h8hLdm77J/dEqPlOsbfDJlPuzImMpGbc/upZ8RdmS9prmVTi5tXJ6yzeLD1Entt3imBYTm+P2ay0sm+jPiqY9UXGZ0RzWRXle1efASXni34RbzePpoQpGRCbL7QTfsySrsYUTKGdCBD0SGLeZBmMlWrmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnCZB5NE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnCZB5NE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8211F000FF;
	Mon, 28 Sep 2026 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620755;
	bh=g/S9zrd4yk37VHPo6I+tjPW6fOCkQ6gHycoGTXQpHjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnCZB5NEXEK4Mqrz/KCfoeGWAH70FnIK675OdFDbieP1PTP9/0uOydH1B0eY7Vaaa
	 QYVNy1mplUy/Pe9+nbaqyWcv1uVPXQhSLKGR00Vkqk0g0bSvwPVthm05/PGSymigg3
	 xkWHmPpVxouyEN+Jz7tJM0PxaJ/qRfT72tGtatUFZDYS+6uOi6hihuXx7OCzY3eVQe
	 8wSslKctEduFCoS0m6Ku5DPXD9h/sH2A6Yq/R4l1Tk/3EP9DxWPPgEdg/jrPXtAV79
	 rzy/x75pk7R7Q5qmAtNmwxwM5nv6y4l5k1V+0Guth1bzUO0aYwHls1r1HEB9C9tWAu
	 rtEChB0QHHzWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/26] perf test probe_vfs_getname: Scope probe name
 to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-22-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:39:14 +0000
Message-Id: <20260928183915.2E8211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The fixed vfs_getname probe name collides between parallel tests, and the
> cleanup deletes every probe:vfs_getname* probe. Name the probe
> getname_flags_$$, match it exactly, and remove it from an exit trap. Not
> starting with vfs_getname also stops perf trace, which opens every
> probe:vfs_getname* event, from pinning it.
>=20
> Remove the exclusive tag from probe_vfs_getname.sh and
> record+script_probe_vfs_getname.sh. trace+probe_vfs_getname.sh needs perf
> trace to find its probe, so it uses vfs_getname_$$ and stays exclusive.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D21

