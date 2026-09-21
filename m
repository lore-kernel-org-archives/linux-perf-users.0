Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91423451CD
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968708; cv=none; b=Jjntc3VDTZ5hl8GjgdJpe/ABH+ikNgSCJcvABGGvoGv5M3LGGafHalthZzXNI+dctbcCJOkK+6g7IqJWsmlqu109HL1fy0jeUdU7//+65r47k2HZnOr1wSMSUksIR+SZN+X0wM+YJgrtdbX/0I5NGrcwu98p5XAH/c7gK+aqJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968708; c=relaxed/simple;
	bh=po7HR1qwnotkFVsn2w2P9fqSZNc1mNbOrJnTq6zG+Jc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cbVdi8ekG05i6k2v6rpA7405vpT2QVTFv5NTt595eUU9AhKKafzN/8aEBD3ewV2RwShMuzyIbuneIwtQrZKJGhlw73xAX6tPAFy13SiVlouwP/eMOrGCsbdvNMgmzK/CN5Ql0YAAShhKJuUqTpE9d9+iX3yiFS4Eni/DNAjx2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJVxyW6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJVxyW6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1ED1F000FF;
	Mon, 21 Sep 2026 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968707;
	bh=E3MB/D8ALQ2WBnl5P79RUA1lrEdp0TnQlC76NL6JYmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJVxyW6dGPddA1D8g2YAbjjg68jXL8HO2JBmAwipumasyew2VgmVLuZm/t7I65S7Q
	 v1IBX4jWdGXJFrQRkY8S+p91ZKVV+bslRxsCMLQ3TIMI9w6UBTvZeuiOlfbYgPyUos
	 H3KmFU5jx9RRowPFxYe0EB3479sQzqaQEgVYJRBWEFfHNbp2mfIj8TFxLDtykSY+k8
	 daxt0UM4bAd9DtYr/PpjEsJay97k3CRMUStQposh3a8LR3msXbTHvDoiicthwVy/1M
	 Ntr1fKP+59kxlmr0RI3+J6wK29qXXlacqReXmmNc6VRBOeH+fPvxZch/RQr3sLblT5
	 jrCk8Tn9IQSVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/49] perf python: Port flamegraph to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6a93df199d357d7dab2e6e061341dcea76ab6f25.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <6a93df199d357d7dab2e6e061341dcea76ab6f25.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:31:46 +0000
Message-Id: <20260921053147.4F1ED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port flamegraph.py to a standalone script in tools/perf/python/ that
> uses the perf module directly, avoiding intermediate dictionary
> allocations for event fields.
>=20
> Improvements compared to the legacy script:
> - Add Subresource Integrity (integrity=3D"sha256-..." and
>   crossorigin=3D"anonymous") attributes to external CDN stylesheet and
>   script tags in MINIMAL_HTML.
> - Upgrade CDN HTML template hash verification from weak MD5
>   (hashlib.md5) to cryptographic SHA-256 (hashlib.sha256).
> - Escape '<', '>', and '&' ('\u003c', '\u003e', '\u0026') in embedded
>   JSON payloads (stacks_json and options_json) to prevent HTML script
>   injection / XSS when rendering untrusted symbol or command names.
> - Skip invoking 'perf report --header-only' when the input is stdin
>   ('-'), a FIFO pipe, or a character device (S_ISFIFO / S_ISCHR) so
>   non-seekable streams do not hang or fail.
>=20
> Add a shell test (test_flamegraph_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D19

