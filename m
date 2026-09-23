Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0051CF68
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187598; cv=none; b=hDJXJiYKwoYVB6bFsUBKVA1ckUts4aHCGV0sjk/mXC/CbK5aFVHwy/yI7lp+NYmoZfD3AXnXrrKiNqoZVs0jBsQ6HsKuhxi7pCmydJJLMOUnB8fHzuwI56Z3QguX/WggzPEO/lAfixzf/DY0jDs9PPRiqYvhoVem1pi/oANZ6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187598; c=relaxed/simple;
	bh=gQQVncAi3HVVONOv8f7pYvqaCxKVcKUAw9X5DPfFtvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hjwy9ZysrMRHHwniPJ1pYuwWCCyh/E6Q7BYAaea32yXl45kv3648gwtLvlI10kbySPmkLh8+jyhEkJh7JdnuimoxVpYQ1eHPyqdVH0sZ2LgjGQzzx5jWJFqwqFGeVjXrLJsgEEXQhYEBAHS3dos5zUxOONGfhyYFvxBK07du2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKqstYnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKqstYnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75FD1F000FF;
	Wed, 23 Sep 2026 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187596;
	bh=RxojjTf3Bueez6KgvQMctrIUkqKYVhOQlvHikmlc0hU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKqstYnGJNpP0kpDqAznvxjtHxTjvdLp7vjNmyhdk5QgsDec8zMaI6WuLdSU8/icG
	 anX9dm9/U4udsCzLaCfvMaZrziPkeeH7vLTw+AhECfgEbMiGLgA1SWmEDD6jhrjfBc
	 NsfUOmByTDtRA9uZHUSeTOwMx3H1yMaMzfDMDB4gJTr3VuDXLw+SnqpaaZtnSuHCwe
	 zjadT5qagCgh3EyCbwcUeVS50RPFQbcz7A33f1MMQ/RI4d76Jt4QiAQZ/HsCGGGY0/
	 bNMiKR5s1PTzfJDaTlWSElVPW8+KYjByt4dzd7S0IULQIcuG7GQRAuWYMBPRkwbwC0
	 wdWTs3IWYyxsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/49] perf python: Clean up pylint warnings in
 tracepoint.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-6-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:19:55 +0000
Message-Id: <20260923181955.E75FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in tracepoint.py so that it passes pylint
> without warning suppression comments:
> - Catch ImportError instead of bare 'except:' (W0702: bare-except) when
>   importing setproctitle.
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evlist.enable().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D5

