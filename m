Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1A140E5F;
	Thu, 22 May 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928010; cv=none; b=AfG7STOjOfmWQufrQLEZ++N5vposZP9YTtcfGxP0xQmwVADYBCqKIOK3gEvMKYz2KQDfB/6MZ3iRmwIkJkP4xHnqRGX/J30AyngLKqW10wdf0umdwTloWgfz7kE+fhJdH0nWYtxVnqjzxpLyoDmhMjx6LhTNLTb2pxq78QE0530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928010; c=relaxed/simple;
	bh=dHbAZ5ERAu9TTa4RNxr44TpsvhQH6Iiw4sMrY5lwR1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJDa+FFiEfGEtfbY4NWzcbdFMjbEQspq2eGxVxDFwkyYrNjBQ/EuwTPACce2LWXlk7GPPkvQ3ivMCc6+jNzurksJwi/qEPPrnQ/4TghYOEQ5XMbw6ZbQhCXV6AuHQaMFGP89EKwySTbcsodeY1ZOma/sbKClDVRQrKmeqYN1YyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilC5D9yV; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilC5D9yV"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e0ffe1b8eso4188047b3.3;
        Thu, 22 May 2025 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747928008; x=1748532808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMK/MFWIIEvUH8F/i4Odtp6TUa8tGn+mmKMDt/mcwx8=;
        b=ilC5D9yVIrIcR0gTZfd/sLwIDm1vnA3jRj8XbY0L/a0xU8kccqueaCMQ4C9/hjRb+q
         Uucx8vwW2n3XyK15WrdSNYmNkc7Kk/kys8NtG6bopgpGs/dvb+LbUjgb0bM4/a1ABGSL
         +ToEsH7Xm9/wSPsiHqkkrbYICIETJrQ27C5DRrQVyyVUGCJbLOgYNs61T9m8SylN8xNU
         uIOZVG0mQ0hWrxta3erNQVphg8L83368gR6Pe6RF7q7EBbD94oKH8GEUlSTvcadDe/MB
         hiWdS9I1FL0A92VX+v+nN0gV48W/4sFetsnJt4TE5ftjiCk63KwHZXnIh0n6wIKIsZji
         2LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747928008; x=1748532808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMK/MFWIIEvUH8F/i4Odtp6TUa8tGn+mmKMDt/mcwx8=;
        b=E1sLSWw1Tt/ESmSte2F5uAsujEns9B4lRVgdRA3KlwN9uVVnlBSUEKafWoUjmlvQDh
         dcn6++GbqXsBkrOOdZFp/GVoB87CnptzLiI3yGHqu2bfZyq/ZCKtW2egvv+3L/gbgO8Y
         Ns6mUYFJz1KTcYLjzQH8Mc7G5w+8T6f1fEmOg7Zgy6jrF3k/Be+WAADhDteZ/1uDNGhk
         X4mIGsYE5obc32Z4u1Djx5Ob+VhrkEUHpgzbka5dcZN5+MhUgDCFnqOqps9SMPt5naG4
         HTYaZ3BJgmwC6/6V1mVrwPe8WK5PfLQujA8hAm94IlTKFaNK0uTG5lT8uMWLaXJ+dQq9
         8D2A==
X-Forwarded-Encrypted: i=1; AJvYcCUw4a/K0dQ4lWiDUT79TepRuxmBW5tY9RJKD4lH9iYlYdf1TGEkGMKTorDMZRPUwIHzs+9E5G2JPI9WMFQ=@vger.kernel.org, AJvYcCX6ggM0voHP22MN0Mpip0VbY2VTN3g+0HSJV7z6Zxr1A9HAtuOoJNAqxCTcqHx7R4FTDsljTP/74oA0rmqUn3lxtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+WEg1+lCyDufNYmDK7c2IBA7ketIW1k2VTUzxO2j9aMgJEPU
	D/pdCk+suYkyvgkXjwpmqex/xtL5V1Tl3cIkO7kfUo0PgOGLvFNeqA7Zkfgx+TQxhm3hIvP4wIM
	zVhxFxCQAuxcLX2KiwvDMUpOb3bNCwaa3zA2nNE8=
X-Gm-Gg: ASbGncsqvn3hX6c/AxYBR+hs61g88e6qdTkT26DEvyeQ/3Q/n3NJee4GX3m+0fGolU4
	Zkd8Q+NhJPyy1YJ5huBKxMkR2CLXyiJn2dLl9zbIgejs8E+LBv/z5jKNNIyHz0yDiwwZ3a7rqn2
	d2s7GEM8KlTxk4Wb9D2JN9qpsORJ23qIU=
X-Google-Smtp-Source: AGHT+IE+OMv2HBvBJG4aoJT50PGnOPQvFyT/WhD/QprHbsIm8Cr73du3UbW2p3WsRhgX8+joNh4kjIOmxvL02IKTYZU=
X-Received: by 2002:a05:690c:f0a:b0:70d:ecdd:9bd0 with SMTP id
 00721157ae682-70decdda036mr138687757b3.27.1747928008112; Thu, 22 May 2025
 08:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522142551.1062417-1-namhyung@kernel.org>
In-Reply-To: <20250522142551.1062417-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 22 May 2025 08:33:16 -0700
X-Gm-Features: AX0GCFtUI4DeH14Jj96mverXmQ2fc7ha8kiVT9GJOGezMBuEuFWDVHll6Bv1DMk
Message-ID: <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

$ sudo /tmp/perf/perf test -vv 112
112: perf trace summary:
112: perf trace summary
--- start ---
test child forked, pid 1574993
testing: perf trace -s -- true
testing: perf trace -S -- true
testing: perf trace -s --summary-mode=3Dthread -- true
testing: perf trace -S --summary-mode=3Dtotal -- true
testing: perf trace -as --summary-mode=3Dthread --no-bpf-summary -- true
testing: perf trace -as --summary-mode=3Dtotal --no-bpf-summary -- true
testing: perf trace -as --summary-mode=3Dthread --bpf-summary -- true
testing: perf trace -as --summary-mode=3Dtotal --bpf-summary -- true
testing: perf trace -aS --summary-mode=3Dtotal --bpf-summary -- true
testing: perf trace -as --summary-mode=3Dcgroup --bpf-summary -- true
testing: perf trace -aS --summary-mode=3Dcgroup --bpf-summary -- true
---- end(0) ----
112: perf trace summary                                              : Ok


On Thu, May 22, 2025 at 7:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
>   $ sudo ./perf test -vv 112
>   112: perf trace summary:
>   --- start ---
>   test child forked, pid 1018940
>   testing: perf trace -s -- true
>   testing: perf trace -S -- true
>   testing: perf trace -s --summary-mode=3Dthread -- true
>   testing: perf trace -S --summary-mode=3Dtotal -- true
>   testing: perf trace -as --summary-mode=3Dthread --no-bpf-summary -- tru=
e
>   testing: perf trace -as --summary-mode=3Dtotal --no-bpf-summary -- true
>   testing: perf trace -as --summary-mode=3Dthread --bpf-summary -- true
>   testing: perf trace -as --summary-mode=3Dtotal --bpf-summary -- true
>   testing: perf trace -aS --summary-mode=3Dtotal --bpf-summary -- true
>   testing: perf trace -as --summary-mode=3Dcgroup --bpf-summary -- true
>   testing: perf trace -aS --summary-mode=3Dcgroup --bpf-summary -- true
>   ---- end(0) ----
>   112: perf trace summary                                              : =
Ok
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
