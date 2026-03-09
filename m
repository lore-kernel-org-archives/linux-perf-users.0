Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB93CE4B2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069606; cv=pass; b=jFp/y2DwRIDryry80NBUJBfeWeG5tgy7rrDvhjGkKtOM/4PYOtrfNZp2rP/8A8IAHhtBPPVAnX55IvtyyuPxyxx0x3PjhGgbsFFCgpeTyl8K78MKC7GFCD27wnmfDUZqQR8IAOiG2sM8h6hVLgnr46D79nJF6MCJYV9XPL6OR7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069606; c=relaxed/simple;
	bh=z6L5lDT6iJVMzgmGHw8+z2qnP+1bKb5wssYVFGZee60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4IZnuSulZBNfAojn+XUW0yeDSW0mPlU0fZO2UiDMquj1rXe4nIjOFPJdwnaa+X2s5r30/4WYHRNcNKRKn1rDYj5bmYlI6oHKpcDjo4IVbDUR2ZqHvW/INVJsmLQIaJDFp6I7iIAdWJKqgCqWkdO+nOtHAfg7RgFGPOuhMMGFa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/EURYUV; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/EURYUV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae523d54d2so146335ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 08:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773069605; cv=none;
        d=google.com; s=arc-20240605;
        b=LmWJO+zgA/0wBhaQVPtpoq25bazsAUCG5msi0syTft8/6rVrXTekmMdPSxjwGkHbfU
         rwfmUSfjy6UyGoqERwc3tT5zWL0hQ8g1ciXdsW4Q6PbneM+dmOUHki7+fME4L2r0Lo7y
         NuXeGgvwMv33osuMKMPkspCW2b2F0AWouj4A9Bm0ZYYjp6zb7SoW8MhuO7msqMlN03A+
         MIGPSFqjgh9oWyyH9n2Muof/OWFmLE1EeF444NsgjL48GuzNCjC6vCeCN6D70nk4T5yV
         dmdjTIZey7PbB6BRoNepWB/yg3N7rXLCOtrO/DMib++FcywyTTZ6Fpbmx6eTrURi4JQr
         0QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YCwgn/LGLbOqI0PyvUZQbnycgUxHpuGNhHts7H9S6JI=;
        fh=gnsbVSSNMRWLXaJ5Jtrp2ay3gJ5zZrXF6QDCIxLBMh0=;
        b=Fk/Mv+x6wiPXVU9yo/bW9HOmMdEiYD8P4OCh684l+g9mB8Ae2TwxZxi9WPlu2yD4N7
         zg2NV8NRTMR/O73TSJszKw1a0bNmgtTIpUJUnHrq3ALTDLDhr+4EF5aeoAfpVqWoogBT
         cfPEc21FxPVWijjWnrl5ejuD8LvkC4QgUfMwTQQ7BgoO1rH4Rvtw2nhsghmf18VXBUFV
         DwTBeeat0FyaZ51Rm9KmxzSxDGApgk8bkktozCcxHj/gF5ZKZMphwBt/a0qbBPD+/u9c
         yXzVBTQVaeFb7QDByA1iYtkBtkS+GERBgvF0S1TRnXQARHJUB6xoVtqUTCa1S/ZkV4a9
         fd0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773069605; x=1773674405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCwgn/LGLbOqI0PyvUZQbnycgUxHpuGNhHts7H9S6JI=;
        b=B/EURYUV1yYsg4Pco50scY3yj5cuGTMD/Qrl+LI7J++VQL4LZ45YONiNrpBy+wzl2z
         8Cv47iqUTnaziATJvLp8Fztk2wGhZI9SNCi+fy3y+rV8t1gZv+BuBO2/zbjUMRFNT/Sk
         OClVv8LKy5ZPrn/6P631UGLncCS43YHuNKa13l+jj/d6fEXWkUear7TEO4K2wnoCcO0c
         sa2SpDQ223DoTk5QAE6dMOx/Jyidp4IvEPqe9EimO0W+dOQw4TLZhuGneLxadubBpu3T
         jfCHj6TqrT41Y0+2mgdr4vx5zQ7J2vCwtlaUd5ISu7f4RU5qWgTEbu/pN0CJij8Dvyzx
         5W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069605; x=1773674405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCwgn/LGLbOqI0PyvUZQbnycgUxHpuGNhHts7H9S6JI=;
        b=PLpOrzy7JKcOc9Bu/Hfa/O0zCFJcgjZYohh6+22VW8O7P7jdl7J/kFhHQxNFn5Kcit
         QR0HUzmWyfmoG/X2Vwu60FWfkO254xgIntkcEvb3I9e0CZVUUWjL5mhbQPm8TxOpwoDd
         oGszOyElZ1Rk80/7qI8YOtjQJbau0KbLpsv9SEbJpu9NQ3N864dwuFd+qpIzoyhGf6FQ
         rllbv1I6no69++6G8bSUg9L/DNgejHLpevMqhjdlKxfoJwxWq/8AdTJ8XVwI79Jw49K+
         LCc3/IG7fQ+3RHOGPpeNxLDGs/vUcL/mfO0xQv/DxMaUbsJb+y1Hm59LSLLm5BMSc6OG
         8y8g==
