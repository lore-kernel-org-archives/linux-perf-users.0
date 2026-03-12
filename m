Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899D3EFD1B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336303; cv=pass; b=MKnwZAMn+dLHfxig/P64W4qcAP6qc6UahWUHA1i2iPkGH+CPzQGsX4QhmgAje1zGJF2oSGp6ruBRg90jnrokgiUisYVzGKYlCW3k6TR+6nEECiiuSUB+pQyxJkjhNwaw0Rwf3tdL2sH/fJsFCf58hYYXaPw0hNBgn2V5xbZ027Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336303; c=relaxed/simple;
	bh=EUnbf8s9gG6GzSdAsBxHv68nHvfQl+MlAZdHKrNHid0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBqsjj+0oHFhSSQORGpVCyqutn7sV/WRal04/JRACscQNpHEZcBunZE5/g4Yc+VNy5XUsYVOiyA1J664W46JBfMeMnDAbgQSvF3nLd5bLhJfBUr+LDnGdq1mo0hPOnOvuNaz2rRkKQrgT7vHYMGSn76cp8BJdTiLzvt74c84WGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0t1e8bK; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0t1e8bK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aea4ebb048so6375ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 10:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773336300; cv=none;
        d=google.com; s=arc-20240605;
        b=VavlH6z86RKMzEQVnWqFstNf2oqB/kbzXGVJqryaiJCAZbvcuIOZRL6BFLCf4RwTY7
         4KWekY6fYbKB3T8UEewaMVsrwX5kGaOv7GyOauRpxTTgu/A1Nl/BHL1vV7bd9faJbJis
         O2h/eUe2JEyhq6jynK0xZxTZAhYwmt4+uTFJxeCyAOHZDsNVdJMoXDW81Mf+h1aTw69z
         fT1Vdq5zLraLWiLugUr+TeyCiTu/BT/0K7nqxjL1gzeebjsicwk6oTedh23Zi08aDdqp
         eI9i5oZ2DuGPIOngMwHx9hlzPtnc1KW21SuVFQhFHvgfaI1IwTXCiujqiuShvTBMqTD2
         Y1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wt8HMORomTHlz2fasa3fWuq19mlRWO2w6YTeCuKKCWs=;
        fh=/HVyin8w7bmLIzy1tSdcnoxpfYaQ29zTrPHCjUZx2MY=;
        b=XhQ3FoMWfsO11pIWQlFI9hKj7IkgKwbmARdjup7s4gLtvBqI7B+yPitTDzUCzXOP+a
         +ss9IXhifvoCkQ1zDzBBS3zQ6b9nVaPeEFqMHkWbUYKTbcWvaQ+z8z/y1/sNRhL8KyfE
         XfDVzXFvWArpBAuspTW1Vtq5s0RZ73JdnGKzXsj04M2gREp9WDAgP0rzmh9PNxjAVNsU
         HICqV/pArWOfLL5SSLSiNWfyaeBZ6bu0eMkHwlttDrB2DM3HVEPJUhPgFzzHCuaYq3va
         ohmXhGTAqUrisT+BjKXyDwAQA+46sH2B4wEA5/u0UjYh2o/BHxquuvfgs7ieT2vWBvd1
         5kmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773336300; x=1773941100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt8HMORomTHlz2fasa3fWuq19mlRWO2w6YTeCuKKCWs=;
        b=y0t1e8bKg+C32XSsB0LPpxxI2XQPaVXkNMGT9vmZ8cCTsFjsZdfKdKO4bixYDf2rj8
         qBv12tvIG0/Ym3+euTqjBwgZWIpC19okpg+fFv47jy8EAEX1FR8rH/n8G0uERBnYXIi+
         5S0YjwqIWpoKrifv1HSqYpa1PMjW14YLb6ujJWc/F6aFbtxl/mgDeZB0qs1ndhkRoXPO
         06dJrzgDPaNlxeE5p6U5Ti349ZNmTvBTtA09tk07LsFGXzIu69+TUkZadlf1Dd2SzTr5
         2QCxN+nPF6GtvWwApMY/t7XX4/WSFJXMM6tYLIeI+eOND3vc/d7NEO9fT+zPPu5Ygfob
         JgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336300; x=1773941100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wt8HMORomTHlz2fasa3fWuq19mlRWO2w6YTeCuKKCWs=;
        b=Lh51oAkMogv+T3Fmbfahdps0uN1ZAwTWUcMOvc7B8TY6ZBqK1BzlTIx0TJmcGj8ylG
         SFIP5TZChgJHS3txHrDU9Gi1NLzhNvAHsDRF7IdfDIj6qL/+UO6N0cc/1XzlGhH2Nt8k
         xaNi8ZVhDqiCQQw+231L2wiRko8tBb2Bi732o35M6NH6NJvf6Ts8O1tKsF68sUimiWEZ
         xtXx/24Oo/CAsuoBEGyH+BYAUm4r7qv2E0EswYwBj5sxJw0ddUXw3Fy42Bz/+3RMWxqk
         /ZcpXeiPhVkkR797fsqyor/N+yANG3/PZB7P1l/mQIPp0SUa68Fas1fJg8YNJxmurLbS
         q5qg==
