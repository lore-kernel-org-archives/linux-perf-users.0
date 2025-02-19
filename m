Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0B1D79BE
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007947; cv=none; b=jNgV8OYpj4P7SD07UZcNfpnBMW2Xkb5cnBXi61whgIDP21I4i+mDlvF5jW8bvq4qtwOGyVYlHMoLSsVaMK6zTic1cfJOtbtPf7G5qtI3pQICzc0cb5LkHt1ml0sbTuoldnjFqNo62qwA+aJL7tWP1bJUz0b8PefXmk/zvB11ARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007947; c=relaxed/simple;
	bh=JsuY5aEnKTjWIegGtTXkzfenE0PnT/5RTkOFNi2Wbr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c89gkx8MBTUzvG13E3VEh15vxKGSyqPPnD+Ax5DIpZwH2VDPnwthdGvD16zc8TdcW5AX8qkxzrhn0Mr42wlyuaoWUGZri5eh515nc5yXVGqdYCG074tmM1ZhjbS9nt9lgD2iZjoeOwvRaP9X64tvSqXXJJrs/FZxe8a7+jMvNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQqBPZyE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQqBPZyE"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so51515ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740007945; x=1740612745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RxA4eu4dfq7Zk/1pUhMY39No8gQgsfAHQ8YKi/sOm0=;
        b=OQqBPZyEs799NwJYwyZS8KVUW0aepoDMJaLS4iRzOLOrtV5u7PmYbhMQlj57qBaIk6
         g5VFj/9CjKXVfDaYxza9SCdkTWNB9x80YbXn+BPUN0AlTIEnc1Bx00YcmeE8/pgoQOCz
         RUxrhmiKDzSnPCDNk8cWQlh4q/opjGZTY3h2PURzwyufXKcCHRw3IrPesBnVO0Jgn3mT
         c+BgkVxIECrCakBq/RvHJx0ZjYwKEtJkMy2WdDAssP0pHC4B0r5++RyYDevvXb5BMlKT
         meCZSieSWJ9+jAJp4dGiO1h47sE+BTNqxbtUu95ArrTSGBAAcYIY6Ky3YwjwZVrRN8M0
         4U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007945; x=1740612745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RxA4eu4dfq7Zk/1pUhMY39No8gQgsfAHQ8YKi/sOm0=;
        b=BJUeiGngmyBw7RS6XBHri8Mu2/I7yT4IAm/aYcWmQZ6qI+rQeJG592xdF42LhIXoeh
         ei435sDvCclUmiEzpJf+vztd2CrVV+LTMFNxUBmytym9nuOF7K4KRh8YHsLsAkPsJwxy
         MEoSHcXYtBtMPjRtivxEtWMGtysq0LEtHrU1BKSL95/l9BM+JAw3GFoCo3AG1MxHWGLI
         4zV7qJ2wVuoyXL/JfnGE1prhf8m4haTxXhhBHbQOgZ3qrVTuZBcAfnDQq2J07wG62S1Q
         QavnTXnC6eCCkRR7RbNtFUR1qc7VYeWqhkaH4cx0Y4O6NFMTLFi/r3dB9oq3ce9ZFl9O
         AmiA==
X-Forwarded-Encrypted: i=1; AJvYcCX6UJTcWPH+2zaYg0vkReamPplOU9hrVrjfey55cDkpV33X82LrAMhtHW/rPkAfNlCd1YwGJ8BNpJx4dlJ1Glgb@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGYZ/bD7ZJ3RODGqOKpBI7XzlZdsLpE23Zzz6ZNyMLkwRiAkL
	H3+gkbxAa++S08QI8YTj6ZsyGVSioH34VbBMtsiMNmnUjBYu783plFgcVNvpkin1XJLVVJ7EYfg
	spEUZzduaCKBZc/Y0i7bZw9/f/znIcf/OE+yN
X-Gm-Gg: ASbGncsPTtfH19+IASVAiiuApdbYtP7VIv4oX9fRH6S0xjlbH8oerwDX90ug2xrqB3o
	pomVN+3JoR3B2L+724xcNGPpjK2bxGNWSH2lnutRkdO9EGUE+GqPcEpvQ+zCKVARWoIBtX63qjy
	Z9UYXNBWwZ/WouhucAyvt3Ci+Ezg==
X-Google-Smtp-Source: AGHT+IEYCkfJ1ZVGVS5yNULY/6v2ccbPdb6GmoCQPY2XQXgN3GgKXem7vryx+NCZihS3hzRZVe+ZGvhMO1UuJUsNbI0=
X-Received: by 2002:a05:6e02:2193:b0:3a7:c9eb:accc with SMTP id
 e9e14a558f8ab-3d2c0af361dmr1166825ab.14.1740007944860; Wed, 19 Feb 2025
 15:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com> <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com> <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
 <Z6RD7NuT9IPhOkIV@google.com> <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>
 <Z6WPmYCJcc6pPKDA@google.com> <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>
 <Z7Znm47DJcpAsvGI@google.com>
In-Reply-To: <Z7Znm47DJcpAsvGI@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 15:32:12 -0800
X-Gm-Features: AWEUYZkz89bL95SHTcyTv0XZuZJQ49X-HSItX_LXicReGoMS2frdXtXZWQMqHd8
Message-ID: <CAP-5=fXCzwWOJMTfxDToSxsr9Ox9KjXtNXkpLhdS5CpSzG4RUw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> I'm ok with preferring JSON over sysfs.  In general I think they don't
> have the same event names unless you want to override one.

Thanks Namhyung. I'm not clear, what's the plan for this patch series?
I know the clean up parts of it were applied. Are there any actions on
me? Are there people to solicit feedback from?

Thanks,
Ian
