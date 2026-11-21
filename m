Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231837;
	b=cXy4woy3OBMFClu4P3P00w9XItGPabdFkl90z2AujZ1eYxgtcGh5+LsiVjGZFSEbYLkE
	 4UNVeqv6rhJOurIUduuclOUaTGtNhvMPs2YL1AymNOAk0MzC/CLgfqmHgXVLGXcSVhGz3
	 KOhDj8YTiM/g9aTUKPvJb1rEOA8jWlKprYAqfvVHGDb7yc7zz59OUp2roSerSYRpCmwFG
	 431tt2iY4963zTCh8Q8sycmiQOo3yYOUtW547IH7zZn0IFXjawn0lc40dv9+PB4rJdEez
	 USpZjnOpbGzqwQ+FN5oP1yZ8XIUTu2C2wnrhlQG/bfOVVMGMK3Yl/6Lq1Rs5nX33e+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LAKkPTobIUaCfLER+08iSfnVBeeCuWWME+staGrX0/c=;
	b=YIKty94/WzExnfrj1bNU81gL/hUzL1m9/7bDBFC7UGLPL4dt8netxbWG+Bch8diNXFZm
	 Pz3fl/jS6O45heH+Dx1QKNUEroSIIzhwdpxzQ/NDefHzKCxaE7W8x24AENb9Q3rxLE1k0
	 K40ntejwPHl+NXB5mR6qCRNknGvDVe/dIFQ/baRBBldmQxqW0UrkMP/t9xxaFem4X6CaK
	 BNuZ8XrndgFN8oTZN2pJG7bHd8MVPVFpIy7aWkP2NfIz/y06udDBcieLxxeh6TWGP3MoN
	 DyN9vmpg+UG8ptuqd8W8QyHVmdvDYB8OSxUG5si1uBvdd0Psz9OLVVwls7WXk/cnznQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOmi5OFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AF606A332
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOmi5OFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8160A1F000C4;
	Sat, 21 Nov 2026 03:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231836;
	bh=LAKkPTobIUaCfLER+08iSfnVBeeCuWWME+staGrX0/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOmi5OFetHFzpdYkdh8I6EFCUnyDuVWNW7YcKAzn9coECe6gkAnj4NfpGOuIU4c+9
	 khrtvVryefqg6rIrdi627Zp4FCG1hJdcUe29JVw7CNUGR0YKry6oev2ksPP7HBygU8
	 iTUMWWaCVkWhxSJjWfZmeJ2uiuTb6zpMU1ibGDRddH/aHqGb00XTjpfQiq7GhIey5E
	 WueDthDESaPARw8ozSmbuhVS6v27fzN75/N+PjCZ+G6WVB3Lclk+KrI5lsKK5o+IJz
	 WtdXD6iS2iBw3GH3735jTW8Uc0fbE8OkAl+dj+Au/LzxmdDpT8UqVLsfa3UB6ghnM5
	 4qGXGrsSYPNJA==
Message-ID: <sashiko-outbox-226585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/16] perf tests: Exercise the annotate stats
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121032052.1392234-12-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
 <20261121032052.1392234-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:30:36 +0000
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
- [Low] perf tests: annotate_stats.sh omits --data-type --type-stat
  output check
--

commit ce86ed141b9b58088762fac4e45ac569c679a1ab
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests: Exercise the annotate stats output

This commit adds a shell test exercising perf annotate instruction statisti=
cs
output and the warning emitted when --type-stat is used without --data-type.

> diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/=
shell/annotate_stats.sh
> new file mode 100755
> index 0000000000000..5af48bf187c5e
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_stats.sh
[ ... ]
> +if ! perf annotate --code-with-type --insn-stat -i "$perfdata" --stdio \
> +		--percent-limit 1 > "$perfout"; then
> +	echo "FAIL: perf annotate"
> +	cleanup
> +	exit 1
> +fi
> +
> +# The instruction stats are accounted while the instructions are
> +# displayed; printing them before the display loop shows zeros.
> +if ! grep -Eq '^total [1-9][0-9]*,' "$perfout"; then
> +	echo "FAIL: instruction stats not accounted"
> +	tail -n 30 "$perfout"
> +	cleanup
> +	exit 1
> +fi
> +
> +if ! perf annotate --type-stat -i "$perfdata" --stdio > /dev/null 2> "$p=
erferr" ||
> +   ! grep -Fxq "Warning: --type-stat needs --data-type" "$perferr"; then
> +	echo "FAIL: missing --type-stat warning"
> +	tail -n 30 "$perferr"
> +	cleanup
> +	exit 1
> +fi

[Severity: Low]
Does this script omit testing the actual --type-stat output promised by the
commit message?

__cmd_annotate() only calls print_annotate_data_stat() when both --data-type
and --type-stat are passed, whereas the first perf annotate call here passes
only --code-with-type --insn-stat and the second checks only the warning wh=
en
--data-type is missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121032052.1392=
234-1-acme@kernel.org?part=3D11
