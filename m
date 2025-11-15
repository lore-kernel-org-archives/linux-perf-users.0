Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F432FAC0A
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763214927; cv=none; b=GLW/lPy/QCyaV7kEZhlHhiaGkk8pfwvGanQjrevwm0BIIzTyo5RT9BuOMaBRzjoyskacILPUJFIt4gSgxz0OZyXJRVM2lDLTqyikUE38ovYHU7dG17b6po0WCp+lpE/VS/9Iei1RHFtOmMhGFtU7muy+aVUoQlHm3NQr8kukoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763214927; c=relaxed/simple;
	bh=y5QUmSKzlS0amBxXurpdk6aXWqflSKro/h9ErGoIjwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRLg7YPbsA7F/NvG+8QpgxSQL5G5dghcWHb+AOxxjrhmYiA3lWfabXrlMkA80GnugYDBwh7LUY4zht+6cqvdI703ENn+MEk47ziuKbVA/5BAUn8iHZGlGr4SNcd0CxbL6/uNUl3BLGzPOzXQ5keYxQ4JofLgtk0ubom0QvZXT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXj3Vvch; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXj3Vvch"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343d73d08faso2825047a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 05:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763214926; x=1763819726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5QUmSKzlS0amBxXurpdk6aXWqflSKro/h9ErGoIjwQ=;
        b=jXj3VvchJ3DaDQrXW6IN/9Jnboih4YaZsQ4jwthcGQt7g8jmyb1FuL5Sv4FBHm72Jh
         CXnGduVJJaNgwuCvg5ldvn9DFPKFLMF+uokpidzv00Azp43Zr3UkGvnFR4thVeSRO7IS
         AXTogjn+aDULC8ZUEDLQNSO7gAdf49lr7c73UiSd2iOB9RMOYdzglH9nn/gUWVMmhoAC
         TIjjb8rG1d5E0toxH3Sv54mWByx0piXkKYaK7e922KCmwia7WlBlQDLN3WUfvcBwpm7N
         7A+y2YSfm5vHPIVBHPC6sVRxDDZq2gOCxFMwiVTsu8BWL34QbUxje1RULZIqClxye8LA
         gvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763214926; x=1763819726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5QUmSKzlS0amBxXurpdk6aXWqflSKro/h9ErGoIjwQ=;
        b=pa413nsc5FH2zGeNbCCUC03X+3WLeKKG7fRyV/1RhuKROR/SULJLamGljBht47x/bq
         hxU3CAqIFfMJSHFu0xPDNKW2udq/RagUJZclCDxn5n+ioRze4xOMSjZdrZ4quE8T1fc4
         sViUK/GksJ93TnsLgf0G3x7Qv4aaIRMeFjvcLWv51MiYIjo34cwDCydIxSZo+CCDzNk4
         N/OOVmW3lkYvd6mj/7sklKtJ00ZgzGWQ87N6tG6YjjnnSyV3XHmheh+kPAqU3UCbZVTr
         H59lxC9BY81oFWloHYlkAarksDmeM2FzRejB0+TsjVGLhyP4MHEZaYHU3hssW7zg91jo
         mU5g==
X-Forwarded-Encrypted: i=1; AJvYcCWb0+l1fW/H24Ytmcr4uzQOp86dBW5UcobjioiBTXopMrIvRiRpSc/Fvxkhn8qgaC4Es/S71ewg7kPMkf+LH9Nb@vger.kernel.org
X-Gm-Message-State: AOJu0YzKD0xPRvvjSq05NTyE0WHt7V1cu0DDQ99G6opxsGmrlRfWfkU7
	c8tMHpeYpmAkUhn1GDwQklTgPgVFsO24tXgUUAzd/VmqebjyxARL6Ug/
X-Gm-Gg: ASbGncsmVcN123iBtMmJbYyGmHRia8NMl30Ro8Ds0UNs8sqVRodD3lundCcqCq1Xi5y
	YZzjGKFhek20AF/X39dTityH3G6Ypj7Xg7B1Elhzp6jaFB7X7rpGiZctYqBeXXtYTu/5EtFtreP
	s4pVLMNR1tkYdUQjJsU+rSPoVzTFR9JzMzJaK0arlj7ECT7Imi8DWZ8qYMsFWMZcLAEQDP+d5ED
	5fOlcLQ4HqIfWboMr2+TLhd6XIsNVqY3AVlM8ng0Hc84F4VC7bg7g7C4dvq2OXzQjJlkzjgnjq8
	ccFeNWBNbV+u0A8NygZWFaKl5CA5P9MXY0cWcSSMwbyz+5Bmgc9Na+6x3UwdtyftCannYxhnrvw
	h6hOCjGqef/xdJn3+KJqr5Ss3GgF73Q9EfK38yJRSug0t6bBVEF4k2VFfYTCulF6UpYVAKwra0c
	iVMRwv4oxzRFg3FJkGBYQFxENu+AwZUSfmYGo=
X-Google-Smtp-Source: AGHT+IFuTufEP59uKbwpymRKno9yjHG2whmUp7ulswIr3+CxbVVYv/nhc0N014IklbozTKH44HgIGw==
X-Received: by 2002:a17:90b:3503:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343eab07fc3mr11539361a91.3.1763214925468;
        Sat, 15 Nov 2025 05:55:25 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e071571fsm12590727a91.7.2025.11.15.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 05:55:25 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: aalbersh@redhat.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	andrii@kernel.org,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	brauner@kernel.org,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jlayton@kernel.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lkp@intel.com,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	oleg@redhat.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sforshee@kernel.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Sat, 15 Nov 2025 21:54:43 +0800
Message-ID: <20251115135443.460-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <878qg8bduc.ffs@tglx>
References: <878qg8bduc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Nov 2025 20:42:35 +0100, Thomas Gleixner wrote:
> Please use the documented way to denote functions in subject and change
> log:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs
>
> Also you make this __always_inline and not inline.

Thanks for pointing it out, I will improve it in v4 patch.

Xie Yuanbin
