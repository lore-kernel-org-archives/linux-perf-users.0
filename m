Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D73C07A
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221557; cv=pass; b=qNOZ18sZxAVMiotS9ANHjspd4EMHMhtAMHDNIgAJnSaOvcz7MgTpt7EdU511ZAIx0/gj9lwNEj12VifaVjv5RLI9BTdVMQ1Bdp3krLkGCg4STHlLKYyRfFtYOkDZCpgM+dHAopasJCyJHIjTUKswhUzzonAttn395cnG851HdTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221557; c=relaxed/simple;
	bh=agQdRyiekzKzUkD8QSfdqzYYwaY3t3skKjWl0zUZLv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMQMHwaiULbNONo77tpx2eCBgesfeFU1bpKnvP/3bK4H6pdoQHImdq5VroDO/wjl4e7hLQRHY25C7Ubyh5Ue4HZz9PzRvEMW8K4ceZpP9UAYthH/TfXLywFDuO+ae9qTO92nBsWpln55wY8J40Kq1pVScg5Wj7gmYYduKDSNyIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIJcxCxw; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIJcxCxw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52faa58bff5so99361cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 20:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790221555; cv=none;
        d=google.com; s=arc-20260327;
        b=oPp5j2V7LsJB8XQqgvFPJefkVe4gLEwdPWTGxBwDzzEqTo4QZy2qdv1JqJIr6a/f6K
         0se3p5gSdi/rbElgPDfkNUwjpjMDrqJJMCHN/R5l8+66NMdCwcMI2VV8C2UbsZi/PH+3
         KwtJImEVCFwoi0hY9IPH/Av27iFbSuRBDEyJm7bABu/ui+J6Z8D8TItKZX/Ajn8wurNc
         lgWr887qCRaCfUtb52vzb4QJ3neFU0XNGYZyuDrAGF+ls3RjCUSdORlGaTDJSZcpUD4H
         +frg2SSDQFaE6JFdu8BrPEvEJM97W2++6M7AFSjLkqOMDAIQwbNRhLtb1o2QKs7upXeS
         Bcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uqt7YdPAG+fbVbfF6glhS1Jh/r4rcT3mFnxXOlmMXbw=;
        fh=/dffAr6xApo4LkC4qVwAQQsuSmhiQokBP6SFbKrUypE=;
        b=Oh0SQix3ZsJevrKnnOKUgWQW4Kseq1RG9ygQ2Qrosz/zHrd4ZlaicGRmGRiDHj8FZe
         Q7pDSsN7QyGwIqg3UluN8TUq69NGZrx3pzdgwsdWDUikLpIZ8xrEnJDuZetQ7BvcizZa
         Kgp6mTb2MH3ahkshYrzDNiW1f7tP3HojjrAAvcZjeB3F3eoGzf1QiOppYVlTasekJj5r
         17nsdKQksNIHhVk5HkSvAZot4AWHdG/TaKTLY5LCB2EWykXyX5WP432TiTMTdr+nY8kh
         NM/S4Zw7jNuLLAY04wT9LBrg8BbRz0EuOLR73tJZsXoSC3VtUNXjWtZJxDBMHrORen+J
         rDQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790221555; x=1790826355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uqt7YdPAG+fbVbfF6glhS1Jh/r4rcT3mFnxXOlmMXbw=;
        b=KIJcxCxwX37byZbH0bWJXMJxtuLma2cDJ6hsL17mF6I6+nslxOM7NG+jjwfLJQLYOE
         ZbsOr20gEZI8p6Vm5NqLbx+QgP4qhnLB95HqFpxfCeNt+5WQP1rJv73ZQIdtoDqU0xAk
         4uB7BJsaejDV+h3CjSpR5crm4LrIY6KgL9bEPs9hpjyvMKCeKQdZilXXYfDCum8tK+PZ
         jwRnyv0+nd/cc/0suYtz+837Yfq5+D73dZEPv61U5e/uEBM8CUknqXgzItZySDUwI3p+
         mRJYr075pK4VMCbIVNMjULXqxtK+MONowGmxPhxZOUMCh0YBjiY7up7tFKDaXOkz+lLq
         C6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221555; x=1790826355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uqt7YdPAG+fbVbfF6glhS1Jh/r4rcT3mFnxXOlmMXbw=;
        b=WcufzxL62ZE2uVCAs7viM631/MqOEkxnIPnI4MvB8j1pszhqNYr52jeri/XqAQ7v/H
         ZbP+WuwA1qsmvVLtIhe6PBajeFM2fzDJH1VN0xIfu/TiiUt2MJl2rYrniyebowqWkVCB
         J/EiC2ljxCHqeivPYYkfylZUmupMpGOsc1sBPDYjPn0OGKsVwbXOojRc+7bXG4GIUJVa
         8Fx0Rv4UkOxKcrN9IqgO+9hvnCN2oQNq/sdd2YpifAshPoDe9Ku2+p4v0UJ/o1lTz+Ej
         dpBtm5kSowJC6JhpF4U3CwWsdidTAYOFAhJ7klYOEirwkX4lksbC2DiFDafPfwrsZ2W9
         mH4g==
