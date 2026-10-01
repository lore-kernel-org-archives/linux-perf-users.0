Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B43BB671
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822348; cv=none; b=nJYU7FDRxV/6PJoDzA/BteZA1yJtoTaj7K67Pi+03sWl3TE6eYbQgtJgIp/PabM/E8ZIsaWmo01THxEW8MXdJ5UEHCzi2uSlDSVjs+Vud2BAeaHZubd4/hLKl3EuzSKgEepa0f6B/uzWGmftHeGzSl9tTHSXLciAqV/8mMQ61XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822348; c=relaxed/simple;
	bh=F/c/wsKV94MMaZ+HjsSeQ63tPNdxr2rnCnQccSumzQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGsEVe2MXw4dYxI3UqtrHiUhWIBUDNGksRq6ZiIkiHeoTV9QHwrbrZ3Pz26kTWKBe8ArXbtSC2s7UKY1ywNuyS7CqYAG7onbEj8Ob2NWd/Y7iWwbIW1jQZrr561u3iXjgwsLE1QsLlDViz//Nz+QdAfd5luWoMIQ5JnePCHXPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSF7xS6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSF7xS6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA021F000FF;
	Thu,  1 Oct 2026 02:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790822346;
	bh=F/c/wsKV94MMaZ+HjsSeQ63tPNdxr2rnCnQccSumzQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSF7xS6xC8fVpZ8seeAtXd9kDqBi7a3SJ2p1seFRf0juA0eySddsyK13M56SH1YfE
	 e7jKSgzY6Yjo7b5PHtiT+IobF3/rHLO9E4hNRWDwAH0MDOrOduqyW7DXF+pZDlS1r8
	 DcvDeVHNesucQGMCKnBnR1Crgi23HLydg5K0w9Jtn742GK1Z5P2EMCuBcsD7bmbnXB
	 Sas9av9eM51vnfOv8bF0dk4JOS3IcYiDLhkowu81T/dbQNc2vyT0QRTv5i8LGOvrkV
	 NV2FDJS6rL45RL3fuSZcg5PTubjx46y4LyDbD0jMRQKuHRKtUkTZQ3EfoUV7c+Jqyn
	 /IApAA123e1zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf build: Run shellcheck, mypy, and remaining
 pylint checks in parallel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001023423.1225713-3-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001023423.1225713-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 02:39:06 +0000
Message-Id: <20261001023906.BAA021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Following the approach used for pylint on standalone scripts and tests,
> move the shellcheck and mypy checks in tools/perf/Build and
> tools/perf/tests/Build, as well as the mypy and pylint checks in
> tools/perf/util/Build and tools/perf/pmu-events/Build, into dedicated
> phony targets invoked as top-level sub-makes from Makefile.perf.
>=20
> Also add 'perf' to pylint's --ignored-modules (leaving perf module
> type-checking to mypy via perf.pyi), since astroid's ImportlibFinder
> only resolves .pyi stubs for package directories (__init__.pyi) rather
> than single-file stubs like perf.pyi and does not introspect C
> extensions by default. This removes the need for pylint to wait on
> building $(LANG_BINDINGS).
>=20
> This avoids blocking jevents code generation, archive creation
> (libperf-util.a, libperf-test.a, libpmu-events.a), and final linking of
> the perf binary and Python extension on linter execution.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001023423.1225=
713-1-irogers@google.com?part=3D2

