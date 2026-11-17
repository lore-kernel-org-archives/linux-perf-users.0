Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934492;
	b=2f5FpdPUXbd7Hr6rcxxxJIo7qSzpKd0k6nZW/+U85j5TyFAUaWvIZzMnPuSIAY42GVWO
	 zxMIDAlYhmSU1Y+SvcyzWsNg3miXn5TIvLEbjT33Lix4pY+GdObsppCUx8HnKL4+LQY7a
	 UHZwBrOaip5efJnn5EGR0mNmi9iwzoktKLTaJfCLOcwGmDBgJ/wscKgU0xjc1ekg31uPm
	 vmatj0B4HeTMhCkQRBVmTpvmDkbp5re2/oPTtLT/7Wu0cxu3CxcXWLSJ0574clIA8PfII
	 Y3p3kA5wvz8c63VCNuMrAqxoLeEzXsaDP0tK8ycAFypjTisC+TGkSSWRB1qqYyA0RjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934492;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=DGDRp2kvtb93Toj3Qe9cR7ofTSqhSOCGBjvMYhNFgBc=;
	b=Ie3Ci7nkfreZw+kxEzLLQBIlXQgmdR21kUgG49OIws4KGKGJWo5iJ9P/kU+vzxW+hlAA
	 hbPLxfbhq8fGRntjJrg55DT6NKbpqDYf5JdzZq9xSWlhpyTOC3rtEhIUOoXTfMPoJIfLT
	 9xwkkgMSml6qYOQSnSEwF6OtZp5uAbXlZC4c9tnEmAan7DOrljDvqcqJY0SKc0y/NSM3v
	 zjGSeJt9hYvEKsVf4GHfUFrBluWZIrP5zSehyt2PYzYfbf+kt6R0Nij0lyJ1LTsKqefX8
	 NRug1hwzEafu6VUJyxBCVcXi6y9p1RR6oH2K9ERh8HlMSWy8gDfnslUAXZRs+cf5ToA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QHqQsfjQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=boSBA9BM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613F606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 16:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D613F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QHqQsfjQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=boSBA9BM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794934491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGDRp2kvtb93Toj3Qe9cR7ofTSqhSOCGBjvMYhNFgBc=;
	b=QHqQsfjQKtr9LJKCFW64WCyAfWedjSVLliUPZ1Zh85vdoki/F9/VqkoFJU0RMpBOKJ6Xan
	KUhgcxdDMnHbQ+e46iAJ/IHtsM/vGRRIYXcko7FZK0LuRPalWUoNCLyc4Och2BzsMccoGQ
	XAu+qvfJ/z8pVAoHeOunYRii3Kf3UE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-MyKSr65_Pvqq49IBoxpIFA-1; Tue, 17 Nov 2026 11:54:49 -0500
X-MC-Unique: MyKSr65_Pvqq49IBoxpIFA-1
X-Mimecast-MFC-AGG-ID: MyKSr65_Pvqq49IBoxpIFA_1794934488
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso417925e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 08:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794934488; cv=none;
        d=google.com; s=arc-20260327;
        b=g9aD2AftBr556LeJVT8NCXAY2GfXe+sMNzj8UnZHjZWZmLU8/BpLFnR76wOc11EnNj
         1iBepQy74RozuIBmLEgQoA+ffLZEWDdxsOvH6TIyzhdimhE7CHTXuLRvf7vG+Wdm7/Ap
         ev/2HEKLZ4r8/xKtUtqHTQAuXxaQjlb7ruRKz/lP3j6r/ieNQDXB7Ec/ejTSPu5z/vjx
         4b1k8fbN9PUteTrVo6zbQTCocHRvwPSHn38CUImcNcgcHu4dxuczy5RIWv6aIwmnQT0J
         b1Obs9GUyuYSeNQnsqA3G4GITECAOl/Zswjeo+R916RhClWFpY12W5m4PxRgaboTzgFI
         4iJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DGDRp2kvtb93Toj3Qe9cR7ofTSqhSOCGBjvMYhNFgBc=;
        fh=T1fCoq7zS4xdxkzFa4udfBHj6IO8UL/DFpN+uqfNxyo=;
        b=XkiFsTF3b2nTL4j7ljKvQuVbpTbDpb9vh7LJQoy1A/NCXAYM+PCO4HsBnQKYezSX87
         DDXzxV5wK2Wdp66ie+9wEnKfq4gqNCp3XJ9665Cw6oVc5QNSH8dIGYVWBzniAiOxLKHq
         ADwybVazjc1ZYN7buu5lB8Oc1Gd9BEOBdMyaNKEMgAZFaUclKRkQ9fCWf+qa4YkP6XjN
         GPJ+WsX5ZEb6bB+sH2sh7hQNZ+3epUZxWirUQKVM2/V4UbbziUboocXL2HR4Qpoz0KtY
         BwqlGzn8+oFin3veZRRGDmDRCW63XEa6U+ay9lTFXoKAHF/I2hAs1DY6d5dBi9Ocg1OP
         O8Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794934488; x=1795539288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DGDRp2kvtb93Toj3Qe9cR7ofTSqhSOCGBjvMYhNFgBc=;
        b=boSBA9BMzgzp/9GTmKfzsDUrEtRv3AnbWstOHFz5RtX6cqce2mGNSogsMbMOPU6V7t
         t8sl1g10XuWgovp0GQ3sglig/7cekSSHrErpAp7g2J5WXMz1WjElWhUBuI6EEVR+S90z
         MS73Y2D3szqB6xm2oC4MxjbNeYYFab8+w3rtw5oh++JtxsW7LBy+sLA1o16hBpCdaUMI
         2nQ3yFkVyF1r5bcvfAlywRT/mGzOg9oWln9HDcdjFN1gKVLL9q40dEi1N7X2ZutwIRg0
         UJDxAZWIhtfjcWCHUxCrQeAyIqiKmYiNMJsSrKtOV4GTBUXrafotFydASMGtuvAItyzB
         kzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794934488; x=1795539288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGDRp2kvtb93Toj3Qe9cR7ofTSqhSOCGBjvMYhNFgBc=;
        b=y50GLqLxC8PB8IrwHRtBXuMcEBqmYA3sAcTRKqTgPZPYdDsuuXMhqfWpuIhyXE4gOi
         yKq3sWtmHVfWz32AYemewcMx+2V647cIv3mfqQMUvzwIKapf7N8ojts4SweN9nhQrBbo
         uzqYW9mIwxdLTztOUxQ8Pmk3+xkL/lTf9HeHAf+CDI9czD3i1ucBdGaSRfquKk/3LsCN
         ckaT2DG6ysXD59AJKX7hy1MAudtrMqcZMKRhMkHGMml0aSu8uD4x0fx4FuxuRGw4IBpz
         pC+D3b5Erjn6PA5/bcgZdQf2t90+TppvPzDNA0HgvyVk30eqAeQLd8iT2Rd8oGtaMi0v
         UPOw==
