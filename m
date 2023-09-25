Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B4101D7
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 16:08:32 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECDBBE
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 09:08:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-414ba610766so1130501cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695658110; x=1696262910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T1sBdR6OeHgqVg4dg484hQ9QDIMGYEZTIFKkUFht1Y=;
        b=nqnMzs4+uEQiQyOaWz6ky7Qc9qtJlOW2rfuBk1DxPZh5bAFn6kaSl+aQXTkc6Ma5RO
         uq0ORfoRzrENYbh248ja6onnhcl1dD/wW0hoNTZx3F2oaSvZR2fcJT19W3ilvaosdhIp
         G0kZ46h9HtN4buXaye9hZab1qLTcQi3bMSC8BYdLPOV0QzjXNrYwTp8U6ln2TcoRIcTo
         v8lVWZExKqlejTQdrKlnNlx7GvAFv328Q+AxJ++pISBnuq3lLSmUvXxWPJwOBwRjwd0t
         Px/Lm+VE+Hi1cAEKn3NxAweBor6u+UC9mzDfYsmcYhuFw76Rla6CYSpeeistgY6OvsgG
         /RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658110; x=1696262910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7T1sBdR6OeHgqVg4dg484hQ9QDIMGYEZTIFKkUFht1Y=;
        b=ZweeGwuwZUbnTn1J9rBjMjCnpMHiuI7n2Q3A5DzRMc85WHuE//sHsLCYSQVLnz2YUx
         vBtfqBslf2Mf/cI2a/u3Wh2DAs1klKsnnAhPtMno+9eIZmrf5CASqHXvB6Ey+q4dNm7C
         TQQfe+uMa7TDTTToCDSjUxLzmeGlaMkhpP6DtRYPnnzj9pgmmNuXhUNNbKUdYHRAKOn5
         NGdoaGQCJeqnxPd2mofUDvfEiIZR5u4yPRwppWmE8nKp1JtD7rZqT4bAn+CmFuRH1gkD
         OZ+Mi+Yh8DU4WXwDSRu0QhI2sGUdB4GCFX8aaMY63gFbr4qBE+DwSH/F3RCGP5mTH3Vh
         Nz6g==
X-Gm-Message-State: AOJu0Yz9Kt9lismKkM/QeIHSTbx0k4Nmb8FwJPaa32zwxxQIMsRc8ja7
	c1pSZOCtfJXOBNisANyaGqihW+9OcRn8Lszq5EUtxA==
X-Google-Smtp-Source: AGHT+IHf7UuFayo3F+VD205zs38dEtCVXb8YrCI5u2r3xxNxGUjqSV7Er5yoE7d0xht7EghGHRkMoXRMAHJAfAq4yu4=
X-Received: by 2002:a05:622a:1aa6:b0:3ef:5f97:258f with SMTP id
 s38-20020a05622a1aa600b003ef5f97258fmr450110qtc.16.1695658109976; Mon, 25 Sep
 2023 09:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925055037.18089-1-colin.i.king@gmail.com>
In-Reply-To: <20230925055037.18089-1-colin.i.king@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Sep 2023 09:08:18 -0700
Message-ID: <CAP-5=fUht_JQKW8ekDCpHyRbdVe168nmLGrWU21aZDYSyDeMQQ@mail.gmail.com>
Subject: Re: [PATCH][next] perf kwork: Fix spelling mistake "Captuer" -> "Capture"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 10:50=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> There is a spelling mistake in a pr_debug message. Fix it.
> (I didn't see this one in the first spell check scan I ran).
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-kwork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 7e8dd35d764b..f007a9b27065 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -1866,7 +1866,7 @@ static void sig_handler(int sig)
>          * Simply capture termination signal so that
>          * the program can continue after pause returns
>          */
> -       pr_debug("Captuer signal %d\n", sig);
> +       pr_debug("Capture signal %d\n", sig);
>  }
>
>  static int perf_kwork__report_bpf(struct perf_kwork *kwork)
> --
> 2.39.2
>
