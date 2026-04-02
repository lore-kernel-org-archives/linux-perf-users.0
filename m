Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A83E92A9
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142566; cv=pass; b=nmk+u7WrhjVJOkAR9UU0v5DNu32/mSwWUVxxSxQZ0Q3DLOdXq0ddGctJl6QxK/bLHRe9HzKPp2wbFxUtdHmEopurse7bLB1G45GzMPm/+Tj3kvN79NqN5Y4NxQzvm2LIuo7sT2eNMcXl4iMNsTAswyuWmRKku1UD/w9UhoAu0i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142566; c=relaxed/simple;
	bh=X8CjnSI/tjqm1ede5+yk1zYHqTWURWfdEsBQJKOqCQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnyppO0RWtiLDlrsz2m6XGwZX8cKwSpFRCdvK1SrSiNmE7sTMo4vWesrFdsmEytPpL3aIyUemuEGVYu0TRH7bsCZsKhImmtIiAL6tgaHHod1Pqqk32toV6GZN26mrABUs+swnMta/tSnJvoBoWeJJeJ07UbBFdpcqHRxj+xXu0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyT1sXql; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyT1sXql"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b243198058so67665ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 08:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775142564; cv=none;
        d=google.com; s=arc-20240605;
        b=JXuD0GLSBPnCZChAV6a4OFAeHtJ+a8msppK9wT5lcaj8CPtaMMf7rZ8eXNbiT1oaSI
         AL7lKBTJu+wv3hTbioklFeii2qFBUki9InLxsA6fJeHtcJSyIUgxgnpb69JV4k2XgbKq
         1nF/buJ5JK+mtDGzshXi3yIC5Q/xzQspidMmiwYCtDRbzMZCJFEuKvTNPoqm88VJOKD1
         05M8+zUd6yxy349k1Rjl8ECz3hZt9zTMDRhmBUKllhnJDism02Q3pNQof4vWRAW6s1Wb
         zd4j+4fQ+F4vCZoZsZvvzowvGwX8Lf201jKbgA3CoZJSPvLBTIqGaVXjACL+9NVb9K5U
         X77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5NvVC9uAXVaQSavj7B6qNg9YvvTlpKV01rWwJOFU0qQ=;
        fh=2ggxsn/vSxUTYbAKELz7XTlq/8ot9I2eDr3ykERc3ec=;
        b=hHYEmkH5qeAQfdiah62p1cmGcvwALlwCLD86/35Llx/+c/PFskFSAzznbU9i4s2Y6g
         jIzMH8q9kZecN55Co7gKusVni8EUCraIA1tlOuxbbe0inlU0oJq8KKpxbfDSayPww5M0
         Bka7Ob1KZCzCnSLUpaFvS0tnR5jhqMjt4npqml3Ia7HmYJxEIkYFlaUq+mvKj+aw8jAz
         Ly5awa9SBOlQMOcT3ovooCc4XCi4xSEiQH5hSXm+Jen+bApdSirhNHZvAPkTkbVNnGYX
         vhldvzTfeIWfA++NVjnSpeQ5O8aGWO33xA/QDQb583cusmbkCZcJADKPW1MVVH2ab0It
         f9GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775142564; x=1775747364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NvVC9uAXVaQSavj7B6qNg9YvvTlpKV01rWwJOFU0qQ=;
        b=DyT1sXqlyvzA8UVsnZeclpaX8EiYbWl6ZkTPrGzlc8YDy3JStworlBWBAvPqIIg4j+
         yrhV5coyiLt+NdNN5XgPPMNjkdfGcOOrBAD0K9alFkIlTUzgG/YJ7O5ox7npc1MIJcaz
         qnxHK1WXS2O85UiwsSPLltyNf4ZVb8oLeAbYfoq2b7T6PwT+RwabARgRzHgkXg9vmdkW
         vIUIw13t0mL6KcqByJQgkMucqr+thneJYsZmgPV2vo4I0YtJo0JUi0/n9ckcl/zQbYsF
         /172teCX++BgA7PMrLe/T6GOdvmY8V5jcuadQ536rgJvQ9vb+qm57/8ExTKVqIKROOUz
         4jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142564; x=1775747364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NvVC9uAXVaQSavj7B6qNg9YvvTlpKV01rWwJOFU0qQ=;
        b=T9bF+bRsQT4x7W/R/QUv9+gTLoEFQnW9mBsNgPHKGQZEsIxbZpubdBn2pGXl7XBt/E
         hxQnz7n7fHUEDtTUGuB5aNRiSYw2ZrAWbNletFoT4k3O5TqlRd/Y8pZmLimREKBLZvdB
         bc7ayF0s7wJU0m2eb9KkvG+nps4jTeHqcLN7a1/NtDNKeC8+mGeHGvbWef7VzBW6N6Mq
         2QWCMnVgSaOsN9GjcdT6mj3PTR+FGi3WCuhuP3Q9lmac4+zqsHZxzK16X2Jysw3BPpIR
         8SElvPXQ2iLql5kowYC6d9JVZe3mAYQHTHRKFzs2Zifb3+RG4AMuMPq69li+UQpETzKT
         7m/A==
