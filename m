Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A442137B
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 15:46:05 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D93A2
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 08:46:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4053cf48670so54319595e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695656762; x=1696261562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6w9cjIBkaiBE4V+3VmCBqXcsiPNS3mk1iew76grX0s=;
        b=sXpck00fnEUEgH+mbkGn6gWJbR56KP6mvByviS/buHkkLQZPNyQ5N6GO5Hly6IE7q8
         c4wURSNuLpl8cud9aeafuKgkka5aK1Qn6dq/d8hrcn4Qxrh4XLHfj7xjp0Eed2q323vT
         byoTaapYzMFeP20zZcPTpigB5mZa9tuvQRrUWGQ2woJ0NutOP3pnMpQfykvg0ccHOC1H
         5J8yTsaCviD50dBw0Ij+I9WVakOpIKd4PohmpQ+EtZr/mYhAAGYGG6SVRthwMUSDFCCk
         sRKFLZYOQ195LMyePadkDB2I3mq36aV3Kwu+lS4KQsBPq6tnNxOtRfQoyORWDMcKAijY
         OUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656762; x=1696261562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6w9cjIBkaiBE4V+3VmCBqXcsiPNS3mk1iew76grX0s=;
        b=YkBofhmopZxFl/tHXiSeidZsvF+mMl8ruu9PUcytRNoXExgQ8QGquCkGq/bzNj52U1
         xjyPiPaaXRYWtAf2LblbawFFOISaQQQaOrYIylSy9eXWGxdYgCKnrcf60YC2A+eUKD0c
         jM1xlu30CV+aiTtF0y1T4Cthhd39SBhwJ5HvWv3e3q0FfnabKBBbLYag+BpEIOF2Lcqh
         WKP1W0yPzL/iBIpj07mquC1Bb2v0+blsxDGiCmr9KubbIw2rW/zHLJG093xwp2Aa4C3v
         pXXbF2153XFg7hS8Oi7fHniBQqgVXBtGANegmjB4PhPkpl8tOwjgfIgLNRbdQncDZb/n
         PSnw==
X-Gm-Message-State: AOJu0YxcOTim0KSOgezuZbvU9JugR2Y3LMxTMOmPLnOrvbbFdIvoL8b5
	frcBIky4xkdlkD3u2Awdsk+Ql+Hozt7KEVigSaKCBA==
X-Google-Smtp-Source: AGHT+IGu/9yAvMgyQo0GKRSxLjrvYvnLqQG1R7XDHQF//7461nbvcXHf0k5K8bPzmjA5KENtcUlC23HtIehGPhsqqnw=
X-Received: by 2002:a5d:424b:0:b0:31f:ea3d:f93 with SMTP id
 s11-20020a5d424b000000b0031fea3d0f93mr5883911wrr.40.1695656762384; Mon, 25
 Sep 2023 08:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-3-irogers@google.com>
In-Reply-To: <20230923053515.535607-3-irogers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 25 Sep 2023 08:45:51 -0700
Message-ID: <CAKwvOd=WbZfFnen8e_k_TgocQumfdM2sUiO1doh4gS_G_+=h6g@mail.gmail.com>
Subject: Re: [PATCH v1 02/18] gen_compile_commands: Sort output compile
 commands by file name
To: Ian Rogers <irogers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ming Wang <wangming01@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yuan Can <yuancan@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Make the output more stable and deterministic.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index b43f9149893c..180952fb91c1 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -221,7 +221,7 @@ def main():
>                                       cmdfile, err)
>
>      with open(output, 'wt') as f:
> -        json.dump(compile_commands, f, indent=3D2, sort_keys=3DTrue)
> +        json.dump(sorted(compile_commands, key=3Dlambda x: x["file"]), f=
, indent=3D2, sort_keys=3DTrue)
>
>
>  if __name__ =3D=3D '__main__':
> --
> 2.42.0.515.g380fc7ccd1-goog
>


--=20
Thanks,
~Nick Desaulniers
