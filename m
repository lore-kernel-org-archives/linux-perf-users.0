Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA33ECBF9
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689225; cv=pass; b=C9j4MidybZa/CoAzPLRlUDe53e01Z2jK+0+144G9l4SxEXFqel35PYVoQeUdCgHE8AMyMqeAtSqn1NerEayFtIz7R0V+a221efogQQ9IA+4AEJSy+puWJAw8it+HZ1S7mUdvaozvkTwXPgLGLUujc6rV3xBBKGvgjjqMB7nT03s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689225; c=relaxed/simple;
	bh=oqDnC9O1HHbTztUx1VQNjOXbFdrM4R780qfSQSeVJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIaMcp/ks8V6PyAKlSvZqNgAYQpn6xQ8pjoLI07f26HKp+vo3IcWfa5zUxqbkngscrWv4nFHOz7ZUdRkFnBrlhmWXpXtK7d8dJisPtPDuLwMefxRLa1Hl6O/KKIETAGa/2lJTEMFvGlJmZdgJQPU+YEy0DXmcgsAv+MYXbdBJeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEDja6Jl; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEDja6Jl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso4345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689223; cv=none;
        d=google.com; s=arc-20240605;
        b=kk7Pu3RTe30gMW0RPfGC81KTGSzs/GibBOnJTu4mwmwKwt8fgJNwEp7fs5sSaNJYeJ
         7yLaIDfpomOgaFBzeBBOkF0IdjMjNnOLfNA21EhK798vgtAgUdmOv1r+u0iXGHMXN5SZ
         VyI2Bt86Cs2nA/fTtZHdc/5pfGAEmYoY4SSLow3kxlu/SkVFRApYVg0wZbzd/d/h7IS0
         q9Q3nhDfa0jFOzvmS8KzgxNVUcb8Na0UvOE7b6zu98QlKwi7uvbvEgB9DzPfWRkOxx+h
         xYAM52oSsH991MwU9pSPYp5x5+2P/+jWkQqM72HfqTREHIudSrl+uFUdOZaxnG+KKq41
         dtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gesujbp+9VPzg+sNjC3SXEPNRKdatpcV5h7/VQM/Pv8=;
        fh=cPFfNJ5IVJdhjyPw7k5X84CqgKsSN4VksFAwd6w+McQ=;
        b=bC1nmFcyXDHiEBmd2x1kejbZ/IpAGhhje5sxdJkf2OvbfNCcEbXxIi10URHa6xIj4o
         zn2KACIevejREF8T8gaACKTnt6uD89PeAHA2x1tr/w9H/s/OrFkDR4S+/tIG5Xtz1810
         j1gvHJnA1gwNMz8X5PKZtd0D1Eq9D93VP51h0x2OHg0+/1u4NPLEjJ7AulKyfnet7eAL
         cg/MDTX8tznUhKNEwthrAyK1D7knKET7reWFrCVYrMaPadappLsMN2NaU2egKazbpHdZ
         q2H+DcVori3ha12RpnQQYZPAUkCUS5yh6QXIdhuHvmAo0EOBGlYGjbAlmHt12fVE8opl
         chQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689223; x=1779294023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gesujbp+9VPzg+sNjC3SXEPNRKdatpcV5h7/VQM/Pv8=;
        b=tEDja6JlvuVPpPVVxL/Up8hYMJhBH4P4F5wv5swxhM8FCoJt8f5b0zzUcZ2ajCbpld
         JLpJ6MthOONFrMesCB7LHQ7c+v1hKyW7J4oEJ0XCwfSIQd1XBGY+YyKi1NPcYulwQ0w0
         5oxhBtqy37rl6xnm77CFpEjrgUj2D2hFb4ZmnupTjY7cFP8lW8eAWBcf0VC1LDwpuc0l
         x5JomB0UdlFpSlGOvBusLgP5RazqyGhKEt8xandMyl0sP9EeyMQn8svyEeFDXhgi2wPy
         LzYSKf0dR1YR8zVN2bYA3JNfMFqUD9V20rG48U/Yhqjk/soppuj8vHrdCsWmax4AxO04
         HN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689223; x=1779294023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gesujbp+9VPzg+sNjC3SXEPNRKdatpcV5h7/VQM/Pv8=;
        b=S0uTDmINPRA/g4kK33znlyb/PFC3nKK/4ZWxrgWPY7HVkZKwtlR/1J5EkyIZCgigAB
         bEI7p2JKUMQ8XahUmrxNSeSeWf6W7RiE5MCufutnIjiE9x/WggiTVruH2lH7uM7lfwhy
         yyfXMTu9XTL1of6YEMxRBcfz8T2TAlyP05LZXzYNi4As/TKEAFm12FCgS6R8uqKuOWX7
         UonG5wRkcYVzU0AKnyR9y0jlaSVikwEsWGJrNcJ8dWDFZtAlGaoKbz6W8RmYjvlmThVB
         czbtnPn9dmeCgI4Xpy1t8lc9XW5GEFR2dtiKq0QE9qH8Y7LfToQ22JOjqMuoF7KdgE4d
         6dzg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZJiza/lE0oU29qTkt4VrVhPp8+2OeMqSux0jFOAVWL5q4r95hDzOZZGZlVPaFc7QV2s5Nfj/luwJuNwLFMfPg@vger.kernel.org
