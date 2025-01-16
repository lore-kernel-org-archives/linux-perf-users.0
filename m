Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630A1DE3CB
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027345; cv=none; b=j06LNkD4pH2IhhPz4M6bYz6ZO+B1jbKAFSW+OtXKXBD6Y4fdKOLAxY0/YeNwacnYYxpd6gsT5+MvYKRuTZKbUVWBZDiIv6BaUgt1x9cMmKHOwJyoFJ+x7Bku1osdGQIOZriP5UsFb1+Orh5Rt35O7X2gR1dLXl6kiGsE7uED30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027345; c=relaxed/simple;
	bh=4rScqGobGnb4mpIlFYLwvBzWFz/YxIvFcWlI5EGHYXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OutQWfW+h1bn9FI7bMMLB/SbapdQvvR29DG9CFZ7hBF3hZRBS0j+fbjtriuv8Jo290RMvTVTqrxd+WVsB+QLNJ23hnwlRu5QBTbIXG9OcuD9LQchDyMfnRAjPKnOlq60dGFrOMLOtMngZosRT7Ww8X9WtLk07iV/7TRrE1iJ41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmI+zVYM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmI+zVYM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso4677715e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737027341; x=1737632141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+IL0+GOfzEC4aeJWJbSxSpruqaLU6cR4sD7yZTPtTI=;
        b=ZmI+zVYM2cDreQMpPos69d4v7gpYC+D0SXHp0k2o/i9y/0cOU1pN7IazeIhxhw988C
         tfeD6FaH7GanmGMAmcorD7SJaoFy1fg3D06ZL1HScpfTDbTa3917UusxbjVvG8axVoqz
         7TZc+H4WtunoUGhCVRhamX4UM8BWlUOElzhx8BEVS+ergM/Q1/OaWNdDlunyDUQtNvL6
         fhaMopIxof1U7aCZeOH/UnF7RT7RO1FURbc9LRYQqVDU+7KE9rl7NEV8CpdbB1DwIHEQ
         IdNn+6XJZTvOpwPHQ331SFecW/FxJuVWhEiTVQnSEHce/sAMXvVdPo68hZefoVa7Qe+N
         yniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027341; x=1737632141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+IL0+GOfzEC4aeJWJbSxSpruqaLU6cR4sD7yZTPtTI=;
        b=GVPnGWjgi+AnLoOIIi5cf+j29UyaRnqU1pswdFjtY19UgWlvEL2HQJBf8vqZ8LDfoo
         3AeZKwMiKkRwwutlmis5UrUXnm6SNPDDQ//uiXOdzq1PDJ07ZxlvrNlyNS3VAqMuEhAY
         PU8UF4h6ItFl4+k2qT0bzIW8f4hj+sAnbeGo9aWHkBbDzVgNy6guU8UX5VZ4WfNV+Y4W
         dEwqTJz5Hf5moDvpWjzooTQmvUqKSREfd25PQlfFklecfg6B1b9RPv+j9Kv0kC21A0lB
         p6OkpD1Ra/27qJikh+P4wD1Akpo11KbRdzwAr70WfLRbPnqFkEf7YpN9zkchap5h+gyh
         wzJA==
X-Forwarded-Encrypted: i=1; AJvYcCXGFxUSuljIUBP/yrkjBaoLHZmewrjQUaVrFp3ZNo2qSj6w+YiCIjOsh+WxohqbLhI36L3Cd8dyxz7QF8cXAIgz@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbIKdlAQCaSrIcnI/h9MIEtAqGWNxW9qY3I1skw5e9UKcNhIF
	AtOrg2INqlmJGL6VCmD6kdM2hxt0nrYwbpb1wgnoiHKTIkS985fs3XRm7bZ9mkg=
X-Gm-Gg: ASbGnctQPtKGsiaXDFx0WTuLjDw8RcoM9XeGsBUwQhecfSH6ISLNFD6VR4AEK+k4U5i
	oT09vjBNSRe/Zk6xdgso2J0n6/YFeavz93nMkZ56fkxhY2Ywf0MBD03GfpQqvj4BV4tftn1sN1S
	ZUTHSO+6zjUUgFb0Bbx6e+NEFPxC63ZB+1ydFKS5OmmuTyG5XSSbCWETdPPtG1xuPRjGNq56m7v
	/k0o1xOsJbL4VihugMDUzh2QLc6Q3O75i5R7A8RgX0TCFRgo/G0+deh28NO1Yz4KQ==
X-Google-Smtp-Source: AGHT+IGBydE7n4ukQMxeJC/IohCUHz/oBS4d62nahhto5e93jzlvZ4RUwir6qAgTxFQnHx/YuIXhKA==
X-Received: by 2002:a05:600c:3c85:b0:434:a1d3:a30f with SMTP id 5b1f17b1804b1-436e267736cmr270167985e9.6.1737027341348;
        Thu, 16 Jan 2025 03:35:41 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm20597123f8f.19.2025.01.16.03.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:35:41 -0800 (PST)
Message-ID: <6d3dd8f5-db23-402d-b7c0-d8264bb5a045@linaro.org>
Date: Thu, 16 Jan 2025 11:35:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf bench: Fix undefined behavior in cmpworker()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chun-Ying Huang <chuang@cs.nycu.edu.tw>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20250116110842.4087530-1-visitorckw@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250116110842.4087530-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/01/2025 11:08 am, Kuan-Wei Chiu wrote:
> The comparison function cmpworker() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
> 
> Symmetry: If x < y, then y > x.
> Transitivity: If x < y and y < z, then x < z.
> 
> In its current implementation, cmpworker() incorrectly returns 0 when
> w1->tid < w2->tid, which breaks both symmetry and transitivity. This
> violation causes undefined behavior, potentially leading to issues such
> as memory corruption in glibc [1].
> 
> Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
> compliance with the C standard and preventing undefined behavior.
> 
> Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - Perform a full comparison for clarity, as suggested by James.
> 

Reviewed-by: James Clark <james.clark@linaro.org>

