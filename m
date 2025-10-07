Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618E25743D
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877901; cv=none; b=hsW7YmoZLblLcR72wOpDfAMtpHwc1jsSiOkAxl6mGe2/Ry3j/EvPn2q8u9FSsV3e/hCq+4dbQeYTA1ouja+mc6LBvckcLhe1OQh3gKO5a3kn6tidZYBxFZF5uASj2Ei1lqJnk8pcnsOFXIiVwyLJpgw4Z8PAcid+ww0lmyQ/juU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877901; c=relaxed/simple;
	bh=5+KQiXKaE6mhudMxCJikU0TpZUEaf78Hz+t9g+4OaC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrAC6WRDIv0eqITQWLdA7VrwI7hYjTZeYNJgFYGVQHbG69sdOHCqjh1NPf6PItQmbcOsb+HHcw2fHgFCzRJYzVpMEL1AOxSdjXrXTNK3a2Qzc55tqPibhe7y2vVCRPKjSJqOU8zOsskIv2oKgOaeq1Nt02zl4LsH8Beu7BK7z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hHZvo2Fn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hHZvo2Fn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso6722305a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759877899; x=1760482699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+KQiXKaE6mhudMxCJikU0TpZUEaf78Hz+t9g+4OaC4=;
        b=hHZvo2FnIpNzBtb0yH7xfpc+ZYkANXLRSlsZY4+A9eHHaRoTXD5ur087sW0U3kakzz
         udN7qgZNVtPKhJmY7UMosAuonCbj8TLn+J5ahzBL74XaWMzmgvci/g8VklbtShn5VPSa
         KIbm4i20efZbuDvtpJiGrUFrxRoyN3+clrM4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877899; x=1760482699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+KQiXKaE6mhudMxCJikU0TpZUEaf78Hz+t9g+4OaC4=;
        b=uwDcofGEUIHYbHDfQ4v9okY4FQVMpGy9IJmN8VJhQUNRoJh0c6GeITK5U8GnwhoLuy
         G+7IiNvZ1kBPg2KY8I2RYJ5AJ4QLWzKxy+oLq1Hyqakp/5qhszkPknCcFCSZ9oDDqLmu
         CxSSYi4OMnsUGr26ab2X8SIdwB+4vcbnyPHl3QOH6iVNLIt08vSz5i/yZGvPh7z3w4qf
         WdxglR1pQyRyEov2tr4QQz4kL6BmGRTqy6buZKnBEa9yoO6EpW+hieuQn7d0ecmJMInW
         SvvlZujDg/VLN1S/B760By3zuHEAmZGMyhUrVVPK3XeSQ1/rSVLVwZbpK1xFUCv/TU/r
         pV7A==
X-Forwarded-Encrypted: i=1; AJvYcCV4IBr1Yw1QUY4UCde5KRr77XVJtwghHa+l0o5WKUuAgYU9YHuNn/FR4YJKJah4+uenqvLj4T9poUlgSJZlfkti@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTR0SiuvJqIJ3o0iJ315kGVm6LBNLBe0ndDNYE/yfUm7fUzfM
	xjDqrG5FGPVtR4Hg10KKLpp2dXLCdVOVyw25JbFh+upUSWs9n9mhwgoZIIxLb320/XWTR1AI6Cq
	PZCo=
X-Gm-Gg: ASbGncuNOZzREbNLAagl8jxHepl01yrYVdr1V2bqLHKAbML2Al89Er6Jpv/PL5Fa5B2
	vmle9tNmYBPR760vgE2dA+XzMdFKP7Lo0UB8y9qwPPbsvLmsUntkDytUZeFS0tMqLxtxsKQDukr
	dm/ZEcxyeqUQfK+TDk6XSvgKuiDC8R30uMTI0nVv3ql+mxAHRxJpiJgodvnS+/BsD/wxvmXPc/e
	bklyWGsA1jIrrW6Nwxtsrry8AePkWFHpB76CpukUuwwF6zFMggLA1bMFdo8U/+W4qWRVHD0YLMk
	gqGR7vfCRABFVuLGwW3AwjXuyMAtpKge5NkcyKu0iXVS8qaAXbWtCt98tQK6ULqZnmF+0DMODQ5
	Wz+uVVOi/Ji4G347MVTYjCjHCJyM67ZJMTTVdS0bRy6KkLy4Fi4Xu3IqGWBXApYDAp7K6mEE/+M
	h+cbNrR3W8psBA6NAFC2RSxHJM
X-Google-Smtp-Source: AGHT+IFa66PhLHgXwlZxNH4xRsK5XIFxuqFyASO61RziZXGmx20LhZKlvmsxlxPrAETFdaQ7iPfw/Q==
X-Received: by 2002:a17:90b:1a8a:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-33b510ff6a6mr1450044a91.8.1759877899298;
        Tue, 07 Oct 2025 15:58:19 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f2409sm39339a91.6.2025.10.07.15.58.18
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:58:19 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso4497663a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 15:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXexQT0SAtph2lod41ea+qc+0sAlpbK1nYq5HfPFpsCpD3gMt9wxXEYYMDMEKBEdZo6MqOmu+G2VsH4Yq/Lx+wH@vger.kernel.org
X-Received: by 2002:a17:902:fc4b:b0:28e:7dd9:5c29 with SMTP id
 d9443c01a7336-290274024e3mr13055185ad.51.1759877898085; Tue, 07 Oct 2025
 15:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev> <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2> <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com> <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
In-Reply-To: <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Oct 2025 15:58:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
X-Gm-Features: AS18NWCSxLhXMa6LWJavaPtuRN6XlQd4XglBJvkd9z7Rf77zdxFhI-J_rEr9-v8
Message-ID: <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	kees@kernel.org, masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 7, 2025 at 3:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 7, 2025 at 2:43=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> ...
> > The buddy watchdog was pretty much following the conventions that were
> > already in the code: that the hardlockup detector (whether backed by
> > perf or not) was essentially called the "nmi watchdog". There were a
> > number of people that were involved in reviews and I don't believe
> > suggesting creating a whole different mechanism for enabling /
> > disabling the buddy watchdog was never suggested.
>
> I suspect they lacked the context that 1 in the nmi_watchdog is taken
> to mean there's a perf event in use by the kernel with implications on
> how group events behave. This behavior has been user
> visible/advertised for 9 years. I don't doubt that there were good
> intentions by PowerPC's watchdog and in the buddy watchdog patches in
> using the file, that use will lead to spurious warnings and behaviors
> by perf.
>
> My points remain:
> 1) using multiple files regresses perf's performance;
> 2) the file name by its meaning is wrong;
> 3) old perf tools on new kernels won't behave as expected wrt warnings
> and metrics because the meaning of the file has changed.
> Using a separate file for each watchdog resolves this. It seems that
> there wasn't enough critical mass for getting this right to have
> mattered before, but that doesn't mean we shouldn't get it right now.

Presumably your next steps then are to find someone to submit a patch
and try to convince others on the list that this is a good idea. The
issue with perf has been known for a while now and I haven't seen any
patches. As I've said, I won't stand in the way if everyone else
agrees, but given that I'm still not convinced I'm not going to author
any patches for this myself.

-Doug
