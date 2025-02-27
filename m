Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624726B2D5;
	Thu, 27 Feb 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682239; cv=none; b=r6mHQnqpBZGAFbBWOa6OGZ/h3WSeZH9c6aAS51IGYdIwSmFF68tGCyLUoWlI/2lRco8F7UQyGN5EIBwghZGjA+Ipq0oRtWLC95wzP/+qQnPhGhzV0RX7ZKD53DkYNHM0Ie6e+bgltPINuMv75GXZGN5iNLPjyIjMA1BXLmFOTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682239; c=relaxed/simple;
	bh=oTVSH8ATq89gEN+7dq3E+hPTjcXNSgoWoUNOl9on9bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7I+Z8vTS+1tdp6fjlWl2Qi1x3Q1jKww394agBVIfqoO18ydTr661HUg0mHp2qoF5vrN5EICeB5twQGgM31DsQNvlWcPYse4uTutu3+Psyx3+y7gjLbzdl8LrDe1LgIL9HsQsLKvVzh5f53CXf7oalkL5tj8sYIpbaHGmdcx7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovWiIEZ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovWiIEZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7E8C4CEE7;
	Thu, 27 Feb 2025 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682239;
	bh=oTVSH8ATq89gEN+7dq3E+hPTjcXNSgoWoUNOl9on9bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ovWiIEZ7pLy2cYEmwBy9IfLXnjS6VdikWxELyTrI2QDKLTCdc645ImyP1GuLNhavP
	 765lMHOEFbwWxUChgBN0HB4KOYFfR/xHdJnWc+9rUL5FjaFaik0cZ4IxnUyv0MBiAg
	 yQDBkUkO3WxcDDICEEhqbsBmypRrfd6Vc6stZ8EmpnZBxoTu6FUcrfiAaAwFP/GQpB
	 +2kWeNuPZL1BpMsGVeRTVAi7hlUSBN9Nfpl9MfZYAfJU0o2frDafj8xkW6cQFKuU+s
	 2tsCX55wezvcRolMndfUhqqaERxbOxdnX0Fo4vO6ZudDOwJowP7fVW+fp9BNWq7Vna
	 38vOsLr4rtCtg==
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22356471820so19261275ad.0;
        Thu, 27 Feb 2025 10:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4duq3gHsx8k5Gq0ENiF0+j/7es9M4xyrGgTqWemI37zTg2h1FmbN09Ffc7fqb0lj5CZfHWGJw/wjyTGU=@vger.kernel.org, AJvYcCUvN2VXvnMTdR4dpfRpVj7yM5vWW6R3n+RGemZh2LMGMU+XizRjRwlMZtMwLU9d493POm1oGLdLD7rK+x0h2CcBgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIK0N86Y6+p0OFkImBQcLHDdmFf/03yV+qkmaV/v0qUUWxq1/
	toEATA6wXmlvE2X6iRrLanl4IybgbgAuFKydYkycRBxuMFyKiwmewuaGqt66NB7rztmfsbe2eFq
	yUieEL2HD0rLT68M1i4aCtHTRJi0=
X-Google-Smtp-Source: AGHT+IEcT8glwiOUUxgaZKf43NgGrwojDEdFCyXWOtwjeMycyiAX4X0ZADJ2fsdkYgvLrdiPV4tdOMFvF17XUmJsHdo=
X-Received: by 2002:a17:903:2302:b0:221:2f4:5446 with SMTP id
 d9443c01a7336-22368fba4aemr4634515ad.25.1740682238646; Thu, 27 Feb 2025
 10:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227051718.1176930-1-namhyung@kernel.org>
In-Reply-To: <20250227051718.1176930-1-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 27 Feb 2025 10:50:26 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6wuBjCo9ygCFhyYimEHg5ZNtN7-Yd+gWuMJPTU781vFw@mail.gmail.com>
X-Gm-Features: AQ5f1JqKpEAia7ny_bAWJIbQCaS3pUgO-hy2zjDAKa68TfRDgM_e95e4q7iAJpY
Message-ID: <CAPhsuW6wuBjCo9ygCFhyYimEHg5ZNtN7-Yd+gWuMJPTU781vFw@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Skip BPF sideband event for userspace profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BPF sideband information is tracked using a separate thread and
> evlist.  But it's only useful for profiling kernel and we can skip it
> when users profile their application only in userspace.
>
> It seems it already fails to open the sideband event in that case.
> Let's remove the noise in the verbose output anyway.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

This turns out to be more complicated than I thought. I actually
like v1 better.

Thanks,
Song
