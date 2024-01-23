Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143C627FB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025909; cv=none; b=s2DbjD6OLreHA2c5/+NdIgBzbAYJVVv5lJ8v1vwFkfix9oeVwuiXhVvdIqS5TBG8/TKjGkFrYxV5EqQlBqC9nV7wMvhA3LWjxh5pWQ8ragGz9PBStgzv6E1vB4ezsgyN64CeCY4+IBt6HMBuV3v/f7J7p6T4AmMzR1tGqbRbvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025909; c=relaxed/simple;
	bh=HyArpE4Bn9PmSQ1xAjgCKpN910ZJX5xeMSEjnvi+zrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeQtb7GOfN7y/vzTZe1C/VjxPBiTpSeHC+n8jgPGwNJhjONE71MfYcNxOw/PbyVUCGy+dhdNtCEZlsUwVegr1e/XHT/1IhrWz545YXGgk5dGja6amtZ9C3u12ZLqQhWykwNckBL2sbsuYXMZuhS98zVmSYUhieG0K5jr/dy3bWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfkfyETD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfkfyETD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76f1e3e85so102675ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706025907; x=1706630707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPRvhF7JVnUDF3h0V9XjA6y+vpgVj6b4pFLJNf18uYM=;
        b=sfkfyETDC3ThnVAw7YbKhBCm2R8AgUSyKTeCQayraDKg3vYMYaHqLtQWG8VWIhai29
         jwb3l185ppRAob1N/OkdpO1VF5brYYUY0Ppb550fEr2vbZlges9Ke63ov5eZvSPCeqHa
         1CZAnuFYfke+Oa/DFQwZIDMs+bYTu7hj2Z3GOckM2PzTkb+Pxryh/qiBph+bnhmTNphe
         nnupuJmqeeV1ovvKYSW3/a9Ww3y8TJirsugXhTom0M66he7MCo5bYUnaHBHdfhjOtB4H
         CtQrrnF7JX6ad2beEeSjgcMlvtQ0RjiGHlT8KXIS61PsiPO6uAsX+IWXJISO1SIrljsX
         EWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025907; x=1706630707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPRvhF7JVnUDF3h0V9XjA6y+vpgVj6b4pFLJNf18uYM=;
        b=NqWUH+ATp4mMF0bd4nX/XL2cIrAPnvuigTu2xWAk9Q+ToEv5Wr2f75p8MdBXvJRS9O
         Mwcvbzuoyfaw/inGxnLYShEJvbmHuhbIIEJnhmGxd5SrMX0LJQ1ZJRJ+NyNIpENHOtYg
         tomWpKF+jVs46WBmiHLTBAMj3FgjNPFxxAJ853OO568CeG/k3FrMT/NkASoEjYW+ffGN
         xmMdzj/ne5bPkz6OSkCL5EFwDxsrvkRPOYI6ooBtfhN+2L7vO66kQtdOvNXU19nIVoqf
         ooZjDm4/9HiqQQjx3zpQ2F8DqyCSy21/PxUT8OP/Z7XyKpG4B7NlBLH5zdLXWox8Ah4z
         oLdg==
X-Gm-Message-State: AOJu0YxAvcO5tH7dNtlkw5RBjl99Uy+lDWGpgIDnXG2XlmgN6SlczeRz
	ofasj/ABt0cyH/9bw6m6h20TgCMXKeqHlBIUvffSZPSQKAXoqxHT7Hsk3yquxbL+nt5evVipviC
	lD09Y+/a0lTcGVFvUH1Wvo1pidRfVZBD1VvhJ
X-Google-Smtp-Source: AGHT+IE9PtNgbAHEuzSwNjDkirjNG2rauUtARn4jMdSNNZxVvaY9aLkWNaMjBCD2H80Oc21iiMj3W21zbmEEemnmAkg=
X-Received: by 2002:a17:902:db03:b0:1d6:ebf1:f8cf with SMTP id
 m3-20020a170902db0300b001d6ebf1f8cfmr6830plx.0.1706025907190; Tue, 23 Jan
 2024 08:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080406.28678-1-yangyicong@huawei.com>
In-Reply-To: <20240122080406.28678-1-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 08:04:55 -0800
Message-ID: <CAP-5=fVzaRycRX2+NNMRp423sU5qpBa8z8p-WmF5sX+ty1Xf8A@mail.gmail.com>
Subject: Re: [PATCH] perf build: Make minimal shellcheck version to v0.6.0
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, namhyung@kernel.org, peterz@infradead.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, yangyicong@hisilicon.com, 
	hejunhao3@huawei.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:08=E2=80=AFAM Yicong Yang <yangyicong@huawei.com=
> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> perf build failed due to the shellcheck on my machine (v0.4.6 on Ubuntu
> 18.04.1 LTS) doesn't support -a/--check-sourced and -S/--severity option.
> These two options are introduced in shellcheck v0.4.7 and v0.6.0
> respectively. So restrict the minimal version of shellcheck to v0.6.0.
>
> Fixes: b809fc656e76 ("perf build: Shellcheck support for OUTPUT directory=
")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 27e7c478880f..f8774a9b1377 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -236,6 +236,16 @@ else
>    SHELLCHECK :=3D $(shell which shellcheck 2> /dev/null)
>  endif
>
> +# shellcheck is using in tools/perf/tests/Build with option -a/--check-s=
ourced (
> +# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0). So mak=
e the
> +# minimal shellcheck version as v0.6.0.
> +ifneq ($(SHELLCHECK),)
> +  ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
> +        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< =
060), 1)
> +    SHELLCHECK :=3D
> +  endif
> +endif
> +
>  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
>  export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
>
> --
> 2.24.0
>
