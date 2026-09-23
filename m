Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE38337F31F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189256; cv=none; b=PBOKRk0MLj7T3AJhjEmoLz5gaF8000TfkczQqDmDerkTjRfUZ01XejR8Heqwc6SuXrtARqNRE5Xe8461cJ8lYoB264iPjG9kChPaFQ+jhZKhJRVov36MqKoxBcAZKAmAU/zdOdA9VzdYb/BFXBmDDUwjPhyTPEEUHiTa1PvUl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189256; c=relaxed/simple;
	bh=We+a//ulSHRLTJtZBJspYMH3YaJGxcTok+BTlU6Wp4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1TyOTEO4mBpIlSp6JRzSJkd8CxRhlg4UOpCTb3G1oLYyvk9RZ4r8M2PPbij8hqnGhJ5oX6kVFVM+wn9Dgg65d7l3WVEUePpxP6Tw1YC2bF3DDqXJtI5JtC+30yN5St+Njz4DGYEr7VjUNc1t6JUQRJmutxvG2tHREV9tIAXdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USqIMXvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USqIMXvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6511F000FF;
	Wed, 23 Sep 2026 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189246;
	bh=FmqwGiiA0nMOlp0Fe92Huy9MOJX0K0CfoWLMkO2ltMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USqIMXvGy8CQZBKm2I/TQd5W/4SWOH4FEmbD4cKwmYEDIEb/m+rkIGOfDMEwxtXEZ
	 hNBwWsOO1ksPcIBWr21OImIO91if9+Rv0ts4Pi1HVqH86UJjN0RXwIFL+PRhNXx7Ai
	 2A48obWw0BrJAOQHsHhKJF+NWcuoyRsXhIzYsipW4TU4Fu0Wzy/HUnWuueUbHv4MZf
	 aDMWuBofSuA8ND7Bvuobi+vqxIkno8k36wDswGGIv7Jg4qLV1W8bSSofILiIaPZQAT
	 4vcyukyz1CiNNr4KwRGE0C21jISVBZRQKOf24Jkq9sweHyr+pXwKLC5VYtgJ7OW2QX
	 EVCIvS2rK5/UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 43/49] perf python: Port export-to-postgresql to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-44-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-44-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:47:26 +0000
Message-Id: <20260923184726.BA6511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port export-to-postgresql.py to a standalone script in
> tools/perf/python/ using the perf module and libpq via ctypes.
>=20
> Improvements compared to the legacy script:
> - Remove the dependency on PySide/QtSql for database creation and DDL
>   execution by driving libpq directly via ctypes (PQconnectdb, PQexec,
>   PQputCopyData, PQputCopyEnd) and streaming binary PostgreSQL COPY
>   files in PostgresExporter, enabling export on headless servers without
>   Qt installed.
> - Harden database connection and SQL identifier handling by rejecting
>   URI ('://') and connection-parameter ('=3D') injection strings in
>   setup_db() and connect(), escaping single quotes and backslashes in
>   connection strings, and quoting SQL identifiers (quote_ident).
> - Support Intel PT and instruction trace export via
>   perf.session(itrace=3D...) and perf.call_return callbacks, reconstructi=
ng
>   relational call_paths and calls tables (including id=3D0 placeholder
>   rows and callfk/returnfk foreign keys) and unpacking synthesized PT
>   payloads (ptwrite, cbr, mwait, pwre, exstop, pwrx).
> - Use a dedicated context_switch ID counter so context-switch exports
>   do not advance sample database IDs out of sync with call_return
>   references.
>=20
> Update Documentation/db-export.txt and add a shell test
> (test_export_to_postgresql_python.sh) to verify the standalone exporter.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D43

