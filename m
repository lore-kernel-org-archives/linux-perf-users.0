Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C9389118
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404220; cv=none; b=q7HmCCQ4vVcEQb4Uxac5oVXKbCWkxNqnbTVM2UIqM4syoCS8ifCW7uiiI48nDHMy5+vm5+eSq+J8xb6MUiwLPXEc9WRrzs0x+QoY07+EVNrT15q7syXQa/n7uOj2181tDDrQVSB4aFvz/FetnJMR3FgoIyoe7ZrGOgP401wrlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404220; c=relaxed/simple;
	bh=slLJXtNhYz7N7+4NTZaceh77/CrTs7wD161+yDb9V38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QUWTAYtUCGnscVP3lUv1qhBjV+Y3E6FqQqo0ycs2VcUAtAmgZWyteOxeIrwJYzp7KEKGJZFra2Beaf9m/oSK1DUtIPMZYeRPlw/0XI0SHVaWJCEjms/MqfiRhz7/Xd97qGKJgkskahZR+nuf1n8KOvn0I3kwEziDVLXyVf10GzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXu3/HrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXu3/HrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A91F000FF;
	Sat, 26 Sep 2026 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404219;
	bh=MgNFECviDZkz6Qq8oOMa8URMnUOau4QqZUCXo/i4E8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXu3/HrMC3klXoSqCE/mmD+0/ed+pXWyx7/P3Pa9YTWtUetQEfDnnTIYgY5FLb1Bn
	 VhW9PALQAcu0eWs7KkXQxfB4jktycOQO5r/y5iSa3tAQUIEwTrnsyP279N1LUVzhJi
	 RCvjLS5ot0ruv7NvqVBLNCIAtUxCgDuHt16DnqZC/pm0qXw5xig76R7CI+TSQSp1c5
	 DFZbEI7ccnwHd+7y1WcBq9FCZ25e8wVpKKpzu03Y/H4XtXbtQF9oNThXUmIXTO8tCC
	 yVOt0ItHh3/n8GoaDdv6N8ekqEoOCNGtFqPMchxxr2as1IJPOzPRDa8HHlRT8L1JlP
	 hBEDGvaumLJ5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/49] perf python: Clean up pylint warnings in
 treport.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-5-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:30:19 +0000
Message-Id: <20260926063019.822A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in treport.py so that it passes pylint without
> warning suppression comments:
> - Replace broad 'except Exception:' clauses (W0718:
>   broad-exception-caught) with specific exception tuples.
> - Pass both pid and sample_tid to session.find_thread() so guest and
>   process threads are resolved accurately.
> - Rename parameter 'args' to 'pos_args' in FlameGraph.__init__() to
>   avoid shadowing the outer scope variable 'args' (W0621:
>   redefined-outer-name).
> - Clear session =3D None in a finally block after session.process_events()
>   to break the C perf_session reference cycle before launching the TUI.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D4

