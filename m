Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779831;
	b=T4IcR+k63rJhFeg5DXKZGR46iRzlLRNHrqCmNwuKFDFhgx7KjrENy2HLIoR7K9s6mb7k
	 /oVsLies95GUOvjFCDa9Szzbu7XIkufDP6IS7+1P0noEKK79myezIhg0YMM4Cl+MrDj/R
	 /GISYGnpVPj1sPmNW5vZLlVcyNaFMYj4V/BaXYk0ru6Wc2a04HT3leyaibs2aQjLldgnY
	 AuYUeQQIbuMftmslUsEXC4bsaBCLKiZ8aCT2o6Rd08/VMTxhByC1D7bnRUQJXQsoTkCj/
	 dAb7hdOmZG++QtHSV7D8E6upQKYtpJbKBbhZECQ+8JYnZpRdB7uAcvHzgzxW35p6Ilw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FrqXa+k3jytZUHGymUrBhmXYifhUZWCqjzRMofnbh4M=;
	b=bIrcaRfC9Tyd1VJRLgSyOV/fu32uKZ8FR+lRzqvdZQgqFzaq+78S8Og9Csp+HRLknQyx
	 XreCd5ESGK0VA3xTvTKQSNFYM4kxPlRO5HUCjKrW+S4oVJ3TMKOUEx9umTPyvrpuKn5WD
	 BSLdRf6cVsI0fEhc9ygLd8dctzDrzhyvhYvTYz+oVrG+bWg8mTSSxbwYGWz/gPUTglCUM
	 UYjfDX+bWJarwTwasNmDrH3MSXbsMuacgHl3GmW9NSNtN3Zo9gKaFGEMSwZyc7K0s1Cmd
	 k19l/F6nVlXP6tFap+NKdgEmICMQR2AHSYHRS6/SQ+ouhDiRvI6aYBioy4W4c/9dOVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUojU28V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F1606A88C
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930F1606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUojU28V
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55be673e029so211991cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779829; cv=none;
        d=google.com; s=arc-20260327;
        b=YPG0dtrJyIy2NenyNdmL1uVhECXDd0hqvAueiEqb4nS9FVA7p+Sg1p2pJB8XZrNtqe
         KSP6fZTn84Mr6ZGReE4bCQ5nzbQLqEzEuxhFtbXsC/UDkLe4GzOvuom61EAo4krwqGsz
         kbVB35LqDREjjC2oOU04/LzyX2tg+zSJGElGgsSNm+For7PRqfjRoyspRa9qB3K3AGWx
         UWOnQZsMr/RX8HSGmVVcIb/v6cxBz4M3AnszI81ZM7LsiN5sC/k332Lthl8uFxdIAA2V
         UUzLMg8Kd+y5QNfM06SktzvDrffOAaqua8LGk+0WuKUMbVowDK5dzOn6PlgJBF/hSwFX
         esIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FrqXa+k3jytZUHGymUrBhmXYifhUZWCqjzRMofnbh4M=;
        fh=68E93BtIEbPGUuUvwcn2XhOrOattBwcqfBnFMgr21R8=;
        b=hrLVRXjPk9b8mK8agV9Ls2cFYQMBcyEJV2XaEzciBSxPHx556W4RCDYIOMpXwKuT3u
         dbbJUfyB+5wM+WNd5ZIyObfKDbEhcnHJQsEruFOkShAsiywAWpX8rfi/LO7ORNTzeL35
         4ob8ReLZL9YZY1Z+k3Idu7G/gjE3ji+VYnMQalzsp2lPPaqYiHjZATw+2LWdy7vI2WbT
         y+EVf49xhvExbExVinnA2NGQbPBF8N4t4wlAnz3OJtEMllCx4JvFYPN3k3QDUpZxk3rw
         +XZ3YIOTaWHZpfwZhwnkOrhddRU1Cz67L4gJlPHC/tLFZs5M+JNc30wQOBx2lYSKsLj0
         jIQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779829; x=1795384629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FrqXa+k3jytZUHGymUrBhmXYifhUZWCqjzRMofnbh4M=;
        b=lUojU28Vd3dqK01eZKmE3yuMAiWpA5SDAF/VehUstM3PbMQD4I0VAIbfuNaxpOlnld
         9fBXxZqdZ3kCYgu65FpbSSG/KuTR3YWl+ipVx2XjFnc021yflHAQyf7g3FiJEqC++fu1
         wTowk0eA6n9ssPkLGWGo+JngDkwuuJ+GoZRBDehrTqub4ALdzd1h01HVzvrFkdH8F/8g
         YOiVfuzIb5Gpw5MSCBnVCoRIo190L0XAc2R45ORsyjSgRac8tUpowxvlYOjekRxJYGEL
         BjcZjO10JJK0hXzlJu8mAvPT9IDxiTd1fFkb66f83dsWgsjxTIGnF6W5na1/PejqLYNr
         szcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779829; x=1795384629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrqXa+k3jytZUHGymUrBhmXYifhUZWCqjzRMofnbh4M=;
        b=jklC8CE1/L/BFAVbzV661lpXovWtW0skax+/tXRmWFGA7wNPXe7xquyVvHNR8kIHXx
         oVXGdAdO4e7aND8lfxpz1pCNmz/78mUEhPqjNVQAX8Yzsz7I8UQk6NVVLdfACqWmImsX
         vX5xcG+yNlgveeSaaImXTIQKVX1SSsZdUAOgM4X3hThI7bpQFtaHHBtnJmFZg6prs7cL
         BHGzfgQFz/8kBq3b4m1HhfdBVoAFiQGjvqdJaqZbkDigsgFeLJQkUJ9NZyTB/ZNEB8wn
         Fix8gfMEUURb4JRcrASbCX8yq1vV9Cd6Ll4MYTwko/HbrqUyeR/xr40gvdjVxsKlSDGi
         9VFQ==
