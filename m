Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595932FA08
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570428; cv=none; b=qX/7awYor3xtEgIzUToyoR5uqZf+4lBNUx8xkpvF4SXQ0gKt2mnhDJGpiINpHobpDkKCYyGl1B/JrMwKM5uY6KoOpM/pkoXx1sbSB+6Ha9uJgPmEiCRMsBCyd5hKJ9hwgF2DWedd3LsL6OyxrhxXlTFwz5kJRdhSIVHtTsqprmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570428; c=relaxed/simple;
	bh=/Lfbc0+/PgjvEUofKYteUiXygrT8mWP2xZP3R7eoUqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOsZlt5kCc17pTFYUuUm2pv7oL1X9R2oH7WJ0HPCpKM+uFohrqLrJwzJdbZ+R7kFJk0fSdy8ZruAZd/2Q6+niV2hzr8eJ6j/5HnsKKfQ0m2UM5ceww9rg6TP3h3+V/XvSUrPxzs4hsgjMuxnddVYgaNqaapCoWPG0wh5HlSB5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsiT0skx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsiT0skx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2980343d9d1so188625ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763570427; x=1764175227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4rnd9c+7T7MSzruM14MSPD+zmeLy7SmaX83gEo85Iw=;
        b=vsiT0skxNTnmLC/ircpJs1cNR+xozJFq3gnxrMrKxPJdV8PO6DO+jH5VA3xrGOvq/M
         dbYs2zk5GNMuc0v3RycEi2LAg3E2Igv4lYe90bJnyDY4dNDt95WoBcjuH9RF2WUzysxp
         r6aSICML/7HAiqV6+YlYkiNPfiVim5jddRSG75B3NSLzCCGF30dCJl1Wv5RqNQIK7bFz
         O5hP0T5R/uHpa4IUJ0XNUcNZDcVdpgZ+ojaPMbnd/xJYiLgdh3L2D1KDQVudtnwyo7QO
         DNbUiqIBP8Ok+u92rXjGj5k+kFk9O3K9NSzhT0YQZWG8R3QvbvD7b7zzmuyrOrxCKGEb
         8WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570427; x=1764175227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4rnd9c+7T7MSzruM14MSPD+zmeLy7SmaX83gEo85Iw=;
        b=c/XGFTV6ktREDLMocrBGIm746rM6a1fY1R7lwu4CGpuyYsl1y4uWBfqfz0HwhJERlg
         Hj11LKI4Q6NaPNFq+NDdQ6Pju9t0wPecLkI/SDrNp1HYLYicBM2+SGIwvyYWl0UEr9Oq
         ejTUM0+EtglM+gSYxdnmMbOAlqR1JmYnakcWlvMJgFWIpwbGBMBB09oWdwN80/KuEihU
         9/KKpmgiRnio/iVtqS61dWeCBojKhxmlDfbrSrUkRVG6QDuu9qZPqbvlc/TMW5Xo71uw
         17pvts4jWFFPLnkfdtudH2AG5pdBXTAcbooKwkt7VSatBplvVW/HCAc0I07Qst8/qssq
         FPnA==
X-Forwarded-Encrypted: i=1; AJvYcCUHvLjqsNrbFkQ+SrKkYKmvpNgE6dZap3nQPoZki0XeSpq+r+GdLaU76W5f4dS/zeN184VNjDzd5o3rDsTfvpFj@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyx0fI5mEXIuleJkf3ugfvN5e/+d1MVKSMUq5a7uNUMp6IARW
	CyGvPMb4bcJ8mjgjlHGB5q2MIpFSs53oq9fVusoFvDrFEiIXWHy5MlRvc0TBlQ+N+Lv+evmF+RC
	KVnTdg35q/CArNunSzE4pRg3M+L6KM6s904n1wofv
X-Gm-Gg: ASbGncvjfZPsLq6Lk8+07ELRbtoPaPIuD28dVD5GUVEWkJvPwPOBhacCTi8S71TxKWG
	mXVWcxko0J3XS/vxkhl2AYhYVJGlX7qcH/tppLo0rJXq1Dr1/YpQUCpGAOGYBveybi+q7Fz4END
	S9Iq+BBCneFN11NX0ZFkfZbQQjroOzd96wq0LD+odr6sM5ShRd5SNmLsaJHmoYRDl78RyPUDB1n
	pYFucSJKFpGRd/MeTeIF75GkttOWu9rfbultc/kbLNSVhdJiRuan85+Z0j/tOqBn5eYXU2BB4yp
	n7ueHzumW65OX5xDuxFKmlTLPw==