X-Forwarded-Encrypted: i=1; AL+hErFOzNd/Rb478kbXveK3Mw9+i87CGxLw4HSLRfwb/HpYPKY4iBOPBUS6d6w4J9X+EGDWzxFBNlACYc8aM+8JxHmM@vger.kernel.org
X-Gm-Message-State: APuU4Z/kkb0y8qVzDqfJsNXpzNTbwATTMzn00+vUo1WQNkBhkRoiZ0AR
	o53Ai5zxBtKqX87ulOWFulDWW2bj05ZpTL5Jc6Sv0HZmP5IKfTEErxuf5DSehcEsCCN3+EAdhQe
	ogHpjgs0m9TY4nUNpABswdshIC3oF1bVNrJ8kw3JCaqbRtnH2pmJOYrnH82oheTdsBQG5leFCn9
	X/gT9U7wiLZmZPVI5dNpAi3uqvr8xYlh3ozCOlW0DizPwzMQ==
X-Gm-Gg: AYBFou3P7hbBnGfHoYx093VzxjigjM03oklFdfDGxd4+Ch6AQOvPJc6Hwu2eWfZM7H5
	rYDCtUGx0FY4iD4KNOKNHIJju2A0jOr6Avrgl5+NecvyQrw2qRJrBPRPQ9EVDWCgfMqDgvLRh8P
	qrvlaNMAHSYkAqVVBf9hetFw7/1PYo1RNZxtOrnIkKqr/eeTRNwL2oGTIxrcT35WmWJmXT8Q0Xj
	3hvXJaR/uyBzERosA==
X-Received: by 2002:a05:600c:6986:b0:4bb:6a2d:b438 with SMTP id 5b1f17b1804b1-4bb6a2db52fmr178231555e9.0.1794934488496;
        Tue, 17 Nov 2026 08:54:48 -0800 (PST)
X-Received: by 2002:a05:600c:6986:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb6a2db52fmr178231035e9.0.1794934488110; Tue, 17 Nov 2026
 08:54:48 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com> <20261107023917.40606-9-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20261107023917.40606-9-himanshu.chauhan@oss.qualcomm.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 17 Nov 2026 11:54:35 -0500
X-Gm-Features: Aa3M54roB7QDb-4IN47SMi2aVS10SiwVpvGI_zdHUzKl8EZH9k7SzFLp96gzPDI
Message-ID: <CADRr4bc4v4Uaf2_1ZRFJXoru6a=g+PEYgKKK-vEzXgmV6bXqPQ@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] perf tests: keep bp_signal memory accesses visible
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:40=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> In the breakpoint signal handler test, a breakpoint is set on
> __test_function. Keep that helper as a real call target so the breakpoint
> has a stable address.
>
> The test also relies on the watched variable being accessed as distinct
> memory operations. Use READ_ONCE() and WRITE_ONCE() for those accesses
> instead of making the object volatile, so the source marks the exact
> operations that must be preserved.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-by: Jesse Taube <jtaubepe@redhat.com>

I personally would send this separately so it's clear that it should
be applied to the perf tree.
Thanks,
Jesse Taube

> ---
>  tools/perf/tests/bp_signal.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index f580ba7486b1..2e4f7747d32f 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -36,15 +36,14 @@ static int fd3;
>  static int overflows;
>  static int overflows_2;
>
> -static volatile long the_var;
> -
> +static long the_var;
>
>  /*
>   * Use ASM to ensure watchpoint and breakpoint can be triggered
>   * at one instruction.
>   */
>  #if defined (__x86_64__)
> -extern void __test_function(volatile long *ptr);
> +extern void __test_function(long *ptr);
>  asm (
>         ".pushsection .text;"
>         ".globl __test_function\n"
> @@ -54,16 +53,19 @@ asm (
>         "ret\n"
>         ".popsection\n");
>  #else
> -static void __test_function(volatile long *ptr)
> +static noinline void __test_function(long *ptr)
>  {
> -       *ptr =3D 0x1234;
> +       WRITE_ONCE(*ptr, 0x1234);
>  }
>  #endif
>
>  static noinline int test_function(void)
>  {
> +       long value;
> +
>         __test_function(&the_var);
> -       the_var++;
> +       value =3D READ_ONCE(the_var);
> +       WRITE_ONCE(the_var, value + 1);
>         return time(NULL);
>  }
>
> --
> 2.43.0
>

