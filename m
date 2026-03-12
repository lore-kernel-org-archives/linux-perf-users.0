Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21D26059D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275399; cv=pass; b=kItgkjdEkKpeX9iAkeJgPGTXPYUuMb3RP0ynAQCp8nQzXyERGyRYqufjT7QlY8C3eJNl8hSiy4SiHEOANdHSIQficn/K/qTmy92VbHarjnTbt5Ud8ZXRCxF6XoooYYccvheQzt901uMKq70zs4ThZ1YzFLuNNVOj3UPzEGa6ij4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275399; c=relaxed/simple;
	bh=YcypzZhNU7pNSG3Co3XkiZS4WRLodx1GYdn6Od+L76g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6648EDuQkMvfUVyd9Zhhy1hL1/39OD8GMGE9MW+a/zng+E48ZRv8q1G/EQ4k1e+AMz8MH0zLBPL0BkamEx+lua3mbojsrYhDnyqes+3XecU6Sl6VZrxh21xOz9bz3ONrZy99ZOjfnTvexZmOv7Fu3xPovNQk0sbz0yBhHY8COM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVjbBdP7; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVjbBdP7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae49120e97so37505ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 17:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773275396; cv=none;
        d=google.com; s=arc-20240605;
        b=R00KX9d6PaQqwuoScrrsVq1XvI4agPcVqTo3wnAEAviJYhKF6gyHjRNZcjx8GwLVD8
         XB+4dlzkJ9cJURhJShDZ2+GGNvwdlzafUvD8FDGXdDQZZeSy1NTMK93TNHzbfkGJgTnt
         zQK/Sp+zCudkov7gNBNOtnb0cyaRBQEKezepsdQAdU1UTaYk7iOD/J1xez8PswrubFTN
         wgDDRueQ8PGmg74JDgl3KeCo89NfdXrqHAVrZeijfHXQ3UAtvEFvsax1Dg0qiifItfIT
         lwHGg9szlu8ii0vq89l02bHyJpVlAOmxgnLBZd4oO1lkrm5apPLRAjCXMEz0b0IFKSPb
         zp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PC+/wr2syCqvxGBoZe6+L+D9Kxcq5YGZvRoBAu0gk4=;
        fh=Ih0DPdJDGAeep7vB/lzGW1i9VqqiLoQh+2Iaz8YLSlQ=;
        b=YPI/+4EzY5AIcSjiFJlq7YaA/Zmpznsz+RMGRIYUEqWdo1njyQLMWfd6if3xCDlZvf
         HEMBglMNIYLbUypnzTG5WMWdwXQFYLY831YHlQMP8Hj3fw284iyxN4CIa7WDt5F7LFMc
         ww1II3d1b8rR0d3PCZDiXq3LHwfQLTWhAcECRa0WO5P4rJ63yLA/QsSNnJjkLsNoLf22
         NqLSb3ewbfLYA1H0fUZCOPM3kMHns77yy1NK5M6BJeIkYWIpYtq27EF+fuUGNiHNETIT
         1kN4C+iUDP5eUUPwdQCpPJjsIdqFmNBuYwoqocuXEl981ki1cXFpFGoxReTDG+BRDAPN
         nBsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773275396; x=1773880196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PC+/wr2syCqvxGBoZe6+L+D9Kxcq5YGZvRoBAu0gk4=;
        b=XVjbBdP7BywbdQHnDO4m7R6dIcnBKfdSjjyxAOsnRIfeAtI8OB7DcQrXFTffvDlv9v
         aOc3Kk2i1WHPrsFzZR1wOLt2OiDAqCWMWZnFQmZxNxmRHzvz5U481DdTnFQQQlbZahF6
         eS8S4j8vM0tiaa9tIW9ko3rW6KKGUA6gjHKPfBE2oltaZgTS+BLlSqye8cH4VPR8mIQl
         xNjycZD18On3+wcyBr/hfDx/XIedPP0P4bCQ+4VKExJ+Z2LBU+Svnqkg7KNl5RZDAGAE
         8kaND5KiiKt0uLIv1dM8/2rAvj0Cn77WaY5SnliPXDfXUJ/e/Qe6bmwQnWIOykz4J2TH
         02iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275396; x=1773880196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PC+/wr2syCqvxGBoZe6+L+D9Kxcq5YGZvRoBAu0gk4=;
        b=hWjiEbEwCtejCsAcgM3PYLJuAOZui6iW9O86gq4eiP3gRRJ18Jm1iv8bC9YrXlC5/f
         vRrc4fpc7YsJeJDER5KpGsCMyCY6XYtsRUfAQqp2blLkciYQToYsnxATSRuVG7tRNsfx
         T5zKGCR0q5N4+ZENbn/NPOT8enDMg0X2hVcEqP6jgUiBlADVBZqXoVCdruqC7xGurJ8a
         C9ybsv8+EJNvF4ftENA/z3d2mQQUGUZMnC0ZR/3MZOOe+0yZ2qeUL7vOx8uj1l9xCIdg
         wu4toLpeXzKxMuEoTxOG4mF3LN0iKmdRH9Ffyytkp8f+g61BEVMzK148i5s3lzAFdWze
         riMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuWsn4I4GAlTrPo4j6mnmTpAkGYwpayzOqVW+alpHZMhRlmS0eB5N/VjQiH9PZ5AmujwsUW8xdymD1I5Y6ePDn@vger.kernel.org
