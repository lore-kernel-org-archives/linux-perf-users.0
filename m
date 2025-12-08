Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1D2857CD
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181657; cv=none; b=LetSsnDtfhEzAJNVF6B/5FnimibbLiKJoyKEcK2P1gRju8pMqhnOBXVnoyxia3TYy4xu+gD53MvBI+ItOPLp0iYA6Ixa2+giZxmmaLGCA2IHGCjypEPDvkeZeqd5kt3UjI/XQgd7xMG5/ZkR8ujOM0Jzr3Zh2swL8IZxnGoa3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181657; c=relaxed/simple;
	bh=zKuBvxyxZJslPOMplhZnuM9Yv8eYhb7wr6yk7mLhsZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U29PFaSq2ReBnW+CRct1yoVsUE5D7excrfpGMCA5E7R+Lzm4CjZkLBuKCA6AvPBiA/fi4wYIuX+NaM8Jnztm/3DL2ehOXO3zcNvYPVf+xLYQ3Tr+hVP3dcz44C4CXs27tOHvXS2ya7y6YABG8UuFYoatUAbyoSc01QOUfm08IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLtaVbqN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLtaVbqN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso1323735f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765181653; x=1765786453; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1991j57Uz3Fn7DkGnXZOz9lVmuzpVmyw3e1zr4rts0=;
        b=lLtaVbqNzaPDlJQH5Q9qGk23m/OFHrNFIWUklG3STuJ44xlsOUnlbToSxhbLuYo4OT
         nVQ1yPFP+SuyBhwc/F2YWEUyvqfsewvZaUP/7ErdoY51i1drN1NZ1YkpV+80ZDlMiGo/
         khIoWKCTHGh9Kd6cTWnE1lVB0snimabfLcbniTPGPfSICRN5vwGbg/tpSUdULQ0GjL4/
         sxQsizVxrCHTrYeqmvpG40NAHHN8LAuxhFUFOahUsqy9ZdOjq6x2Cbg8mI4n51PKo+TZ
         DuuOcZ3QKvmJjXCUnoiK5Xv2qQltzLdaiXvKkWWO2M7qaHyvQb6H0RjC4keVK69tW8oV
         kO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765181653; x=1765786453;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1991j57Uz3Fn7DkGnXZOz9lVmuzpVmyw3e1zr4rts0=;
        b=o/oGjoNaPuA1C2hF7RAO8LZkADtZ0PPadtBTvWh3qnU5W+b1NIDYPuZ6nDNLxKSX7I
         1uHcIeOZPkR8KUahlLbjeWoOtLfYW4dcQQi4yBvR/GYoV158hgGsKRcToRTSuRFyhzpo
         qApZnHXGvapg5UwQW09Hq6/8oLHYZeDva0HGC9HUOgpbRi5cl3WlidGcNtZQL3A+4sDk
         Q3wc7aePZoN+f1KpZiY+Ey4bw2ZPs0IpKmoTMGa6VqV8FUMZUcUoiQVTOcn8+CS7flg9
         LCkooKwNGdKfc1MhiPb5sFNqGomzeSzt5S7UF46hukrrxuTdkQhkRGhaaAOApnWCO05+
         KZ6w==
X-Gm-Message-State: AOJu0YytbVF/kZ05OWOHOiQ6XS8W7tQ5ItxaMQDOkW3d59db9aXgCUkn
	IVWPpMn82nN3dtvuJBBg/EDZuaWXDmpJyJefTYc1A0muVfYztX0gicETTITh3VENr34=
X-Gm-Gg: ASbGncvpoMzNIXV5khAH0+inWIgRgpj0TKhWkcJ594ke1DgiST2iZUyP8ar5FsDi0h7
	jXk82hMPAyxRWBP6JeIJi9tFFHPl7FU2uFQeFGbEzb6F5MJ8iQw5uQ+iAuxPCm2IE9ayhE1Gc/z
	kLJOKMRWsve+x/KSA30KQ8aCOCJOwY0c2gHVABDNfV1BHg4pRQAhU7rSWxbW4H8YySL9oJtfe9I
	lh1mk/8InqG/fEZnUch01DC4H5p5pUi+jZVXVK1/W1zwfutDceZcpvgDsm7jUDJdP5XRlFs2Gvh
	DDuuTYqjHhCRfsudG9+sAa9zHWY+BDglXH7vBm0cRI4wDjDL3KxAng+dJsIhFeqfZah+YEpviNw
	jEKHul9S7h3ycAL3BO0vpF/0syscdPO9a+C+XYFfKV/mqlPIZ5pc32kdmBgPs3eRM6O8djFEBl+
	yabr+EnYj1nyPFc6gH
X-Google-Smtp-Source: AGHT+IENvBVyw+v75lTlgMHU8PIOMdlNNByQUTjHiyI5B9jOdh8IUvypNp1jfzdtKKlHEd8bqfTwLQ==
X-Received: by 2002:a05:6000:26c6:b0:42b:3bee:a7ff with SMTP id ffacd0b85a97d-42f89f0e417mr7068719f8f.24.1765181653346;
        Mon, 08 Dec 2025 00:14:13 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42f7cbfee5bsm24236359f8f.16.2025.12.08.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 00:14:12 -0800 (PST)
Date: Mon, 8 Dec 2025 11:14:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
Subject: [bug report] perf/x86/amd/uncore: Refactor uncore management
Message-ID: <aTaI0ci3vZ44lmBn@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sandipan Das,

Commit d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore
management") from Oct 5, 2023 (linux-next), leads to the following
Smatch static checker warning:

	arch/x86/events/amd/uncore.c:660 amd_uncore_df_event_init()
	warn: set error code if 'pmu_version < 2'

arch/x86/events/amd/uncore.c
    654 static int amd_uncore_df_event_init(struct perf_event *event)
    655 {
    656         struct hw_perf_event *hwc = &event->hw;
    657         int ret = amd_uncore_event_init(event);
    658 
    659         if (ret || pmu_version < 2)
--> 660                 return ret;

If pmu_version is < 2, do we really want to just return success?

    661 
    662         hwc->config = event->attr.config &
    663                       (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
    664                                           AMD64_RAW_EVENT_MASK_NB);

Or do we want to set:

	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;

And then return success?

    665 
    666         return 0;
    667 }

regards,
dan carpenter
