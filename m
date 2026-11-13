Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602021;
	b=dQW2PiJezow6USqMRr+5jQ35A5wYexuBbJXNULa0yhi6R+jxerhO/sh4ayKuIPGthDOS
	 z5YRUM0AetHEaQDDbg1knBWgKUP4fiY6oR30EFYOcWPmzU7wL/yVkbhnk2k3bPTDbGuVv
	 h/ha+eNuQyrWnJ5rUZdovAgZYUYR2/M0HmftCJt/ZpWA6iBBEVhGHpq9i79m1+D1vCeOP
	 BkrMKRWqXr44YWUqbBaHvzxTYPudSPYwKPTSlwYUMe05lsHtl0p/TxYFo9V+BxeF452RG
	 k4WRViOx+7eZEN0C+pg7EUCJesmEwKLwS55znocz2V7XdKXjXLamKk5HtLRpH5vvGdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vt9rAIkNzjf5p/HJMK+RZSSOwbgm80VhsTDLbSVqIrw=;
	b=H8BSGKDZ76WrzvMAdS0EeVAxYBTuXc9pqz+y1gCkIZv0Stf5EYjhDE1HhiHLvTu4gjKM
	 FjNvM14vpJ7G/EV7Jih0Vhgc6aiWGVQxiElMwkQm31BAw//2WlENDwwr0DUCIUrlFwpRI
	 dtsKBnKyZoFVxPMdwyQ6c03da7N4ew80f3rWEJ3UJSut0+GeMaGj7xs4g9ZVJ5qieIDtb
	 55FSKC8RTc+wA8N/ljZzIQatCmP1Hiu/JEdkyBdMv9PeZtC2nSxow7GLfI7V95ewEbT2R
	 fTf51sfydVwJDc40jXalCTpaxE0c4NwVL8nzdKoBx46ERXB/Ls1Wdk3MM57bVLorp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9ISIuSo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13221606A338
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9ISIuSo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862F61F000C6;
	Fri, 13 Nov 2026 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602020;
	bh=vt9rAIkNzjf5p/HJMK+RZSSOwbgm80VhsTDLbSVqIrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9ISIuSonSZvifFpvnQ1fN2V7jbaozMtFHt1qHMhs8Io52FpFgm4+DfDXtSb8F2Pk
	 5y2rdccTbPnjRWOdOM+pTZG+MMWjAR1z/5xFA+9v4P0NwZmuxlz2SMmB3Lg6rPamGF
	 vOxKMybZn5q+b0laNQ7OohZe7fEAWBgwcFZDajzb5/avYstdVpTmj2PO1S0vgO+mAL
	 aWVtLyHek/yK/4Ag2ZCuzNyyerE/cMrMvvEa55oIhba/kbt4WYls/09mBJ2byiZ8T2
	 QhYg/yq1B237NxvfC1vVluUsTqCNGWSlOPrjTZN3qiY50qwjzAOAhEgYEK5Mggopak
	 Hp6/STIIH8sKQ==
Message-ID: <sashiko-outbox-213649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/30] perf parse-events: Decode metric-id terms when
 adding events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-21-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:33:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Metric events are parsed from an event string where the identifier from
> the metric expression is passed as a metric-id term. As characters such
> as '@' and ',' can't appear in a term value the metricgroup code encodes
> them and, after parsing, walked the parsed evlist replacing each evsel's
> metric_id with its decoded version.
>=20
> Move the encoding and decoding to parse-events.c, adding
> parse_events__encode_metric_id() for the metricgroup code, and store the
> decoded metric-id on the evsel when it is created in __add_event(). This
> avoids rewriting the metric_id of evsels after parsing, leaving
> metricgroup with only the replacement of the evsel names of metric
> events by friendlier versions of the metric-id. While moving the
> decoding, fix the out of bounds check on the encoded character index
> and return -EINVAL for a bad encoding.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D20

