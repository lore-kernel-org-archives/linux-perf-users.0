Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AE3264F5
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969587; cv=none; b=sCj6X6EylfglZUJZf25p4mzNEMj1mr4TPkkYVGNfnjsm6Kj8KBsc/XkJ9+TOk5RZ9gdirm+z/sABinvFgVaS/uiHSOi2raoHg7E6OubJwPpEIU7ZvEtEbedpFmorUqIYknIhwn7BKnpDCC15VbM9Vifw4iy5/7yQoUIJGqLJ6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969587; c=relaxed/simple;
	bh=KsMYJjLdipzGiFmCwfrhA5QED0X05jsHjCIEQW9JY4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JAtFTNK6qISOmbcT5wRV6EhpFH+ZdvsZUlnTAXkwzLNNgvLy9xIhlzklwZ8CpR1CsFehCNB/jkfRxpuRULx0C2brQhONyiKuMT2VZ6yJUgY9MHOySISz0n0Lym1dPd6RACy8Lrx3lTD52wLWIsRK3udCPxFICMSrhnS0XDXGdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvkBjIFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvkBjIFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789671F000FF;
	Mon, 21 Sep 2026 05:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969586;
	bh=eLEEf3j3mf5sKE1gbi6c4xN3dsY/pZYGcUCx6I4cs6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvkBjIFlCBi+T4DxTNjZJu2fL7rmC9dUuUjJDGDyfJL1oAuvq+Q4MTDWjo1zB7pbG
	 31juacDJ+/qACFfGEOvkceuLRmB4BotEplmJLQDSBSFj5FCoHNbG8Cn50dwjqU9exp
	 VVgxxA9xx7KG9mNS0+Fqa0k9yw6rHlaV/M0O56yyMYeVPrd1iSv4ewQNnxlCKGnQT2
	 oWRtQPxmlnWS41caXtxeeQSbkKRf3Le/Big2y5s7H6qOaD0WaJRuzp+aMt3vHzmABJ
	 ZED9+gnDltL2huUywuIXpzzsU/cRLfX/SN3b2G++3hoCYbzsTNd+0PGqhh2C0n80Wm
	 mebSUoyy+5DHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 42/49] perf python: Port export-to-sqlite to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4f2c5cca88d7da4b79232763285710fdd8ccb8ea.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <4f2c5cca88d7da4b79232763285710fdd8ccb8ea.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:46:26 +0000
Message-Id: <20260921054626.789671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port export-to-sqlite.py to a standalone script in tools/perf/python/
> using the perf module and Python's standard library sqlite3 module.
>=20
> Improvements compared to the legacy script:
> - Remove the dependency on PySide/QtSql by using Python's built-in
>   sqlite3 module in DatabaseExporter, allowing SQLite export on headless
>   and minimal systems without Qt installed.
> - Support Intel PT and hardware instruction trace export via
>   perf.session(itrace=3D...) and perf.call_return callbacks, reconstructi=
ng
>   relational call_paths and calls tables and decoding synthesized PT
>   payloads (ptwrite, cbr, mwait, pwre, exstop, pwrx).
> - Export context_switches via perf.session's context_switch callback
>   and map thread and comm IDs to their relational database keys.
> - Manage temporary staging files inside an isolated tempfile.mkdtemp()
>   directory with guaranteed cleanup in a finally block.
>=20
> Update Documentation/db-export.txt and add a shell test
> (test_export_to_sqlite_python.sh) to verify the standalone exporter.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D42

