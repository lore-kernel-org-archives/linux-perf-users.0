Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15088322A07;
	Tue,  9 Sep 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416668; cv=none; b=mRxpqV3p5svzjdrP/1J9290+cIdIBhr4fSpGMUbIMo2Y4JgGg7cEhpJtHZQfM0/2tuQFb1BFNihH51kRo7vnxTUMgZXgczpMcfBVROgH+w9Vf8oWNDfufevYDACxDiksM/8ntoVOS18UBJwEwqGoeUZlYk/9yuAvm83HPbjH3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416668; c=relaxed/simple;
	bh=L+5fYqbewcP5/HJs+VLs7JNvXN2ToMRlcI94DxOGs60=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KLrNoJsV/a/2IaxxQeB7WK9N3qLgYpSrJryLIpiwbb+EdCc9qeNyMpKzh8JHMQ/HEfh3MGV8hDoimMWgRXFtZCZRpazrkaAmW/ZOvX8O7sq+YnILTJHE49grWxOQePcYoItHxcGG6du0fiF+CoxGkHKyoTimmo9PLbJFw7CyVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKQi0zmP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKQi0zmP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so1848127f8f.2;
        Tue, 09 Sep 2025 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757416665; x=1758021465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VVljkgp7MvGpKjOsmhx2yN+YinrCOTHGa8ikpTuCGY=;
        b=SKQi0zmPuIvW085ahA/k+wNROq3FPf13LYDoqeieJRLLErXmqmDQrK2q6jwSkbmHEI
         4VRP4eluMNIvm4H4/WJdNP4PZnADRbpZS3hsbiYj1knTs+TXxfQFECmJDM1oUJvr0PVw
         nCNV+if/lQnupi42kqjFSX3eKmA4iLcWb+Dp31VOo3Na6QudszMfURy8GLS4qaSfWRBs
         0JVtgMkL1Ze81ZmFtUZCzZNO1/Dv+qzYaDlEaESS1u7/YzSfyzN4tgQa4+rb7H9TOsrv
         ZUgA26MSOXSVb4imPRjFT+pTDxHNxJV4jZ8CCHu0dP9kJbbtfQycOQdhK2eHij/GnXSV
         8b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416665; x=1758021465;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VVljkgp7MvGpKjOsmhx2yN+YinrCOTHGa8ikpTuCGY=;
        b=xREde60+GeALACNC33Pifl9+zmwEboJYhY/7w+g62QiQFz/aZOzf0Cm6Fc9Btr082H
         2EKboUQHA50EvEOyrYczZ+j00LoKtQBT5+dBY703Bl34RHRREWPljmZa5h6HpVwauU9z
         4tNJmVUrkwh++NVWpiFKC8riaeNEgvLST2JPw4Kcc+Av3DF0r9KjbsPjKLF09VWEpqvP
         c/fkBU/fRp7Iz2XsMkEO7ikQb19ARSzXm2vDUti0iI1ASq67/2Dl2rNY53EdDO/6l3ZL
         JqqDx5bPuSmnQoUtiieiUV3aTcNWjWkXfocHB4aCXqYT5lJeE4f/cQG/Fk0b8XZ7PQMs
         xcwg==
X-Forwarded-Encrypted: i=1; AJvYcCUybZk6p6cU2HyvWt+kse/cBx+/RnG3FRhyUEhA3GyKpTSDekJDeay1+GvMhIoso+d5KXpdyCppPn3/05SYmUs=@vger.kernel.org, AJvYcCWWvtRLOxGmjUmgd9Z+Ihin1qOtoJSQCNj49fNZRNoJzqQN/GC3DnMxbjsZlzDgx9R9BkpGQ7u7xKlLhH1JOiLZoQ==@vger.kernel.org, AJvYcCWrv4hZnE70sycudvb7reYWCKaosfeskXTVFXuDS3ATQgkPXCCKMFSPn/K7uw8GhDYMKSDILrHeoaRsakk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcHqcsNw7WYPuTKOnlXsAG0Vjo4mM3nXpAY/dBQ2FXgedObfB
	eEt7bxT8TXJodJO1DPsqvlpDt+J+zuG5s9N7t4dcWZKuqIlGSv1fPFNC
X-Gm-Gg: ASbGncvCGgsILT5O00p0gFOgpt4DTDLefPkL7+T8aGles26sU/RyJHmsPmnKhpDJz13
	KPyPGQI6zlhiPg3JetO4BT+YuiMn1Xka5KYqCJlgYTT0kI4+rYqAAitqizxLtO4pHHShbs/8Dqp
	DodJcf5JGcz+jGW0/m+NvRwlU02PT+SlEBPGoZ0SIuH5L3s00J/y9wnyHtFXReiSmLKRTRmqsjM
	h5G3a7XuGOvlBkCg4IoTcewz6RjJprQPx0xD8NTa21n4nyZM2Zvzx12G03fOVwjg1mNSA3EhBoM
	3wh8/fi84K+ZArustGm18FkPwcJUiGAFTlunT0dPG4C8J4qwJd70b8qOThl9YSP/EmCA+Ts+YgI
	KTcIjaztEXjhqIqN4Pm0jOBzC0qGzs66Y6Iy6IpC718MsRucb
X-Google-Smtp-Source: AGHT+IEs3II4xsTPMVI/xUzt3uonVN7P389tTb1caXREMy7D6ZwZPZdcAfgUGJUSd8hWdsE6ZsUUDw==
X-Received: by 2002:a05:6000:40c7:b0:3da:27c2:f51d with SMTP id ffacd0b85a97d-3e643e0807dmr10034707f8f.45.1757416665147;
        Tue, 09 Sep 2025 04:17:45 -0700 (PDT)
Received: from ehlo.thunderbird.net ([176.223.173.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf7ebsm2369801f8f.3.2025.09.09.04.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:17:44 -0700 (PDT)
Date: Tue, 09 Sep 2025 08:17:40 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jocelyn Falempe <jfalempe@redhat.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
CC: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_next_1/1=5D_perf_symbols=3A_?=
 =?US-ASCII?Q?Handle_=27N=27_symbols_in_/proc/kallsyms?=
User-Agent: Thunderbird for Android
In-Reply-To: <CANiq72=6yb5PZnuPYX3xWAms6pfYmfpoPj-GE1AZv7OfxcROJA@mail.gmail.com>
References: <aL9Ch_XaYTxMzFXK@x1> <CANiq72=6yb5PZnuPYX3xWAms6pfYmfpoPj-GE1AZv7OfxcROJA@mail.gmail.com>
Message-ID: <0633E365-72E2-47B9-B6DE-99E05D1E729A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 9, 2025 7:57:40 AM GMT-03:00, Miguel Ojeda <miguel=2Eojeda=2E=
sandonis@gmail=2Ecom> wrote:
>On Mon, Sep 8, 2025 at 10:54=E2=80=AFPM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> +       // a seemingly Rust mangled name
>
>Yeah, it is a Rust mangled symbol:
>
>    core::iter::adapters::map::map_try_fold::<usize,
>drm_panic_qr::Version, (),
>core::ops::control_flow::ControlFlow<drm_panic_qr::Version>,
>drm_panic_qr::Version,
>core::iter::traits::iterator::Iterator::find::check<drm_panic_qr::Version=
,
><drm_panic_qr::Version>::from_segments::{closure#0}>::{closure#0}>::{clos=
ure#0}
>
>From your `grep`, it seems that is the only one you see? If so, it
>would be nice to understand why=2E

Nope, there are 2 lines in the commit message, both zeroed as I did it as =
!root, I can see them as root=2E

Cheers,

- Arnaldo 
