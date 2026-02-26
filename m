Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F533ADBA
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103971; cv=pass; b=Jk7Ra53yFGHgeZ9E7MosdmqQQ2SU3Gd12cKtyZ1E6iDxrpS3Sd3LTKQlmJrg6Qm6Evt9ufIyxmY7HuRSOnAvA0J6+FZhVy32FLiGXOMIAHZW64jbAqQN1Vhm1/7Lah7wZMeFiLe0R2tJv96Y/J/+khaqfdy+cp+lML6AQyfsX2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103971; c=relaxed/simple;
	bh=6WpNNjK2wqWyQpnk+n7CrxCBJhZGPYFEKrEcrvO+EsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fluPRHHkrpBzGOeudH8duQJMTvRSAP/kzlZzjUhdn+Jo66IJO3yB8CosO/5PqgJro7ihwkV0fKvolhYg0qLBx9I+Z4GMjirpinJN+FTGWGgFF0Xj3vVNPzcFY8iKh1wBIAXaS6TcxHf88/Y71RERdXZAlXgwKAjKaZGlRC7E9fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlQeZD74; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlQeZD74"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506c02ec1b3so8618641cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 03:06:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772103964; cv=none;
        d=google.com; s=arc-20240605;
        b=KEveA9dWf9hbgmpXImBaObm4uv+Vv/LbuOdCAQ0l459hdG4pSSXJ3zU6ZBzSIJWldK
         yHxTV4FDImPV4bztN0fSx6Kjry1s78PRsTpiVRBO6q+93/emJTnirRqR+/QYzUvBySdt
         3VbA185ezOeL+HdKXZDicUpIqTkkt5C9Gf+yQvtGwKxBNaQKFaua6ox+TjGvNyawLLJ1
         JYhYa6wCSAum45kIC2yiSymbCLu7+5HmVsLJKljf2v367c+O9nlUQmlbi5BVdp0PWVTP
         H0SFn69VUHMxnWBD5TqORoorEqai8KpfJB8d5UEbto+sm/mVuS/jlYu00SoFCHyuV08M
         qaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NURSY+vSVQNVeF4d5BbXCG8ma5CR4tyBQmhsMvF3gGY=;
        fh=kNkUvejyTtbhXd3VanE07Eu0EO2HfVlTSUmWU0E0Fqw=;
        b=jM88kbi6Y5LAByNl8lk2+I+hbmD2uBP2baUh5Gad7fY3qZz33D2QfIH/JQ4Kw2f7p7
         Cdik994VS7dhtYwQaBYNF7D9vDQeS2vUVrQwtg3ZM5WHpflzzwSCFi9qWnd2OFXNG8bo
         iLsOZke7H6GNln0euZNNtUNeFOcJZId4t6vo2RDZ3TPOiFR77DMul1lcjEztqAYfnuyA
         JwJPWfPpBHPle/i5Y6JrkYubJBoTmONsEErwC2Td4z5fU87/8YROLPlrx9w8f0xGwgme
         IcYMWL/d1Ot+dhZCdWLk3Z1suG0Rwot7smF4sz0vL1cVbTAmhaM5H57tOSbDuPhGJyiz
         EGwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772103964; x=1772708764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NURSY+vSVQNVeF4d5BbXCG8ma5CR4tyBQmhsMvF3gGY=;
        b=KlQeZD74g9Z7u4Me9QeF1EFVfZhlAN6mtCOjslTaA96z8b3WGDT3PlB6aJGsi9FFf2
         CK4XMJwiau2fOK7CQ+hphjscpiApfP1LQbtO7CGYfgg0dRAZPZ/aAu9MoXgmY93u2oij
         pWaIDjNgfW/+cHq3QcPsxIYYt97MXuIPZn1thnjDmo5SrS7EOt2N//dwvipgwgLKjTrR
         2iN/SvZ0jk4Na8+16FiJUqthCvFHa372KzfcMReJK4FDhIYGVtjck07vryfTcjGT18GX
         8KFsJ2p3JElS732WUsmcUhkKOiZ5SomP+N0/N8IOny4EoU749DUkKNDVt7iS4mQ/UJbr
         fcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772103964; x=1772708764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NURSY+vSVQNVeF4d5BbXCG8ma5CR4tyBQmhsMvF3gGY=;
        b=pWcDfNE7nRGid1ZNEe7p9zmvaNv/HSAEm4RpUG1sWtl9uGUyIyEWRMdSMs9NRPgt3K
         9uJx+13Hm1p30rssXY5zJN4LGBS+CUwLlyhDioaRpOIrhjsuQK7p6bbdetgnvTkoBMsI
         NI0bWOAL/ZSG8/6zl9PPaZzny28aiMXGNUKOYG2mqPWDIAGOIgC6iDmP+Trz5CxzVxgd
         uhMdKfFJqV1J45vBn3WREzyOmrxZ0sAAiP1dpLcrX1eZrddClHS0LrXHSWcC9zrBfDoQ
         pPhbg4EjN+jXhV4PVee+MrhvLTViZkEPsoHoLdTlOw/VicZu5MtDuKLM04zwrDo02V5r
         3kdA==
