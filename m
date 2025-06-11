Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DF25C83E;
	Wed, 11 Jun 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633947; cv=none; b=KdHJda4tUDnnJRVHuUHJkKJ+e26uf9i/rfA+3vk0iWRDFeBIBV7A9eDRnuxfpFwUlx47FyvlUd5qKet2bf2LHQiV05uXvuE2rx4FFbvN/BLPjEdh8mhLVCPIBeRxxAsw3W89t5AvJV8Aml/JQTvin5Zf98jTUFl+sXshn6l6Zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633947; c=relaxed/simple;
	bh=C2eY2wgLZDRyRHC2BZzzTnEymlDbxP4PU6gFORhZ98Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFm88pdVLAyHxtZmiq+Kuwgf8DaCGgHXsr/iAMMfBQs1wVlAJAu+wwRS//DphOukvyl55kweU6UR7a+heDC2tMbtN1mij30NXRjpaa2JhBSebN4SieXukuEC3/JTRDBmgQfhKgJJUuNUIN+4kriH7uzCD6ssBr7P+hpuy6dU5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuEuQbAk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=slDVcyq5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuEuQbAk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="slDVcyq5"
Date: Wed, 11 Jun 2025 11:25:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749633944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/OrJEKAMLQzuR12xpBYqySl3lqI/7yOMuJ3BDm7j4Fw=;
	b=VuEuQbAkM2Pev2WXVKRGZ8nL0SMZncS1T3tSJFSAXUdTPfmyBseHyRdv8T5BnmgcEukgwz
	n6V1icHd+yh+Oi5Z5/R9AZz5skpDAyr+VknQ23JPFRz0caPgv0+kknvR2f9rN2XB77swwf
	rl3ceu57HfNHkF409Rm0GqSP/zAsUQ1fP9NKKVmkHOuACKrO94nqpKgrFTBE6xW2FLlKvv
	HYtII/2O83EnTfHpRFEwE+jaUAUz/PP/FJ5uRtUhpB6UpzRGxzR1oAUfg8aDrKeao8P4bV
	+J86rcU+6bcVQsCLsdQ1GHXS5EdPxutjld4TJzDsoPwkTaCJAufz3kzc+Xz3+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749633944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/OrJEKAMLQzuR12xpBYqySl3lqI/7yOMuJ3BDm7j4Fw=;
	b=slDVcyq53Fh4hrqej/McVRQG0UUzVu9mc7d0c0UQxow2Hj7FwNdpZJWdS3BG0EA8oyV1ky
	L5DQwbmH3fRDgRCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <20250611092542.F4ooE2FL@linutronix.de>
References: <aEh6xO14wDSCFUDr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEh6xO14wDSCFUDr@google.com>

On 2025-06-10 11:34:44 [-0700], Namhyung Kim wrote:
> Hello,
Hi,

> I've updated the perf-tools-next to v6.16-rc1 and found a build error
> like below on alpine linux 3.18.
> 
>   In file included from bench/futex.c:6:
>   /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
>      88 | struct prctl_mm_map {
>         |        ^~~~~~~~~~~~
>   In file included from bench/futex.c:5:
>   /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
>     134 | struct prctl_mm_map {
>         |        ^~~~~~~~~~~~
>   make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
> 
> git bisect says it's the first commit introduced the failure.

Hmm. So your /usr/include/sys/prctl.h and
/linux/tools/include/uapi/linux/prctl.h both provide struct
prctl_mm_map but their include guard must be different.

My /usr/include/sys/prctl.h is provided by glibc and contains the
prctl() declaration. It includes also linux/prctl.h.
The tools/include/uapi/linux/prctl.h is the same as
/usr/include/linux/prctl.h.

The /usr/include/sys/prctl.h on alpine linux is different. This is
probably coming from musl. It contains the PR_* definition and the
prctl() declaration. So it clashes here because now the one struct is
available twice.

The man page for prctl(2) says:
|       #include <linux/prctl.h>  /* Definition of PR_* constants */
|       #include <sys/prctl.h>

so musl doesn't follow this.

To align with the other builds, I guess the following help:

diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 26382e4d8d4ce..540261f299b1d 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -2,7 +2,6 @@
 #include <err.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <linux/prctl.h>
 #include <sys/prctl.h>
 
 #include "futex.h"

Sebastian
