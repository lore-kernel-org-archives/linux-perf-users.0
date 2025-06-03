Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0823E35B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967701; cv=none; b=umTkXF8thEnZquCuYKBtELdg7s88hQI9egeLZU4XaZ/W4EmWvxFE6HYlLycwunaYMsmx6rHgxbDA6eunasyXKn1wGO/xYO5j1xjXUPVV0uSO8ej0Lkf4GYOkMibZqT7yVoDMTNyGKIXveUrOHmpZ7AbwRqa0cOdJ2tl6dk400Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967701; c=relaxed/simple;
	bh=QN6vQLNwGhhNM/4tTumTA+9XED7x95B6fAyfcDbulT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YooLuvfGIqcQzpymJXJN4SlFqhj3emxI+e5uz7ilVX06Aflg6Axnk/UN4kSmXdTrUtGksHCECFdyMy8LUbL6o8Ot/l4v1ojw+iBaeKNbYFVIcC8TllRSqsOoRH35B5dlKNdWLEMYd2F0IOPcOXPqulVcZMnNDisuMnJ/vvWl5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZa6IwV7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZa6IwV7"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb47e0644dso6374566b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748967698; x=1749572498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PkTMBLG6WEh2+ki4d94T3ukg1lH9xLK6gNdvKHbQys=;
        b=VZa6IwV7zXPlFHQVP404iuVtEswmEXzTPmz/YKuAJiBzhlCj33oC+5Cy5Y8G9qQzZs
         hzEOeQjtxhvtZiAXf68KiYy+zwD5hL/d0xfEEB3K+wPks4IAThXcKnUPZQA9+vvNjeuz
         UroJtHAUAwlh8oRLdpHBbersnXYIBZAiRHJ5EFiP2GFjpHTQyGzm54PN/ZUl6D3bWX/V
         d97UpfuhooYQdNPJlvvToa5tBcMVQwkUG0Ym/wYfENrrLxR70nVH2Bp5Eoi11cpwZ0SW
         wzEf9yodzTNuQIfoJpvR20Oy8fBenzdDrsE7y8vOcV2cb0+90my+oDORfYjPeCWvHOlb
         rvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967698; x=1749572498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PkTMBLG6WEh2+ki4d94T3ukg1lH9xLK6gNdvKHbQys=;
        b=pWquuPBgn6vwJpp495o+2Eu0cVbOghtjnzajosazDTtAgKQVE2MSRcJmh8AO4sioN2
         wnxqoz5QDh81SwXVDHzCzo7vEeDDRDwNc6VhQATDE51z1CFm4i8McZNBOHJMDzImUCwe
         7tZMLdRS2rAyByJpjpoZb77mMEhjY/1ne0EQOsibLfBwqW1rXfg2cx676c2FoFSEwOHY
         qTNaFyBpq21lXh30cEOJk+mQ91bBiFw06pYZKX5Bfc7ewZ4MGjxsJFle2c071/t8smhy
         flRICvD6JgWJbVn/58bd/8k/ouxQNgdi8r8/PZCpx/mxHvMs2wuoiH7wGV91FWKp63k4
         GxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7u/XgPXvCgUVKt1cZBSSmdMbEJ5kgnV8Bw1zUi3HaOko4V/IqK4mdlhhtYIiL0ELfYwemJwa6o7iKahcmOtTI@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjs/7bmEPthxdXKzDB2uYJUa9sZDmzEINsb9CvxgJUiqVRPbg
	AT0x+YCPJ7E5BSsncqHrzDRK/qQRduGe6+8fOEm0P2xeUk0Fm9Qz+DY6/DZHNjxvXHtqB90sAw7
	LtRK728dDalHMueBi50tBk6kZqJvUYkEd6Efzgbc7
X-Gm-Gg: ASbGncvuZgaQlX23oyLVkHmQo7BTeP4zgfmyhRwhO658ilrogiqzNRvmk9/bfkOwTTy
	Q+va3J6qloAaQ52W41vVWB3vrumtLbtyXbveF6GUuKEgJy6mIigvX/8kxcLlNidr6pFeeCiLIyt
	u+b1JnkNrYrhkwciaJw7NbHOVNgXJ4s906Xb9/SNjk7DH0h+V8eVCpkD5+x+OtVq4zUNEKkHA=
X-Google-Smtp-Source: AGHT+IGofMiMp5RzX54Dq88PCjwcEfaGTsDR08iI/6PMtYXd/VtZgV4Q4ahV960pEFhnR7LC4ApwMPzxoNAd8I14fZo=
X-Received: by 2002:a17:906:c10b:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-adde66ca1bfmr353698666b.20.1748967697406; Tue, 03 Jun 2025
 09:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521224513.1104129-1-ctshao@google.com>
In-Reply-To: <20250521224513.1104129-1-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 3 Jun 2025 09:21:24 -0700
X-Gm-Features: AX0GCFsXrGlYlktpbNu8rcJOkbZR0XJOI1qX1i_R5RTBKxUDewa_es2-rrdwOHA
Message-ID: <CAJpZYjV_XquU785dhOPVGM7k9N_6QV+1OxenXLj4-fbDCj=yWg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Restrict uniquifying test to machines with uncore_imc
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Thanks,
CT

On Wed, May 21, 2025 at 3:45=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> The test would fail if target machine does not have `uncore_imc` devices.
> Since event uniquifying behavior is similar among different
> architectures, we are restricting the test to only run on machines with
> `uncore_imc` devices.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/tests/shell/stat+event_uniquifying.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/per=
f/tests/shell/stat+event_uniquifying.sh
> index 5ec35c52b7d9..5a51fbaa13bb 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -9,7 +9,8 @@ perf_tool=3Dperf
>  err=3D0
>
>  test_event_uniquifying() {
> -  # We use `clockticks` to verify the uniquify behavior.
> +  # We use `clockticks` in `uncore_imc` to verify the uniquify behavior.
> +  pmu=3D"uncore_imc"
>    event=3D"clockticks"
>
>    # If the `-A` option is added, the event should be uniquified.
> @@ -43,11 +44,17 @@ test_event_uniquifying() {
>    echo "stat event uniquifying test"
>    uniquified_event_array=3D()
>
> +  # Skip if the machine does not have `uncore_imc` device.
> +  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> +    echo "Target does not support pmu ${pmu} [Skipped]"
> +    return
> +  fi
> +
>    # Check how many uniquified events.
>    while IFS=3D read -r line; do
>      uniquified_event=3D$(echo "$line" | awk '{print $1}')
>      uniquified_event_array+=3D("${uniquified_event}")
> -  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
> +  done < <(${perf_tool} list -v ${event} | grep ${pmu})
>
>    perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- tr=
ue"
>    $perf_command
> --
> 2.49.0.1143.g0be31eac6b-goog
>
