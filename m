Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2639F16B
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135472; cv=none; b=Z2S11rBaaO79tJSvdo4eo1ptTeCraR4W27Gl/PeXrwuVbEwJm/QLeDQMZp8Tcwqiubtacm2P6LYFFB9NgVJS4dsrltHHVvHiM3bGXntZ6xAhBCgABd56TPncu1WuKvxlVyWLddZFR3hZVAoQVYJVgjmDhqZVX+LjGiiPBPnBT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135472; c=relaxed/simple;
	bh=zjK/3xCHKztg74c92oNjB7E7CjKSgJmPGGvlLgbW/Uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uicTsl1XvT7S5uNdFZufaFvMiBbblunQYp/4h0HsGThSklo2azrREcJAgP/QqBJT9/luPzaZ7ln7+ktKxgMK5XpHKf67QmPh2ur4I0Uy2jofTauUMcPvwWKTYsQeO36sfIUe2tEPF0TIh08eB3D22Jx3s5DrC3ygKnexDrMJvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx9+Q9DJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx9+Q9DJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780C71F000FF;
	Sun,  4 Oct 2026 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135470;
	bh=bU9VTEA31h7T697kmNmQKGnDM2Jw8QnjfW9xqgLqtFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dx9+Q9DJzh6vjrrM8A09F7u9fHXdccC+1lrPzP/L8O2TRN8mhQLoh9H4gF5IsFzeK
	 d6i2wAikUkTKx1KGM9g+GarQYdKC5aRqqQApkPV5CSp04fP3DPlnj5GLXmxj1fvZlh
	 Nzbmhy0IH3uEtmntl0IV8bUZar4RZEDMJX0tVWdSdQEmY05zOxpOE/R8W9UodTh6vj
	 ZHV8Zd1YU09diP73RtGs037LhZKyxN+bM+K6ZhXGMaXda74W7w/LzDoaocaOiAdpZ+
	 zLPVUrneVG5n+NRtKfzw97NLaGFPvqIozDM8YgtckRzoeAEhZuP82tD/3TsONw8Q2T
	 guKEISInb/uug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/9] perf config: Make perf_etc_perfconfig() never
 return NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-3-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:37:50 +0000
Message-Id: <20261004173750.780C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf_etc_perfconfig() returns what system_path() gives, and that
> allocates, so on failure every caller dereferenced NULL, the
> pre-existing ones in perf_config_set__init() and in the daemon
> included.  For the usual absolute ETC_PERFCONFIG system_path() just
> returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D2

