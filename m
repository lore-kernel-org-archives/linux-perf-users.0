Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729D337BBA
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648350; cv=none; b=gDx/iLAYxTfdFB72I7Y8Eb3M+tcv6b7Ei46MRvWBAnujd2IduoqzYaqnaYjxCdF7ebqt3bXDsPHSPb6g5+9ZYZwRhmJMeBbytoVk3umiDDVyk/dsaVUj0ioi9IvU5aCVWf1hBzsAS/EQL1/Yc6bCNQzmptQCSY9cJ54pbpqUpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648350; c=relaxed/simple;
	bh=71xR6QYzJdwdOokv/CFKZ49LWyyZFU7pcNK54isomOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=kPW+9QBb46hCULsbf7Rdl2PeBS/gqnHoovccb1bxPprvPzYtqd/uboiB2K1jgPPsTnB2+jY5GXirwR0vMzQxJg2kLGi+4TsvYYxkQYiWfH7NmmA0b3+F0Zj91rP+AfiKkpWa6a+301DM+khs0M5N+1lflkJlDZSY5wfQpePwilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOAjCdeF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOAjCdeF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so545460f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763648347; x=1764253147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzRUBgRnLtue7JLgqZDwQWS0Dekpvo9x0SVB1SOpe+o=;
        b=GOAjCdeFbeT8wcBSuw8LmpaU5Scl2R5gEKMp+xVIj5OwTuyE6TTWBkxPlkXct3DVcI
         aUrShZ1B0/05VOyOkH8pOP2g543Anrs4rc4V42foIHQJOyEX0M/9ClTkY/JdhPgwzVBs
         /BV0qyWVNKhj6V2N6nPxXnb9gVW8hotba73LkGHfEA6eN4wWxobZiLbMR7pAA1781klP
         t2dlBPskdC69NSAY6kULB5x+mx8t1Fsb3tcxwYSXF6/F8++uLIaAA6m7hqgF9iv3x9Yw
         SfXYSgIF4PfnaXER0UGhe7IqohWkXFtjITbqwW398ss74Q4qKrjnP3+X8WieMJVg1i5l
         pmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648347; x=1764253147;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzRUBgRnLtue7JLgqZDwQWS0Dekpvo9x0SVB1SOpe+o=;
        b=eMR/KMq/wUd6VBiYtdXQHPfLD+bJzk4JumYjLEi681al6J4+VcLyWUoj3RgUuQ7f+p
         uYyJ9Ip/RxCwVWLWsJfZOIjIvHNgUSEwGnrHrcCwyWez3FsbjE2RirIgwE7UjjncjXdh
         99zuUeAvYxGtQMA2r6P9qPpwR9K4khI74RANhs0b46QARzkNViT7Cq+zEr1bmeG3aO1Q
         4Nq2v5Y94uIVnZ3WJ58Kb/sfHjoRIEZMfu8WI92FRUtujWM+IzVUaNC7MRQ80xrTXnut
         K7nWGwcAtb7hhRUPAa+UbXru0zaOw8sOG1xj8PTA2gT8D8ngxPBUNrjeLC/Fwrwa6Gw5
         WXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUgZCQIdiW30Q6+5M+03oDdoHLM6paOxwZJH+4w8grWpMqKKchw1hzGL9LgevEQZJ2i/GjJYGhXyHpJjr3FXmdB@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7TTYzhtPlJAXlxWwsyBtjbQvSSIHrqeRRquR+QlNneLsKIEv
	xNRVIxldJtMfuCOLbsMpoOL/wjAl+/Orn8mrc3S5Tu9GASEKasZWFuOmXZENo6JIxPo=
X-Gm-Gg: ASbGncvWMt/KLEy6gwgB6QhaJy7HoUVKExMMUnRW5OYELv8dCQ4Xsd1yZM85De13CM1
	ZRcaxfr84ina3MDEBCElY/r9nQHW9lvO1Pa3hIPhzj9DlxnoSOgOgCqSW+aFflhY68y7qwCzsSY
	L/Wz4Wm8b6zJ/2ryLzDx01qhvsPvnQ7Xp3SB2Nos6j79BNito9wdODWFbu6NGecKyf2eHzzCnes
	8ospW1GBA5XT9xZBHNfCSIzq58ETqb5vn90PHp7lW3mFGs6sipdJNZ8giSKBTF5nwaCZGRCNyCK
	RN6476usjwjw/vSgy/6bQO7I5RRbTRVhvt7w9+eSbkx13el+RpbMT6WnoShwbJ6+NemqE7dr2bT
	3DucCy+gwOfQ7oDNHvko50unQYnMmyB2PhhBRdfd9KQqEWsL3GHzNzpInwbff9Krwf6aaqOa1wd
	z2tm5SCQq6squDkjKG
