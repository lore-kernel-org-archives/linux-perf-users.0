Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C689258EF6
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789421; cv=none; b=csLsf/mbjPqBDZTq7O0ktL5ds5ohUad3vcCwYZMT9icxUc/N05itocqPVY/TM9HlQuh7Y29Ae3I/sNQaRv+SIVk55plvLdi0xVFh5JmklCF6oTKsq1aZEYcS7xImOc/jLz+4utXJZAjHX4IaMsNgAob6Elqac0IIYPX/qI+Sn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789421; c=relaxed/simple;
	bh=lJGQMZvZZc4KMFQn1KPcnjNaqLnQgvkqHDsdmDw6EPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgjKKThP5qxbDB1kOiU8j6F7GrV3Vj145vwx1xAnNDY25KdltT7RdwYssD8orsb378DsMiaxtvsgOkCvSEYjFK5C8RgakhL9XxCgixh76KKl+yiawrwLXCONO4sUW6G5E3ZEoeHK4UjRmf9HX/Kc2ntOJ3Z9mLieA9/f/kB0Ohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkRT/c49; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkRT/c49"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29808a9a96aso13112225ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762789419; x=1763394219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLAK+1utwDQJnW79jqnXsBU1gEdDxofO6NOCNqDBYAA=;
        b=mkRT/c49ATaJmYRGOCcdSx3Rr7VjO5+jPdDXtzpbvc9iY4QftAbWyBGfpLQPl5pIBX
         sJzAiuV0qbShW417k65mSybcc6F/0IXDieBkSkNBSdrhZh9gMQN1LdLhl3glO+pTUIht
         sg4wQMkRDFrE20VfmXUsqh2up7ZYEYWPu/CD8yPSQAaWQoHcPn5RN3Ay0C8ZdCTS1w7D
         5OIOVabfYLAVjeqmx9hsVGIQR13zqF9S8qOjvGlQfN4wiujfgZ4i85fvYEP/ipOZZZdL
         8x6pQxTkYFBgfnLIppUtxXOmxlIS6kfVe1xpoAHAwIQEShLDf9MFJhDCojb/hVO7zJTC
         dTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789419; x=1763394219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLAK+1utwDQJnW79jqnXsBU1gEdDxofO6NOCNqDBYAA=;
        b=bgttTklNIIJi5sHqpcHE5jpv/LrzhJDMUSA8oMpueGvYxRyhFuLpnFLNzgdfKpbadE
         eKDOHQY0U4uWz7pEHlhS6BsKVRvlASxCRIImaBVbXdtixD2FqHz+W8QA3PhTQw2Wzhzk
         ft7EGMnZ2H9LsB3iqmyeS+HwHQ4tspWOGeBJSKDqlqVDBHjyLy5CJyin1y40AzRHwNOu
         PJOEKusFjuW50/MQLzOL4IljnuUJgcy3vh/QLGU8hMK6nUx5rQuAb+uE7zlIbkmbTaLS
         aEwt0zhkxroez7xawqzB1Ny5sKqT/jtZvPPqnC+kTzp0cWgPhM0m242q03Fs/jfdKX4y
         I2pw==
X-Forwarded-Encrypted: i=1; AJvYcCV/dKur6obyI0IgTMTyll5ArblseuXxLegXcdV8Pd5ulj23+t+gIDsetqIlw9aeU0TZ1UTOlcxhrrv6B373BfCU@vger.kernel.org
X-Gm-Message-State: AOJu0YxShRqouLDsx7CGNzed6eAxUOtuKGpkC64029/nniRqMKNt8e4p
	svwkUskmEncAfIkObhm1IxhXs3BkMPEkH1iVQ9tUFRX/Bzd9wYFGulVj
X-Gm-Gg: ASbGncsuP4SguOB+5qhJtyWrI4IcWRnnyXwv1uzhz+JRYfMOC4BUBCN+kn2VoZ1LBHq
	91HA6BeiZdfCI3YljCsqqHPbp4/WqFoh34SvOTdJsydsCkkHb+jQPlaTaluPshA8Ax6Q2imuTRy
	EYhrE4pfXeb4rInd+avmrEgMv9GyQYHsK6xfCkhGBY8P5QnrPZx7df6I+etA6aJokJy6vb07CAJ
	IuTlZiVT3SMqmdOSzG+byoV051K5WK7YdCrVWQ2vU14s/fxD2e9B+edjjtWEagHgEsPBJfGtTg3
	4YKZxJhRZoVFSj7hHE9ELkdw0F42lyrugqtAiihbEH6bix9/g+VsTT/5/kVgqSoSA9Ni8TQ+umT
	xJ8G7vapTvjv5Yz6GechminHqME90SflZ5cvuEMX93LD4sEzyHWk0FsS5Q6O8OdoUxLbtxIii1M
	FvykdkLY+shTuvwvNOKS/CnynW12BuymNBcUo=
X-Google-Smtp-Source: AGHT+IFhicyH9W7Mg5DiwE8MVpN4/er0oaakdgICmjAbGBgQnJD5pAHwQ51RtSmFFQvyQKJ0R4B9cg==
X-Received: by 2002:a17:902:ea09:b0:269:ed31:6c50 with SMTP id d9443c01a7336-297e5408bbdmr106752805ad.10.1762789419238;
        Mon, 10 Nov 2025 07:43:39 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm101566725ad.88.2025.11.10.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:43:38 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: arnd@arndb.de,
	david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	peterz@infradead.org,
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
Date: Mon, 10 Nov 2025 23:43:01 +0800
Message-ID: <20251110154301.1930-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a034a57e-d9f1-4c56-87f0-e9126246849d@app.fastmail.com>
References: <a034a57e-d9f1-4c56-87f0-e9126246849d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 09 Nov 2025 18:35:23 +0100, Arnd Bergmann wrote:
> You can mark the caller as __attribute__((flatten)) to force all
> functions to be inlined into that one if possible. I don't know
> if that would be helpful or desired here though.
Thanks, you made me aware of this attribute for the first time, it is
really a great attribute, and it has been already added to the kernel
public header. However, it's rarely used in the kernel, which I really
think is a pity.

Perhaps, I can try adding this attribute to some hot functions in
another patch. For this patch, I think this is sufficient. There are some
cold if branches inside `__schedule`, __flatten will inline the function
calls in this part of the code, which may cause some unexpected
performance degradation.

>     Arnd

Xie Yuanbin
