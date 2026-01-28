Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC57080E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568527; cv=none; b=QzzygzOY8X0EWwMP/zVDWz/q4Ruea8eGs/14WHOObmiC+N2F8SA9H21NZn1lZXv19GZG0fn5ttdsK1WA7Sm/QdcGY+PyMoBMrHBtdMJDPPqz/f38RxKeLhCPhBNXm+VX2NSk45tBZp4ECxXD6Ul7rKo+7JRo/8L4rnQzompebN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568527; c=relaxed/simple;
	bh=QWrLLW916vtkzNC2YAUSDv3SX9rSiSe81hUMKGcqSc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkdBwgHDisuXcXoaT7TbozHSUAjAQkzI4SrUIRtzszTkIK+OCwxPtcmdCRFMe+1Ssin3CNX56EyP/hSWgXKNfP3DnDHHdf3MynVxI+QCWbpF+MRSVGywsSKSUYRlQjNsqO7IqbZ14oOL6LrxqdGXjbh2UhYpb63OKJ6ckXJqhXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF2naVz+; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF2naVz+"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c708702dfso3471721a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769568526; x=1770173326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWrLLW916vtkzNC2YAUSDv3SX9rSiSe81hUMKGcqSc0=;
        b=WF2naVz+IMR/m3XOqAkiNSMx+BTpay3mkQMw9mxmvlC7rvVuiyhiHiOiM/niuiHTmP
         EM+bQxLtDJGDSsVpYzP4IY4vXeOwBnjBGFCrU6od40K5Rfju15X+6YD/KY781qIi139k
         qcFgLYI2YnVt/REvNFPd5ILuQ18L6rJRacj9UQt8r29/IZJrUDpdenV2ahbvMaIElzs2
         fKVc9yGbadoR6YYVoVwS49Vs3pdh6DbrR2DVak3BoU4wvgkKHpl30yVe/GwGu1bpg1j8
         ScRyLFV5SfQEPCQ2NficU+dxetit9G6LY7nrzqOvlywxoKpYthgHYU9lix3otLRDXyl8
         YiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769568526; x=1770173326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QWrLLW916vtkzNC2YAUSDv3SX9rSiSe81hUMKGcqSc0=;
        b=HgqIsOzQRS/He6+DyPsGUx/wrYkYfIMKdwjWljkLyRNQwR1XBW0h8EDV+7ROpID68i
         RO7c15yckQJaYAOC/OzN1nRCYU/8qazNJPEmnUnXBFNdS2anb6OB4GptGIIIw/GRaDPl
         64A2iQ9mcRTlyNMin8pIv+aGqs2IoPPUGtfNOJqCLQMY6iJlOUoQyVzII2O7ve/BCOeW
         5/h0yMRs+58qXKVkCk9HVrPKKMzmYeQGyfMRH6qf55N085dreNaDXncmrVlkz2fppr8a
         458TapY7vduzH1uYD0hRD7UddXDMG+ShhudmUWhYep8N/ZDGdZcY7ULmQdC59DPbPs6E
         x6YA==
X-Forwarded-Encrypted: i=1; AJvYcCXHPR+jCtHTgPde1Jv6mJlMCbVTimKiqMyBWImeqnuuZmm1pG/ctsrYo1htdFNb4myE8ksjlOPVIvJRyiuzOYJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyME35Sgf+IFMHuRkT6UNHOiV7ysbt5yoMVulnCK12NtY6/TzS0
	LlT7bxnC8uJnhb42Ji9L+D4FVB8OH0R3OgampqhamphDZKrCJsCdZ62K
X-Gm-Gg: AZuq6aKU3XEY1WlAc8LCPCnf5YKjcUY2C8zynVm2Ctu4kDCSECL/w1B2CMeHqQ0aJn0
	V3OFElv4MUt+4hVUksRIpMw5i7qj/uDYbCEuXfyVNElAbmp9Z/683bqMYq5lXtSTIJvyT1yyw0O
	j8uDXBpq28C8LdSf4aVsxhQdON3s1spJCVPmnoZMhdYeczfBclTfetnWApee/aBNAFW8kkFGC8i
	5Mm2QTW4ALcVvguH6exAbWY5kCa7zFvuai+0RQN6rN0PJaySIIaluB06uGe6RjfHGLAxwYprrnt
	pv8pNW2vqJq6P8qRIV4F+9rhw7tBDEPwt17Wxl0QiCB7Qi7oBjpJtsELm23xvoTXdxd6HCNnJGE
	MmCnHCU3lx6mHwojLKtA8ncpSLXZkuAao3aOYe3VQEq57eySg39UfTPIpi5Rre6XWiAQAcwf8s5
	WCtw8oU9ricjNK9rWroC9C5+huVs6EwosQus4wpA==
X-Received: by 2002:a17:90a:f946:b0:353:f7b:6d60 with SMTP id 98e67ed59e1d1-353feda10admr3573735a91.33.1769568525887;
        Tue, 27 Jan 2026 18:48:45 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee2bsm896545b3a.3.2026.01.27.18.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 18:48:45 -0800 (PST)
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
Date: Wed, 28 Jan 2026 10:48:38 +0800
Message-Id: <20260128024838.1820026-1-wangqing7171@gmail.com>
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

Thanks for your review. Let's wait for maintainer's reply.

--
Qing
