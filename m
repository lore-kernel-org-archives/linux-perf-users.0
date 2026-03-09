Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B342BEC45
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079654; cv=pass; b=RHRQAkpp03JWC0a2vWiZGIJ8r1+5QCrUJn0miBPlRJ+CYZS6aFdRsQShMukVpHuqoHGbEPAhjIpW1fV9emh/Yq670aQmxfNDRJKm+Evx+rH39xN8qMbuIbbN1vG6PevW6Aqy/OQfqrxTC8yYI0mBBakXWqAkTAM1b9BCRbMTbv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079654; c=relaxed/simple;
	bh=QIMNB5EyqX39o2tFyg9pOLQaPD6ckffxKJvkpme5m9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZBBlD+SoV4ENE/mYOMLSbE3+ozywIPnxLgHqLnypafsNfA9f9Cizo7Q6fQY5ZBoJOIRPLMNUvUZmkoPQ2AYlZxfpXTfwiI8bsr2x9rpwn9Z+Rv6OmQC7WVh5xxfBBD3iLudGO+5SPpjlOc9Wxk8+hILz/p7EN+ptHltmQi6PW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dITMcj+I; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dITMcj+I"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae523d54d2so16325ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079653; cv=none;
        d=google.com; s=arc-20240605;
        b=H4+mUdydKgQKZKSBoS31EYKpcJyl1jX9Sa86c4nYijPsA4Mbmz5q2Y5e48YL3Es5A2
         lvDirzq0GGaI2qEPU+bhkxvTj12K6b/wfyLlXH77pTKyxyU/4euqTJbRSU7bWcsPU6tA
         828j1hs3T1VJeJCdcaJ475LVWRKlx7LWYFhPf8zckKO9qZg3zd2b3za//k69bqlwvuoA
         aLOLp+ZMF6P14Yw+bS6Z3bs47mKoRUrnyXt+rQ9xiQmn+v0L6uD5yegaFcbCTmOpMTtV
         M/tZHW1hDmjHn3AZ+fRzvxYT86CqGVGT3wCfUOuT2czzMVgTi8gr/YT5uyZVvmnuWY5+
         QozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8TSrNRaJmO51nmlmw1NUXrIFdMrsiQHCiZF8RZbGZ8o=;
        fh=VPeHU1Qox35zvfr0UizOReEOTdKk0pCss3TJRuA5um8=;
        b=BumTY0j7ybQ1vCLLilfmYt22vkGDU3JfaTp5PZztekDeAhhrBdcQT85jNgT3L2O8eu
         5IsBDPVZBmmuK0kZIj5P7BBiyIW642Fs06PNfcsbaR03qQfOTxyhRqx2oPQUn6xOguPb
         D78utR+eQG1RoS8zk2Nxs6RdPsF7VwcXePprvjRMSadf58Ce6ZkXU+2wN03kEm7nKPeO
         b1p+C1M2v9ITRYZCsnBCJFclHmbnWRqs6ggbORHlHKVfEuOJweWs3IVNHcnERq80PdUO
         XnlJ1L4X3jw0GqjA4wvkK/yieWvYEe/FYy2eT7/6NA86md48E3UORx3JOelf37aVvkmc
         +MnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079653; x=1773684453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TSrNRaJmO51nmlmw1NUXrIFdMrsiQHCiZF8RZbGZ8o=;
        b=dITMcj+IP+X1pNDLQlzbO/2Br9TEhFRT6fvRvGnSdpfo8105ue3D5YuFUzfORKIUR2
         8exPwII8caUYFpgVnBptMqd/gNbrLduG8jLq8oKnWCkanuKHfPsCmRK7CA2w8wuZSS+w
         sGqOYYxPQtJElPE6D9nNWXQ7Uz8nfTicxQlRAT++ftptEd9ozJOjZ/xxSwjkQt9/nPcC
         QxNZ4bj65X+XCvTm8tv9s6UJivX4A9uroRHHgaLVlUfI1w6YuArFopcF2d/T5QU4gJ3d
         GIUGYVOUkl/wLfgA5BUCiavv9Wy/BP6W5KABBryaUDzIRRgPFYa3gCzFGP4ilbvzTAAo
         o0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079653; x=1773684453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TSrNRaJmO51nmlmw1NUXrIFdMrsiQHCiZF8RZbGZ8o=;
        b=Ktf/Srbzkk8ZuHfyhZchbmGfwvQz5F9mULPiY/WUHDpVrSMwU7GdrK+bEOae4N+jOo
         RRmK2fLFDnH2YIO/ufbpRjjA0nVN8fQlx6F5dGyGwRqtpkurCGSi0//7RR+8wELYiMYm
         ejnfkI8T9B9UxntlGjlkMbBZ82t/77VvPT3fOtNmEk2nJ0O2gKK2MME39Eb2JACnXeXj
         l9V8weXE4xC1qEd+EsDBB/YSk5i8XcF8LTBtsHNm025Na9qL+pvHsCR0Ri3w0wyqwggM
         4bOTM/5XcZpCbHP+ygdWJBJQ1kHKPPmz0YUuwcCDNEOoQ/JQ+ANXbXGugkIwp8RxT5NZ
         qZmA==
