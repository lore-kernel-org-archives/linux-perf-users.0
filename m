Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902E248F72
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644735; cv=none; b=ZZalZ4Xm/TDEjEA8fO9bfr6REDqpHE5DcqN/j0Fe1/DwQ4p9LBMatOHXcj3gqlAG48WjRBESZWBXDLyrKHHUJmyn6g4JRmrDaoemMJQS/JJr4CrFlbgDtYM24kdZgVll4+nIdT7Q0z9A0XEzt29aL+zkXC4l+m1HosWizotsc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644735; c=relaxed/simple;
	bh=Pq7Ydvgz2murBW3lAms8hxJ/g2Kb8+05N9AzfVcOT2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4tqV6o5q7gh8NWq6RG8nz8Gtll/1zgdNP7ZZHZRyeTkfoYnRRShrcM8JFiD0SkMYXtXs+9tNrnchZaqTUyilaz7IWs+iatpkiAvnzgzFZFuiemPTkrdou8okOuxaL/8Gco4FmXKuA7sYEqha1ckhmJuBwgDv6OBykz9rvQVj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ9hIlkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ9hIlkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D6C1F00893;
	Tue, 29 Sep 2026 01:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644734;
	bh=15kyZ5N8cQ67rsbVWMW6LXHkp+xNC9D+SVT6r9yoyuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZ9hIlkq75EQ97MkMzOmTFBEjLf5hXg9of3fKbLTPiRVPzPvVUpR67GYq3MopNEeI
	 lfvIAe2wrymnG7gPQoQljHD/UUaloGDAeiBayEEOHppCmpVdLV7DCVBmYM+m7kdlJ9
	 /gkEm2OBQMI3YDK5T9AURFhWBOtBja6pObxn7fvpkU/tgY8aZMERV03w46gQbq2X2w
	 u9iIRrzlhEvPK1wDzLKvhaiRdU7x+yojR16LxzV6TlmrVfJ9ynfNiR8JDA9gqEwvBV
	 n5TiIywEwot3w/4B2B59DaoFq0dUNKIYQ/pZanA7l4y92p+9hWzOhKGcKyV3zWcyo6
	 kDu3NwTpi7p5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] perf tools: Add dso__put_filename()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-6-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:18:54 +0000
Message-Id: <20260929011854.60D6C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It's a counterpart of the dso__get_filename() as the returned string
> should be free.  Optionally it needs to remove a temporary file if it's
> decompressed on the fly.
>=20
> Currently the dso argument is not used, but it's better to pair with the
> matching dso.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D5