X-Google-Smtp-Source: AGHT+IHZGdtLjFY6lFc1x79ZepDxvZpVrxlBwxvC3kn52DDbzw5ROGW+IV26aYRXuCVCAJGFs4CPeQhPvJ+DK2mZVwo=
X-Received: by 2002:a05:7022:ea46:10b0:119:e56b:c1d6 with SMTP id
 a92af1059eb24-11c8dd43ed0mr157742c88.1.1763570426256; Wed, 19 Nov 2025
 08:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118063641.517066-1-namhyung@kernel.org> <20251118063641.517066-2-namhyung@kernel.org>
In-Reply-To: <20251118063641.517066-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:40:13 -0800
X-Gm-Features: AWmQ_bmVSYiG9Ca7R4Yh2PTpO9wUQpJkxJDK6Y5T76IyL_D_jvWddwqf_xQFwks
Message-ID: <CAP-5=fUkaNybog6ojcatuyQ2+zBD-BZXE-rYZkHKP91VoT0P=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf list: Get rid of json_print_state
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The JSON print state has only one different field (need_sep).  Let's
> move it to the default print state and use it.  It would waste a little
> bit of more spaces but who cares? :)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-list.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 28bf1fc7f5eeff8f..1ab969ffe371c5cb 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -60,6 +60,8 @@ struct print_state {
>         bool metricgroups;
>         /** @exclude_abi: Exclude PMUs with types less than PERF_TYPE_MAX=
 except PERF_TYPE_RAW. */
>         bool exclude_abi;
> +       /** @need_sep: Should a separator be printed prior to the next it=
em? (for JSON) */
> +       bool need_sep;

I'm concerned we might be reinventing something like the stat-display code =
:-)

Perhaps this would be cleaner as:
```
struct json_print_state {
  /** State for regular filtering, etc. */
  struct print_state ps;
  /** Should a json separator ',' be printed prior to the next item? */
  bool need_sep;
}
```
So we have the regular print state stuff in the json print_state but
don't expose json-ness things to other print_state users - and
hopefully avoid convoluted shared state, function pointers, etc.

Thanks,
Ian

>         /** @last_topic: The last printed event topic. */
>         char *last_topic;
>         /** @last_metricgroups: The last printed metric group. */
> @@ -368,7 +370,7 @@ static void json_print_event(void *ps, const char *to=
pic,
>                              const char *desc, const char *long_desc,
>                              const char *encoding_desc)
>  {
> -       struct json_print_state *print_state =3D ps;
> +       struct print_state *print_state =3D ps;
>         bool need_sep =3D false;
>         FILE *fp =3D print_state->fp;
>         struct strbuf buf;
> @@ -444,7 +446,7 @@ static void json_print_metric(void *ps __maybe_unused=
, const char *group,
>                               const char *threshold, const char *unit,
>                               const char *pmu_name)
>  {
> -       struct json_print_state *print_state =3D ps;
> +       struct print_state *print_state =3D ps;
>         bool need_sep =3D false;
>         FILE *fp =3D print_state->fp;
>         struct strbuf buf;
> @@ -521,9 +523,6 @@ int cmd_list(int argc, const char **argv)
>                 .fp =3D stdout,
>                 .desc =3D true,
>         };
> -       struct print_state json_ps =3D {
> -               .fp =3D stdout,
> -       };
>         void *ps =3D &default_ps;
>         struct print_callbacks print_cb =3D {
>                 .print_start =3D default_print_start,
> @@ -574,7 +573,6 @@ int cmd_list(int argc, const char **argv)
>
>         if (output_path) {
>                 default_ps.fp =3D fopen(output_path, "w");
> -               json_ps.fp =3D default_ps.fp;
>         }
>
>         setup_pager();
> @@ -590,7 +588,7 @@ int cmd_list(int argc, const char **argv)
>                         .print_metric =3D json_print_metric,
>                         .skip_duplicate_pmus =3D json_skip_duplicate_pmus=
,
>                 };
> -               ps =3D &json_ps;
> +               ps =3D &default_ps;
>         } else {
>                 default_ps.last_topic =3D strdup("");
>                 assert(default_ps.last_topic);
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