X-Forwarded-Encrypted: i=1; AJvYcCUUa9Z1P/0Wa5hy/4swcYJnk7UI0Tef/769yyoRcx0498Q35EB9Vedgjrnpy5Rk9Jp1KNG36gUcJHX+5stmjbhR@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyXsETMvAKZACjrzYI7PcSjXyqmVlaxjVUi1pWHqhK77mfDQK
	22uhrKyg+XW1VdUNQQ65gul/Tgk9J3O/oxko3qWoxZ774+aORmlc/eLp95tuBR4nsdx7eTo7b9T
	7RRbGALR0OJIIy4y60zz+G6tc5sKffjlhQNOrm4e5
X-Gm-Gg: ATEYQzwe0LF0r1u++WqsmbbsCRcJb74Tt75HmILSsX0IxqekskcRUdNIOpiNRtzK/Hv
	SNNmZIxoezxEdYs7cW3vA1Pi95ecfrdIczi9OqbOJZGIaYp1ekDmE4aDEcpgGORSrGjEWRJs4g8
	pMwNfk0ali+7OhFht2MCCIuhU/38VDUNf6jBBjqzZYllrQsOd5nIgYYSvWCb2b8VoFzrcGVro6A
	vGKISOCAvWJZf3jOj5pKHJg2r5YlZ2vIimRHkX4DcTZRqXTm5O4yxSi0ZYQzYoZyf08Oh3kbWOu
	d/rynq6oSpfnw4wQuyZ0HdcZc/4Z+Bwl5ec=
X-Received: by 2002:a17:902:da91:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2aea32679e7mr214325ad.13.1773079652084; Mon, 09 Mar 2026
 11:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-22-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-22-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:07:20 -0700
X-Gm-Features: AaiRm51tQNQ2inpIlTxQfShRsJQdMzHGmNgW_x5TCtZwRMueLBJEPIayhaU2J5E
Message-ID: <CAP-5=fVp5LEezSpRaTZTH17KjkFBvnDLqonMDa5Lm7O7wHD_Bg@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] tools: sched_ext: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:49=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/sched_ext/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
> index 21554f0896923fa9c2e5b98c85d65d964152e592..7b97af037ae55981bc84d4a91=
40766fdf4c62a6c 100644
> --- a/tools/sched_ext/Makefile
> +++ b/tools/sched_ext/Makefile
> @@ -89,6 +89,7 @@ ifneq ($(wildcard $(GENHDR)),)
>    GENFLAGS :=3D -DHAVE_GENHDR
>  endif
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)         =
         \
>           -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)                       =
       \
>           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

> --
> 2.34.1
>
