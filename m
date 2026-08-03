Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091B3DAAB8
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748887; cv=none; b=BQagVwBCsN0yrDl3CjQWICQJ+mwygBGhRk9lv/V1KXW4FZ1GpmSrCNw+1v8yRtrgXY5IEcHMjgKoJYMNcongo4DEflYf7yyHvsr7hhljO7x9Y+Y1TSX+f7WoM3XCW8BsPBr8D3Svo6RkUWPBHyMtD0fQ6O8s9qbEDu3IlffNFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748887; c=relaxed/simple;
	bh=VgxOgyeIain//7+AdGxqG/9tXX3C8AbxMqwISwRP8vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S2xtLx8vrpBICef4YwnhmO2SVPG++v4oCrT0EauU6vhDtR7v6nJjFW0Qixhm6UVmc3UmcJhT3nK2h3GN9YfaLUEqMU4UPZfF/KZt/7HLAuNZqlRMPdbkuOk92baSN114PCQvFgdm1S0bD9b351p+t2oRsHfEBd3bXYaLWdRO50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbnANI6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbnANI6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620591F000E9;
	Mon,  3 Aug 2026 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785748885;
	bh=PM5fJrn+LC9RMcwzUrcJ5UnTow5+I3V+TpuSDLNhEsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbnANI6NiaX3DU6fSoTK7/aBrdMInYx2A08KvYoURkYpXgaEKkKuM0ghoMIf/RNkd
	 X1Ay7wJqxFgEl6O5CaRzsjCMBlT9nI2U2TPasaD6QB9zj0m1svhsVAzQmFkFjkIVQl
	 mva2qdgtTT2yejEu/JOiPuiX52mXtBoAtMmsynhDsq6nkr9J9brkvILTlUZFTfcDwV
	 PTvn/ZxP2lk7SR80lDQYOdbie7hxsmf2B7H/ixpFqCRGWeSHcx75d9zKjgqw1iCp/u
	 /YW/qSrlv9SHDCH38HYmCcpXKbgqSopnI/WayayfWmMB4iFJuFYm+yEamRrXAi8Ky5
	 ARu9sVgbBsBOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] perf test cs-etm: Test branch history on existing
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803090640.2412336-7-aaupov@fb.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-7-aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:21:24 +0000
Message-Id: <20260803092125.620591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `check_callchains` does not verify callchains for each process a=
s claimed in the commit message.
--

--- Patch [7]: [PATCH 7/9] perf test cs-etm: Test branch history on existin=
g samples ---
commit e252ec70028dd10b925f2e4ea78b626688f184d4
Author: Amir Ayupov <aaupov@fb.com>

perf test cs-etm: Test branch history on existing samples

This commit adds a CoreSight shell test to verify branch history on existing
samples using explicitly timestamped ETM traces. It decodes traces with L4 =
and
L64 depth settings and checks that pause samples contain valid multi-frame
callchains and bounded branch stacks.

> diff --git a/tools/perf/tests/shell/coresight/add_last_branch.sh b/tools/=
perf/tests/shell/coresight/add_last_branch.sh
> new file mode 100755
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/add_last_branch.sh

[ ... ]

> +check_callchains()
> +{
> +	local output=3D"$tmpdir/script-callchain"
> +
> +	perf script -i "$tmpdir/data" -F comm,event,ip >"$output" 2>/dev/null
> +
> +	awk '
> +		/cycles\/aux-action=3Dpause/ {
> +			in_sample =3D 1
> +			frames =3D 0
> +			next
> +		}
> +		!NF {
> +			if (in_sample && frames >=3D 2)
> +				found =3D 1
> +			in_sample =3D 0
> +			next
> +		}

[Severity: Medium]
The commit message states the test will "check that the pause samples carry
both a multi-frame callchain and a non-empty branch stack for each of the
workload's two processes."

Does this awk script in check_callchains() verify the callchains for each
process?

Unlike check_process_samples(), which checks for proc1 and proc2, this
script appears to set found=3D1 as soon as any sample contains a multi-frame
callchain, without validating the comm field.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803090640.2412=
336-1-aaupov@fb.com?part=3D7
