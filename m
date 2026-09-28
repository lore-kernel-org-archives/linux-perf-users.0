Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC304EF144
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613601; cv=none; b=sVFKQNW8UbVN69Wjw+JRx2VYojooqwVaROB5J9xO000ODEHAiCp/pP6cuN5ky2jXe/0zSdtPZCeBE2DLR/sYKc85RDdrLmB2Yi2gxXg3JdEdRDKjGzrWCbyoS1nur0EK8erb5NBCMNnWK9cKm7eg2LYg7ZPCNG7eDoPyonsEtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613601; c=relaxed/simple;
	bh=hNMwAdN2vjDmvARvcZfCR6peO2XlKtq79qowUcFrcFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/XnD9Y1G/uKLnvhHtZo8Mwx9FSplzEat7Hb05EU1WqnqgiF61uiPGvb+33YZuF6BkjKx+n3y3JXhJ0ekUcxUeT25g3eGtmVyqfP1kYh2GXZatRotMqOi6XsgB5RG8TY067VUVeJJ8SegaF7AO3ehhzhKptc1EI4aVKCbXg6qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsM/sJCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsM/sJCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BF11F00899;
	Mon, 28 Sep 2026 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613599;
	bh=hNMwAdN2vjDmvARvcZfCR6peO2XlKtq79qowUcFrcFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsM/sJCucbXhMcHFVcR5Qpt/vOjCcCSFrWd9vO981UAWR1+xGT351w8gRNDNTzVOO
	 +OuJ4aleyA25Ac8J8tPkqJK3/9MAiHZvLOtDg71FJ8oUZtj++vjpDmSDKPnbbSbrLb
	 IBxKiW17UZi/ZSoq6kBm2lOBRsjUap41QJ4J3CpCaXWbGABM54yCLZj4q5e/73+WbL
	 gmw6KNeDfSboBpveicssyUxkWeF5/d7szLmhU9RDzVdggCnti0+Rr8tiLmolUayYJJ
	 iZgiK9FxyhtwG1NdGY8tq0o+swQcpcMoJrLBbTnHdHmMUHZxHKI5SzmEdiUcowdioc
	 I7EckAkYiQtdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf build: Clean libperf-gtk.so in 'make clean'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928163649.3463451-1-irogers@google.com>
References: <20260928163649.3463451-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:39:58 +0000
Message-Id: <20260928163959.48BF11F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When GTK support was made opt-in (first via GTK2=3D1 and recently ported
> to GTK4=3D1), $(OUTPUT)libperf-gtk.so is only added to ALL_PROGRAMS when
> GTK4 is defined. As a result, running 'make clean' without GTK4=3D1 does
> not remove $(OUTPUT)libperf-gtk.so.
>=20
> Add $(OUTPUT)libperf-gtk.so explicitly to the core-progs clean list so
> it is always removed by 'make clean'.
>=20
> Fixes: 4751bddd3f983af2 ("perf tools: Make GTK2 support opt-in")
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/linux-perf-users/CAP-5=3DfV6+mzN3Lf_mCAJ4=
aP42JFZsF55ekvt8XrX505xOWwrmA@mail.gmail.com/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928163649.3463=
451-1-irogers@google.com?part=3D1

