Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467935F5E1
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404137; cv=none; b=vF/sRrcTUb6YJ0evcpueQm4rU4TZlaOnjmtiVjqWncDdcHWG7LhaPXrTsWw8T6IGkM5h+eTdfZUhVKr90r6bU0QGgQOyRYupBS6lQ1ZfbyeR9ggVbGMpAX4Y+ftMQwP3rskglu5XL18aiztN8M8uttvgSq6+NGCsOwJyiTKjrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404137; c=relaxed/simple;
	bh=UvFx9jywOtc+3G/RLvjyBHQohQ0eNK0/RIsO4Xri+Yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3jl7Bl/gGKzVldpvHY/zbHnpxPK+LRI5bd2m/6+gkW793AYbhO4ZoJGUahaAmavJ/kEEEkqA9TBagZATAkuRLJJEtNeBptEMDcdOHbPtaGqDEYt1snmSH/2Fp2ipRyu2pm057iSCrtAcFVR5z5rGQRZStAnwDwRVm2jxCVGSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjafmOqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjafmOqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F981F000FF;
	Sat, 26 Sep 2026 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404135;
	bh=UvFx9jywOtc+3G/RLvjyBHQohQ0eNK0/RIsO4Xri+Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjafmOqEJbfseoU0HoIlPMCMfpIONrAVXQeFLjQm0AJK6zHhYaIhi5q407X9ZePj8
	 FDUIw5T1XwznXS34GLKG6eZkfQ4FZc9XqbFW+6shf0ObSN2Nn0Kk+f4pZVP9ytpt1M
	 iaq1/8S8vUYXjJxdhNPtYfhdU9Km9jdL1s8MSDqDS5/w4BdjjvVyvx9f21VkBVKHe8
	 JmP1j1cQg8whwqpJzwiRgptMhDRLs380heSElAM7KS1YtfTtBZvv4qIwR44myGbqG1
	 899emwcbh9ZLItZ6ZLG8Ebwgn+tWoWhWiCCWJ/SmNjF5WMo+D5Hs3Ig4svcGODkHM+
	 aaEPVWLzDPP6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/49] perf Makefile: Install standalone Python
 scripts during transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-16-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:28:55 +0000
Message-Id: <20260926062855.86F981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Install the newly ported standalone Python scripts (python/*.py), type
> stubs (python/perf.pyi), and compiled perf Python extension module
> (python/perf*.so, when built) into $(perfexec_instdir_SQ)/python
> alongside the legacy scripts during the transition phase so that newly
> ported scripts can import perf directly from the installation directory
> before legacy support is removed.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D15

