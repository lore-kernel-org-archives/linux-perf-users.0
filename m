Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54103279DCD
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654700; cv=none; b=dOHwxhRzNRMjrOq4sdTyTXqOUNQBYTqlNoHHrDeJxxQ1sm9293lnHACqUBgXAuot8d0qV73HCFyADnc6QMe9HRtPYAmVejY63Q2m26AafMq9bKw51rO+9MY1jS0rg4LpqGoznXQfWs4gap2F6hY1lSHbUUQr2aLhONHp3RHOqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654700; c=relaxed/simple;
	bh=v2u3DDN1vJUVWkyENZTFaLudE3ZJMgsmiptpJTv/vfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIhHt22ZkhWs+GLFjlTUQdm6GnDd2XyDKwFy0le8E1Yx9x1C4xlGJ0db4fg7sqAmc9dF0hGCk2Ph4mSE+wE5s3X8Vdp77eqAiWQUGWc3LEsdFvhf/5fm/5hvTERrI7TMOLcIFIOY5DKJAzpJ3JK36P6rg2tqd4SxK1I2FiDIfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UF4Z5vRu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UF4Z5vRu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2681645b7b6so34565ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654699; x=1759259499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0aRp23onmuK1YI16vYV3557ffQNsqGxBUdhV7enEBI=;
        b=UF4Z5vRuspYPiU0nHg1d2MZYT5G8N3Hwuqm7KiKSWQQ8aPLedxJXXu+8OJctMkT4oq
         D5XJIsc2TSc6wvHM6VoabyRIPH+q2gExVXhS6RkjhsbD4+UVWNGcfAEuA+o2vUmPhjkS
         EIkmQKTa9kAg6dFIvTGuR6nwNnpMZU6KrrW9C5r5jvc1jq63vviVA948v28OdzGVaRJQ
         w9YoMs7rd1eURQehNh01yG16CSiTWXIPsteeMj0VlGEY4rTtTdV5rItYOq9R6/JPfU3k
         0A7dnm7X/gqKr3KEDUljDKnUZ2m4DKLk1/mggoUtAPodxIYTOa/CchDF6c6tTwpcoeHD
         Cwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654699; x=1759259499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0aRp23onmuK1YI16vYV3557ffQNsqGxBUdhV7enEBI=;
        b=NXEpEVbK4xQklap9pJuCLq6UWD0385riE0d3uDPQxqEdfyiOuQ+AC7QQjAY1H5Woys
         3jXX5KPlHUKobdFIMZKOl3iSPlWbVmiaZ+JM0rD19N8YZn3810wdXiYyuCDJxIPK4odp
         N2PrRXBGlNcYW8y0vuUOggJKn3AefDWPrX14kVt+tg9UxMq7839RLqFtYfvSTuWYFspk
         wwnXz1VlVfDVpsWN0AP/7xbrk7xF3G6Zvz872bTwtfd/VDDc3EesLf61eYvbSBM8tFg0
         Eik3MbmjD+9fqj+KNfTPwIY1Ky/fvYSmPNSGpDoK1ckcOzJUe6vuRPC6waP6NlOBk2Hn
         UrQw==
X-Forwarded-Encrypted: i=1; AJvYcCWsfq8jjsd5CkqU0H2guXhBHH4DIDBzhXG990ahrXp7f/AyfoSh0+/5UA/hrTgeLIL1gXb9OOe263g3/4gYyO7t@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvOINcXLhw26rsRdGCiwJvpBIPQ/mqGFy00dJi4/rdIMfPK7F
	ebCdffYC7Aqelrngi1gRdNYhuQ3bVYW7WxNg5WP+ZwF64cRC8JFadqburnztFjC37fY1u7PTzP3
	8Pd/FYIXSh62HdE0X+cuAXn032sM/wkwLPCaMJR4h
X-Gm-Gg: ASbGncvGOQ1+K48aIMxAnZHlRbnKEPyuVUJYsDSVSJ8TD5pAnQdSJAm87T0uWb6eu31
	zgONXfrsBKMHm8nEWxMgidPmRSjoiN5GXFrH5uruMR6rTCAwVeuA+R+ZU0Mekvip9zMEK2BdMTI
	yEnAK97BJOV044Cu56qVXeW4rAcSqaztONtQ7x7K752/v/C0RhfKRXbxL4ExmJfVlUjkCvegh3N
	DliJlAlyPvKhg/twRIsE79udLbBQh4AZP3PETqDESAj
X-Google-Smtp-Source: AGHT+IEpvMZS9o5jaVovIxZDwZ9QySAPJBblw7ubBZWZX7nsSiZOYR0nqp7c69ovmbFdYEiy+CLg6p+NRQ35tylvJe4=
X-Received: by 2002:a17:903:1a2b:b0:26a:8171:daf8 with SMTP id
 d9443c01a7336-27ebe65b3b6mr791355ad.8.1758654698276; Tue, 23 Sep 2025
 12:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Sep 2025 12:11:27 -0700
X-Gm-Features: AS18NWD5fQaeN06M8Yt6DM0g4l5r_sCqXJfp2FqaVb5LfSYPs2ldnjrBFJ--oqY
Message-ID: <CAP-5=fXVFBewYhSmjVCGTbzEN82apECRLRnSeit8rqydCBJ1bg@mail.gmail.com>
Subject: Re: [PATCH] perf/annotate: Use architecture-agnostic register limit
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:43=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Remove the arch-specific guard around TYPE_STATE_MAX_REGS and define it
> as 32 for all architectures. The architecture that perf is built on may
> not match the architecture that produced the perf.data file, so relying
> on __powerpc__ or similar is fragile. Using 32 as a fixed upper bound is
> safe since it is greater than the previous maximum of 16.
> Add a comment to clarify that TYPE_STATE_MAX_REGS is an arch-independent
> maximum rather than a build-time choice.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 541fee1a5f0a..1f76885facb0 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -189,12 +189,15 @@ struct type_state_stack {
>         u8 kind;
>  };
>
> -/* FIXME: This should be arch-dependent */
> -#ifdef __powerpc__
> +/*
> + * Maximum number of registers tracked in type_state.
> + *
> + * This limit must cover all supported architectures, since perf
> + * may analyze perf.data files generated on systems with a different
> + * register set. Use 32 as a safe upper bound instead of relying on
> + * build-arch specific values.
> + */
>  #define TYPE_STATE_MAX_REGS  32
> -#else
> -#define TYPE_STATE_MAX_REGS  16
> -#endif
>
>  /*
>   * State table to maintain type info in each register and stack location=
.
> --
> 2.51.0
>