X-Forwarded-Encrypted: i=1; AJvYcCVvSlpipdrkatrEybzA+AF0DJz+lm1G+bmtWfTOgFrieL6cR8LXqPoksj5rHlQeRdMbamp0NLi3/7d2f0ifJlhZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjRkJ09POnoS2TNge8mUprayjNZzRohXH30XdrCNa5Na3gJxb
	0Be21t5Uz82YcNhEfEBr8MOZLGnN99pZD8/YUNEl4jj/vQ/Y1x5aVSHoMn6hSRzjlWoSQ84XkYr
	qiyeQOlet4aZ7j41CVJ5hzq5YcyQ1UoOcz6a3cHta
X-Gm-Gg: ATEYQzwvqCRO0HbVTlY0MmCh9AMAuTGTn7TYGf3y3KmT42nNi1g9qCMK0a2oiJDr+tn
	3LH1NSSd5Tkp26MzM+OfzTvCaybuGL89JG5TVdwZtnjTHKbUKXAOOtvWSACVCmY3U+NldJXNk0a
	suH+2+iPJwwEguiiyCkfou5s3kCXTGFhqBmWmeZXdZurbFIdgTFiq2Fdip2uo55vI55OsXgXo1N
	Cly2KfCj7jgmG14vc9cdCtE1yLB7rpzR+w0WIRiFrbW6EyMlIEGP4SkxTClVd8Sj1bH9kG72g/Q
	AjM6N+wYCPKSm7gsoJ7EJl2c75T6l9q01K+M
X-Received: by 2002:a17:903:94d:b0:2ae:ca87:b1c2 with SMTP id
 d9443c01a7336-2aecb4968d3mr115665ad.8.1773336299917; Thu, 12 Mar 2026
 10:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com> <20260311-tools_build_fix_zero_init-v4-27-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-27-9e35bdb99cb3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 10:24:48 -0700
X-Gm-Features: AaiRm52hQTw51elOXRvyPkEpjj1HAq438fXBgq5QDvtll0HOsb4gHaSDYi-74S0
Message-ID: <CAP-5=fXjd15e5YpCM9KMjEhpjLxvxc6qUk0g7BprCfkzcRZ5_g@mail.gmail.com>
Subject: Re: [PATCH v4 27/30] selftests/bpf: Append extra cflags
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

On Wed, Mar 11, 2026 at 1:33=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> urandom_read is built with clang.  Introduce URANDOM_READ_CFLAGS to copy
> the compiler flags without appending EXTRA_CFLAGS, which may contain
> incompatible options with clang.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 72a9ba41f95ebb825d25799c07ba3f0311243e45..27112f08c9a5b6cabc4190220=
7d00897070b41b4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -71,6 +71,12 @@ ifneq ($(LLVM),)
>  CFLAGS +=3D -Wno-unused-command-line-argument
>  endif
>
> +# urandom_read is built with clang. Copy $(CFLAGS) before EXTRA_CFLAGS a=
re
> +# appended so that it does not inherit potentially incompatible options.
> +URANDOM_READ_CFLAGS :=3D $(CFLAGS)

Later in the Makefile, include ../lib.mk is executed and it appends
CFLAGS like -D_GNU_SOURCE=3D which will be missing from
URANDOM_READ_CFLAGS here. Perhaps move these assignments below the
include?

Thanks,
Ian

> +
> +CFLAGS +=3D $(EXTRA_CFLAGS)
> +
>  # Check whether bpf cpu=3Dv4 is supported or not by clang
>  ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),)
>  CLANG_CPUV4 :=3D 1
> @@ -255,7 +261,7 @@ endif
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c li=
burandom_read.map
>         $(call msg,LIB,,$@)
>         $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -                    $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
> +                    $(filter-out -static,$(URANDOM_READ_CFLAGS) $(LDFLAG=
S)) \
>                      $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>                      -Wno-unused-command-line-argument \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
> @@ -265,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c ura=
ndom_read_lib2.c liburandom
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so
>         $(call msg,BINARY,,$@)
>         $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -                    $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter =
%.c,$^) \
> +                    $(filter-out -static,$(URANDOM_READ_CFLAGS) $(LDFLAG=
S)) $(filter %.c,$^) \
>                      -Wno-unused-command-line-argument \
>                      -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(O=
UTPUT) \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
>
> --
> 2.34.1
>
