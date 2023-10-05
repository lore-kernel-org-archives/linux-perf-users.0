Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110E1C17
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FC46BA
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Oct 2023 22:04:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27752a1e184so415488a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Oct 2023 22:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482291; x=1697087091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GpQOgC+hdgh0C9LQyr/MypfTxuRF/K6WCOldOnnXYA=;
        b=rdfibbkb8/g1WigCdYP1EOqAFV51d7xCv24B4+zP47fZwksLf20mbf58zfYV5srIZ+
         oQPufosIw9oozcvS/pG4BjpGlxCQsgsmrff0IXeGaoj33VXdwRoI9KQWwWwiqHsoyuUv
         Y6lkwtveRZcA4phInNYqGdqE/sMAT7sTJVkwvIoRIOV/VMImdZTnKL3kBrfCZhdtcdaP
         uVruprmcwXoOIMEj5bhEGR2bCNQJrnKQvfn88Hu+9kFtv+Lg1CP4TNbwYkad7IzqybQP
         n1JGC0Vgr//TX3DaCq2zckREJ6lSVb9xM/JlSnCMej//KA30obgRko62f69e0SjBChUf
         UMgQ==
X-Gm-Message-State: AOJu0YxxtS9x3yrQyrvXF7zK8RAYaGenOCgOgDi0hNRgTxigk60R+gys
	EiOq3JOeVRxf9ZLNQ4fuIU+suSsP32AkOMFvMek=
X-Google-Smtp-Source: AGHT+IFboV2QT7m/k+gdl6ovBnuALbYSTfeigYPbQQByLDnmqlc2aCPlMBNIdTAXTgLjM9gWhJ6jMIsND9j3Kl6RORw=
X-Received: by 2002:a17:90a:c711:b0:268:dad:2fdc with SMTP id
 o17-20020a17090ac71100b002680dad2fdcmr4294888pjt.21.1696482291408; Wed, 04
 Oct 2023 22:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com> <20230929041133.95355-4-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230929041133.95355-4-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Oct 2023 22:04:38 -0700
Message-ID: <CAM9d7cjr0TDjrMkgu3TJ-JTDbi17SAVfeE0_2=ZCjLJ8_uS=Pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/perf/tests: Fix shellcheck warning in
 record_sideband.sh test
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 9:11=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Running shellcheck on record_sideband.sh throws below
> warning:
>
>         In tests/shell/record_sideband.sh line 25:
>           if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true 2=
>&1 >/dev/null
>             ^--^ SC2069: To redirect stdout+stderr, 2>&1 must be last (or=
 use '{ cmd > file; } 2>&1' to clarify).
>
> This shows shellcheck warning SC2069 where the redirection
> order needs to be fixed. Use { cmd > file; } 2>&1 to fix the
> redirection of perf record output
>
> Fixes: 23b97c7ee963 ("perf test: Add test case for record sideband events=
")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/record_sideband.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests=
/shell/record_sideband.sh
> index 5024a7ce0c51..7e036763a43c 100755
> --- a/tools/perf/tests/shell/record_sideband.sh
> +++ b/tools/perf/tests/shell/record_sideband.sh
> @@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
>
>  can_cpu_wide()
>  {
> -    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true 2>&1 >=
/dev/null
> +    if ! { perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /d=
ev/null; } 2>&1

I think we usually go without braces.

Thanks,
Namhyung


>      then
>          echo "record sideband test [Skipped cannot record cpu$1]"
>          err=3D2
> --
> 2.31.1
>
