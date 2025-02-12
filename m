Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C0200119
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390457; cv=none; b=o+o5W8W6BUed5VfpqgPYxmQfsGMVton9D6drnGx1o/mXtdJjKiE6ZZOop+eyLwWPTygOIge4tUpa5JXUNwArAzqlc5U5u0FBjGGmYKtWVwnCQuW4NA7cgF6YwTOtjrks/SXhqbAtm799I1rikyX3MSPia1DUEIQEgvL5mSQOtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390457; c=relaxed/simple;
	bh=0pG+JRaVXBqhNYTI0BMGYl5wF4aFO16HNm2CNHXCsRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA0NK9s2ChHH6W2ifwxhZi+A0ewfp1b/rSK7pNKfwr+Nm4/7n40alTbK9gmt8Ny7+RmaI4sRwiOcfukhc+XZeZcJ5eIcJ7g56anNCNitDfx6bUbkF4nuiV9BN1WL6Ke1qhwq10WU+Cjzp2eN0gEwYWZ2pZMS3AdUslX/1hgCmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR+uY2im; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR+uY2im"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so33155ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739390454; x=1739995254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pG+JRaVXBqhNYTI0BMGYl5wF4aFO16HNm2CNHXCsRE=;
        b=kR+uY2im3vikgcdH6pNtrgT5uXPdBLXooyXAIYizJeZg9n92y4SdW9NeOiHeorD06C
         uWsc/9eWaHlPI+j3FzhnKB5fnUL1TJKTmm3La+0XXAMt4KG9MWUn3ZL4Dquu0xLFE2fM
         LOw0z07EV3HI2Brd0hS5qO1+qhLKrJK4FCpHHv/8wtiRK/UdTuLPwey6K85qDDM4m4J/
         0uSSDQSM2knyrXxAzXIbkv+9M2FxI0TUecNLZ5pvQQbwuOr16GxrxqIYoPdaNhz+4w3c
         xwlwugo41Sw2UxYJyZaQtsuHBxjY1mDXfqrEqLGJfcStdSMwgoAqAbCFyy+OVIHoCtNQ
         xBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739390454; x=1739995254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pG+JRaVXBqhNYTI0BMGYl5wF4aFO16HNm2CNHXCsRE=;
        b=wazK0OuJjBQxgkArFwgHjzarIoSQcTUqTh+fhniZRxJIK5NKVsgaqsBvZf2RqBKgOx
         N36A2BqDJX7B0g2/d4rwuAM5sHTPzUMSOaVoz357OZn78xwUG9Pk20scbN9wnBytbTBU
         ZzBO/KHhNQ52NIUz2jTZrI38eh5WUtrPq/45BgrRNhaCUZOGvSyTxwXCANR1fjUzYpbO
         ka22Y+XOyefPcjm4w1/GsJEuGaAxYt57Dtck3YtO0PKFJS8aY00sLLBvkB5fv8GbW1In
         YwX2duZrPayc+fGkx3PULtlX1WadI2q8f+v7uWaeOtjgZFhnqdtCXTzm20jzHu2ltSOZ
         tqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyLSsM/Z4EKenk8uW/LsaQ55Gjy3yOF0pjMSpWHP8LL0Um4ShwzgMhTYZc4irvEG3Xy9n83xdppETzDYcJtjWs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/aPuIb8vGo6afgRFVTAJwOfGfaP78Jo28hKp0wXj5TtefUfu
	WIn2ZqxDd9GRfzRi2UDQq9rPYZbAAPJukOOB27s27WeY50YCKzJLNVFnOq+CoORSDpwOrm4vJkL
	GqAjzDZ5asig9te6QYj4X+Ls4XYMHWgpZ2lS3
X-Gm-Gg: ASbGnctXc4HgIzBnX0yVXglob7U5Tjwm4nG8LN9PKxuwtKqp2WdV9HD3pHQS9N5TuxL
	UQwhIIPyN9h0miJBk0/Z8sjjZOfdi0hKUF7uqISLFzMv6Z53YcR5EUqx7lxderew2BNfG/uSlk2
	ECzCoPYkmO89Tg5n+lQtYCE7FZ
X-Google-Smtp-Source: AGHT+IEB2+AmkIaAIOFeTQ3Nx+SbWIWSCka7nrurGRcxVhzIsTGvQ9larnnNye37zvZb1s5tc7xUC5PpYKHHlDl1Gic=
X-Received: by 2002:a05:6e02:1d06:b0:3a7:a468:69e0 with SMTP id
 e9e14a558f8ab-3d18cd73592mr371945ab.1.1739390454354; Wed, 12 Feb 2025
 12:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com> <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com> <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com> <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com>
In-Reply-To: <Z6zslLa8XM1ubwXj@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 12:00:42 -0800
X-Gm-Features: AWEUYZkPHlCKO0ya0iQ7pvFOSdQsLxZFLpDtuZpM2UOOjOUU8vOMF1oHXBvfyp8
Message-ID: <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> It's not completely broken and works sometimes.

No this is the definition of completely broken. If it only works
sometimes then you can't use it, we can't put a test on it, there is
no point in it. Even when it doesn't fail on perf_event_open, does it
work for processes that start after /proc is scanned? No, it is
completely broken.

Thanks,
Ian
