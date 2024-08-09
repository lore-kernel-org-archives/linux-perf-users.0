Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F81946DA
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Aug 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206567; cv=none; b=Mp0D1UIRrmUqshEe8owjXf9yZwWBFLp6LC8UYC2WVtJfgSS+UCq2Fn2hB97YmZ8tZOB5Kwgu0+ns2FBV5nBRnvTwng5xsog4p+EZFCZuyZYjENzWoEWmgYxnhzy8TD7ZLOoYGVJZefYrjZ0+IEe05ICBGPrMnPIe/TmYF5lfaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206567; c=relaxed/simple;
	bh=BU+WGsl8AvAp7jS3GHKjmTVYbPTQN7nylpAGie+GXnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CP79HTxoKeJiln07E72QLq12rsw4AnyyUiyOfE+AongmfLYYn4UtDYIh9jqEXEnw/jQU2HzjLsgzj66CFfIvE3+A+emss95wmJDa9qYDGewzpnNBtlPt8RYRqzrif18whIY94KldHwRmf+7LlKxRJwpyF3Q9sVufIoPcoZl4Q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pzJw9wYj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzJw9wYj"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aac70e30dso239782666b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Aug 2024 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206564; x=1723811364; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUk1lgVZl3D8TCEy2XTXwDR416eCE/3DhdhxQhM1i2k=;
        b=pzJw9wYjs7zpSmjTIgrBg4w9RW8JVmOyh2CtRyIrMi2kik27A7ciBW0wrKrO4yyTpo
         YUtGYvjm09fNnErCoYdPN04FLWy9PQed+ngDsw6ObkUEfYJk60pK6QBVw11FtyEqRed1
         m76wpbv2XCqxCam8w7eTPVK/ewPBxjyxTuqQ75Wb1eTCbx68LSF3kIOR5UTya2MGJx6Y
         4FSRwGZrKj/Zwsm4ZRdPHVR41G/H3NIZA43Et6+vZKBPprXzi0181EWlMB8LE1goLXHS
         qpPy3ockM4ZdjB1thhd9cvUuVZ3svD4qy0WQ6L+vsBYqY5BznMT9rp2c+D1cb6vmObNo
         8IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206564; x=1723811364;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUk1lgVZl3D8TCEy2XTXwDR416eCE/3DhdhxQhM1i2k=;
        b=fBf1N/UTg88DOY6IqMCVtISwV4vzTmU30dKhRk7DAsHhI2JvEUzerHGBvpd3x6Tz6C
         E0U9SKRAiXRNZv4LGIzYdks7QdpMDYifiKh28Ch/IURSrUmHwQFUFbO7LtLIMN7erCJe
         Kg1Jrh6RsmeVuNBZGvMN7dsX/pMB3BEg8t+iZMo85cePdJUiWw1TsOAsOplpW0JBIJ9g
         emfuQ9X5CD6ugCP8wPEDGKu6IxPdRIpjvS9J71Ktg81eQ5tzU43ThMQFMTNp4ETkxyUB
         GAzNYl9JC/0WkCAu8XsKo791Onyq4tnzP1Kg1IK+jIAl9TNN33si1LyI2ZEn+YFG16v/
         SM+g==
X-Gm-Message-State: AOJu0YzCj+VNs5VrAoDH+xYHeO2rQyqek0TEFKSXbDr3MSUYoEm7ixT7
	YuCK43qiJiTc8aJHvc7TU2fNbh/g3Zcst3dc2Ae/qARoXW1igC/1JM9gVF4uKpI=
X-Google-Smtp-Source: AGHT+IF6tH1jpR3Lkr+Klb+s7c/hVkhKOEe/XKYETZNaY6yBaYGt6LYFNWWGk0/dPzLNxLBmssok1A==
X-Received: by 2002:a17:907:f183:b0:a77:c330:ad9d with SMTP id a640c23a62f3a-a80aa6d3711mr121424866b.61.1723206564179;
        Fri, 09 Aug 2024 05:29:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e8383dsm846734366b.173.2024.08.09.05.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:29:23 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:29:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: [bug report] perf lock: Print the number of lost entries for BPF
Message-ID: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namhyung Kim,

Commit 6d499a6b3d90 ("perf lock: Print the number of lost entries for
BPF") from Aug 2, 2022 (linux-next), leads to the following Smatch
static checker warning:

	./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_begin()
	warn: unsigned 'pelem->stack_id' is never less than zero.

./tools/perf/util/bpf_skel/lock_contention.bpf.c
    360 SEC("tp_btf/contention_begin")
    361 int contention_begin(u64 *ctx)
    362 {
    363         struct tstamp_data *pelem;
    364 
    365         if (!enabled || !can_record(ctx))
    366                 return 0;
    367 
    368         pelem = get_tstamp_elem(ctx[1]);
    369         if (pelem == NULL)
    370                 return 0;
    371 
    372         pelem->timestamp = bpf_ktime_get_ns();
    373         pelem->lock = (__u64)ctx[0];
    374         pelem->flags = (__u32)ctx[1];
    375 
    376         if (needs_callstack) {
    377                 pelem->stack_id = bpf_get_stackid(ctx, &stacks,
    378                                                   BPF_F_FAST_STACK_CMP | stack_skip);
--> 379                 if (pelem->stack_id < 0)

->stack_id is a u32 so it can't be less than zero

    380                         __sync_fetch_and_add(&stack_fail, 1);
    381         } else if (aggr_mode == LOCK_AGGR_TASK) {
    382                 struct task_struct *task;
    383 
    384                 if (lock_owner) {
    385                         task = get_lock_owner(pelem->lock, pelem->flags);
    386 
    387                         /* The flags is not used anymore.  Pass the owner pid. */
    388                         if (task)
    389                                 pelem->flags = BPF_CORE_READ(task, pid);

regards,
dan carpenter