X-Google-Smtp-Source: AGHT+IEyXLt5JVQU6RfXVIsmFqkafV/foIUCJq4WJcs8aLMI+3oGtWeUMpw2rYrwctuS12CNjB8/Gg==
X-Received: by 2002:a05:6000:25c4:b0:42b:3dfb:645c with SMTP id ffacd0b85a97d-42cb9a11829mr3019069f8f.12.1763648346883;
        Thu, 20 Nov 2025 06:19:06 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm5953302f8f.38.2025.11.20.06.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:19:06 -0800 (PST)
Message-ID: <a5b1bb5f-7364-465a-ae32-9dafa0823f1d@linaro.org>
Date: Thu, 20 Nov 2025 14:19:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test all metrics: Fully ignore Default metric
 failures
To: Ian Rogers <irogers@google.com>
References: <20251119193047.2238095-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Richter <tmricht@linux.ibm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251119193047.2238095-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/11/2025 7:30 pm, Ian Rogers wrote:
> Determine if a metric is default from `perf list --raw-dump $m` eg:
> ```
> $ perf list --raw-dump l1_prefetch_miss_rate
> Default4 l1_prefetch_miss_rate
> ```
> If a metric has "not supported" or "no supported events" then ignore
> these failures for default metrics. Tidy up the skip/fail messages in
> the output to make them easier to spot/read.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/20251119104751.51960-1-tmricht@linux.ibm.com/
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Reported-by: James Clark <james.clark@linaro.org>
> Closes: https://lore.kernel.org/lkml/aRi9xnwdLh3Dir9f@google.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/tests/shell/stat_all_metrics.sh | 27 ++++++++++++++--------
>   1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> index a7edf01b3943..3dabb39c7cc8 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -27,19 +27,20 @@ for m in $(perf list --raw-dump metrics); do
>     fi
>     if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
>     then
> -    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
> +    if [[ $(perf list --raw-dump $m) == "Default"* ]]
>       then
> -      # Default metrics that may use unsupported events.
> +      echo "[Ignored $m] failed but as a Default metric this can be expected"
> +      echo $result
>         continue
>       fi
> -    echo "Metric contains missing events"
> +    echo "[Failed $m] Metric contains missing events"
>       echo $result
>       err=1 # Fail
>       continue
>     elif [[ "$result" =~ \
>           "Access to performance monitoring and observability operations is limited" ]]
>     then
> -    echo "Permission failure"
> +    echo "[Skipped $m] Permission failure"
>       echo $result
>       if [[ $err -eq 0 ]]
>       then
> @@ -48,7 +49,7 @@ for m in $(perf list --raw-dump metrics); do
>       continue
>     elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
>     then
> -    echo "Permissions - need system wide mode"
> +    echo "[Skipped $m] Permissions - need system wide mode"
>       echo $result
>       if [[ $err -eq 0 ]]
>       then
> @@ -57,7 +58,13 @@ for m in $(perf list --raw-dump metrics); do
>       continue
>     elif [[ "$result" =~ "<not supported>" ]]
>     then
> -    echo "Not supported events"
> +    if [[ $(perf list --raw-dump $m) == "Default"* ]]
> +    then
> +      echo "[Ignored $m] failed but as a Default metric this can be expected"
> +      echo $result
> +      continue
> +    fi
> +    echo "[Skipped $m] Not supported events"
>       echo $result
>       if [[ $err -eq 0 ]]
>       then
> @@ -66,7 +73,7 @@ for m in $(perf list --raw-dump metrics); do
>       continue
>     elif [[ "$result" =~ "<not counted>" ]]
>     then
> -    echo "Not counted events"
> +    echo "[Skipped $m] Not counted events"
>       echo $result
>       if [[ $err -eq 0 ]]
>       then
> @@ -75,7 +82,7 @@ for m in $(perf list --raw-dump metrics); do
>       continue
>     elif [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
>     then
> -    echo "FP issues"
> +    echo "[Skipped $m] FP issues"
>       echo $result
>       if [[ $err -eq 0 ]]
>       then
> @@ -84,7 +91,7 @@ for m in $(perf list --raw-dump metrics); do
>       continue
>     elif [[ "$result" =~ "PMM" ]]
>     then
> -    echo "Optane memory issues"
> +    echo "[Skipped $m] Optane memory issues"
>       echo $result
>       if [[ $err -eq 0 ]]
>       then
> @@ -101,7 +108,7 @@ for m in $(perf list --raw-dump metrics); do
>       # No error result and metric shown.
>       continue
>     fi
> -  echo "Metric '$m' has non-zero error '$result_err' or not printed in:"
> +  echo "[Failed $m] has non-zero error '$result_err' or not printed in:"
>     echo "$result"
>     err=1
>   done

