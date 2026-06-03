Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBD33CEA9
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500160; cv=pass; b=GkL9yX0S/X4VfTcJxeC8Mnc4UrdpWMfyKDVs0k9mbKbMJtVZ+OAGw46V3WSLIaS03QDtjlzx+P5ZFZDU/aM4CH75kGprvTDF77vSrihWiTf912k8blG3dxjSDUivavbykY0PJSjEE7UQr8d60kOwMzuz/HqIIuEW6DoJa08xOh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500160; c=relaxed/simple;
	bh=ZjY6fQ+OkNX+QIentfTAZom0dvP2zmSMpC0L4vEq+8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m32w7Pflv8atR9/iDS2ORMrTumPDmJVZ8wT7CmEDbFRJLsbRjE42LvqP1DO4wdyuJOfZgOcPe9CqUtM6rYBJOjHzQlPx9+xAE9MXZV5tS1V3qW+n9ZAWHb1SjtmhIchoiPe8/e8vdiKXM2VxAdTwQE48Tyk00uJSlTFiE17rLhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKl1IEen; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKl1IEen"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0b1a48855so99185ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780500159; cv=none;
        d=google.com; s=arc-20240605;
        b=BO63Xwz6GWB5fvaBWaFJjv4juhrTZgwaz0wWr2LfYftNhCTdKEDJ4CWIQL8sGdiHcy
         7M7QKcndITo/oqX5YK+SN4bJluxjptvxS6nQRwa0lP2bev9TwV145nb1i+9Acwbvsn1C
         36dSvtQEWGf26bHBwjCxYIWbEnCHAzuhbgYVYsAQjRM8AlaCGxpePL5Ex2YkLUlBqXoP
         txcGVgyMRy7mbDVf2PCH73h3TLPjWAw+ApMj0E2xEuXEkGioGka7jUF8frwU82BpGRDZ
         ieEIXXeLiws8GRPO8a8vuAWBKV80qGx2oMJ25Vd11aJf/MpcYWv71TyzyUonuCT/dvWL
         xiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXS7+Fhu66wBwMI3PFTaspq6nORkh9aykIM9GFqLrSU=;
        fh=yDU8p4VBVGm6ejOOOJOgop43UicYMlGlDYwNPTyx5ow=;
        b=e9PBrNfwaHqMh06AezKJGYX9v+t+u8jdJjlvfVXjcbY3hilraDBxft8dQ1mx25oVDn
         x6W13XIkxILx0KHcKXdn3glJOAxuLG4hV118n/QTfg4pyTGmLW6zxTkkMGThqFJDymgl
         tLRAICK8bmGndD7vADY5rj3XcugQt++Is/YEGmh9fYbaKVJwMyFVTjYZldh22a7W+TvO
         mqgUC4EgWZk+I5iY480TMVemKjWX5ItwPpDIB34DrHIDC31u8U8DGbCGnCVv9aquI2Zs
         OjFTVYVUUo2rVSTo7qcTvS/BliBwM/eMVaA/Kh+wceoG8Jg6Dzb2h0Mqd4TS+lb2yMt+
         Fx1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780500159; x=1781104959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXS7+Fhu66wBwMI3PFTaspq6nORkh9aykIM9GFqLrSU=;
        b=GKl1IEenFoXE4HMA9CPvd2HwiwnPdqWUfl17QortVDe6JVTBhzLimpq030XKldJBfI
         OQ4emfzApbw19fSQYPYS0p1lQR7Dr/JEOSuXRPMrj1byYwaEdlnmOwWsg8ImywGbm4Xl
         oq36jdQEAvPbqpCYy4YM2FoF7S4Drqh5/W3L+ziB9+fVMritGNLI4dpSqiQAnXymxa7z
         iePgyzS1d/H61bdXdCK6PfzcL/O9wRJKTKlXDZusZVVAQoEv6TdptKnl8GPeW5sFX6YI
         02D++SkXdE93/RB5EVGn3aa5nvr2v/DFi617OppYBYorPE1qmOIjFxj2ZjA+QHywL9tV
         QfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500159; x=1781104959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXS7+Fhu66wBwMI3PFTaspq6nORkh9aykIM9GFqLrSU=;
        b=cfxxcxUUnvy8Xc7A5JmhhO0/YnDlEPUt/nt/QV3sj7SgYu064DJ78U7N6y4XcMhjqr
         r8kc0WkLfyp4PN0GA97NS1DeV0Uu13gb3mZ/l/NMfO9wKQgQyGZPxHqAwYkwuvEw+fs+
         irq42C2un+Yyb2gFFyBWc6EONYkzJyzgf2G3LdNyauwOHeV5bnHVID0DccNA0boT5bch
         yysDwQ3mKInTz1L9AvZ92+bbVQekQANLsDuU7G3NXZpCq3aSjOMXNxscEsJUii/Isui2
         tnfqy+ZvTWfOcBr/uaiqZYbcQB1BWVuV6tnXh4A/oGYD8t/6xXMkOO8KgRoQYAK7TlwB
         uKpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TnYq6UsTxp6vBITHHg1SvQ52CNhMURmHNbRFdj5ZOXu0GnPuMqpnM00oSoqpDylJCeBi/GKVzVDv4fJsfDVMC@vger.kernel.org