X-Forwarded-Encrypted: i=1; AKwUvBx1vW1VahQv4Xe68991G6iJzUL+LptdFhnBer3/sUThbfH4DrgWJ+xlH4LNNBhlb0ADoOHYiRtZrHW5KEO7N+eI@vger.kernel.org
X-Gm-Message-State: AFuF++lHwcP8cNlmjr8+aRWGDuj4Ovlx1tvfJt4FR4MNT+UWcyi0jjBa
	8Y8hQSTybJiH7Pb9Q2uTGMhpx+Z/XCDSHU5rk9GKu3qnRa3L2/fAg/4+s7tVD6oqgSAOuJLOz2w
	3Z/9QDKCwr/KVW5lL/P7VKJAH/mBL7AiqFxSPPvM+
X-Gm-Gg: AYBFou2H+j8TiUOlB8oXJLCcY1reylDx1kCnKtIufMNCDYq/lwFlb5vyStzKP76QpS+
	yRriJFY1HvUxGqYo6bXIsuJmEWrd5FvPhEPbmpsH2IfJ7VZZpGVp0njHZBgWTADemRWJpuzkwUS
	aAiplDH1Y+hG5XMQGWGs9ijCSS+qa03EKfdAvRZOVtTN0gKcckUJO8iydFTPDvsPGixC1volujL
	5h3S/Kutdu7HzSLYONhrA6iF3APTXheaoVtC3bfvzuzEvRobD3i+k/C2PtsonaU3k/SR8nwTQEE
	HXvpEg12fW2CByJLqeCtF7Hi0F4Pz15dBGrE8BtUyye5VFDzanKBqvU=
X-Received: by 2002:a05:622a:4110:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-532fea2231emr2750391cf.5.1790221554565; Wed, 23 Sep 2026
 20:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923215255.3329181-1-namhyung@kernel.org> <20260923215255.3329181-2-namhyung@kernel.org>
In-Reply-To: <20260923215255.3329181-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 20:45:43 -0700
X-Gm-Features: AclHuK_Jlv41nVnh02C2Krhs-ub1GtaU47Y_EHUe2Wi9C7qHr6XPY88shWHsO7s
Message-ID: <CAP-5=fV1_4xC7mjmCpBarBNVd9e=ZYHAojtpK5ECuAF5u+s-Zg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf test: Fix record tests on Intel Broadwell
To: Namhyung Kim <namhyung@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I noticed it failed for leader sampling tests on Broadwell.  It's
> because the period of groups members are a little bit different.  Maybe
> there's an hardware issue but anyway it's close enough to treat them as
> same.  I printed the value like below.
>
>   $ perf test record
>   ...
>   prev: 462507, curr: 462506
>   prev: 494783, curr: 494782
>   prev: 454350, curr: 454349
>   prev: 502782, curr: 502781
>   prev: 566693, curr: 566692
>   prev: 606558, curr: 606557
>   prev: 559770, curr: 559769
>   prev: 595737, curr: 595736
>   prev: 643386, curr: 643385
>   prev: 663672, curr: 663671
>   prev: 620622, curr: 620621
>   prev: 650419, curr: 650418
>   Leader sampling [Failed inconsistent cycles count]
>
> Let's update the logic to compare values to allow 1% of errors.
>
> Also I think it should compare only if sees the non-leader samples so
> split the check of (($index % 2)).
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

+Dapeng Mi

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index cf8ba3d3411b0bcc..04df35b30b0c15fd 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -550,11 +550,14 @@ test_leader_sampling() {
>    while IFS=3D read -r line
>    do
>      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"cyc=
les:") print $(i-1)}')
> -    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
> +    if [ $(($index%2)) -ne 0 ]
>      then
> -      invalid_counts=3D$(($invalid_counts+1))
> -    else
> -      valid_counts=3D$(($valid_counts+1))
> +      if (( $(bc <<< "scale=3D4; r =3D ${cycles} / ${prev_cycles}; r >=
=3D 0.99 && r <=3D 1.01") ))
> +      then
> +        valid_counts=3D$(($valid_counts+1))
> +      else
> +        invalid_counts=3D$(($invalid_counts+1))
> +      fi
>      fi
>      index=3D$(($index+1))
>      prev_cycles=3D$cycles
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