X-Forwarded-Encrypted: i=1; AJvYcCVt/Zaj/6aK3+JOPYAb4i7v9HHei+qRZXoOrluVOMY4q9NRn0hqEirQ2+uaFe4vBKUtN3NdTsjALOvB9QZq6C8u@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3MoqM+JyuRTmmkjnCZQKJ+13OhvvGPCvAKjUrT3Z1Ohd+KjP
	tnLWwAm+3UsGFDe8KUSbbtvhSPvBZOXpEwVorNYSX7J8qipRD++Vf7SmQFyNqvBwRQu1Pc06BnV
	4o6r2/fgXLXku7V/FSi6przsRGJ13qSXbQYzRACtF
X-Gm-Gg: ATEYQzyE05jUFdbOjpXIsdPnG1O8FXA5HihPlGgiKkhoqFgIxp1+lgAsR/Qs8S+1AgT
	NmZbORxKdU7BxYP1LgzxeLpuOWzYzRqgX0PspGOwvT8cvr1OG5hqD//TNYG6Z8iG24w4mdzeYRc
	bFjWC9etBACtFyAfXoH7Bh3Z9VxsYv5NSZIIicLfVlP88JDDfTSIb7ftfpucjmOl2xg6RtqOsDP
	EwU4+SWc2ylWRwGLLIr9qGWhbdrPpsRxsDaDi601zDnv3dTl5EZcnvFjlZ/ob/y5pb7KQ29qDTH
	qQu4IR8skaaVhdQQ9A91kVHMYvt1umk8K1Yptw==
X-Received: by 2002:a17:902:c94b:b0:2ae:57e6:616a with SMTP id
 d9443c01a7336-2ae8acf04ecmr4622815ad.2.1773069604098; Mon, 09 Mar 2026
 08:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309010009.11639-1-akinobu.mita@gmail.com> <20260309010009.11639-3-akinobu.mita@gmail.com>
In-Reply-To: <20260309010009.11639-3-akinobu.mita@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 08:19:53 -0700
X-Gm-Features: AaiRm53lVlx387A0SrY6zRXv10i_r0OBQERaDBdoHzQAntDt8AQ7OB52dy8QI14
Message-ID: <CAP-5=fUPWNzFvsA0T3xJdGa1uQ2QgnZyphWys6AeFZNE54WXLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] mm/damon/core: introduce struct damon_access_report
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 6:00=E2=80=AFPM Akinobu Mita <akinobu.mita@gmail.com=
> wrote:
>
> The struct damon_access_report is borrowed from SeongJae Park's
> DAMON extension project [1].
>
> [1] https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org=
/T/
> ---
>  include/linux/damon.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 49d2983af4a8..5f2870ae02ba 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -110,6 +110,30 @@ struct damon_target {
>         bool obsolete;
>  };
>
> +/**
> + * struct damon_access_report - Represent single acces report informatio=
n.

nit: typo s/acces/access/

> + * @paddr:             Start physical address of the accessed address ra=
nge.
> + * @vaddr:             Start virtual address of the accessed address ran=
ge.
> + * @size:              The size of the accessed address range.
> + * @cpu:               The id of the CPU that made the access.
> + * @tid:               The task id of the task that made the access.
> + * @is_write:          Whether the access is write.
> + *
> + * Any DAMON API callers that notified access events can report the info=
rmation
> + * to DAMON using damon_report_access().  This struct contains the repor=
ting
> + * infomration.  Refer to damon_report_access() for more details.

nit: typo s/infomration/information/

Thanks,
Ian

> + */
> +struct damon_access_report {
> +       unsigned long paddr;
> +       unsigned long vaddr;
> +       unsigned long size;
> +       unsigned int cpu;
> +       pid_t tid;
> +       bool is_write;
> +/* private: */
> +       unsigned long report_jiffies;   /* when this report is made */
> +};
> +
>  /**
>   * enum damos_action - Represents an action of a Data Access Monitoring-=
based
>   * Operation Scheme.
> --
> 2.43.0
>
>