X-Gm-Message-State: AOJu0YyIc9RuYoYscCB3LwHcmnoFH070A4HYgXMYslrhmP0R3GYUExLa
	HBepEpI7P4S9Nkx/QLnphh4yD97YmXZkgBo1n+kqq+hpZtbrdfcNssT5mLPCE+OkdkZG0YN6b4R
	lBqs3mNYEmtGDvAnCmtJYINI3Wp/CQrfytu9HMFtl
X-Gm-Gg: AeBDievHLqN3Mf9Y/OZ8AHv51xjKfYQiWdsn33m5dF69Xfo1zeqMMOJb7a5uoL4MF+/
	NV0YLvyDgXsm/LMgavf1tCEnZhXppvjDJ+M6xzOjT4/SVW/MH8yCLfu7SM5poWY9ezz8kfMrTIi
	JSoKM/6Ph+6eBwa97ioo1YkGH62Kcj6lEGKrfmljsheEvbqCQRByPl5OBUVYt4oi1lcFaZSs4E7
	uXaYunsbK4xkK1LByCVQtkOYnFdj8twN8EOWnQKYtSqcK3w3sM2Z3tey6Of4Fg+r8EPHMhaDshD
	XHVR5iMlEhF8V5usxrqJyXUBLPhlAJej39jU
X-Received: by 2002:a17:903:a84:b0:2b0:5c88:51e1 with SMTP id
 d9443c01a7336-2b278554bb3mr1361445ad.14.1775142563726; Thu, 02 Apr 2026
 08:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331101020.1270363-1-mpetlan@redhat.com> <20260402145118.1379546-1-mpetlan@redhat.com>
In-Reply-To: <20260402145118.1379546-1-mpetlan@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Apr 2026 08:09:12 -0700
X-Gm-Features: AQROBzBV1eZRdLMbexXfO9PNYPFaC98JE9Pv3WlF_GcoahOZhFmeSICVm8TGrJM
Message-ID: <CAP-5=fUo6GVurv8qQnMfpgN-hYa1ukNLhF_5n2VfEv=X6APBTQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix potential u64 underflow in duration calculation
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:51=E2=80=AFAM Michael Petlan <mpetlan@redhat.com> =
wrote:
>
> Although it happens very rarely, in case of out-of-order events (i.e.
> due to CPU migration when a syscall is executed), the calculation of
> event duration might underflow and thus a bogus value is printed:
>
>     2.804 ( 0.001 ms): :49553/49553 rt_sigaction(sig: QUIT, act: 0x7fff40=
3ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) =3D 0
>     2.807 ( 0.001 ms): :49553/49553 rt_sigaction(sig: CHLD, act: 0x7fff40=
3ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) =3D 0
>     2.815 (18446744073709.438 ms): :49553/49553 execve(filename: 0xbb173a=
30, argv: 0x55aabb171930, envp: 0x55aabb171120) =3D 0
>     2.815 ( 0.534 ms): pwd/49553  ... [continued]: execve())             =
                              =3D 0
>
> Check for possible underflow first and in case of a bogus value, do
> not print it.
>
> v2: Use greater-or-equal to handle "zero" duration calls correctly.

Nit: This normally comes after the signed-off-by past a "---" to
indicate it should not be included in the commit log.

> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f487fbaa0ad6..9c59969de2af 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2956,7 +2956,7 @@ static int trace__sys_exit(struct trace *trace, str=
uct evsel *evsel,
>                 ++trace->stats.vfs_getname;
>         }
>
> -       if (ttrace->entry_time) {
> +       if (ttrace->entry_time && sample->time >=3D ttrace->entry_time) {
>                 duration =3D sample->time - ttrace->entry_time;
>                 if (trace__filter_duration(trace, duration))
>                         goto out;
> --
> 2.47.3
>
