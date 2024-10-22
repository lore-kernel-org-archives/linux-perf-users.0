Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EF1BE23A
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618791; cv=none; b=ioA0R90fvevbHNMYbFrjFwIAowjp1edbR64j0/KY23tYw/3Zx0Wqg97xWAk8EMr0IprN5ezNhPIX3i9UNd1m4ytbM94fAGlcISbK8k7LjKCTgh3P73ONkTpOmPlhz21MRRW/GN6ZjaNfYHNgclYc8+h6V9mhaTbPIy9TpDmzTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618791; c=relaxed/simple;
	bh=tfqcQLTeImNqZ/dTSL8rjfpyWnAv3T+qgbr+HElPBqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnJO6yh2YXmclxZK5vL83Rbo8CyxB/Ua2rnGJ3HvBm75TEnWwHUZxqzKRa+g0iNttixqP5XC7ZGI8znchcMzcBMd4b49D/83AwuhUbW1r/x8Qko+w+7NwCJuDoa1hniXDJlARxFpIlvf0VK6tfwf8jSixxvIYx4h1MNESXJCwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUT3UAyh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUT3UAyh"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460b295b9eeso22031cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618788; x=1730223588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDHRg8NIKJDTLo9xK8tFgj2qyUrzM0Z23IToFFRvpbY=;
        b=PUT3UAyh519bmoskdp1LMVypaivA/3g6Sxw7MXvd7f2zhHt3/V3NUgNDDHCQ1F32c5
         SGO//nfInqy8ylAfNPuRe45Ew8Sg21vuEo7+jPvTrDxKgBj8ZF3czZ5x6dfEtt07F8K5
         Fa28jGZVDAKEtgcZ5SFqFUKlxb8YKPlRJHCieObGwwX1lEevAR3OmoLyVS3A3ihYVK9O
         WI+5zaq9KB8Wu5YOZ+tOSsSveS2R03zB6PqLxI6VUzpzjD8X9vaSUvZS0MN/s96XRtsR
         JRTLFpfWkm7VQkQHV9Ueqid12/fQOEkGYOyoTNEht8i8/OyG39+R9ZIGWyFYleidWX3r
         Yzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618788; x=1730223588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDHRg8NIKJDTLo9xK8tFgj2qyUrzM0Z23IToFFRvpbY=;
        b=CI/03JuzCtXSEeZ8tEIQPSnoZiqFKKa1OMgC/M2n0xoVBTEVQ92JAZndWtFHwN5p7p
         WdPHYUzv2ueWZPiXRhNbTVo0pmUKI4Mw4tvLXUfXo/Swjz67wmKnAAP/pVuNTZwbFiT0
         J8m/8P/XwrbrzzXj10XiIOl/ER2Sfw9XjRbs4R6OF+UVJs02vEBD0DoPwxFj3FwFr8GF
         VMBkSv3LV8xR0q3w039uL0BcIW5/YS52TjwLPjMJIktBITiax33iEgOfRcxcmCCsDgMr
         bNEvCfbL/8wwSqDHVTj7g/ePOEM7cq691AKMANQsV/P6AJn4APAQWflFnDUGDjFLQbKc
         iO3g==
X-Forwarded-Encrypted: i=1; AJvYcCWfgC3SFL/KZ7jZT9sjsTEcENlKg0c16HXNsF62/ZmKeN4nkjrCkeZYGamW8ZNfM1yJCZduO2VJkZeYRWNlrFMG@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYQIH5TsC6dBGP/CZton6x2AzwkIYL2Z3DYshN4ME5PZkBlUP
	nN/LbwDzQJt78O/VS7Yt1+YXMBPXxEuadg7vzCwBuPj1RfV3PVGyfhuAd1JTbNsnDeXhSedTUCZ
	X3o5ZZ0AcLckI/D1U20H67G//ocjcANRzQmVZ
X-Google-Smtp-Source: AGHT+IF8WqI392dhZO4Ni0adr9KA7j3Duz+98CmVrJXy3V3O1PWAWFk7qSL3uTdgZCEIB3FTgY1BKDnlhAXH5bCgGHo=
X-Received: by 2002:a05:622a:1443:b0:460:e2d9:b745 with SMTP id
 d75a77b69052e-4610247e0ffmr4211801cf.3.1729618787827; Tue, 22 Oct 2024
 10:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018055627.1005723-1-irogers@google.com> <Zxc6_jZdDcWgtEom@google.com>
