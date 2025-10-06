Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F62AE68
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793993; cv=none; b=TxUTHP6f3o3j416weMV9d3GZo5TSI30LmmfFvYUzBV4j1kw3FENvYlMIsOArsmvLnK2M5pqvuVGJayRJ05DvqCgy4oDGrF/eKgqFYmkNVV0e3RfQMNsRYzQJvJqtJLWZwfk3N24wHTIV1QH9pYLA2NxFUqHbBub7ocx2lsAlBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793993; c=relaxed/simple;
	bh=Gns+VlYyW80ZkP3KAJMY8rFbhbpsU6HpY4D7cIcI7Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbPNIY1QkxL0tJSCTHPT1GHH8EhgG4EgqTk8wTCd7gREMny4l0Dz3H3wPfy0LeMUoaBafPuJcAuYrxGtJFz5SZvw+ihw5Tgl23S1UiEaDoCAucgHAMO2pLDPpcVuGxMrNg2SO2W2hUpCNVdwWOYcW98Ql0Vm+2x974gF5u3bq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJNTA2lo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJNTA2lo"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42e726431bdso24280475ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759793991; x=1760398791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9TZOyB/EMo09OKq3vpFLrmNzk6bmCMZmlPS+l7lrX4=;
        b=bJNTA2lo+TL2iv1YIuZ2RMQKNOw+PnxlUMUSGMjQ0skheSr5mCVqhSRmV64TP13a4c
         dI3aKw31cyS5Xx4yZg1YiwZ9FSOmlXys1b/iofrfGM1KuWT8zLTvTwDA/ILNanSANPBj
         u+hng1e5CgLyGgRygywV4xJ/Q74ehLRl/RZF/TQ9OBu1YEVUMj9ofZRL6P69iMhf7fkd
         C4RdY426Jxe1v26wSYBgHhSeCMeNtzWg6O6t71CzWzKm6J801mQLjk+JL6Xic0rnWt7y
         9oDLSNTXyMP7gKntzE7YVSYSgjbg9UyTdqj2MQ1g2E4mmgMOlyDjh2FnWchMe8bLUm/k
         u2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793991; x=1760398791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9TZOyB/EMo09OKq3vpFLrmNzk6bmCMZmlPS+l7lrX4=;
        b=OaG3Onf2WtLLD51QTU0RMPBDIjqk29jXzaKU1cDIdEjp2E36/6L7nI3N8v5yKgfjV3
         AN9NUCpeUBFSxwGWUjkgBK7AcIbnpb8Q8P64jDC1JAhjAcYh4TuyxE4yQp1rytkrA5sI
         Q9IB84aPd8Sbb8/L5fwmOCiKxcxTITbKMyqT3syWbH1R+B27+lu+8zbVWVfVrRbko/7y
         O402yS97YM6tUg3lkqebIf4vlZ5vm42JFTK5J/70fb4eV1HmD36GdCy/SH3r9KJpjvo8
         axvQBu9gFwyALrzgj/hnFv3Yl/xEc48ylaxKbkP4yjkn01Dod8MlzmiQqpCVFGjtgHBa
         tgeA==
X-Forwarded-Encrypted: i=1; AJvYcCUX1Dhm250gjY/VwnnSp4MDHdkGWpiokdD/ZBX57iHjv4qit7WyYp9JjMuOvGKiLIk7YABcIHjZe9ZnXudIKmGV@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYadac81GLHmIuAHY5W9026kChPelC+ouwIjqII0vNdjNXcr5
	x6HZdv70XO7k+o04jO3XaxvKT9KkZIh4+N3qx5I9KbkynNvhlkOiCYYY6mQuQLax7A==
X-Gm-Gg: ASbGncvbCd58GPWh4VUzavuNh87gXXi69Nmurlkkre7/NOIS4tHioEmkJtqTZSC6CiT
	zT1Se4gtFsYc0qR7mDv9ll+exsE6qBSKe3PKNlVtRTRFRSlSA3ISAgJHFHREiZ2ZftjXeDWc6ko
	7OUI9UGdCGmtcEw9NtJjYkuNDdPbZqwyTmrmZijdp6wu5kYkY5/qcnvaIlIDeegVT0gqqkxUnQd
	F12s0ylqCaIOCIgTC7WMWxnTszNF/yus/aiyCl4TL1HkWnsKWqLw8dc2ooYY1t0OrQLzEsvmyqs
	tnrCPG8J1MGWMjyXuKbSWf/7bXCi+6HcSIZ0gHNw9nxcDH/vqDHyjLwnZX39AdDpnCUR3B8jnGU
	XDGQ9E3tU2K82UetpVgNCzYLMIXN4b3c0sKRxr9RxuNXyzlJqiV2W6OKyhjioHtgHHzAhjrECon
	4c52l6i9ypMm4UHFoupSg=
X-Google-Smtp-Source: AGHT+IFiW5uuUfThNCAE5E5ZFgpL6m05j9sNEBA5KdXE7U5W1B+ttFi3OD7gOKI+vJdjrDuPcWhiyg==
X-Received: by 2002:a05:6e02:17cb:b0:425:8134:bcaa with SMTP id e9e14a558f8ab-42f7c2d49a8mr17910315ab.0.1759793991149;
        Mon, 06 Oct 2025 16:39:51 -0700 (PDT)
Received: from google.com (138.243.29.34.bc.googleusercontent.com. [34.29.243.138])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm57563385ab.2.2025.10.06.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:39:50 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:39:45 -0700
From: Justin Stitt <justinstitt@google.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v1] perf build: Don't leave a.out file when building with
 clang
Message-ID: <csrtenswfduvfgyalcydxudcwjo7ezt5vuvfxkkrbpza6o3cls@t55uhpt4363z>
References: <20251006222116.3335193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006222116.3335193-1-irogers@google.com>

Hi,

On Mon, Oct 06, 2025 at 03:21:16PM -0700, Ian Rogers wrote:
> Testing clang features doesn't specify a "-o" option so an a.out file
> is created and left in the make directory (not the output). Fix this
> by specifying a "-o" of "/dev/null". Reorganize the code a little to
> help with readability.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Justin Stitt <justinstitt@google.com>

> ---
>  tools/perf/util/setup.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index dd289d15acfd..6caf2126b1cd 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -22,8 +22,16 @@ assert srctree, "Environment variable srctree, for the Linux sources, not set"
>  src_feature_tests  = f'{srctree}/tools/build/feature'
>  
>  def clang_has_option(option):
> -    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
> +    error_substrings = (
> +        b"unknown argument",
> +        b"is not supported",
> +        b"unknown warning option"
> +    )
> +    clang_command = [cc, cc_options + option,
> +                     "-o", "/dev/null",
> +                     path.join(src_feature_tests, "test-hello.c") ]
> +    cc_output = Popen(clang_command, stderr=PIPE).stderr.readlines()
> +    return not any(any(error in line for error in error_substrings) for line in cc_output)
>  
>  if cc_is_clang:
>      from sysconfig import get_config_vars
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
>

Thanks
Justin
