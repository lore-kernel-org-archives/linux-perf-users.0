Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0502475D0
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089653; cv=none; b=AFc6PLNDXDlCIQyjr2y+XGhvXN+cjgSAme7wkgIKIG+svQRWSK9H29Ly2lKs4ESAJCRPEgpSi8zhAR3D5Zd89XKp4J4ZsGnJg9jhVfXlW4nQvh881NsfJmb8hxQ2ZwZbxbz8SujG37C7o4GTj3773I8sR3gZ/QQExRxq0H4wGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089653; c=relaxed/simple;
	bh=jwNyZdCzkpVeu8M/UncF/JIEZsPkukGJTMUOSNPYnO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCqg1jqs67t84BptcIj9LgBbWMjigldlGNvQD+Ue+jZVm2mPb2g8oA284xSc+MzbuwGiGZPVDcjQxFI00pjxNXnoSUvh+am4BvGTdA9FLMILJRZSftdleK4H4bE7u4E0IfN2kUAYBKYS8tStOjEHWjJegReyo8Wfag6DgOmf3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNIbWBmh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNIbWBmh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-776b0100de0so466105b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089651; x=1758694451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FmzfgTfio2uU1BYpRua3Nqm7f01ztuczzsg9vKgt8Hk=;
        b=fNIbWBmhnTpKRlRZlHhECeXxrxRTkuUGze9MPrTN3O0pBWYjyWKp80N/jMoEHtKNlw
         7it1yZ/Jc4+Xy4LGlPw8Af0KBpIjvxtUYCQ0C4TxuJeOLOG935Q5ouWtu6ZoicaI7m0I
         TRBO1S4hQUSvUoxhg5kp+xbhmAn6s/JgakGKfridtuDyQaXlpe2Rehq6bEpZQQeYqqIb
         eoiUGU9Ot0IzawZh2UfPYJkIy2CB2L7Jo3NchVSkF4mRATr5DUcIxeZa6nWTA6TaQq7f
         eLs4wx+fZ/RDc+IFZ5dYKRItMp1W+H0KBdkbmsgW2eKd7pRlfr4OkuuKJnEmclNosI/i
         mi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089651; x=1758694451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmzfgTfio2uU1BYpRua3Nqm7f01ztuczzsg9vKgt8Hk=;
        b=CEO1cGkJYVjVXvLga6r+psF2KzRZTEopc0uoL9s1G4pEglA6QkM7+wDHzuNdcmmRse
         DkxHVZvNkWSR6UQPmtUtICkfFnlPbUyI1KC7MLYKokdtp189qv94uNHPu5r4V4mM4NTT
         R1tMFEExMmmIK0bucE933H609UaUhGo//ttMkU5rsTMcpCHlsRkm1I8OLY0OnWA6LZok
         3wELsvLdvOXyPmhf3qyoxut6RRWsRkhIDOJtiJ9EtxU0hzhu2+YVV53vqtQ7V6DEF3Pl
         MbPxqD8rLxQWXW/h+vFBWKmHDsZ/g+Q0chkZGSSE/4VuBx/JoDpEB6S8EbnfCUSkerTu
         k27A==
X-Forwarded-Encrypted: i=1; AJvYcCWUkztzDfQHhmnJkDq6SL2G2P7iiOSHTXd4un2vSM73uJuJUGhUBzvELa/lsCyaT+EuIJ6zBzxY8a0keYFMh/hl@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBhWH9nzDybJ++mUOs8vzptbSe6XOBjpxrdIPKk9QwQ+vB0ha
	l2ZEN+LjSxIPuTOCkmqt2EgVUm6GmpuaCdic+SbpItHHbTf/daVcBnqI
X-Gm-Gg: ASbGncuPDB/rWgU/mfaQ+L9q4Eh1EewgaVijkfoIo/wgEL/VOVe4egL5QujdC00aCvJ
	Uy3U4slNTdP+yzteb+xoz9c3Mt+R+GzjnxA0QCwuaiFJQQ9JezCDtfr5TpL5tn3bj87m74b55iI
	AgkKFKEO3LnF6kyrTSDV3PLxUZ6mwo/cPHAK2erEeCDt3GkvrUuvPfonINhMo/vbz+ALr4ELd1D
	AwVGWV2hGPQAF0TPcyGARK8ePhjbKdOPcnozRd8Sf4XF7mXy9Mgtdacl4JRV6iZ8ZvJoSbV+GKi
	7USJ++782w7oovHCRxOKuIWrX5iGq+yPINVp0SuAgqc9DRRNROeSC8QYywgbXEmCi6N+F7N+XQW
	4SBmAHy1ErOSTD+lsuNPzDtlWvwitD+WdZWIJXWK8
