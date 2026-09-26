Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E593921DB
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404557; cv=none; b=VVGOWw4HjAwi8dnanB//Odim+W1lbCsN2qsQhOhNNVlc8+tL7zrt5D+m/FDAizXibn/PbtU1PpsNRXOj46Qd7zofantgbRvYVhat31ce4neToO9TMzUqNuCY+Kk+cKxBTB+sc3XILco3fd+6H/7L0B+IHE49d142MRrKKclB1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404557; c=relaxed/simple;
	bh=O34qrEwYZf4XSmT3obaUgvms6i4L1athiui16cB2ho8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFEoBv5BaTQUXOcqYml+8wxmsdsv7u/YN8jT7oIvhBg6/klIm0dKKJeKcHlmr+eZ9JhW1MoLTJbRbrZA1/mm7TkGtooG5wXt+lpYGRTr2wRTckW5cgFnoXwvMhhIvoW5VChHIyhB2n1/BMU2j7VsMHNs6NTnzUIolGsrtE50+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+WrW5B7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+WrW5B7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095651F000FF;
	Sat, 26 Sep 2026 06:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404556;
	bh=BUtdOmiV/ZdI6QH7/M9j8zZ1OSK8A5BEO1C95uX7izI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+WrW5B7W5k6hb279/exqyP5Bj6zM84OJ3hUGM9AqyBzlr0hz52Z2knICh7VSEaqD
	 rFdIAWeNQ0yqdGiP7NvR3dQVpaqYpyN1UVwQn4hS6lLycIr70u43U+/xr9EmciqTrm
	 jQmkuI6WGjgaIjqUjW1Md5ovvOGQPCjvwfeo/i0mjL0Rkfc+oYpKayTXlR4ETdz1eY
	 DofCF6PjaA5Ar+v1qc0AZn5DrjVgp4MVPWmVCinq/bmEs8hEld+LzUZvoF+kg8xe5N
	 d4V1Rv6Alxic9AobwtkJiT/Blnvf9iBqvLOWUYVtrqhg/AtoF7K1QDALfJmtxxD1TQ
	 C57Iri95JGbUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 40/49] perf python: Port intel-pt-events and libxed
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-41-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:35:55 +0000
Message-Id: <20260926063556.095651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port intel-pt-events.py and libxed.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor intel-pt-events.py into an IntelPTAnalyzer class with full
>   type annotations to encapsulate trace state and stashed output.
> - Configure instruction trace decoding directly via perf.session's
>   itrace option and context_switch callback.
> - Dynamically select 32-bit vs 64-bit disassembly mode in libxed.py
>   using session.is_64_bit and annotate instructions with source lines
>   via sample.srccode().
> - Rename methods in libxed.py to snake_case (instruction, set_mode,
>   disassemble_one) and remove Python 2 compatibility code.
>=20
> Add a shell test (test_intel_pt_events_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D40

