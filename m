Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF413C9C4
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079601; cv=pass; b=uJF7vPIG5+TT247H7Zdjj+XN9RostT9ohzJn+f+vgQih7tBMMPRCoGsBdjMI3QLagn0UPtmgRU3KmD062D5Y64qF6DwBXN2+T5fDZ+IhvI/s/XwW0r5D8/cs8307I1QtB2pH8UREhsLyL+TlU5QN5rLfdmkiy4bwwST/iAvYEtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079601; c=relaxed/simple;
	bh=5BCddBznHBMpCnfR4x7BgUbDIxp1InoJ/1cNZt92Udo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ET6XsK3BU2TAu7ENaEiWcLB8Xg1PQcvTv9xk4hZSK4Rqxq06DqDZOpcKmtUt/O7gvKC4+uJyTX9d0tg+EGdCE8GUJTGTJuKrqPoEyLoaXv1zzKeYkpKIsNuSZKbs9Cf4a0cdYqpm8Na4vhqj1EMEJErs5fmauz7sahQO7PXqpS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNmsrxK3; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNmsrxK3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae4b40999bso18065ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079600; cv=none;
        d=google.com; s=arc-20240605;
        b=f0733jhTuo3Sji5wQAjDi1KkIMJH9ia5b5zuag1nXl3c2M/V2rDNCMYQKijNn3ErhC
         AEqs7C9yHbysNTV09OOFtvpivG2MaqgQ82uzp3xYT5XVGDr8hBbc9+4Bu64Fe2Q6Yr68
         7POOX7nZTIQ1EuomdB4M2BQBzAMvx9YDj/N57owb3ZTIECsmzSDLZNOpxYbLI9b8V2eC
         oBJ5H84Kf1GAJ+VM+LVWpvYge6SiP1AhoGf3UWzD+VGdLKWw1ENR6CCVemNQ2N+B5QiD
         PLMHDF/l84jvfqR/I0VTflwqQlCaAov+YGze5mnw+XCd5wFOJUkCV2JzXn/xsiBjqlz0
         JJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AmKGpbY3mrkMMiWs2SN3h57jVWc6a6COL/PKyMDU0SA=;
        fh=4HsdrX4lbN08bjUUdJTRSsnqXsswevVDDTO1lZNFy3A=;
        b=l2jHQXj86KrUi5N213pqLJMJBA1Y7tMAbU15rgMrmWpDG3hVB4FrfbklDS9Ol5LBqy
         kvD0UMe9RKSLntTFQ/hOn/YoXfMBLg9mnGkMVOuBciqGj6PmH3ZRK+wG6gwvJhIntD0s
         UBAQi3lpEcGjzt5dvT0iL/M6iQkwGRqGwprJ8H+Ygy8thI+9c6Makkdchb4A8a+gSiRV
         7SGkv7SM6eCCM1ho2iOu3JxFxkGFp/ya09TLnmugsU+dlXpS2MiPkgkSL9cXI0KN+O+S
         RuZFiEJEpcrQm+Wyych0nqU5egRCUuLJOVdTHqavqV5/MbtuLTIYwDbhK7gAt19zYlYf
         P36w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079600; x=1773684400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmKGpbY3mrkMMiWs2SN3h57jVWc6a6COL/PKyMDU0SA=;
        b=mNmsrxK3yTC2djju/gid5Fyhgsxm3nY4UFdIqA5vnoGMHel2t4CGNVRHrdSeEydgGH
         uSx04u9NV7tyby4lVdWGOegUL2uCq0Stk8/kvyRULe+HdUFa0AHAkD5ShNPotXY2qJoh
         PKEPCjztm5FRUS4eMCyA+0cVtp70Rm6QFRsq6RxIBW3bUn5pZG4vfRpu8xffmAtmJDMP
         s7WIXi5eqiSlW4MEY4Neya06647nstYxpp/dpGVy37Dz0HdZgo7ba00Fje08ThLiLMTi
         o3Tz6ekaBFVdpz82URUqzhGF7AITvg5uPb6dFm1hHJCF4KOmU33IVHkvY76xZBzjMM8a
         3h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079600; x=1773684400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmKGpbY3mrkMMiWs2SN3h57jVWc6a6COL/PKyMDU0SA=;
        b=GxddbDnnCS+B/gM6N3UH9/ZqMDYB0qA3gzWpzaTYKtFmVssHXMtWeFlojVMov73wzi
         poaFU3UBbA7M7DbYUaPCVT8htrEAqVDXwupnD1Rw22+VbT+PllByBeaDE3WDWv5Mu3XS
         PScVKbDl4yFNqKPiG+ZH/M71QU+2dPWMBUL/i6v1+diNtUPNQMOu7JXLJuO/utSeg+Ga
         1R5feTExAeeVEzAjOj8hyoY8TjQpLVqoorNGRmZkRsHoqzzgG/b6O5Hgo6HeunoPkckS
         RTpgKkKAUs4beBluhmsm7u1gDkoQVXGfVnCD607eG9aq6YPaHCsDprInVgnxp8Zulsmp
         zjQA==
