Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4743C37A9;
	Tue,  9 Jun 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983372; cv=none; b=dsHpv83Bztlvv77uT3IKzJulvwObAK0J0Ee/iR9jhNR8LSyiV86iQAfeljbJ9GrFdlmQkb+apE+ud1WD5VggYquio85tsuRLpC05GKXKzFJUY446wajITpemf8p1DNIuRrWHKM5tLWdTs7ohiVaJFgiDG46G0EdREX8tAJYjhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983372; c=relaxed/simple;
	bh=cYUEA6geXgeK+XrGcTHbgl61M3KYtOAjDDO4LdDTPVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnnV5XskiuOpEIgK2FFpiNbQHCnBW7jsw3+i6OsfPuyfRCu9LFciFKy96OjANN6imQp7cE3yy/2m/8Q3dhfUYiXmza+jGCUmXjqDJVsaFcwq6lFf5NXNMMhhN/nw48iUO5R1bUueqAFhCbEGQaYXvXX4gBmXCnSWpMdJ5rgZsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeNRAMep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeNRAMep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0C1F00893;
	Tue,  9 Jun 2026 05:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780983371;
	bh=CDU2rB4lZXQhgcX2fg23JW8gUy6tahFW7dl9j71VEmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LeNRAMepPX3cqGcVe3T2VwDnVUDt4+7obhwSEheUEQz+eKDOsrZdbYCkwDzlEdUqS
	 e4WrVbvxthDueFjUxHtl0XZ56NS4VZw2X2nYWO17qsItUCIR4E50bnzonNF0b0AMKq
	 AyirF+qdSvJe0w95PX/Fayzk5sSGJNxsiUdleeqH5kTRoynErvsGYdeo+JiGxZG8Oh
	 R9m6ypezNp1jWt/Za8xxOA+tkwGLziY6k+gbjNAhfic7wnSF2Nr0enQh9KmMORIjny
	 oUpN8FG9Jnc81hX/ej8sNFYVqzCXmRbLnbnADOyzGrLkG3Y8KYv8UNHah+IFCkhA7H
	 bwfZ0wxZt8vYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] perf test: Add BPF JIT annotation test coverage
 for all disassemblers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609051759.405027-8-irogers@google.com>
References: <20260609051759.405027-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:36:10 +0000
Message-Id: <20260609053610.E4C0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing a securely created temporary file before reusing its path=
 creates a Time-Of-Check to Time-Of-Use (TOCTOU) race condition, allowing a=
 local attacker to overwrite arbitrary system files or steal system-wide pr=
ofiling data.
--

commit cc2ff8c9b984e996a4b88b05049833c644d20227
Author: Ian Rogers <irogers@google.com>

perf test: Add BPF JIT annotation test coverage for all disassemblers
   =20
This commit expands the annotate.sh shell test to verify BPF JIT disassembl=
y.=20
It captures system BPF programs and validates the temporary ELF generation=
=20
using various supported disassembler backends.

> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> index d3bafa7e3db55..d8c710470c528 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
[ ... ]
> +test_bpf() {
> +  echo "Test annotate with BPF JIT output"
> +
> +  if ! perf check -q feature libbpf-strings ; then
> +    echo "BPF annotation test [Skipped - libbpf-strings not supported]"
> +    return 0
> +  fi
> +
> +  rm -f "${perfdata}"
> +
> +  if ! perf record -a -e cycles -F 4000 -o "${perfdata}" -- sleep 1 2> /=
dev/null

[Severity: High]
Does removing this securely created temporary file before reusing its path
create a Time-Of-Check to Time-Of-Use (TOCTOU) race condition?

By deleting the file explicitly and then allowing perf record to create it
again, it appears to open a window where a local attacker could place a
symlink at this path. Since perf record does not use O_EXCL when opening
output files, couldn't this result in overwriting arbitrary system files or
leaking system-wide profiling data if the test is run with privileges?

> +  then
> +    echo "BPF annotation test [Skipped - perf record -a failed, probably=
 no privileges]"
> +    return 0
> +  fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609051759.4050=
27-1-irogers@google.com?part=3D7
