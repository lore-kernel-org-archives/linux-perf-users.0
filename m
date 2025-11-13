Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FE363C5F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053074; cv=none; b=s3waLmAdDKDzYmDETSJFo0adxIx9EeWcCCFG2hvUHuI8aboFggOy4jyf0gVZiTRuQK7K4JuagRXKQrNk9BnonLWkAef5qMRWrVnr9q34+U9CYhMuEQxJ152OpZxh3Ihz04rYQYfAuJkrmfh+kxmhec669xhpAeMKA8xQUfUhKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053074; c=relaxed/simple;
	bh=jhroVY/HWo/R4pzbpVqafKrGYgd85FkipZ8zyk+lGCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/3un1n/W82OeA8KZaN7wqM4DcqBm63GD66RIqJwfC6nC9Berm+ssm4qLUJDMepoK4vkHHkEqW1ypRHuD4DoMyubCQw59J3eqOG7rvOu/vuqriY5vtYvlY6Atfw/1bp+hxG7bxu+8W6VqRB13fh/DliKKERIMV+/CbT5jwmUBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGSoGuvz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGSoGuvz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2980343d9d1so208955ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763053072; x=1763657872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLxkFc80eg4XlOBCdafQkFgvYgVVVTnJl4OY+3IwY9I=;
        b=SGSoGuvzW5zrTMTrEI7n9r6bgiOz9dGiJALl/9H4gmrwhfqe1uLGD3H+GSq7MQx5km
         JCREYWbHR0g0hojNvRhChAeu9F2iXhka2k0MoGkNaIdQHfnAC4b47p7RujbY3GkgNSqs
         nfbQWvp8ZPq/6Ce7+4Pxz07L9jUhdnFYyeceRNamHg22/gS0hvyUWC5i7EFFW8rM+MDT
         qP78oRH8yea98kXQttD410atjOrzheEzS5H20a1KY6vHzaLtZQtxPQ5ukQavf+v5JO9e
         RyRm8G44qVSOSIVsbT5YEYQ4yTAvU3Lljl6iXhvzjLuBckFozWQI4jKrmvx2JGnlPo/o
         mCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053072; x=1763657872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLxkFc80eg4XlOBCdafQkFgvYgVVVTnJl4OY+3IwY9I=;
        b=tzLJkW/3Ob4ZDaVNP//eWqcAf2nlJ8lgSAzlfB9dS40v445hxDw27f4/7LM93orFx3
         3j6DFf8kjc0E71tat/saNXbUIY5HfsLe7Fht5FhEbNwB+iauMNutWkLnt3fOMKU2QzjH
         JcRKzy2jImTCIjvWZAw/dipgTVBQA5WGBrYNCLAqYRfxRP3pB2AfYMoLj+k4ETQc/ZbW
         gA95BNlXE+4srXJoyZwNW9WPNUSpxPxz16jfu/nBPi70kpdN9FyH955OLPcXrclB2TAn
         hThyoCbP5Q4ZbjgO5m3neD9LPDknlUGeTmiis18gsDPqJ/uWF4D1qZ5hP+KSLBBZ4idm
         LSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWPTJDOUO6Pu5Nmn1wqTF1Yqh4yxnM90nXrEg1lJMrQKgNon4gE2mBz/pehVvNfqrjstO0VvjH3iv+86ZQHN0fn@vger.kernel.org
X-Gm-Message-State: AOJu0YyOK/4asRMCwlPY4KTArUcVYvgdRIKtM1wCKGiOzFldUCzzbU5/
	5nxgZ7o41TYNzeC7p4dK6WrsVL7GnqUJG18KTvsQR3/RCWASsjVinwS8BvTXBDCeuhDSZAAZUgc
	ZLYoJTij3KcTVX5pucsBPSTRH/FiRvo/+Ll7uPe3D
X-Gm-Gg: ASbGncu/yLYX67bUHlFqG4mEaB0Z+t2/s1eHHo73iNsQk1VBkA4ey2ctVykro24j+mL
	T5J0TNYsD3Ry2gsLtACmS3bZ7zOrDNPwbwq2JXdPTYTPnnnyD3PiBgH22ih4+lO17v+ZWlAzUOl
	Vnx6uku3oCCHv7TJpOcLSioj49lOZuWt93ZuNS1l5ikZcgZ9c8teUy405GiZ9NYItBD5SiPBqWE
	/RKd0rC+t93OWS610/YWcifNZdimDYVOe0asat45DRiBVT4OG4IFU+oTs/m/9GxzoEr6OVqxRwJ
	XISRZmnXa/U5F4hN+kA3zgRb2Q==
X-Google-Smtp-Source: AGHT+IFGM2UC9cv0Rb69qLMLBN2AHbSi8XjPf1Y8jV3cTVxKSlzeyDyFNonfq8lFV0Khqb3WDzq3f3llEYINITYq5HM=
X-Received: by 2002:a17:902:cec4:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-2985c444baamr4595265ad.15.1763053071802; Thu, 13 Nov 2025
 08:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113160124.2695-1-ravi.bangoria@amd.com>
In-Reply-To: <20251113160124.2695-1-ravi.bangoria@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Nov 2025 08:57:40 -0800
X-Gm-Features: AWmQ_bnYR4cOVJLHr78WOaem9eSbY6OuN58PYrF1LrkuBmsPOHOG067Ywkfi0go
Message-ID: <CAP-5=fVNZW5EvpX+MCQOU1WJ0BeyDudk+nMp8-cAH6CfF9cE+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf lock contention: Assorted fixes
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Tycho Andersen <tycho@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:03=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> o Patch 1 resolves a segmentation fault in both "perf lock report"
>   and "perf lock contention".
> o Patch 2 repairs the perf-lock unit test.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> Ravi Bangoria (2):
>   perf lock: Fix segfault due to missing kernel map
>   perf test: Fix lock contention test
>
>  tools/perf/builtin-lock.c                 |  2 ++
>  tools/perf/tests/shell/lock_contention.sh | 14 +++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> --
> 2.51.0
>
