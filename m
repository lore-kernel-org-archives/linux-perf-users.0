Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF223AD51C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179292; cv=none; b=NBZHDZLvb5304CRXlse5ahNWSdBaF56jg+4wAsWmtgL2SV92oFaJoTVqxxjxSUgs3OH1ogi2Ry4OFAg9Gy7gvHABInoprNJqaA7lFEb+blsfMQjemFtgg+fdjgGCHPMgPNWwBnpixzxE5uWf88VJLVSgzocqAzzr9zxfaQWDN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179292; c=relaxed/simple;
	bh=tM9zkwo9OQAw3xTxz79UmKdXw/UAiD6hY4mgu0HRBlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lvk1YeJ1D4fgBHTQaHxOTcntoFWhVm4BvNzPWuBWt5ADKmu44o3HmhMy990HQu+kua0W0Bmnx2DvCTOE20e+9rG4YLysF1H5FNsm9FwKwF/PlhvKYCWg5lknbiKEAGvRas94NEiliIVsJKlNPaLfqDEuqx79vuqMmjP3QWlGZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM9sbJak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM9sbJak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149001F000FF;
	Wed, 23 Sep 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179291;
	bh=boFXF2ufQL5ehxi3g8igP4AR4eDd8UlEga9zV/eeBmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mM9sbJakV+ywh9jkXTjdvjAHMF7PEM3frwO0+OXSS4e84sxlY6CLNcTH4gF0IFRYE
	 gj9w2/quBX6KQ/NsSX3Ij1Yt5r9wnkaTaqZarfgntlZLZ/lyy4tuOJahGixOKC3eSG
	 EBsfGB81fbq1cTKScBUzm1f9mEKxI9OtPSHhWrVlbuTQnzK0+luGanLXKILNbwttUg
	 M5sI1bmdcXd960kDZX+Jt9bEClYfMS81+PlJeM7+tR2bJ3/ClqzyNHtit3/Z/T6HxO
	 9mFm9MkTtratpsB0txhOucSnT/fPvsLcUnUdwlrCJ8xRBOq2xmLVFmVYJ9kznLnNfi
	 nZJwaFWncxjLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/14] perf cs-etm: Use the recorded instruction size
 for A32 and A64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-5-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-5-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:01:30 +0000
Message-Id: <20260923160131.149001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf cs-etm: Missing bounds check on instruction size in cs_etm__c=
opy_insn()
--

commit 8ca3f124dea0462e31844bee55fa404297bf8a53
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Use the recorded instruction size for A32 and A64

Use packet->last_instr_size in cs_etm__instr_size() instead of a
hard-coded value, allowing the decoder to supply the instruction size.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2d1ab34f7b6b5..0163d93ac2d53 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1358,8 +1358,7 @@ static inline int cs_etm__instr_size(struct cs_etm_=
queue *etmq,
>  	if (packet->isa =3D=3D CS_ETM_ISA_T32)
>  		return cs_etm__t32_instr_size(etmq, tidq, packet, addr);
> =20
> -	/* Otherwise, 4-byte instruction size for A32/A64 */
> -	return 4;
> +	return packet->last_instr_size;

[Severity: High]
Can an untrusted decoder-supplied size cause this regression to overflow
sample->insn[]?

When cs_etm__instr_size() returns packet->last_instr_size without validatio=
n,
it is assigned to sample->insn_len in cs_etm__copy_insn().

This unbounded size is then passed to cs_etm__frontend_mem_access() as the
read length, which writes into the sample->insn[] array:

tools/perf/util/cs-etm.c:cs_etm__copy_insn() {
...
	sample->insn_len =3D cs_etm__instr_size(etmq, tidq, packet, sample->ip);

	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
				    sample->insn_len, (void *)sample->insn);
...
}

Because sample->insn[] is defined as a fixed size array (char insn[MAX_INSN=
])
within struct perf_sample, processing an untrusted or maliciously crafted
perf.data file where packet->last_instr_size exceeds MAX_INSN might cause an
out-of-bounds write on the stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D5
