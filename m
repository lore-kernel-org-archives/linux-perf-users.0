Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19E471CE4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187781; cv=none; b=tprBeFlN39wHU8/gEFU7E/G5+GOo5eFJEwgLsA1VDUkDewEvPk7eacM07U6K+nE54M6/QlIzoD3Ieo0rs9eq6p8V5rmZpLepuH+Gx5CxtwbJ5zNIpi8nv7htYFHZb4TPvKzZx/FP5XeKavpVVna5vx6OlJbvx9W/Doa0Subjz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187781; c=relaxed/simple;
	bh=KcMf5HkRy3qqkF6gG/SXXRBmYPFHxeutD6clTe1s2pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdsmzPu947WlC67ngdaXJ+NNdVAjV1eZR/aixoV2/0MyXZpdZ60UaHMVubXOaHdd2KWoC3l1NYm793bagbLeCbDY6erurU5uKK1LAtCIgz6NdXI0hYKJy7iBHLLKkUV3ufqAd5e7oSVotrMQlr16AEtw9qNLJTTP1Z64hMyq1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWcb7LLj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWcb7LLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278E1F000FF;
	Wed, 23 Sep 2026 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187779;
	bh=pNaxKAS/Msu2po1ceiwNBFc5vFiaIHaxk0QIDnRn5kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWcb7LLjYzoqetyTkLghi2Qg5JiQgDFyFIjahyGmCk9I5IvAZmE5ntxgxvbWyPCVH
	 eT7K567yBLcNtNupHsG4XM6ZrQ7oLITIwayZExYwY/GUEWcYjd+P3KoiQubP8Kfcwm
	 jWiKih4+J0m8CPNYVoYtEFlqmfNIZaOME1PEW8zHO2Dt4j2Qu1JP8UNXRg0C6EwHUD
	 9ngc4t91T1k5os6ggDaY8gg77J3BCVIYl3ZNmVHMp2I/4iAZj4Radfdhf3yP9xPZ3t
	 taSJi9LhtjwviGSHhf8+GCqCHDSdjgnxLYVtc6fVkVHbG/uZiCdlqNsYfPrE5zubgw
	 RKU2hCqHcHFCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/49] perf python: Clean up pylint warnings in
 treport.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-5-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:22:59 +0000
Message-Id: <20260923182259.8278E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in treport.py so that it passes pylint without
> warning suppression comments:
> - Replace broad 'except Exception:' clauses (W0718:
>   broad-exception-caught) with specific exception tuples.
> - Pass both pid and sample_tid to session.find_thread() so guest and
>   process threads are resolved accurately.
> - Rename parameter 'args' to 'pos_args' in FlameGraph.__init__() to
>   avoid shadowing the outer scope variable 'args' (W0621:
>   redefined-outer-name).
> - Clear session =3D None in a finally block after session.process_events()
>   to break the C perf_session reference cycle before launching the TUI.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D4

