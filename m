Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3035C69F
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189252; cv=none; b=MAaF4z0SvhApFwtb8itIaJknvQhqXPDBDIuMazG8HjUatbaUEwIL9uYd9hPytAIhFGw6yzhI4vRndESK0wmXdYOWmVitqKbmC7KZgRhgUgDOJPl92+6ukMeFnwjWn1/8Y80w442UgvmYhlOHWEg9R9ZxhijXl/0ginqvbsdt/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189252; c=relaxed/simple;
	bh=y+YMe9y4HuCnLLynJECyhkO1+x2idP0QGfTkLwCJDlk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GQxBdYDPC/LLcOqTgvxaziRTTtk3ZhM1o1mDPUtokDBOwaDIURjYgkTguLsBKWfyGyr/FNGc8fzM5OdEJuq4g8pn+2m/IQkgpdQDysAN6OtQY61Yga/Pv3rK0STRi61kPjRnxmrdN+o9lbnxwcTPGQMTzd5qvDA4TNOS1KVdOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmiSz73v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmiSz73v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09581F000C4;
	Fri, 16 Oct 2026 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189251;
	bh=y+YMe9y4HuCnLLynJECyhkO1+x2idP0QGfTkLwCJDlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XmiSz73vb6M7u5+OdFSm/NjCI3eSrvMJ9YylppklHXOi0sbrYUS/W+3dPk9C3wfEy
	 upae4bnNcK09pFyrFzHG1FS4h7QqHJlDj4H4V70Xc7mfPvO+rhfL3v+H780gViqLtM
	 cmnYqFNODZ0AsOdvaJlE/x8p8ZMuJ9pSF+gj1Y2Ri5poWYVkgJ3dGfKc0XTLilDs8Q
	 IghAHiekQUGXv2rHKx2874SFRKSQgKfF5cTgXQxhIZCLPNP/5paI1FZcGgPJ08QdL2
	 o3W8vi3zHojy37vBISin9KfFVpkOFJ+VeNcXwi2FP5bTmeF0lGr2UQq+Ilz0Mm485k
	 XsdsIbf8lXxpg==
Message-ID: <sashiko-outbox-175001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/17] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-7-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:20:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D6

