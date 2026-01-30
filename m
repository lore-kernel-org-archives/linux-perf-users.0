Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A61B4138
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744068; cv=none; b=D9UlqN3LA9tSwis/LbWTQDJY6wgtxbpPoNUtUJyp/PryD4QJ+J3Vhm0Uyc5xnCsdWHSix+cguYF1lJoSeEJstozPLKqkiS8jutFKBIj7Inp5OappAh0n9hruQrUhGFBboEmA0Br6wnemO8RJQBcQ8uYpw3hwPHq1QG9QBvX+Nx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744068; c=relaxed/simple;
	bh=QVKshjrmITWt9exp1ZUKXHqWgOlKpwlhierbwT/A83M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjiQREf3fgibwO7478uCsunihJ3Ng9YxJaOK2K2ytCIZI1TBDFp2dwzFCWVp4v0oK59/ziLM1sf/L6a68YS9Y29QmfWDwe2GQUlaNgCxCcWVTOLN13vCmAQr5pywpAzo8Bs9XDzb28ApoQo2OcNGqGswUR7tQbimjsRr/jb+Xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM4oHje7; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM4oHje7"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35305538592so1416785a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 19:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769744067; x=1770348867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVKshjrmITWt9exp1ZUKXHqWgOlKpwlhierbwT/A83M=;
        b=WM4oHje7MbsQlVj6wxcr7DH2s3f/FfwKZO/DfMIodnSTmKppaHBLpSl5bpIz6bDwqj
         +CFhZ7fMeLOgUbz1wEBNTYpLXVlcIBEt7wLv9TJM83zSmlqojXdA86WNbBJL+7bu5v3X
         akmAvxXQ7bSBiHdoVuHqZ6yqRNx2NIKNAZRKTqD8lwnpf5Jr5IdToAuanw2Bi/+9HvwB
         3wlW4vGgftwit8oeLMcCftLz6f2S6kptyRprIL+lp18OdFKHQrRwuM9GWRr3Z4mp2879
         mwqumPk/H9NjEsXoiRlZFlEzGrGUcmc/sfYWrD2Av2WeJBSmVI9pSxWz8RRoZpZh2eqP
         KPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769744067; x=1770348867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVKshjrmITWt9exp1ZUKXHqWgOlKpwlhierbwT/A83M=;
        b=ij/taB93E0p72D/pGHLPbDNaBojG1CP+x0eiuNXQ8kiVWBqgFMzCIJzKJLr448J0Cb
         X15KgTH4GAP+Cm7OOT+3br2FySG+NJgEc4kyX1jUfJde39VGHoNOFf0xHZ4BfAfnHz3s
         40LE/oUmKVC3J+r7nNOeSeByQkIMZVoFVvv1Sr/muU8FyiFZRPBB3Eoa9PyISu3yBQUz
         1vOTajOl4dm+r4ktvTf7Y61FMgQvC32wfmkL9d0Uf5PmkJuLlw0+nLSy1Rv7/MomAD8n
         5l8kvWQpF5TX7gJhHO7VCVYk1anJoi/pJsW3+i/kIToxPojv9YaADSbEL3pMG3Nm7K3j
         pJAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQOGv3kTVI/NTs+RCoc7fBpEwd6pkU57z7G44aCLGjkmVWwXghqJ+MfFGOozQ3mI1ksX2O1lHwhuDlG9dpYQQc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+yexw6PI/gSAZ4x3AvsVhDV2ovL8F7GASEmkijfB+E5D/axM
	domSj4sHspYS24HFBMpo5qaCM9FHFKd2GtcTx+VokCdc7ye2MqVyJQp/
X-Gm-Gg: AZuq6aJHNYOOKvw3iEKqK36TMiHDO3kvsklG5CtQ6stjaPaP/YG8scMGgQRWzPbuXR5
	ps/BqS6/ixcdZWih2EGbr7TKXJ2McVaM0yYy/dIVExcm96ssHkb0pQp+yj13JgulLwb7oONdEbm
	uN9ChFDVXd3mjV674y6pQa+iBXPqY9yZFJEihga40qdxEzyan7wcpwTWnwQYbL8Jb3/X7iSWVaX
	oF28O5F+QaJsQb3mv13OCT80SNsFq0hyYSgoG6z8CaBXpfKY+u4K1eexhfYGBmOvbVYnLt6Ga2e
	cNuwxf1zGgYmR1smoe1WCTPxw296kPpozeRJJ5lQTPtQs+0U872ISEYqREaXN0IF7EPD6f+XGzc
	4trEnWFG7jPS53Ht2tH4ps9Ln9QZy7YFneLh1UPr/0zuXm3edGFZpMzcZzkCl5OzXmFA+e9RIij
	y8gfAZMZKF6vwAmxnwcd6VKaxlpP5FC61RDPhMyQ==
X-Received: by 2002:a17:90b:2b43:b0:340:ad5e:ca with SMTP id 98e67ed59e1d1-3543b30535fmr1577516a91.12.1769744066630;
        Thu, 29 Jan 2026 19:34:26 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3f0872sm6439833a91.16.2026.01.29.19.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 19:34:26 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: zeri@umich.edu
Cc: acme@kernel.org,
	henryzhangjcle@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wangqing7171@gmail.com
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Date: Fri, 30 Jan 2026 11:34:20 +0800
Message-Id: <20260130033420.23612-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACkPEmne--T_3bdwJEy8-GEYm4EJF60xSoqbrQ-m_LuZhJhCuQ@mail.gmail.com>
References: <CACkPEmne--T_3bdwJEy8-GEYm4EJF60xSoqbrQ-m_LuZhJhCuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Jan 2026 at 05:29, Henry Zhang <zeri@umich.edu> wrote:
> Thanks, this looks good.

I thought my patch is incorrect after review.

1. The RCU protects 'prog->aux' but not 'prog', so 'rcu_dereference(event->prog)'
is incorrect.
2. The UAF issue of 'prog' may not exist. It's needed further anlysis.

Let's forget my patch.

The data race is correctly fixed by your patch but there is still a little
suggestion:

The 'event->prog = NULL' in perf_event_free_bpf_handler is needed WRITE_ONCE.

--
Best regards,
Qing
