Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91C19E7F9;
	Tue, 22 Jul 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199790; cv=none; b=gJsed2ctW2bVwryxWaytoCkuMJ04yTuNQFRUluoUa9D9BXj89yBnmZ8HOEMAm/gEIDOMkkRqqOogxro1Rkeoglo1SidVLxGgTMVwggu+jHhHiRwNrgOmKtM7vn1XuyjbLYamD+HKJZo9dcp66mFRYnP7RnGiVTiSJvISe0wcu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199790; c=relaxed/simple;
	bh=ehonnbedT4DZldR5JroAFWGY9SqxMYm2QDP/tjyZQeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XGsuqsuokCwDnvS6EQIABsdrC/sGBk7MNctKXKtGLsEP5NIzzrCnmCoJmLsXOISW7p2LtkiUtjmkel0lJhpYDE49zUxFru7WJcwpe8OJig9NjBt9Azz+osdzzU8SJ/AVfvwaaisymaF4AIMyC2lm1dBgWfYOIugnCRu/la52oLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnZ1XUG9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HnYfVNio; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnZ1XUG9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HnYfVNio"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753199786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkEw/lTmafJr2SSwmjCrpMZhRZR91UCU4u4JDdbQoLQ=;
	b=gnZ1XUG9t4b5lhL+OjoV8CtdguTP0aTMm7UTaZVmxRBHwchR9i/fTO93JR5u+sxSptwdxa
	pKn2sjVcYLgkcu/0JBmqNM0xctHWBsNKzFNYqDH/0byKvqe3qWp65lmkj/KilHRTYKpxWw
	eCB+NqzMLbjzAUQwXHWCfvIe73yq2mPOen6lwpa1X9828azVQFuw+Us1RSdeZ8t+jF/gKV
	fTW1uKva2W8B+te4zQXOQi8/NyogAI+lHpVfq4pbLVF9Meb39Po5Dw+ICfXegEJOq7MXk+
	9YPQUV8/ikJ0ar/oXZcGobR4i2RraAQ7VytF44VKRQE5PoFwD5/VniQWcMTSsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753199786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkEw/lTmafJr2SSwmjCrpMZhRZR91UCU4u4JDdbQoLQ=;
	b=HnYfVNiouLI/UrUTVrH5vXV03Mh01KEYd2ZsEEztUAEaCOxN+aucJHMnX5YH6MJibflEdh
	6q4uJOC3ORTvtUCw==
To: kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>, Eric
 Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, Andy
 Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed
 struct to memcpy
In-Reply-To: <202507050736.b4hX0Xks-lkp@intel.com>
References: <20250626054826.433453-2-irogers@google.com>
 <202507050736.b4hX0Xks-lkp@intel.com>
Date: Tue, 22 Jul 2025 17:56:25 +0200
Message-ID: <87o6tcrzh2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian!

On Sat, Jul 05 2025 at 08:05, kernel test robot wrote:
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on tip/timers/vdso v6.16-rc4 next-20250704]
> [cannot apply to acme/perf/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/vdso-Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250626-135005
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250626054826.433453-2-irogers%40google.com
> patch subject: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
> config: s390-randconfig-002-20250705 (https://download.01.org/0day-ci/archive/20250705/202507050736.b4hX0Xks-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 61529d9e36fa86782a2458e6bdeedf7f376ef4b5)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507050736.b4hX0Xks-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507050736.b4hX0Xks-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/s390/boot/decompressor.c:48:
>    In file included from arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:10:
>    In file included from arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:36:
>>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:109:9: warning: default initialization of an object of type 'typeof (*((const U16 *)ptr))' (aka 'const unsigned short') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
>      109 |         return get_unaligned((const U16 *)ptr);
>          |                ^

Any update on this one?