X-Forwarded-Encrypted: i=1; AJvYcCWeoQMVK6JMWF+n1fmm3m//kMZojl0c2s9veh4DKjt54tvoIsvVgd16Gj8qzlkKOPMsptT0HJALQFBjklgSOqnR@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFnNh8OlV0MzOz5kTaCo4Ev0I+W6xu1bph3UYRYI390y9/SeJ
	LFRxrRIh/y331SKzANJNjXhmU/iZIVwV4y5K8KyVwB0AmYvbIlr4IfbIoY13o3r37FuPywsvvD3
	sNjnYMkCXfQn/IDhchvzAMJTx3qTwVRs=
X-Gm-Gg: ATEYQzxho5X5evi+xOsfC0KeAkwaBiWmuZCfjXErR1QRSy88wubIlK07c47EpZ8j44V
	kccDkoa8jNtrhRd5xeNNa23aSIVf8r2qbhEjwhVRM/Y/6Vp7Uiufr5r4sVgyiCQ7BCjvcRZpHTH
	yHTCWJRtYOEBTR1PaA54KBWN4Zv3JLPC1TVyTkOwO+EQ0lvVvUfZyHDPEUzA6DZI1zADlH1u2R7
	98sZdNDhUzn8sYLaI0NGjpLfDjABrQO9CbLA9XFPKZCl89dAbsS5H+DnTlKw60oBW/SfFUugiG3
	L6MA1Q==
X-Received: by 2002:ac8:7f02:0:b0:501:7d6c:2d4e with SMTP id
 d75a77b69052e-5074447d2d5mr28594091cf.42.1772103963786; Thu, 26 Feb 2026
 03:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226014955.801293-1-namhyung@kernel.org>
In-Reply-To: <20260226014955.801293-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 26 Feb 2026 03:05:53 -0800
X-Gm-Features: AaiRm52fnBcujtAM1zG3_WpAd8AF7JSJg6Hkti5piuUnaJFH4-HvM99c6lXuDT0
Message-ID: <CAH0uvohd=WE1wsQqDQQc6uqTX+NboEG=Jcs5crYxerLVNYBFOA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Handle task exit in BPF syscall summary
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Wed, Feb 25, 2026 at 5:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Some system calls never return because it'd terminate the calling
> thread.  Let's hook the task exit path and update the duration of the
> last syscall.
>
> Before:
>   $ sudo perf trace -as --bpf-summary -- true |& grep exit
>   (nothing)
>
> After:
>   $ sudo perf trace -as --bpf-summary -- true |& grep exit
>      exit_group             1      0     0.004     0.004     0.004     0.=
004      0.00%
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> ---
>  tools/perf/util/bpf_skel/syscall_summary.bpf.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/=
util/bpf_skel/syscall_summary.bpf.c
> index 1bcd066a5199a476..4172f3c9fc483955 100644
> --- a/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> +++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> @@ -118,13 +118,11 @@ int sys_enter(u64 *ctx)
>         return 0;
>  }
>
> -SEC("tp_btf/sys_exit")
> -int sys_exit(u64 *ctx)
> +static int do_exit(long ret)
>  {
>         int tid;
>         int key =3D 0;
>         u64 cgroup =3D 0;
> -       long ret =3D ctx[1]; /* return value of the syscall */
>         struct syscall_trace *st;
>         s64 delta;
>
> @@ -150,4 +148,18 @@ int sys_exit(u64 *ctx)
>         return 0;
>  }
>
> +SEC("tp_btf/sys_exit")
> +int sys_exit(u64 *ctx)
> +{
> +       long ret =3D ctx[1]; /* return value of the syscall */
> +
> +       return do_exit(ret);
> +}
> +
> +SEC("tp_btf/sched_process_exit")
> +int process_exit(u64 *ctx)
> +{
> +       return do_exit(0);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.53.0.414.gf7e9f6c205-goog
>
