Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69F19F111
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148335; cv=none; b=MB3c4lEYz0L7Sov9qpMzMYRh86plJKmWH+UIeNjYFazkuepYQVW0GRTe6RkKdFIEH+BECO/bl7AjknxUZQuy6M+dfcrxEq/neVmKFFw3NUE02wYQWuqC4cYRcO8UtnKKMOuC154qdR2gSUAq4xezJ8z9VqteHUH0tv/BM6bzj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148335; c=relaxed/simple;
	bh=tfepnkRSYfeOewnGVp44vpTV71/1+cb85Xv4c75tmN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLt/quFXED7lcvUPeCXxCQ7sBTq94gt8sae69CnD0SJ8Ya5WhvHx/v+F1nX4cElDB8GxCZYhtbk5U0bcJfsC8D87CddiZCPImr93T0xRemzmhmn1I34JFd0Xk74ZojVUl1olc2EKBOHXHUBqshK4le7uXNjpvH/3Kqx7Www8G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpUnQCmQ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpUnQCmQ"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so174775ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747148333; x=1747753133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMLtJEXEa+JxCThnWA+Qw3y9/cF6frKLdP3FzJRv8bo=;
        b=hpUnQCmQc6WAq4jhE4G+z/POP5R5TUNXIEKfFob62ME8/rgaPn4GSzuWD+Bq8TyhI2
         VvBILR2l26B7tBrWRoIzeEUhmmCTlQ1yN+kL4OzIVvhXm0Zkm9sw++SaKZ0zZh0qFw5/
         IkSwbUhnWES18HWgA2aCsUd9hbJCIlbk9ISbvrOHJM1/xXP59ECvExZlEO5g1EsRBJ/6
         5g37TC2ApqkviFiRdbdyuI3xNoWjKABZPbxFO6URVVhDBDkkfGvX4dTIO1FLlipmbr5g
         RUFbSYYJ/+Jdy9ebADYxZlgne37pKMbIHI4tgypTr2iitCEtwS5WCKx4IXkJvBmq5lBj
         TXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148333; x=1747753133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMLtJEXEa+JxCThnWA+Qw3y9/cF6frKLdP3FzJRv8bo=;
        b=nbgGjCVC+0x8sRstvv9pwd+ZBbtaEZ/N6S8mxI/+mMxlS0GMessxKxIQ0TTuI2MRWv
         F/ax7M/oCxCI+eskzmWa2bETGGGSGMS1N8suU6jYpxaH389SzpvWc+P6SPFvNHDC9uI+
         vp+T7mGUSdOsoR3z+B26GkANwH5XyPGKl5WmFOHcgyOOEWJ5K0sdOj+Ojvy+vQRCRJ1/
         3Qma6P77JYIxWeSpYFP6wWcyKCzHWC7e07/uKVCtz9klADniuZIPsd8xJlLorZhP489S
         7+UYcllGq6vudTXrYx0U1mQt7lLb/vygTu/lzeV1oAI2ATtr+oqVR8LeL381D3NTJutn
         cTHA==
X-Forwarded-Encrypted: i=1; AJvYcCVHMAzy80gocn56GSp8lWSRFp+xxl/FNINzlQ7TGlmoOcHOOajYQybzv4T4cRFr4rPUO7FUBwDIgox0XR6dGG2P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58WZ7bpARe52aT8Ufl+ampQcpf6UGiCQMXQSIpQBBeSsxZg1i
	AiBRIpGVvLv8WUyee7Y36hxE2VIpS7itDU1g3HRObZwdzPOxLvZLnCk9x03xT6oL9i+8CAIEN3G
	qPJLzj+poc6JihZp580PnuyOi0kXhzGOMb0sJ+kqW
X-Gm-Gg: ASbGncteJyKV1s/OupVamJ5FFt6mkn3qoafkQVCiSBdvpihb8k9QwG4COhoGQSTd1Nj
	UpOM+zRZSqL31C4ExhLNJ9CdP7Ov2LT0ALG6bLwX4791PjJUh1+RnVi5jyyFRK8ehsegczwmYsi
	wx4DwRqSMuXYC0PCIK2ret/dBzY5/sVhWS8G8plsNBrqO3Hoq9EMA4ayWhsn1zRQ==
X-Google-Smtp-Source: AGHT+IF74IIY/0jhS+2GSY32PBNkpCfrOlZIg/ea9M+72KHGLhsaJJmebZ73DSz+cTM5+JyRQ3K5fraofDc5uDz6iPY=
X-Received: by 2002:a05:6e02:3186:b0:3d4:2362:9fbc with SMTP id
 e9e14a558f8ab-3db67ad1566mr3694005ab.27.1747148333236; Tue, 13 May 2025
 07:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509213017.204343-1-namhyung@kernel.org> <20250509213017.204343-2-namhyung@kernel.org>
In-Reply-To: <20250509213017.204343-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 07:58:40 -0700
X-Gm-Features: AX0GCFuqb0zKWHc2TH-_5OUvDAwdKGfVGYEWts_ndNEqqEGXb2ZoCtS2NYX3crA
Message-ID: <CAP-5=fWNtD5KfMCd5Fy7oKfVgXrgO=1jkhP2cxw204sKjyUxAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Update sysfs path for core PMU caps
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> While cpu is a system device, it'd be better to use a path for
> event_source devices when it checks PMU capability.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record_lbr.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shel=
l/record_lbr.sh
> index afad02d0180e023c..6fcb5e52b9b4fcf6 100755
> --- a/tools/perf/tests/shell/record_lbr.sh
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -4,7 +4,8 @@
>
>  set -e
>
> -if [ ! -f /sys/devices/cpu/caps/branches ] && [ ! -f /sys/devices/cpu_co=
re/caps/branches ]
> +if [ ! -f /sys/bus/event_source/devices/cpu/caps/branches ] &&
> +   [ ! -f /sys/bus/event_source/devices/cpu_core/caps/branches ]
>  then
>    echo "Skip: only x86 CPUs support LBR"
>    exit 2
> --
> 2.49.0.1015.ga840276032-goog
>
