Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3A115
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Dec 2023 16:56:16 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ce015fd299so2049325b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Dec 2023 16:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701564976; x=1702169776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7MqtF2QhFM8WgYD9I6oDGrIZxp6j65KHoiY/Bh94+8=;
        b=rimY0wtcN3KXfrAVxyWwl5MTIAO4jOpFlbnpyNwdyhc0yM40Bf3ZFjSwb3hMPIIkW0
         ojbXfj0qMKTRITc46RaMLkz1i5X4myBqeqEoQRqzcQAfxkugxd8MyyefsdIIqNw8cg7d
         1/u+bf3e6P2yZQbHvG93T+tJc4EuPOa2gU7B7aT2vJYwpniv1NGRhiUU+gCotiBs0HXU
         mpHR5FmXIIsFRj62HWyCIm1QCcR4nnMp5PsuNhOZVLY84X+s1zuPwTjVg+2jDXCdnnVs
         DTnX6AaGz9TcGnDA/rrIb2X5Aa6qZwjWOP+q4EqnppTxtZ82ZL+YPm274EUqdrnFalrR
         KHaQ==
X-Gm-Message-State: AOJu0Yw3kKZya7ZNr9sQfHWzuLr2eKBeITsAhoZG+hRqo0mUmSVSdofI
	K3eLBRYj/V2e9eMz0cHyxX/vgsorh+aye9tgKtE=
X-Google-Smtp-Source: AGHT+IHmtRDUjZVNc1pejWwcR1JjBai5yEtgwPSe/fFP0dKrjtbZONDt6BIvC7Bl/KUii09x0Y5ZLv27vVABrVuLhB4=
X-Received: by 2002:a05:6a20:a114:b0:18f:97c:975a with SMTP id
 q20-20020a056a20a11400b0018f097c975amr2586926pzk.66.1701564975855; Sat, 02
 Dec 2023 16:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202023256.3398906-1-siyanteng@loongson.cn>
In-Reply-To: <20231202023256.3398906-1-siyanteng@loongson.cn>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 2 Dec 2023 16:56:04 -0800
Message-ID: <CAM9d7cjFhVag8nTjtkJvz63vgm+-NbKRhf1Z7OVRWUfgLWCgVA@mail.gmail.com>
Subject: Re: [PATCH] objtool/perf: Fix malloc call for new -Walloc-size
To: Yanteng Si <siyanteng@loongson.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	Sun Haiyong <sunhaiyong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 1, 2023 at 6:33=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> w=
rote:
>
> From: Sun Haiyong <sunhaiyong@loongson.cn>
>
> GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
> like:
> ```
> builtin-top.c: In function =E2=80=98prompt_integer=E2=80=99:
> builtin-top.c:360:21: error: allocation of insufficient size =E2=80=980=
=E2=80=99 for
> type =E2=80=98char=E2=80=99 with size =E2=80=981=E2=80=99 [-Werror=3Dallo=
c-size]
>   360 |         char *buf =3D malloc(0), *p;
>       |                     ^~~~~~
>
> ```
>
> So, just cast type to char, silence this error.

No, please do not.  I'm not sure if it silences the error.
The buf is to be passed to getline() so you can set it to
NULL instead.

  char *buf =3D NULL, *p;

Thanks,
Namhyung

>
> Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/perf/builtin-top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..29191d966522 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -357,7 +357,7 @@ static void perf_top__print_sym_table(struct perf_top=
 *top)
>
>  static void prompt_integer(int *target, const char *msg)
>  {
> -       char *buf =3D malloc(0), *p;
> +       char *buf =3D (char *)malloc(0), *p;
>         size_t dummy =3D 0;
>         int tmp;
>
> --
> 2.42.1
>
