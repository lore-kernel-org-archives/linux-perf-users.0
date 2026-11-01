Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562526;
	b=JoLW/kDZ84L7IQLOkKn/8QL8bDuDtVMiidb966nby7z23uFvsR1AJCcrVU5kL6/FE2K5
	 vR3s49zQj+CY8389WkhRGMSlPiDWP83iFWyVw4HLRmSwlLMy1OGhl6Zx7IHM4eKRRQ6vG
	 Dci4hIMVyPTnwCncGanDkY65CP1oO5N53d+kYNYEX/6zFw6leXBrH3PKHgTzawbRkH70o
	 wDKheMf7ycsrLj8b8JnThSPwp77feD+m6vBGQoe5rFjEFwxYtEy+0SInUSDNquJyUfRBj
	 ZA/8F6OKaIGdHx6UxQf/0MJFfVC7J0LCQjcNQw7WlAsgJx7VBvgcHuV/Yyiz2sAJGUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VpFJrzpoGMpD77cU0SvuWnwEHPuvXj13ejbpYsy2cK0=;
	b=XZQfgYxaa2fzTKxiKOYyHj9AZ9kclnL/ztbfvg2u03/jAdepJW1rt/4P/X8r0Vtg6bZh
	 KoXD5piQPEq3yJlWKScqka7f9XWa/FZzzEUetDjT8R1PDXirRtBhvqbe/RefVQsYPQJsV
	 tZXM6hJyy5kZ3UoHor/iB30XfQtTqSDHrORQeqHK1Q00/zn+OWkMybqguqQvfLHXM8yPK
	 37LrpY94Yf8ky6LQF8X5Z6sIB9P0DzuxRy2mFADD4NdJETdtSKDMoMhL2WleLHBDkyuIP
	 TctV5fG05y9j+8XjiZ9JC9JjLS369kUJKF47IUzzOXrvQkxthbFV1JwfreFCTvNTOcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJPrtGF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBA606A327
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJPrtGF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349801F000C1;
	Sun,  1 Nov 2026 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562525;
	bh=VpFJrzpoGMpD77cU0SvuWnwEHPuvXj13ejbpYsy2cK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJPrtGF+jjzIL2SIkKC+n20ndo+tS419zGIHQUpAe+0i0FadpbiQAWIYtqU8hmCi1
	 68lVlv011eDuziOgLKb32pwzF92rTFk4nbhe8X5Lk3gvvvTaN3FrUnS3zV/L5shnjI
	 a4kGzn0hkwlI7ciSuJMW3dz7QBevVy/Qnr8vRvmx4+AEJmvMI4jmLAT9d3eWNzVNS5
	 GHde0qx0lWsf5vGIfoTQ8UZ0ghb6XLnFNnZCMO6c1sCpEZEJN9QHy4eeM/8/muM22J
	 AiB8KoegFjOzuiFC9SxjOxBQJ7TEW22pDjZVHz1JLePPcI85bs6V1eScmYSJKUlLPm
	 zb36fLWmDU4ag==
Message-ID: <sashiko-outbox-192633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] alpha/perf: do not report user registers from
 the entry code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-4-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-4-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:48:44 +0000
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
- [Medium] alpha/perf: __entry_save_end precedes r16-r18 save in entSys
--

commit ce97475b8e0171fa2ccbfec6b4cebc978a8757a6
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: do not report user registers from the entry code

This commit prevents perf_get_regs_user() from returning an incomplete user
pt_regs frame when a perf sample interrupts kernel exception or syscall
entry before the user registers have finished being saved.

> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 790389a15c3ce..2de7cdd3a8725 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S

[ ... ]

> @@ -473,6 +479,8 @@ CFI_END_OSF_FRAME entDbg
>  	.cfi_rel_offset	$gp, 16
>  entSys:
>  	SAVE_ALL
> +	.globl	__entry_save_end
> +__entry_save_end:
>  	ldq	$1, 0($sp)	/* syscall nr from saved r0 */
>  	stq	$1, 8($sp)	/* regs->r1 =3D shadow syscall nr */

[Severity: Medium]
Should __entry_save_end be placed after $16, $17, and $18 are stored into
SP_OFF+24..40($sp) in entSys?

Unlike non-syscall PALcode entries, PAL_callsys does not save user $16..$18
into the PALcode stack frame, and SAVE_ALL only stores them into
trap_a0..trap_a2 at 160..176($sp). In entSys, pt_regs->r16..r18 are
populated a few instructions after SAVE_ALL while interrupts are still
enabled:

arch/alpha/kernel/entry.S:
entSys:
	SAVE_ALL
	.globl	__entry_save_end
__entry_save_end:
	ldq	$1, 0($sp)	/* syscall nr from saved r0 */
	stq	$1, 8($sp)	/* regs->r1 =3D shadow syscall nr */

	lda	$8, 0x3fff
	bic	$sp, $8, $8

	stq	$16, SP_OFF+24($sp)
	stq	$17, SP_OFF+32($sp)
	stq	$18, SP_OFF+40($sp)

Since pt_regs_offset[] in arch/alpha/kernel/perf_regs.c maps
PERF_REG_ALPHA_R16..R18 to offsetof(struct pt_regs, r16..r18) rather than
trap_a0..trap_a2, if a perf interrupt lands between __entry_save_end and
stq $18, SP_OFF+40($sp), in_entry_save_code(regs->pc) will return false and
perf_get_regs_user() will expose task_pt_regs(current) before r16, r17, and
r18 have been saved.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D4
