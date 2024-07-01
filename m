Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073439FD0
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830661; cv=none; b=HgPQ5U1AG/T0nd2BAhVETO1P9UvhsviQx8st8XKn+xSvEML7F5xVIVzfpqogW1KQqMCr9w5On1zksFC8SCaT3iONiPNvmJ/Pfm0h0/9sMNNzVlv4hm3WYniExIHijofQiBzLUbzhXg/TCHfFewYESqxU+ktUdiAjEoC3OXIMOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830661; c=relaxed/simple;
	bh=XCdW44Y/W1pMIjSU1H0+kvP4gBv+QwTafV9o8Jdq+wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyvgaxpYfMj8z1LDvHzNNQybixYA59SQTBuKuqav+EMwxwVjCtzq6jJUVRXongeeUNhjTPNaTWHEbZi8FxQasPfz4YR1/nmkH+AZNAR8cR3M9/PMishUcFEfM5nlwddWtChIIBuBl5w5sIrDQnJ+v0on07Uft0MlycRmHfOB4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2+uXN9G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2+uXN9G"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36743a79dceso2207015f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jul 2024 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719830658; x=1720435458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgBnC/4yQNccWfXBwuSK6AYXVeUb8AAoDMIknZW7vSM=;
        b=Q2+uXN9GNJqq+N0vZ3vKaVDXQT+IK+6mAaW+r5hgRpPR9IUOtzneNKqiqjkVuenDir
         lGgmu43XJGlADa3+1E6mtl5+YDW1mKNdShS2OEwfJhL6M+zf1aIl2QIsimN9nyJZ/WQW
         u0pYA+PGFgM4on0zqgpaYlEVZurQgGV8yPaIIVuWYUlOJd2qhAfeLI/tART7Be7Ido3N
         JzNQYj62S4XIWs5b/qbROEBNcbiSnAr/4MkGaBofkzfW7/BUIz/SrORqz2n0hrhLOmKZ
         nhXpF10iHK9nj4L5/juMLx5B7qBD/Ng0/5JxOHURXwK5IGWhE3HExe+9+C3dCPRxXm7c
         /aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719830658; x=1720435458;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgBnC/4yQNccWfXBwuSK6AYXVeUb8AAoDMIknZW7vSM=;
        b=e0WBozDJfej9HGyeGuTpVt7hu+WjVGBNd5oM9Bb6+4fJvwAvkRUwZjqouWHsAxHzGo
         i0hJFtzXxq/iN0N79TdabXsD5rzkskgMZYlsFf9+Tp7KbCLyuIlp+zVSUVwLVfJuIn0c
         Iu40Gaz4XUKqwmk14nnLijx3DQZtFLW0Gt9XQdKQy2QxHlsWhVg36MfnLllAFwXkTINa
         UEG1mwNrAyqpl6hLjuzBdaL04UYcQKuvNVSvT1gFBfRG50a9e5uE3WvS0JpwNmuS97WC
         PM/pv5Qt99zO28VAiSYSM0NX2Gr/p1BvwLYVpFuFX04UKUKxg0fslzyB2FW3neigU6WL
         rxLg==
X-Forwarded-Encrypted: i=1; AJvYcCXYUwM54teXPLlhv2PAriEtgRUriGQPUZyxZWLD/I0wWQG4jYpSTfjDqn17u9nXv4Jzzs1kuWbJ1DVkBwPUCKjEKYTfiDiMuspiQBZxRfTQYw==
X-Gm-Message-State: AOJu0Yyswdbp9avMQg3BDZTJNCXgeG5nESp2G3EYq5B0gBygDJDoN6Ek
	UCOZb7BEKXZPYIq9pNZvFYwGCd8k7tUnUulWVwYJfWDaHwsmtOfEmD/Ab43jjB8=
X-Google-Smtp-Source: AGHT+IER1f49zyD3Vmo4dboK911bjrTo2BZCO5sh+GIJBhmfCWyqTNFSUxR1ZhzjBLx6qVtCMqdUOQ==
X-Received: by 2002:a5d:62c1:0:b0:366:e2a0:9a68 with SMTP id ffacd0b85a97d-36774f5fd1bmr3722782f8f.9.1719830657672;
        Mon, 01 Jul 2024 03:44:17 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb? ([2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9b12sm9640262f8f.44.2024.07.01.03.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 03:44:17 -0700 (PDT)
Message-ID: <df5b3001-e79b-4bfd-a2a1-c63111feba8a@suse.com>
Date: Mon, 1 Jul 2024 13:44:15 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] x86/cpufeatures: Generate a feature mask header
 based on build config
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20240628174544.3118826-1-xin@zytor.com>
 <20240628174544.3118826-3-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240628174544.3118826-3-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.06.24 г. 20:45 ч., Xin Li (Intel) wrote:
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
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> ---

Overall it's better I still have some minor comments which can be 
addressed only if you are going to make another submission.


<snip>

> diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
> new file mode 100755
> index 000000000000..351d5a4c7d64
> --- /dev/null
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -0,0 +1,85 @@
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
> +# Create a dictionary of sorts, containing all defined feature bits
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
> +# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off
> +file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
> +	on = ($2 == "y");
> +	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
> +		featstat[fs[2], fs[3]] = on;

nit: 'on' here will either be 0 or 1 (awk doesn't have a separate 
boolean type).

> +}
> +
> +END {
> +	sets[1] = "REQUIRED";
> +	sets[2] = "DISABLED";
> +
> +	for (ns in sets) {
> +		s = sets[ns];
nit: 's' -> 'state', though is 'state' the most appropriate word here?

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

No point in doing the !! dance here, the value written there is already 
true or false since it comes as a result from the earlier check. Just 
drop the !! also what's with the 1 or 2 letter variables. 'st'-> 
'enabled' then the check reads 'if (enabled) { foo }'

> +					if (st) {
> +						nfstr = fstr " " feat;
> +						if (length(nfstr) > 72) {
> +							printf " *   %s\n", fstr;
> +							nfstr = " " feat;
> +						}
> +						fstr = nfstr;
> +						mask += (2 ^ j);
> +					}
> +				}
> +			}
> +			masks[i] = mask;
> +		}
> +		printf " *   %s\n */\n", fstr;
> +
> +		for (i = 0; i < ncapints; i++)
> +			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
> +
> +		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
> +	}
> +
> +	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> +}
