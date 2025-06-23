Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71591A42C4
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701955; cv=none; b=Xr4uCH8YS3wyUETOSqK68vGC73vOTWlw1jHEglHZu4hJO+WE61kf0nQlV8Ml3JD4BI8HUv18U/NOi8kQ2KeuvnVeyV24jf6EQtlz7VreKHd7wD3Ef81pkuvHuVlewrl5ldnvrTRiSuUiVwhTe3CEaIXKsc6DChvKagWe+VuaEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701955; c=relaxed/simple;
	bh=uB9Xm6eaRNihSSkT6yK/cq6q91QMQcRLKlFVMK316kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZmvp2/aaxTSyxeFAs5HKGzXjcX16zA2I1xrKGuyxesvdOhbDqXXzs+PGGYeHDjKN26HF8vzljjNUiS+Bcq7hHpSLjZndWfoVNWMBWR0Tz001nt8f2W1u/x6Vhxw3l2ZCmAGxgHGdKYM5mRxXGwYc2tW6wL9nNMaD+h1Go7Kh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHCNH1qI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHCNH1qI"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so16295ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750701953; x=1751306753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLS7bcTJVBZve2BcOYUtDe8oViGu/YRD7NKWZ/1+BTI=;
        b=EHCNH1qId3qG1LkmOt9avDJzIwlowSoPTb6+kryDgaB56DlZypxlMf1WmmCG94YAld
         GxcyKR4gmDU7NIt/uXT1joPzMLdx8t9j2Z1pD5Q86UTLlPpUFELBhQR8orW0ZpahS01b
         BaeUX99arYVGUH65Eb8jLCa4RkNKkDymsE6Wl16ibrhdbUxLBYsbCQyXyiCAnPkyJB90
         3gIJt7Z7MeF8p3N/xL74pkQfHPWAliO/k3MJqtvOujYBVc/+yoIzXuZ3samLOJFrKxbe
         X/nfBZWz2xOTdZWFCc8ci70i24NyucYLsAMR0UqRjAtOv5lBIarD04WyVbvpBccVoIh8
         UomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701953; x=1751306753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLS7bcTJVBZve2BcOYUtDe8oViGu/YRD7NKWZ/1+BTI=;
        b=Dqxf19pO7nWLrMGtskkWZxjLjXcpjeXZE6pU2kSPwEZEiDPdFLxTCGa7vJ11PV59Z0
         xlQ/abKqsqXyKxjH1HFzkxX4h+ZyKRC8uTFbExXV+ZhREwh6M9FeM1q0bAPx5yIYO7UT
         GLo6ER85EunBHyQJIeaJrPYoFnkZkj7Xx903FWCTejaqia1f/peQXb0aLpGIB5Q2ioJr
         1qbZXuGjlNn5uncrH4i/PBYp+ohZcep9Hz7DUPmdLXj6YHXA/IH+5o8Lu4Ss+82OzFMJ
         hHbn6ie7Qc1YNFFtBIHrccFE5vXrN79V27KQ2n9liwK/fLkLDXgnejP0U9OhziOQwmLj
         Y5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWs9Nc/IchFOG0KIvQwE56kYc8ZjvFRSp2V2q2/mI2+v3gT7gG1HpkNEMp48O07qEjPVJu3ZyNAjsA/ynSWe3L5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFJQ0RnkLwc5GsxvbcpJQxjp/fZ6vpxxKVarL4moH7SaAwcfd
	LJwZZEd/IiTNtCipgnpq1sj+jNDI5rhcnCYmZYLM32EibBPW3iZwBJ6hUBVpH8xkucZox1yjqE3
	jSMLDkCo177zXVdT1RRbmPDRGknJ5/lmSpGBdOBJz
X-Gm-Gg: ASbGncvZ0uI9GVUtsHd/LL2OVvZwjW1SPrVpD7n8HVzrM+tfkE7aU0j6xXG1AKfcJUy
	3i00EtcimwdU5oDbTb9VZ32dzLq+5nHioVGyXrFxHVFgF1ZospNq7XTLT/GqvK03UM1WtoUdr1K
	EbTvM203LtNV8bUD+RBnGOD1F0c+LeJxi30h35wxd3920b/JzWS4kcthASzdCQEe6DfB+tGvbP
X-Google-Smtp-Source: AGHT+IFoPkNVe4Q2bVoIHmMNhdShHH6deoeW7JgoeZ5gaNh6f1dgwmJRG0/F7F+VMSx2Mmh2gTW3sdf91IuPyKpMs74=
X-Received: by 2002:a05:6e02:1b0e:b0:3dd:ed9e:a53f with SMTP id
 e9e14a558f8ab-3df070326dcmr6234545ab.10.1750701952276; Mon, 23 Jun 2025
 11:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619002034.97007-1-irogers@google.com> <aFW4VJtk96JD865U@google.com>
 <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com> <aFmSuSyZ1ZNT94Tq@x1>
In-Reply-To: <aFmSuSyZ1ZNT94Tq@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 11:05:41 -0700
X-Gm-Features: AX0GCFuWZKcC5pRfc9BZ8I6NY9sP1wGLxCTxil3Ood7reBNkagEFXiDzqyyZ-wc
Message-ID: <CAP-5=fXms87LVH-Y5V3OpVbwUjY=hWAe0NTX4uKQf1q3Ax-WSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop process
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:45=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jun 23, 2025 at 08:12:47AM -0700, Ian Rogers wrote:
> > On Fri, Jun 20, 2025 at 12:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > I'm afraid it'd introduce a build failure on musl.  Please see
>
> > > https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linu=
tronix.de/
>
> > > I think <sys/prctl.h> would be enough.
>
> > we could do that but in the glibc man page it says:
> > https://man7.org/linux/man-pages/man2/prctl.2.html
> > ```
> > #include <linux/prctl.h>  /* Definition of PR_* constants */
> > #include <sys/prctl.h>
> > ```
>
> > It'd be nice to think musl was slowly getting fixed. I notice we're
>
> Sebastian reported on the musl libc, its maintainer replied:
>
> https://www.openwall.com/lists/musl/2025/06/12/11

Ugh. I'm not sure how we're expected to resolve this and have glibc
and musl be happy without basically not trusting libc.

Thanks,
Ian
