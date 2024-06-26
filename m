Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723C17E911
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401778; cv=none; b=bQ4646hSP5u9CL71tHKScAzVWQKpcXTOlIT+TKJJILqW5PNN9uMXIK1GSfuqJou+XTnKdCbEID2NQvJRCqWE2zX6LhDTjfU9p9trPFnwSoIPhXCbrt6UIYvfN3Jk060lK77YIuCg9RLU0okvHdcHaawhnT2j2gl7djfS6/Cmo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401778; c=relaxed/simple;
	bh=7kxtBK25xovD9hnasOmXym1Dqzb8xYXCkDVgPyX+fcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnSYyX5QAVXHgXRugwOl7L62qDDPAatVSYsxpj9+j2pHPARo+uKYiiGeISYXGRC6USqEQezh+jjTBEAyDavv2yuUrm1CBWmLR3U49P+3VRYiqDkxt4LFANBJsmZwjCZRrl+ZyGE8buED8oBSO/pdD3yFwJnNWK4OXw/GBt9vvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TGt/ZUz1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TGt/ZUz1"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cecba8d11so2294359e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719401775; x=1720006575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMuzpY4Z872AyWI1aK61/MVe81tb/rCrS4Gors5C2F0=;
        b=TGt/ZUz1HGQGhfzvWKYGkdEocIa85dHpu/hO2yWQHIOzwwV4mtPXq3Rv2pPZ/0NElF
         81oKUjwvWUX95cUf6kDWpyM6Hg5pr09cPg1ykvzyDTW56b1NFaH1Mvhz3ROLZYD/wYjf
         G429Gym3StU2gXb6adrajCkZnwh5qD/1cT+9dCSbtgV9gKQMYc4DzZReZr4XCgEuNCzT
         Itwg5xklgJ1y3wGDuVAYGg2eMJ4YUWznmyTwXUkWSyikLsz8fs/IBLj4OvYZxCuZ5sCS
         p3I0bqTs5hwoyRA563UWrCZj3DnAL0fUV4PisOLJSRiETcPWYYVwYa3G3ETtQarqxt6l
         NJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401775; x=1720006575;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMuzpY4Z872AyWI1aK61/MVe81tb/rCrS4Gors5C2F0=;
        b=orh96oEOd/WHRKU9qFcjqgFlyqQP8ygqWxD8pNSvzEdn9DJMk4sABNDMzqHdFHAy9H
         xc+Tw7NcR51m5XtFh726dyR8wB4LkaXjlqzb2fInOtU2k4oywqYJ+etMLY406VF423YL
         +Hy/wYLfysJPT39k7PK+4yuUL3p2iOET+jdiLBD0Wfq6gSzpXSsB1MJ6XQm+I9QSjJZm
         2vgRr8HQBQGXmMlBXW9aPKNNOXPI68TKzFDe1mtGu4u51f+9yTrcE/QQu4TJhFjPntxJ
         f7kKF0+pFMdB6t+xxRnow40wBDwLDELIOW+e0S4dz9DWC39o26ryMAjUMx+LuWflfnje
         vrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWeumRRXHBgTQh3+xXnfrRkZtiFn3Xx9ALtvaC3Ulr5Ol5hqARyLVP4L6cH7yDgj9xip4M8DpryUrmAuvwCAj4g8KoHyW6j5DqFbW8syVMbwg==
X-Gm-Message-State: AOJu0YyC5vlH4P9vid3sZVG0aj63ZenW9uHUmWeQaq25h4bnK7OZsK0U
	X1xjiHUyZcSv0MbRA/KANnOGuPYrgpNKoGC/GHBipXwVU/EPNbffD5xWdRc9A6c=
X-Google-Smtp-Source: AGHT+IEPEpCRb3cEZBmhNT1f7PAwFW+p+uWIp3od7KrxRjrljO66wKi6YdCFGUJvQkzMblj3tBvohQ==
X-Received: by 2002:a05:6512:31d2:b0:52c:e3bd:c708 with SMTP id 2adb3069b0e04-52ce3bdc757mr8165299e87.10.1719401774812;
        Wed, 26 Jun 2024 04:36:14 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f973b7e5sm6762226f8f.14.2024.06.26.04.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 04:36:14 -0700 (PDT)