X-Google-Smtp-Source: AGHT+IFbOOUPuUp71MZLUCXJnIvNlVqkzTniqbE7azWA2KDlmn7NJjUtb/+FLQYp6JRxCAhLg6/vEQ==
X-Received: by 2002:a05:6a20:3d10:b0:243:b089:9fbe with SMTP id adf61e73a8af0-26701102125mr7170178637.31.1758089650568;
        Tue, 16 Sep 2025 23:14:10 -0700 (PDT)
Received: from localhost ([146.19.163.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm12638506a12.19.2025.09.16.23.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:14:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:14:02 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Doug Anderson <dianders@chromium.org>,
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
Message-ID: <aMpRqlDXXOR5qYFd@mdev>
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev>
 <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMpIsqcgpOH1AObN@z2>

On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > On Tue, Sep 16, 2025 at 6:47 PM Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > On Tue, Sep 16, 2025 at 7:51 AM Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > > > >
> > > > > Currently, the hard lockup detector is selected at compile time via
> > > > > Kconfig, which requires a kernel rebuild to switch implementations.
> > > > > This is inflexible, especially on systems where a perf event may not
> > > > > be available or may be needed for other tasks.
> > > > >
> > > > > This commit refactors the hard lockup detector to replace a rigid
> > > > > compile-time choice with a flexible build-time and boot-time solution.
> > > > > The patch supports building the kernel with either detector
> > > > > independently, or with both. When both are built, a new boot parameter
> > > > > `hardlockup_detector="perf|buddy"` allows the selection at boot time.
> > > > > This is a more robust and user-friendly design.
> > > > >
> > > > > This patch is a follow-up to the discussion on the kernel mailing list
> > > > > regarding the preference and future of the hard lockup detectors. It
> > > > > implements a flexible solution that addresses the community's need to
> > > > > select an appropriate detector at boot time.
> > > > >
> > > > > The core changes are:
> > > > > - The `perf` and `buddy` watchdog implementations are separated into
> > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > > > > - Global function pointers are introduced (`watchdog_hardlockup_enable_ptr`)
> > > > >   to serve as a single API for the entire feature.
> > > > > - A new `hardlockup_detector=` boot parameter is added to allow the
> > > > >   user to select the desired detector at boot time.
> > > > > - The Kconfig options are simplified by removing the complex
> > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to be
> > > > >   built without mutual exclusion.
> > > > > - The weak stubs are updated to call the new function pointers,
> > > > >   centralizing the watchdog logic.
> > > >
> > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is that
> > > > enabling and disabling whatever the boot time choice was? I'm not sure
> > > > why this has to be a boot time option given the ability to configure
> > > > via /proc/sys/kernel/nmi_watchdog.
> > > The new hardlockup_detector boot parameter and the existing
> > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > >
> > > The boot parameter selects the type of hard lockup detector (perf or buddy).
> > > This choice is made once at boot.
> > >
> > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a simple on/off
> > > switch for the currently selected detector. It does not change the detector's
> > > type.
> > 
> > So the name "nmi_watchdog" for the buddy watchdog is wrong for fairly
> > obvious naming reasons but also because we can't differentiate when a
> > perf event has been taken or not - this impacts perf that is choosing
> > not to group events in metrics because of it, reducing the metric's
> > accuracy. We need an equivalent "buddy_watchdog" file to the
> > "nmi_watchdog" file. If we have such a file then if I did "echo 1 >
> > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to be
> > disabled and the perf event one to be enabled. Similarly, if I did
> > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect the
> > perf event watchdog to be disabled and the buddy one enabled. If I did
> >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > enabled. I don't see why choosing the type of watchdog implementation
> > at boot time is particularly desirable. It seems sensible to default
> > normal people to using the buddy watchdog (more perf events, power...)
> > and  CONFIG_DEBUG_KERNEL type people to using the perf event one. As
> > the "nmi_watchdog" file may be assumed to control the buddy watchdog,
> > perhaps a compatibility option (where the "nmi_watchdog" file controls
> > the buddy watchdog) is needed so that user code has time to migrate.
> 
> Sounds good to me.  For perf tools, it'd be great if we can have a run-
> time check which watchdog is selected.
Considering backward compatibility, I prefer to keep
/proc/sys/kernel/nmi_watchdog and introduce a new file called
/proc/sys/kernel/hardlockup_detector_type, which only shows the default string
or the boot parameter.

The global str pointer hardlockup_detector_type was already introduced in the
patch, so exposing it in a file is straightforward.
> 
> Thanks,
> Namhyung
> 

-- 
Jinchao
