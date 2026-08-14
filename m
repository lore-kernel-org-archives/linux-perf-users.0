Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E781175A80
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666465; cv=none; b=i7/Pth0qE0q7f1aMIIQlBJb/3AUhQrPaXdSRaPF/EKdzhI+Aqs98dUcvNYUoGBJYa/VdyFumFxn/xV9y+S5J6ThEft3umdzPs6+L5tezVDJDgRA8493PvsL+/D161C5Y5/PKiFz/bjprY3Hn3FgXD0mwv1a+g4uN3V7XQG6QKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666465; c=relaxed/simple;
	bh=J/XjsiqPrxN4ZVlGqzaRkWx2fZQlLFjpBl5auku9GlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tI1XUBtxtfBi+aE44VzeJ7evd4aDiNDsy7qNjwnfMznd5lMNh+p5P4P/6q3yyfwbGmbe9KnZsQR9y+TVwKDA76iu07Zv1JVSElEJKdqjopIL7cLepukq7nn0CTcqIckHWBEYJ9HUepLG26WpainvMoIg637x60MYPTleXIgdrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH0hMaYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH0hMaYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1128A1F000E9;
	Fri, 14 Aug 2026 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666464;
	bh=J/XjsiqPrxN4ZVlGqzaRkWx2fZQlLFjpBl5auku9GlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UH0hMaYOWnnpRHK8N8i5gXmB7ESKkuYeB/QTSXc1yqrXqo+7PS7sHe+LMZow54Gqc
	 f4kKqJ88D/aV2y+FgFswLY4h3R9ZSo0LkPQTrIiEslDi6LyLDg5egvtWI4cx7PpQqc
	 iAQJiK5hiXPA3z+rmw6Sbzzf06Zulbtr88snWD1MqMdS8xTUqkUgQdmt/6Gz4OnZZN
	 vB0BSCv8eEwum+u2t8vXTnwZpddXEgdI368rhh8FmiXSXss36bmjny2X+OnViQYET6
	 PQCprmMsh8C2RWVRJ4LkzMQrakTmSdnD+HZzJm4rQEgRqWvRLIfkOG5Q2BYS+E5uPh
	 2o94OZjnawi4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/29] perf sched: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411191710.524998-18-irogers@google.com>
References: <20260411191710.524998-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:14:23 +0000
Message-Id: <20260814001424.1128A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The sample contains the evsel and so it is unnecessary to pass the
> evsel as well.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411191710.5249=
98-1-irogers@google.com?part=3D17

