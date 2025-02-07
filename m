Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4617B502
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947143; cv=none; b=figVdSl87LHitE3MyqvH1beinFPTIxm4lhn9NjR/OrEkH9f3WQld4Kw8jJ27Tuatz8z86UIhQzLxwr/ml50DNXJcR3B/TxZPvjBQisIG/YCNloElGUuqy+48y5gBBb45G6fOyQnBerziF1Og3mkn0eK/j9jQ/XmCHlwmwvPv5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947143; c=relaxed/simple;
	bh=lBczyWVcEwxF4Ttj3nziaoQ4DK0ZpgMsW5CwuhpOyMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6k2K0tdl4DS2spGfqUbEEILuEhlAI0vIJAS1fvr48IKYruUPKdAuhqnfzew5OADeYeXguIfOVTPjb11vvZMyZnQCwHh0O2YGWVOijZNKj5tWpK9hheb7PzwGcIG40ghHwR6Bn4D3Uth0CnUyUd2B/i+tC0vZEFkgVxdp+u0mZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1onWQ2n; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1onWQ2n"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d146357fb2so80095ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738947141; x=1739551941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaQn6K7jyorHitw/wTj9hI+PJlPLgdCagiVogzW2LvQ=;
        b=v1onWQ2n7gFHKO2n+7GHoyZNmEsJdd7nIhrBrpE7XqoeTaAg83PnbPCfUiPy5B+ovx
         xfPYIcF4c56f/YBLELhAGJgWqE+ALTG+92kAytniHc8TFOy2G72E8BN5fbeKtK3Qi5Ao
         eR9k7TuM7XeKHQ62bea+DfCuKjmgATNtjMPU2nsw5aHWqlx2Udx9YLum9VxW1EGUPDbp
         5YnONKaG5AUbWHOu0fzXetCQI4eeG4C3isst/Z8IzxWT/VlYsil/11bSPRomBqX/bsxZ
         zhHt0FeD/ADDIDDsZqd0KN1wn5iT8ezdVeeU67InZsBCqwkCSWcseWdB1ZZFs2juEzNt
         6WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947141; x=1739551941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaQn6K7jyorHitw/wTj9hI+PJlPLgdCagiVogzW2LvQ=;
        b=CptZ6R5QG8k79K9awlZgzmrzOJXM3i9Rqp385LaGSSDpa3g54gu10PrNEVkHmb0qMM
         ffWIB93UX5xGZcfHaYNWERMMZG2MckaIN98kwOXBblyYVoAYQmOeMz+EZlrNfF8c4Dgw
         S/BV7vYHkZB5hHdg+vuO8Ps0pB35wb5NjdTMxm7vgoEhy/T//VOrS2hwSZvGs5wCX36b
         X5yj8YiJjmvLSVKLm75raa3wsbVCKP9DPLaqc6rwfC6L8njxLp12lXGE3JN6zLJSuLtb
         XTF1z30x2yfDO1Sup/UAjFkaic5jrxuhntbfVUllGOehybwjFqYoc+K2ij10cnWYi3TF
         EvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXBhk0bv/7esidnwRYYjB5DLOPBrPFX2x/z46A4484quv8g87R+tTw5xtG6ZMoz9HDA2mU+OPSIG3iNx0ZY9a6@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbEZzEJvg8XLcaOLOR9GiA2/BHkV5QuANMWK6MqLZvHVoVjzc
	QqfGZ6degCW0FIN2M7VWsiIQhiCKNgp4VLnuwj6hJZYi/kXZJef/tQ6cQ/HUT7JDyYbrKtXz0vv
	LqXEGXUoXts3tkW2KAh+yKPC8moz6Np5F369e
X-Gm-Gg: ASbGncsbEMI1eIlkYxMWY2HKmpCPx8c61crsX46d/tmBLp1KgpIZkzPVRb1mhAml0li
	bh+vsolPsDjzjB4YVQYXru8p2Tud0ulhbYMwwyjBEr8U25LoAeANydpVqlmQJSsQlWReoXsx9ng
	==
X-Google-Smtp-Source: AGHT+IH+eccZeVWVRooHatPRWms97tl2ixYWDBvCtisUhE2l0dgUs4cNDVp2DO8WirI/llb9F18uQzOyaVmYC+rKfN0=
X-Received: by 2002:a05:6e02:1c8a:b0:3ce:3873:48d4 with SMTP id
 e9e14a558f8ab-3d13def5cebmr4524575ab.4.1738947140907; Fri, 07 Feb 2025
 08:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152844.302167-1-kan.liang@linux.intel.com>
In-Reply-To: <20250207152844.302167-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Feb 2025 08:52:08 -0800
X-Gm-Features: AWEUYZlD4rHHScB2ecuCe1drW1pyGKqdAiE92k6K4hUGUg3ZtHT9u6XBaEP-kI4
Message-ID: <CAP-5=fWoRhg6eY8OEhKA-TbWb42pOZiiDF1PENuu5dHPMp-dpg@mail.gmail.com>
Subject: Re: [PATCH] perf tool_pmu: Add skip check in tool_pmu__event_to_str()
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 7:28=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Some topdown related metrics may fail on hybrid machines.
>
>  $perf stat -M tma_frontend_bound
>  Cannot resolve IDs for tma_frontend_bound:
>  cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)
>
> In the find_tool_events(), the tool_pmu__event_to_str() is used to
> compare the tool_events. It only checks the event name, no PMU or arch.
> So the tool_events[TOOL_PMU__EVENT_SLOTS] is set to true, because the
> p-core Topdown metrics has "slots" event.
> The tool_events is shared. So when parsing the e-core metrics, the
> "slots" is automatically added.
>
> The "slots" event as a tool event should only be available on arm64. It
> has a different meaning on X86. The tool_pmu__skip_event() intends
> handle the case. Apply it for tool_pmu__event_to_str() as well.
>
> There is a lack of sanity check in the expr__get_id(). Add the check.
>
> Closes: https://lore.kernel.org/lkml/608077bc-4139-4a97-8dc4-7997177d95c4=
@linux.intel.com/
> Fixes: 069057239a67 ("perf tool_pmu: Move expr literals to tool_pmu")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks Kan!

Reviewed-by: Ian Rogers <irogers@google.com>

Ian
