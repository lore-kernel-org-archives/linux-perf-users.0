Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0B336EF7
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581627; cv=none; b=GIGtkgHHJ9qMQao/TtSJ71Wji/LcN62KxpV9sWk7VuM2r75Xc/hEOz1K7ngKifD4PY/Mts1i+yt/RAGLCfDcTokC9UFND/Oupgw0oKzfYQeTx7chCo45KSEXvbOOb1CEgWHmDPx0uvNar5TlCpIERAvjmSkutgL3DwTNOqFMxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581627; c=relaxed/simple;
	bh=Z2RNeIgIuiMxf8WzwyV3GqNjVb47QgM8ARvMJvBsGWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEmBxzVU9lzXx8sbj2KcRefm9dq71IiTODnVj71lVscLF1GPOZoB49X24BjpSMyAGWPyn/64Dx0R91EOpmDgibF5EBjzIov6x2rdE7XJRpV5r0EVeapYN/BSHAAjsu/nny86flYnZusT0TK2cr7KHhh1tPvC9X6hynDM9WJOSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHuT4vyf; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHuT4vyf"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c227206e6dcso4344422a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 22:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769581626; x=1770186426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoxFNbF1tIwyPaMGUrhH8qeDggEU3m2mgb1vM1gtHo=;
        b=cHuT4vyfHhUq0umCO1Bt9yuvejemY0rDAR2/ddWYGvCOy7LNzpEFNIn2tjeHXtiquW
         NWDoqY1lYrQ9ARkwp7apx5SWdtv/ejL0y/HvwTpClw4SeQrxJ8P/BepuYn75HorLU+si
         nlUlQzPYefjxUwksrD488y9ponpOvqEDClKqEIUxugnOfwBzocHQ4O9Akxa5uMgKXfsm
         UM9yTXZQwhCVXeNHk3D00C/TiMUKjUYyPThASIlcuNQsbfS+O/rd3aYTggHNz1UsgGvT
         f5bnuai+1TN6N1GdhYDWQPuSsZidFZmjOYrQe/mR2/kyOMnhtumFJ3RRPK7xQnjJsYbc
         z9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769581626; x=1770186426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPoxFNbF1tIwyPaMGUrhH8qeDggEU3m2mgb1vM1gtHo=;
        b=ZyqPJTTfZPQjr1sGOzDRmdqUBZfgUu/W9tdjAmZ6Kbo9cpf1CI1nm/LeLMi7CofSJv
         kbYUE6nWLmF1SWsnIHs/T/vBxG1qEaXo3E7F9FaUD5nAZMCFtftC+If4giiyhfJBmfwr
         d28RGh7pOschBmO99E0EWlarLFpayppM7zLEqxby3g4xvTKDwWuDGPKNZvpjT89y8rTW
         mHT7ifPd48idWffmWgxkiRHGEaZ+J9I65E8zAi1wR7dXwQ+2TSY7URAHL0xUJD9n/FVq
         QHLTQDnoHfeliwf9PxBDLI3RCq917owRgs/1/wOB4dJVtEhTYaDZeawG+Z0SDC6YkR38
         CK/w==
X-Forwarded-Encrypted: i=1; AJvYcCUNfg/udVESu992rSONfQN5EEtSaqn5ZOBoMwtkDGTt1sTJv8dHLIzCwEfS/+7Xdx2DKXroR/AZPNkOAMJFriWC@vger.kernel.org
X-Gm-Message-State: AOJu0YzddKFd1c3NvNiw1bnD6HM3yyrYpyNoWxPeYCOA+YwPaiXPr1kO
	/QEYlFNAX9CwsapHaaxgGzioZJr5f8zniazoWQo/4F0/8fq5TGYYnVGC
X-Gm-Gg: AZuq6aJWu/aOi5eYj0woSQfqq4K2luwjWDWQ/FQgdC/RghGNhm/Pr5Jyo4NKUYlbimt
	pk4V136HH1bxEnmA48Ftx5+y42n2oZIlFykIoMe6ndgyts6VQ5cswI2T9/a67q5N9UNqS39IoP8
	yfRfsrS0VH6gj7+adpwjb+rWvB9bYHwREFEH8UiOn4tMBVeBwldLZHW+CTZIoUIeUTFluoFCDo1
	pCaCCwon6U91NWwfoCFqqWjvi5LiXT5NkZEZmcWKB9TduAGmiZoj3v+OzwBNxobcWQIJhHPfajb
	K8A+IAsSB7frthJexg3z5bB8LgNmQ9cWGD/0sPkr+PRT4k/RN8xmtgCOxuEN/ZAdgEB72FtDiwH
	ikPz3GXsAER9YQK0Nvjn2Ff5pKl0pcQlvNSxyKyhrT1fVSd0f/PUso+1XUvC1rPwe3smNDGdfCa
	gcQF9r4/xj5/HoTvb52MNnnosjhUOWETOitc/ifQ==
X-Received: by 2002:a17:90b:2789:b0:34c:cb3c:f536 with SMTP id 98e67ed59e1d1-353fedbb396mr4595212a91.36.1769581625850;
        Tue, 27 Jan 2026 22:27:05 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24aesm1286780a91.6.2026.01.27.22.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:27:05 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bpf@vger.kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	radoslaw.zielonek@gmail.com,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in get_callchain_entry()
Date: Wed, 28 Jan 2026 14:26:56 +0800
Message-Id: <20260128062656.1860201-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
References: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 at 01:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> Which is what I'm doing in [0]. Radoslaw, can you please help
> validating if those changes are enough to fix this issue or we need to
> do some more?
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240709204245.3=
> 847811-10-andrii@kernel.org/
> 
> >
> > > ---
> > >  kernel/events/callchain.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >

Hi,

I found this issue still exists after your patch in upstream and I have a
patch to fix it.

Patch here: https://lore.kernel.org/all/20260128061753.1857803-1-wangqing7171@gmail.com/T/

Looking forward to your review.

--
Best regards,
Qing
