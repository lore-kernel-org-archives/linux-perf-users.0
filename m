Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405937;
	b=xBVakXyYAEaNx4NFwNFc9pRUEdjcX1DIwDfp20+28yCt4E8Uy/OdbbWeNcW7yvQQt6P1
	 9Vt6TTFWCP3mgIlNunYnAkNjvHVCqczn+gUKwPAMapi2NFv8TMW+MXNxEmLG7lpKbD/eZ
	 MYO4yr2zy9WvZsVDIVxeND+rQcsiFIdB1VPxe2T424J1WOqwlupn7lRXhryyN6VB/ijem
	 Cg/u1Myp9S5p2P8XdpDKhoI4AT/vOzHYSzYkwbhR1fWLshQyTdwwmUxnXkGF8ED8WsPlg
	 o+KG2sG3CGgyKfQuwdekiI0cQ8LiAzpTTWqPz4DeMlPgBYWbcvEOFRF2iD/j5+xRhwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TFHH1ISsUrZlQNtqkxXZxpufeGl4tOWrEabuIEdfECg=;
	b=VIechGG36UjtcAEICO9knZuqq96z/zjC71v0CK0U3YocPM8zTpRjWIPeh22O34p0zlv/
	 8najXe4OcCp9k61yBoni7QSoddaLlRvfKj7JkTtiIurXQm2LaXZlJXs7sOzu+beTKw7RS
	 bxJJ2BmKwmlYA7e6ljV9vz4lM0e+lJjLkM5ntax2iU/Xnk5zw8vQYkiTWX9uLyZL+2ofc
	 +nIBY9Rf5e/wkIB1wEDJvepQrbVlMWylMoIeQQ5+ErTBXQmcrviLOtF4XdoMZyfTR7og0
	 CL9HcCpnE9a0Fnc7A+cnqMcP6JUsqck+jdHnQsa8/3oqbNmDmRZFv+GtXZA+iDM615A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azvTfSpl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E8606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azvTfSpl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCC1F00A05;
	Wed, 11 Nov 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405936;
	bh=TFHH1ISsUrZlQNtqkxXZxpufeGl4tOWrEabuIEdfECg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=azvTfSply9a6KWMaiiD1+1cm3ntXeb6SXlOhWHkvxq6tz2Owc047j/GVGBEYeGnZq
	 Kq/6PWlbigY7nRPhEPvD3IJBDq8s0ZoHyZVQ7e30MVW9AIL0GmrXNMaPh54IV1vxbJ
	 OCs3CP0N1U/0gtRerNVgb7L5KzaybU1h1CwJ0QvHk730LpIHCs7qboBdmDgXkT+0CZ
	 ch6Wq0gkIy+wJArIx1aWjwiqwK0jgOYk9hjixHgn1WPnmizqLpChBJg50IAjgEOW4F
	 /DgF+j/jgeIuq4fzd3LRD9kCEu2NcJDndZcJnIulxZGD48wiS66MTVF0ONFlxPs2a1
	 gxs8tYaKGa7Iw==
Message-ID: <sashiko-outbox-209117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] perf jevents: Make the model argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111132622.2349165-3-takano32@gmail.com>
References: <20261111041045.2031464-1-takano32@gmail.com>
 <20261111132622.2349165-1-takano32@gmail.com>
 <20261111132622.2349165-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:05:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The model argument carries a default of "all", but a positional argument
> with a default and no nargs is still required: "jevents.py x86 <dir>" exi=
ts
> with "the following arguments are required: model", and so does any caller
> that only wants the tables for an architecture.
>=20
> Make it nargs=3D'?' so the default is reachable and an omitted model means
> "all".  Builds pass it explicitly, so the generated tables do not change.
>=20
> Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111132622.2349=
165-1-takano32@gmail.com?part=3D2

