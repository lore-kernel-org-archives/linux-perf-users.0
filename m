Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB727BF84
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351450; cv=none; b=XOfnQIaj6/pZ1jjCMVWui2fIGlL579GItBTyo5jolsYYP24pHRCj2bX26LGpzzI6O7Qr+W16NgoZiwX9DjWFVgiS+jwIOMRyXn231PiQ2giQGByzyPC40kDVhkpza9PK/RrwhCMg22LKBBWfGBbb1IJyZV8iLEeMqFdmH3/aE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351450; c=relaxed/simple;
	bh=JVOVV/NFW0b9ijSbARRCTYzLXP3YfPnnKqy5Ubs5avQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/2WJpxgl7DEa1/C50R1owPaLQzYZpiEwV2NrYJ0TbpwHmrfj3MvLvKZ0qYlp0HZnOWZJyo++mWDyzE0c9PJK4LKLxuVGCShYicUDoD/gZDZyU8JKMHCx1ZD0JHr+kTeitH/m55UH2FWEeLYsQUHgmgMZ5lK0QEtLtR5q14tyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gY5DTCA8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gY5DTCA8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d67abd215so57735ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Oct 2025 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759351448; x=1759956248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+KwBxDA/rZ/Tq2hlD+ZR4WdzOTowWhZ+LF5/8jAnaU=;
        b=gY5DTCA8wXjYuhL4hN+cvk5zM/sFPbOBIzF7DQrou2D/Aw/OuwGxybf9MhC/ErK2fE
         Km2vDwkU0ksQIzN4HLS5TB+gENmT/e4PoD2J2D7gqpwVt7gE1rD/adSLprZ8qtd2U/uG
         PdneaaLh+G6x7WE3DxiZ2FWwytCPRdKNy4zGtSqZE2OajEJf2flb602dkXFebxYE6qX+
         zDAQd4SU8EhkZUiRi7cmU/h0iAzMOi7TzKEX+DdIuDvqqKMzmy1xfmDKJceq6pv3sXP0
         4TyzpOgktcENEi6CM3QJOzrpwnuds/nVoMSyp63yeLINSPSX1Qd9mujO0ZUa+QxUueE7
         Caaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759351448; x=1759956248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+KwBxDA/rZ/Tq2hlD+ZR4WdzOTowWhZ+LF5/8jAnaU=;
        b=tHcbI4e9T2DD2klAP2y5Mf7oWbQKBuhFJEhr8LWb9dhOQtnLHkaBIMwGwfHngHTUMp
         VMc/28oXWu0sZhyLsSpiZbRhTwgPTCsJco5EmNccGfW571xHTrCep4nLBK5OkBqPsxgo
         9QWoCBsFQpaRWe8vUOjM2aRycUHZFE81Mogd043KvQkqlllSoh+x2+f2/+eTs7CX0sLO
         y38a7eVicV8RCGS6So2th/54inREnln46a8TUjDluuExahYT7Jdg+RDLicQRoOZmDytV
         Kjt93Xrj9YQhpRbet17sMeSGljAkKorFPXUYgEHRKKPS+LcjClWXs71Grvif4kskLXpA
         z6bg==
X-Forwarded-Encrypted: i=1; AJvYcCUaJK9udHyN8UVnidlt8v7wGnPAaSikvxdmpcLHonnfyAucgMqXWwUDRBQVBKS1osEVoJY+wkbHc0NOIlhHZWEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WY/3EXxaQocwhn8KPADf+reEl5Ia+dnJXyjS/qV33lf+rzQy
	c0TSiBUiV/+WrQMbv4Hbz92jqNJRKCxfK2WQzNTBHqOP/wjUdVr6zD+eu1UM5mc6nOtT3LKki0e
	4tJqyeS3vBXMH2Sk5WijXJGbEkhePz9oSTyYVgzj0
X-Gm-Gg: ASbGncu3j2whR24kGv5VJn8d8VnJlWMJtiA7jwK6h4qqwazhhK/9IbzKhssdoWuOEdo
	4F3EcwssgfmSZ7M+SO46t1o/JtNFYnktTlE6NrQqW7alSop0Se8IKqH4gKyoDLgKICom5IhPTk4
	da8iyYQ46Ogc8A7QXNw3Eoho+li/LjDdlxuQa9o4EYX3wU64+isUXAEsEJpA6z7t0OewQ2T865V
	BBhfsQcEcLAUkreDluwws8u/Yi1wrZWQ44th9PKrsPGDkWqhU+Jt0jYx1qajD/FponAT6CmIreS
	ag==
X-Google-Smtp-Source: AGHT+IGBbU5TmFHShVElXeDYRO8NszyF2qvvNtpA1SOhvUW9cP0Qf4YRX360GAoGtuZtdJI/dnNzNjx5XUF5QTyKDR8=
X-Received: by 2002:a17:903:2311:b0:261:83d2:9d91 with SMTP id
 d9443c01a7336-28e8ea94067mr219315ad.15.1759351447809; Wed, 01 Oct 2025
 13:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001195047.541745-2-ashelat@redhat.com>
In-Reply-To: <20251001195047.541745-2-ashelat@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Oct 2025 13:43:56 -0700
X-Gm-Features: AS18NWDwbuNRrJl4aNBKUwlXMHG6BNXv4U6YA6dJdwnpyf50epmMhMgQITBw8OM
Message-ID: <CAP-5=fV4nvyvhuxBMPPXTamvgO78GrGPG9BYgkh=Q0asQMKWnQ@mail.gmail.com>
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:52=E2=80=AFPM Anubhav Shelat <ashelat@redhat.com>=
 wrote:
>
> On aarch64 systems, when running the leader sampling test, the cycle
> count on the leader is consistently ~30 cycles less than the cycle count
> on the slave event causing the test to fail. This looks like the result
> of some hardware property of aarch64 processors, so allow for a small
> difference in cycles between the leader and slave events on aarch64
> systems.
>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/tests/shell/record.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index b1ad24fb3b33..dff83d64e970 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -280,7 +280,12 @@ test_leader_sampling() {
>    while IFS=3D read -r line
>    do
>      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"cyc=
les:") print $(i-1)}')
> -    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
> +    # On aarch64 systems the leader event gets stopped ~30 cycles before=
 the slave, so allow some
> +    # difference
> +    if [ "$(uname -m)" =3D "aarch64" ] && (( cycles - prev_cycles < 50 )=
)

If cycles is 0 then this will always pass, should this be checking a range?

Thanks,
Ian

> +    then
> +           valid_counts=3D$(($valid_counts+1))
> +    elif [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
>      then
>        invalid_counts=3D$(($invalid_counts+1))
>      else
> --
> 2.47.3
>
