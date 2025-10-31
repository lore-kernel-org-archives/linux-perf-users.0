Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4901CEAA3
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879054; cv=none; b=g6mzbD/K/Vkskbbl7lgp3la8KJBoLm8aIbvcLzev21B2vUqC6K4dCHfrxyFBXtwOkitdYqcDnIgEnxeMyM2qfHeyw4Jm9RVcy86EQkLqOhMfCug326UP7JaTEkFXb4Bv2SO3jz6aXxOHHIJ3zfqc3HYRiFAk9Juq2YlYAaTfJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879054; c=relaxed/simple;
	bh=qS8tf6ZdxD5YdgAohIV+PFDGE+5VuGWpefXJWTNedps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ommJlsG2JYRTcbNbcs4yivtmdLbIuEevOKsuWoCQTfCYuBzJalLupOb9r/iifz0LSt8DGMgyeTi+yBbEhzqBYtX4Cu7RzNWg5VJL92mwvo4/a9xTo3eoUWru4rQ70oFvkMylKHAUc398JXQCyxptDZRhxM8z+3YEzIBFgsHr8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5d980e08e06so1260969137.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 19:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879052; x=1762483852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDVU1PDXVKtyHtSPl3IIz+yw4eJmqS8Dvhc2np0RKUA=;
        b=MlzIMR55X2o9G+ynTVgAWOF+hSvJUgsJXHLf4rsw/MqSI4/Nw95HigQJrf/HlNcxuv
         kfMQ5xxDuwMF5nPBYyjg+SYnsdiUOPWfwmi/k07TIMEhuuPDNFaUtcHDokSaiHn2hpsa
         7eXE8l4Z4dVp/xsp7xyYQ+bPhKVD+tou4+J+FUIkvVLhOa54sldOYMCNFpOL3RA7GBym
         6qpqN/tsYn0Q18W8/w7YF2g8UwIAMunVYrJuJvzY4q8WucXnp8ZcTRMUVofyS+Z+CVno
         TrraA8YUpyNySK1Pu3H+iLbrm/am5DGuB8kQXkbl2VyAiiVkOIUgC+TI1IQT0gTeKeTz
         IPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUolg+qmUKgKHlEue1hjG5ZJeU92WWXN4MI/d46zZylMLFJZoytRnd5PdLRJrLj2xJVHAQDxTDE6hFtPGNY1TQp@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBu4004uYpvebGsJ2n4bPGGGbvV/de35zzB5aJp3r7h7mG2CW
	GQY0BW+abV6nH3ISRou5F50Siscz1mEyPCdMz/6sAFM3HYdE1GD3eoCUeawtNA==
X-Gm-Gg: ASbGncsHF41z/s6thFjk0FIktazSf27oHQZ6l+9qIbSZK1OGwjWVN/Nxb1kXHa09fgf
	TDowALR1grQELZP+yJQCqIRVneBp8hoNYnEb9ew/mwZ8GpAwElTo//e3Mlpt2vwkcdaxJWtXGOx
	taKN+TRXkdFAz0FkBIOTCpycavlK2gZ/rRszZMi4jaY0qdHAW3F/viaXw4Rtl6arK1tdDCSd+x5
	AoU/afpoaAzOlCMODAEFFpyr/rjznqHr/IrWnXnNiMzE3k/ENM4oRZsptDzKUgpyNSA0olfWbDt
	eXKSBu3hkoy7RLdI5uMHA3t3+WiiuvM3HvFXAvzOA/3DdGQooykwNEGn8rxx3k6oQ2Tt9hUjvvi
	72p7o3vRHxHgOriCIK9DWq67WjR9VVGFb9w+DVabgQwCCEKwUkXHDZcmPb506S4KcjmpdTa/PG+
	G597dF3By0bzl9VIhibgnoxpCDXDs8qT2wHDjStB8K
