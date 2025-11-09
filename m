Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA03002DB
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Nov 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707874; cv=none; b=GjZtRubQIPz8EJpIe9VpMPFwn3SPMjTzk9DQH7Kh4PwYdqNxQfSzJHQyi7ljmVYw8ugaMreemkm47lb7+BnEd3B4r1iahl3rmqqubyJvcvRMbGVYSf8B+506fFoAUbhR+f/YuWmJ+vHUMlifXs/9zAk19UR5/jjNBYYLfRbEDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707874; c=relaxed/simple;
	bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uonUcuuxl0YSNjwimSO3JQR6LQwrJBtJ4ZxwBW5IKyf9HXXUhSMSYEneGUpGwVqVG7d1UYNh3BUsffBM59cGu1zCuiDy43BMOS5Sr3JHbbqAKg4QUtZzQlEtjytLSWnQ+qCetlPG3RjGEwON6SPFmnKRvQmEreJwzRUaqgnagbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUWscdTu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUWscdTu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2982237a3b3so518385ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Nov 2025 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762707872; x=1763312672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=SUWscdTuz6E8COB4RFi3ARO92QxTVYh+eM1xKZGjF6toaMhbiUpmk8leK7DKEWdVmL
         T1n7eWLAgZR17BgtucZln5haaFIwIlzBsalpycpO9AxPOEgjT11nWQKYzgTk0Z9K30Kr
         rFye/XM/FEOlo1TZuOg1+8wKc4EhvaPGuuwf7bsd2id6U4ZThUmIyUTSgvVorWd3erHW
         mGWG0yFvj5HsGIavX1MJ6qyQVNruD0wj8Ku4SWPkAODcbDrsuB4gTHSFD73zHzYvw9Xh
         Z/AAbxMNYwNciKd7J61O/9qa17+e9u5qDL/ZsKQWqs+i2yi7vmHiqCc3mSXqFsLZjskb
         DLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762707872; x=1763312672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=S8ACDnzxemn2ZTg2tZZxlS3xg1wgofj9CTzaepmyaJN23QLa/3ghW7aTNrmlIApKyR
         C4AIk/6TaL2qp2WX31OglS2fK7Br1au3HBBX4ZBGywNBDtOCTgTImmSR90Vgdtj7Cryc
         3O+rns3bP52owCN7mv+WkFoY+AyTy/1gMOxr955ogXkzHbbpWC7bh4sJMudBjjOfdbtZ
         ExK64Ox/JClJgYmiUOX2ColrSbgDy/3swSKxjB8FxbdL2UZkNEAuGvFBTTzpOxrb1uWs
         LwZk6guciNG2bORF8jEGYv1B2d3mgHop+mUkKYdenjXkEhju6B9V3cFnbRDxzRUUIEkR
         K0pA==
X-Forwarded-Encrypted: i=1; AJvYcCU+tZsHyOWensrFf5lEI6iMLqReDc/wVSR/PAuvCbMGTh8h0tWoVK33ZsbDwPm2pIM5wgdjakTyOHwPdpjEdZJq@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8Oic/qDqpBxPZ5VxcAgnjl2dJarIYtOTDzqUO5+V43lTIpmb
	eF8cDyBgdhknPgaw3U6Cc9RYOifL5FjslGO/h+SqVdai8LmNl7OUibe9
X-Gm-Gg: ASbGncvuYiY8RWybgwuNzbchtKbNpLEI49pi4rnAjS5PQRnJ72oQiSvDgXnIJ1QFgo1
	hLZe/jCLgvJwoEnSlraT3wlGVFT2mQ0e8lHUBxNs5L8IQB6zjyZ4wsxrQsUaDAcQWpiUV3y96JF
	ngKWuburipM0CQrNE7V3NT7ZGW7JmxNmNU++/BxzIkoDu7hkiy2tmmBXYaKWeUhkA6erIc3U0vZ
	vfSbuY8nlKR/kqCxvCTvrv2w0i/KzZENF7O8zNRoC+yDU2OjXJMpmYd/ZsLhFSLgpaaDcSK4rYV
	rbK+fIFR+hXJxfh7+3O8MF4OI0dcEXF46W+TyzwmfQmm4dI5OatNHqXQVJ2VRdWGXUKvS/z21wT
	sVxoCFD6THoayhCjC39tOuJv8hsMzhfWepDBQ0cTFMMMY+vb8cDidA08Jkxc7BBVrsWLWjiuQBd
	Zs0N1ErWRku7pMS5OFLYak/LThrHjEXFDaiEM=
X-Google-Smtp-Source: AGHT+IEO5xU3ShKvIQJG0EYcsf90e1JVTbxU34yk/YUYIZqWcpmJ8G9BchXReIw1drUaTkP5NUMmRg==
X-Received: by 2002:a17:903:2f86:b0:297:c71d:851c with SMTP id d9443c01a7336-297e56be50emr71705165ad.36.1762707871570;
        Sun, 09 Nov 2025 09:04:31 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm117879105ad.20.2025.11.09.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:04:29 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some functions
Date: Mon, 10 Nov 2025 01:04:02 +0800
Message-ID: <20251109170402.145012-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
References: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Nov 2025 12:31:52 +0100, Peter Zijlstra wrote:
> There isn't a single function in the entire kernel with an _ainline
> suffix, while there are a ton of _inline suffixed functions.
>
> On top of that, this function was already marked inline, and your
> compiler just chose to not inline them for raisins. Just make the thing
> __always_inline and forget, dont make thing extra ugly for no reason.

Simple test: "Make the original functions as __always_inline" VS
"Add the always inline version of these functions (with _ainline suffix)"

compile as OPTIMIZE_FOR_SIZE: the size of bzImage is same
compile as OPTIMIZE_FOR_PERFORMANCE: disassembly of vmlinux is same

Adding the always-inline version of these functions can provide better
guidance for compiler optimization, but it does indeed lead to more
complex code.
The best solution may be to prompt the compiler to always inline at a
specific calling point through some keyword.
I noticed that there are also people discussing this issue on stackerflow
, but it seems that the current compiler does not have such a feature.
Link: https://stackoverflow.com/questions/14571593

I have no objection to either option; it depends on the opinion of the
community maintainers.

Xie Yuanbin
