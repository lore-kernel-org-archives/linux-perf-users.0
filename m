Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694111;
	b=miLO338DOCtVnBDUrXsqHtvRavV+mDoqNtDINUDDCKvUiNgQKujD1++elrT1qCaOX7Pw
	 OTJd7bAwSKoKkgc5Ik94S+5FcPLeOCeK/CAhOihGXY4vi/p9kjWYEJpv4F6t6kdwplclU
	 EMrQu397USA5BGK6gdl7UmhrMnfOerHrJ36CHx9lE08Ky54w7b58iNhkp02Mpo5TD9uW4
	 hRdaH4/2mtRwDzftp+6Y8hguqQV2cgMMo3ftlXI1U7Lp+rFZy1AsixD40pMi3EjiWEY3P
	 O9UHjhw3sbaFoT6jG3QcM/1CfHqW3PE4d+ac4CRJO2Vrm1oNELUxeqL057Km/Q1t8fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694111;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UOmomCMA6I+lQ/IH2QNpH5bVl5gG63cZDqNjeaVeC5I=;
	b=lKTSztpGCQ3cBR89UCuVDYjiwH5cpWQ7+m6BzUwgFG/2NNEVrZn8ZJnPE7y/YL41Npfy
	 76CmMMTfyISi2nqF8OJC6QU1VJsGobmw14qfzTENWUzjAJzNm9bpCrX7oO+hOPQdf+W7j
	 4rMUyjdFcT01qD8IbiRVlRKvqu3uudcnYp5VwpbYu2s/Ohv81ype6zIahDVHsMU9epa+V
	 IUpm5Qcha0tT56sk0W5kOjMiqdv6USY7FtXHvWoF1VFxBGOl4CwCsTTJuQdu3+z7rgDdT
	 jNgMM4K7ACtEFeVrIx60OD8WdeXnUcOciDZdUzir5XIq5Z0b5Mdm/HkLHXxtycyH7pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abZinJOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E660A2608
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abZinJOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C924C1F01829;
	Thu, 22 Oct 2026 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694110;
	bh=UOmomCMA6I+lQ/IH2QNpH5bVl5gG63cZDqNjeaVeC5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abZinJOLQufxrQSaeRBc0MCC1iqQYPihb+KE1NyjoOOdJxWD7fEL/htaqQ1LouoIY
	 tZTKjh+EtvOeso8Js6uzMFyukUjPdWcOYqtvtL7uA5EvJiWcmZ+HTDOS3If2eOMcv6
	 GodhmdTf5XF14gXYcfNf397XzR5jJjOM7FKtM+9gVB1BQGi51JUcJlhJwO1msuX668
	 4z79ACv4uhrxXly7LlMeXnmCI3tl4k1JpveiME76USxb0yLWt2dfTkVgewHNIVD89E
	 wAxWU+pyYvQ1JMYcU4LnDOHdoPTKzquhEyWOAusTOdHbfQGQ45Smo7n/7jF7irkVRk
	 LramUmo1Pl00A==
Message-ID: <sashiko-outbox-181928@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] tools arch x86: Sync the cpufeatures.h copy
 with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-5-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:35:10 +0000
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
- [Low] tools arch x86: cpufeatures.h out of sync due to unmerged commit 87=
db7795cbaa
--

commit 473988ac3b0546cf1a165c42132612c34c2cdad9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

tools arch x86: Sync the cpufeatures.h copy with the kernel sources

This commit updates tools/arch/x86/include/asm/cpufeatures.h with new CPU
feature and bug definitions to keep it in sync with the kernel header and
silence the perf build header check warning.

> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/in=
clude/asm/cpufeatures.h
> index 6547c0aee45b7..fe84cf4e97d35 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h

[ ... ]

> @@ -465,6 +477,8 @@
>  #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Break=
points */
>  #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNE=
L_GS}_BASE is non-serializing */
>  #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing=
 / synchronizes RDTSC */
> +
> +#define X86_FEATURE_TLBSYNC_SFW_NO	(20*32+ 4) /* TLBI Erratum #1718 fixe=
d in microcode */
>  #define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mi=
tigates TSA */
>  #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears=
 Base */
> =20
> @@ -575,4 +589,5 @@
>  #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Tran=
sient Scheduler Attacks */
>  #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected=
 by VMSCAPE attacks from guests */
>  #define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmc=
s" SEAMRET from P-SEAMLDR clears the current VMCS */
> +#define X86_BUG_TLBI			X86_BUG( 1*32+12) /* "tlbi" AMD TLBI Erratum #171=
8 */
>  #endif /* _ASM_X86_CPUFEATURES_H */

[Severity: Low]
This patch adds X86_FEATURE_TLBSYNC_SFW_NO and X86_BUG_TLBI to
tools/arch/x86/include/asm/cpufeatures.h to pick up the changes from commit
87db7795cbaa ("x86/CPU/AMD: Fix AMD TLBI Erratum #1718").

However, commit 87db7795cbaa is not present in this tree, so
arch/x86/include/asm/cpufeatures.h does not contain those definitions:

arch/x86/include/asm/cpufeatures.h:
    #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializin=
g / synchronizes RDTSC */
    #define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW m=
itigates TSA */
    ...
    #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affecte=
d by VMSCAPE attacks from guests */
    #define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vm=
cs" SEAMRET from P-SEAMLDR clears the current VMCS */
    #endif /* _ASM_X86_CPUFEATURES_H */

When building perf, tools/perf/check-headers.sh compares
tools/arch/x86/include/asm/cpufeatures.h against
arch/x86/include/asm/cpufeatures.h and will continue to emit the header
difference warning.

Should the X86_FEATURE_TLBSYNC_SFW_NO and X86_BUG_TLBI additions be dropped
until commit 87db7795cbaa is merged into this branch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D4
