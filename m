Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7D128398
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383391; cv=none; b=Lm1lmyA0gHCtR6SaaT2uiRBbXghwYbSFaBLY3OAZxtm+dyS7fIP/a1IFkslOcCNgjJcC7oiq0kE46k3vdX368k4kSta8L4g1ofMdlL4MWWo6H46yEAvTOrOoVwBtn3JCjo6nK1gti2gfWSaUfp19lmBAUFTTZ2x2FZxWupIbSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383391; c=relaxed/simple;
	bh=zOlIRNoya9Aq3GjWxh2mtlQ6p0hJb024NC/3zSO3wCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUr8wY1hccN1YutGR0eUJ8Xb/9fKmcLzgC6vEJztf9i9+TWkuG3VbrP2tRjhbSMpgL5CctmXcMvQuz+/1G4wT9OXp1/Twugz2phsW1gbFJs8dXRI1ScEHmFgpAR9ARJ3wflUH29WsTfysfh01aVo9bDqZbGXu0fJT1wXs3RyEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=we89xq5e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="we89xq5e"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e058b9e479so250925ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711383384; x=1711988184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOlIRNoya9Aq3GjWxh2mtlQ6p0hJb024NC/3zSO3wCQ=;
        b=we89xq5ecztLSxHVx6TqX+Ik7StaB0sK7NID9ZZPca+ELv4T9mkbPrK3ONSbDzi+KM
         0NIb+qVBDQiEltq4j0dbJsYrHDISIRYS+6Ajd9CzitHMOY3dSHapVJbSM6CdAozfjFzt
         oFcSFSPaWb7qIckWHwx9vvpbJA22+RlgZCSVMDXpDEHUu4whLelp+1KxKWIiulJ1qrp8
         Bhkp7cDqbtAZUVWm+fezuTyz9FVjt7DfWzeUOeRZAkY9+Y4uozJ84GoFh0Myd5m9GU7F
         Sdlo1k8Pz6GqszAdZ+DzP2WFenL766XpRCAduDbmSKEPq/jrKaMt/XgnLzW8yDxezcRM
         /B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383384; x=1711988184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOlIRNoya9Aq3GjWxh2mtlQ6p0hJb024NC/3zSO3wCQ=;
        b=PIwgZfUrEyEbOXDcdWAMFWpX9Cj01g3J/0r2foMsb1gqWLL8RahAKti8zolpMu2XW8
         vbkS0rtuUM5QL2aokHRZ482khQQ5o3ceSIw4hRYkUlwftlWBOHQ0MIamvLP6iTCpEPgq
         KOOnuN7k4PN7PAJORySj4+5+Wtr/wZpnCF+wDiR/0LvW8KYltbW3DwyQW4OA2bp4Iu7t
         T+bHJ3fy+WpeWwcmEI1In1ERLKOqAl9lSRyhIWx3a7a72bvuoY2rsLoe+uZmzpjOHv6t
         QD2iYS7wYZFjWmikj4sBQxO0DfyMPhUnGkumj2Q1XrwwOEr1UgyOQqh9AqwglyS8sczM
         1jTg==
X-Forwarded-Encrypted: i=1; AJvYcCUquRZM1bpXEgoQNMdh5SuWOTx8KTZY7MsIzkaCtGQBnz+AlyygR/zk9+FMc9KTm8ZCt2NrFQ4KqooQxqhBBgYl/FWzgfdQ8q4fVM25Yu8ozA==
X-Gm-Message-State: AOJu0YwtrbddfO++VGN8zumyuQLQ1ZfaaGDwg+mdF6x6Bb1LCYqbKQoC
	+h+5AwsJyZaJKb0z9RTPThmS0LW6PCIE9thPGQd5DwjDvJaPqK84W9jGXZsCj38a0jQYK77acpl
	WH9j/sUX5sdUDRL846joZKCtouU5iFnMUDsIlQTYwf4ZnHQy4AK5w
X-Google-Smtp-Source: AGHT+IEE80IN0sVZNeArGeomMw4UaISjfm+I0OBMZngIRqWMmK3knvlf5ImAi7Deh5srmwXQgVIpqgJFEWafSpW0Ndc=
X-Received: by 2002:a17:903:2d2:b0:1e0:919d:b2ee with SMTP id
 s18-20020a17090302d200b001e0919db2eemr539808plk.2.1711383383441; Mon, 25 Mar
 2024 09:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202022223.GA903@debian-dev>
In-Reply-To: <20240202022223.GA903@debian-dev>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 09:16:08 -0700
Message-ID: <CAP-5=fUtB4sk2f9oUU1+mFdxyKGC5_5+RAB8ov0h7a=BvMHKYQ@mail.gmail.com>
Subject: Re: Document: How to Use Perf to Debug Perf
To: Leo Yan <leo.yan@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Daniel Thompson <daniel.thompson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <James.Clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:22=E2=80=AFPM Leo Yan <leo.yan@linux.dev> wrote:
>
> Hi all,
>
> I have written an article on "How to Use Perf to Debug Perf" [1] and
> would like to share it here.
>
> I call it as a self-contained topic, as the subject and the object are
> the same in the same sentence. This highlights that perf is powerful
> that it can debug itself ;)
>
> Hope the doc is helpful.
>
> Thanks,
> Leo

Thanks for sharing! I've added this to the wiki's useful links page.

Ian

> [1] https://github.com/Leo-Yan/write_plan/blob/master/how_to_use_perf_to_=
debug_perf/how_to_use_perf_to_debug_perf.pdf
