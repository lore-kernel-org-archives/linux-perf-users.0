Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC42C326D
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Apr 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409613; cv=pass; b=mfYzASSVFE1aSbjwFKChwJa+2Rf0pF6o/UojfRFS3mbusR66RCn41NK22lhPiircegJQmM0wFR2M1yc5wPTr16+QxMqpLwKyHUxjX81NDWWxEHeXfLLPXJXvBXinEyNoB5Jg1UKu95ExY+T6JWnaFtB8+AT/OcKpcAl/Jy66l3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409613; c=relaxed/simple;
	bh=3YpgLXd4HMbHhM8Vn8koLtFpUtfR2eMycH5fohqGv78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pallJR/JTv3XPTgkVulu91/tBuEQgigyG1U5C5lZ4FpfOSFYmi0+2h+jdV1ZVB1ZHw0+bVVdVY4yi5aVj1P+8Lp8/uVlin9qVdp63oTb9IRrcsXLLWWB6/D7rOarcJ/FmKs9gqt7Ft3NhOsxzzOyQU4uRd4Ek2Jp9UiL9tzuutU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4nUWfSv; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4nUWfSv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2591757fbso209755ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Apr 2026 10:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775409611; cv=none;
        d=google.com; s=arc-20240605;
        b=T6LFAXWwG5b9RMrvWXiKVJVs/UmAPjn9xKSLYB388s2x52hJjNISAdEOf7y/bNXOGJ
         S+Feq41KLeWEb1gzjvHrmVyKGVehL/b0hZGL8HC0/tQwUoYq/l+CYZUm/bNw10uvNULw
         Iy1O2Dg0ZrCnuvev1I/7qBsURKhMkJ7Uu5pE6F3p0VOpipvrl7RKV94yd489Y7O42wpZ
         TbuHdgr2sfubYgWgiIngyJzcwpI/Ty2IwsHJ/I9lzLMeEaRrA9FLIoVdzh/R4ukJKUd7
         wzIPnMYteahLRo44aNqThvCaR96jUciYMp7AiljMEYmLdb95ib7UnDR3lyvO8KGWHACJ
         +B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QpjE6W+5opSIO6M+flagkuZjUlLWTyP2R3Xbm1Oq9Ps=;
        fh=p4bKIbLXRZidzOxpVr0pc1BFcUyWXvuRG5YYUdTW0/w=;
        b=F6X1v3HcPuZocH/BWYQ7ioFB0u6ftZyGATPn8wPG91cquhF3CmqKPA4R1lxl4gxnGU
         qhyxkuLRd2hU/100biuoDZD0R8QZdKwSq6rNVrT3aZVkpQdQ3tq/OebcXjxfLdN/EXRT
         GpowIcO3pv8CSmJgQipv4ulf6QnWy+vx5/cnGHifh//EOMpUhi1xBrtS4hoxjjhMR4yl
         x/d5CfdaSYsxAE0YwcRM1NohevTgorty/9pFKpDdZlq2n8hNw7+thBHwYwv89je7mutG
         gk6P5I/fNRCBpQ6sv7hRRdII0lphnlu2sAKWWcSJ0QN8j9smyl/kAULql4+CrgCI89q2
         pDNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775409611; x=1776014411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpjE6W+5opSIO6M+flagkuZjUlLWTyP2R3Xbm1Oq9Ps=;
        b=P4nUWfSv4b0GmKyPOD6Pq0DZOuyDN/Px25Nrw6aGtBBu2jM5UgU09h0aH78WQ/e0uW
         sD7kXvNo2hXysk9FMwoSLCsUhsne+95zxhdCW95X2aNxki1OavySyWHGS3hTgJDt3PJ0
         Q5gvPd9johepwohhdjpiBkbfz9xDDcdJUrZPecAMUa+R+UclAQQtOFNlgrk/dbXtZ8sv
         Nrf4O8kPPkF85N8EwQ0slp92FrWIx78ppe1igsPq5TGOT+p7KK9sJQZK4RB7ePbEaOiM
         jeX1dbS7kOI2BeE2oTwNEuLkjj95cilyMT2T3xLIyfntidbn0+TNYuvycyneSzza1Rlq
         6wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775409611; x=1776014411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpjE6W+5opSIO6M+flagkuZjUlLWTyP2R3Xbm1Oq9Ps=;
        b=js668ORU5GGqg8RLlD82niBtaXittZT70mQ3UGfdZSPVqc+30r0R7gm4e4RdTXccb4
         EvPkymCZNQkEWqnOeektAs1Z2dUJLg8lauE07LgKRSQk5qS1PPhMzB+bM/Pu3ZigBbhP
         YmZYnUZW5lgRVKkgQDeDORbnP/ZkyywwlWaUv2GE8oeHgm0R3gtEkyPs5H+uZ7YlDDPR
         kGQ9uEYXFLaRyHZArhIUcml8LuMFReXUA3CWCGn6/JOc3c8MAPz4HlZkm/qGbx0U6FWs
         cFcZf/M6J1ElExRhFi243x7LWzsOlDWicSxpeYrNDMwHQGoWy0kWbq+Zz1OUuLKD9wlm
         EY5w==