In-Reply-To: <Zxc6_jZdDcWgtEom@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 10:39:36 -0700
Message-ID: <CAP-5=fU04PAN4T=7KuHA4h+po=oTy+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com>
Subject: Re: [PATCH v2] perf check: Add sanitizer feature and use to avoid
 test failure
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Oct 17, 2024 at 10:56:27PM -0700, Ian Rogers wrote:
> > Sanitizer builds can break expectations for test disassembly,
> > particularly in the annotate test. Add features for the different
> > sanitizer options seen in the source tree. Use the added sanitizer
> > feature to skip the annotate test when sanitizers are in use.
>
> Can you please split the perf check changes from the test change?
> It's good to add an example output (of perf version --build-options)
> with new sanitizer features.

Okay, will split/add in v3.

> Also it might be helpful if you share how the test fails.  I don't
> think the disasm format is changed.  Then it probably missed to find
> the target symbol in the first 250 lines for some reason.

Sure, the reproduction is trivial, just add -fsanitize=3Daddress, so I'm
surprised you're not already seeing it:
```
$ perf test annotate -v
--- start ---
test child forked, pid 444258
 68e8a0-68e96b l noploop
perf does have symbol 'noploop'
Basic perf annotate test
         : 0      0x68e8a0 <noploop>:
    0.00 :   68e8a0:       pushq   %rbp
    0.00 :   68e8a1:       movq    %rsp, %rbp
    0.00 :   68e8a4:       subq    $0x30, %rsp
    0.00 :   68e8a8:       movq    %fs:0x28, %rax
    0.00 :   68e8b1:       movq    %rax, -8(%rbp)
    0.00 :   68e8b5:       movl    %edi, -0xc(%rbp)
    0.00 :   68e8b8:       movq    %rsi, -0x18(%rbp)
    0.00 :   68e8bc:       movl    $1, -0x1c(%rbp)
    0.00 :   68e8c3:       cmpl    $0, -0xc(%rbp)
    0.00 :   68e8c7:       jle     0x68e8fe
    0.00 :   68e8cd:       movq    -0x18(%rbp), %rax
    0.00 :   68e8d1:       movq    %rax, -0x28(%rbp)
    0.00 :   68e8d5:       shrq    $3, %rax
    0.00 :   68e8d9:       cmpb    $0, 0x7fff8000(%rax)
    0.00 :   68e8e0:       je      0x68e8ef
    0.00 :   68e8e6:       movq    -0x28(%rbp), %rdi
    0.00 :   68e8ea:       callq   0x2adea0
    0.00 :   68e8ef:       movq    -0x28(%rbp), %rax
    0.00 :   68e8f3:       movq    (%rax), %rdi
    0.00 :   68e8f6:       callq   0x28fac0
    0.00 :   68e8fb:       movl    %eax, -0x1c(%rbp)
    0.00 :   68e8fe:       movl    $2, %edi
    0.00 :   68e903:       leaq    0x66(%rip), %rsi     # 68e970 <sighandle=
r>
    0.00 :   68e90a:       callq   0x27e650
    0.00 :   68e90f:       movl    $0xe, %edi
    0.00 :   68e914:       leaq    0x55(%rip), %rsi     # 68e970 <sighandle=
r>
    0.00 :   68e91b:       callq   0x27e650
    0.00 :   68e920:       movl    -0x1c(%rbp), %edi
    0.00 :   68e923:       callq   0x2086e0
    0.03 :   68e928:       movl    0x18aca72(%rip), %eax        #
1f3b3a0 <buildid_dir+0xa0>
    0.00 :   68e92e:       cmpl    $0, %eax
    0.00 :   68e931:       setne   %al
   50.02 :   68e934:       xorb    $0xff, %al
    0.00 :   68e936:       testb   $1, %al
   41.28 :   68e938:       jne     0x68e943
    0.00 :   68e93e:       jmp     0x68e948
    8.67 :   68e943:       jmp     0x68e928
    0.00 :   68e948:       movq    %fs:0x28, %rax
    0.00 :   68e951:       movq    -8(%rbp), %rcx
    0.00 :   68e955:       cmpq    %rcx, %rax
    0.00 :   68e958:       jne     0x68e966
    0.00 :   68e95e:       xorl    %eax, %eax
    0.00 :   68e960:       addq    $0x30, %rsp
    0.00 :   68e964:       popq    %rbp
    0.00 :   68e965:       retq
    0.00 :   68e966:       callq   0x2086f0
    0.00 :   2d6910:       endbr64
    0.00 :   2d6914:       pushq   %rbp
    0.00 :   2d6915:       pushq   %r15
    0.00 :   2d6917:       pushq   %r14
    0.00 :   2d6919:       pushq   %r13
    0.00 :   2d691b:       pushq   %r12
    0.00 :   2d691d:       pushq   %rbx
    0.00 :   2d691e:       subq    $0x48, %rsp
    0.00 :   2d6922:       movq    %rdx, 0x20(%rsp)
    0.00 :   2d6927:       movq    %r8, 0x30(%rsp)
    0.00 :   2d692c:       leal    -1(%r8), %eax
    0.00 :   2d6930:       cmpl    $2, %eax
    0.00 :   2d6933:       jae     0x2d6b2c
    0.00 :   2d6939:       movq    %rsi, %r9
    0.00 :   2d693c:       movq    %rdi, %r12
    0.00 :   2d693f:       cmpb    $0, 0x1c5f99c(%rip)  # 1f362e2
<cpu_bitmap+0x122>
    0.00 :   2d6946:       movl    $8, %eax
    0.00 :   2d694b:       movl    $1, %ebx
    0.00 :   2d6950:       cmoveq  %rax, %rbx
    0.00 :   2d6954:       cmpb    $0, 0x1c5f989(%rip)  # 1f362e4
<cpu_bitmap+0x124>
    0.00 :   2d695b:       movq    %rsi, 0x28(%rsp)
    0.00 :   2d6960:       je      0x2d697e
    0.00 :   2d6962:       leaq    0x8e9708(%rip), %rdi
    0.00 :   2d6969:       movq    %rcx, %rsi
    0.00 :   2d696c:       movq    %r12, %rdx
    0.00 :   2d696f:       movq    %r9, %rcx
    0.00 :   2d6972:       xorl    %eax, %eax
    0.00 :   2d6974:       callq   0x2c18c0
    0.00 :   2d6979:       movq    0x28(%rsp), %r9
    0.00 :   2d697e:       leaq    -1(%rbx), %rax
    0.00 :   2d6982:       andq    %r12, %rax
    0.00 :   2d6985:       leaq    (%rbx, %r12), %r13
    0.00 :   2d6989:       subq    %rax, %r13
    0.00 :   2d698c:       testq   %rax, %rax
    0.00 :   2d698f:       cmoveq  %r12, %r13
    0.00 :   2d6993:       leaq    8(%r13), %rax
    0.00 :   2d6997:       cmpq    %r9, %rax
    0.00 :   2d699a:       jbe     0x2d69ab
    0.00 :   2d699c:       addq    $0x48, %rsp
    0.00 :   2d69a0:       popq    %rbx
    0.00 :   2d69a1:       popq    %r12
    0.00 :   2d69a3:       popq    %r13
    0.00 :   2d69a5:       popq    %r14
    0.00 :   2d69a7:       popq    %r15
    0.00 :   2d69a9:       popq    %rbp
    0.00 :   2d69aa:       retq
    0.00 :   2d69ab:       movabsq $0x7fffffffbfff, %r15
    0.00 :   2d69b5:       leaq    0x40(%rsp), %rbp
    0.00 :   2d69ba:       movq    %r12, 0x38(%rsp)
    0.00 :   2d69bf:       jmp     0x2d69ea
    0.00 :   2d69c1:       nopw    %cs:(%rax, %rax)
    0.00 :   2d69d0:       movq    0x38(%rsp), %r12
    0.00 :   2d69d5:       movq    0x28(%rsp), %r9
    0.00 :   2d69da:       leaq    (%rbx, %r13), %rax
    0.00 :   2d69de:       addq    $8, %rax
    0.00 :   2d69e2:       addq    %rbx, %r13
    0.00 :   2d69e5:       cmpq    %r9, %rax
    0.00 :   2d69e8:       ja      0x2d699c
    0.00 :   2d69ea:       movq    (%r13), %r14
    0.00 :   2d69ee:       leaq    -0x4000(%r14), %rax
    0.00 :   2d69f5:       cmpq    %r15, %rax
   55.45 :   2d69f8:       ja      0x2d69da
    0.00 :   2d69fa:       movq    %r14, %rdi
   44.55 :   2d69fd:       callq   0x20df90
    0.00 :   2d6a02:       movq    %rax, 0x18(%rsp)
    0.00 :   2d6a07:       testq   %rax, %rax
    0.00 :   2d6a0a:       je      0x2d69d5
    0.00 :   2d6a0c:       cmpq    %r12, %rax
    0.00 :   2d6a0f:       je      0x2d69d5
    0.00 :   2d6a11:       movq    %rbp, %r12
    0.00 :   2d6a14:       movq    %rbp, %rdi
    0.00 :   2d6a17:       movq    %rax, %rsi
    0.00 :   2d6a1a:       callq   0x20e190
    0.00 :   2d6a1f:       movq    %rbp, %rdi
    0.00 :   2d6a22:       callq   0x20e1d0
    0.00 :   2d6a27:       cmpl    $2, %eax
    0.00 :   2d6a2a:       je      0x2d69d0
    0.00 :   2d6a2c:       movq    %rbp, %rdi
    0.00 :   2d6a2f:       callq   0x20e1d0
    0.00 :   2d6a34:       cmpl    $3, %eax
    0.00 :   2d6a37:       je      0x2d69d0
    0.00 :   2d6a39:       cmpb    $0, 0x1c5f8a3(%rip)  # 1f362e3
<cpu_bitmap+0x123>
    0.00 :   2d6a40:       jne     0x2d6aab
    0.00 :   2d6a42:       movq    %r13, %rdi
    0.00 :   2d6a45:       callq   0x2a9030
    0.00 :   2d6a4a:       testb   %al, %al
    0.00 :   2d6a4c:       je      0x2d6aab
    0.00 :   2d6a4e:       cmpb    $0, 0x1c5f88f(%rip)  # 1f362e4
<cpu_bitmap+0x124>
    0.00 :   2d6a55:       je      0x2d69d0
    0.00 :   2d6a5b:       movq    0x18(%rsp), %rax
    0.00 :   2d6a60:       movq    %rax, 8(%rsp)
    0.00 :   2d6a65:       movq    %rbp, %r12
    0.00 :   2d6a68:       movq    %rbp, %rdi
    0.00 :   2d6a6b:       callq   0x20e210
    0.00 :   2d6a70:       movq    8(%rsp), %rcx
    0.00 :   2d6a75:       addq    %rcx, %rax
    0.00 :   2d6a78:       movq    %rax, 0x10(%rsp)
    0.00 :   2d6a7d:       movq    %rbp, %rdi
    0.00 :   2d6a80:       callq   0x20e210
    0.00 :   2d6a85:       leaq    0x8e95ff(%rip), %rdi
    0.00 :   2d6a8c:       movq    %r13, %rsi
    0.00 :   2d6a8f:       movq    %r14, %rdx
    0.00 :   2d6a92:       movq    8(%rsp), %rcx
    0.00 :   2d6a97:       movq    0x10(%rsp), %r8
    0.00 :   2d6a9c:       movq    %rax, %r9
    0.00 :   2d6a9f:       xorl    %eax, %eax
    0.00 :   2d6aa1:       callq   0x2c18c0
    0.00 :   2d6aa6:       jmp     0x2d69d0
    0.00 :   2d6aab:       movq    %rbp, %r12
    0.00 :   2d6aae:       movq    %rbp, %rdi
    0.00 :   2d6ab1:       movq    0x30(%rsp), %rsi
    0.00 :   2d6ab6:       callq   0x20e1f0
    0.00 :   2d6abb:       cmpb    $0, 0x1c5f822(%rip)  # 1f362e4
<cpu_bitmap+0x124>
    0.00 :   2d6ac2:       je      0x2d6b0c
    0.00 :   2d6ac4:       movq    0x18(%rsp), %rax
    0.00 :   2d6ac9:       movq    %rax, 8(%rsp)
    0.00 :   2d6ace:       movq    %r12, %rdi
    0.00 :   2d6ad1:       callq   0x20e210
    0.00 :   2d6ad6:       movq    8(%rsp), %rcx
    0.00 :   2d6adb:       addq    %rcx, %rax
    0.00 :   2d6ade:       movq    %rax, 0x10(%rsp)
    0.00 :   2d6ae3:       movq    %r12, %rdi
    0.00 :   2d6ae6:       callq   0x20e210
    0.00 :   2d6aeb:       leaq    0x8e95dd(%rip), %rdi
    0.00 :   2d6af2:       movq    %r13, %rsi
    0.00 :   2d6af5:       movq    %r14, %rdx
    0.00 :   2d6af8:       movq    8(%rsp), %rcx
    0.00 :   2d6afd:       movq    0x10(%rsp), %r8
    0.00 :   2d6b02:       movq    %rax, %r9
    0.00 :   2d6b05:       xorl    %eax, %eax
    0.00 :   2d6b07:       callq   0x2c18c0
    0.00 :   2d6b0c:       cmpq    $0, 0x20(%rsp)
    0.00 :   2d6b12:       je      0x2d69d0
    0.00 :   2d6b18:       movq    0x20(%rsp), %rdi
    0.00 :   2d6b1d:       leaq    0x18(%rsp), %rsi
    0.00 :   2d6b22:       callq   0x2b45a0
    0.00 :   2d6b27:       jmp     0x2d69d0
    0.00 :   2d6b2c:       leaq    0x8e94cf(%rip), %rdi
    0.00 :   2d6b33:       leaq    0x8e94fe(%rip), %rdx
    0.00 :   2d6b3a:       movl    $0x128, %esi
    0.00 :   2d6b3f:       xorl    %ecx, %ecx
    0.00 :   2d6b41:       xorl    %r8d, %r8d
    0.00 :   2d6b44:       callq   0x2c77f0
    0.00 :   9200:       pushq   %r15
    0.00 :   9202:       pushq   %r14
    0.00 :   9204:       pushq   %r13
    0.00 :   9206:       pushq   %r12
    0.00 :   9208:       pushq   %rbp
    0.00 :   9209:       pushq   %rbx
    0.00 :   920a:       subq    $0x88, %rsp
    0.00 :   9211:       movq    %rdi, 8(%rsp)
    0.00 :   9216:       movl    8(%r9), %edi
    0.00 :   921a:       movq    %r8, 0x20(%rsp)
    0.00 :   921f:       movq    0xc0(%rsp), %rbp
    0.00 :   9227:       movq    %rdx, 0x28(%rsp)
    0.00 :   922c:       movq    0xd8(%rsp), %r8
    0.00 :   9234:       movq    %rdi, %r10
    0.00 :   9237:       movq    %rcx, 0x10(%rsp)
    0.00 :   923c:       movq    0xe8(%rsp), %r11
    0.00 :   9244:       movq    (%r9), %r13
    0.00 :   9247:       movl    %esi, %eax
    0.00 :   9249:       movl    0xe0(%rsp), %r9d
    0.00 :   9251:       movl    %esi, %r15d
    0.00 :   9254:       shrl    $6, %eax
    0.00 :   9257:       movq    %r8, %r12
    0.00 :   925a:       movl    %eax, 0x18(%rsp)
    0.00 :   925e:       andl    $2, %r9d
    0.00 :   9262:       jmp     0x92ff
    0.00 :   9267:       nopw    (%rax, %rax)
    0.00 :   9270:       movl    0x30c(%rbx), %edi
    0.00 :   9276:       testl   %edi, %edi
    0.00 :   9278:       je      0x92f2
    0.00 :   927a:       movq    0x70(%rbx), %rax
    0.00 :   927e:       movl    $0, 0x74(%rsp)
    0.00 :   9286:       movq    $0, 0x78(%rsp)
    0.00 :   928f:       movq    8(%rax), %rsi
    0.00 :   9293:       xorl    %eax, %eax
    0.00 :   9295:       testb   $0x20, 0x336(%rbx)
    0.00 :   929c:       je      0x92a4
    0.00 :   929e:       movq    (%rbx), %rax
    0.00 :   92a1:       addq    %rax, %rsi
    0.00 :   92a4:       movq    0x68(%rbx), %rdx
    0.00 :   92a8:       addq    8(%rdx), %rax
    0.00 :   92ac:       movq    0x318(%rbx), %rdx
    0.00 :   92b3:       movq    %rax, %r8
    0.00 :   92b6:       testq   %rdx, %rdx
    0.00 :   92b9:       je      0x93b0
    0.00 :   92bf:       movl    0x314(%rbx), %ecx
    0.00 :   92c5:       movl    0x18(%rsp), %eax
   13.66 :   92c9:       andl    0x310(%rbx), %eax
   16.28 :   92cf:       movq    (%rdx, %rax, 8), %rax
    0.00 :   92d3:       movl    %r15d, %edx
    0.00 :   92d6:       shrl    %cl, %edx
    0.00 :   92d8:       movl    %edx, %ecx
    0.00 :   92da:       movq    %rax, %rdx
Basic annotate [Failed: missing disasm output when specifying the target sy=
mbol]
---- end(-1) ----
 77: perf annotate basic tests                                       : FAIL=
ED!
```

Thanks,
Ian
