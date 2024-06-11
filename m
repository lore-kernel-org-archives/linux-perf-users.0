Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F22B9DD;
	Tue, 11 Jun 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121819; cv=none; b=GNlJcteGcHkYqTbqIlVETeiU3/IpauvyS8+JAN8cYeMvcuz7H+f8i/6nLsV0/noySZS29soakQ4HEbxOlxeeL63t53N+uH6qitLxJActyI0drlBA9a9vjTh8488UffMUN5sNpfeAnxIeackr1A8ceBicZxsAHCg7iZVmwLBRMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121819; c=relaxed/simple;
	bh=QOmpk5JLZ6uslcuqiWbyefS2HUNhd02h+M9Gsm9Qv0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/bbZCxs5epY1JxDRnMebCsFPG0pzMIF0is16Wzk7jNCpTYXF0OyQ7/Skeq5t0AGa3/SdN583QKdAaRMXBgYoAEcwxDo/GkKxpHpR4iK6fJ6Jg90Hdc3fAXtSVRJ8JeRU+YXvIoUM7q4tKBAtcumspP549mQffemYAaeCsd+jIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7041053c0fdso3078824b3a.3;
        Tue, 11 Jun 2024 09:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121817; x=1718726617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOmpk5JLZ6uslcuqiWbyefS2HUNhd02h+M9Gsm9Qv0s=;
        b=VQZddW3G+auGb5ODXXXvfmnmM1xVszRHQ8Dr3+rsiWubmfMReAd8rfV+shzv7DQ38w
         7Sm2QZeCjxxG4bZ/jYYW/qmRMmuufxWiQpNdmXM+zBNxhSYUSnXJV+c54NZiUxlxc3Rt
         HVfrldPsqLai48kLBphJ7axe8UIgLovpissO7CGLPKed/QOiDdQmoIB58Oi+2h5evg2l
         RYW/BlxaNSGnUqeBZnffAqMonmaIH0D6HTeOQB+pWkSpeKp6VTLlmUfAR/ibTL4SeIsJ
         3ObDRAuMERiGnzX//zx0C+uWKFt14Y2fIeXOSYWAO6VzGTWQ9TX1eDdV06AmqdaykhSc
         XpMw==
X-Forwarded-Encrypted: i=1; AJvYcCWzOcKBKVXNTvInjFmuX5goZpsYUK5NvKiYD0Edo0wBzRG5PSkSHopFaqssy1IjHUgZ8i/T1ReDm+fWTzNFuA2aRWSox0TQ6bN69PnIg4f7mLmowCvf/84KwdTsQkSptJ8csZkRKaFqGxTeGxqb4w==
X-Gm-Message-State: AOJu0Yz486b4ZW/iXNIXW99SqQTkZi/ZrH08PxXllklXlSORgm2BD1G+
	J0Wzb9mHU7XVrB1/ktdaQHBw1J8voaNeBCKgclW+ErCRkhnny9DEqC/YHywrXJFUgG7eE8ePf1f
	aBHzQ5FJPCK9WZDcMPnJa6z2rln8=
X-Google-Smtp-Source: AGHT+IGXDv1FPSpMzUHJGlIVNMuTkPreMewvl2JFTAd/3QehAidEF3D40lSOViix9U8zZ0p5AIWnrqUx+N3ukkl2nTM=
X-Received: by 2002:a17:90a:6b43:b0:2bd:dce4:8f90 with SMTP id
 98e67ed59e1d1-2c2bcadfcb5mr11942400a91.6.1718121816689; Tue, 11 Jun 2024
 09:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611050626.1223155-1-irogers@google.com>
In-Reply-To: <20240611050626.1223155-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 11 Jun 2024 09:03:25 -0700
Message-ID: <CAM9d7chyxF5LMz+-RQevD5N-vtg-VwaRq3+0kugeN8-vwLzHuA@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: Ensure space for lost samples
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Milian Wolff <milian.wolff@kdab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Jun 10, 2024 at 10:06=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Previous allocation didn't account for sample ID written after the
> lost samples event. Switch from malloc/free to a stack allocation.
>
> Reported-by: Milian Wolff <milian.wolff@kdab.com>
> Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@mili=
an-workstation/
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
