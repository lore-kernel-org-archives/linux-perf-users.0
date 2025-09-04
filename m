Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EF283C82
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001437; cv=none; b=JTBS51O18Odx+nDzLD1hrxXskb+Tb+ndqAmUemnzu2gta+xQ110dNEEOIJFu3xb/N5AN8INKQkpbdORzV7tAVeBibFgc44/CeMrPHI8XZ/25YSr0HP2/UUL8SsJvAuZ00bkj/TIaP9oQnHNbD2Zu/lD+KGA5aC3gXiILXWMoI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001437; c=relaxed/simple;
	bh=5bwgftlti0OnS19E8s5I3qUBUN5cb0H7I5hTJs1jaEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlEx96AQHsJHvp5WBMcFs3Z96iLW9wqu1K0uUVd7Sm4wSmN1yKsW0QCLBT9KDfIFq6qwqv0ogAef0bvCHU7sfIDVu8Hww3rQ+8Z30uokFNN2ih5wRk5FQLEhRngAi74JK8s1vKkcHjPQFmpoC7/AdR9HqeSSduoyQgrPvHDPyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlu9umTu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlu9umTu"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24ab15b6f09so202765ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757001435; x=1757606235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knBUAJ9UaN+FZLHj0gx+L4m7BuumlipWhHmFcevIGIQ=;
        b=wlu9umTujnJHZeYWpfX93lNgSOkFLhU4c/fWbrf+hzKIES8J2DN9jQ5vAyAjUrqUtX
         CjzT9pEIHd/3SPKzuH+gS9UYJxRBwzSoXWs9PuZbTniH/c08yk28M28OoXYx4FYzUbwN
         o0uR7FYWRTo1hqQvAH2x58rYpuzADKA99YzlxvGy4j/c1kOb+uBTkU0/8LR+N50SWSsy
         2KfsAqo6H93bFxFC9Ge1rYRMW4dbFv8hgmWuJXpnVMBmA2YgfaNYBYKmJbEJ1+QOJsdf
         FxDAx5ywNmdXI4tLdcEgaXFSTFEWd92maIEoTY27CoIWgHV91oXvzuX+9ldOIuK/qaHp
         L+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001435; x=1757606235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knBUAJ9UaN+FZLHj0gx+L4m7BuumlipWhHmFcevIGIQ=;
        b=KQZkhadi9pIaaXw6l6B4mUq06jJxkQDVCX8nLUziSFqb0KGl88WoOKMeWXgOjoyZRH
         rOoclKP6YQykeal9h4qw/8fF9xHsxH1AKfYDE217x76yAlj9vCiwp8Tqi8o6w9tV3Gi7
         nG7P4wCUCpRoQPh+xNUxCcEfywMoMPj9qzFzo3qT1FV815qqufJDvQQOKU2T8nXTI6le
         +BQoU3guGNUoNaRcJr0nXgKF88W0QLpytlwdspdy19/xEbOO9sThjQZTxLBV/9W8PD4z
         OkW2xsehv2nvxA4wxujW9Th4qfmrynVOb9PKZ3Io9zrhdcq50IcCInDi2aEyRZGg6Bbz
         3jfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrinaSv0LRO1E/KwxLHRyNc4vMIOdXX6sH7q4Oa/4JpA5j+U8+pTAco+VhSiv95ekh+CUOab9TuZslxlHZWtr3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Pkxk9w+XrUxSxysBEoiDASA2Iofbk3kDTmgLlrBUyqnkOupv
	HXx95hWgc9m6UvHuwjWY0a4KIV1D1jUtyMYSl2LRjuXgU57Zu+EFZrvO49in4iX36Vh4NPd8pRU
	0sJhNyH45LVRCXetFdkaO7vU3kCpezzgLjYAjyGzS
X-Gm-Gg: ASbGncudQpwpo35EFUoXhHlTSO9D4SliZCIJ2jhl+q+YH9Kq5UdumB+YbwP6zlafmbI
	lDt0ALHpKG6aZRYMHjg7SM+adyeGNqYAM7gApYAquvZXhfwXMXU/JQ6fo9Sun7kG7O0YNY9f98o
	cPllwBZBqBOE7ieyKz9PEiqK7DM4VsfhvzG5ZxkpPELEvHG+uLnYM05Vcoa7vuYzvYS6v9qgwB0
	LpPRqyFktzZmdN434blAXh4fPzZqJYzb3sSFmPNg8R4pYxqbejAtzM=
X-Google-Smtp-Source: AGHT+IFruwuAGBkh7rKP7RWIUwTJnAWvhVe1xHsgspTlHo9U/RM8g1S8GgdHNUpcy8Rksev/Q7nZoVg7U084PMlX+h0=
X-Received: by 2002:a17:902:e88c:b0:249:10e8:c866 with SMTP id
 d9443c01a7336-24ccccc4984mr3559105ad.11.1757001434759; Thu, 04 Sep 2025
 08:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904090904.2782814-1-colin.i.king@gmail.com>
In-Reply-To: <20250904090904.2782814-1-colin.i.king@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Sep 2025 08:57:03 -0700
X-Gm-Features: Ac12FXwis0ieQjvaJDpAAZ-N5VUsQcVYBE46x0ADT7btZd7ypFajhQSQ5YJpnbk
Message-ID: <CAP-5=fVZ-mQTRzA2qkW2NjB_W_AvNJJ7mNJj5cBh1jJX7X8Btw@mail.gmail.com>
Subject: Re: [PATCH][next] perf python: Fix spelling mistake "metics" -> "metrics"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:09=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There is a spelling mistake in a Python doc string. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin you are a star!

Reviewed-by: Ian Rogers <irogers@google.com>
Fixes: d0550be70f7a ("perf python: Add parse_metrics function")

Ian

> ---
>  tools/perf/util/python.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 47178404802f..779fe1280a56 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2187,7 +2187,7 @@ static PyMethodDef perf__methods[] =3D {
>                 .ml_meth  =3D (PyCFunction) pyrf__parse_metrics,
>                 .ml_flags =3D METH_VARARGS,
>                 .ml_doc   =3D PyDoc_STR(
> -                       "Parse a string of metics or metric groups and re=
turn an evlist.")
> +                       "Parse a string of metrics or metric groups and r=
eturn an evlist.")
>         },
>         {
>                 .ml_name  =3D "pmus",
> --
> 2.51.0
>
