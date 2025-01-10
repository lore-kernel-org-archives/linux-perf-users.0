Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0F20B802
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503766; cv=none; b=otamkxfV8N4wahUl721lsvu09eZdlJ3um0f7i9Ko+u+C7+5OB87RtAv2RXCeKv9NGYcGOL8UyN0HywkwSLDOoo5HQYjjelfKs4XYpVBML+IfdgttLBks/i2wQYqSe+ffIP8zB9OjvVaSD1WA2Mn7/7untKpiv2i/W1Fb9sZze+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503766; c=relaxed/simple;
	bh=uxyKD1yFWNexlkuyW0l7JVg+adzsE/DwBFF+qDJSaiI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PlFrQv3Fbtfd/LMpJAwFK8QYdvHmYUZ9U9FRuNAVk3TP4LyhT7zUUktCOdYZuanDgnALmrGGPfwiIC3dEf9tBMF9W82Kr84ujWQCY7IYOiV0YqmioPzEOPw0CblU37J69ImV/ZNQovNkxqpFeJck8e8VUs2lAKsKw5s0IaRqodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzvZrp2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzvZrp2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736503763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxyKD1yFWNexlkuyW0l7JVg+adzsE/DwBFF+qDJSaiI=;
	b=CzvZrp2aCJiNWvgq+J0rIUZOiOGH/58pi5VrxpC1Jnt0X8LaRN6bJI85vcsazAWTVXYKWD
	NR6lX54bnw6uV7DY5bW04ePsWCZww7LCCBi3v+6uh/IoEGTCooXOV5ZgEfB50WlpDk/jkb
	NbmbDvXv2OssdXt6+BUPUrvP8V15pMU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BW_aga79MXqUfNUd9MJLHA-1; Fri, 10 Jan 2025 05:09:22 -0500
X-MC-Unique: BW_aga79MXqUfNUd9MJLHA-1
X-Mimecast-MFC-AGG-ID: BW_aga79MXqUfNUd9MJLHA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436289a570eso14989925e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 02:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503761; x=1737108561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uxyKD1yFWNexlkuyW0l7JVg+adzsE/DwBFF+qDJSaiI=;
        b=hqqOO1WvdLkfynDzl36knXtJh1/GlC5n/XVPm9xF99h4Lk0YPsd8xLf5UgGgTp76Rm
         7KGdZDI6k/NlmN7xofq64mHaqSqES0/1GJG9HDUHgCZhh0orpxWxgS1i+pU/3TYxh+Oz
         xQ0SRlDx8AipUTmJma7aLM4taxhPay8DyzdSrRsCzugApIDbligk03aOlpxsrZ2plmay
         gxTr5HmIMf8p2Ktz4ceE9tpkCj1yiWGzRlUQEfmATfD8EVDJATSxm+QZ0QBiLM9fKspy
         8sTStittvTy/Z0yrZlaI+50wq4yxvlLo5+w8snt09vjSiV6XhMuF0B/CwtDAu51g/w90
         xkUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxdVC55Y44gIPbvEvQOhkwwWBDYeK3FZE/D46mEJdQfU/KzqBvA9EKTNX8VwHIPUsxy+PPVJ/UL6eNHbLOD+f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1W0cwaL138IkNXv28rM6DW8KyyRDwBAoZGI5dJbnUeSxgX1Bu
	cwv9mcQ7P/ksA0FOKZ0As5L7wvBhcaiSZS92rrbfKoZDInKOP6fFAyWjRe/JF6XArM9UoxBjBKr
	4nd1TcWOK5rnqoz3qZNO7c2ZeWhtp7HfpHUeb3pkVgWCO4hNetPs+u581yT3Xc+xXw5FC1d8coR
	JB2Q==
X-Gm-Gg: ASbGncvA9r3vRk6UX3JBkmoMEHtd9NgkCkFPRQ+ZU38s6vunuSSSIVq5TX8T1MBvign
	fThhy0qw7EFNdxtIi5xO3XIOrIolWEWFlIvNvScObaRXpeuQDURoAJWsJ268/35c60uIlLfbzUt
	NzZCJoINnRw8ov+f1Qlyul+sniOQ38PMptwVw0XdrX9fouJmR969R2p1yqPyiEx8ieVPb7+CC2d
	EhBySHyw9lVr7Tz0YNLCu2qaMaDLP641FpU94ZdmgZn8BQ04qDH0g==
X-Received: by 2002:a05:600c:4f4e:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-436e26e28cemr94156265e9.20.1736503760916;
        Fri, 10 Jan 2025 02:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXo4yI+p9MrPaWTe+SRlvW/0zFOsPyUR5eDb2Y1KfaN2kJ046qwaOXQboOe8GSSW9lEF4M5A==
X-Received: by 2002:a05:600c:4f4e:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-436e26e28cemr94156045e9.20.1736503760621;
        Fri, 10 Jan 2025 02:09:20 -0800 (PST)
Received: from [127.0.0.1] ([195.174.133.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89df1sm81071295e9.27.2025.01.10.02.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:09:20 -0800 (PST)
Date: Fri, 10 Jan 2025 10:09:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Message-ID: <0ef32d5e-594a-43a4-ae5c-e8ad05a2d320@redhat.com>
In-Reply-To: <Z4Bt8aIkX5uErX8a@google.com>
References: <20250108210015.1188531-1-namhyung@kernel.org> <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com> <Z4Bt8aIkX5uErX8a@google.com>
Subject: Re: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket
 range
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0ef32d5e-594a-43a4-ae5c-e8ad05a2d320@redhat.com>

2025-01-10T00:46:49Z Namhyung Kim <namhyung@kernel.org>:

> On Thu, Jan 09, 2025 at 08:53:02AM +0100, Gabriele Monaco wrote:
>> On Wed, 2025-01-08 at 13:00 -0800, Namhyung Kim wrote:
>>> It's an optional feature and remains 0 when bucket range is not
>>> given.
>>> And it makes the histogram goes to the last entry always because any
>>> latency (num) is greater than or equal to 0.
>>
>> Thanks Namhyung for fixing this, something definitely slipped while
>> testing..
>>
>> I confirm your patches work well also when the bucket range is provided =
but the
>> min latency isn't.
>>
>> I'm wondering if it would be cleaner to propagate your changes (using
>> min/max latency only if bucket_range is provided) also to
>> make_histogram. That function currently works since we assume
>> min_latency to be always 0, which is the case but probably not
>> considering it altogether would look a bit better and prevent some
>> headache in the future.
>
> It looks good.=C2=A0 One thing I concern is 'num +=3D min_latency' before
> do_inc.=C2=A0 I put it there to make it symmetric to 'num -=3D min_latenc=
y'
> so it should go to inside the block too.
>
> Or you could factor it out as a function like 'i =3D get_bucket_index(num=
)'
> so that it can keep the original num for the stats.
>

Good point, I can have a deeper look at that. But I'd say it can come as a =
cleanup patch later.
I have a couple more changes in mind and this would be no longer related to=
 your changes.

Thanks,
Gabriele