Message-ID: <5aeaaecf-0eb6-4934-b14e-2285eff6cc62@suse.com>
Date: Wed, 26 Jun 2024 14:36:12 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] x86/cpufeatures: Generate a feature mask header
 based on build config
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com
References: <20240622171435.3725548-1-xin@zytor.com>
 <20240622171435.3725548-3-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240622171435.3725548-3-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.06.24 г. 20:14 ч., Xin Li (Intel) wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Introduce an AWK script to auto-generate a header with required and
> disabled feature masks based on <asm/cpufeatures.h> and current build
> config. Thus for any CPU feature with a build config, e.g., X86_FRED,
> simply add
> 
> config X86_DISABLED_FEATURE_FRED
> 	def_bool y
> 	depends on !X86_FRED
> 
> to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
> feature disable flag, e.g., DISABLE_FRED.
> 
> Lastly the generated required and disabled feature masks will be added
> to their corresponding feature masks for this particular compile-time
> configuration.
> 
> [ Xin: build integration improvements ]
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Overall LGTM, some minor points below.


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


<snip>

> diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
> new file mode 100755
> index 000000000000..989b021e73d3
> --- /dev/null
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -0,0 +1,84 @@
> +#!/usr/bin/awk
> +#
> +# Convert cpufeatures.h to a list of compile-time masks
> +# Note: this blithly assumes that each word has at least one
> +# feature defined in it; if not, something else is wrong!
> +#
> +
> +BEGIN {
> +	printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
> +	printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
> +
> +	file = 0
> +}
> +
> +BEGINFILE {
> +	switch (++file) {
> +	case 1:			# cpufeatures.h
> +		FPAT = "#[ \t]*[a-z]+|[A-Za-z0-9_]+|[^ \t]";
> +		break;
> +	case 2:			# .config
> +		FPAT = "CONFIG_[A-Z0-9_]+|is not set|[yn]";
> +		break;
> +	}
> +}
> +

IMO this script could use a bit of high-level comments. Something like:


# Create a dictionary of sorts, containing all defined feature bits
> +file == 1 && $1 ~ /^#[ \t]*define$/ && $2 ~ /^X86_FEATURE_/ &&
> +$3 == "(" && $5 == "*" && $7 == "+" && $9 == ")" {
> +	nfeat = $4 * $6 + $8;
> +	feat = $2;
> +	sub(/^X86_FEATURE_/, "", feat);
> +	feats[nfeat] = feat;
> +}

> +file == 1 && $1 ~ /^#[ \t]*define$/ && $2 == "NCAPINTS" {
> +	ncapints = strtonum($3);
> +}
> +

# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off

> +file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
> +	on = ($2 == "y");
> +	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
> +		featstat[fs[2], fs[3]] = on;
> +}
> +
> +END {
> +	sets[1] = "REQUIRED";
> +	sets[2] = "DISABLED";
> +
> +	for (ns in sets) {
> +		s = sets[ns];
> +
> +		printf "/*\n";
> +		printf " * %s features:\n", s;
> +		printf " *\n";
> +		fstr = "";
> +		for (i = 0; i < ncapints; i++) {
> +			mask = 0;
> +			for (j = 0; j < 32; j++) {
> +				nfeat = i*32 + j;
> +				feat = feats[nfeat];
> +				if (feat) {
> +					st = !!featstat[s, feat];
> +					if (st) {
> +						nfstr = fstr " " feat;
> +						if (length(nfstr) > 72) {
> +							printf " *   %s\n", fstr;
> +							nfstr = " " feat;
> +						}
> +						fstr = nfstr;
> +					}
> +					mask += st * (2 ^ j);

nit: This expression can be changed to mask += (2 ^j) and moved inside 
the 'if (st)' branch. Essentially only add a bit iff that status of the 
relevant feature in the kconfig is y, which is signified by the value of 
'st' variable.

> +				}
> +			}
> +			masks[i] = mask;
> +		}
> +		printf " *   %s\n */\n\n", fstr;
> +
> +		for (i = 0; i < ncapints; i++) {
> +			printf "#define %s_MASK%d\t0x%08x\n", s, i, masks[i];
> +		}
> +
> +		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
> +	}
> +
> +	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> +}