X-Forwarded-Encrypted: i=1; AJvYcCUYQF2b9XUN6LU1S3l2tHDNA2ulfnKpM95B1KD9wZZaae3iqqGB1ZR9Sy8G/9jXuDrrVqqIDinaq+df46zlFrdH@vger.kernel.org
X-Gm-Message-State: AOJu0YxIil5zrnQtdlpA39hq2rDr3rHF3iVIjTYsjDg3wXzWGBPrN/tS
	fGUhJdXOX06plZWuQ9TQkzuBR8M38VRYdoKcAXvPObZVU9r1K6MMNvvTcduf/cjJyEgTT8GRdHZ
	nLaRuADf+iZKrJ4Ay2cBW3+/QDWOnkRhurRZeuxuc
X-Gm-Gg: AeBDieuDzGllvNM0cterTGFd93B8UR7glh0i5J1zFb8Tadju0VvMh/L2vIiyI8UWG/X
	Qey6hNxztMXWCpRP/sEn9Aras/EVOfBo7U22gKxS8ZB5YxC492g3dC676pDCdCStXrzq1vmrWEP
	aoUEuyQq3p7Mb9VOHoQ7bJW1QlUFn6ARWiYXXqWGibdxpQCbdH4THOTWZUhJG2Uuc3/VBYIRAey
	aswafhADKcCGq2Q122lJdpwnZGjVO/DQm4MFyCpJ/+BgAdWqi5fNF0AJbW54/eunQwYPlfC5CVo
	bN+bl4sw
X-Received: by 2002:a17:902:cf10:b0:2b0:9a61:9d9 with SMTP id
 d9443c01a7336-2b283fbe02fmr4929055ad.9.1775409611096; Sun, 05 Apr 2026
 10:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405051644.61511-1-namhyung@kernel.org>
In-Reply-To: <20260405051644.61511-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 5 Apr 2026 10:19:59 -0700
X-Gm-Features: AQROBzBob0db2TVQpoQxbispA6B8Lyd2gyN_IKdgMMjIGmIDiGyVOMoE4Ah6rFc
Message-ID: <CAP-5=fW3FnZQ0oTQ4wJL654VoTUb=hH=b2EaW_oncoVFotxHxw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sched stats test for !root
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 10:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Running perf sched stats requires root and it fails to open the
> schedstat file for regular users.  Let's skip the test.
>
>   $ perf sched stats true
>   Failed to open /proc/sys/kernel/sched_schedstats
>
> Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/perf_sched_stats.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/test=
s/shell/perf_sched_stats.sh
> index 2b1410b050d04737..41ee41fbf0253d55 100755
> --- a/tools/perf/tests/shell/perf_sched_stats.sh
> +++ b/tools/perf/tests/shell/perf_sched_stats.sh
> @@ -4,6 +4,11 @@
>
>  set -e
>
> +if [ "$(id -u)" !=3D 0 ]; then
> +  echo "[Skip] No root permission"
> +  exit 2
> +fi
> +
>  err=3D0
>  test_perf_sched_stats_record() {
>    echo "Basic perf sched stats record test"
> --
> 2.53.0
>
