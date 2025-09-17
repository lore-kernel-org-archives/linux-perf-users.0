Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541726A1CF
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092107; cv=none; b=JCgRJbXT8xG9P7TQoJq4ngKM+UaeQlerWPM6CMLDEzctsEubPiyJpIzTl5wkHrYWNUeQqD2aYApx2fmC70MAqfV4hHuZG9DB7WmHZNDRX8s6TpJRWqoWa7ooiwWi832jNHiy+16Lw0oODcgAaVCHePbeiJlp82Hv06EwO3GN69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092107; c=relaxed/simple;
	bh=n2xOh/vHIWFAVtPY207+qfTRmAJyrUlRJgvSTUIK6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuRjwZP2VYYUJD39aDu5qmz/lTutojvLwRxVyUvT7EKD1pPibIn0+FHSYZfGQ1zvhJf8EmP+lmkQDe0/S4ABkigKAeVITLdveQz7VgihYoYVx9AkOvXunaKa8F3oE0dZSyFc1ycxZGvVYacpzNa9vJ0w++xWuRSZmVwpr0M5IgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jpv8KzyJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpv8KzyJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458272c00so67253675ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758092104; x=1758696904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ciYojmKTHtrfRmerHgichDH+MlCs0p4AN6MtET9b34c=;
        b=Jpv8KzyJ61F0C7x6n4bOIWTfqJPh3vrj4po8HLoiUMtC1t0T3Srb3UKcsaOmQhP1IH
         FYyu7Z7QbiWIZeP3J07QJ7haUoMjk/rle64jG/H6HNcZDC4CXZ0J8LHldsG/ULB4JhHk
         vgRNiiMODMAtQYcB/jKJp947TrFt0h5NMz5PT+xN3rG20qdVPfrkxWao8K0DT2NA/od+
         0caR7Wrk6B7khb0zPq5RXfCh7rZrR/U3Ymi9g3LfbMdIDbqsP1oayN+8vKEkAXv+3+I/
         DltPdisUyWi7hJ/vkV14p+RczCosJP+2mYGfEZaXDShSTvYMiJhHbQLpFOZpoQvReuSV
         nHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092104; x=1758696904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciYojmKTHtrfRmerHgichDH+MlCs0p4AN6MtET9b34c=;
        b=d4zvaeIiW4spnwkQXaR2MZ2TfP7V/e+uuVK3ydQjRnd3YE+tHRqNZu0GpFhZrfABuQ
         qaHzFa7EJuIxrLdoG2sOoMmW/I0o3+o6OT123wRQ6ffSit6dph4R0HGm2KIOTWBnl82o
         Tzgi4329yxaqVJYWYh6SNUuJBiEnuCcK6nc0rdtJ0g4snWkRQAlGldgaoAhbBQwKC4iG
         bDCiPzYbR2bRT/8H9JO1qoFXN28GGdHRzBfKfp3mkg2GV51zi8tC+SCAUnYJnCBbJM8H
         U0o3swJ3GsiEI6kiS8G4U1U4O3yJlmRlsyrq8HXgXMZMIiaamd/x3aAY3CtUS/oHz7ar
         sxRA==
X-Forwarded-Encrypted: i=1; AJvYcCUyA2R66BhN5zX7wpwCN5cIkP/0OToeavt5YDlKvz5w1tRB7kqyaPAgdRBM7JbabwhKtrg/++igZ9XN3nuUx8U6@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqRLKagOd+cx03lUohub6k2bZZY2/n95G9VlrTOlI9ijRCspl
	Izd3yEDgPn9JIFfu3yCmrXf2fiY+t8NdYRLysDn7sQblNKsbEwZt8HLC
