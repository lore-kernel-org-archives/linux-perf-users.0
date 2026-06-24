Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF025BF13
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294445; cv=none; b=VNageVqyTYHuQ63NN3QgMQdh4JThSYuGidf30QOOv4aVB1M8M47NGU+vvTuPtrDRJaWND30CC9te8ze7zhDJCkBwlzz0HhwdGZbjDiKAg4yRnhUFYQCF/X3hoEXAWB2DmFUBrLoJeDxUGznJnTUjo4KGkIIM7szGZz5rdCnoFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294445; c=relaxed/simple;
	bh=KidoJZ/wHQ0un8VNY+VY203ob0YcMedLwp4dhqq46ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5rFrtI8z9aWzBFp2mmu27QD0E0sanzfPc08TQ0jFKiUZA4nGUuAvW1zpw7UPaWwC1g3qgYX08JAYTZGhgqf/OzSJDDu8MTaraId0YM2e+kBZlAESmqYxLIIl+U3CEsr2gePv8IsdTS6O/Bli+qUhJAsyLJKpwYwHchsrhupwfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTYOy15i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTYOy15i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78D71F000E9;
	Wed, 24 Jun 2026 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294444;
	bh=CE1MUnA5hNkzR3MFFZoyy0mjQGuvMG8FF/vgPmRLIn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTYOy15iaFV/Ovr3IMrjGF41BDEkCV8S2VBRQq9a3ZB2nXB0YlrD2CUFP4zVQQi7R
	 UnFtdW8+KJLNIe1AcU03+xpDoyeRiU8lIBuBnV7tsc4pK9+GRSOQPnAtzkDNIbKRTI
	 bhCouf+MTV24ymlPbVrMr12cpVAnEPdRJ9QvdGSaBPxYP9F+ENClTKWKpLQ/ikBzno
	 DfUPocNneeoC3QKiR69QYOA9Xdopz+0hvWZ4dO3iYj3w0lqqvjuFX2DLJHOQ+T8Oy2
	 B6rrHo1aqBmBCq6aX59UfkqlvD/BKzDMH6ZRviCGdDr8y5xxeOqqqCN/Nz+RJTSDdi
	 CQVvAfkha1NTQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4] perf tests: Add auto counter reload (ACR) sampling
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624093316.1439582-1-dapeng1.mi@linux.intel.com>
References: <20260624093316.1439582-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:47:23 +0000
Message-Id: <20260624094723.C78D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test `test_acr_sampling` is flaky because it structurally relies=
 on the `thloop` workload sustaining an IPC > 2.0.
--

commit 8d4447d6783576282b44d2b951b516b17d5c46b1
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tests: Add auto counter reload (ACR) sampling test

This commit adds a new sampling test to verify that the intended event reco=
rds
can be captured and that self-reloaded events do not generate any records.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 7cb81cf3444a7..5819f11ad3a90 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh

[ ... ]

> @@ -402,6 +402,48 @@ test_callgraph() {
>    echo "Callgraph test [Success]"
>  }
> =20
> +test_acr_sampling() {
> +  events=3D"{instructions/period=3D40000,acr_mask=3D0x2/u,cycles/period=
=3D20000,acr_mask=3D0x3/u}"
> +  pebs_events=3D"{instructions/period=3D40000,acr_mask=3D0x2/pu,cycles/p=
eriod=3D20000,acr_mask=3D0x3/u}"

[Severity: Medium]
Does this test configuration require the workload to sustain an IPC greater
than 2.0 to pass?

With acr_mask=3D0x3 on the cycles event, if cycles reaches 20000 before
instructions reaches 40000, both counters will automatically reload and no
samples will be generated.

> +  echo "Auto counter reload (ACR) sampling test"
> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/n=
ull
> +  then
> +    echo "Auto counter reload sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"

If the actual IPC drops to 2.0 or lower (which might happen due to SMT
contention, execution on E-cores, or cache effects), the cycles event will
repeatedly overflow first.  This means zero samples will be recorded, and
the grep check here will fail.

Should the event periods be adjusted to tolerate lower IPC values?

> +  then
> +    echo "Auto counter reload sampling [Failed missing instructions even=
t]"
> +    err=3D1
> +    return
> +  fi

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624093316.1439=
582-1-dapeng1.mi@linux.intel.com?part=3D1
