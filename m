Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7F3B27C9
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109917; cv=none; b=Tshd+/CPhwMJRrZN2IFbq4Z5Jc6YMN6ktb87Ot6pgDPUBkHZIeFrWKSqAq/35bikJ/Nots1G9gX1OuvI9/D4R6obkV7+6/AwDpUfa9sCvu6sUgjM04ahb6vH1ZzR+Ch7HsA1QFLh6yOEIqsiSJGwSLGtNorsPj/e/KRKAKYYkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109917; c=relaxed/simple;
	bh=1xsKpzBVXLXdGKFzhlY8RYvWafWlCeAfU8sEvbMCp6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u5gSgQ4B5v6R3c2cd1LKwslx5onliwpWlDLDK54blJ7ZrC+KBhYQ81oJIkKF3h+dz26tpOZx6tNXPHrIC/8IYjhEQ2EPgV94TLvYED8QTDiLyGCZ6/lvE4gYrlFLNzY/uUIds3y4lLzQNzfxbrMU4rg6jfIKw2ZQpmCQ+qGbJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPCs/hVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPCs/hVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5CA1F000FF;
	Sun,  4 Oct 2026 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109916;
	bh=uRWM5FxXwCF06dTkvS35N8PB9JdjyytNEkeMl5Ce1mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPCs/hVz5GLXLJDRJXu852LPiKaU4e/vJfVjh+TRWCbwHUQY3xmcMejCgFZC4N9AX
	 4IPKOS8Q/HP+eC8eXKvn6b4GwtCJYAhZKoz5sDgpgUHYPe3UICGyKzLl6BpjW4hthS
	 Xf3CehwO/M9xtqe9X/GhCxbH/kfyzhrsupEfij+iSgy8eU4ESDqmk+TusHQre7jf65
	 R1jbOMEcgg8oeKjrxwpDGjXkY5IhYwGvE7112NuBny8JDS/umxaidUydaa2Ay+Jnoc
	 C3GN5bACjjlnGacVRvk92IRhecpUX3qBVkS4ETDOMj//WlDzjwKI+EG5ZKtMUNfs59
	 Qtxm6vWanuFAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/9] perf config: Serialize config file access with
 a mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-6-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:31:55 +0000
Message-Id: <20261004103156.4D5CA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Config file access shares the static parser state and, since
> perf_config__set_variable() became an entry point for background
> features, can run on more than one thread: a feature writing the
> config while perf top's display thread reads it.  Serialize parsing
> and rewriting with config_mutex and the whole read-modify-write of
> perf_config__set_variable() with config_update_mutex; config_set_mutex
> comes before it, as building the set parses the config files.
>=20
> perf has its own mutex type, util/mutex.h; the file scope mutexes
> here use the DEFINE_MUTEX() static initializer added in the previous
> patch.  The two lazy inits that system_path() and home_perfconfig()
> do would leak all but one of the strings racing on two threads, so
> they move to DO_ONCE(), added in the previous patch as well.
> bad_config() runs on the dispatching thread, outside config_mutex, so
> it stops reading config_file_name, which the parsing thread owns.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D5

