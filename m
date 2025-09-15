Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DC220694
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951306; cv=none; b=akMYVpSiAQqwIFuEWuOlyTumUTaqN86URUasIhPwStXwSmx31Y+HM5nRiDsS2o5Q+rc/0ZT1Wz3Wa++n1K4QyP+G+izhCNWt/ZJ052PIBTO6ZT5o2X5tkdi5u5TP+7tN1OGpZZ9GaDEpX0rt2qABk0derKHgs251TuuhjX76E5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951306; c=relaxed/simple;
	bh=2FgZf+GYVPbUDHE9BFwH1ejC8shiR73nOyJCnPx8AuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIeOb9uz5r69Gwc82eGlKfkTyEdsiZhxV6Bv0xAweeqTnNQM/nytCvwxOXnKgDJ4JaTEmpFJyirmBltJJQuoyLJWcAkC6CLXq5BFzye5qWOulQ1evkUxBBV+4NbouV72moQP4QyuUQALDTF00Uc9+0toxMWqKLzfTraWqbJS43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZA/g6tWQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZA/g6tWQ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b3d3f6360cso40513991cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757951303; x=1758556103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF9n47OKYupJ+YpHurEgKB2LmOn4YAEsHDSQn4dI9Aw=;
        b=ZA/g6tWQeWWxTPnzJhFjJZZdDH9iyufBrKQ561M4dshahas2XkheqO7dLpiRyDeuMt
         bo2FuYoZSMBbl1FjcGYHjZE16+Mxbl0Pkc0UG1fXTyol5jaw4U4qUCecIQSFxbDq4g0b
         Z1zMdQVWQj6nGV34aj43Qo3NJ7NLZzkttHlfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951303; x=1758556103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sF9n47OKYupJ+YpHurEgKB2LmOn4YAEsHDSQn4dI9Aw=;
        b=fA82cglCTBZD/rlMWJlTKP5mlmVHjGsiHAzmg/y5SV7S1XLQ9w22CZZfdVtJgGrcQs
         PBj10d/6vChcvjCtOrX72xRXvvtDz+ZaZ/z5B8CNPyyOm5TSrDHq1ipRIotDaF78zVZ8
         5MTug8Uu2ztaphT0RT0Ie/ET5FqGxXvLMUL/tzZgFDXsAc84WHQv124KkrLiXXqeaj+Q
         6HpCq7zAR92HL7CVCoCIY34+ziRJNo2+YQ13Sq1Ds00oiKecPNT96VmrNRIp7wCbvI3r
         L3foS/2AdRrL1A3XPBPJwgGOddF6yEnPfHwT9woqS7n+ili/DT/HujL/kglnA4bftJ4F
         LEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiSfIbxMQTvIVZPmggrFasIw6R4BzB39yXcOJ/9VYg+SU0MoWWx1RliV8ksYnue7p7GKgEek3mqNGiSMZcUh+A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wof0gGRG6oEoXFpNiTAigBRQ8MEmkAgTJWQ0mkGGAGbgiCDw
	lwTsQwuu2HyG2EF7Nm1AMd1yj/YJVPTXkbYcxkWN5R7WfrBYlbxb0u5966cI9aYWG03349cW275
	Qirc=
X-Gm-Gg: ASbGncvZ2kXAFMq5Vb2AVs60KVy9S+KcZ+HW+FDhUl/UL2Ps+ggma27DU02Y8JYoXrx
	ddS34IabQ8T8MNofWEyWjEd6AME7MwuSeVet8t97wWV5ba70joRk0me7dsyzGo/EesQJ8NSR+Rw
	zpaUwUj3gykXrYnwodGak0Ekcetc+fkst8rabFoWOMYuzf54auiczU17IB7JLLfza6Ux/+fu6Cj
	vKXraJtpU2f8LxrY1kKpjbRXV4fgtbBTXmyagW7Tqxu+KJSkPeNnKVWGjSsdksRMT1qVvRZ0QzI
	AbDVaMuyXDL43KRwHWsFn/tQU1VFVxWlQvrihfkpyfaLAexmDxjHfg65Yz+NkcTK0ukKJrp8UCn
	Q6NiwdjCXRnk/fKWPYBxYQyP/AIADUBnqaAQoUvboRT1pxRMbAtdwSBfjf1Ju9A==
X-Google-Smtp-Source: AGHT+IEx+1+0pVLa0p6KSmIEq54TU1WDDmytEM7D7T5yIOBQh1GmfiPvGJKxPrDp3HCjZmht/s7ucQ==
X-Received: by 2002:a05:622a:248c:b0:4b7:a62c:3739 with SMTP id d75a77b69052e-4b7a62c395emr60812051cf.44.1757951302697;
        Mon, 15 Sep 2025 08:48:22 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7a6a99c01sm17606811cf.47.2025.09.15.08.48.20
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 08:48:22 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-777fb17fd84so14577666d6.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 08:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSrREXEuMqu/dDHomDtK95bCFC1rEXArITkGG0zH5shaDpvXZtBk4c20jxiMQNHJUUSAvDseP8KSoftAK7kRUv@vger.kernel.org
X-Received: by 2002:a17:902:e80c:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-2640ee2d03bmr82023175ad.19.1757950933588; Mon, 15 Sep 2025
 08:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck> <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Sep 2025 08:42:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
X-Gm-Features: Ac12FXzAoIBOvB7DdouVYRPtMAe3U5Dl3CUX53Fx6WzMzB918sSg5cv2FslrCvs
Message-ID: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org, 
	masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	wangjinchao600@gmail.com, yury.norov@gmail.com, thorsten.blum@linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 3:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Sep 15, 2025 at 11:26:09AM +0100, Will Deacon wrote:
>
> >   | If all CPUs are hard locked up at the same time the buddy system
> >   | can't detect it.
> >
> > Ok, so why is that limitation acceptable? It looks to me like you're
> > removing useful functionality.
>
> Yeah, this. I've run into this case waaay too many times to think it
> reasonable to remove the perf/NMI based lockup detector.

I am a bit curious how this comes to be in cases where you've seen it.
What causes all CPUs to be stuck looping all with interrupts disabled
(but still able to execute NMIs)? Certainly one can come up with a
synthetic way to make that happen, but I would imagine it to be
exceedingly rare in real life. Maybe all CPUs are deadlocked waiting
on spinlocks or something? There shouldn't be a lot of other reasons
that all CPUs should be stuck indefinitely with interrupts disabled...
If that's what's happening, (just spitballing) I wonder if hooking
into the slowpath of spinlocks to look for lockups would help? Maybe
every 10000 failures to acquire the spinlock we check for a lockup?
Obviously you could still come up with synthetic ways to make a
non-caught watchdog, but hopefully in those types of cases we can at
least reset the device with a hardware watchdog?

Overall the issue is that it's really awkward to have both types of
lockup detectors, especially since you've got to pick at compile time.
The perf lockup detector has a pile of things that make it pretty
awkward and it seems like people have been toward the buddy detector
because of this...

-Doug
