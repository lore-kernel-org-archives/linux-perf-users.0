Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BE1DF99C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438028; cv=none; b=S4Vt5pMsIcPZ3y1qcA6Cnkd7XW+yIHl3k6i3LtRIs55t/55Jr5sTtPIbFI3OGj/5kZeurLxctWHel9eADmGurx+tLbLxcXT4z/hS3kG4mB0NeMfKK1Bkb57Fd6OeGYWydZo2kV2Ui1cOJGdttoixZEBXB+L4GU9Ri8yNhZydLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438028; c=relaxed/simple;
	bh=wGpuZ6M76mxssiVzFPguhRDJhH4kxLiycpYO+f7VSAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eSk4mIy3a4IV0aq30VriKuSgFGZGxcDA1MBEQ3qvNKdd6pb1jJHxa+vKVUqisNc7uKCFsvP0+fxesf+HE2BStYSX+nudTk7BGhit9KSpNtod2bRGr/hB563TmCw3wd4Wm7LUtavtl7B450ocjyxl/JAQMTt9nYPz+l4nEk8tnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzpMTRKy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzpMTRKy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681645b7b6so15065ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759438026; x=1760042826; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGpuZ6M76mxssiVzFPguhRDJhH4kxLiycpYO+f7VSAo=;
        b=SzpMTRKyfGX6J8chm6op3vEywBE3i+QypSnAvn9VY4wfQModMa2l9JucAdJtCzUXOl
         st/OZcGp3H3sxG5Rme3nQppuWBr41HawrDW0ToZYMNvtwjF+RgkCSp7LADZkMa7J1/H3
         FHA/eblWYRyoj6knV/q3cKGME15/Hswl884p95rZ/CGkM+ZMGwKqALkE4Q+o86BzGbbM
         5KZr3T4/3nEMYEYwQROmD/fNmpiw1jyMmqVI6ZiygaBKdUyUhtXgM63S6bv5wpXMO92Q
         9tVk9YuvojSHng/PioDA88tmcKQPpH2mmzDiJGgBPuRMov4WlSPG9QbpzjeF/pdx7Q/b
         qmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438026; x=1760042826;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGpuZ6M76mxssiVzFPguhRDJhH4kxLiycpYO+f7VSAo=;
        b=MAzvDCI28d72Y7QoWoi601F16uaVsFOtgxMIEmYcjXMx5ZhGwzS2Pnud75eVC4Tqsk
         /yEkkEwLJz0VaGxfACosn8gvi1V72jH/mCUqJbnciX4u+4wN0EwM1AO0NoQQLwcIU2Qd
         G9qpnFJeHZGQ5Zk8XhZI6e3tMCCcVmozlkTeUU1XOW5JniaVKHxngtEZRIYW5uzpSt3Y
         b3Teya86Cgdgp5RiKgIPHIvjSBLKklUD2ZF9rQFCzO3hk5QSjnafNxWuvhKbSDMGML+L
         DDpm78z5JU+/8Eoc8FTKUl/KCOIMLypQPjH6tG7fm0Uimg3qonLWUxieeRb1Fx98oFFT
         3IVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU47y+PzjEyeKsK6u1NTxSrZDMqIETWKLE/5XhJmf2m8N1/LuLczEUbK23remj+sD9vd7ZkLrprp1f9R84suVp@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBqXARMgs2nb3herFvdvvu12K+K1XYXlLM18js6aEZ9gLp0ai
	eSf55/cSww58rZNrsPB2rvx5v8ufpypNmw7kSoYJBwDdH8SrUBv6gvFLVzv3XKhN+aRi/787/0i
	i9zrRyCY9iwtQbO41ZHYpKnC4DRZbTUFxvILrxhkZ
X-Gm-Gg: ASbGncvQWDRrtAbxduTIFFuWo1lvN6X5dKY8HwoqsABHSYcjxV+iSeBgTEJODY/siN7
	LB9YB4Wk5tPu8istliFHWSTjedyDDGE0W+7/YVM6vYjp+BsMAADXMT4F5tbfto2lbdaZQYbrNZ7
	AwWgYRf+NsnDfcggHeZg5hNRYISSiTE0uZaGcB/336Gz4JYpaaOVLsXBT+pXDH36o6tWzWmZ4pX
	mChSNzT/TRANTX3u7sOtcEGaucVW8YhGgLd36VXo0+g+A18g9NowCw2XcKcVPuE3Xp5BsLocZlA
	1Mw=
X-Google-Smtp-Source: AGHT+IGeT/Wv4F/Aj2sMPivpvB6xqpoM5WwcESEP9AUk2vBvZmhz0lOz8ASNJ4/8/WdJIostUr9SbQ5MlLrOBK0r7gE=
X-Received: by 2002:a17:903:17cc:b0:240:6076:20cd with SMTP id
 d9443c01a7336-28e9b6819dfmr277485ad.15.1759438026136; Thu, 02 Oct 2025
 13:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002200604.1792141-1-irogers@google.com> <20251002200604.1792141-2-irogers@google.com>
In-Reply-To: <20251002200604.1792141-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 13:46:54 -0700
X-Gm-Features: AS18NWAkMYJeep1oFyAislGqnoiAUDkYmOZdGhymPKgmBEyVCgnWt3LjibdjhnI
Message-ID: <CAP-5=fWvj-cAzh9R=8EjjUaaLGe9+XW5x_f4Pka6EdAQMU1X4A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf stat: Refactor retry/skip/fatal error handling
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:06=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> For the sake of Intel topdown events commit 9eac5612da1c ("perf stat:
> Don't skip failing group events") changed perf stat error handling
> making it so that more errors were fatal and didn't report "<not
> supported>" events. The change outside of topdown events was
> unintentional.
>
> The notion of "fatal" error handling was introduced in commit
> e0e6a6ca3ac2 ("perf stat: Factor out open error handling") and refined
> in commits like commit cb5ef60067c1 ("perf stat: Error out unsupported
> group leader immediately) to be an approach for avoiding later
> assertion failures in the code base. This change fixes those issues
> and removes the notion of a fatal error on an event. If all events
> fail to open then a fatal error occurs with the previous fatal error
> message. This seems to best match the notion of supported events and
> allowing some errors not to stop perf stat, while allowing the truly
> fatal no event case to terminate the tool early.
>
> The evsel->errored flag is only used in the stat code but always just
> meaning !evsel->supported although there is a comment about it being
> sticky. Force all evsels to be supported in evsel__init and then clear
> this when evsel__open fails. When an event is tried the supported is
> set to true again. This simplifies the notion of whether an evsel is
> broken.
>
> In the get_group_fd code, fail to get a group fd when the evsel isn't
> supported. If the leader isn't supported then it is also expected that
> there is no group_fd as the leader will have been skipped. Therefore
> change the BUG_ON test to be on supported rather than skippable. This
> corrects the assertion errors that were the reason for the previous
> fatal error handling.
>
> Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> An earlier version of this fix exists in:
> https://lore.kernel.org/lkml/20250923223312.238185-2-irogers@google.com/
> This version is more thorough and tries to make the overall code base
> more consistent.

Looks like this broke some test expectations, will fix up in v2.

Thanks,
Ian
