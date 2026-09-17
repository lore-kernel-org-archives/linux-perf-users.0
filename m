Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A974E9C20
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664007; cv=none; b=A7Qx4S7E4ljgPGJQ/6WCNsesVWPTarvxec9bQAbWeZCYFXWSiyk5NIYqu8k5C4++nPYzHLmFOeR4eURIiqGaw384/R04DHqDvqdP3FVVJsc+EW1a8Ze0SpghCtastNMnpdrnRhx2GLZRGDxoS/limufrNAWo1bx4uM43PGv8A08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664007; c=relaxed/simple;
	bh=0OE01QFIPtDEW7AQfRzFuOIAt1LtfdMxzXKJMNqkg/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ck/U8d9oe+FUuOL0oyIy2jmqE5z5oCouBYWrBYb5u246SOm27gw1hDtKZdADj+x8TXsr1u2aX1AlaE4a98OII913xlBjtK06Vtr21x09NwRDYMEYltz2CVDI7jcyVtNEQyDmlpTbVwUXZXEn5QKH/7iciR63kW70YREfdqgjkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UASUpR8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UASUpR8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1BF1F00893;
	Thu, 17 Sep 2026 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664005;
	bh=0OE01QFIPtDEW7AQfRzFuOIAt1LtfdMxzXKJMNqkg/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UASUpR8OD3ZBMZjMFilYu1Fi3GdKi9Ep/b0vGK97c5QCHblolo2U6w8uBv28ttEIO
	 edRypqqWRQ+cESsSycf4TsbtGiN/RFji3e/CLHjOHl2nFKv5SCzFkNHV88e3qkFH5w
	 ijzVI8Qu/x5aA7716ASMdD6FuSddyVoBePmqDiY4m65rZSX9geNSbbkE0CwJURp3EN
	 HHLSbruV206LilEVinXzj5xdlXYuk61DWSPKZr2/koiReIBIzw52p9d1hNsq6xdhg4
	 5V6j4UohyXrNaLKafy4KnTzK4hVTBsiltn5ILkL2lk2S97bRufa1MDcyqs3HEH9sgI
	 +iNrxBgawGtzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] perf test common: Do not globally disable
 tracing events in clear_all_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <e2ea8c6dfff43fcaba7e6b1135cfdb6ba65b9bd8.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <e2ea8c6dfff43fcaba7e6b1135cfdb6ba65b9bd8.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:53:24 +0000
Message-Id: <20260917165325.9F1BF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> `echo 0 > /sys/kernel/debug/tracing/events/enable` disables tracepoint
> events system-wide. When running tests in parallel, this kills active
> tracing and recording sessions in concurrent tests (such as perf trace
> and perf record).
>=20
> Remove the global event disable from clear_all_probes().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D8

