Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154843A1CEF
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196469; cv=none; b=TloATdzeNsmzEeSYxP9Zw1HHZfovw+nTjPGTyaD6ARA3EnaWCUfKu3Zd2Gmz9U3DltxnnVDAQfg2EEcHaP1PdBwHIUEtUbAad2+3v86kM6WEnI64HnaAvV/SObsSXtsJmAoMPbYQ6uhZADSJM1/hLaMGOcJjkzGQCMb0juJjbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196469; c=relaxed/simple;
	bh=sc27DwzzgfFQTFrQpnFL01JAH1HWFmGBXG321GfI0hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWfh1yeL0Qe2SLFUuj1LJQJPHpdJJweLQtl1JgFckvNYzmqxIiHACnWtY5zGsvRbODFxubVPftoojsni6RkQAtXglmGuQJWtmojTQPSdpRTujkSAr261N+SNkXJVA+fQEfJr64hH5RIqOgCtNyyMIGYZ6tBIlPLA95ARoXnrCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3JvLS9p; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3JvLS9p"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34abc7da414so4106606a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770196468; x=1770801268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uygNsZst5G+GJw8qWQt/teS7lcnQtwFewRjz4BVhmDU=;
        b=T3JvLS9pLVDYgvxvWKRNcV1GY4Oo/3v8w5vpkRTM2if7WMdoPZg2Um/rzhhwrEKZB5
         T/zcONGV4/Ptck+kS2bPqQslHhQmJfwZg3DFHptlFQKOvN3nH/9wxDw0MRiu7ay0dQW4
         jKcrYqzdJgcvZEbOeF7ik0S8pqOJrqYIdC1jRy05OTNOOZ03FS+rJMIyiINQg88q2iYF
         hLmhnu/nTIelcdMGdqkaJFgoeW2aRWdFauOzFLeTvZvVILe40xLdpK3F3RsINJllFZVJ
         klJPcivZIs2rEsdF2ayu6qaZccQu0qSrD3/XSuFjfznGozDFP4STSPLYR31QESAZ2b57
         Qxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196468; x=1770801268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uygNsZst5G+GJw8qWQt/teS7lcnQtwFewRjz4BVhmDU=;
        b=tr+xthKEhxzojYIk3/IpOUQZRtlprZ+ICOaZubuyrknxch61Y8kwcnppcPmbmHhHHz
         nKfb36ezVzXAV2jNVDjZpaB6s5bFLM3KOMI38lZmyWN1sgw4tZFpt9zun/b46cfK5DMC
         T//KMdXgj6Jwf/pjglU/jNQ8PZry0twfhxc0htFxkm6UYIxX/iwepdR7FEjph6LvLJMQ
         xw/MD6sVzIPVeJaWMD4Exd5wkQZ/ldMHEwH13lkqNkwnW/Qk+vgOuDgo/Fr+aePBLAL2
         9ppOUjpCTxdyBndD8gLQKaKbIHqJfWRF9ToYjVnXwJsPt+sHbQjvbJWhFn2uQQkNWMvy
         sKng==
X-Forwarded-Encrypted: i=1; AJvYcCXLXi5JNr1oDuTbGYqbz8JfxjV7jU+Xa+9Lic1I9XW6B64CjOPVkIyaZxOxoxlSRhAnFhQgtbGc3KqZrnsLImDS@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqjiWgekyQwXiy+hcS8uMoqHPy1kvcx3CkIMpiO9HV1/k/uYJ
	w9yf9JTmTmrqarQsXGHCKEobch/tE+0GPHOE/RbhcB1kp5Q2BCIdXICh
X-Gm-Gg: AZuq6aKfDplUfzBB98cANtdd1KDp6JGc5FDvgJ6yWAjpE8dMppE7lbtVxZ5NKa5duvz
	Zy3l5BR79Kot6xYD1+ntl+JVsSHYYzh7qfyeWivTbmCJ5+dGt5ebpwzMGPsBitY5wZGxpqjjHAq
	YYO//CItccILK1uTq1V3Cw6oOeZbC38+0q1JUqAU7RSUxp3XAA4Jr5CuaDDfTwlm9dgeYp7Xroc
	tyiKbb+mKOD8YNgeyQ/lcjQWFbbWFnNqb6bUIeXchgbV15TaO8774TIlg2rakwCfnIdNGqgIEne
	DZ1NEHNuztj6l8WHDFQ7H5yF8e5C38+Mm0xVfwyUu3P6mqLrCtOnQUlbhgd5i+rCo3d5Ft446oV
	rrLq9TVi1pomx8sj0wLglIvNpn00hvO93WFIU83mzNE8fTFnQEZN67sreXtEZq4mcvySkk1c5Xh
	HQzBtKALMI2LOEgbnIssWyyxUCKUAqp4d1TgFvZQ==
X-Received: by 2002:a17:90b:548c:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-354871a955cmr2463472a91.23.1770196468414;
        Wed, 04 Feb 2026 01:14:28 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548630ed2fsm1996984a91.16.2026.02.04.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:14:27 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: acme@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	martin.lau@linux.dev,
	peterz@infradead.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com,
	wangqing7171@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf/perf: Fix suspicious RCU usage in get_callchain_entry()
Date: Wed,  4 Feb 2026 17:14:19 +0800
Message-Id: <20260204091419.887114-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com>
References: <CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 04 Feb 2026 at 08:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> rcu_read_lock/unlock is not called when may_fault == false because in
> that case BPF program is already running within rcu_read_lock/unlock
> region. So I'm not sure this patch fixes anything really. And even
> with trace_in, if we cann rcu_read_lock/unlock one extra time it
> shouldn't be a problem, no?

Thanks for your review, I agree with you. My patch is incorrect and there was a patch series [0]
to fix it.

    [0] https://lore.kernel.org/bpf/fb745675-e25c-4dcc-be4b-4a4411056755@linux.dev/T/#mc0fc5e0fec2e6456f72f402308fd4e397ba19d09

Let's forget my patch.

Thanks,
Qing.
