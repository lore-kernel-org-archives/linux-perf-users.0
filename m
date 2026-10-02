Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E7476684
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937202; cv=none; b=m6G6mQrS79ysVzRBuKqjTpyTRqCY2AyQFLhsxQGIQtNypzn3yrELcJMhVsfh8gYKqKsdFzmjJvvGDoVt/FM3rh42fXMdPTKdg6XDTNNZdkJGNL/JOQEiv1qn2AqYkdSgmW97iRLWaPzCc3grRmwHsHMSxguWqckXL5uZgM1n+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937202; c=relaxed/simple;
	bh=nOAwEzCLozQI18GZA8gAXGUCTyPGVXCeFCM4JaWR+sM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNX9F3FVknDpjhkAK7iAb0p4RaezWocyiw5OHoxDSxd/0ftsIBlQcP2gLEa56u59iMs+vVlrhXt+iEx5etRRwvC6h9HWWMtJjpg3cOLKCcJ5laO6A/Te13+XLR823Vo1arJf3ddBkmV7Y7WQpAG4+vdsH8AS+JgEBB+NHG97cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxOw2njs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxOw2njs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0961F000FF;
	Fri,  2 Oct 2026 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937201;
	bh=FA0AtDDRKRceU42uhOwR3QVzeCdDg9v1wAhDR5XIbtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxOw2njsR1tT0SQ+0sC2ovMZV9GlaG1yDBx/L38Io0XodMAC6AzjtjvqAUlWJ2SRM
	 6lnPW4PD/oBiNgmdllcr+a3Ohb2Wlg2Yrgj1U7HRGn7gcNJEkTIcCwBKk5byz/ES22
	 zDojPU2+rnJyEo695HdxRTjrvEYbj9uerYhDRZ6oqwY+kdmXB34ozk9ey0lewAee47
	 08W5ecdpndGgijiccmLQlArIMi7ihEndmnlz2eDeOliLdxukyvNXYjFr2cZCshuA7e
	 Lj5Cg6YTTQpQ2NMKTtl/Ld0OcNVOFhpNvBwi1Es+UzIp4+F3xiOD02GVL2hR677SH/
	 EtUJZTEMlcDNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/9] perf config: Serialize config file access with a
 mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-6-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:33:20 +0000
Message-Id: <20261002103320.CC0961F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D5

