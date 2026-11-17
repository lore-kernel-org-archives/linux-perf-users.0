Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947365;
	b=Yc4xSCx2y5FssQ4+Q84aM0f00mhEPuAbWYOaO5Ee6ANBRd6s4FnUjurby4mOBAxAOQDw
	 47jdboEMkrlVBlentWB6jRC6Xc4HwhYGxnQhCM0ZhZcw/hdwUpWslJ2hc5shU1u4l49d1
	 kup+mKT+3QCRBAwNgqS3L9culhrgI1EblmKiJl84FpxyfJVdan4Rlm5D9mqdy6JJBW2ny
	 dhXLnzd7RGsNvBpCG9LWUtop7PV/CxCN2/SLx3Kv3ZGz0uGY31pr4Q07qyxxKgXc9m5w/
	 T75EGYgqu8bKYUqjGQQqC+QxM51GVxkHduRUPRe+UYDSGB+A+/kUYZxgAZRAAsKCUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cNa1OxYk2O1naRlafQJ4jv4FIRc2V/c+LUL8d5V8lEo=;
	b=oAqMXseOQQIFvgY+WMQT37LS7TJjPMxSPcHmal9PEGyz1DcDDK4BIX6oUcBcgK7IhRNb
	 3E9nhLXilK+EiuqD0WESPpcZY+BCSMLabz/Dec8Mk59yJgQnA7pPuE8GlM5ZbPBy+NJTQ
	 NlxOIGhByNlMo2LpEHzVgSlQ6WmPbpbi7CWN5LuWixxoBxFEShdbAII0pcbrvjtxcnih7
	 4lvPsy2EoNpVE1a40SO9RRPMlihEOElWizAsV3V5t4Kn4jA4jGfv+BksGHZjkWWf368Nx
	 v8gPhXJUDqzstM91vyzr2RfDozOgL16RdNXv1qJ/RwE1///MAaP8+LPDJ5A0RElUYkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVKnVQ7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5334606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVKnVQ7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887911F000CD;
	Tue, 17 Nov 2026 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947365;
	bh=cNa1OxYk2O1naRlafQJ4jv4FIRc2V/c+LUL8d5V8lEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YVKnVQ7HyYrBWjww18uh2vAF4W6Rc7JbvATZr2OkQC1rMBxPyvHwJSzNIX3SOA1Np
	 sh4zkSJZD77sWoJd1ceMrM85L96aogiW2ktSJ2x/ZS2hcI+9uZAlpymAwmKgTlaYWx
	 ZjHCnEbgdBGdF3ZSRqK/6fa/sZh7QJNzVBDt/CnYJKSYsT8rbz6RMMIozH20q1iO5y
	 H0oc+mjVWhIw3kaAZieyKBBa+m0dZ/cuh6QR3j3nn2y8Gm2AfQBp/Q/w3BfngwiG2r
	 lDMVjh4dRcpAfmLbWyDRefRCU8dFX0t7SMclLw85D6uCfUthPU0CKuRi5f/Hjw67a/
	 lf/c4arQToNww==
Message-ID: <sashiko-outbox-219605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-14-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:29:25 +0000
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
- [Medium] perf test: test_lbr() fails to skip on AMD BRS due to EINVAL
  vs EOPNOTSUPP
--

commit d21ae617447c59168b264906c4d199925c28a698
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Skip the LBR inline unwinding check when unsupported

This commit updates test_lbr() in addr2line_inlines.sh to skip the LBR
test when perf record reports that the PMU does not support branch stack
sampling.

> diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tes=
ts/shell/addr2line_inlines.sh
> index e8754ef2d7f21..ca88a6b886ca1 100755
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
> +        if grep -Fq "doesn't support branch stack sampling" "${perf_reco=
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

[Severity: Medium]
Does test_lbr() still fail on AMD BRS instead of skipping?

On AMD BRS, amd_brs_hw_config() rejects non-BRS events such as cycles:u
with -EINVAL rather than -EOPNOTSUPP:

arch/x86/events/amd/brs.c:amd_brs_hw_config() {
    ...
	if (!amd_is_brs_event(event))
		return -EINVAL;
    ...
}

In tools/perf/util/evsel.c, evsel__open_strerror() only formats the
"doesn't support branch stack sampling" message under case EOPNOTSUPP, and
falls through to the generic Invalid argument message for EINVAL.  As a
result, grep does not match perf_record_err on AMD BRS and test_lbr() still
enters the else branch and fails with err=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D13
