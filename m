Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016E301015
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419940; cv=none; b=sn3EzG+0uCUgdkyohUzviw1A/IQDvfZzz0YbqNELCsKrRxqju52JP0iQ4nm4AG1EPkUCcov5djTSHZkqiIjOz/mXnVIWVL4qQY//CPB7u6BBgqPQiHwaohPv0fNCcsm2d38C0bSBCy32sLlswVDVr2wpPgM3nIVj1e11/hLECt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419940; c=relaxed/simple;
	bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYNpJAfoKnj3ciOhCgJbhLVqgZS6Ca4KsTcnVjvGOeP42uEknxie/z99HeFfNw1VALxlSVkzMF1xjLGvsgzB4HM5wvL2IAd4L7CZLPugf4tkQV96p2+zz7CgUSLs1isqNO11HOBeTMGUU7RxRDFENfr70H8hrQGgIIuV+2mcH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqx+o/z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqx+o/z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eec33b737so47200585ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761419938; x=1762024738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
        b=gAqx+o/zrW38qe8vTmotvOS8G1BK0a4PPbPHZ+5uhUNrTPl0NW2TqVA1EU6TpCrRGh
         GzuApbZZFeg9EVYXfwWy7qYrWubTWy6BJ7kHjZkrF0kNtyxw+T/eakjNqr0cxpSkN/Qv
         nAw6QtAgDQefdqru9VnlBqrFJHd3RCOH+8AnkHQjNJTOHe4M5aTuzcyKYQMDCvZAcI8Z
         0jOS+mw4XTEKwmU/ll2iTsbuLIAvslDOMRR5zE9wIPbqSjzmFcEZqqDUXfK0LXuM48yD
         ydHJcVDEhcOnxguGJa4DAIB8Iwmt9VspSbWk5Q1aXtDod5j0Rh/g1fQZaDF5Jon3nN92
         7OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419938; x=1762024738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
        b=AV8OlJjh33qC4xQA5fhry2IjaP+hGqMNvm2X8uzlSnQlGodOsDA0aYCVmV3rjcjCaL
         LyyPGdJVED8LwcQ3bmXKiWiDJwZk57Zrxq5VYm7+ebZWaPYJyMvr5zLn4mc/R5oKDDBM
         AWvL9s2jUORFZxQH/Fuf4wmanqb5/RIl94kmvuhxzWp2FV9U39q1ctyqdFQ9y8e+2tGJ
         5hMjSXYmj3w7VAAnU26/cGfhonouLeAfaE8ezYhdR91npuB5raSmyMrYglzmxNEsieY+
         ctlHxZCmT9ege0XANaFAUtty2BKenY1ETNzJ3p54kqLqfUbQYPt7BBcw1FQ3SE8uJViI
         BS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXiNreE1Ym4X9Khr5sxliKLoSBDGaOP0KxhHphDEZKps2VWBtE1EOW8xdpt/Z/iTqHLi3uAGuTNyRg6Bps64pbt@vger.kernel.org
X-Gm-Message-State: AOJu0YxNM1TrEFQwmjMDJtuNDyJTgoGYWIGfgI1SzF4YFCMyy0mUFuti
	NCNAtQfN+X/lYqKO9BJRMFe8JmHNDrPHcAyKIYrpX7HK2/GlK0nKyb8I
X-Gm-Gg: ASbGncu5sm/O+KBjSQwiMGTR/vGHoRQFP4xxK0bxUZy1ik+9LhbM5GYDqqlrG8gT9/k
	7hRubcOKUYLiJmi4uJoaOYgZ4UwlNeF2DtmIKCg/ZghhchZ7b4DCikZUblBmBpMiBbz+Acdrvdl
	WbEUBU0xEaCntW1kEkgHC9skdokVZlhdXnrNIeM2uNqEwrGiUcjewzSdWaer52izZRbScIS2C0P
	FU3WZxD4d5Je5vqJs6vmKeBVTZTljFA7BuX3kNANIcYDSi0YCVAgq1gs8u7ciZQ3vY8nKcV6azq
	Nyucq2Ox4nsyGco0mAW0lgENWldo6D2uJQEB+UKs2XbsTxBF/rh1tsYMfLyG7F91jLJMrp09iTG
	3AZdsVlOwDGnh7APWfknLhhjKfz2CklDBfa98EkOlB2POUWNP/po92uCk4IKzQUsozHUtZ1uC88
	3KxEnIiSYcwgfiNOpDLukbhoOlvNX+vZE=
X-Google-Smtp-Source: AGHT+IGB2o/5lEiKd9cWH/x2UTjOp0RZ2ut0VtofYuc7VyGMeDPM/lJA9l37C37EEgCCcQfgsU8H7w==
X-Received: by 2002:a17:902:e889:b0:27d:6f49:febc with SMTP id d9443c01a7336-290c9c93af5mr423757525ad.1.1761419937751;
        Sat, 25 Oct 2025 12:18:57 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm30054435ad.100.2025.10.25.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:18:57 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: riel@surriel.com,
	segher@kernel.crashing.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	namhyung@kernel.org,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 2/3] Provide and use an always inline version of finish_task_switch
Date: Sun, 26 Oct 2025 03:18:39 +0800
Message-ID: <20251025191839.6907-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
References: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 17:36:06 -0400, Rik van Riel wrote:
> Does that actually work, or does the compiler
> still inline some of those "non-inlined" versions,
> anyway?

For the current code, adding a new finish_task_switch_ainline function
and calling it has the same effect as directly changing the
finish_task_switch function attribute to __always_inline. This is because
there are only two references to the finish_task_switch function in
core.c. When one is inlined, the other becomes the only call point and it
must be inlined (unless the no-inline option/attribute is added or the
static attribute is removed). The uninlined finish_task_switch assembly
code will not exist.

However, if the call point of the finish_task_switch function in core.c is
increased in the future, as long as one point is added, a non inline
function will be generated and codesize revenue will be obtained.

Xie Yuanbin
