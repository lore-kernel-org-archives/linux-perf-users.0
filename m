Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC63769F3
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490117; cv=none; b=BRatP47UjbITh8HvyW54pa+RH4kut7G2IrjFtQwBGv2QNj0UeolIzdyIc0o4ai4Xltgtn4gDpuxXHytcAj7tvDqFTVdCLbNTZ1pazPwykoYISN4cub/0Ob2axnVJRpo9rss5Ug6OxbqGGc8nnIRA//duLsbSfmynK46l7lD0Ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490117; c=relaxed/simple;
	bh=oKrcnP7UnOuHaCg1uCzkSlMtjHi6VDmUZBEtsMiVJFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lFDOoJ3xbFep+nYGMcCe4k3hAf/X05O9Q1TxKusS3PtZmdn/Oo4o4MongFZX4ocd96qGsqOY3WpT3klet6hU5zd9LTg6OCXohz8ysJBelDb2f1XB3g8nleqE6f3beM6MdQLb8kanVtzEf6Qzy2jirFX3g/cVRisYJDAuyMRv7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf45/r9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf45/r9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F411F00A3D;
	Fri, 22 May 2026 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490114;
	bh=8vmv1pLWF1XIr5+Dx4ooVMeVpHoGv/+4J+ql2kE/iOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xf45/r9q3XGqIszjJCWVJOpuqbx04Njp63dKlu/B6XghrexvmN2/6JHTp0PrMMK+A
	 5UeLqW1GONu9ATx6eeipWWPN7oAn1jloF0h07fxghnvSHUV/dr78y/gb1fW+U2XjQl
	 IjbBus/lZpSEzWZ+xptRnFDQ3PTBbO4O6SHdh1XWr+myNmakUcfegQ4SlgOhf1bdGU
	 FdUdOI6W04O3rXSH4kB4bX698yk7i5Ri1y8rSczRlK/zjKdpdTaVHhXwmqptjYOG13
	 dUpuARnQC21yUarKY225KClU6C/jpqEu/1LDGwuXFMHHSN67HGGnIQeu198jQTvBPo
	 lulIRn0bL0gRw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 09/14] perf stat: Extend CSV output linter to
 test advanced PMU and metric-only checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-10-irogers@google.com>
References: <20260522223342.2393553-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:48:34 +0000
Message-Id: <20260522224834.D2F411F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] A redundant `if [ $skip_test -ne 1 ]` block was introduced instead =
of grouping the checks together.
- [Low] The commit message incorrectly references JSON layouts in a patch t=
hat strictly tests CSV output formatting.
--

commit 02bae29bcacfe6b2ac713a32abfb3c12b7c4b5c2
Author: Ian Rogers <irogers@google.com>

perf stat: Extend CSV output linter to test advanced PMU and metric-only ch=
ecks

This commit extends the perf stat CSV output linter tests to run advanced
hardware PMU, topology-aware aggregation, and metric-only checks a second
time using the new CSV print flag.

> This guarantees that CSV outputs produced by the decoupled printing callb=
acks
> are verified and column-valid under advanced aggregation modes and metric=
-only
> JSON row-column layouts.

[Severity: Low]
This isn't a bug, but the commit message references testing JSON row-column
layouts. Since this patch strictly modifies stat+csv_output.sh to verify CSV
outputs, is the reference to JSON an accidental carryover from a different
testing patch?

> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests=
/shell/stat+csv_output.sh
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -103,6 +103,12 @@ then
>  	check_per_die "CSV (New API)" "$perf_cmd"
>  	check_per_socket "CSV (New API)" "$perf_cmd"
>  fi
> +if [ $skip_test -ne 1 ]
> +then
> +	check_per_cache_instance "CSV (New API)" "$perf_cmd"
> +	check_per_cluster "CSV (New API)" "$perf_cmd"
> +fi

[Severity: Low]
This isn't a bug, but could these new checks simply be appended inside the
existing conditional block immediately above this, rather than opening a
new identical conditional block?

> +check_metric_only "CSV (New API)" "$perf_cmd"
> =20
>  cleanup
>  exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D9
