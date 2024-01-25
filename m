Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C85CA7C
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jan 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216382; cv=none; b=GmNg8nSK3q/HnlGEzKcbrfy3RU00xI6d8DPGUs7P7WisEFocma2KRudQJlPRjYXfwi6tQu65+nQZ8rUFs9fcuXKxg/oxZADD00srJZ+JICuC015tnPi3fldx/Zuy+x7M68JFByw8PXdDtV9cMsExcppcL09tX9mMdy3R1ZnhG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216382; c=relaxed/simple;
	bh=kugWdLPRbZv+nvzTzXeYEHDhAGQHx+mp0pJFpgLrtHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiuvTHrCtxVRRk4Io7flrtMk0ovWrL3baZNV5H4AxV6jd1O0xPNsx+ES3QL6Wgj66rhJzwf8STGg0Rb1x1qq6eaZA4jE4JjJrpikAiBq7OWXtSReZqaa9su5aAUS7VwbmVQRSAL49IExlT/P6OOIf2v+vdmWhFKX0MM5CmWfzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMe0vKK4; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMe0vKK4"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-361a829e012so17225ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jan 2024 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706216380; x=1706821180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxhQjCPn4Rmv3lAxNtNAmeDVJacck3kwKzoL0OQKBYo=;
        b=SMe0vKK4SSoZ8TR2ECS4eYh2DX7n11XvgPG2OIGXfJf2LSunohim7xvl+TvkNOzMnI
         Pf37y0CNYNq5Pk0lkrGmN54EzrUZVezz9C2So+O0nhuKfmTVFjEyxl3MCTYUBhpCM3z5
         s/tFi9rRLwE0yYxx+++17WEAl1yVnrKY1hBLFm2BvZuhz5U8UEmQDVviVzm+kYNXDyRY
         rR82/b26bOiLhflumVwkStXiQlM+MEEoVy58JRawyt+eAWYxesZWwm9rVvQIfUOumLhv
         xA9RVLLBmkDRgeZGmorJWEIB2wgc1VfiYlOoYrOGBDuTm1NUsCooYzHDIHW0EsMc7nS9
         zSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216380; x=1706821180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxhQjCPn4Rmv3lAxNtNAmeDVJacck3kwKzoL0OQKBYo=;
        b=DKOvBxIgu2YwOzyuwq5iOmA/lU7byI4A5Uo9vA1ymOL0N52JZuBcCasG+PdoomJCO0
         zagPnQ5B8oR2Xkff7ksmWqqEMVI2//VuJ0LOdteTjZp2FnIruuvnKsTbYSag6tZFLjFd
         I5tpA+ePu7qUL+2qs7Nlcozv6hsZEcfjD0Lp7/dE8veTaxx4YFRqj4/6+n9V4uwfQwK9
         GgPwpOn1qZV8glxTRLnRhvHEHGudsbTpy3KbVJ9fqkbHadIbdr5r9tMEZiu7471PJttO
         k0y1KdtJcegDJBwGcfcaiBXzpcuBQmE9c1Q1DIWrl4hIlJX4docDMYyB6MVdbcX+SXOP
         svQg==
X-Gm-Message-State: AOJu0Yz4mog6ApXre48HNgFtC3DRLrH+a8Xj18kMK5w2lVF57awkgiCV
	6cXJ+zZhzv+568cI3JkdNhpfFQEjjv5reG/yhvdM7fgJAakb6qTMa6HmSD+NsYwslcqg6Y3Shuv
	bilHvVHXTHwuh7w+lRL7kRvn9OZqsuwRNvTnd
X-Google-Smtp-Source: AGHT+IH6w3OVXl5Xxvj+X6w0bhRST4tKM7ssjJkE4Ww6EnA/boQv6Rq+izaq72As41Kbl3V2NYqiU7fSbQrPhDQo8PY=
X-Received: by 2002:a92:d4c9:0:b0:35f:6f66:286 with SMTP id
 o9-20020a92d4c9000000b0035f6f660286mr3777ilm.11.1706216379661; Thu, 25 Jan
 2024 12:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125184411.30757-1-kotborealis@awooo.ru>
In-Reply-To: <20240125184411.30757-1-kotborealis@awooo.ru>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jan 2024 12:59:27 -0800
Message-ID: <CAP-5=fXWALXbbDSv9rY9DN3vRy8aynk2MQEBCbqC7drP-Xzcrg@mail.gmail.com>
Subject: Re: [PATCH] perf data convert: Output empty string for null pointer
To: kotborealis@awooo.ru
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:44=E2=80=AFAM <kotborealis@awooo.ru> wrote:
>
> From: Evgeny Pistun <kotborealis@awooo.ru>
>
> Providing ill-formed input to `perf data conver --to-json`
> causes it to crash with segmentaton fault. There's a bug in
> `output_json_string` functon: input string is not validated.
> This could be reproduced by crafting input that does not specify
> hostname/os-release/etc, which are written to 'headers' section of
> outputted json.
>
> This patch adds a null pointer check. If `output_json_string` is
> called with a null pointer, it should output empty string (`""`).
>
> Signed-off-by: Evgeny Pistun <kotborealis@awooo.ru>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data-convert-json.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-c=
onvert-json.c
> index 5bb3c2ba9..f8fd22bd7 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -42,7 +42,7 @@ struct convert_json {
>  static void output_json_string(FILE *out, const char *s)
>  {
>         fputc('"', out);
> -       while (*s) {
> +       while (s !=3D NULL && *s) {
>                 switch (*s) {
>
>                 // required escapes with special forms as per RFC 8259
> --
> 2.25.1
>