X-Google-Smtp-Source: AGHT+IEeES+EF8SnkNFuopAPBhLS96tqV8Z7wkUZJU1t1WaerCXCLYciGuVpEgTX61FFskx7lpCfgQ==
X-Received: by 2002:a05:6102:5122:b0:5db:23db:2ad1 with SMTP id ada2fe7eead31-5dbb12ef353mr582549137.28.1761879051414;
        Thu, 30 Oct 2025 19:50:51 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbb64bab89sm143535137.14.2025.10.30.19.50.51
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:50:51 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89019079fbeso929643241.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 19:50:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ/3ThaTlDbOw0VqudDx+Lvyn22rCKlza2CHKJOT8ssr/gJGNKbCbAIRFuq58K9zSbbQ5O4HGp7OUP5wUvNV3c@vger.kernel.org
X-Received: by 2002:a05:6122:2888:b0:54a:8cfe:193e with SMTP id
 71dfb90a1353d-5593e3eee23mr689960e0c.5.1761879050970; Thu, 30 Oct 2025
 19:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <aQMUGvXv6sy75nKn@tucnak> <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
 <aQMcYe5BK+Rsu3xF@tucnak>
In-Reply-To: <aQMcYe5BK+Rsu3xF@tucnak>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 19:51:03 -0700
X-Gmail-Original-Message-ID: <CAN30aBEvVbYh4bUerPSK3nk9VV=Szu845+PVww_XoU4gdMSJLw@mail.gmail.com>
X-Gm-Features: AWmQ_bkToldiXwOSFlKVHRT7mRZ7QErCYaHn1a_Ye5mYyw3G3dxbB6B8-BAj7j4
Message-ID: <CAN30aBEvVbYh4bUerPSK3nk9VV=Szu845+PVww_XoU4gdMSJLw@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Jakub Jelinek <jakub@redhat.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:06=E2=80=AFAM Jakub Jelinek <jakub@redhat.com> wr=
ote:
>
> On Thu, Oct 30, 2025 at 12:50:42AM -0700, Fangrui Song wrote:
> > An effective compact unwinding scheme needs to leverage ISA-specific pr=
operties.
>
> Having 40-50 completely different unwinding schemes, one for each
> architecture or even ISA subset, would be a complete nightmare.  Plus the
> important property of DWARF is that it is easily extensible.  So, I think=
 it
> would be better to invent new DWARF DW_CFA_* arch specific opcodes which
> would be a shorthand for the most common sequences of unwind info, or all=
ow
> the CIEs to define a library of DW_CFA_* sets perhaps with parameters whi=
ch
> would then be usable in the FDEs.  There are already some arch specific
> opcodes, DW_CFA_GNU_window_save for SPARC and
> DW_CFA_AARCH64_negate_ra_state_with_pc/DW_CFA_AARCH64_negate_ra_state for
> AArch64, but if somebody took time to look through .eh_frame of many
> binaries/libraries on several different distributions for particular arch
> (so that there is no bias in what exact options those distros use etc.) a=
nd
> found something that keeps repeating there commonly that could be shorten=
ed,
> perhaps the assembler or linker could rewrite sequences of specific .cfi_=
*
> directives into something equivalent but shorter once the extension opcod=
es
> are added.  Though, there are only very few opcodes left, so taking them
> should be done with great care and at least one should be left as a
> multiplexer (single byte opcode followed by uleb128 code for further
> operation + arguments).
>
>         Jakub

That's a good point about being careful with new unwind formats.
The LLVM compact unwind format, used by Mach-O, utilizes an
architecture-agnostic page table structure but has
architecture-specific opcode formats (i386, x86-64, and aarch64).
I.e. it does not introduce an entirely different format for each arch.

I believe the size issue with .eh_frame is primarily driven by the
CIE/FDE overhead, not the CFI instructions.
The inherently large size of a single FDE (around 20 bytes
https://discourse.llvm.org/t/rfc-improving-compact-x86-64-compact-unwind-de=
scriptors/47471/10?u=3Dmaskray
) is a significant contributor to overall size.

The performance issue of .eh_frame seems largely related to the byte
code nature of the CFI instructions.
By encoding locations with different CFI states explicitly as
different frame entries makes it faster.
