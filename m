Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910332D45C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599068; cv=none; b=RIbxn2bipDh8VtlFS/3lbn3yn62D1EIo8NQoxkQIQHAl/GSV7YEwpRp0WD6rqe6aPR7pk96HKFUbWDxxHbiUFFIjnyK33PYezRTek0YSXFg+2iIkcOSfGHRe1koa8e/3m/nY0v9w0pGev/17+IROx2G3D+1zeFH7lp03oW9frUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599068; c=relaxed/simple;
	bh=gutqPAb0WHJAWtT5uR87aNaacbsmulN4b7zmU2l4vf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgTLdpuK1cLUCDBy9T6tdzaGjGgOpw8uT9oEsm5s97Ib5y3YAbQsBVuX47IPSs4oB0wCOUfZ71ZjL66Tb5c9H5sy7P1IeQ1NKPauTbxBJ4rx42EXPtPQFQZ6ni3xJCerojd9rp0+8cOQ3QxsW8IWDZSHWwmFrqCyg0DViWg0hOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKq+ekxx; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKq+ekxx"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40866608701so1528477fac.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599066; x=1770203866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gutqPAb0WHJAWtT5uR87aNaacbsmulN4b7zmU2l4vf4=;
        b=QKq+ekxxsMHg/Hr205+28tTaVyf1DgXyoAXa6WK6Dz7ktlvetIORyg1pZtW6qu6LLt
         pOMFZlC4+Io3SpaenW+w2+HCIOFtCZMy76qDnnBr8IvRCDL386Ro0i1utTPtxvhEEkah
         F8gOPRwLwx8d/2TPQwN62SgRioVZurQsGRL7fzdoEP20P7V4dSherJ5BoN4vAkFKcLIm
         /e0TipL1HXs+oDb370UTeHHHmLR99DRSSamuMWCGcnD3XPuaHR1R3AQb2ItOHuStwiBF
         /C2oK8GzvOzOdsnVYWFNV0Xf6wvmZJgmv7lcvZ7bjPtH3qErhuUAsMVigFwd1eAS1Yvq
         mHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599066; x=1770203866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gutqPAb0WHJAWtT5uR87aNaacbsmulN4b7zmU2l4vf4=;
        b=V6gNUVeAQiUbFNQQDEu0+ACBHdmlfLD1adBIXAZUXmT+/L+5MOOtAt5cxXcDgugx70
         zxDdMzdgGkY56ubKJi9YlrELRTX1uSPDJLNZPEDPfzyvtDWHALxD1zqNlJwkJWYHlO7F
         A9+44PWTQHcf2uJhFeKo46jxAB5dY8GB/monZHUb2S8xoqCMVy9LiF7h6C+5hqmi3cwR
         6kd0UDTexH0tEoHKJ5/tXAlWl8wKbaCfAlLwFcSEIjl3zr2GNHQQoZyuBhG6kEIRdGZs
         O2LnR0iFT9RWd3AKNL4wS7S0w/W3j69ebW8pJa8xCDLxoYPcTJRkiQlJX/RfFCk9hl4r
         eRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkM2YZAVWyJ0SYcQT9SQIDoR4tQf9LR2x1fHV9Upr+cV8wV/J5DxeEH4cpfHzYQXSsQM0Dbo/Smcu+8dXcV464@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6S+7J74MRZU9HvQ7U6Zz7fl5bqRrZMsMugfhGUefOObPrAFZ0
	hNTaIUarEhsjWEaB+c6v1/DNagUDZ+nP3gidXNtEgiV+GhR4MPu6Bo7LIUI2Fynvwj0=
X-Gm-Gg: AZuq6aLkAJrQJdLgsJnyp4/8D0yGZpbcTpXGkXwfFQqntSF/7f0a9yroowUalIH+k1f
	+W7ijvKXJFffMgqw2N6B/BAV7biuR05QnyVkPMMrEoOiM/9/EcVoFOoWqUq3+2bsEupLfyzex5X
	34dn2kyPhUOybsBALxJzsBYIpXr8Af1DCkYclMEbz+BjMeLhrshMOgHA9fEr9nNSpPkxd++rRcM
	tWE9bz6/eyjE3WAaeZiapG6P0dpvxVkCkuBUnq0/ulSB0Y3+8EqM/5QYLMqPNesJ7SKlX/Y1haC
	MSYZ3sQvBEJjQNZdTLkaSb4C3el3yuphxBWb8skpJUNGW2lfrTyJsrauVj4Ky/U5hvrTue5Zk7a
	HMdY5Q8pRueEn58pUZAKKle70x8UaLfve120KUYnk7qYzizJ3d4Euwj0MqiKOJCBUr3M1N9yVoN
	ede7RFC3t3qtSnv0k+utF+Pr7ExB8+Yu2fWx0YvA==
X-Received: by 2002:a05:6a00:2353:b0:7e8:4587:e8c5 with SMTP id d2e1a72fcca58-823692b2c4fmr4056091b3a.56.1769591747564;
        Wed, 28 Jan 2026 01:15:47 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c21112sm1958770b3a.54.2026.01.28.01.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:15:47 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wangqing7171@gmail.com
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
Date: Wed, 28 Jan 2026 17:15:38 +0800
Message-Id: <20260128091538.1892516-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128085200.GE3372621@noisy.programming.kicks-ass.net>
References: <20260128085200.GE3372621@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Jan 2026 at 16:52, Peter Zijlstra <peterz@infradead.org> wrote:
> This is just papering over more bugs. There was a series out there
> somewhere trying to fix up this code, let me see if I can find it in
> this shitshow called an inbox :/

Thank you for reminding me. I found that fix you said.

https://lore.kernel.org/bpf/fb745675-e25c-4dcc-be4b-4a4411056755@linux.dev/T/#mf901967ebe77506f1bd6e3d876c2a85824d9519d

Let's ignore this patch :)

--
Best regards,
Qing
