Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9C1E2613;
	Sun, 11 May 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746996214; cv=none; b=g8UPIDITL8bLgSpYIxf4ruy4PbPwroE8EdlhpI20OHDf9jNVn76SJkh9e7ZffwM+g4dHXxV1fNyZiE7CpHIp4+giMcqJgi0PAQBlgyNOpKBSzrJIAx+rsanspBrni5Cp8tuJwR498+xPVnTthBFFPQXPmk5+vb4tmpDjHma5i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746996214; c=relaxed/simple;
	bh=wDkvekKIFy58Bz8i7MiAQ0zrCMHyW3QlCx8LvOtWlgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjgPk3VvD+SY99va5CvaSEqaOvxdt7l/HtUm9bf+v5PGtAcHTATm6HNtH8bDLbY+iLvYiXGdd8OcNFellGV4IeGMBobGjpcBAs3zEK/zmQphrhDaOrbGDScnPHDFtdDyuX1RuHdZ7ctoMrA/Ko1k8rZ1SXhWzqiPpkX7Q5yGIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5SEf0k7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5SEf0k7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b239763eeddso1987499a12.1;
        Sun, 11 May 2025 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746996212; x=1747601012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPd929bIMrDT+5qnm0bIkkNcOs+c+3gR17M8PlMIk1g=;
        b=P5SEf0k7uAfdQFnpWpH7U66GrTNCa6DLLpjHtIPuEQnlH7erhr2LAalpUKAVMMP3BQ
         kFqcQ4iP0WQqMVWv0wEqHZ/OwF2lXxu8yIJLa9FCtrUk+/+upG7Ti9zpPFCR5hFlWs4N
         OdoXvKPscR2h9F/ydnl+2IsOOPPzJ+BxVcifJEymF8IZHn6ZQ3JnIqPCeevoPUI6ByNb
         RtR4iXZ1icTDYuXQ0yytbFB7BHJaCn+M4MgS5e06mj0ykL1VDxfWVxRNI1z0cx+rssia
         jurodmRlXSZ6LqaXpmfYjrOjfyOoMNyYBOvEo2NB/D6/0De6wMsK1l20ITZ9YHwq8Sil
         9GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746996212; x=1747601012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPd929bIMrDT+5qnm0bIkkNcOs+c+3gR17M8PlMIk1g=;
        b=ewh1HHCU5LQI+896SFC95UvoVclqOQ6zkhl39KWvwzGxFXy95KlnEVfaj/hdPAjXvy
         36ssWgqVPAXDVrSIQ9nfs19wTHMKo/tdUvuJiFHZw3YLP8u2QoomDS9gpy3OVJCvQkya
         37Y4JUrRn3TLK0ZENzhM5hSTbTDwDIyIoDk+qeygI/cufnEZ3jzC2KNfV3bHiibBFwvl
         NDMNAVLcaDHaWFyEVn5vOBXRorvp0unyg77R8zNHaeFE3xRW2jHemFwlzH8XfCJcpJaV
         6xl9ygXV7YXHWSL44gnX3ZtzMJcrz7UBgEh7PSz5yvf/b+r6Ve95QDETijO839UJs4fm
         BDtg==
X-Forwarded-Encrypted: i=1; AJvYcCWt6r1kj8BwBv34g3JSCHeT+o024+8DXGItGTtBkputP0kDYp1a0zunQzFtmn7RFmlXBICfxkj7xDbAvJX1DNnW6Q==@vger.kernel.org, AJvYcCXe27JNk/8gsRaa8FCwH1Zk9TBW+oqXFzL5euqMXqKuGN+y5IdDZl2NJa0uyBKLeqdntm7w9qWA2DUnC5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWaVn9eunGDFe2TqxX8Rp0aLi2Lfaej578XAPN7/l3rxj9q0P
	d6ZX7y1DkAQ3zC2D++5vx0OR+tBL1ErcmkDT7MjFg9+mczT+4rwSMOECQe+e8KZih0mfJ0+OjkP
	Xjz6hPcTBUcYgkcSIT4eiLfoGLQs=
X-Gm-Gg: ASbGncvL69OhYyuX74QSs7X3xQ5wUa+hNM4zg54mVzhjmX+TOY4qZHMLlvk9h97Qrrk
	2Ron0JgQv7r2YSKvtxVa235kvbwbjfWvJg0yr+VORB39Iy9de6mOdm3af+ETwTISEsZOCU7Znbm
	uq9zy80cCavTrMTeeM4Kv/n3STZ3A1gyMeOpU8HSnjFw==
X-Google-Smtp-Source: AGHT+IEzjPpd8aBIAHhKA+K8g0fgSGRywISB8UCK9sKavXtJWFYGmOK1s6pmOS8R2Wqm1GEFARAiLFYZmdYUbXnQZRE=
X-Received: by 2002:a17:902:ccd1:b0:224:a74:28c2 with SMTP id
 d9443c01a7336-22fc8b76a88mr162090105ad.29.1746996212545; Sun, 11 May 2025
 13:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506164740.1317237-1-kan.liang@linux.intel.com> <20250506164740.1317237-15-kan.liang@linux.intel.com>
In-Reply-To: <20250506164740.1317237-15-kan.liang@linux.intel.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 11 May 2025 13:43:21 -0700
X-Gm-Features: AX0GCFv3tPKjO7mnYpa8Bk3TIh92OMIcbfmzaY7FnG_rrx080Z7vPJ7GdsGjrZU
Message-ID: <CAMo8BfKWBdMFgRjxiW9kCr1zDuqeDcJ9WAc0Jfp69Pgvoj1AHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 14/15] xtensa/perf: Remove driver-specific throttle support
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:48=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
>
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/kernel/perf_event.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
