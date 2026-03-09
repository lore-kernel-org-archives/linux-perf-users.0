Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2973563EA
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037588; cv=none; b=SDij6CqSM93qD6Up17qqgC7EtWXFFNpkqpl5KnQzYG/sl2jk0Sk9Ii8n4KiXduT+C0xVpTa9ttITPinldnuzCglGSPO7hEQV175VpLntguXeXeaI+7H2RNy5Dw9bzTyKHV5zHKJXoeeQGlZq+jx+SMOo1S+gPupzpyBkHqP5SIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037588; c=relaxed/simple;
	bh=wAPHd1pDdaeVfK8pv9xwpBJnF+tChiKS7/rwSbvJ5d0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIUZnBG4tJf+SbYMldksiMaTJNsdy4so7Eq2IevN3QrMyMDb0iSdhg/m+ARrbM4CzfKo6LyUvNdNThgEPzLVoqifyQX1hdPifn7VUengiy8o7Xq3dJvqiIuksd0MtEFGOrJ7mELjsYtVYGMO8J7oSVATyHFSxHmXe3dCjkVvegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emBqtnkL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jtMcDjMG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emBqtnkL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jtMcDjMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773037585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4wvI2K+mUpk9VdyVw79oHtN2sfcbsUCHhbZBCFsNac=;
	b=emBqtnkLuhqqkZYxKpaCxyIS+wQcUOUbHsuZ+dN0c06KfCPxuRhRBAnrLPjmFn2vQD+Sn2
	Ji/lUI1McVkc4CCAWwe5x5UBCmrsS9WMEA7u7jxhokeiZEbzRrDrVwCzir/r+8fUadz1QG
	FUeiCTF6Ds4Nb4XdVOXdiSi0jgHWWO0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-8sq3y3RBNAiCoobWn_q9Jw-1; Mon, 09 Mar 2026 02:26:24 -0400
X-MC-Unique: 8sq3y3RBNAiCoobWn_q9Jw-1
X-Mimecast-MFC-AGG-ID: 8sq3y3RBNAiCoobWn_q9Jw_1773037583
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852d27f473so10061635e9.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773037583; x=1773642383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C4wvI2K+mUpk9VdyVw79oHtN2sfcbsUCHhbZBCFsNac=;
        b=jtMcDjMG626PJyQP+TUhs6zzLIyD5sNYE1NX5llW7/o9cNIyfBBnyOaKkGNu5zcePY
         R0GneTIzf9tNCasO9r/mQsafRbTjTVC0JVH1cZ5yiujx0odhdIf6M6rs0L8i7sKnqiv8
         IjHhLg8ZlPHuLDFiI6k3Cbmte5kHlLTzAaWec0J8HL06HjgJQoV0LZ2kb7qecpQPlY/x
         a8gJ0sWYWspJv7p642FbfPNkE3PmYKcpAjKW8Er5D55013PimK/FU10Bs3Q91l0QmikY
         nqgll8rnWpgMoKj1nQ2eHh9Ff5XSi40RM6KyT+9ZPIbaRkmhUwLCvg/sdyrLLUZIAfgD
         ZH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037583; x=1773642383;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4wvI2K+mUpk9VdyVw79oHtN2sfcbsUCHhbZBCFsNac=;
        b=Ha8J6hj6OaUVcb9zSXfZ7vZXuTTnQjsVaKcd/tNqnbmnl6bHghCN5/F0u37qdWRdB8
         cWJ2CZAhFZgcdj/zsxEZN2GX9EVfgEfCcf88J5qP2GXc1EG09dVuUy21YT8YQAGQlcrw
         BGaDdd7EpFHY/Pp1NJcISuD4K3fFmBu24V/XeL5grU2zaMcNjBF7i54tsH3Fo3NcBu18
         0rTjd4pwcM0goPrMV759jvWo8t3/0KXhArFARJcly8Y8SnisAzGu5WuGbKl1Puui6lAN
         tbpJLtqhUVIGAFJFy+urDuYaqTtQxXnqsT3+84pgEHfjm34tDwHNqJ9K58ZFayqfk0oD
         2OUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmJ7YucxcFrC5NqTBiy1MRICg68jcRUbDd36akyWsdCHHiYKVIahtaUeh+/oI6tTAfyMwq7XNVTCkuPtpxnAbo@vger.kernel.org
