Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE728DB49
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184695; cv=none; b=qyZPX1ks2Da1M235z/BskLBH3K5rNMACJnAueyqJyh5AJ+62iHsdhvGkbh2WgH9MH0+tr/Z2ORePqUEr+5vexsRTAN3XNla0HHwdg6kaRcVch59JT/eZZjJbSc4pbfNUHQvOM44x4Bcmg3UnhUCMX4pSDGuKUeIC9LTl/d3OB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184695; c=relaxed/simple;
	bh=99Gq8zaJQDzmh0rJ9SfN0AY30f5+FLcQmxa4EMt1/ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9k5RpxzWJmbfdsXeQ4xyIe9JLggt8MKYB6nWfLYBj/BReqejsEL/AN1ECYPhnzy/BWfb1CNOpffj2wnWdMo6WMBXmt0nXsfCPrBNmwqYwpffkDFC7YbEu3zgXKZrdGieQCRNpsxfpOhTRpnzbI0xPerWOWE80BFzLH2bZoIHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7fntAkf; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7fntAkf"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-594330147efso4479287e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 01:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765184692; x=1765789492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99Gq8zaJQDzmh0rJ9SfN0AY30f5+FLcQmxa4EMt1/ss=;
        b=c7fntAkfTqGkWkQmtCzybb3Hb57dEXiuElcOQhQJKIw0Al6BFGscItB6qdWQFSQxh2
         8YoONjFJFxnuTjqDRRh+WIxHgGFMZjKsFpRZEOF7xwv6Pe28giM5DSHExG/qBy+pBzQv
         /TdZXN3a+tJZWIWBbNdpI0KcbWJLuvIqy/DtpKL893dVrdvawi1kVXdh2S7dvc99kJPQ
         TifEfFfWS+SeEg7Cl4xar99kgiBS7ImhPUPdx5r5yQge9crlV4sfvW2j1IbCVIlwl1t1
         sLulX7M+51x6mPhrcc65+JFaLRqbcpCudNjAtpXlKpyPiQWIi/5NchXQGKXI+IxebLZD
         4TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184692; x=1765789492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99Gq8zaJQDzmh0rJ9SfN0AY30f5+FLcQmxa4EMt1/ss=;
        b=jSKThPoDkLPkdk+teiNcUI4kFTcQwDuRLn2iLiGb5JrWgRZN31SXfSj5V8zc3kvC0J
         I3JxZktZDc6IdyAuJWDj216li0NtY0mznVqbJOFod8WQxckag8HWjWQecqLcTntitaGi
         BUQQo/80ebjqJwhrN5IvfWXByBPuMTU5L7QczDoq6Q60TRXVNRSfNYjHYEA7HqM5Udlf
         uUh2X7fBo1wJaBVKYXWPmZXdvHyHgWN3AUiKuWHb3I15XFIA+C47mIAEOjoZdT3tRBlK
         4/QMCbs03uDu1ZIYYSMBXtmzwsb9YOr9qAfNH2nGAuBHXOT7P6RVsOpnf8a2q4B+xDmq
         LP2w==
X-Forwarded-Encrypted: i=1; AJvYcCVAP/VCNtuRrrrvfLZ0FS65u0du6CrNgUCYwxsMDREv5k/vx0hKdzByW9aVMQs1zXtTQiXV9JqERdxfJEnwTknj@vger.kernel.org
X-Gm-Message-State: AOJu0Yznamw3qb9E4YlEt7nX64tlouNJu2k1+Ug6Up/Q//HbN3wllGvo
	XrPZjl4hAOG5zDZNJAP/wfiIBgjVo8YQwvbocx+I/kBAmHX11NkKPHo8pJHs7tXiCZomORiWubC
	L6TcxZdvQtvNDjTP8PQSTY5yGd6DZR0c=
X-Gm-Gg: ASbGncsUCvpa9qWMdcz2pPR6BvEJpq6YaQGhBJgren8TwUtYwVUZbyo61ShA2RiZvVy
	7mLLmPX6CRSxNZwPkuyE83B/RzBR5w8hy7ODGJhFQzJwm1ZPXQB17p/N8SRgM+g8i0BkA6ihyrj
	Fg1ldurz/4yY5jhE9PjWe52R9FtOhEjGyvMwXbomfu6vPL4/T2gGzGkpK3VK7mtTtS9chcgOSFb
	wyY6QWsfggCK2ifUcV6bAeVOd24LpQDFNF+2dQA5xnT1jlNvIT4rxASDw62R+6udEI5aUgs
X-Google-Smtp-Source: AGHT+IFYg4OgwQnei5+rllOAVWB78++j4+Zx83YGsSe7RF49GOP1cWh92Apy+dR2MiJqMRHSfCoSe2uIDSC+y35FELY=
X-Received: by 2002:a05:6512:12c9:b0:595:8fee:fd8c with SMTP id
 2adb3069b0e04-5987437295emr2161703e87.8.1765184692098; Mon, 08 Dec 2025
 01:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124072310.3592-1-hupu.gm@gmail.com> <20251125163920.GG724103@e132581.arm.com>
 <CADHxFxT3TfdfLUYUqDqnx2ZBzn9uiSoDpo+R-u_t2U9OCoHRew@mail.gmail.com>
In-Reply-To: <CADHxFxT3TfdfLUYUqDqnx2ZBzn9uiSoDpo+R-u_t2U9OCoHRew@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 8 Dec 2025 17:04:40 +0800
X-Gm-Features: AQt7F2qByZg7q8Fjnr1WQW-PWExvD-tEjSlKPVYl2kwUxDMKLOUwcNr3z4N4Q44
Message-ID: <CADHxFxQ=RamXerAKMDQh_NGcgVtZ57yOTgXDV4jAAqcMy+Ef0A@mail.gmail.com>
Subject: Re: [RFC] perf build: Use self-contained headers from kernel source
 when compiling
To: Leo Yan <leo.yan@arm.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

RESEND for your attention.
