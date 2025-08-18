Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E31F4C84
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546876; cv=none; b=Z3eJncq/t30Nmtovrw8XFz5j01UO+g7FkgU/2ROiCPQISetv/KwUbzavjAXmDJwerRyiEXN37luX/hEO2CrPEJDl1oPeMED5myVdTlmEaJvXThnGRUOIS2YAH6JjhakGchWicY0P/cmTUYx9TKRxTyCapfGeSd58V3kRLZ+VksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546876; c=relaxed/simple;
	bh=6Us6Mk7U8lUxlYJwLwrAqk8HYmG3DXp6p3hJvhkWkU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJgspnnkO67k6rzQpb2jvgZX+eSOGXa9KVA9LQwrEYK12Rizi+eqO6IzdD8oFaBPN2SJZOiEEKQPiYRNN1OBRLehs3qqhdQiK1JtMrS3kh8kfzpw8gpk9QU7yxNui6y3LO+m71oJwH/MekdB72clViQ4c42HCSQ+BM4v91dnoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+One8Ag; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+One8Ag"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d3be6484so4695ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755546874; x=1756151674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Us6Mk7U8lUxlYJwLwrAqk8HYmG3DXp6p3hJvhkWkU8=;
        b=N+One8Agx3viSq3c+Rh1yqmuOMDknTzFYKTmFk8nENT34u0qi3JwmUB2sfMU7dcIJa
         sUDJ3A1RnePYUdtHDRE4pRp9gon2Xga89v2xxc3huH6DK0lXD5nkRJGgqZ3neJ5iVhj6
         kUbDypcOW49XCmDX/GqcvejiS3kJLfo/K7R2z3iA8GyPELtDC/j3jjP2+1JX+KkaerCw
         mC7PQXQ616KiYPqFi0zTryVdnrnrv5j5zj5yWS+QX1wA4vDfT/ZFh4fCOaBMfqjT42S6
         hJUrBR29wjeNKsdKrkgCJhiizyEl0LMwtPArbEQs1Bu9PeN5jnyNdKMGFvnTvv1WyHNc
         ES8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546874; x=1756151674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Us6Mk7U8lUxlYJwLwrAqk8HYmG3DXp6p3hJvhkWkU8=;
        b=u8KRuIeRQEkF9xsCp0jZGjJ1XxDntgHHqIzt94tzi5epCiTgFkIjzp/+aUFg/fc/mf
         CHhyfNE83vRkA4aaTfSEBfFzMrGdIBobUrQTqBpfuPixtn09vcNQiiVYCn/ARRW39W6z
         bs0dCtlIhailwPN5q30hhywPBrHNvyJq29TYWbUsb+0jnugFQjAe0jAR8YoyalEWShZl
         0HmDrJcRF7fKkLEV7xblTrgIoLyrcI96puau26E44lcncbNf8wwiNDDu1cMygX+F8Uj2
         HfsQRTPq4/O5gxFewOdMuy1eURw3unTo9Rbt6Q0ohl+MGnHqb9LVVDZqltsXT3lEO0F6
         XE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7OLCkv3P93PS6jQd5KZ4EgP4gfhuV1RGyrMUzyOuo3xF9UlK3PPRKttuoaIfyE4kLIU7VoJCmbgRJ+NJxX4uk@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUou/QgCBL3TDaOHQqi7FvKHScu1ofIn3p0h+lK+d+ofI9TFh
	ryAkwvTqojBwHtvYZnqXA98kxK+c4zuC8RwXsbflphsIwYCEfGieXvPNj9qInQwL3qzy2rJNrum
	kEsV3DIVKhSfG2bDCki2gvHbQoirUCQlEm9kaqA8x6i4KBFnAs41WwWy+
X-Gm-Gg: ASbGncsoVtW2zwQ3uZtxypG8K+WI1j20//KxftyaFh7XM5FUehL/4fJKG/j5s6RqPyS
	JQXmnVc/LjpzCc5eqRZMyGWT+NSLYDTYEOKrJHHGhkEP/mJA3LzsdmOKbL94zTEZp0uTovC97ol
	hma1TVqMiOSnny75EYqoHOy5Qq7hCQsP97DcyKPks2Px+XTdvTRkMbBr136ejH4vo46JFGBGSnE
	KRZp3b5JgRLN5oc5Ofr+uut17LXIy6Qike2JS6fSCQ=
X-Google-Smtp-Source: AGHT+IFuy2ueueA60iAACaiLvkHJOf9fo01NfQC1Be/3M/GCiEVFkWElihAlyBuh3i6jDNohU+RejPdzZkCse0Gmee4=
X-Received: by 2002:a17:902:c408:b0:240:127:85ed with SMTP id
 d9443c01a7336-245bd9cb684mr7555ad.4.1755546874225; Mon, 18 Aug 2025 12:54:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805063209.3678359-1-linmq006@gmail.com> <aJ-aDh8RG4CXcnI4@google.com>
In-Reply-To: <aJ-aDh8RG4CXcnI4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 12:54:23 -0700
X-Gm-Features: Ac12FXzxR3h5HmBo_HOoyJRmDDOm9y1ebSZ80B8L0A3D_sEGoPVbbOddIXELL-U
Message-ID: <CAP-5=fWgaj_UZ6H_VbEzPyr-dLnbgdFVPOO5FuoZA+18jVHKkg@mail.gmail.com>
Subject: Re: [PATCH] perf: pmu: Fix IS_ERR() vs NULL check bug in perf_pmu__init
To: Namhyung Kim <namhyung@kernel.org>
Cc: Miaoqian Lin <linmq006@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Aug 05, 2025 at 10:32:07AM +0400, Miaoqian Lin wrote:
> > Replace NULL check with IS_ERR() check after calling
> > hashmap__new() since this function return error pointers (ERR_PTR).
> > Using NULL check could lead to invalid pointer dereference.
> >
> > Fixes: 754baf426e09 ("perf pmu: Change aliases from list to hashmap")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
