Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96D401A2D
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977401; cv=none; b=bUV7ofXmRf77fzXF5OuK3JxcIsYxRaq+SPlqsDwmDUlNXP5vg2Rn2LFTepmkPtOQUS6I15qZcO02EADJMEaOVzgKSgTyd/mB06izx577mlFfcLmICMo5rlD9MZ2eZynGDee3K/7xlBhVpFdgIMuZpUfYiCm7FYRioIU5nPB6o9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977401; c=relaxed/simple;
	bh=YYe0UsBMCaRl/SSTsNMvYXizf5N50Ge9yNyjOI2yeog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5wpcaM0Er7pDHbb/5y/qHZqkX4nzSYaQVX1SSCyP4GkVjAi5xJ1fn5eHT0OKyLjppZCJE1HAxmsdXnk3sNTIC4K2W9yVZ00WLkxQx97pA3f4jMMWDHd7nhXtu6qDjdWU1I47TWlXu5D7ck/lqiCY7KmRNXPmyEYEMfsGWJXW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKzshV6e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKzshV6e"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so7449631e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977398; x=1778582198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYe0UsBMCaRl/SSTsNMvYXizf5N50Ge9yNyjOI2yeog=;
        b=PKzshV6eK7GAfq3w57/u28D4PzUHGvxTno8gP6wmJZOGd/Z/31AbLENYaP072OynLm
         dCYzRAyJl0LdGqZqTP5jRAee8eKNuqr4wv72TquIX6aYuYwQ4VD8wvu2MQCTUNJt1/3u
         AgYj3C/nXBBMqCUmM1+Cwn58+dZfJq37d0WYnmlOaQT4psUjCZzYT8ZI/tDp6rpY3wuF
         B9HbJMTR8HIW7TwP3rNF/80J6B5g5ufBg03cmWdj6+er/D+3NhFptUH6WaG6cdv60B/2
         OPA1V+JMfbbxa5Cn/zNwEkvGHcev4MXpB//ZGBeHZSHNmNBnPg/uQWE5N/GlSVUyKSjD
         qpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977398; x=1778582198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYe0UsBMCaRl/SSTsNMvYXizf5N50Ge9yNyjOI2yeog=;
        b=aFq2WMGk1SGoGopTKuBomx+4A1EZQgiuhnT08oUtn6hi+Six6wTX2UOSXhRY1IrsQ9
         d2rfPbuTpwRaUIVvslobb2RiC6rB4BZQkhesUnGHv2+v9+58L+JPrgXN9vN8RUapGaUM
         EBVv07iG8xFEHPFeQaII/OOqpyvfZvVgVaL1anbyxhAq0ffZqpwqbdrVUK6nGVPzjlUJ
         gZbN7fiHwbxiOIty0aVscIw3rNNfmQf43ojNiNJgOtpIIRPYTLUIcF/j+CdYyVE3uaGu
         gKnUGB0w9sTuPt5GAysoH2MAB774et1XSAHCf39FekSflZRAqTzyBHY46f5cwrMwG2ra
         a4oA==
X-Forwarded-Encrypted: i=1; AFNElJ8lCO4LthU+cIM7Jmp4FwKRrxoLeGCdtxN0ZBMp1HmcK2dTYLqGwodyzgA9jAU1VsN1gjgJF6HBL03WZW4hzcRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2yOgxzO0LrSSl7s0TfSI77wHcv6Is0YSrUSDB0OGnzWscOH1
	nHx6zr00B4Gz1j3yJKDSu2dY00jJHbo2RHq2dlMe0wjrr8uoMw4AtCrM
X-Gm-Gg: AeBDietSFzcm8KcqWS520wQkcvj1FnuH5pOZBoLxTuOtylHC2pIF6tc/3XA/TuKLwjt
	g9WIW9obngGOr1I/2LKsqM+zrtXGsvHRJLBiI521B+ZDHeJDfPp6TItG0H8R1jnOYzi2yF23zeB
	a/9OEg6y9C9xtvBtb7LX0r2jbzAyR6Y3Y2CyYrmd9jeMGERQ1r8gTR6nEeaJNq45PSj1y9sM7ri
	AHM/GD40Cc7j6bKgDsg5ya4AIQvYUIihoxQbFzmP2tFEpSj+PjMTnVK+C+GbuNGLWFYI3G9r2qb
	xWgHiYMZX0j4v2de0Balu+xTEUU8XzOlo3RKjbJaq/I2RirWYQZGZTsp6Phx/h0YKpD5oRqHeIe
	ZjzRGRDNavi0MMT6njLhXBkg9sQmTdYm/Eav/vBGVlDEgIABebDkF1ENwRUKLu1HEEG7w+80tH9
	87PbBIkGmAbQLQZCf0Y+M9llgxNgyTE0p0bujFkap4yVWhuUbWVissgB6bKCdPRZ17fHgXmZM=
X-Received: by 2002:a05:6512:800e:20b0:5a8:6391:4fe5 with SMTP id 2adb3069b0e04-5a863915030mr3062779e87.26.1777977397888;
        Tue, 05 May 2026 03:36:37 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm3774443e87.65.2026.05.05.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:36:37 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	Valery Borovsky <vebohr@gmail.com>
Subject: Re: [PATCH 1/5] perf/arm_pmu_acpi: fix reference leak in arm_pmu_acpi_probe error path
Date: Tue,  5 May 2026 13:36:27 +0300
Message-ID: <inv007-withdrawal-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Yeah, you're right, my bad. The `arm_pmu_acpi.c` patch is definitely broken.

Since `spe_dev` and `trbe_dev` are statically allocated, they don't have a
`.dev.release` callback. If we hit `platform_device_put()` here, the refcount
drops to zero and triggers `device_release()`, which is going to scream about
the missing release function. At best, we get a messy WARN; at worst, it'll
panic the kernel if someone's running with `panic_on_warn`.

The kernel-doc note about `platform_device_put()` is really meant for dynamic
allocations where the release path actually frees memory. For static setups
like this, the original code is actually the right way to go.

Please drop patches 1/5 through 4/5 from the v1 series—they all suffer from
the same logic error. Patch 5/5 (mfd: sm501) is the only clean one, so I've
re-sent that as a standalone v2.

Sorry for the noise.

Valery Borovsky
