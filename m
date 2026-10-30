Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374854;
	b=oAgXqBfSCrACmVLqKZRhQGe8jLRq5bVsaU/llIGYfhTd+mBDk2LzjpynooLn8ukTLZs6
	 BqhaDLnD6mhZETe6VU7S+VeCAcN5/Jdv1lObUirdnHVatuFY9vOxBYTMjXsdXqaMu72yY
	 RfPdk7OlvJFnq90UYMnl21HTig6I5xlOsmwB2LdnAVUK/O8Gu5+V8hpC6wPML77x9YOSK
	 FkFml1qoiZja+baSNm8moN4EFhx6K7DCsZRgy6E0/0Tk/TMXzdEnfWjwnpazl1vPEhwq9
	 MF38ouiNYNaIwsQXr7r7cJSogVQw17tfZ6hnWBDTih4hEcZiaT6rj1LHUdY3Ee4P15Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kPqyuzfHQpsm+q8kyFvV3BDkCIiL/54visMtcYwwNTg=;
	b=wBQwfYtKoFPZEzKglzIFzPc+qit0CKmVSp27OUKLMbTf+mUml61dnH4KtHW2bCEqwze7
	 +9jTBQIoruQdNADVQ8OBpniIU+fF8lBweTzbClIvsnxJvFZZ5MVS4ltKkWdA3oeKiog7E
	 Wn8AMDYp91Excq9mUhaaC7Q+FDNPDR8wzP4J05Pgj0jWtAB0SusgT/WxTt/9OEtsN7JO8
	 bdKYyVNUoqTXqMrNmYRB/z1AgWt/TaZHkJmSMPp4p379OssmTs6N+HZeS7H48BKEmOB6n
	 0tA7ixZG9Zl306iEINg1vp6x9wsKFtg/ThLmbJJQLVE24qpquENkxxInFyEvZr3XSxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GILXIekC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B584606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GILXIekC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13851F000C1;
	Fri, 30 Oct 2026 15:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793374854;
	bh=kPqyuzfHQpsm+q8kyFvV3BDkCIiL/54visMtcYwwNTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GILXIekCH3UQpBQ9zCSWqBo9bGlHENtW5YAgW9VGn7gvGnKI/m5cMGqbp2uIEeRmp
	 Dgq83uclNSOpyV7hwbqZy6eDtGUd0YfclsxqWpldKavk6MAaU5s9pJaJq4FG+X1fpw
	 V/hApXxHqzCo0kfdFKUIGXHXf4MewrAkUe/k6Q0Q+nQjqc8kQK8qjoYVX0OtANDvxJ
	 y7PkLopr20gpy2TWgRi+JnOCCdoq7UUsRNQ0zDFKidR+XBmf7oTb2WTuYRB6OoLmJZ
	 p6X7Vx9aNS1tawGPvs2Cm5IgtdA8xMhIEY8SAf2mIHuiutjnferA7lQW6RHVX/hj1j
	 5VJmuDkzY4VMw==
Message-ID: <sashiko-outbox-191183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:40:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf cs-etm: missing protocol check in cs_etm_decoder__buffer_ex=
ception()
--

commit 1b56f1522800c89c4b421c00a6430a476535232e
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Synthesize exception entries separately from branches

This commit synthesizes exception entry samples separately from preceding
instruction ranges by deriving A32 and A64 exception source addresses from
the preferred exception return address and retaining the exception packet in
prev_packet until its destination is resolved.

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index ccae10e6cdad5..b9397151748b2 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -514,6 +514,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue =
*etmq,
>  {
>  	int ret =3D 0;
>  	struct cs_etm_packet *packet;
> +	u8 last_instr_size =3D 0;
> =20
>  	ret =3D cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
>  					    CS_ETM_EXCEPTION);
> @@ -524,8 +525,34 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue=
 *etmq,
>  	packet->exception_number =3D elem->exception_number;
>  	if (elem->context.el_valid)
>  		packet->el =3D elem->context.exception_level;
> -	if (elem->excep_ret_addr)
> -		packet->pref_ret_addr =3D elem->en_addr;
> +
> +	/* RESET has no defined preferred return address. */
> +	if (!elem->excep_ret_addr ||
> +	    packet->exception_number =3D=3D CS_ETMV4_EXC_RESET)
> +		return ret;
> +
> +	packet->pref_ret_addr =3D elem->en_addr;
> +
> +	/*
> +	 * T32 calls can be two or four bytes, requiring an instruction read
> +	 * before pref_ret_addr to determine their size. Keep it for the
> +	 * frontend's SVC check and leave start_addr unknown for its fallback.
> +	 */
> +	if (packet->isa !=3D CS_ETM_ISA_A32 && packet->isa !=3D CS_ETM_ISA_A64)
> +		return ret;
> +
> +	/*
> +	 * For A32 and A64, exception calls execute a four-byte SVC, HVC or
> +	 * SMC and save the following PC. Other exceptions use the interrupted
> +	 * or faulting PC, including traps on those instructions.
> +	 *
> +	 * With a shared branch target, no instruction has completed
> +	 * at the target, so last_instr_size remains zero.
> +	 */
> +	if (elem->exception_number =3D=3D CS_ETMV4_EXC_CALL)
> +		last_instr_size =3D 4;
> +	packet->start_addr =3D packet->pref_ret_addr - last_instr_size;
> +	packet->last_instr_size =3D last_instr_size;

[Severity: Medium]
As reported by Sashiko on v2 [1], does cs_etm_decoder__buffer_exception()
misinterpret exception_number when decoding ETMv3 traces in A32 state?

Unlike cs_etm__is_syscall(), cs_etm__is_async_exception(), and
cs_etm__is_sync_exception() in tools/perf/util/cs-etm.c, which check the
trace protocol before matching exception numbers:

tools/perf/util/cs-etm.c:cs_etm__is_syscall() {
	...
	if (magic =3D=3D __perf_cs_etmv3_magic)
		if (packet->exception_number =3D=3D CS_ETMV3_EXC_SVC)
			return true;

	/*
	 * ETMv4 has a single exception number for SVC, SMC and HVC; need to
	 * test the assembly code to identify if it is a SVC instruction.
	 */
	if (magic =3D=3D __perf_cs_etmv4_magic || magic =3D=3D __perf_cs_ete_magic=
) {
		if (packet->exception_number =3D=3D CS_ETMV4_EXC_CALL &&
		    cs_etm__is_svc_instr(etmq, tidq, packet, end_addr))
			return true;
	}
	...
}

cs_etm_decoder__buffer_exception() unconditionally compares exception_number
against the ETMv4 constants CS_ETMV4_EXC_RESET (0) and CS_ETMV4_EXC_CALL (2=
).

In ETMv3, PE reset is CS_ETMV3_EXC_PE_RESET (8), SVC is CS_ETMV3_EXC_SVC
(10), and Hypervisor call is CS_ETMV3_EXC_HYP (3), while only
CS_ETMV3_EXC_SMC (2) happens to match CS_ETMV4_EXC_CALL. When decoding an
ETMv3 A32 trace with elem->excep_ret_addr set, SVC and HYP calls leave
last_instr_size as 0 and set packet->start_addr to packet->pref_ret_addr
instead of packet->pref_ret_addr - 4, and PE reset exceptions bypass the
reset fallback check.

Should cs_etm_decoder__buffer_exception() check the decoder protocol (or
corresponding ETMv3 exception numbers) before matching reset and call
exceptions?

[1] https://lore.kernel.org/r/20260923163605.3962C1F000FF@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D10
