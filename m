Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D32BE04B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992655; cv=none; b=ix2PuhSi/G1tDdYUK66Uc8XSScXk0eOHkPBaTsEY0XgWSdEmcQRCbOvvFOQaIOMKUOuXT33wB3LwmxTX6xNVoSrB5zIIPc4tvyxviaOAOTuFv5KOTGmhto9MJtJlyu64B9+Lsey4kEs9RY0gE+X9pE5xuUNHT+y1t7VBMut3YDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992655; c=relaxed/simple;
	bh=5iaDRjaHStX8bpORHYa3ggYGC4GJYP2AVm30MmJstLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld4Yds9jB+L7DmzhtjjNbA1b4hm/JuD9jSMWhlePi76AB6jIb2OwmuHiyEnOhDTwhAF2poVJF89/NMvC3GwXveeV4/sKfTkARUXrxRbyQvbqLykjiIStLd4lrxpoFXHvKqCES9JSS5G6NX7nZIozHVKCKkcmqxaTgaS2iqTsivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl3GJE+w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl3GJE+w"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so462453b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 23:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759992653; x=1760597453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=msPzO2LdAQxGndJ6DjHr10aS1oMz0X5JmsGbgMgwTiU=;
        b=Vl3GJE+wDZX+vJoZQYqZ5ZU3Z0SQctrtVtmm/0vba35ymk6QBlLv+eCnG2JuOuB0Qy
         nvmqEhWoNBGjFTV36YcAGEbBHJeEHSrSjX9cCf2LNDJQ4ieCDR+B6glXBPUYIMGy6AR+
         OfxsapHPWChffiaxokBM9qbV0QPjTG+DEA1vUY+ItLTMttD0Yx2T6QT3p84j93DeAxZ6
         8+OMHQIjOyi3A4McPZ8x5x9vQCzlGXm0dRA75T8l9Dyzq70gUzI8qS18aIG1i1xajKhx
         Gv36ILfSWTD764v/y4u6fXTjAzrRyKHw1aFAa2aDdRDF2z6aUnUNzBfcwx9anjCU71in
         TWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759992653; x=1760597453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msPzO2LdAQxGndJ6DjHr10aS1oMz0X5JmsGbgMgwTiU=;
        b=LxCuVU6nflX8/9JzdiJtt35Y0/rtdG9QChUEWjnee7+hehuC/ScNHcpqWhrrrx8aU0
         fyDJAfMp6AsFfImyS1PsmAJYxnRrT0+v0ZGsLt1QycsysLVfJDNNI1bkEX1zVjeO52fM
         WQgEy8L1XJlqFn48dG+5y+2J1JIqf4bPpV88TYwviNwYfk7orsuviCIZx1gdgFvHBx4m
         86swl0Xc/gNS9Sl9Nj5+QaGZhOf7AWe6yY12iNyAr13jNS85nj6iF0dokb4SDzvhj8vb
         UZ6X73HKmYVtiZAgwdeoUdfyM8zQI/gRLngaRAGqhFeWQwLrW0C9gAz4PY427QS4JFB/
         b5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ja94hwzlFZU0pXY6oHteaZMTzY/cpmyG2PZ8oDFBNtsQpsLamhGudLn+GDVkRX2/i+ZsBbw6N2W8d6fstgbx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6XNxrWGxbgo5AAgX98da030v4aBhZ5Omx+XbzLlp6wxpsdvC
	/28tavJOTe5C/aWpGfSkSDh+/q2EYm6ZMmONWCx9vuEmuy+J1fl9hW2V
X-Gm-Gg: ASbGncsBRwqB9MmFSdD6HsBEyNwm8G5HijERgvsmoSufVXjmgf69XRxthujeCDEy29s
	RNK8wKvMOgia83onLaOmrQ7Wst+smMbPgQW7bmWvjLIXbQYkU74UrJ0KFH92GstG2k3wVxl6f/K
	80BNsQG48y3U+YmG/fJW1ceVuOj0HTrK4RS1oE0AFn5UtmM4aQkNgAq3NwdSUOQqAU3HyoO+Wn1
	JBp+LWiUMnDqtb5bsw4NHZlbZdg0Ho/hYy9oXIuSeOoDKznyUIPbfY0GVMPujTUf77zkgsTp6YP
	5+E86LJyK7L/R5dt4DF71KJHi9ubxBJkeYootzEH9DAeCzuzlAxs0xK1QlNw9Nnm6zfTFVSSLxr
	TGH+y86zGR5V2/v4tjbHqrwQD7zuawFNziUm1cTo9MxCK+C4q0xrWSfGKo3tRBt5A3GGxQC33
