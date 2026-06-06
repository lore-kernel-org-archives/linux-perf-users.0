Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CD3AF668
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760794; cv=none; b=OdzKrFlkkx3qIBM4RRb5/ZmtbYSmsmzCfRK9bZsPlj4eFZfaKp0xnyKQpkHxHpStM1kQjWAlD05wUNY6/9tvuYZzu9i79IYEAUFNYCO7TmPgzjzeCZ8I6tHcDd2mYMFMDM4X3GTIXPbLo2qMaTr6ULNqyGCQ2lApprj8yvr91Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760794; c=relaxed/simple;
	bh=g4D62Y3YmQgZtXsPJzaVerVgiwnzGUHW1KYbSQ+6TVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSZONMvoi/87BOEbSOJSpTHTIL6iAblxWCZ38VPvuzTe8fxY/1wxDFThTDnhrM9gxVc6NKqDtCkWZSHgUVLy0bsJA0+N2ILynq8Vz/c0orc7Ic+r2NW7O3pMIF9gALVZHCa6jZIkqtWjO9y+Dng0+hpDKy1NRw/6JQwSOrgNkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQzaVOJO; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQzaVOJO"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43d3454f643so1176323fac.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780760792; x=1781365592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyCKNs9ex2RvarMOfyRVYoKfxJfS5rsby9PSMWADADw=;
        b=UQzaVOJO3CE4FZqomJVgz6opyvoEpMq1P1HAGkTUb1AgHQDxpVtthswlo6C2vkXCOc
         k74PzqZ11f3QVNkV3/8dxaI+28GpIkuS6bZ15r+EM+sTvtatowE+d64lct9SHw/DNUhw
         p4q+lbltMtQtmgvdqMsmR6yGL62GxPDtrNrW82YKrlIo2NerLAgn6otCtCfYy0THqMMV
         cgpRtbrSgJe1bSYwA6LbxVnScrfggHhnttOSCt92ttrW8lkq+/sqKw8Osn0d8tG9HeB/
         7joEXDQqcElXA58vp9tpMMMagRuzouMLMeOz199sfNkYZstGqTYOmAskQaT6aHddrTy9
         ecOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760792; x=1781365592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyCKNs9ex2RvarMOfyRVYoKfxJfS5rsby9PSMWADADw=;
        b=U4Vvd1gKCSZq/nGvB6JASvxzXLzfUsutCWZC+/aM2LerBudlIuWVkx8JIYTWIERZfW
         zI1k+8bh40PlXQrPZe2EPjH8d/+BCKSwEV67egCHzE5YqpOVgIEBzuuhhHzTG5zyz4LQ
         HUE0JB+rbmdtyWHvg9N4H7AEEJZvKbRLxl7iiX0ybnspq2Xasqpp6Z6s8K7UYLKLvmXz
         nqIAJVZw3JPOPrW4N7G64jFpE1QuLXd0G2iHCEWSiK5iq5nHsSvyD7b7ri1Bg2ggSVg/
         TFkdlpRIeBeReEetZGGS5rEF5YwRXkSuqNkVz7h8FQC10Ok13Cg6jDwQQwYvC4BlG2Nd
         huGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SsqEwMIvuL1nRL0DTEvvm5ophuKmiRialFgCXaIH88BT4+ADeYcc6OjS5V3D+dwP5gi6poUzCweGcTgfWtcZm@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrLdEwi4/tmgLq7ZfUIpwLCcDJelCrZ/ZctsDjzseupoLxyKc
	6VK1YPiRf2AoeeV1DmTcJ0uT3OVgDiH/FtJ6RmfhFE+F30KIGQPRD7x0
X-Gm-Gg: Acq92OGYPDuI+CAnX0Xz929FI8jauV226z+TgG1Bh1l5st4aZpoWCNjf49aT1Aog6mt
	9gcNOgGtVZou5f9HHt3WbrWmKtyHR3TypqMxHcQrIOtOZB0nlpDZUVpKbEvcnUFsNPNZwqIdLz1
	dscoVOm4FCiURO2l0g6hAvtkEoALR1Ti3VGzb31fbJSXuAFWvLUqqCiTX1/iIZs5eW29+yNi34l
	JGYY8bNgbK2zJ372EpOolJhTX9ZpTqR7SLSKDgUmiCt+qnX0LunW0pzM1ruX8pBIAbiV0c1nTDi
	lvgj4pw9lrQ0yW3y4lkTRk9BFcm/vt0697Bkjbw9nOxm4Yhn4k2NyUW87U6sQBKH927+jsGE2gs
	mRUAOX9S1FR4IyPqowsi1eySKbSn2P8JcMkHHwlEQS1DFjEzP+Y3gw0IOxf16imMBIWyABN2ZGn
	SZzl2nrtjXHU2zdh8CxkbcRyT8fZ9TwYn/pFfQUpEYa3lfCJX3ZYCSS9jMa3iY/pimx3lOszb9W
	2kavoqSyuVUHFVs9fam4J4Y0WCm
X-Received: by 2002:a05:6870:6710:b0:439:ec11:8c9c with SMTP id 586e51a60fabf-4413d99a42cmr4732906fac.31.1780760792066;
        Sat, 06 Jun 2026 08:46:32 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:856a:da39:d9b3:fb8f? ([2601:282:1e02:1040:856a:da39:d9b3:fb8f])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-440d8297395sm10158925fac.11.2026.06.06.08.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 08:46:31 -0700 (PDT)
Message-ID: <dc8da8b6-fca4-4e6a-ba42-15a68cf7d64d@gmail.com>
Date: Sat, 6 Jun 2026 09:46:29 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] perf sched: Clean up idle_threads entry on init
 failure
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, sashiko-bot <sashiko-bot@kernel.org>,
 "Claude Opus 4.6" <noreply@anthropic.com>
References: <20260605233837.1773732-1-acme@kernel.org>
 <20260605233837.1773732-6-acme@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260605233837.1773732-6-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 5:38 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> get_idle_thread() allocates a thread via thread__new() and stores it in
> idle_threads[cpu], then calls init_idle_thread() to set up the private
> data.  If init_idle_thread() fails (e.g. OOM for the idle_thread_runtime
> struct), the function returns NULL but leaves the partially initialized
> thread in idle_threads[cpu].
> 
> On subsequent calls for the same CPU, get_idle_thread() finds a non-NULL
> idle_threads[cpu], skips allocation, and returns thread__get() on a
> thread that has no priv data.  Callers then get a thread whose
> thread__priv() returns NULL, leading to unexpected behavior.
> 
> Release the thread and reset the slot to NULL on init failure so the
> entry doesn't persist in a corrupted state.
> 
> Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-sched.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


