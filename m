Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D3216A02
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899640; cv=none; b=AjN1Rgy75YVKiw70rplIVUcH1ueimF71hwMvC5c+W/cRXIFXu4zBugAcfUMF1ugh1A9oPhKJg6ZEFh316v/pHQ0oFhdhSOeERDt4EK4kHVuvkC9hwtrukhDrS9c40T+iAWKqA8WgxpA+8e1y4YHEp54pPtb5LKlq9IEdWernLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899640; c=relaxed/simple;
	bh=26ch3VLdZlgASzApmc+sdmN42sQrSbzi8ri/yXB2hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzaMBzmqcMszDXdmIFp+zEL8NtCxao/nJKtn1ObSvWDsO1G8b31fuKt01xgf8cjhAnIuPz23xYswE0kWBsnBDVWLZnvv4x83fKM76nFEOqi64S9vS2ZdAwaA8cJx6iuQlFXXuz1lxeZKjnizSZl7EA+1Sya1CzgVWwtqTZoqxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rjb6hMTr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rjb6hMTr"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2facf481587so1743501fa.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727899637; x=1728504437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=Rjb6hMTrL7av1RJhOLuqijENuHyH8y3OsXbHFOVF+KTTeSz3K6XOA3QoTEWi/aHFUk
         +ka36RtInPVqZwpG/O8lr2SQj2SvIIOw8EnVmPefKCqwBt3r5XBHT4MkzeABG6jav+pf
         xmzwKqevXo0xxh5we8SXg8ZMnmYKdoYUAYryc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899637; x=1728504437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=RWQsjGgqfqt3ygewcjD9kSlE+dYLN24O4KWYQmX4yo/ydoZwmOELnR+yXbCom0/W4y
         uxjmHYtNSWKwPwBTmbDzDmq6iIsdWmJI2hZZwoUbTRK8rC8zHbsTi4/HuWOhD82EYoYf
         UTSM+iEJhD5sGJdTUw+ElobfCopH5c6PsCNZ11eiJ7MMR3V/4YnRlihVEjRk9ILKsBdP
         fbMpUVN5r7/0hNxHFLUhbxsUsc9HrlRp3So6PyHZ61BHnu6dM9piKxTPy7yMdVXX7WJI
         xhAE/Vhr4SOc5qTAGMV3dfeTxJgFIdG/CZIO1tgg87ewwERDLmlpd6f4B53v+n1iMXeG
         9h3w==
X-Forwarded-Encrypted: i=1; AJvYcCWMPsJrtBc3J0j+tTxQ8McX64e4aQJNEm4T7JhPdn5URdDkxw9VxlXTOsH4LnKVC329HpzkVJzECzX4ytLJkPua@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hyXOZsbzxObixoa3PSube96yVpHdIlx0pRWk8/nrKndjB9PW
	cQg+EK43VFaHOqwAQj0xSfehCnLQCIW7UVyOmzoYVFI/ThmlF2GWMs6azhUBLvtReU8b+cbGAnc
	bmbuVsQ==
X-Google-Smtp-Source: AGHT+IH5O23fbY1PYxYVlL1DZQGpYhiGAWQNXoE+3qmfALM5gtLZvsNsIegFpbFVYzuqvmHDGVdOmw==
X-Received: by 2002:a05:651c:1509:b0:2f6:6074:db71 with SMTP id 38308e7fff4ca-2fae1018f21mr27832261fa.17.1727899636479;
        Wed, 02 Oct 2024 13:07:16 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a330sm7936220a12.21.2024.10.02.13.07.14
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:07:15 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so1209605e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 13:07:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrP5IDvopNOI1KP5T/QyUzHEv/Li/3nrBPZ2UQG53tD9s7DzrUMH3sGz6HKFdtOE3BeOuEZkLVy1rRTMa3A8TC@vger.kernel.org
X-Received: by 2002:a05:6512:e9e:b0:535:6795:301a with SMTP id
 2adb3069b0e04-539a079eb59mr2506573e87.47.1727899328912; Wed, 02 Oct 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
In-Reply-To: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 13:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I guess you are referring to the use of a GOT? That is a valid
> concern, but it does not apply here. With hidden visibility and
> compiler command line options like -mdirect-access-extern, all emitted
> symbol references are direct.

I absolutely hate GOT entries. We definitely shouldn't ever do
anything that causes them on x86-64.

I'd much rather just do boot-time relocation, and I don't think the
"we run code at a different location than we told the linker" is an
arghument against it.

Please, let's make sure we never have any of the global offset table horror.

Yes, yes, you can't avoid them on other architectures.

That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
feel are a complete no-brainer and should be done regardless of any
other code generation issues.

Let's not do relocation for no good reason.

             Linus
