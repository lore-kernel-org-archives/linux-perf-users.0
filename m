Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90352843C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188566; cv=none; b=Nh1cdvwgP6/dHHtJGuVyTRQ0zEJj0FqvhomKXzfVA8Chl+IU8uHtBi4IUKHNS4fMcaTAgNA1mP/rcpB+IJQM26C+TMDCCd9hdbCS5F8Mq6qPGxxNy8KKbMPwPN0StGTLvJoa2pg6R2uxa7VovYA3m0DJk/vnAVrxj5f6g28EGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188566; c=relaxed/simple;
	bh=hhxhJevG0uO4jqyky5Q72EEGoaNWHsa/YSQP+YY5mYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJ3zmJ8hm+VT1KeWh9vSHvkUzlwCX8iQo59LvQR9+IfZfCQtHhcPf6c9uqUk6Sc6OpZB2/nUuqKUV2n0jCeBoRnh6CiJfV0epCcaM3L1sf8coC46Z+DdaNSU75LSA9j53c4j7rvPebnQjsVj3fWZzbbCeRHuJBFOrAqqcbpYWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH62y4Xg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH62y4Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D1F1F00893;
	Wed, 23 Sep 2026 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188556;
	bh=3qA3TNzXM1K1KJmU3fJKT6hocata0RZUXVfrDLq1tAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IH62y4XgT1N7083zXQ0S7FG90tLvKcjvk6T0l1RerHdc7v9QBNVdS51w5N6gqscpN
	 4vC+Eyy3hnr1/BVRP0rxorJXneviIFgLnhBXoEwumNyGJBrV5g/8AwE7qHJlgonEzR
	 YR7b0ZTaLxbEVw7ecDOMTUttsuqvf74X36on4DBJMldStmGqz3fdUIj/ujFGR3KUu4
	 nU6Jk0tK/ik7CfxFocmZbWOwg/xJs05eEHMwEQIOwn2TWsu/r23lq3DV1kIz7wogc6
	 BP+qVpOJvtxHoG9m85GwU1PYY7YSWU4SXLbblOmzOMc9B7emxRHrJ1dZOTZOuCwlem
	 crNDCSOSF5pUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 32/49] perf python: Port sched-migration and SchedGui
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-33-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:35:55 +0000
Message-Id: <20260923183555.F2D1F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port sched-migration.py and SchedGui.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor sched-migration.py into a SchedMigrationAnalyzer class using
>   perf.session for event processing and add argparse CLI support
>   (-i/--input, -v/--verbose, --gui, --no-gui).
> - Port SchedGui.py to tools/perf/python/ as a local module dependency.
> - Load wxPython dynamically via importlib only when GUI mode (--gui) is
>   requested so text-mode analysis, testing on headless systems, and
>   static analysis (mypy/pylint) succeed without wx installed.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_sched_migration_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D32

