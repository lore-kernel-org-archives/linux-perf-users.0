Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43513B592;
	Wed,  3 Jul 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998617; cv=none; b=l0oZfhSFzGTNFFSPG3OWJDMPhRsIizZZUdY4bk+LF4XDeHuNkRpkvDl7Nlwe8IrsPHguTAmKlXsLHw7G/aRqCgMDoLXjW3DK7+s/O6eT2im4QMDESM+if5uST2u3XnWJTsDvndsNcKhaAjJEzTxWSWAzTorbTqkruBBvUvTlivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998617; c=relaxed/simple;
	bh=TBGC9Dan9vGqetl5WATjTdps3EQfpzzfRQi+UrwaeVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGsaQd/rdLoHHns7mtw1ZYvOL8PFd28JMy074ydjl8EwZesChI9doz4ZvgfAhGSo0FB78L6JyTFofnh72CCL6bn5dfxdq72ntirvKxwnldE8LNx8nnZ2OghgCdQZXXMgNbwUQsD9Q0SlIyoEBtKIUGNnR6jZ6GWwYGmmB0vv7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GkUbEEI4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GkUbEEI4"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4639N8KS289555
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Jul 2024 02:23:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4639N8KS289555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719998589;
	bh=j4XLOK1g+Fi+APGrWOjI5bHBPtCrnTFiV/z2Z8mj4p4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GkUbEEI41cONifmgA3Ovr+k+ZvTNwp7iNNvvMDzmbKg9NbQIm0lyhIUZ7nlzOMboy
	 fkjkwQWwPmqKwENWM9Kwdi28BBo7/rMz840FhJg6qynsyUDuQEvqyPaLato+v4Htxq
	 KaRl59VBwuzBFM0igvRGNHCm05jszwAw9m8KUA+5UDunSbcXYopi50VXENarkjH6So
	 /4OkaSm3Axsb77n94O4WnzB1YMV2F7J6v+EwWnZAgIPsajsBeY3UdSDlqIJ3CbjByy
	 ov92bUtoCzdmHxwBXRxMNI9Tvi98WONPEJ0F9ZP7ttdUCHFApKWygl5OyvuXpNmQ2r
	 QgBgyYDfToq4g==
Message-ID: <8744fbf0-46b9-4df9-951c-4f1ddafd7b36@zytor.com>
Date: Wed, 3 Jul 2024 02:23:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] x86/cpufeatures: Generate a feature mask header
 based on build config
To: Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com
References: <20240628174544.3118826-1-xin@zytor.com>
 <20240628174544.3118826-3-xin@zytor.com>
 <df5b3001-e79b-4bfd-a2a1-c63111feba8a@suse.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <df5b3001-e79b-4bfd-a2a1-c63111feba8a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/2024 3:44 AM, Nikolay Borisov wrote:
> 
> 
> On 28.06.24 г. 20:45 ч., Xin Li (Intel) wrote:

> Overall it's better I still have some minor comments which can be 
> addressed only if you are going to make another submission.

I can send a v4A for this patch.

> 
>> diff --git a/arch/x86/tools/featuremasks.awk 
>> b/arch/x86/tools/featuremasks.awk
>> new file mode 100755
>> index 000000000000..351d5a4c7d64
>> --- /dev/null
>> +++ b/arch/x86/tools/featuremasks.awk
>> @@ -0,0 +1,85 @@
>> +#!/usr/bin/awk
>> +#
>> +# Convert cpufeatures.h to a list of compile-time masks
>> +# Note: this blithly assumes that each word has at least one
>> +# feature defined in it; if not, something else is wrong!
>> +#
>> +
>> +BEGIN {
>> +    printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
>> +    printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
>> +
>> +    file = 0
>> +}
>> +
>> +BEGINFILE {
>> +    switch (++file) {
>> +    case 1:            # cpufeatures.h
>> +        FPAT = "#[ \t]*[a-z]+|[A-Za-z0-9_]+|[^ \t]";
>> +        break;
>> +    case 2:            # .config
>> +        FPAT = "CONFIG_[A-Z0-9_]+|is not set|[yn]";
>> +        break;
>> +    }
>> +}
>> +
>> +# Create a dictionary of sorts, containing all defined feature bits
>> +file == 1 && $1 ~ /^#[ \t]*define$/ && $2 ~ /^X86_FEATURE_/ &&
>> +$3 == "(" && $5 == "*" && $7 == "+" && $9 == ")" {
>> +    nfeat = $4 * $6 + $8;
>> +    feat = $2;
>> +    sub(/^X86_FEATURE_/, "", feat);
>> +    feats[nfeat] = feat;
>> +}
>> +file == 1 && $1 ~ /^#[ \t]*define$/ && $2 == "NCAPINTS" {
>> +    ncapints = strtonum($3);
>> +}
>> +
>> +# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on 
>> | off
>> +file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
>> +    on = ($2 == "y");
>> +    if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
>> +        featstat[fs[2], fs[3]] = on;
> 
> nit: 'on' here will either be 0 or 1 (awk doesn't have a separate 
> boolean type).

No change proposed here, right?

> 
>> +}
>> +
>> +END {
>> +    sets[1] = "REQUIRED";
>> +    sets[2] = "DISABLED";
>> +
>> +    for (ns in sets) {
>> +        s = sets[ns];
> nit: 's' -> 'state', though is 'state' the most appropriate word here?

's' is the tag string, "REQUIRED" or "DISABLED".

> 
>> +
>> +        printf "/*\n";
>> +        printf " * %s features:\n", s;
>> +        printf " *\n";
>> +        fstr = "";
>> +        for (i = 0; i < ncapints; i++) {
>> +            mask = 0;
>> +            for (j = 0; j < 32; j++) {
>> +                nfeat = i*32 + j;
>> +                feat = feats[nfeat];
>> +                if (feat) {
>> +                    st = !!featstat[s, feat];
> 
> No point in doing the !! dance here, the value written there is already 
> true or false since it comes as a result from the earlier check. Just 
> drop the !! also what's with the 1 or 2 letter variables. 'st'-> 
> 'enabled' then the check reads 'if (enabled) { foo }'

Sounds reasonable, I can make the change.

> 
>> +                    if (st) {
>> +                        nfstr = fstr " " feat;
>> +                        if (length(nfstr) > 72) {
>> +                            printf " *   %s\n", fstr;
>> +                            nfstr = " " feat;
>> +                        }
>> +                        fstr = nfstr;
>> +                        mask += (2 ^ j);
>> +                    }
>> +                }
>> +            }
>> +            masks[i] = mask;
>> +        }
>> +        printf " *   %s\n */\n", fstr;
>> +
>> +        for (i = 0; i < ncapints; i++)
>> +            printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
>> +
>> +        printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 
>> %d)\n\n", s, ncapints;
>> +    }
>> +
>> +    printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
>> +}
> 

