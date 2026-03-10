Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77920233D9E
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113877; cv=none; b=mqjrtkdrAW/BM2Afn7QOoxLOWgHmEeDDetpvSqfmpl/Q650zwuJUxV98I8xWliJEcxoHdNPy0asrxNgJzTgO0fBdG3diDWdDochXG44OE9wjVi2FGaud5Ozqd943Z3WENDZwjeo2MSS2MBQwouioTLWBWxjXFtvhO5iS9DqPKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113877; c=relaxed/simple;
	bh=fHAdq3AOTRUlyMoegZmRVCGP/gYnsge9SZytjjH/BeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnyAziw6iTQDCn9E/7+4ie5vlOm289NmwA4632pDdcmLbpaEhwwOAHBzXKo0sy9sXQ+ykWTP4trsQXRMfDl28QqRa8aU+lTpUSPKBqtg477vWBO9DdZElgHMFcxkyiW0PuHK4jCtG3fPziVCh72Ut+8l6XLqHJUDedFQd2GpEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9/mwvRP; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9/mwvRP"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439af00d33cso9391647f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773113875; x=1773718675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3O9gfhS/C+fzzyiVz/DN7Hm9aqoIX4yPfxjmSLP5xg=;
        b=Z9/mwvRPNLAcjxQ1YcfI6n6aNRPFnX9npLV1S3oyJ6aUfFeNR8GYBiVDx8ORQxEOL0
         kVztxQsd7l+gfb9exZK3Ob5EOKT6dEguimr8g4NBH5SYq1OJjJUOVwHn43ZBJ9Lul9JU
         Uit74q5sYzm7JSGfjivGLhsx3M9xMTrR0K3YiSFURx3iWLWTS2S6zhvLC0FMYHuEZ9pE
         5yb/SNJe1K8gXg9tZYwyCKPA4pcsrb9L5i+frT9yATVH/InovuotoI/RvtO5TanDXyBj
         nSZ/p+dY+6UNuQI6c5Dp5sxMeh978rqGrC7DU11OkU32DgorQ00YvWor2t4mpkqgW0Ub
         gv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773113875; x=1773718675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3O9gfhS/C+fzzyiVz/DN7Hm9aqoIX4yPfxjmSLP5xg=;
        b=ChieIAFwA3R0O9i3MjhEZ5mFatIEZt4yI7iO+H52U1x4DQyeDUzzyV2WDLs+mcS8N3
         ItVc0gqdTWJphZ0RndcOCgj3q8lJZKGq4YMjnR/nZxVMJjdFHMbW7ftglay7JseoLEUU
         nEG1Qa9aJTqf1fYCHg9tZ7/VbyZu3okS6rget6ZGo/xWEhdmenfsQuVnWEkRcTyeKdEk
         ZMSj3u67jORrOxMlzyAX6yS1SqY9ZeGKAldgUE7cyg5EFqLxFjRbs68JzzKbRN5Y5Yb7
         /wx7GpKu7WCeAHPN+k3oLH87itaa/tJnokW6klusIzOR6x/SfZG6Nu7kadoloRxETRV/
         b6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXva0Jd58lnvpT4z40G/xFObbXYTa2Be+nI/5ZXR9+La7rmvOsgnNNJsmXf8Jfwz4V/NAafqT3MrSFeyp40SZsy@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpmhU9l/XiwLcuwxPfhzGGPlu39wX/+8uPJiIKeBLBDqCaIDi
	ZpZZ9usKKm9f/DQoQicHlhiHcGZoIpJTAKVEwhRQx9clTDUGjYotWw+R
X-Gm-Gg: ATEYQzxGwJ2gCmf1ebf4pysoDp4kzGelDjMB3PZOH1iHgAyGbI1/ah1JDhHNAcrYp8Z
	esBM3hfTXjebklrPyOJ4eRDsvMtq7zQu2AfuLG7Ew0+jsr9nQgAcRIGKKk+wZXtGONyBHZFvYjL
	yK+TSMYywnHFi94BtW0Orax6BWxgkXdsYo8ckPlU5HZPlmubMXB3OLvYMpQRwt5w+VMKJKWGIOg
	efZgfUEAlczTUkHsAgMRtYEdisKeEMWZ4b54HCOLcrwr6c1UIEJfHXQ5eP3Ng5BTlXn86faVpPD
	c5DlbLIfdA9iESWeOBS0SM5dbQ6/CedBbaRKseTn2vLLaKldLzpoT7aA0E6SRjZV2DBseY0HD4Y
	ypDlQbGm+YAje6l6JDsGkbAKvAvXrCbTp6v+Ald2LBV5dytxVkNsb5jVmLVYBq2JBCLtADC6UTf
	NJzzJ+eJGd+n3zBsotWsCTm3LPnXyMcCxe/DH/WBuXmf4U26YsiA==
X-Received: by 2002:a05:6000:2003:b0:439:cd10:aaf1 with SMTP id ffacd0b85a97d-439da89d477mr24263538f8f.53.1773113874639;
        Mon, 09 Mar 2026 20:37:54 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae57c05sm29700525f8f.39.2026.03.09.20.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:37:54 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: irogers@google.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com,
	wangqing7171@gmail.com,
	yuhaocheng035@gmail.com
Subject: Re: [PATCH] perf: Fix deadlock in perf_mmap()
Date: Tue, 10 Mar 2026 11:37:42 +0800
Message-Id: <20260310033742.3606390-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAP-5=fW3jcUyOOF5ikEUHbp8r=yMZE=iUPVesUhcba38T8ayZA@mail.gmail.com>
References: <CAP-5=fW3jcUyOOF5ikEUHbp8r=yMZE=iUPVesUhcba38T8ayZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Mar 2026 at 02:59, Ian Rogers <irogers@google.com> wrote:
> Hi Qing, thank you for looking into this. I proposed a similar fix:
> https://lore.kernel.org/lkml/CAP-5=fW-wHEv=TCULwk_HVOhWHdqRd8AZoESZsU_vnhLjghUBQ@mail.gmail.com/
> but Haocheng noted it reintroduced the race condition the original fix
> was targeting. Haocheng has a larger fix in:
> https://lore.kernel.org/lkml/20260306093616.84299-1-yuhaocheng035@gmail.com/
> that should handle both the original race condition and the deadlock.

Oh, this fix is too large.

> I wonder that fix may be made smaller by passing a parameter like
> "holds_event_mmap_mutex" to perf_mmap_close, something like:
> ```
> static void __perf_mmap_close(struct vm_area_struct *vma, struct
> perf_event *event, bool holds_event_mmap_lock)
> {
>    ... // code from original perf_mmap_close
>    if ((!holds_event_mmap_lock &&
> !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> ||
>        (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)))
>      ...
> 
> static void perf_mmap_close(struct vm_area_struct *vma)
> {
>        struct perf_event *event = vma->vm_file->private_data;
>        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=*/false);
> }
> 
> static void perf_mmap_close_locked(struct vm_area_struct *vma, struct
> perf_event *event)
> {
>        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=*/true);
> }
> ```
> 
> Thanks,
> Ian

LGTM, your fix is better.

But, can you explain why there is still race issue after applying my patch?

Thanks,
Qing
