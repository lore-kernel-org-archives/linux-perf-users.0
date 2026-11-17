Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874003;
	b=nWgr6D2n7FdRgkm6CyRLeLOfCPMwaHPxKpzOVab6Dw8bMDLNluHLzohwm7JbuyvU9Lgr
	 aLISrZc9nhopE/Nce7jx9BEIVE+qDc4uxjvnW+R7+detJE08l3hGNEUMLLOsw4Ls4F+vs
	 FlSqauZxgkJeoD/WVUaBmod1YH3J7xkBBhnjaoIjPrj6sQtrDD1oIKxR+XvoZtPPDO0x1
	 VE04XmEnvLkquWk1kps823exNcUs1W8GSGQ3tjDKh/MCEuyBayMskquIvW2RL2KBJaAfh
	 JoduiphmB9agCmOl91Am6xWihr5uB7OKIHwv+ORApnG5XEEDiC2k3EvmvDtV0CEa58A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jI1oP4N/EK7i4mFuPyNjUOio3ksqpCX3MJs/Sz7TH70=;
	b=a6tiIHJJLDqp0/XSGqms8xRg51MKs1PmxDr8/fbXElrHqg9JjsDJuegoe51Vd4vQkvXi
	 6RbQcsVjH6BW3uy/XtYYoWw3AYCCuSQdL8dbuQ9fGLyKl817TgFACdKurs4INCdnvZoAj
	 hClBhmqlAqhOVIlSL+0PpyxhGFgf59Wa2klfOz2xiwqMelaWi3FUoeFs6307gRMoyRqmU
	 3XiVtjo6NR73PStqitNM55zYVsoh7BydPYm9fvl7S7rkC7xuy+07g0WrYUsV57uvz9D5L
	 ZXK18YzZQQNUA0NyTFlglXKo6Rw/WK8PAx+MQTy0cSihCRVicsKhnriNz95arlCR+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt7hkO1U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F91606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt7hkO1U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892B11F000C4;
	Tue, 17 Nov 2026 00:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874002;
	bh=jI1oP4N/EK7i4mFuPyNjUOio3ksqpCX3MJs/Sz7TH70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kt7hkO1UyWrT5up78ZxHmH2sunMatO0+ie/QWLthW8m0dJ+3MV9rh6UD4M+tWcQl1
	 s4o6F+qYAOqrifAiLoChSasG5dvYnfdeQ3dyuUlmrPneBir1LRz45BlNOtWBuxawQS
	 mjku04oyai9jAkkMWLA7bYMosKwFoPnK+g9AN0w0ovgrZuGEltTao0P4mZHGxnDWHi
	 RURGR+LkdhVvaCzPtvtBLbN5b4WNbjCCubAft3KYbA/+cdTCGDGJhV7FhJdtWVKLQo
	 0BYuiB254m9NNtQrAeH+G8ORVsMw8kcjp96+xZ7MPKobyvq7RB8A2cMhoe8uSNixEk
	 X/5Bbf7CFLG1w==
Message-ID: <sashiko-outbox-217977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-13-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:06:42 +0000
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
- [Low] perf test: test_lbr() grep misses EOPNOTSUPP branch stack error
  string
--

commit 0391fa9c2628a460f3c842d979bf69a0aa07c146
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Skip the LBR inline unwinding check when unsupported

This commit updates the addr2line_inlines shell test to check the error
output from perf record --call-graph lbr and skip the test with exit status
2 when LBR recording is rejected by the PMU.

> diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tes=
ts/shell/addr2line_inlines.sh
> index e8754ef2d7f21..be0bfb70143a1 100755
> --- a/tools/perf/tests/shell/addr2line_inlines.sh
> +++ b/tools/perf/tests/shell/addr2line_inlines.sh

[ ... ]

> @@ -71,7 +73,22 @@ test_lbr() {
>      fi
> =20
>      # Record data. Currently only dwarf callchains support inlined funct=
ions.
> -    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf t=
est -w inlineloop 1
> +    # Some PMUs advertise branches but reject branch sampling for cycles=
, e.g.
> +    # AMD BRS, which only samples its own retired branches event.
> +    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
> +            perf test -w inlineloop 1 2> "${perf_record_err}"
> +    then
> +        if grep -q -e "Invalid argument" -e "not supported" "${perf_reco=
rd_err}"
> +        then
> +            echo "Skip: LBR not supported by the PMU"
> +            lbr_skipped=3D1
> +        else
> +            cat "${perf_record_err}"
> +            echo "Inline unwinding lbr verification test [Failed to reco=
rd]"
> +            err=3D1
> +        fi
> +        return
> +    fi

[Severity: Low]
Does this grep miss the EOPNOTSUPP error message emitted when the PMU rejec=
ts
--call-graph lbr?

On CPUs that expose caps/branches but return -EOPNOTSUPP for
PERF_SAMPLE_BRANCH_CALL_STACK (such as AMD Zen 4/5 with LBRv2 in
amd_pmu_lbr_setup_filter()), evsel__open_strerror() formats EOPNOTSUPP with
"doesn't support" rather than strerror(EOPNOTSUPP) ("Operation not
supported"):

tools/perf/util/evsel.c:evsel__open_strerror() {
	...
	case EOPNOTSUPP:
		if (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)
			return scnprintf(msg, size,
	"%s: PMU Hardware or event type doesn't support branch stack sampling.",
					 evsel__name(evsel));
	...
}

As a result, the grep does not match and test_lbr() still fails the test
with err=3D1 instead of skipping.  Matching "doesn't support" as well would
handle EOPNOTSUPP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D12
