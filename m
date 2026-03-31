Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5B345750
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977758; cv=none; b=QovW2tZXaoFpMGErhxwcSifHtJNotd6kF9mpQ4u95OOZGTc4Gy2zrmy38dFARKPj9jntTCLFdi9qXmKTTImoQ23AJB6x/5GFO/b2In4GQdGloRHDF625N24disU1GTQiRHMq4SiLVUYTfogTXij8nLU0a33FDmGyQ0Llyiw5oxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977758; c=relaxed/simple;
	bh=pcywMolBn0oP7rzSAhDoY4rho/BcYShbzBlVdZn27fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMPqnaNZgMKOYz4gxXjX4PQhEw8RhnJRkgw0frJ2/CQC/mlpLgGtvs5loUJgADXfuOp4wVZLp5euMR10QXAJxFGr0j9fqd4C3OrflOu9/pTTSU0AOG6zMiteg7w1pBq2I375J8ASlj8/U5OknxRK6yDzilNr//RoZtD4OpmDkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=D5VFnsxk; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="D5VFnsxk"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12a693cdf29so118142c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774977756; x=1775582556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buMcd7BiSqQWL605PmrRNw833KvkdK7h99i/7i+pigQ=;
        b=D5VFnsxkWVrEPg0Nku93b41U+OL3Dhj95CrJBJKh2LqW6np6usWgZJw7g/WELPsHB5
         ACSRIteb4iPDdij8NqLLQXW4T4cmGN+G7TElTuC19jsNgV0KDtScypO/5XCvWfjqbBww
         aVaCuBTaekiCin/WRgSYPaSa7c30EMKo5Dw3CnAE1ty9Q9Jvrp3ngORBRPzEgeZipVHW
         UlE9bTqzJUqkJTHxU2ohe3YwifiixNLzgx+VVTFOMqdeEEkcmD4zRx05JnX2VudE6SWO
         RNgbKSMroIlXfsJFsqJUPcEwipOX85Vb/x2A03Sn9LJQwBZgYzOhk4bX5y9V5Hd3TsMG
         /Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977756; x=1775582556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buMcd7BiSqQWL605PmrRNw833KvkdK7h99i/7i+pigQ=;
        b=Iie//GGUxkH3+SeFDx7F6p/4TcAPyMlNTJyJWVr1YYPwHXRtAWLMNqn7nQ9DGozrG6
         P4AdlnPUbvvl7n9sJitcKtbo8ht+oEBoAB90XTSXHjvtRaLyO+rC0zKBn5XrzMQFMc9A
         ni0AYnChwdC7cCzE5ESHEddvxmmmtNCzbU6Uk0KCmcasxUG9jSdqOxCqlomMc/grQNAQ
         /OoWxubjKqwz19Ajo5cTb9ltuDi5HLCT5GrWiskiiyK6xf7YdG4N6MV72VuVNANa8fuB
         zybSRajdrolwPIK6tCRaCKIWq+mIvM/M0s6BX+N/6XtJInXM3FSzMGKdDOqGBiI3E3P4
         iYew==
X-Gm-Message-State: AOJu0YwUcm26dIN1EEg6fo8oDqcSrO16p6Su12P+k1r7tdSuHKPsjQlo
	Umx/erE2SKngLJqwL7G6U27MsIErpDIsHXxg0aJWqCPhjrQhgdCl1qES2wKWABIP9gI=
X-Gm-Gg: ATEYQzzhxDRI1kxxK9Vkvu8+1wwtR2hMT0vhJVZ3y7uzCb3cCmkYuNbVCvXJPdADgsC
	2aSRIp95R+/YdtqmARkdA3QciQgDAzY6KGkEzRzMRCg5YxBm+ARLKeHaHhWME25QLSp4/6RcUn6
	s8ou4U+RnhTskIaVBMpHDKZFid7cuLK97az6xx9QqGNyUvtmk/tKhKw0i7iF2hSvs6NXgbv51FA
	oZde9P8zijk1aBdrqtqN1OO4EQDVaRbnprKlsCtgiLIqZbaTdI42eu7x/xMUR0yz0pqyJdRhh3o
	JJgEvhLianxPwcpp51RSxk4Nnn344XRwSEOrLo4I3nLoV1oZoydGGJEdwhXriat10DKleuoOxXb
	2KetXX50MOjwWgH2fAzwfnFoZGPB4YMFABF6j561HZS2JoSlv7YUziPiGkmsoM4Z+D70HxDzNmA
	T8oXyL5iDhH3pWsuFVPt4Tsj+uhQ==
X-Received: by 2002:a05:7022:ea26:b0:12a:6b26:8618 with SMTP id a92af1059eb24-12be67b2c52mr99319c88.2.1774977756148;
        Tue, 31 Mar 2026 10:22:36 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:36de:b209:4884:3260])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm17170946c88.3.2026.03.31.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:22:35 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:22:33 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] perf: Don't throttle based on NMI watchdog events
Message-ID: <acwC2R63DVoZVf-l@mozart.vkv.me>
References: <cover.1774969692.git.calvin@wbinvd.org>
 <685061daed5b505ef604835b602e0202531f2315.1774969692.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <685061daed5b505ef604835b602e0202531f2315.1774969692.git.calvin@wbinvd.org>

On Tuesday 03/31 at 08:25 -0700, Calvin Owens wrote:
> @@ -663,6 +666,17 @@ void perf_sample_event_took(u64 sample_len_ns)
>  	if (avg_len <= max_len)
>  		return;
>  
> +	/*
> +	 * Very infrequent events like the perf counter hard watchdog
> +	 * can trigger spurious throttling: skip throttling if the prior
> +	 * NMI got here more than one second before this NMI began.
> +	 */
> +	now = local_clock();
> +	delta = now - __this_cpu_read(last_throttle_clock);
> +	__this_cpu_write(last_throttle_clock, now);
> +	if (delta - sample_len_ns > NSEC_PER_SEC)
> +		return;

Bah, Sashiko caught something obvious I missed:

https://sashiko.dev/#/patchset/cover.1774969692.git.calvin%40wbinvd.org

>> When the outer handler completes, its sample_len_ns (total execution
>> time) will be strictly greater than delta (time since the inner
>> handler finished).  This guarantees delta < sample_len_ns, causing the
>> subtraction to underflow to a massive positive value.
>>
>> The condition > NSEC_PER_SEC will then evaluate to true, and the outer
>> handler will erroneously skip the perf throttling logic. Should this
>> check be rewritten to avoid subtraction, perhaps by using if (delta >
>> sample_len_ns + NSEC_PER_SEC)?

The solution it proposed makes sense to me.

>  	__report_avg = avg_len;
>  	__report_allowed = max_len;
>  
> -- 
> 2.47.3
> 
