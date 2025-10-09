Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D03595C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019431; cv=none; b=eKX4oy096IGyxmlpJGSEFXrDqetPpY8elONpjxqiQpJ03+sXJc4WvwUSXCSgfNn4DTFFGXtEYxa1LHLFPMjiQDVtj97W9VpURBw3AXzIOfwfsXXaUmb6Mc2Zwe+nOXdltbK8+EItpfefhdqTnknPvsOSS4Sn6zzXVDcbktdl6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019431; c=relaxed/simple;
	bh=/CLrhferOI53uFTYqvRaXBO4XQv9zvmyUYHZTPmj2Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLMzTF94dj/gFmM6HtKAIsQfiGPHU34OnJv9ly125crAmS78jJmuO6TVq11TVNd8ZzxVruJSB2FkyUx04JMrZVRPHxJxmmNsd/11USzsscDMKgl8uo+B+ZQ2vMlB/L5zfzuiBwIgXnXXqnqHU2SpmTX1gY0Mjxq5JtrBZdGBHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWAdSFio; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWAdSFio"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781010ff051so746137b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760019428; x=1760624228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAGgXUa7jrEcPUZf+rZoYoMIoxF9gmUgGUWe7xlA3HM=;
        b=XWAdSFio9YBJKOXVpCMiG8E/QKejKmUA8deaBpCvmxUIIP0LgoT76K9SZpTpM1Dbnc
         wdP3eveDXl2yYkdD/NFq6mVEhBp1BKhGSmIKicS9ij2eTLVmvg7SDwo+PJSsrQpAz8yT
         yidlqLK2Jq2l0yH1yMhMYpavUlaxOHn1TAFS9F8RMJEBAIFm7Zx5JpfYnE4VzGQZCJUh
         ImpUz26o9BlY+7w1vc9fze9/Px8EgxiM9kpoPFZW5uqTNMduQxHYAe4eNs8x1lQoeE2H
         PPLsnZzHXhz58nDhrjUNTmUfSTfEciLP1NtwC97UF4/4ETKIZT2m4WdaSY0eWO1fP/v1
         1cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019428; x=1760624228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAGgXUa7jrEcPUZf+rZoYoMIoxF9gmUgGUWe7xlA3HM=;
        b=jX2ATXbzOQo5c8BZ2mTXzpg5locL9hHvF8cg9CRDdkWw2B2sUoDQ8eyR/f/nCyC+dk
         Ld2YPhs6IyKwVUZFwDpRlXPll5RztGvORszfD44/+ffRCd5RWi/VEz52kj24Yj41ihsu
         KsTW+XXjGJ2gU4R5YtSNKGexpswNTVP7CMh8ld4ko/N57Kj6bT9ssoQLfBiiTCPT4jVo
         lO6QZCiU4I4brNLs6RK4Txy4s56zuMPAPDDo7mWS7h9IiPuB7V4Ln0IyuIncmqmt2xnc
         t0vAXiT4MafdWqaUswUPk07Oy/9brv1iMUS+uQrVrwGpyHhDD5dWt6d9uwSfq0ybvY32
         YKFg==
X-Forwarded-Encrypted: i=1; AJvYcCU0V3WRPztth4+oD41XzSVKf4FiFS5DYwAaroCRc2fjUSdWlT8ZOBZG7DKL2lFw8KMECRZFjxIlR0aXyjeHfqcE@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCyTAjY2rcwS6QEa94hEy+GLaO9VRkJk+ZJPYskSiuhU6LGnq
	iMjJeAl3etq+hkiRwk6YZOjh0tqJyKQXQxhymO1bqq2iCJJ3ig4UUYKZl+YAH4zMPHjA1vfy3aE
	x4frgNlAfJKbLJe/ODDXrkKd6EPXzDvge1EjVCxAjzQ==
X-Gm-Gg: ASbGncuKYkWhRvQUpmLEeedxvDLjkKjSwoSRo+Y+k3vahw21lNNHZIQGpQknRKANZld
	iJFLoaXYe3xqrGW0p14HQF4Afiinp8UZXb/O3Yr5JSF+IJRoq53EDJCeTpngVamI/hqKOefMDTb
	29EyoaV5qnA5BU8rU6kHze7ypM0BI42p4GdPPR+a7YdYLjdWBm9ulVFiB5QRrZIkUWUQytvfsGb
	cw28A1pfVVjDE50NzdKVRYmxaSJb8h6ZG+C
X-Google-Smtp-Source: AGHT+IHNiqZkNg6XPeFelUbllPF8ssAC0Q7z3PQ/udjq0kDEms+Yi6CfYpXwtOZXZ025zfvzYmbK8YD8WJrjzye5Z0M=
X-Received: by 2002:a05:6a20:241:b0:32d:a904:8bfe with SMTP id
 adf61e73a8af0-32da9048c2bmr7568674637.52.1760019428498; Thu, 09 Oct 2025
 07:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 9 Oct 2025 15:16:56 +0100
X-Gm-Features: AS18NWBMLxvQq3EALWAjqVKr0csFKifCNSSsQBqJuIAM_-6p8ePV2UoH-Pz_cmo
Message-ID: <CAJ9a7VgxMt7Z22rB4+ndHYe-T-hV77BPwoHU4HFipySM6sXd8A@mail.gmail.com>
Subject: Re: [PATCH] perf sample: Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
	leo.yan@linux.dev, suzuki.poulose@arm.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 10:51, liujing <liujing@cmss.chinamobile.com> wrote:
>
> In the file tools/perf/util/cs-etm.c, queue_nr is of type unsigned
> int and should be printed with %u.
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 30f4bb3e7fa3..d13575285b19 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -777,7 +777,7 @@ static void cs_etm__packet_dump(const char *pkt_string, void *data)
>         char queue_nr[64];
>
>         if (verbose)
> -               snprintf(queue_nr, sizeof(queue_nr), "Qnr:%d; ", etmq->queue_nr);
> +               snprintf(queue_nr, sizeof(queue_nr), "Qnr:%u; ", etmq->queue_nr);
>         else
>                 queue_nr[0] = '\0';
>
> --
> 2.27.0
>
>
>
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
