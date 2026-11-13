Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583444;
	b=WQmSJLkcLxY/R9eZA4ZQxqKA2xA0WjSeFpv9317vPsfK/LF5FbDr43KpvKkhowoIUSHL
	 SwkPiEvYWIdIuMQa4Y+E1UPobv96VbI/DSRAVmC28rnBbhNQH4WiqlkOfLRI+5SmRibN+
	 c16z13QSSdhL+7SHQ0yu+pUkcd8mxVPZOAYXEloZTdSsljXexsi9da8AMeWlT8qGol1w2
	 nAovLL7d7++CVCTFXQZBXFXuo92Vuve9Y39mE4uJPQ7VKUlV6pR8BuF51gKyvb1LZPCa5
	 FIL/3VUDpFgKLzmdW70dujajQ/gZvpBWBkGEnHurqmee5or4hw4jBLaUchSblDPj2YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FLPcBLPab19O7unbB2ofTytG6XM/XVPpZr7w0okOf+Q=;
	b=IWDYvTK/dVRLnuPSadl7MnGeF/bR796ad0ObhecJAwIElAjaRwZOBt+uhVJbFoqvxRXm
	 VUVHnFn7YhGWMtZhcJ8KrSNvakaFPRljjCG68ZApHldVhzNeOAiokW8QpJWEoJ2gi1o3C
	 YM7FCZF40oBi4L2hpaRMuoPBEZmIznnq9ki7s1s9Qw5lr7HkuGzpe05fYYlC+rF/ShaRk
	 C0IGVrfSgsqx+1kpoh1jxn5KUwDNx8qDJ+wr/0fB8o9zpopL7jmKdma2hNiQQaoVvUYUx
	 KcAfBUHgOE/IGwj/pjzflag9kqQwDXeeihlztRNiDHbnngAv+E0vH5YhXDftdALm+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYs9Pm9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F05606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYs9Pm9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E41F000C4;
	Fri, 13 Nov 2026 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583443;
	bh=FLPcBLPab19O7unbB2ofTytG6XM/XVPpZr7w0okOf+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYs9Pm9uJWbOsfJuLDQdAUL+hEKRVq4EHqRIobXK2UBacsieGq+GCw22KTibU7d0R
	 N5yjZzz2ZMVfg1Lpd27yehcQTZslVPMEq55xbNW1eqtDuDukFcTgEzxBVv5G5Cn5XJ
	 r+tmIQlo5dLp6C/XncS6d/lr1XwEV5kixY8ujvxvIYkMel8IOmvVQ+Rz70DTTvIm9u
	 d0XsxWbMlA5QDYKvFhUwmxU5igagjuWtjBXuMEJh8sgM9rWQybzSjj5sg5I7+eHpmZ
	 /Kgi5STVWafmGhgnFzhx/fGTLy+Jk7HWCmMO32vdPn/7xN/G4SSHd0s3g9AflBXuq0
	 wuqaHnA9f+DHQ==
Message-ID: <sashiko-outbox-213083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/12] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-7-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:24:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf test: missing DWARF feature check in annotate_stats.sh
  without libdw
--

commit a3aa8082d0e5c5ce9cb6c085dad08c8447fc23aa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate: Print the stats after the annotations

This commit moves the printing of data type and instruction stats in
perf annotate to after the annotation loops and adds a shell test for
instruction stats.

> diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/=
shell/annotate_stats.sh
> new file mode 100755
> index 0000000000000..82d2becdff141
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_stats.sh

[ ... ]

> +if ! perf annotate --code-with-type --insn-stat -i "$perfdata" --stdio \
> +		--percent-limit 1 > "$perfout" 2>/dev/null; then
> +	echo "FAIL: perf annotate"
> +	cleanup
> +	exit 1
> +fi
> +
> +# The instruction stats are accounted while the instructions are
> +# displayed; printing them before the display loop shows zeros.
> +if ! grep -Eq '^total [1-9][0-9]*,' "$perfout"; then
> +	echo "FAIL: instruction stats not accounted"
> +	cleanup
> +	exit 1
> +fi

[Severity: Low]
Will this test fail with exit status 1 instead of skipping when perf is
built without libdw dwarf support (HAVE_LIBDW_SUPPORT)?

Unlike --data-type, --code-with-type does not exit early when
HAVE_LIBDW_SUPPORT is disabled.  Instead, debuginfo__new() returns NULL,
so annotation_line__print() skips __hist_entry__get_data_type() and
prints "total 0".  Checking "perf check feature -q dwarf" before running
the test, as in data_type_register.sh, would skip cleanly with exit
status 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D6