X-Forwarded-Encrypted: i=1; AJvYcCXYn4jcy8e3tQ0r6RfZzYbvD/FpJ/D4fY3JPuaqt1Q+8WjJDWYHjVMqarpN0O/79rPQaYwoUKb/S+2JZg89TbHd@vger.kernel.org
X-Gm-Message-State: AOJu0YzeICq2E9yJUA2BC6n9SMHu3u9CSos59KZT8CI5W3git0/4SfdU
	vyj/XV4nkpmmu7cmFjFULpWJxjwBhcJT7D8JYkOTDWkpbLg4IuYa6mQhx0DxeYd7U4vXO5rIm/j
	4eQlN/f+NEiA7GftZvNgtzwunem58GfNFms/d/LgK
X-Gm-Gg: ATEYQzzWE5xk6kxTTmEwX9mOeLcnKUDLIV/nrB4GcvY9uQ5tc1Ju1Vk2qxFWshIYJ4T
	TTqi9M0cKS0EyzQ8yEhxZeJhckeWaRaHqd93oNdZOikbt/e4n+t9KNM0GYSQrQqHrBh1rT0FvKD
	FAN3mmTtENC5egrStaD8pyLHguRajzL/TRXbnW29lSigKXelA2Y6k2mcWiV6BvdmO5pOJfvHcHc
	cjGXL2iUKmDIWH508Z9gZpBpwdfFuwR+OymqVJhhTopor+HWmev1T8efzTt0VeUnT4taqWnD2ew
	Z9n8X6MYm1jlUYdw0Kcm1iJR/YEPtj/YZMbX4r+qsEHPMA==
X-Received: by 2002:a17:902:d508:b0:2ae:4453:3674 with SMTP id
 d9443c01a7336-2aea301e6d4mr356985ad.4.1773079599358; Mon, 09 Mar 2026
 11:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-28-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-28-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:06:28 -0700
X-Gm-Features: AaiRm50VcNaU0-sQ6heYDrcoPU8N1ix0gE-QK1YHwS_OqKqojBYetu5zksjNqTE
Message-ID: <CAP-5=fWqju3_+d=w73DkvdS4cnrfhnd48H2ZLqsSRkKxjh=dRA@mail.gmail.com>
Subject: Re: [PATCH v3 28/30] selftests/hid: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/hid/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
> index 50ec9e0406abaf316fba232c5da1967e27d0fa9b..d0dfa411af9b56ea3458184b8=
a81ef61bd44b1fe 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -24,6 +24,7 @@ CXX ?=3D $(CROSS_COMPILE)g++
>
>  HOSTPKG_CONFIG :=3D pkg-config
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
>  CFLAGS +=3D -I$(OUTPUT)/tools/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>
> --
> 2.34.1
>