X-Google-Smtp-Source: AGHT+IFMMMzSXgtEWLK41QXTNZ3lVQJZHbdPqEPiYgjhZ+ACp4v2JbI3obgmT4HZPDkdNTRW4JUzPw==
X-Received: by 2002:a17:903:1b30:b0:276:d3e:6844 with SMTP id d9443c01a7336-290272c0450mr82694985ad.33.1759992653189;
        Wed, 08 Oct 2025 23:50:53 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de56desm18189935ad.19.2025.10.08.23.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:50:52 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:50:44 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
	akpm@linux-foundation.org, catalin.marinas@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org,
	masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, xur@google.com,
	ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org,
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com, gautam@linux.ibm.com, arnd@arndb.de,
	zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com,
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup
 detector
Message-ID: <aOdbRI3BaMCbyvtv@mdev>
References: <aMpRqlDXXOR5qYFd@mdev>
 <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
 <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
 <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
 <CAP-5=fX4=fV70N3GCdXgV6o-YoJynnSppxJp0MwdRrtsyDrs0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX4=fV70N3GCdXgV6o-YoJynnSppxJp0MwdRrtsyDrs0w@mail.gmail.com>

On Tue, Oct 07, 2025 at 05:11:52PM -0700, Ian Rogers wrote:
> On Tue, Oct 7, 2025 at 3:58 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Oct 7, 2025 at 3:45 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Oct 7, 2025 at 2:43 PM Doug Anderson <dianders@chromium.org> wrote:
> > > ...
> > > > The buddy watchdog was pretty much following the conventions that were
> > > > already in the code: that the hardlockup detector (whether backed by
> > > > perf or not) was essentially called the "nmi watchdog". There were a
> > > > number of people that were involved in reviews and I don't believe
> > > > suggesting creating a whole different mechanism for enabling /
> > > > disabling the buddy watchdog was never suggested.
> > >
> > > I suspect they lacked the context that 1 in the nmi_watchdog is taken
> > > to mean there's a perf event in use by the kernel with implications on
> > > how group events behave. This behavior has been user
> > > visible/advertised for 9 years. I don't doubt that there were good
> > > intentions by PowerPC's watchdog and in the buddy watchdog patches in
> > > using the file, that use will lead to spurious warnings and behaviors
> > > by perf.
> > >
> > > My points remain:
> > > 1) using multiple files regresses perf's performance;
> > > 2) the file name by its meaning is wrong;
> > > 3) old perf tools on new kernels won't behave as expected wrt warnings
> > > and metrics because the meaning of the file has changed.
> > > Using a separate file for each watchdog resolves this. It seems that
> > > there wasn't enough critical mass for getting this right to have
> > > mattered before, but that doesn't mean we shouldn't get it right now.
> >
> > Presumably your next steps then are to find someone to submit a patch
> > and try to convince others on the list that this is a good idea. The
> > issue with perf has been known for a while now and I haven't seen any
> > patches. As I've said, I won't stand in the way if everyone else
> > agrees, but given that I'm still not convinced I'm not going to author
> > any patches for this myself.
> 
> Writing >1 of:
> ```
> static struct ctl_table watchdog_hardlockup_sysctl[] = {
> {
> .procname       = "nmi_watchdog",
> .data = &watchdog_hardlockup_user_enabled,
> .maxlen = sizeof(int),
> .mode = 0444,
> .proc_handler   = proc_nmi_watchdog,
> .extra1 = SYSCTL_ZERO,
> .extra2 = SYSCTL_ONE,
> },
> };
> ```
> is an exercise of copy-and-paste, if you need me to do the copy and
> pasting then it is okay.
Can we get whether a perf event is already in use directly from the
perf subsystem? There may be (or will be) other kernel users of
perf_event besides the NMI watchdog. Exposing that state from the perf
side would avoid coupling unrelated users through nmi_watchdog and
similar features.

> 
> Thanks,
> Ian
> 
> 
> > -Doug
> >

-- 
Jinchao
