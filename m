Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF0272901
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313801; cv=none; b=hE6GlxMTpgH2wEKELVFjC7FmewidhgMLXxYr4QFBwC1C80/ShcgHNqzssNtn8L5gHPQQaIKWwNGLtez8jykX5c7XvYmKQE8IygItR0XDuwFE+BdKf455z7Y+oPWxsgOBUpFmEty76v2+yryFBEHVOVVMrx0x5964wJU3gk6PeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313801; c=relaxed/simple;
	bh=f9KY+6eNEKUf11+++hxSSdeAgCYvmlb6iCdNJHIeWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI93+g+F8OBEVq4mJ3y2ebHedga4DRF2cr9NAqlRKgM//tBL1n+4CJh0aKPkEAYzVNGtlcGyqnLMhbr4raCKhMjK5yomE0Ln+CFcr0ZdGDNdEaBkOu7v6Shkt+x5OdjM8tHguKsZPZZJHrSvqJ+0f7e4vqgDMbMCVFa2fiSMO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRiQypg3; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRiQypg3"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d147331fb5so48415ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739313798; x=1739918598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB+Kz99xiql9mHJ4ulDoF28EHq/GR2RedSyzITbYkFc=;
        b=bRiQypg3AU6ZI+W27dgsgAeIRjICjIhWl0wtHVUzrya7DTM0dgbfZqCzqGkqt69PM8
         AcdMArKLgJZbgHWB+X4s+NWmFYSR4nS/oHT74/U0pa61yzexaUFJI+4/A46xQo3Lb/zD
         tOTMzfIyrxrXeNufwpU3b3I64InWjzY/WhgmwdsJKT+fyl27rLDgqM+NYauAIW1Fx0qr
         d0IHAvfQDiArNslg2vQTNNYdqp1utIWB6VAhYHd/PukVqtdyWJ1PhRoOv7/umUiO79mx
         Vl5V4Glpe+tP2kB2KStIteEw41L9PlLe8w2cpRJGKx99lKJngP5gxkfROEw8bPI7zxpT
         u/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313798; x=1739918598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB+Kz99xiql9mHJ4ulDoF28EHq/GR2RedSyzITbYkFc=;
        b=GhYbx54L14r/gP5iWWbS0Y03SFLOoxQme7bkwjLyRjyYaOzeKi1uVHuaxHrdqsPeJV
         EFLyviThc3utyD91AORi0/v7yiihCzisOwe+Il+tpMfvAlAEhJFO9Msd5Egg8OQpufu/
         KttEpCSeJuiAl54MpmqW18HpFuEkF3pWHTK1iFFVk1jS4wZvC0RjZfZaiHzIVB+5O4d3
         c4xAVAbStSdFg4SW0DNfu1H2nwGLagmOPAtRgGk5pW4k41ske4T2ohnR7ERNDTTCkXUY
         2dCB464vQy1mELMF4/wZjAIDtX5SRoz2kgdQlj5vTmRVgVPxhxuElp6tCeIaLE1VZfxf
         UCEg==
X-Forwarded-Encrypted: i=1; AJvYcCVkX2Rq5KV7TFc9XuZBVRyBGYcatlta7jaZ4oO870Xy0ZhPSIvIV8oQh+aO5BWDO42rUvHSoP1VtQcpthnEK2g4@vger.kernel.org
X-Gm-Message-State: AOJu0YxumiAs1jvRdmdYGjAFZZJ7TZAfewC+W3AxARf50ZbCYoG4YpYK
	IERFLU9NbCFmFACkRy+XKZC8/5b0QCBYvSKK7U6wivRhDfavBX24pBodiHCqcZvr53QZ2gkmWZI
	i1oWjmkwIvh8RMXQDRlECQLdW3gbUHX7gXqn5
X-Gm-Gg: ASbGncs5BLk8VZvVFt7NwTE7l0lO6tAVCx1D6h1UzrEHTTdH3wjZ1bhcPDmP2Son/BA
	6rY3xTvKlILmpFS4DQ8Ez4clFq05H2oiOVs/EOxiln6xerdhvJKbQQnjxvB9U719j/R4bU38W9e
	YwV93S8FBhcWYYIhNqv0Aiow97
X-Google-Smtp-Source: AGHT+IF+cb7GE8XgaPk0n38/Yi4kaWPSQbEoAefJVRYnQU6O9euNmFzz+KH9Emoxt8mZXUIIIsvpA+wdR0FLZmlK18o=
X-Received: by 2002:a05:6e02:1c03:b0:3cf:a4e4:8f89 with SMTP id
 e9e14a558f8ab-3d17cd5f2a3mr1080045ab.4.1739313797883; Tue, 11 Feb 2025
 14:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206000137.2026034-1-namhyung@kernel.org>
In-Reply-To: <20250206000137.2026034-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 14:43:05 -0800
X-Gm-Features: AWEUYZm25vHIgauOaEXBMf2v_MqwEaiH1o1lrNB8Jgsn7jomjRRVF7NAhAargog
Message-ID: <CAP-5=fUcjEONLZ5uTHMDep3xF2b7ZB7Krd1dEViUSYfuWT-G0w@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Sometimes we need to analyze the data in process level but current sort
> keys only work on thread level.  Let's add 'tgid' sort key for that as
> 'pid' is already taken for thread.
>
> This will look mostly the same, but it only uses tgid instead of tid.
> Here's an example of a process with two threads (thloop).
>
>   $ perf record -- perf test -w thloop
>
>   $ perf report --stdio -s tgid,pid -H
>   ...
>   #
>   #    Overhead  Tgid:Command / Pid:Command
>   # ...........  ..........................
>   #
>      100.00%     2018407:perf
>          50.34%     2018407:perf
>          49.66%     2018409:perf
>
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