X-Gm-Message-State: AOJu0YwltgtcteJ0rKbxafIPwGGXFFcEr3UskTGHN31ultyaQWBFWauk
	nquioYzG/LiVyTruo9ucK1J3Sz8xWr7sdyZi8NVYWoUjTtKEPEZqHdEvTsZqhB7E/5mMlpM8WA4
	Mebekvnkr8eK6mN7WV0AHTXzFZv52k58f2/EY6f3h
X-Gm-Gg: ATEYQzxA1yt1T7tX3L1siJKsKDqPyQAZer/90RMn8ZiSfgFH4LJ9WJbkCjMaNsWZuP2
	kwFRhACiDGdXaKBkCi2Ln8/UjcMCLYpKlHE0Wnfy6z3n1IHOU1Cx0cwncdB+/6tyKT9scFRRFxN
	ql5Xo0FWtTvCX1WxKT47rpkI1NuK1W/sElIoWfRjo5KQia9bgZxoGXkzn7TvQh5iss6TN1+mM49
	ifn0moTPSt7vUf0l/PnCQdWvxhgOhjP/40vi7JwFaeW6Iua6f8yWkYKFl8E8arXSQ6m5ncUhMum
	Ro/lMj+yfWZqWrYKo5XvUEtzOFBiICEIJyMXPWP9C3Zffko=
X-Received: by 2002:a17:903:3c67:b0:2ae:80a3:98a9 with SMTP id
 d9443c01a7336-2aebd197d2bmr962485ad.11.1773275395866; Wed, 11 Mar 2026
 17:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com> <20260311-tools_build_fix_zero_init-v4-12-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-12-9e35bdb99cb3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 17:29:44 -0700
X-Gm-Features: AaiRm51j9bOAiNXwV4INuHof8fl1AJbNKlxnNgZFr0pcoAP2BOsfzP0vifju5JA
Message-ID: <CAP-5=fUsOzjCAOEyJF1cwDbfjSHi=TKjWd1kL6tWWvLu19CFkA@mail.gmail.com>
Subject: Re: [PATCH v4 12/30] tools build: Append extra host cflags
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 1:31=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append HOST_EXTRACFLAGS to HOSTCFLAGS so that additional flags can be
> applied to the host compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 3a5a3808ab2a1dedd40f35ea322913e8a0788130..a86ce3d99e2bb1c005942d9c3=
2191e6eaa55cf50 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -40,14 +40,16 @@ endif
>  FIXDEP         :=3D $(OUTPUT)fixdep
>  FIXDEP_IN      :=3D $(OUTPUT)fixdep-in.o
>
> +HOSTCFLAGS     :=3D $(HOST_EXTRACFLAGS) $(KBUILD_HOSTCFLAGS)


Hi Leo, should HOST_EXTRACFLAGS appear after KBUILD_HOSTCFLAGS here?
This allows the extra flags to override the build system's flags.

Thanks,
Ian

>
> +
>  # To track fixdep's dependencies properly, fixdep needs to run on itself=
.
>  # Build it twice the first time.
>  $(FIXDEP_IN): FORCE
>         $(Q)if [ ! -f $(FIXDEP) ]; then                                  =
       \
> -               $(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(KBUILD_HOSTCFLA=
GS)";      \
> +               $(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(HOSTCFLAGS)";  =
           \
>                 rm -f $(FIXDEP).o;                                       =
       \
>         fi
> -       $(Q)$(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(KBUILD_HOSTCFLAGS)"
> +       $(Q)$(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(HOSTCFLAGS)"
>
>
>  $(FIXDEP): $(FIXDEP_IN)
>
> --
> 2.34.1
>