X-Gm-Gg: ASbGncvSHSCYUxCxXctgHGwgSXfqCf/hW6T4FtI9SCi3iB5d3MwsnSFCiFj7+mNht+v
	fsqf6WWEkVZr1UTkO7cIxIfOql55DQ4In1ssiZqONbhUOt5tlkYYx5Tu6gVmqWDhdY6z120XHNk
	uEbbs30lrLyJzlGjG5Br14py1K8/zCLsV5MjULy72NJ2Mtc5+9uThYcJJj08pdZb9PrpdZxQzDI
	vsTmmHE0LLVgxL22whTOZMyE0wFZZkKKISfIe6J0j+oit+8P8VOIImL9/bPBw2xhJyY8bPOAwqL
	lSPcLs9nSe5Z7lQ54/Mu/0uBdXLki3YvOq+jkxe2nu98SjSnYqDfC/7FAu93ifV6LKs6jOg9q1E
	VQ8SYtF/kKnvqCd5ka8ErUVP2BGdTn5oyOpocsJWi+RpXsjypibC1uWP85YJO9Q==
X-Google-Smtp-Source: AGHT+IEMOPmQpgO9licMzodMNvLCJmPGd6KpjFeGD/TAjLXfmnoUh4OGIUW174YcM5R0QJKsMXjAoQ==
X-Received: by 2002:a17:903:124e:b0:267:cd93:cba9 with SMTP id d9443c01a7336-268137f318bmr14162225ad.35.1758092103917;
        Tue, 16 Sep 2025 23:55:03 -0700 (PDT)
