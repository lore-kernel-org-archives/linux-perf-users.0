Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA431D39A
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882796; cv=none; b=IdO1vpAdfR7RzKvNXWzTGT6KaxDbF0sSPkSHf5Yq1sLBdYNDoiMFEYwdhYaIFgYN5v0hKvNI/CreY0iKbsb/FeKyszj3dJC/SUCoaF9eYk3EiAbWpMPe3VE6fvdtoviY9H2EVUEtvqasmZT7v5Yu0FmHwgbCJ61LoVhKcnVyc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882796; c=relaxed/simple;
	bh=1l4oincJhjVK5uSwWcE5RdBvZWpOCI8MZXEI1SrWq24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9wrAn6LcDGvIoteZo6MTRIl2prvGCBMpXJ02NYgB++SdWtVJjbpPpdxY+yyfTS6LagDLMK+7z4KjSrf/qQI91QIpYi/nTaOhevsK0x9vqiWEzg38KNGsJouW6IGugxAgoUYOoxhJjNr+Sq9Bl9XJPRYKqUm5uXFzHMZvQIW//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg9EsNv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg9EsNv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EF11F00893;
	Sun, 20 Sep 2026 05:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882795;
	bh=WTi9eNbYNdPApWz5leNajKf6s4VtqG70zfRKPAtNdcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wg9EsNv6IqNlnBq/e1L61zztoJ0Rm9NiYdBpsNBVEYLJ4gNB12+QX+/E8MzHUj8Ow
	 JgZkpliObOpTv5d93xNQh+Ez/7D8tZWLlb5NIk5pEvEZQf6tbi7rbXB2xvnLDI+kiK
	 3TiaVAUCwvkgwER6tbTagKU6H0KdPCfpuWF45pZhVElT8pDybqfDbOpCnqeFyI6YqL
	 SU9gHVu4xwXFJzrfKePJfl59lttpSaRdHKIHQSUVWyZDjKcpXweaA/GF+4SGyioRfF
	 xyzu2FFROY054+rhBr7DUGJ78ngaAjeVpM/fgUjh1fzMroZM4yXgLd92euOJvF3/Kk
	 S/dNkRCp6E98Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 43/49] perf python: Port export-to-postgresql to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d224fcc5526d6d9fae07148aa73d0af524ce2372.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <d224fcc5526d6d9fae07148aa73d0af524ce2372.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:39:54 +0000
Message-Id: <20260920053955.35EF11F00893@smtp.kernel.org>
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
>   connect(), escaping single quotes and backslashes in connection
>   strings, and quoting SQL identifiers (quote_ident).
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D43

