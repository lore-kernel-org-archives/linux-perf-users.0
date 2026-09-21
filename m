Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BA1A6834
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969766; cv=none; b=kxd+gHCi/gY1jxj9InTGLCzEN7yNFAkgPhYWvrTCAMUKylf1A+TfBq63IH/zW1tFwR1slaHpRTMxAcqhoDQ0r4jHyUDinnnKovDK8SJIRFdyN7qoPzoipOoZXBRLwupJP+fb23gwxE3HBV+nCQOCsMZ8NamfXxPO29FDvTQ/rzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969766; c=relaxed/simple;
	bh=B//6CZJjPew+Rswy5C86eOMUwNA03MjMKSPWKxvktWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VvAfYMqAJQPks2G6HBIG7dGAff29YE1PUxBRvK29GFMkZJWbsnv6peYUcarNmqjeoq64msiyecxuU6EQUNJEXTSG0duHZWvFcymfAtu6Z2Vt5nOE0OceTv3TvJqk5+DzEMBFnmWLLTRcFKzZQedVYgtdXSDdc3apfdT3uSULt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5yjD4Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5yjD4Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22AB1F000FF;
	Mon, 21 Sep 2026 05:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969765;
	bh=Eo+VtHUldWFuJZARf8TXavQvKKda13hD6C4MYOPQG0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5yjD4EsuvUYnEb+DY3u2r13b5otQfSYq5zVOFOzcANai64gJL32XbeOPwo/WbjOA
	 GrYIArXxoczWFMaNab79Ux4z2cCwPUhUG2aS+jMQMKQ9mBD43esWlIjLU3CzGXJGeh
	 hMxzmAmeaFySVwRzGAx7F6s3t+EJLgWK2nqiY887iLMn697t+zOAorIRQJK8pFbzUA
	 K1Fxw/otZZ46BcgjKeITDBPQVKJ/QNxgKTT/gugfKzMuUQMbV5dRBg/1XhdKeO8wPl
	 Ko2QGsnoRaCvKMlwhGdGmBKXqsvWQRHmLTCpG/WiQq37W1Rirr/maPMGW4XCIhK7CO
	 WrOPiaP38EQEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 43/49] perf python: Port export-to-postgresql to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6e68d6efbba372fd4795305900103eb1292d9f29.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <6e68d6efbba372fd4795305900103eb1292d9f29.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:49:24 +0000
Message-Id: <20260921054924.F22AB1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D43

