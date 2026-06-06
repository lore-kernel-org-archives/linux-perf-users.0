Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C3155757
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760956; cv=none; b=REQm0YP4mpUg4LlqRQpLzwXHKn2jca7ADer+8ohSCvA7QHgsIAHJtnsysLVhxnnBwsCa2+mJvHsMfiN2Vixw7k+zVjNuR2U1f7OeindYCt5osSzPUHlA2w/KGjs8er1psqBACq/M37JVL9znHTKdHNHmUjZOiUW5WHA4S5Cksko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760956; c=relaxed/simple;
	bh=B2rdiQxLX4R92SHqghdh+/SnHGS8LepdGrGU28+CGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYNS/vMTqQeWFE0QGZTIgrNXBZrWWfvCLgrTHPQsG54onYZDE0yEV2To591f9ZUOIDl/OqQgysG0lo14c0BO8GT0GFAYJi/NnUTvmiHHD26xxQmHlEL1Ud3qk+XorZvZEirMkNai3RUyozQDBRvfP4DKsQOHasCCbi9Bl2vY5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKlpI6Ir; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKlpI6Ir"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43f5e285111so1983548fac.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780760954; x=1781365754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrZs/mvHpYoWYQYUFypsNHCO/DU7O81Y2IRm2PY3UsE=;
        b=KKlpI6IruZRRM1W4Muiyrirdl39BgLPRUYrpph2Wz9Igmlz9o3sMKr8a7crJiL2QM3
         MIruYgwMOng1TJmav8veTZVkEA+HfTjo966FY+XHnZC569pKQxjtixdCBI51m77brXBn
         NhhCzqwt3wH3/j5P1ktNGmwq1tmaIOFaBq6b91dWbrTxXbmfDWyNXG3R9jg6ZHhHcI39
         LoRCuu0QmnabmHJCORIR2q0PL7sBEoJVdqxvoOzhKen4jukmBUg8LjPIILSX8PRqeBBl
         EFYJ5e1AE9fr/zVsoXWwfPOMtZpkP4TWyoreidLzH+EIT2r3dyDrTkab1vkTjUP0y9t4
         ECfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760954; x=1781365754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrZs/mvHpYoWYQYUFypsNHCO/DU7O81Y2IRm2PY3UsE=;
        b=IlAxV2YwmvlVtNTBccJs0nqOaoZxFM87dQDYd6gW7IjBU/YO6Eg+RGmFQLqclwHJ+5
         OtnBeHRfVlB9HzR/9Hp02rHuL7o5fgEL0eR98HmOznS3m1NcXXxbiiHoWyrqkv/uR+kQ
         9tm2lg4UmM0pXHktGR+vyHNHL04Q74eOLZTEQAjKJAAKH9kNDOY/sqIehnMY+txSGmOg
         te6iKgTOUucNJUkMqk61sGETm78y4tjFwy8y5qERVy+6dXUK6nAmDOuP4wfg7EpiCfZe
         74WOdY0DvHCyl68tqyYh+QjpKlw0v/dyhIgZ88m8TXi+udxHEPsJjKyLnI0CJwJxPgua
         BjJg==
X-Forwarded-Encrypted: i=1; AFNElJ/FX4tP+74qrVEDivT383VpM2Ka2t2b6KlseobkG4Pqv9zBoN1iFjoHUxB0ZnBDG4aZv8yadkgqsTj5vNTWDTfK@vger.kernel.org
X-Gm-Message-State: AOJu0YwswT5vtIAvoywg6w+rdeyqkQhrclOk9U5KLoWmkFlc1BLnl81W
	F0rKYvtCaBBpBINXNWNpTlnxX0HeZFSVFbYVAvL/5lm7EsjJuKWSpdBd
X-Gm-Gg: Acq92OFmJWYWGWSFYSZaqfqaaBE8Hw01BgGbNcj0FVfpnxAcmBgAnb4+djuIZsUUMzQ
	MbUeKd/x+IGjwe3L2T+8byRh57RjYTCf91s6auHNEVM+nNj6x4oEsacX9kaeFESItDAOYVy8pE+
	8M5fsanRRFQIzwDkOiaxkWvBmyOy8UXpeDNFgTB8Vulc1Bnlt6VRl7ZRCDLop/wQIDNco+ZNMoY
	QmJnNE+7H9FYp2uVoU5YFsugsi1pMcMuFSrIctHlAboBQ+cXGIgP4ZEBt3z7KpG3lmZP1nirP/I
	YkEgw0GwGwjbBq8ee8NnuQkaTl5HZfRikhNb9K7smwPGrSn/c6UA1B3QB5qTgHPEAgfR8ga9o8h
	XXdtQT3tat7Krco8IU1E2a4XwRm1hhFISA0X9rvcnvfNkb0glw6vWn6kyjhfi0cI6oEMdmyqray
	lN0vcGtaQszR0CcEFNIhOWc43Xf7DYKDeVEvlBSmZ3opQyrURdjCMZVM4sQSWOkyGdemrl/TyJk
	JTI0zTDlY1bVsltIRy7iSIr0+H2
X-Received: by 2002:a05:6870:453:b0:439:c2da:7dd2 with SMTP id 586e51a60fabf-4413d9373eemr4714038fac.31.1780760953807;
        Sat, 06 Jun 2026 08:49:13 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:856a:da39:d9b3:fb8f? ([2601:282:1e02:1040:856a:da39:d9b3:fb8f])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-440d8297395sm10158925fac.11.2026.06.06.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 08:49:13 -0700 (PDT)
Message-ID: <8710d3bd-fa87-46c3-be2f-a798f096f547@gmail.com>
Date: Sat, 6 Jun 2026 09:49:12 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] perf sched: Use thread__put() in free_idle_threads()
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
 <20260605233837.1773732-9-acme@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260605233837.1773732-9-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/26 5:38 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> free_idle_threads() calls thread__delete() directly instead of
> thread__put(), bypassing the reference counting lifecycle.  Under
> REFCNT_CHECKING builds, this leaks the pointer handle since
> thread__delete() frees the object without going through the refcount
> wrapper.
> 
> The idle threads are created via thread__new() (refcount=1) in
> get_idle_thread().  Callers get additional references via thread__get()
> which they release with thread__put().  free_idle_threads() drops the
> base reference — thread__put() is the correct call, matching the
> thread__new() acquisition.
> 
> Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


