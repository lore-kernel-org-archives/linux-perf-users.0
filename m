Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6337DEBB
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211179; cv=none; b=CJU1mbquGqF+jVMs2EhYazOWv0D1EX2b7v3b21ZgOngIArQd2E2KQEsOTXa1Igd1kItffn3lng4TGOUbJKW8HGTkvfvtiZZhqb5Heosw76+gnMCh8f181jRVwQFVOWB0+/pOfj4l7mlgqpiPI1Md81U+lEChyhSP8F4AK0n1uGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211179; c=relaxed/simple;
	bh=JXMYW7KXmIReNdzn3m6TqXGn8aUEzHvZ2C5Awj4uEq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jgv2tEcnNAU14MWtEqg/pSCeGn7T2+NwqWe93irYdNTo08K4AQhWZPq9UAM4OoOaWQ/2yyKPbWKpWs/UlyBPqPMY9JufcESQk/lJbrRpm2Vvv8JeWEUKm0MGU3iIkQiiw+ajqpshb0GFUXgNn+PGefL5e1aMu01apDqbxCwN1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDiANy5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDiANy5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A291F000E9;
	Mon, 31 Aug 2026 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211178;
	bh=z31YZCwozjOG2/e3lOXfzwqgq/0nJ/EWapP312ODKSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDiANy5g+Lr79u60NVvVcaDD55MxqA5QG7HiIKX0vhAVsvuulwWmnHljuf2e0iA4J
	 YUDmDA/R485fl5U+0v+qQM1IXRNVxn+QNycnFA2iwHV8fVXlyzWX3YVx5RtziZ3/f0
	 1hE8xMvogFTh6txOjfdAloX4a/aH2deePpHE9hr+u73EjYRO2IkDh7Ex7TKoON3iwn
	 5Ar5kUjIggtZjhO7aVOVvocz9jpnrmLIfyQwm6EJQkNdv8P5IsTXXUqByOwPKOH4qD
	 ajbREs2NMLv8mpagdRi/C2NLdr2uCLQEDA/zIBYCm4TcwfinNQXs8xxS5vSntLKn5Z
	 aEvdY/nr432mQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 16/19] ptwrite uprobes / perf tools pt: Improve FUP
 error handling for ptwrite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-17-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-17-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:19:37 +0000
Message-Id: <20260831211938.27A291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect ptwrite IP reporting and failure to prevent trace abort =
in full instruction tracing mode.
- [Medium] Bypassing `intel_pt_fup_event()` causes incomplete manual state =
reconstruction, leaking instruction metadata and asynchronous FUP flags.
--

commit f901af3d0d6f6651e120a5aaaf5502b7aa3f6612
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes / perf tools pt: Improve FUP error handling for ptwrite

Special case the decoder to handle ptwrite FUPs targeting unmapped code
like uprobe stubs. When the decoder can't resolve the instruction page,
report the ptwrite with its IP instead of erroring out and failing the walk.

> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/=
perf/util/intel-pt-decoder/intel-pt-decoder.c
> index e733f6b1f7ac5..bd31d65dbe035 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -1440,8 +1440,29 @@ static int intel_pt_walk_fup(struct intel_pt_decod=
er *decoder)
>  			return -EAGAIN;
>  		}
>  		decoder->set_fup_tx_flags =3D false;
> -		if (err)
> +		if (err) {
> +			/*
> +			 * A ptwrite's FUP can target an address whose
> +			 * instruction cannot be resolved (e.g. the
> +			 * [uprobes-ptwrite] stub is an anonymous special
> +			 * mapping invisible to the machine). The FUP is
> +			 * still the ptwrite's IP: report it rather than
> +			 * failing the whole walk.
> +			 */
> +			if (decoder->set_fup_ptw) {
> +				decoder->set_fup_ptw =3D false;
> +				decoder->pkt_state =3D INTEL_PT_STATE_IN_SYNC;
> +				decoder->state.type &=3D ~INTEL_PT_BRANCH;
> +				decoder->state.type |=3D INTEL_PT_PTW;

[Severity: Medium]
Will bypassing intel_pt_fup_event() here leak instruction metadata and
asynchronous FUP flags?

Because intel_pt_walk_insn() returned an error early, decoder->state.insn_op
and insn_len retain the metadata from the last successfully decoded
instruction. By skipping intel_pt_fup_event() which usually clears these
fields and handles asynchronous flags, could stale instruction op/len and
pending event flags be incorrectly attributed to subsequent events?

> +				decoder->state.flags |=3D INTEL_PT_FUP_IP;
> +				decoder->state.from_ip =3D decoder->ip;

[Severity: High]
Does this code assign the wrong IP for the PTWRITE event and fail to prevent
the trace abort it intends to fix?

When intel_pt_walk_insn() encounters an unmapped region like the uprobe stu=
b,
it returns an error without advancing decoder->ip. The true PTWRITE IP from
the hardware FUP packet is passed as the ip parameter (from
decoder->last_ip) to intel_pt_walk_insn().

Assigning decoder->state.from_ip =3D decoder->ip instead of using the ip
parameter attributes the event to the stuck failure address. Additionally,
because decoder->ip is never advanced out of the unmapped region, subsequent
packets could trigger functions like intel_pt_walk_tip() to call
intel_pt_walk_insn(..., 0) starting from the same stuck decoder->ip, failing
again and aborting the trace.

> +				decoder->state.to_ip =3D 0;
> +				decoder->state.ptw_payload =3D
> +							decoder->fup_ptw_payload;
> +				return 0;
> +			}
>  			return err;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D16
