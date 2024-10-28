Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBB1DF968
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137759; cv=none; b=ezR4dSuqP+q1bIj5HyAxuFYpTUyQkzLRJINYzLK3vkkJFfi8bgwN8KjMbFdLABLWohTZb8mlFl9W43M+10+kcMiB1GMXrtsDN0PMtQ76Zscc9y6Jb4eZRK++uITNqZTTEfChd8l3qDGn+5OyJIMMTl6skSYr+y+89atWE6GgrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137759; c=relaxed/simple;
	bh=T6Vw1W+O5GAZdK8QfEXE4kI9AY58LuzoNmjOOxhzHwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRCQ/54FcZN+mVQgmBDUxjM/tt1kaj05Oc+t4pbb/68YJ7UsloR8f33wM3b3RVlr+1reeAQi1uPzHDyioTseeAfLojumvCaQfo6cR25XXBDXWttWgC6fC4MwFh9xlsjaow/n7oYu3xgJ094U+PczJkmWmloPIWhPGFpNoe0FC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Helge17h; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Helge17h"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5417f8d4so200146b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730137757; x=1730742557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvbUn4XK7v5ZQErbtSBT8/bUsLUj6/+NN2KmVkiw11Q=;
        b=Helge17hjyAM9lNexgtEI5KGGLGz1UMF/bPsu1dzDaxQK2cBpyG0h6Gtr+Rhzj9oWQ
         /Q3RKKVswa5rMecKCied97go08iWSa2qVRhXATiM7BKjNHUXBr/jE7PHZWdJo22RwFLM
         cDLtRFCvrxD5SJ85KWlgGE6HyWsn5nIHva7O0hIMn6O59JyhlScZpJb/FMpT8yalswps
         zwbH4FChTiUwXiROfSbGJjYEsZRIG8nDOuCjMU4kcqzfi1Q/OxkqaZ+l8jm+y/8S2jgi
         +JhXmn4F6dEI2aFRXSlUAsYfST61AJ/AeZiG/Karjw0/OaKltUVQUnbTZFRYpe3FImTj
         Reig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137757; x=1730742557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvbUn4XK7v5ZQErbtSBT8/bUsLUj6/+NN2KmVkiw11Q=;
        b=sqYmQB1CxIT29JriHM6TZbtFhr9qDrnlYnLo8doJ+q9aYMVYUFdNdlBKgcqoD6WBMU
         Ni8yLeqjHj1HBCmqQOafdCICBerfqgkhrzQeqeb1bciY5nyZphBXadRhVJZ9hZSJECg4
         +JiZ+6AXl32RyHr/WJnLUGhVRxn/sWlm1v+mvRyBqMgFOyUnFcu4F/4dXnP1u24wDlvb
         Z460+aaStXX9y8Nj7HMHmqen59A/sOgMJYBjiy4QUo19hZBP02TszbWMXZ9JNFMfixqE
         w08hopNNPM6/ghCO58AP3WjFoQoiJAcC96dyGUGqTP2oTDJCChA2zokacQLZuEpr7jF/
         r6hw==
X-Forwarded-Encrypted: i=1; AJvYcCXhKR84u4uLZpNuYrnxKI4YhlyO0J+bZ5ypH6QM5M205yy0Psd3W+3qQfa3XRv3ZkknH3+9It3podSpDhuFcaQC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27chBg7yteXKTPFI5uz0DMZYjA9+Eab7hxDeOteXNnv5cnB2u
	EZXsIod1uWNlK6zC3L/KyfNyPpurarjuB/mahguqa6lX2iesh4Gm
X-Google-Smtp-Source: AGHT+IFx1x6GQoyLiQriPhOqnD/UIRgDEVeBu/pQOFU1mcVNup530Bm0m7+x7cgJHdDe+p73y3JrlA==
X-Received: by 2002:a05:6a00:889:b0:71e:770d:2c00 with SMTP id d2e1a72fcca58-72063020e78mr5525517b3a.4.1730137756755;
        Mon, 28 Oct 2024 10:49:16 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c0e4sm5973879b3a.191.2024.10.28.10.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:49:16 -0700 (PDT)
Message-ID: <67f275df-2ea7-41db-a77e-0887811598e4@gmail.com>
Date: Tue, 29 Oct 2024 02:49:12 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 Ian Rogers <irogers@google.com>
References: <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
 <ZxlwoN57PF_5YX0F@google.com> <Zxl5sduEDnoxEmd2@x1>
 <533a9e5e-b320-41d6-8d8a-223f69d719f5@intel.com>
 <3a6a3cab-6d4f-4136-97d9-3042279eb7a8@gmail.com>
 <20241028-loose-beige-goldfish-acefc7@lemur>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20241028-loose-beige-goldfish-acefc7@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Konstantin,

On 10/29/24 1:22 오전, Konstantin Ryabitsev wrote:
> On Mon, Oct 28, 2024 at 02:08:45AM +0900, Yunseong Kim wrote:
>> Hi Adrian,
>>
>> On 10/24/24 2:58 오후, Adrian Hunter wrote:
>>> I would prefer the source.  Does anyone have that?
>>
>> Looking through the archives, I found a source version that predates
>> September 30th.
> 
> If it helps, I've uploaded the latest export I took before the shutdown here:
> https://github.com/mricon/perfwiki
> 
> It should have full history of the wiki edits (in theory).
> 
> -K

Thanks so much for the sharing. This will be really helpful when I
review the documents!

Best regards,
Yunseong Kim
