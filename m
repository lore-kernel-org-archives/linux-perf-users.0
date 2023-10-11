Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83F810
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jf2mLqqU"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4A9B
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Oct 2023 18:36:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6911a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Oct 2023 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696988170; x=1697592970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+sBQDLcPV7LRqiHSrWLqzfwU0UGHpGELoludilNh5I=;
        b=Jf2mLqqU72O1vvvClGVjxMHawpdpaZwSRoOw496k8k/cy6eDfK1chsWJFAtmg0/GcF
         mSsZQewS5nlna3MCskt5DV02ScrwtOBE0Hf4wmRp+Z6wfwq0wohRufg+ulIYYybtSlrI
         XyzbrxggwaOQqZOdSa87zKihi5ZmU+NQU6zeeeen4VKvlviepIX47+mAWIS8c9zOI8Ti
         eyFNrq74lKttt58BWHhqJ1tg/RMIZw9OcW4bnHYOYKnAfeCWUfZs0asPNQsoWKmdD56k
         Yi3sRcIdSkn1GhmRXBKI2wF0W4SA7u2b7Ww8u+64w1dh0GIV7b/p1wS/ww4/7OKnCSOd
         ENhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988170; x=1697592970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+sBQDLcPV7LRqiHSrWLqzfwU0UGHpGELoludilNh5I=;
        b=sEF2aQ5NR+wMRzX7W+LM1nt4TLhR+WmLZx/PO1GuUmnD0IM7ngTksgEA46130IEHw2
         2P/m0WOdTcAFqbDhKJ34x/KuYL78J2CcOqqb4Fj94LKbT5ns3Rz6kNqfqDT+0/tBdo+g
         A9lOUZ7M2MRiHFvNTiG1hOmBp3l327yfTqCM7xNuM6jwt4lYxy9rrqldtGMkwcorLZ9X
         khCfXJ566Hsvo4x2am8iZEJOzPhNihnLqrcKe5vtozMalXPKcZ7T/bE75Mx+U+dmegXV
         ZdveNcAzHvDV+Vu/kMfIl437p1ULtfjALpImqgy/IY54oVusna5gLQ4cmQb+HHSttEJt
         //gw==
X-Gm-Message-State: AOJu0YwPpbpzYyeAezGlxWTdqufmQzPDSuzGCjbn3tKKU5FYEWA8U7IP
	mc588BtXW5uzZZrN8njh/CPNPf9Dm4i3fDJi3iqg+g==
X-Google-Smtp-Source: AGHT+IGhrcHFTQwfrnQ+bzSFjLtyebXmHAy60HH5YGHyNv84o1BbsJb5OqxH0HX2LRtHoVupJ6g3TkOJx6G0TbGiScQ=
X-Received: by 2002:a50:d481:0:b0:53d:b53c:946b with SMTP id
 s1-20020a50d481000000b0053db53c946bmr52345edi.2.1696988170406; Tue, 10 Oct
 2023 18:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310110451.rvdUZJEY-lkp@intel.com> <20231010234247.71604-1-namhyung@kernel.org>
In-Reply-To: <20231010234247.71604-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Oct 2023 18:35:59 -0700
Message-ID: <CAP-5=fVpgYJMTgRjQc6zoMYjNkm7T0TSBPXLgz_VWuzwRo_ktg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Do not ignore the default vmlinux.h
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 4:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The recent change made it possible to generate vmlinux.h from BTF and
> to ignore the file.  But we also have a minimal vmlinux.h that will be
> used by default.  It should not be ignored by GIT.
>
> Fixes: b7a2d774c9c5 ("perf build: Add ability to build with a generated v=
mlinux.h")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310110451.rvdUZJEY-lkp@i=
ntel.com/
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/bpf_skel/vmlinux/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/perf/util/bpf_skel/vmlinux/.gitignore
>
> diff --git a/tools/perf/util/bpf_skel/vmlinux/.gitignore b/tools/perf/uti=
l/bpf_skel/vmlinux/.gitignore
> new file mode 100644
> index 000000000000..49502c04183a
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/vmlinux/.gitignore
> @@ -0,0 +1 @@
> +!vmlinux.h
> --
> 2.42.0.609.gbb76f46606-goog
>
