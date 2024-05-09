Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D214901B;
	Thu,  9 May 2024 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232408; cv=none; b=giLiNdky+p7fV2C6Kll9l3xx+UGwoI+LsqaWkek5GGoU7s9Qy5qhyj1bbIZk1oOfSGIxNR6lZImz/TAejkMkceMAsvjlZFIuBmnRR6Eu1C4dlquryizERGA9eRpu2mSGCe4TlFwp8TUFT9HV/2Um3QGTieIKBzJladU/R+KEHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232408; c=relaxed/simple;
	bh=apyQisj0Vibf1irDRbxSoL5JY7lYjpi1CmS0djbCBBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn2lKva8KZgD0zvysfq/B5l5mjhlnaYygY4gYjuXHPIu130LLNNfK07uiQ33szLjtsnLnmWyI93vwpusFptCnQc919JnPvFn4Vbl9shWQuKlqYbMqzywvGTtwHNpvNAbKtUxMV/FWNLtiN3QuJhymi9Ng8huKF5NwZCOyVSHksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dca1efad59so404616a12.2;
        Wed, 08 May 2024 22:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232406; x=1715837206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrwlnJmatzPnGEjiAIUfkh9F7RO/oJDpBLzuWh0F9Z4=;
        b=tKNUsKpHRcsHBzTZxIfosf6givNsgwB/HF8FLfDmUwRcW3O/+DO9hcUIUISEgiNFBP
         NUcrx9b/73sVxyS0v19U0m+IAJvXdeJTR3VPtYuwVat5vBLJcbKq13gLf1xEetkE600W
         Vw6vI6txwr+ll2WVroHFFB3Uw1eHONUYVazJv81wUysoNyqgoiD0mmVFrKa81kBki68P
         RqZAv2R+przs/yu+g8/BJw+9N3ffLk2RcyoSIiNh5Tmhz7Mxre+C+K6xWbMN29hEbYJI
         P2vGVeX6GrilabEpUhDwoHIETSWIN2NqfrKy8qm7nfRBj0FVnLwRIT6A6sHIhyCXtn31
         ZBqg==
X-Forwarded-Encrypted: i=1; AJvYcCVxRpQNJjGeF2qHx121BTy286w1DIVvjK2v2a0+V5+tzpxlfAqRsKh4dw0iqlpAjaWG8vq3ybaLPWawQjjfGG/+ehcmT+5IgCJ9n8iOyu97hEColk/T/wHDxkd1VG/bG83QssRXeFZrcZxUBKmrkA==
X-Gm-Message-State: AOJu0Yy/9dkQY53bkjbRr7E/vc+Pic+vTc6Sm6vxWQiqsZHZAhs4oemF
	ug9ofLdpP661kJdzkm34hcvtOj2cqRhniM4IydAu9/XbOvKgQSuPWPLBeOiVgAJ1T+HWeZu3stx
	qXeIA/uIORCfMQ2CIRnb2AA/APNw=
X-Google-Smtp-Source: AGHT+IFALoTNFBYi7lMOsNvjNZn6QuUn5d2pMz+I8EBXl+8Hopgak1Sqdd4UgyFzAyAGhx+Q9L6K/5KfSqcDb9cUYJ8=
X-Received: by 2002:a05:6a20:1019:b0:1af:cf63:3742 with SMTP id
 adf61e73a8af0-1afcf633926mr2603619637.42.1715232406354; Wed, 08 May 2024
 22:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com> <20240508035301.1554434-2-irogers@google.com>
In-Reply-To: <20240508035301.1554434-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 8 May 2024 22:26:35 -0700
Message-ID: <CAM9d7cgw45sv2fLm8Yea_RgrOLswSPErwMORCBaeYVb=OXjnZQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf ui browser: Avoid segv on title
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:53=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> If the title is NULL then it can lead to a segv.

Just out of curiosity, do you know where it sets to NULL?

Thanks,
Namhyung

>
> Fixes: 769e6a1e15bd ("perf ui browser: Don't save pointer to stack memory=
")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/ui/browser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index c4cdf2ea69b7..19503e838738 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct ui_browser=
 *browser)
>  void ui_browser__handle_resize(struct ui_browser *browser)
>  {
>         ui__refresh_dimensions(false);
> -       ui_browser__show(browser, browser->title, ui_helpline__current);
> +       ui_browser__show(browser, browser->title ?: "", ui_helpline__curr=
ent);
>         ui_browser__refresh(browser);
>  }
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
