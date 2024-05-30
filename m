Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161C8C06;
	Thu, 30 May 2024 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717047325; cv=none; b=X381MjtyyJJgErOgT/cTRc6APiZhYhu8krYdhdYUrdz5B9FXjoyWsk+Pd0XqJq+qVVtXOljSMMtzUSIeAuG9kKuDwu43NcHm2kXO+fbrH025NyZwgR/GeVHH27GLUd7cHE9s+o05UkQTfr56ZkKDIPWntloQJRE7a3EpIv7xyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717047325; c=relaxed/simple;
	bh=0CsSKfEsPjwBWmUdBY02Yt/YHwAyF+hHRKlg/jxONgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8J3ZtZu2CGQtXu6DY3PqmSOmoVkh2Y2OKhCBZKsYD9Cl6Mlgvn7hU3RlhS0LCty/Eyi9lkXEZitZDLS0oiC9pD6X3NKcVc84p8GZ+1G0NJz5Mf5jLtZ289CKCYDd8qVmTrzZVIjcf3UycM+deKfEeN+qd43BOY6cpyf3MUOdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2bdb61c5fdbso377064a91.2;
        Wed, 29 May 2024 22:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717047324; x=1717652124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xejpgpEtLzwv9hcH2rJtXiBs10TLFrUh7R8Ixh2PMdY=;
        b=hKVtGUUXxzkNHd6Mi+Fq4zhSN4vVGgpr6z7qjMusFjM/+RVwFTfXBQrNB2Yw3O7JkN
         DKDrhrmgBu5+sy+3U1dheNIAOATzt9zwikRV+cDOho6tWXOZW60WV2WoFmLIIDLk88BK
         4jOg5LV/1OXNnVK0P1IiggPXSFnH0QrmQIwNXpw5hWN7oAeSSh7bQC6x+L6ZwnBpYwA/
         NfyZjGKU6EYtyWq36mZKKOt+6DEmtHHtlMHMonwMyLfbw4ZXJ9i2azo6qd4jXeJGlW0d
         WuoyEm2UEcPc9NFqtL7QvoC6EkzePb1wlcXBFkxUVnob+HSk1yFrMp79G2uHUKJY0WYj
         ZrjA==
X-Forwarded-Encrypted: i=1; AJvYcCVcUu8yi3PawNUyALrHMKBf454iybrWDjCIXZ5JPkOA8zHN+zmw3AIkcAx67iMXdVbFI3aWjMvMRwAB432M2qPhapqa6TUIr6Pzr19e4oOddzKDwqEO3ILjqAnFGXNwjyfLrpnuKn8Rdj95BIsFsg==
X-Gm-Message-State: AOJu0YwaMEWUdI9x/TfIdVxBS6sEk81/6fwEb3QrQ2ZZt6yIIJiE2o2C
	jmT29oH61eYVIgcMvVRefy4Xrc1+7f6+DhCIoaJOPnruNKJFM4y0B+NC5vnWMiGT42dBAjvrxHt
	xHWGTQsY7dVIlt2rr9cwyhYWBuMA=
X-Google-Smtp-Source: AGHT+IHJ61RW9EgO0VUalcxM48ZvgUKyWi8RX4+RyScW4gsiljz+kCURsIgJxPTLt0WelyX94RNFpY9alTGkYF6s5IQ=
X-Received: by 2002:a17:90b:364e:b0:2c0:f62:7b88 with SMTP id
 98e67ed59e1d1-2c1abc3c58fmr1123757a91.25.1717047323480; Wed, 29 May 2024
 22:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1> <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1> <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
In-Reply-To: <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 May 2024 22:35:12 -0700
Message-ID: <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:25=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> We can fix the arm_dsu bug by renaming cycles there. If that's too
> hard to land, clearing up ambiguity by adding a PMU name has always
> been the way to do this. My preference for v6.10 is revert the revert,
> then add either a rename of the arm_dsu event and/or the change here.
>
> We can make perf record tolerant and ignore opening events on PMUs
> that don't support sampling, but I think it is too big a thing to do
> for v6.10.

How about adding a flag to parse_event_option_args so that we
can check if it's for sampling events.  And then we might skip
uncore PMUs easily (assuming arm_dsu PMU is uncore).

It might not be a perfect solution but it could be a simple one.
Ideally I think it'd be nice if the kernel exports more information
about the PMUs like sampling and exclude capabilities.

Thanks,
Namhyung
