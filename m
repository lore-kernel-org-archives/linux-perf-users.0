Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBD246778
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135609; cv=none; b=UYDXTfVuNPnnniN/J+MTFUNoAt5a+ouXWSe6ODQH49njm+Z3fXX61FSxgcS84h8Y9OnEqnHRE1Fly5DVJI7wcgP5oL6s5j7D4/Fohjc15k7nkY6+cIK/saE++NUJbqXIPuEwpmCsuzUeqSYs//SqSQRo3RPVpm/PaaJ+NWVrSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135609; c=relaxed/simple;
	bh=MjrYqUQ2E0JVIteGP5NhkGBTK1Hr8xRLPochEEeqjqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DIPoO2iqGQHBeWpz/Y3FDzWCfWTwkZZ6Kss3oGHUAWqpnvw5oMdr6XpMjXkq5FLefQ0X8X+HYt0bMM1Vr55fHgJGQWK97sd++WoGueSfSpdJ5bXiR7ias0P5t46VRwuisOWptaCu8safo/1HXhfx0pxMefdsMFDrnkO806V6uEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8QbFoBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8QbFoBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECB1F000FF;
	Sun,  4 Oct 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135608;
	bh=Is/Dq5HG70s3TFu5LIi3IfEz/0c7RRbtNvj7wSe6BY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8QbFoBCDINb3VpzPw3ksHGKoBWQT53PGvzHOzitv9M+1iaopcu9jjwzX9TWh6iO7
	 9s+IypX3X1l57s7P4q1UXqngFhgw1S+hcZJMbJvvWIG737D/stvVXub26ACKk0JCky
	 ndkIv3IqGZlHnMHLE3clRMd1nQlFQHcjGB5z5FLezb0WUIB/KA7Yz16P6LWt3fHERp
	 g6tAgWqF+tVYFazTxIEtz76WY6+bX/xEignkqVnEBAQp1Ib58FWtXVgt/LBC2xp8HI
	 DD7AutjnPmW3WK7xb5Os/LxtpqeM+NLfjbYI4mHJ6U/RIO0YJULOHw4VpX6qHPY7dd
	 1yOdJnlG/93BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/9] perf config: Serialize config file access with
 a mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-6-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:40:07 +0000
Message-Id: <20261004174008.4DECB1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D5