X-Gm-Message-State: AOJu0YzFovZc2gvmI2V6GuKy0dMMO4+BSiATZDm5baAiji/n4a9qfVAc
	1/dQhmXdlS4PTOH/RY7iTww/8RzcltJVhrpIm3IW1Dr8u9DlRR/fVET9aWa8ZAi6UTKLUFsLqLx
	pfDelX2dEuSy1KhVfAiMRnnODZRYZI9eq96BZjDYi
X-Gm-Gg: Acq92OFJ4lIAlFmomKxMrsO/qyxTHQqMrgqCHa5Quxhq/+y11+7UgY7qUMg1M44zFab
	5heyF4lIXEqg335ee1Hm0obWHGphEmo3W5Fmp7h5lB78nkW5DF6Oy+/P8UOFedTc74htwNasW/z
	IbnCFygFRq3BhjEzs8CWEZciQnn9r3RSThrOt8dimGWkApDruhZn2de1N0ynudAGIZezDmD1q6x
	TN/YGOpB6i57a9t9haWdgcFnJXg4TzlRIP6OV8M6gMW6JtOjlwCy4bxU1xXvbPqq5sgop7UVrFw
	zSD5EetB5vGL39At2xMFCZovDlWeNgQ6hbYEuh+IFihy/+KQ
X-Received: by 2002:a17:902:cec7:b0:2bf:1153:54a0 with SMTP id
 d9443c01a7336-2c16fb3ed38mr1992775ad.23.1780500158452; Wed, 03 Jun 2026
 08:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520125637.105681-1-japo@linux.ibm.com> <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1> <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
 <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>
 <ahddRWPBk46HiR6x@google.com> <CAP-5=fU8HLj73_FJJfzAF2pVnu8KentCWe4cLWbrjJa5ihRGfg@mail.gmail.com>
In-Reply-To: <CAP-5=fU8HLj73_FJJfzAF2pVnu8KentCWe4cLWbrjJa5ihRGfg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:22:27 -0700
X-Gm-Features: AVHnY4IDwd410SWcTTt8MXyZnDLhkzJUmRu62LLuYKbnF91nRhMxlwjLWIAbCuw
Message-ID: <CAP-5=fVLPp2BF4gp5yM4Nwf1mK6Lp34bHxqKvEBf9B5orVu3dA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16 hardening
To: Namhyung Kim <namhyung@kernel.org>, Jan Polensky <japo@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jens Remus <jremus@linux.ibm.com>, 
	sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> So what I think the problem is that:
>
>   arm64__associate_instruction_ops:
>     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
>
> points at the arm64__associate_instruction_ops code:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/annotate-arch/annotate-arm64.c?h=3Dperf-tools-next=
#n79
> ```c
> static const struct ins_ops *arm64__associate_instruction_ops(struct
> arch *arch, const char *name)
> {
> struct arch_arm64 *arm =3D container_of(arch, struct arch_arm64, arch);
> const struct ins_ops *ops;
> regmatch_t match[2];
>
> if (!regexec(&arm->jump_insn, name, 2, match, 0))
> ops =3D &jump_ops;
> ```
>
> jump_ops is declared extern in disasm.h:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/disasm.h?h=3Dperf-tools-next#n117
> ```c
> tools/perf/util/disasm.h:extern const struct ins_ops jump_ops;
> ```
>
> Since `jump_ops` is declared `extern` and would be patchable in a
> shared DSO (i.e., the Python module), GCC is creating relocations
> within .text that fails W^X checking in the linker. To prevent
> jump_ops from being patchable in this situation we can change its
> declaration to:
> ```c
> __attribute__((visibility("hidden"))) extern const struct ins_ops jump_op=
s;
> ```
>
> but it is probably easier and more generic to add -fvisibility=3Dhidden
> to the CFLAGS in Makefile.config. I asked about this behavior as an
> EXTRA_CFLAGS option, but I'm not sure if Jan has tested it yet?

Hi Jan,

Did you get a chance to see if the hidden visibility would resolve
this issue? I can propose a patch (or someone else can) to add
-fvisibility=3Dhidden to the CFLAGS in tools/perf/Makefile.config.

Thanks,
Ian