Received: from localhost (61-221-120-111.hinet-ip.hinet.net. [61.221.120.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267de22b719sm33440055ad.85.2025.09.16.23.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:55:03 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:54:49 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Doug Anderson <dianders@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
	akpm@linux-foundation.org, catalin.marinas@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
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
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup
 detector
Message-ID: <aMpbOSN4DH09IPgD@mdev>
References: <https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/>
 <20250916145122.416128-1-wangjinchao600@gmail.com>
 <f932d6da-cd9c-4307-8877-eeb947a5c1a6@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f932d6da-cd9c-4307-8877-eeb947a5c1a6@csgroup.eu>

On Wed, Sep 17, 2025 at 08:08:57AM +0200, Christophe Leroy wrote:
> 
> 
> Le 16/09/2025 à 16:50, Jinchao Wang a écrit :
> > Currently, the hard lockup detector is selected at compile time via
> > Kconfig, which requires a kernel rebuild to switch implementations.
> > This is inflexible, especially on systems where a perf event may not
> > be available or may be needed for other tasks.
> > 
> > This commit refactors the hard lockup detector to replace a rigid
> > compile-time choice with a flexible build-time and boot-time solution.
> > The patch supports building the kernel with either detector
> > independently, or with both. When both are built, a new boot parameter
> > `hardlockup_detector="perf|buddy"` allows the selection at boot time.
> > This is a more robust and user-friendly design.
> > 
> > This patch is a follow-up to the discussion on the kernel mailing list
> > regarding the preference and future of the hard lockup detectors. It
> > implements a flexible solution that addresses the community's need to
> > select an appropriate detector at boot time.
> > 
> > The core changes are:
> > - The `perf` and `buddy` watchdog implementations are separated into
> >    distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > - Global function pointers are introduced (`watchdog_hardlockup_enable_ptr`)
> >    to serve as a single API for the entire feature.
> > - A new `hardlockup_detector=` boot parameter is added to allow the
> >    user to select the desired detector at boot time.
> > - The Kconfig options are simplified by removing the complex
> >    `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to be
> >    built without mutual exclusion.
> > - The weak stubs are updated to call the new function pointers,
> >    centralizing the watchdog logic.
> > 
> > Link: https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/
> > Link: https://lore.kernel.org/all/CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com/
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  7 +++
> >   include/linux/nmi.h                           |  6 +++
> >   kernel/watchdog.c                             | 46 ++++++++++++++++++-
> >   kernel/watchdog_buddy.c                       |  7 +--
> >   kernel/watchdog_perf.c                        | 10 ++--
> >   lib/Kconfig.debug                             | 37 +++++++--------
> >   6 files changed, 85 insertions(+), 28 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 5a7a83c411e9..0af214ee566c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1828,6 +1828,13 @@
> >   			backtraces on all cpus.
> >   			Format: 0 | 1
> > +	hardlockup_detector=
> > +			[perf, buddy] Selects the hard lockup detector to use at
> > +			boot time.
> > +			Format: <string>
> > +			- "perf": Use the perf-based detector.
> > +			- "buddy": Use the buddy-based detector.
> > +
> >   	hash_pointers=
> >   			[KNL,EARLY]
> >   			By default, when pointers are printed to the console
> > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > index cf3c6ab408aa..9298980ce572 100644
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -100,6 +100,9 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
> >   #endif
> >   #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > +void watchdog_perf_hardlockup_enable(unsigned int cpu);
> > +void watchdog_perf_hardlockup_disable(unsigned int cpu);
> > +extern int watchdog_perf_hardlockup_probe(void);
> 
> No 'extern' on function prototypes, this is pointless.
Got it.
> 
> >   extern void hardlockup_detector_perf_stop(void);
> >   extern void hardlockup_detector_perf_restart(void);
> >   extern void hardlockup_config_perf_event(const char *str);
> > @@ -120,6 +123,9 @@ void watchdog_hardlockup_disable(unsigned int cpu);
> >   void lockup_detector_reconfigure(void);
> >   #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
> > +void watchdog_buddy_hardlockup_enable(unsigned int cpu);
> > +void watchdog_buddy_hardlockup_disable(unsigned int cpu);
> > +int watchdog_buddy_hardlockup_probe(void);
> >   void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
> >   #else
> >   static inline void watchdog_buddy_check_hardlockup(int hrtimer_interrupts) {}
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 80b56c002c7f..85451d24a77d 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -55,6 +55,37 @@ unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> >   #ifdef CONFIG_HARDLOCKUP_DETECTOR
> > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > +/* The global function pointers */
> > +void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) = watchdog_perf_hardlockup_enable;
> > +void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) = watchdog_perf_hardlockup_disable;
> > +int (*watchdog_hardlockup_probe_ptr)(void) = watchdog_perf_hardlockup_probe;
> 
> As this is set only once at startup, can we use static_call instead of
> function pointers ?
> 
> Also, can it me made __ro_after_init ?
Not really, this is just an RFC patch, and there is no consensus yet.
If it is included in the final consensus, I will handle it in the next version.
> 
> > +#elif defined(CONFIG_HARDLOCKUP_DETECTOR_BUDDY)
> > +void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) = watchdog_buddy_hardlockup_enable;
> > +void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) = watchdog_buddy_hardlockup_disable;
> > +int (*watchdog_hardlockup_probe_ptr)(void) = watchdog_buddy_hardlockup_probe;
> > +#endif
> > +
> > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
> > +static char *hardlockup_detector_type = "perf"; /* Default to perf */
> > +static int __init set_hardlockup_detector_type(char *str)
> > +{
> > +	if (!strncmp(str, "perf", 4)) {
> 
> Why strncmp ?
Copy from hardlockup_panic_setup().
> 
> What if I set 'hardlockup_detector=performance" ?
I think that is acceptable in this case.
> 
> 
> > +		watchdog_hardlockup_enable_ptr = watchdog_perf_hardlockup_enable;
> > +		watchdog_hardlockup_disable_ptr = watchdog_perf_hardlockup_disable;
> > +		watchdog_hardlockup_probe_ptr = watchdog_perf_hardlockup_probe;
> > +	} else if (!strncmp(str, "buddy", 5)) {
> > +		watchdog_hardlockup_enable_ptr = watchdog_buddy_hardlockup_enable;
> > +		watchdog_hardlockup_disable_ptr = watchdog_buddy_hardlockup_disable;
> > +		watchdog_hardlockup_probe_ptr = watchdog_buddy_hardlockup_probe;
> > +	}
> > +	return 1;
> > +}
> > +
> > +__setup("hardlockup_detector=", set_hardlockup_detector_type);
> > +
> > +#endif
> > +
> >   # ifdef CONFIG_SMP
> >   int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
> >   # endif /* CONFIG_SMP */
> > @@ -262,9 +293,17 @@ static inline void watchdog_hardlockup_kick(void) { }
> >    * softlockup watchdog start and stop. The detector must select the
> >    * SOFTLOCKUP_DETECTOR Kconfig.
> >    */
> > -void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
> > +void __weak watchdog_hardlockup_enable(unsigned int cpu)
> > +{
> > +	if (watchdog_hardlockup_enable_ptr)
> > +		watchdog_hardlockup_enable_ptr(cpu);
> > +}
> 
> This is a weak function so it can be overloaded. What happens then, for
> instance if the sparc architecture version of watchdog_hardlockup_enable()
> is called instead ?
It is a historical problem; I prefer using an #if condition instead. 
I had considered sparc arch, if sparc version is called, it is expected.
Because the __weak functions only handle perf & buddy watchdog not the sparc
watchdog.

I think we should first resolve the consensus issue:
- Should we keep both perf and buddy watchdogs? (probably yes already)
- Should the watchdog type be changeable at boot time?
- Should the watchdog type be changeable at runtime?

How we handle these different watchdog types(maybe including sparc type)
depends on the answers to these questions.
What do you think?

> 
> > -void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
> > +void __weak watchdog_hardlockup_disable(unsigned int cpu)
> > +{
> > +	if (watchdog_hardlockup_disable_ptr)
> > +		watchdog_hardlockup_disable_ptr(cpu);
> > +}
> >   /*
> >    * Watchdog-detector specific API.
> > @@ -275,6 +314,9 @@ void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
> >    */
> >   int __weak __init watchdog_hardlockup_probe(void)
> >   {
> > +	if (watchdog_hardlockup_probe_ptr)
> > +		return watchdog_hardlockup_probe_ptr();
> > +
> >   	return -ENODEV;
> >   }
> > diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
> > index ee754d767c21..390d89bfcafa 100644
> > --- a/kernel/watchdog_buddy.c
> > +++ b/kernel/watchdog_buddy.c
> > @@ -19,15 +19,16 @@ static unsigned int watchdog_next_cpu(unsigned int cpu)
> >   	return next_cpu;
> >   }
> > -int __init watchdog_hardlockup_probe(void)
> > +int __init watchdog_buddy_hardlockup_probe(void)
> >   {
> >   	return 0;
> >   }
> > -void watchdog_hardlockup_enable(unsigned int cpu)
> > +void watchdog_buddy_hardlockup_enable(unsigned int cpu)
> >   {
> >   	unsigned int next_cpu;
> > +	pr_info("ddddd %s\n", __func__);
> 
> Leftover from debuging ?
Forgot to delete the log, will fix if a v2 is needed.
> 
> >   	/*
> >   	 * The new CPU will be marked online before the hrtimer interrupt
> >   	 * gets a chance to run on it. If another CPU tests for a
> > @@ -58,7 +59,7 @@ void watchdog_hardlockup_enable(unsigned int cpu)
> >   	cpumask_set_cpu(cpu, &watchdog_cpus);
> >   }
> > -void watchdog_hardlockup_disable(unsigned int cpu)
> > +void watchdog_buddy_hardlockup_disable(unsigned int cpu)
> >   {
> >   	unsigned int next_cpu = watchdog_next_cpu(cpu);
> > diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> > index 9c58f5b4381d..270110e58f20 100644
> > --- a/kernel/watchdog_perf.c
> > +++ b/kernel/watchdog_perf.c
> > @@ -153,10 +153,12 @@ static int hardlockup_detector_event_create(void)
> >    * watchdog_hardlockup_enable - Enable the local event
> >    * @cpu: The CPU to enable hard lockup on.
> >    */
> > -void watchdog_hardlockup_enable(unsigned int cpu)
> > +void watchdog_perf_hardlockup_enable(unsigned int cpu)
> >   {
> >   	WARN_ON_ONCE(cpu != smp_processor_id());
> > +	pr_info("ddddd %s\n", __func__);
> > +
> >   	if (hardlockup_detector_event_create())
> >   		return;
> > @@ -172,7 +174,7 @@ void watchdog_hardlockup_enable(unsigned int cpu)
> >    * watchdog_hardlockup_disable - Disable the local event
> >    * @cpu: The CPU to enable hard lockup on.
> >    */
> > -void watchdog_hardlockup_disable(unsigned int cpu)
> > +void watchdog_perf_hardlockup_disable(unsigned int cpu)
> >   {
> >   	struct perf_event *event = this_cpu_read(watchdog_ev);
> > @@ -257,10 +259,12 @@ bool __weak __init arch_perf_nmi_is_available(void)
> >   /**
> >    * watchdog_hardlockup_probe - Probe whether NMI event is available at all
> >    */
> > -int __init watchdog_hardlockup_probe(void)
> > +int __init watchdog_perf_hardlockup_probe(void)
> >   {
> >   	int ret;
> > +	pr_info("ddddd %s\n", __func__);
> > +
> >   	if (!arch_perf_nmi_is_available())
> >   		return -ENODEV;
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index dc0e0c6ed075..443353fad1c1 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1167,36 +1167,33 @@ config HARDLOCKUP_DETECTOR
> >   #
> >   # Note that arch-specific variants are always preferred.
> >   #
> > -config HARDLOCKUP_DETECTOR_PREFER_BUDDY
> > -	bool "Prefer the buddy CPU hardlockup detector"
> > -	depends on HARDLOCKUP_DETECTOR
> > -	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
> > -	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
> > -	help
> > -	  Say Y here to prefer the buddy hardlockup detector over the perf one.
> > -
> > -	  With the buddy detector, each CPU uses its softlockup hrtimer
> > -	  to check that the next CPU is processing hrtimer interrupts by
> > -	  verifying that a counter is increasing.
> > -
> > -	  This hardlockup detector is useful on systems that don't have
> > -	  an arch-specific hardlockup detector or if resources needed
> > -	  for the hardlockup detector are better used for other things.
> > -
> >   config HARDLOCKUP_DETECTOR_PERF
> > -	bool
> > +	bool "Enable perf-based hard lockup detector (preferred)"
> >   	depends on HARDLOCKUP_DETECTOR
> > -	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
> > +	depends on HAVE_HARDLOCKUP_DETECTOR_PERF
> >   	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
> >   	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> > +	help
> > +	  This detector uses a perf event on the CPU to detect when a CPU
> > +	  has become non-maskable interrupt (NMI) stuck. This is the
> > +	  preferred method on modern systems as it can detect lockups on
> > +	  all CPUs at the same time.
> >   config HARDLOCKUP_DETECTOR_BUDDY
> > -	bool
> > +	bool "Enable buddy-based hard lockup detector"
> >   	depends on HARDLOCKUP_DETECTOR
> >   	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
> > -	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
> >   	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
> >   	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> > +	help
> > +	  This is an alternative lockup detector that uses a heartbeat
> > +	  mechanism between CPUs to detect when one has stopped responding.
> > +	  It is less precise than the perf-based detector and cannot detect
> > +	  all-CPU lockups, but it does not require a perf counter.
> > +
> > +config CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
> > +	bool
> > +	depends on HARDLOCKUP_DETECTOR_PERF && HARDLOCKUP_DETECTOR_BUDDY
> >   config HARDLOCKUP_DETECTOR_ARCH
> >   	bool
> 
