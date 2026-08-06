Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A973DAAD5
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018665; cv=none; b=VOU70oiq/0DtDU/hVTZ/HgnLhl6r+p13LNhi5drTjXjbYMkF+0tBSxJlSL5nT+3L3Cay9/l6XGgEalzfKovQBaASu8pnDtH5HjHmLBCkxZa2f29gENfv5gGg9yIw6PQMbxn58p607HSFfoSdQe/dt0DyVR6gehk4K5v9JAo71P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018665; c=relaxed/simple;
	bh=HpEBgmUukeV1LXk5+LcGMi+zqd8RJDlMAU0SwNUG3cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erUZRdxwdz7X2/7AiO4flBZ2EQ9PNKSQ78zFCZiM8kUvMqvmgJIj7+qsPc4zSSGsCumozd2oi5iPYOjBhH/4goMWESArTIKMpqez0BL/hSWThzr8PBqXnqVUZMyPNWzWVfez1ryY+Y3LUPO7waz89p0CgIdGTPOFOG5L1HR574A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzHa58ND; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzHa58ND"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954aff6088so21588135e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Aug 2026 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018662; x=1786623462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpEBgmUukeV1LXk5+LcGMi+zqd8RJDlMAU0SwNUG3cc=;
        b=LzHa58NDJ6OOt4eZgG1WC0l/K9I8btga0OBbF7aLzdEqd2LJxvfYY8x1/Ft3qVJGXt
         +Zjo/7zqONbMwvkB59rApQMDVQaaV1HyYdZmiPCgKlk26E9Ygpe1Sefjmmv1Cjy/u8ck
         RY1rfWn7L88CW4s4wRZkqYuWr3KVxRSHsmwuLH//zKh6/8fKJqhaBVSwVDPc8RhDFU4l
         puyrmRwhxMH29zgrX5VUTzlPiPuloLocsoN/BRCqKwGBl51kguCjNR8mUY3odH+1jTTO
         brAMubTH1hklnbe7jBNzpNbi8ZlGA0sC6iQKXpKcGdKfU8BjMOVCYPd+YTfazmTxja3q
         D50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018662; x=1786623462;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HpEBgmUukeV1LXk5+LcGMi+zqd8RJDlMAU0SwNUG3cc=;
        b=AwBLvoLZmqCMxxLXJRG6EVbbbslpBYR0+ssNBy9x1KT4BkdiPoveqYPDIMTap5mtkf
         5rhImv9csdctU+GzxBmmQN9aX5kSAuyc8ELITyftge3O/n9F00N2ie4JEJ2y0+QbGb02
         yv5hJr8R+5UTdPmzihY0QH4ODQvYWLm0ulkfzBG5Mb9CPbXYHJ36znw2BF7n28M/2GH+
         tPAG85jdo8hCQtc4fKjjxzSaxdqWS3KlfDtllQKOh+2HNHKqo4ilwRML+VcoFEkTluzI
         niyNfO3INZMSYZ0UyTwMmARUqm9QBUlfzZQULchWQx+/14L/e0IObXX9qmUf4dUvsQOM
         NzdA==
X-Forwarded-Encrypted: i=1; AHgh+Rpm4HXwHzeIXSIQlTPcBNAqMDXxkbqscC926yn28usbeQQ5/RReZkmSD0L0ancMpnrwEjELbmKs00jz/TvvpAEH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhtw5/1qT7WTJjyLZOwcuxFbhw68NFd3Jg2x/rPt/8ZPaMfgzb
	GLFbPsBYzhQBxyX6k+AJTgLpgcihLoNCWruw2rZw4vdwHNb1Nf/nNGzK
X-Gm-Gg: AR+sD12erFxO/ocTHTPEMKdT+HxdghFom5mJkPvPBlxvzK4yRmG5fGqGFxPhHesL9Wl
	p8gUkA8UNNPGoABJJJctmnef9l8GTL79gCRkNKQcXeNkFts5auWTM5jvjCCKNzeFKNV8HmkMS78
	7bpmZYJmtsSV2PU7JU5kh5uAOOzXkfZJ7t1SEb47KHW62v3riMQ28+uOl770W9LB6szQx2jmBcV
	EynE1d7W3SIDLffkJ0F4bc6fsFplatFDLAFSgpaDxRgeg4Dq0AzVnT8f2ckuVq7uzo+hVkGyV0X
	x5GIeQEZUM/vW7CJGTGG//CCzZGF+92CfVvLfJqxXRjK6tOze14TW+GJblrBrypznBR7uYtb9+i
	L3B2svEHfjzS0/5wjfy45dEcUK8Q9o0bpQlP6R4tFE0GnnlRM3G7NAwNuP0Yl5RR8UUcT4KGpm9
	6lOwhFjJU1n8seEP7bX5mVeZy8Io+4zrksnP35z7dWKvPtoboJ95Ptd2ycX/tctGzhinAuSGQVk
	kk8RIy7tID5IoIl+gKu+l2kg8mhizKeDFRfUf7iXyp65iIchjQ5KAQb2UH2kaRkyA//eV6nrEIB
	c1qvLDXQ2NM2UDF3ut0c+NUs+RhTXqvPyXAPVnu3qhFNvwaY2wQO2uKoZ7jH9/sQ2EinmeEzXC/
	Nl5vW
X-Received: by 2002:a05:600c:4688:b0:495:6bc9:62b0 with SMTP id 5b1f17b1804b1-4994e7d1487mr181162855e9.17.1786018662024;
        Thu, 06 Aug 2026 05:17:42 -0700 (PDT)
Received: from [192.168.4.26] (c126-188.i12-32.melita.com. [141.8.126.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e5192c5sm124764745e9.1.2026.08.06.05.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:17:41 -0700 (PDT)
Message-ID: <dd06f979-ac82-4331-b888-c0ff2fea7cc9@gmail.com>
Date: Thu, 6 Aug 2026 14:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] perf tools: Fix memory issues
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
 <anQXwT3fD5oZDWz0@google.com>
Content-Language: en-US
From: Michalis Niarchos <michael.niarchos@gmail.com>
In-Reply-To: <anQXwT3fD5oZDWz0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Confirming that the issues addressed by these patches have already been
fixed in perf-tools-next. Please disregard them.

Thanks for pointing me to the perf-tools-next tree — I was comparing
against mainline and hadn't checked there.

Regards,
Michalis