X-Gm-Message-State: AOJu0YynUMx/zsaclskB59nMD9NhRPkAMjd507I575s/FoHLBjQ+4eAv
	wPwMyELmOYDLPjaC4u4pJjDt6xEoUFe3U1JUqLYLvfLr1NFGRuY3mRChpBN2nb2AXWGlX47J4Qa
	9xHYcCSMTTm1hZHz1cvYklDQ+054+BlGSRkqDK8VxwuW5HhEshphWPbX4y/IMKkpipZFFgAY=
X-Gm-Gg: ATEYQzxe+gKNw4nBJesU0mEfKW2KTyInrPCegb/5jAJjuKmeJKCzuzYFlrwxQ8sApe4
	+a3QttLnTyk1meLbNQE6NSxztEKGTvYIsqnt0vUigwPR44wocSSJK6n8wyjAyZdO7pta+yt73rC
	2KT5auI5FQ6H/6wPPJ3hjZ2ATeitSytLYTlIB2orRKE1HBfeEPEdsvMr0A2V4cUf35Js48eMxWu
	jZ/7SvK2FP9k3cC+QyUC2Tgt7Bl7grIGfZ9+GTScUDlapKtlzByJi9z5m//vdYde3TfK4QzoIXT
	djdW0mj3RI0DSXO3b90OH1qJvqCZGSr1zw0vUAjbuISVXQzAcwQTjb9k6hITSqt88Xing20kHxp
	FSZv37HxXDnwbaSIDhjfPgsDU+llxisFlXZo5xMcoz/8VCkacuBKWBsBP9LVmVa7EY9rVodsCuc
	pplQzYT3ab8ek4Z80=
X-Received: by 2002:a05:600c:358e:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-4853ec6e713mr10719815e9.15.1773037583142;
        Sun, 08 Mar 2026 23:26:23 -0700 (PDT)
X-Received: by 2002:a05:600c:358e:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-4853ec6e713mr10719305e9.15.1773037582629;
        Sun, 08 Mar 2026 23:26:22 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f9f82a7sm6141395e9.10.2026.03.08.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:26:22 -0700 (PDT)
Message-ID: <9cb773f5209fc21a3842abe9e60a27b6130c7fd4.camel@redhat.com>
Subject: Re: [PATCH v3 26/30] tools: verification: Append extra cflags
From: Gabriele Monaco <gmonaco@redhat.com>
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, James
 Clark <james.clark@linaro.org>,  Kees Cook <kees@kernel.org>, Quentin
 Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>,  Nicolas
 Schier	 <nsc@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Alexei Starovoitov	 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko	
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman	 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui	
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra	
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland	
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Adrian Hunter
 <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, William
 Breathitt Gray	 <wbg@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin
 Xia	 <xiaqinxin@huawei.com>, Bartosz Golaszewski <brgl@kernel.org>, Kent
 Gibson	 <warthog618@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang	 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui	 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Jonathan
 Cameron	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>, Willy
 Tarreau <w@1wt.eu>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=	
 <linux@weissschuh.net>, Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore	
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Srinivas Pandruvada	
 <srinivas.pandruvada@linux.intel.com>, Tejun Heo <tj@kernel.org>, David
 Vernet	 <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo
 Min	 <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>, Steven Rostedt
	 <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Jiri Kosina	
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Date: Mon, 09 Mar 2026 07:26:16 +0100
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-26-6477808123b7@arm.com>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
	 <20260308-tools_build_fix_zero_init-v3-26-6477808123b7@arm.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-03-08 at 16:46 +0000, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Thanks, for the patch, however I don't think this is necessary for RV as
EXTRA_CFLAGS are already appended to CFLAGS elsewhere [1].

Makefile.rv is included after the various Makefile.include, so I presume th=
at's
good to go for the new flags you're appending in this series.
I did a quick check and I see -fzero-init-padding-bits=3Dall by just adding=
 05/30
of this series.

[1] -
https://elixir.bootlin.com/linux/v6.19.3/source/tools/verification/rv/Makef=
ile.rv#L29

> ---
> =C2=A0tools/verification/rv/Makefile | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makef=
ile
> index
> 5b898360ba4818b12e8a16c27bd88c75d0076fb9..2882f0e93dca03b31d790b42d2ee3d8=
f73cc
> 5c8b 100644
> --- a/tools/verification/rv/Makefile
> +++ b/tools/verification/rv/Makefile
> @@ -55,6 +55,7 @@ ifeq ($(config),1)
> =C2=A0=C2=A0 include Makefile.config
> =C2=A0endif
> =C2=A0
> +CFLAGS		+=3D $(EXTRA_CFLAGS)
> =C2=A0CFLAGS		+=3D $(INCLUDES) $(LIB_INCLUDES)
> =C2=A0
> =C2=A0export CFLAGS OUTPUT srctree

