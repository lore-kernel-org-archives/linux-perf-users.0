Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011272DC79F
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404640; cv=none; b=QmND90IxcESKjo/8KLyAV90V+bVeYwhmrnyeDcNzbW+8HtNRTbO6zKe2BvUUilD+OF9Ea49NwAYRQu6+DD1hUu0RWihP2ZgvApHRGZDi3YCTmS/TXVhXzoFaquZSrKWvA5b6DVUWrYiKW2R8pxWO9kIHFCOen19lNc/biHw40fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404640; c=relaxed/simple;
	bh=Zm0XaLhGxA2OehO7OQLVYEEt888sAHoFXRNh8kZpaPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TwBcf9H497YBHMqegkAvr679RNxy1kv5uwJNWaCBn4Dov1XtS0N4KVS5S7N4Cn7E5ICZnkmXZP+GczyDRjpDHq6RX80zy8dSptFGTB5xCtPGIrbB99T3hG9zA/NMjMX52v3eFztKs75LHFFN5KmGFlJSXxH59T8sHrtwoWV0soE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv3wZDnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv3wZDnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7CC1F00893;
	Sat, 26 Sep 2026 06:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404638;
	bh=3C9zjeEapZ9NgOuF30kcuvVEzxpNAd8kyr1xzpSmKJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fv3wZDnbHEHGwRITwEpFqnr6wxuq0EYFJhOKjCK3gK7aCjRODR/mQGDz2tm+wwG8a
	 epn4Jh5qHfrGFNC7s2v0jIPjetAXzoUV+w/2daYXbADyB5QAr4wBth29JPJV02eocB
	 2pwVPStg1xgITMLCtz++XrInvV9Pk7dmbjnlvU81uQESz0f0beY/QLkJVbS9lQyXTd
	 ytNZ6wMf9YDxD5motGrIH1qMeSv/7gj+FrXvG1OgtlKhGFYOONhKYL6c8Q60RBlKF3
	 mVsqfD4RTU2Kd3AMXskuDzdCm9sy8FXOK99PT5UwFNYFtbqIfuiuotRxtd3YlgYcRO
	 sfo26RPoPXFKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 43/49] perf python: Port export-to-postgresql to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-44-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-44-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:37:18 +0000
Message-Id: <20260926063718.8B7CC1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D43