X-Gm-Message-State: AOJu0YxerHmiCuU1EbW2CbV1Em4DQ3ozGA+SthdZbH/B2TXyw1wQpYiW
	LCMoyqWu0k3U8hT3sbn84TYYPoDWfnnU4/gHG8s2s5J81jIdeObe77LZyIzkjIx6LUMFd+2uRXc
	TUlHDJlHobEl1Ddmu7ju9FW8ywdMpWq8GdAMKGHp2
X-Gm-Gg: Acq92OHNdOfZsMqiYpGDaHbjV6pD8nAxkHifMifEOMtFBp81abonEoR/2HVikpK+B9+
	VayC4DfoDllLM4bk/B5/Jj1xQ19nTmWUrnttjLjCmaJub2gI8aKlPawC7idMeJF/MVrpMpntg9F
	unXOlB0p/ch49XgPP0fW4AE/ZW+WMDX8eLi1Dd96shB1dr2KRG2feXys4tj54DFPxUrYA7J7uCI
	c9X4ywhsl3FVw7pWKn6VEoR6aTGPSNVjbIlRghfkfRzyAnjOFDU2aVBR7dqpP3dWeA8ss8U7YZb
	Bt0tYNcEGC14rlhjIhcgeYFQF8Z9UkYlbFdhU5z1UlKurRn+
X-Received: by 2002:a17:903:2781:b0:2b0:5e19:1862 with SMTP id
 d9443c01a7336-2bd2c0e9c72mr2300165ad.5.1778689222811; Wed, 13 May 2026
 09:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn> <20260513154851.1085334-4-guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <20260513154851.1085334-4-guanli.oerv@isrc.iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 09:20:11 -0700
X-Gm-Features: AVHnY4Kk98DUbkHHWrvSvtIuGqRXY1KK3USIkVcwLWJvCSIgTVFGP0GHIUb5acM
Message-ID: <CAP-5=fUs0q5WQCEW-Hz2fyunsr73cnNFicUFLvU73BcPYB0u5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf script: Provide weak stubs for instruction decoding
To: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	palmer@dabbelt.com, pjw@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:50=E2=80=AFAM Li Guan <guanli.oerv@isrc.iscas.ac.=
cn> wrote:
>
> When cross-compiling perf for architectures that do not yet implement
> hardware-specific instruction decoding (such as RISC-V and ARM64),
> the linker fails with undefined references to `dump_insn` and
> `arch_is_uncond_branch` in builtin-script.c.
>
> Provide global __weak stubs for these functions to ensure successful
> linking across all architectures. Architectures that support these
> features will automatically override these weak symbols.

No don't. Weak symbols are the devil's work (they are outside of the C
specification) and a time bomb set to explode during an LTO build. As
mentioned earlier, these functions should use perf_env's e_machine and
arch arguments so they can work in cross-platform settings. I believe
you've broken your build in interesting ways, but this isn't the fix.

Thanks,
Ian

> Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
> ---
>  tools/perf/builtin-script.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c8ac9f01a3..80a8f0e80b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4608,3 +4608,25 @@ int cmd_script(int argc, const char **argv)
>  out:
>         return err;
>  }
> +
> +/*
> + * Provide weak stubs for architectures that have not yet implemented
> + * instruction decoding. This prevents linker errors (undefined
> + * references) on non-x86 architectures (like ARM64, RISC-V) when
> + * building perf script.
> + */
> +const char * __weak dump_insn(struct perf_insn *x __maybe_unused,
> +                             u64 ip __maybe_unused,
> +                             u8 *inbuf __maybe_unused,
> +                             int inlen __maybe_unused,
> +                             int *lenp __maybe_unused)
> +{
> +       return NULL;
> +}
> +
> +int __weak arch_is_uncond_branch(const unsigned char *buf __maybe_unused=
,
> +                                size_t len __maybe_unused,
> +                                int x86_64 __maybe_unused)
> +{
> +       return 0;
> +}
> --
> 2.54.0
>
