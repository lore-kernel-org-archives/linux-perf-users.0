Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD91E51E0
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Sep 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286893; cv=none; b=Ejeur3p0/aPdbMFR9SbkZCGi/o7koYh01EpiTovOXDEn2fbHQ4nV89/lMJ0JrGLUOqC8d5+gXCU8o41BWV7MnOn3AtuULh3q2lVM29kG4m2jfyQ463z6fLSaUMtSiSvSvdPq1rBqmpMH42Yuoa4i4RVFHDWRk6tSpK2w2OidCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286893; c=relaxed/simple;
	bh=wo3tK6bHFA7DqiNO7PYI330tCwygBeTXt4YoEOQtnvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCiyvFkMHkLqOyPb/460KZ8UMbVgVuMJNL60OnrK/rS0NQX4lVeq6+Ea2wKVCaDuUw7c4ec34BVBYXBxtKenmBTKRN/4HsWYOeG2OJfV2DUmANv/d1tzHlphjP+l47Tk5EJ1tkvmURzF8f6z06hMChpVWKCnicWAVPkxm/xYHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDwwRIIe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDwwRIIe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b2d018f92so241595ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Sep 2025 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757286891; x=1757891691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo3tK6bHFA7DqiNO7PYI330tCwygBeTXt4YoEOQtnvM=;
        b=LDwwRIIed8+jP9h5vzReLPyBOvV4QVvkv2nv62uP2j4ZavIsnFKK0y6NiK/T4HycbI
         BlD0FUPTWyMUkhjgYX2d/z85TcdxwFOcXb7x0DblyBXm4zwVFslIvZ3NSwbmj4Q7b2xv
         1HghuV6otkpg1DFHuZmxgVrWKerd1A36uSH9UWiT2BQeY0gW0juoeAz9rYiLISQa/jHa
         n2OIKskNhax+/4dZSO1OOyZfRewasfNx5A7gpdqT9wsmQKb4tfzSwPzMtoMkS0yWQLuR
         bvWCfUiJA6NdWD8KGcJFsMuXDWfHMBOgsM6qgbbSJBi67Wx4CpMapaGshFGfICCT1ChD
         ht0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286891; x=1757891691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo3tK6bHFA7DqiNO7PYI330tCwygBeTXt4YoEOQtnvM=;
        b=GfFwUssaupc3n4e9Rocn7kFrWP0Ky5NUNoWkycL6q6FR3SVeZW4F3461jgIUBCIHFU
         9KkoaF+UdXMh/AhJHANnTPy6QlR46CS8BsJVxixYAM2AsRD/7dDZTvL3urEkN5iw+yqt
         fV+7zuykyOFhg28ypNCeKio/J480ctzpatnFk9tSdZ8iFByZad41XqGP4pjvaxw1DzKL
         nDQMCV1WgPAU0a0wVrACJI9ccA41wrOJvLFscK1wXuibyFFG9RLnEEI7Hd8BckNWH/Nx
         RejHQNJSH+4BstMVGy4Cs7+s8Jv1ok0Jvf1SCvOu8UxWqonmK0yDcKwIoXl+gMkzH9AK
         aSZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWtcO7rTu4XBnbeJ+kk+J1UNmliLPk7YNuF2Ek5EdKQ6O1lhqyKIdadvGrFOANPXxejd5X/huz+QuOIOpdSIKf@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlSTA7SxBsh4hJdqzSH89TfFCS2x95dksTRR7j2S5clBNHrNN
	iqJ0xn75qHQS7YDGig+5ofb22MZAOlWNerv1p+Yvm/EEe5d/2T6foeWFT/LBe5P4b36OffLosRH
	Rh8MMtua41pNxPtGFvKmQ3AfMLUVTVchn1339JhMc
X-Gm-Gg: ASbGnctXw4UWK1IxNloFodTuW0kSlhPW7H3pTxW0O7M1s647jjKGFfw7FHMVeUZlUQC
	tWLkjNiaQaPHnPFwJ7E1ULfBGxtruAnzXZVCADMgFkjEtlwcry7ciLuOHHVEl98HPrXe+EHcyLW
	8O69/n8IQtrF2g8ee9f5mouMzv7zNA7bnC8wUx6L1ZEZMXcxcXwpaJOKad6neSf9235dlsAkoVL
	AW7hcQ4YZORJ4w=
X-Google-Smtp-Source: AGHT+IEltd/sAul6Dn7ms8HB6NIeq1vgyjW8DOdKH+H9ryQVdD/7vpwWCRfh119NUS1vpsfKq75+rwJhHcfHD7PiJjg=
X-Received: by 2002:a17:902:db11:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-2510f458c5emr4290315ad.0.1757286890641; Sun, 07 Sep 2025
 16:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
 <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
 <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com> <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Sep 2025 16:14:39 -0700
X-Gm-Features: Ac12FXyVydF5cSsxyRKJ_un6fARDQ6-2DZTw3qkJGbuqWtoGH405LU6WKebU2PI
Message-ID: <CAP-5=fWkcxvZ0z9FJztbN4EhU+BNEJTNxe2a6_+11EcYhjZQaQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Doug Anderson <dianders@chromium.org>
Cc: yunhui cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, atish.patra@linux.dev, 
	anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	catalin.marinas@arm.com, masahiroy@kernel.org, suzuki.poulose@arm.com, 
	maz@kernel.org, zhanjie9@hisilicon.com, yangyicong@hisilicon.com, 
	mingo@kernel.org, lihuafei1@huawei.com, akpm@linux-foundation.org, 
	jpoimboe@kernel.org, rppt@kernel.org, kees@kernel.org, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:57=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Sep 3, 2025 at 4:56=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
> > I=E2=80=99ve read your linked content, which details the pros and cons =
of perf
> > watchdog and buddy watchdog.
> > I think everyone will agree on choosing one as the default.
> > It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=80=
=94what=E2=80=99s next
> > for these two approaches?
>
> I guess to start, someone (you?) should send some patches to the list.
> Maybe one patch to make buddy the default and one to change the
> description of the "perf" lockup detector say that its usage is
> discouraged, that it might be removed, that people should use the
> "buddy" detector instead, and that if there's a reason someone needs
> the "perf" detector instead of the buddy one then they should make
> some loud noises.
>
> You'd want to CC folks who were involved in recent watchdog changes
> and make sure to CC Andrew (akpm). If folks react positive and Andrew
> agrees then he'll likely land the the patches and we'll have made
> forward progress. :-)

+1

There are also things like /proc/sys/kernel/nmi_watchdog being used to
enable/disable the hard lookup detector. If we could move that to a
unique file so that perf is less confused in places like:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/util.c#n70
ie. perf shouldn't warn about the NMI watchdog being enabled and
taking a perf event when it doesn't.

Thanks,
Ian
