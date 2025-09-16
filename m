Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF820F079
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991029; cv=none; b=bqMfFCty0qBxIA93jAeV1CB6KvvKVcsHeBRL0J6USHmVSzMdn7STsAZDKICAde6nvxJMhpDWaLLtRd3bJEctmB/HmUtu5/hPwglshMNRyms42RVbh00oyNfTfPdNqDp+M/b0wBoAI/lLrOf3n7jBY7y1ujYTMySIBlOrH0NK4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991029; c=relaxed/simple;
	bh=0BZScZqwkLp8TBGKyHYDvCnuDY5A4//FIvL5EisHnTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYVm3nXJaQvVpavM2IK2tZWwRHNAZ8lChnGAwMaI6sOyH/sIYw8tWO7I4jy8+kwxlaKiZdsvOUqSlVtbByKD5Kh60V4ggm8P5htnZt7Irl+WNYwuuJAAGGH8eGGVY1TWynZCWE7WozNT0IJaCtUO63GZuvCoXwnp1DMvSvCK3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8dNiZd7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8dNiZd7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-265abad93bfso87485ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757991027; x=1758595827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BZScZqwkLp8TBGKyHYDvCnuDY5A4//FIvL5EisHnTk=;
        b=D8dNiZd7hJWHDzCbc5Peon1WCZXAIArdWbvKO7uOCPloN4STNlbhShpGRdNFlX6zYF
         tbizWMn3hONzAOrXdBY+z2wLAblgUG/uXFJ5T0tMCpU7X7FcSDq5dFz3zXp283DVxbJo
         kdD5NzUbVckbk+ZaVh8Py4bQwmOnFFvGvo1UWNxSivAcxvqrn/eV2qxyuMSgPUQtwO65
         CRoGQb72+sFivtZxGMBLzVEFHmOMFUJwiro3U5MYanyp+W2Y9lhyvnNELWUi6QfDiUSo
         FkcC17Tc4FW8f3k63GHxlYNAOOR788bTR/ws0fwftpyOJnd5N+dAdZP+Z/GGnvxySyp0
         K6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991027; x=1758595827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BZScZqwkLp8TBGKyHYDvCnuDY5A4//FIvL5EisHnTk=;
        b=M3asAbXu/J6H+LisrdqLmGexrmoe9MuA0eBRSeerDGXcluQZ9yJH3gUH9p1R3ODNW1
         SGrxqw2XGj6RK4pqwTdIKuZht6o7K0OHKe/ynDu7MB6BET6EJIKiGshcttsb8MkkLy5h
         FryVrxgPWEslpgKaRean1HcOSvvTXqxhKCH3s0pxyQ2BDOwQBBTSjzt8oAbMkFG+T/Gr
         KrhrETAprxalXtp5qWdw9z5SB4CMj9Tv8a4b3gz5dS5Z/hAx0bTwlNHiQ1IaFZ8vgd5w
         wA2JXSEB4jrdiIs2kdjL2MPtxo6h5P9w9GxOVhsGIfOhFzS+i9kGI6G2ulXqyJnunyWM
         Vb0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzJ0ztQTpNDjCXBDgCgFBW0z/bB02eeq3+OAK77qY0LedK0Psfa56ulTuX+eKpzGHadSrBiVpeONrg/vbO57Jc@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUTxs8pQizeHGaKVb16aw0PHycclbnQ7zEuh3vxHDQuPzDtA3
	S/lZfd4iSzk0gNp37WsZs3zV6Z42LwDy2hGjVb++Wz+SzGcR6feUGkX+iWmznOl7VwCFDanTnjv
	ETEGddg9y2pBnAnbeIUX2nkuuvsE6Ztk/hOKqgSNK
X-Gm-Gg: ASbGncsG7E7Xa9HF1YsONcoK3eYDC7rJaLU6XG3mzdrJtOPaUZaQAhQM/By0FPKCuQs
	THZ3R1HJjeeeSVLwup36A/FiBMstj2WfGZYv/+u1fUdLLq9KhyTjU45xNPqai/FoFPpbhT46TVn
	YYfSdyGh2m248zoDfs8y7j4BPS46TAgwHvnxGTWLFUUAuAxiRhaxWb+xudstxN6ouA+rY9p+djM
	mA3qXXIirPI4AE=
X-Google-Smtp-Source: AGHT+IFeyVTW5EhpdU5hsvYCz6r7UZGqUVYyh/d/fgXFv2LFAjtq9iQbsFb9hepaT779jpkPhC9wzFom13aDSrCRIGk=
X-Received: by 2002:a17:902:d2c1:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-267c9e63015mr1730905ad.3.1757991026132; Mon, 15 Sep 2025
 19:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck> <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
 <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com> <7366f87a-1924-4dac-8945-389e6674213f@gmail.com>
In-Reply-To: <7366f87a-1924-4dac-8945-389e6674213f@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Sep 2025 19:50:15 -0700
X-Gm-Features: Ac12FXwGtpNoLqYtyQg6lqv50KBS7uhzhnYxEQJsAkff9-AdgmNoT3fws4BF21Q
Message-ID: <CAP-5=fUs7WPQ1U-iXzZQDwa5Bm0Fg11Riw20AFnDDOScoY6BnA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, kees@kernel.org, masahiroy@kernel.org, 
	aliceryhl@google.com, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	xur@google.com, ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org, 
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com, yangyicong@hisilicon.com, 
	gautam@linux.ibm.com, arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, 
	lihuafei1@huawei.com, coxu@redhat.com, jpoimboe@kernel.org, 
	yaozhenguo1@gmail.com, luogengkun@huaweicloud.com, max.kellermann@ionos.com, 
	tj@kernel.org, yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
> Should we support both modularization and changing the backend after
> boot, so that the user has the choice?

Having both together and then being able to choose one or the other
sounds like the ideal solution. An issue is that
/proc/sys/kernel/nmi_watchdog is used to dynamically enable/disable
both watchdogs and presumably renaming it for the buddy could cause
issues in user code.

There can be unexpected consequences of the buddy watchdog, as the NMI
perf event goes away there can be extra cost in setting up the first
event such as allocating buffers for the PMU. While enabling the NMI
watchdog to avoid this cost is kind of odd, I think users would be
glad of a workaround for what may be perceived as a regression.

Thanks,
Ian
