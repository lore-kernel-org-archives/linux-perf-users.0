Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594532EEE67
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969699; cv=none; b=A0ATWl8a8QWHUVfmk0Hfw6/iosjRUx+bmfCehZ9JRC1YGtbhbiVqNCmQDrT4XaSkrVN8HI5nToUST8ofGCBOiRLNluVyTX5Cxk5t8BSXbz7OK26UyLzX4CN0LZ3tjTtYTKZe3jVT/Ivjj3uUKEcY1s49cfdmhaaN9inctE0Lk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969699; c=relaxed/simple;
	bh=RMVckt7+0SB1D0jqza+5m2hK8KG9v/5OFrtpkkIgBN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxE+xouWTU9Gn1wul16cALCBCoGms6pTqThduSm44lb1S8hz4WwWg7I/3dF4XgsQ++DjZJ1QUj5d6je/F35YRuc61r4usfq1z8Wf3TZsPoxChJBBJpXYlRd0oSKAYoTMC7s/jruWnwJ17o16/0kmMWgDmQ+/QZo0C6rVjgr3gTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3CrV1qn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3CrV1qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195F31F000FF;
	Mon, 21 Sep 2026 05:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969698;
	bh=LF57Kg8PWqB2EjZyBVWg5A4YI1P/Mn2ypDqOfEcllhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3CrV1qnV1mp0PGeMheQyACex70L5jxraXHFRvVRUgvQpvtWSbhKxEcGLnuXp1NFD
	 R077KxKb0EMRrRattUuIZeXPKsHKTpKVnguh5614OyJfjBpkkltUEbnlY5Ch7sZML1
	 jemlHPDcFsqSaQBFg6HZyrwG/fp8ERJmvKOmh8I3VgfLLerLsrEQlafTPkFpTT5MKT
	 0eIWYVuUD+1q9ZoI0rOeHp5M2mukJgYb+vWblg+Yrj0c/WjWggnSvChij0Kz+FABUD
	 kFkl2kLZef8DT6Ev7HQ0m2XdIWEg4c6LP6uFRyRTTAqD4ChwNJRXY+bwzHNqtawY9B
	 TWIzgRf/joGSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:48:17 +0000
Message-Id: <20260921054818.195F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port arm-cs-trace-disasm.py to a standalone script in tools/perf/python/
> using the perf module directly.
>=20
> Improvements compared to the legacy script:
> - Encapsulate trace disassembly state in a TraceDisasm class
> - Automatically search standard kernel debug paths (find_vmlinux())
>   when -k/--vmlinux is not specified, and query
>   perf.config_get("annotate.objdump") for the default objdump binary.
> - Bound DISASM_CACHE memory consumption by evicting the cache at 1024
>   entries and skipping caching of oversized (> 512 lines) objdump
>   outputs.
> - Use sample.srccode() from the perf extension module to annotate
>   disassembly output with source filenames, line numbers, and source
>   lines.
>=20
> Update the ARM CoreSight disassembly shell test
> (test_arm_coresight_disasm.sh) to invoke the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D38

