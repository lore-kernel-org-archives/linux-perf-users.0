Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197F189B80
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270205; cv=none; b=DSSjvw9gu0AQlVANZmSYLxqgKat4LYm062+LCCrCt/H25xxP/XEYOs4R2Fm9HwDyQc3EUyGmWpupm1wEORWADJSbrD294VStfrOURfKS44vS/+57kp6DuT0p7GhlnXzeJ2k5aPss83QKb6NqpqBC1ZeclObdr2eaG3dqRBDbZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270205; c=relaxed/simple;
	bh=xBqiGPj78Xh2ZrNzKzDhEg+ebO6G18eCtPexhzR2Q/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcayQIsUyZW3uj75RksomyOAY8RqPPz7jwy03W3S37U7CLz4JfP+ZTOASfKqPZkwEmxXdiLGUNyk7uEUVlDpqY4Gbda6IbjZq6PzNJwEzR7vfyd80b6hUyqfvxtROSgWtdW2OkT6R9gDXYjh4qLZhKcaD8hUsa4BNI90mfA9jU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tax84Eoi; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tax84Eoi"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so141535ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736270200; x=1736875000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYa5Opg9zN3f1Avn5NOYTz2w51m5Jqi6SEewRPGCleI=;
        b=tax84EoiTPF6s0A7jeeGK/yzBgUCbC4isth1AJltuaRVbUxxI9fSjEssMMbIhoWQOX
         WZl31je5AcSQe2AZI7KrRJbKcfprbfPhdsAGFB1SdbdyI0X++VTa/mpAZAxEJDzauoW/
         2jXaliR/otl9iPS+UOgBNrt3p5IuWR7hzLUk2NTOErBVewurEbi0zG2WS9FAuf4kpUWS
         IPLL0gt/ieXCIRNsLLoX1HHqBVWudwcjx+oZ94tymufKMRJj/TQtmEMayMqJpHoDjzSb
         9QS0h0cgR4pJtYuSlOOwEIyo9Dh7zDQ616v76/+kcJf8hZiz/du56btBfqsbK9Eij6e6
         ZuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270200; x=1736875000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYa5Opg9zN3f1Avn5NOYTz2w51m5Jqi6SEewRPGCleI=;
        b=oumNpyg+Aw1QALPYcSjiNle9el/Y1ptZzZcdl2ucY+eVDyvRF4x1umNAbj103wFvBL
         3pb0/Gfco9QRcvgk8Rnm+R4RwZLqvIKmKayHmMH0Rz7CVQrIsPJ7B2Qneyl/QEzxVUwP
         qRpfDZerhRcz2oTayEV2HiAIu0MxOJljvDgPXZFTizu9GCQSwe6WbonESkmIxambavyp
         wotTuEB7gwLl3YvrEF5Nwor9oQWVybpNZ5pha4oTBCNWIv3E73UzYJQKrKvwJKxlaH1x
         TZ5zDzzz+zcB8WlzJ2va6lvyWZG0NBvRIyAE3zw9blQWtYMnrbhfKLZnDWwIsuR3AiS6
         znuA==
X-Gm-Message-State: AOJu0Yw2sc9s02fqgspPutJsTG1NNTEvS+WqBVhFn90ZrjI8qz0v5Dlb
	kWTvHmsy+d5sJLiA6elTEpQM9Jn+gEG1/JD7Nna4eQ//KKn1kid9rE9KkJWlSRrG8PgVCXqE7EQ
	3KJEbpZNs4agbzCzLE5JHczqysJV2nRD92ZnX
X-Gm-Gg: ASbGncuLyViX2d8TRe+K+gW2+3PgPGdjzwZJN7hQqSGTeJFPchsN2gKIQBiKFXoyFLi
	3vst+M0rTfyWCkVNo9C395WN9kGm7/KyUIfLwsQZrT3hJRUQbHtWTdKJGcQd/gfqL1Z4YQg==
X-Google-Smtp-Source: AGHT+IEYb4udMTphwstNkOgsApCGkV+JSXbCczE1j6dH/LFra/a67KHM1A03GLTA4HVuJeBTE+Pmhpo0RPPgYOn766A=
X-Received: by 2002:a05:6e02:3b0a:b0:3cd:aecb:8503 with SMTP id
 e9e14a558f8ab-3ce33325b75mr3667065ab.3.1736270199900; Tue, 07 Jan 2025
 09:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107165933.292225-1-james.clark@linaro.org>
In-Reply-To: <20250107165933.292225-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 09:16:28 -0800
X-Gm-Features: AbW1kvbfkGrQxu4npcQoyzWKqs25vpc3yF35sUhxk6rKREuT9Z9lDONZ14j6pXU
Message-ID: <CAP-5=fWbXv9egTm5p4RLRL6JU5=tmYjMKZYF0WLx8eJuOn99Aw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Mark remaining probe tests as exclusive
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Michael Petlan <mpetlan@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:00=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Probes are global and other probe tests are already exclusive. These
> two tests can throw warnings when run at the same time so mark them as
> exclusive too:
>
>   $ perf test -vvv 81 79
>
>   79: perftool-testsuite_probe:
>   --- start ---
>   test child forked, pid 46419
>   ../common/init.sh: line 137: /sys/kernel/debug/tracing/uprobe_events: D=
evice or resource busy
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
