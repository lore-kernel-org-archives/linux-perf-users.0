Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213F330B0B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164067; cv=none; b=M38zfttD/cgAQz/dwKCPLX7jgqGDoKDyreHEVpAYtYKAqDqXw8h1U9W2j5xBlTQI/6V9j/NeuNUcdiZYD9wFV8hyPCOGV2ZKTJNHevWJIgP+Iof+IyHHPfCHTwnmSyyQ8Z23zum1sMK5eeM0YOzy7D4SDa6DK5ylnAAGYw0r9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164067; c=relaxed/simple;
	bh=7IaTajV/+dkBgAhYABMFyBGpmbeadMJYvwi9yXjkLRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMkSlJig9XZGUuZe4XqH4a8Si8shbJIyNjEggL/Rwm38g6GFbGcQhcsTmqqID0/g0c6FxVCoYopT0/LWbNXjsA97QPacDJpOFtuK1K/ExJVtgo9RwFiQgXL5HzU8aBwk3x29shAaSEwPmpcDPpamCyB4ncs54+0oQLrEwZUaSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBTT10Da; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBTT10Da"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso22562845e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769164064; x=1769768864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt7TAVcRMZnTWPF3p56NDBk0ozlKnXVnrXA2jTNoF28=;
        b=nBTT10Dak+boVmv/rjO4zWrrA0MaCI/NC6G88i/GG6ePAXEb1JRCTmNtfhbvCJvbT+
         N59fSMNnBKwPGQMZduvpjcu7Wd07xM27lb5MCeYoGHsbhjEzEUfavKDqu8gC9vs74boe
         hQuhpzsL7GwNx+tXhjtKitX10M99Kc2xZ+1UYPlqR0HAP1/UJLHQMFRgXmS4OMwoSi2H
         rfznppIsS5Zardbyth3UkeILSzlfr+bA6Qw132nYEynA70Z+yeKmNQFfVamiSTeP02uz
         Il85d4hwDkXrk0BPfe5FUKhokrT9jMtncI7uEP4I5r6my+TZ7Q0QNlT5+J6JYjlSeTtF
         +mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769164064; x=1769768864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bt7TAVcRMZnTWPF3p56NDBk0ozlKnXVnrXA2jTNoF28=;
        b=MFFKVlhb6a0y8geKGiqhVGZasfBzJ1LcsBB9VsSc3Pcn1Le3Pk1pec1tJ7HnIybcPs
         0Rx70xZXOehlGC84NqLPG0UWkQMPE3V1V+8xLNIEMC6S7VLQSP8YOdBfPxl1onc4/YgR
         YoM9MlrdpWQrhbqrMgKO2rYrk4SdWB7/s1MyTncMPk+lmTv42PowrVKywTm/rbPwwV8f
         fw27zR+6tEqCPryyi1uvwZAhaIOglBXKP6BOmE0bNki4IpdtB67g7BhI1YtVcgudApLH
         1Hc/VqMdVWCR6CS3Unp6PexMJ8oy5ADRelG4mNc/BMsxLWePUt75WdBhck75uN4Z9vQE
         FkrA==
X-Forwarded-Encrypted: i=1; AJvYcCUgxS6TgVuX7lbQLCkN0veK/Tgo11b1DHwunfUJUDiJq4LeIVi9pleBy5GR9kWlg9vX++AdRDQYywgpSNdKzSPi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BfA9Vv5f020KK6baUL89XLYTokAO+3+umrDA8JB2Tx+82URr
	RJHqX595KTpNjRxrYN+bzu06wHRZ3Ad2sj/1n2vZldSNxt+yVpin+wbHcBvwwm3vcL0=
X-Gm-Gg: AZuq6aKIQVW/PfdKLFrrZr6qS6Abur4Ufuo4o/OBNcQdVmCXMdEg+2Dlkfmx/s4V3Ki
	6v03TX7XSJoV3LRHWZ/JKQ5C3fLbw1TuG59yvT1uiwXoSSZ1lzJBJWPCBIkQ5eoLMWbm5Hy5TKR
	ZB/1EDTcmeHWejck+3eC8Pob9d6vDFc0RLoI4bABoTPmVuYHgopQL9lKqZnKdXMQnAJnOJe8g3l
	7H13sDC2VuhAhdAolsXyS64IFBmubd1ryRz4bXSd6nDR8tGhB4CjJgljm1uDWwo9F+jvAME2xv8
	WSHM1tEixvCUzVpxa/emYdJLQY/jdvULBFWTboxFz6BUux/ebfMiKfJaTYMWR76wzXlWcHujW0z
	l0mMp49K5gsWXdT9fBy0axAkPEeQd0DqVwwT0KAc2J2MPso0LCjIx1DzSdW638fdXF5AaCCWVwp
	BuM891G4VxZv2s2TTj
X-Received: by 2002:a05:600c:8b0e:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-4804c946d2fmr45973205e9.7.1769164064086;
        Fri, 23 Jan 2026 02:27:44 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5b2dsm47439825e9.9.2026.01.23.02.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 02:27:43 -0800 (PST)
Message-ID: <705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>
Date: Fri, 23 Jan 2026 10:27:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm_spe: Fix bitfield dependency failure
To: Leo Yan <leo.yan@arm.com>
Cc: Thomas Voegtle <tv@lio96.de>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org
References: <20260123100218.233246-1-leo.yan@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260123100218.233246-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/01/2026 10:02 am, Leo Yan wrote:
> A perf build failure was reported by Thomas Voegtle on stable kernel
> v6.6.120:
> 
>    make perf NO_JEVENTS=1 NO_LIBTRACEEVENT=1
>      BUILD:   Doing 'make -j12' parallel build
>      HOSTCC  fixdep.o
>      HOSTLD  fixdep-in.o
>    ...
>    ...
>      CC      tests/sample-parsing.o
>      CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
>      CC      util/perf-regs-arch/perf_regs_csky.o
>      CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
>      CC      util/perf-regs-arch/perf_regs_loongarch.o
>    In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
>                     from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h: In function ‘le16_encode_bits’:
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h:166:31: error: implicit declaration of
>    function ‘cpu_to_le16’; did you mean ‘htole16’? [-Werror=implicit-function-declaration]
>      ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>                                   ^~~~~~~~~
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h:149:9: note: in definition of macro
>    ‘____MAKE_OP’
>      return to((v & field_mask(field)) * field_multiplier(field)); \
>             ^~
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h:170:1: note: in expansion of macro
>    ‘__MAKE_OP’
>     __MAKE_OP(16)
> 
> Fix this by including linux/kernel.h, which provides the required
> definitions.
> 
> The relevant C file in mainline already includes kernel.h, so the issue is
> not exposed.  It'd be good to merge this change on mainline as well for
> robustness.
> 
> Fixes: 64d86c03e144 ("perf arm-spe: Extend branch operations")
> Reported-by: Thomas Voegtle <tv@lio96.de>
> Closes: https://lore.kernel.org/stable/3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de/
> Cc: stable@vger.kernel.org
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index adf4cde320aa..8d16619cd098 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -7,6 +7,7 @@
>   #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
>   #define INCLUDE__ARM_SPE_PKT_DECODER_H__
>   
> +#include <linux/kernel.h>
>   #include <linux/bitfield.h>

This isn't the first time I've seen this issue. Isn't the real fix to 
include kernel.h in bitfield.h if it depends on it? Usually you 
shouldn't have to know what all the dependencies of a header are when 
you include it. Or is there a reason it wasn't done that way in the 
first place? Maybe this has been discussed before?

>   #include <stddef.h>
>   #include <stdint.h>

