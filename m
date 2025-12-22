Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08E2367CF
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422174; cv=none; b=t8qbQv4KHtthiKcrvSsXk8oQUOAGWsfLhJ4m0ZoTeL+1F2uWnHuKcHPOfWoIRmecTH+V1aZEknNVTGQKdGG0m9IxHbXhkp4Y9XZFFG5G71dhHrdOr0jeCISmddM6JkkZCLRPdeVtheLkX+JlAMQt97K8BbAVCBBii4IoA3H9ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422174; c=relaxed/simple;
	bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHpC0VJAS6jg9JliLmjuTMbpOejq5RapOZVbTTVcoWXjQAq0Xu9dDTZ/jWtg4dd76AdImb3Pcn3O7OcT9Wu2+UT6os7Ll1iR0PsMeWQvSFit5ORQJT7NpJSAtzwZKuNcMntY9MfgPotWRrTEdCurMDMwXNsezfBcA1fJO66rll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh/pfhpO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh/pfhpO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f121c00dedso5574659b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766422173; x=1767026973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
        b=Dh/pfhpOQBQV6NbIpX9Al2Vme3mwxRKsR3UgJhR+1Xt6oHQPDPul7ClQiN3EkIzdkk
         IZYU693JwRK/8/BFaX61lkC4VQFOey3J15sozZJywKtXZqaro47lfQapI72B0CWPrVIl
         vVR9BD9Uy+gpDyGrFu2XQTD590ZYrgkmgi5gxyN5ee9V0xCYiYezcI0pIuqsmLZGtBVx
         M4SwkAe/PRyBZLoJUGuX4NDwyKzxKgiqlpsVXrhfDL1hOgpnTwf7jdG7Og+ioHXi8TlT
         va36CgFYndlmaNZ2IBmqL8L2kWwzCGjgn327ESMfeU0+Jy5wQHnBC+1wPsY+mLxdx4v1
         npug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422173; x=1767026973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
        b=KeEm0hLCs7fP2KylXhMZo2f5MU6rWJeqBzQ/5puq7Ein2uwqzyEce1LtTVXlmbrOqr
         9qKv3a6fxFpgCk+V4JzUpNjACUWoyY0oiYoIMYpMiqHgNAG7fVRmecw18GqUpUuMWFUs
         p+8YbMWdHwjnIdlA2jF7EYYHuLZfnILZa29TEFT5CTKZzsYI5CUbRkzGnDRZqtRRNLlv
         poPmlDHQe4YveDavwTTDkvZtjorlqnb5V1ErtqWVcETYoM5TjGf58sztrY9uDyj9TzIj
         HMn6ajQy5We5dWC0qdSkt3V4coaTQrGD1/Wqe/XhK6vHc44pRGpz+FuTOV/EFsDGNGNI
         N3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4F2VYqxUVds87+sEb/DG0WPT5qO8tEJEqyMpwhpSWXFpZ7Ws7vZ2p3CG15KW1Qa+F0n3Y/4FZrJSuh2hvGoos@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47bcb18nrp53RltTGe10qMJIc3MwIsRzB8V9yHvd9PEKebRvA
	3ZU3w7j+bP5QtRuBEam5JZW/inFKMfFsKwDGb8VYiAORbcp+dBJ2EY68
X-Gm-Gg: AY/fxX5ElEgr5Xel/B9yKiv2kx3HBEFk/VrsxHo8xZk/PuTvjStMnw5+j9NIVRpunm+
	gsYQCx2r0Q3eBrukbqIxJHXlz0yMh9FySocPozsa5BBFjq4KkSGvQnWy+z6WTPj0ZYJ7H1xih31
	y0l1fUScG5DBslFfbQiqlMd+mKQicpA/yQ2E2EYyEdu1y0MLPs6/p31fQF4l7tP9CL9HTvBwr8d
	bBE7rtJkaXRuEEa1QW2xbR+DR8oq/trinTePUb59X57LBvKhpTADoUCCsSKb34uztf8p4wlBXwF
	yHf3kMeFLRkfVzVF8DJgUuLH7ML3CJPKujDzugpxjpQoEy2ZDQBWbvLyE2LxSmqN8K5VciHm0hL
	hXZaXYPAZx5jlx4B+IgPyJAvqmqWGweuUuDqyTguuB146EKKhUpRY9nYGdSqYX/qFM48m1wZBFl
	Z8IhOAaqdPEFksPbNBrlPiKKJAMKNWXpev6usOrj3cOg==
X-Google-Smtp-Source: AGHT+IE1kSobyivF21U2b11KGtxcCjvRi7p3rr+R+RS7uDCxpPw8QK+rjeZvOZXB1HHavY3ezNQDyA==
X-Received: by 2002:a05:6a00:600c:b0:7e8:450c:618d with SMTP id d2e1a72fcca58-7ff664806c2mr10273618b3a.36.1766422172494;
        Mon, 22 Dec 2025 08:49:32 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm10813272b3a.9.2025.12.22.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:49:32 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	x86@kernel.org
Subject: Re: [PATCH v5 3/3] sched/core: Make finish_task_switch() and its subfunctions always inline
Date: Tue, 23 Dec 2025 00:48:15 +0800
Message-ID: <20251222164815.485-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214191307.184897-1-qq570070308@gmail.com>
References: <20251214191307.184897-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Peter Zijlstra!

Could you please help review this patch? The content and testing of the
patch should be sufficient now.
Link: https://lore.kernel.org/20251214191307.184897-1-qq570070308@gmail.com

Thanks very much!
