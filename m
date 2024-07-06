Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A517753
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jul 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720296198; cv=none; b=pNYyF21b0BpKVsTRCWXJWkef/PRZ0aEjdef79K33/cPYUEZg9ID6lBvBNQPmVeRzeQHrzDMt4zG2sHdNNwlQdR6NrkvdFh+axsI5Wpf+xQ1bAGzWil8ToLFVfcXnIDVK2cCDaYx5Bbxy9Yex6DI8Eafeel65C2cPYmy+bIMxF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720296198; c=relaxed/simple;
	bh=Ra4SsSgNnkb6AcgXykU5ox+WMiMnyxDh8lGNql7Ad1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt0XUVyY++lG6NKyGe7TgeaTVwj0rGUBtrahiH4MsNn10R2gCzIpL5EJXndeYYu5b+mKh4K+o+pietzOCD+o7Zr6mLk8N0fc6P5dy/87Er+DBO5JkeGen2fZGhwLaxehbRi6or5NCQUIbQ/xkqXzyCQZaeRRaorSsyVebiB/lcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fDbZiHfA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fDbZiHfA"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e035f4e3473so2388956276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jul 2024 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720296195; x=1720900995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h77256I1GiE3p9I4YnWsSahI84rl8Zbos4yv9AgBkTc=;
        b=fDbZiHfA3YNVh85sTLw3GMCgcDeWeQngbLooHcdJwS0v42bj/0MF1v/+UpUURYnV1Z
         CgsDltHtXZKI1GpBrA+ylGPaNz+4zr8cCLiFBPoazqhgfaO4EP5KziPAcuy2Qr9NS7na
         8EgT1JStbkuO/2+QnT7BValUAKaGnJ6UIjB2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720296195; x=1720900995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h77256I1GiE3p9I4YnWsSahI84rl8Zbos4yv9AgBkTc=;
        b=ijgdurE/JfX/yZQsqTpsAxlACBeg8gxFcrnQ4o1WzxwSwwFogLKLR+wSwe5BZ+L321
         D8Iyyb/jRJxgLW+fph1d9UrKy452MBxj2IuvCErYsTo7hC5VNJIhRKD5hboh3PdP8RLy
         QsR199vxVWzhDzUnTSAlZxgxOf85uNE3NggQNrSHCNkmgpHm+1bBSOUvZMc0F5dfHBQz
         bdJtHWGLXrvkPbIXWEkEzYR4BvAdzcc3aQdoXXiuISlkI8L3qAv+XM2aOeBlHDxIUkAd
         CbinAvblVebdae03baQbOkhs2OWo4yvRX980nDjf/1/t6HGYbn60pyZHQjMHDdYLrK64
         5HGw==
X-Gm-Message-State: AOJu0YwhWrojgbDCj0f1sPuTxrz7yH+Dgz76+Kvu1YJdKySFlHFn2cy0
	GSjE/5CGPmvQtEEj2sem3Z9qFaT/0AUkEvHwFjwlwCuudufh1Nnj4cigrpFgQ4YbXdR+uVGmMVt
	tbI852Q==
X-Google-Smtp-Source: AGHT+IGhyBk6O/B3jt6vPok+PPCSL2wOqf+iNOXENtL88CIFkW2ZBRG1N5WQ5SHi5v1pyr9Vj05YeQ==
X-Received: by 2002:a05:690c:6c82:b0:63b:b3b8:e834 with SMTP id 00721157ae682-652d7683a93mr110366177b3.32.1720296195517;
        Sat, 06 Jul 2024 13:03:15 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8100b5da65bsm1358974241.13.2024.07.06.13.03.15
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 13:03:15 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f301629cfaso492124e0c.3
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jul 2024 13:03:15 -0700 (PDT)
X-Received: by 2002:a05:6122:2408:b0:4ed:5c1:6794 with SMTP id
 71dfb90a1353d-4f2f4016dcfmr6361826e0c.12.1720296194697; Sat, 06 Jul 2024
 13:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
In-Reply-To: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Jul 2024 13:02:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4tpUpyT9VD2StVusGwqZ3-YbN2PkZYrPtYceiqZrXuA@mail.gmail.com>
Message-ID: <CAHk-=wh4tpUpyT9VD2StVusGwqZ3-YbN2PkZYrPtYceiqZrXuA@mail.gmail.com>
Subject: Re: Performance of 'perf'
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jul 2024 at 12:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>    [ perf record: Woken up 9675 times to write data ]
>
> and then 'perf record' will just halt for something like half an hour.

It finally finished:

  [ perf record: Captured and wrote 2537.391 MB perf.data (40467904 samples) ]

and yes, the perf record took about half an hour.

The build started at 12:17 according to my timestamp. The vmlinux file
was done at  12:23.

And the "perf record" was finally finished at 12:55.

Sure, it's 2.5GB of data, but it shouldn't take thirty minutes to process.

                Linus
