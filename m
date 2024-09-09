Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF94405
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848136; cv=none; b=KHy30qdd6n5qLinUmGbodSGNw4rS+3zoUCH6cUCWY3toZ1400xBcKOjuO8GbChFcMlbaE3gkTTVeCNA+g8+oeuhYuJXuFpS/VbM4fu+/9Y9j65uJ4ksUSuSdtNWj41aixCHeL9K3wSvqWYPHtY7DLhNQ4uPNLEbYeISMd0BQ5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848136; c=relaxed/simple;
	bh=/LOorNelw5K6LsGZAXAl2ZaE2Att8l88gdP9meKzMgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a8XLIvcj6N2RrmpGfsaspUlPpzA6OsXScZTjy7HOJM6B+rezbNSCxXrVctqABMmc6NVdzKhuy55A2SVMDcWuIHEbNyQjgX8uuBOVv7XEqVeVlW476NK+HRj0QVDxugvhU9bBR2cg+womOj38YiS0BIllfhMIshaFGZG9mJ4Hlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Rf3qmMp6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Rf3qmMp6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20543fdb7acso26353385ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Sep 2024 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725848134; x=1726452934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kycz822BWcHQgVzQmfVOMENr3RqEtpWbF7qRzT1Ov4o=;
        b=Rf3qmMp65n3WMXtub55essnUzQoVif6CV5y7xa13Dev5TCdku+9P95WWxNM1p2arVr
         iHNenU99sooNWPNITvwvUUck1aU/5znNT0AiSjaWdodc0YCS0LaeBsrawn5TZDSE2yNh
         rN6XVj8PdsQ4FZ95XbcYaBKmodLG7kdYfGrPfcaTyw3I+EgoNWYrSy28ESEgv+20QyJ0
         NvIZrYaTzZ7+twQbqpTJB1FWnoMis5Uz/HmyFwXOitUf/PB81UHk+xbR/N7FDtHmWxez
         pSZdR4Ag7cJcKXLz6FB3+52VS3TArGb8VdCSuZUXGLUgtx1WJddQdt3J4Er74etyr2Ye
         3Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725848134; x=1726452934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kycz822BWcHQgVzQmfVOMENr3RqEtpWbF7qRzT1Ov4o=;
        b=k6VGttQ1WevOExilAF7drSg3AnCNPQsiA/gMnJE/aA8WpMqT57UdwPLiBQhNkXF4H1
         oNb5xbrkVbOI622OT+wS3LF95dvSlMTIRpdDdvWe3IziS+4veIJ6UuvpNLCIETLQJEcp
         i1KV0fLHvGpa7U+HEFOJun2HSF3B18fMOD1Vpgx9aq+uSBqkUIEU3LbpaXYqwbZ1NrU7
         hjGPULvzH0GYp5yqYbr7jlxCs1yw4cliAizNDyqCR/tYF0rEUS+CDEtEelDRz04MT2BD
         ji4bOOfEYMgORGvZHYpCFjnnWU0cOqxJex5uanau6qVyWE9b1cI8oCCryCAfrbFJjv/K
         tzTg==
X-Forwarded-Encrypted: i=1; AJvYcCVmmO+1wu6nPhBmR19ZUzXKEe9jJbRV2uAVWHgpFg326ZWa5Tp8JTWhimrt9wafzShkCF94qeePgqk9uRZarz/C@vger.kernel.org
X-Gm-Message-State: AOJu0YxmlgtZadlKWXeR3JU7eIDf5XWDHV4Nri/47ZuJVblhgxROL2iA
	duGJf6cN4ofUqNNByXX8WEljc5uVspQhCUZVAwfuCKIdFwZWAnu7YStkhk7vz0c=
X-Google-Smtp-Source: AGHT+IEXDdNuaMBdc+/KkajIoBKOQjSXV7wV6wsKWkfirg+ejF8mkgtn4hEdz4bBVIWxseb/r+4QeA==
X-Received: by 2002:a17:902:da92:b0:206:93e7:5845 with SMTP id d9443c01a7336-206f065bb9cmr70776625ad.59.1725848133817;
        Sun, 08 Sep 2024 19:15:33 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20716f1005esm22477885ad.305.2024.09.08.19.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 19:15:33 -0700 (PDT)
Message-ID: <32df3e10-994d-4966-9f8f-e9b736140ded@bytedance.com>
Date: Mon, 9 Sep 2024 10:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v3 0/3] perf: build: Minor fixes for build
 failures
To: Leo Yan <leo.yan@arm.com>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807032019.1828674-1-yangjihong@bytedance.com>
 <b5688d4a-9389-4998-8031-3f002302311e@arm.com>
Content-Language: en-US
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <b5688d4a-9389-4998-8031-3f002302311e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

PING.

Are there any other issues with this patchset?

Thanks,
Yang.

On 8/7/24 15:49, Leo Yan wrote:
> On 8/7/2024 4:20 AM, Yang Jihong wrote:
>> Changes since v2:
>>   - patch1: change LIBDW_VERSION to follow up the style of
>>     LIBTRACEEVENT_VERSION. (by Leo's suggestion)
>>   - patch2: Use a new line for the -ldl dependency and with comment,
>>     synchronize tools/perf/Makefile.config. (by Leo's suggestion)
>>   - patch3: include header files in alphabetical order,
>>     add reviewed-by tag from Leo. (by Leo's suggestion)
> 
> For this series:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