X-Forwarded-Encrypted: i=1; AL+hErECr2W3l/j5eif9a4zeEzyZ6uVwoPHs9xfRu5hhvhFmR+Q9O6FbJKzWAl/whLKEQ0m1y8Fhl9iq54ooxmwyJAle@vger.kernel.org
X-Gm-Message-State: APuU4Z9xIC9i7k6oEDyAJ1AZ46z53w/o7IoUIB2tx724QOMvnqoj8NQA
	+vXJwuclPj+JXCvTresyLUNyniYZ0STU86FEJ+hQSMx1X6acSFCdD7pfjZAeRSM87PkR3lSm7P0
	dg2hQZllFcZpbB7tasa5e0p6J1nopITeyT81qcwmC
X-Gm-Gg: AYBFou2RAqAu9aipNWsFYi+giz3v0T/EOb3QoFW8xxe0BGXICUR5NHG/x+TuQgp39YY
	T6gs/ITJi8kDL2X6MoOSoBe+fZYp/FWuaKdpA6VzvxF76jcdtnvIfCkdpNndl/02b5oeSpggDN3
	XKY6gsJFE/c4uzb45dD3X9j0z84deTmNxnZ3PUC07KLRfiLylQKEerBSFUezeEUZjHsfrUkKxw5
	4+7NL1gmMYar1SLBdxPFE22rjTlOLHG3XJDRIw8jZQebbMvZ0x4tpE/brNgXh15bDUlt3KUHBYr
	OzOjNV2uJ4fvT8NpNw7neXHv4qTkVUurVGA8HTcG0W4iI4nJkW2O/ZGDGVQwg7JvvhdhBRf8v59
	EBxBJsxwG2+qa15tygF8Mu37v5gSNiLi2IrcG
X-Received: by 2002:a05:622a:418d:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-55c3ef5b118mr30920321cf.0.1794779829101; Sun, 15 Nov 2026
 13:57:09 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-12-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-12-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:56:57 -0800
X-Gm-Features: AclHuK8tUG0HqxJLZwfiHpkrbYOo6UvxhIaokwTCKMzordl012uFYJdKi4dzOyM
Message-ID: <CAP-5=fUXT0eB-YnozpOXJzYz1K3x+BnDZELU+ipXPp6Oq9BFWg@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] perf test: Drop samples without an IP in the
 dlfilter test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/script_dlfilter.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests=
/shell/script_dlfilter.sh
> index 88222280f6094fd0..797cd9ae84141f64 100755
> --- a/tools/perf/tests/shell/script_dlfilter.sh
> +++ b/tools/perf/tests/shell/script_dlfilter.sh
> @@ -46,7 +46,7 @@ int filter_event(void *data, const struct perf_dlfilter=
_sample *sample, void *ct
>         const struct perf_dlfilter_al *al;
>
>         if (!sample->ip)
> -               return 0;
> +               return 1;
>
>         al =3D perf_dlfilter_fns.resolve_ip(ctx);
>         if (!al || !al->sym || strcmp(al->sym, "test_loop"))
> --
> 2.56.0
>
