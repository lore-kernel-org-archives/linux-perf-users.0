Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AC23C505;
	Tue, 10 Jun 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580487; cv=none; b=j68Ze1pPo45BiZNTBQUZuR5HQ0GhiAvzS05b8xBtF5Ps0L3fF9vSMtGqz6K2zVw5c+l5DbuNwGm4NgUL7US+74MTPQ6O9fAM0le5h7ezOc4wToZN19V0QNgrfoIQMDFdzwXGDrQ4/hXZwTxKcLqEGF+VTBGNa79DxDCwHYZ334Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580487; c=relaxed/simple;
	bh=Radpja/DJiW3l3IEwuS7/pYBbr8TuNwFODl/fsPNnC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SPFz3vI7yFDqMkQgRmS4rsxOiLuKkS25RR0wP0jcOzonps1+9NROMgecr8BYSj16J0kxeC2SWqQsOAULMjpdPHR/i6PKGucU5dFjVSoTSVZahYQUYI4iVeMG9ed2uTHXdDuNkUwQSRrbu8vAo4UMt4iiKprHHzRkbIFe0o75tME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hilwAtL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hilwAtL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE83BC4CEED;
	Tue, 10 Jun 2025 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580486;
	bh=Radpja/DJiW3l3IEwuS7/pYBbr8TuNwFODl/fsPNnC0=;
	h=Date:From:To:Cc:Subject:From;
	b=hilwAtL/dHtuuNDD+GoWfe0ZFXFlw54DB1B7MfXr1wPavzMZ4tGs7eOgtL7ATXOQM
	 QDdEtP3UTMjwgFFPbC2T0vE0UIKM/eEFdWqzobL5tLBtO//nQPqukut4S/O6/u8sin
	 2M+DS4LICUrJ+OYgtJEaAkDm12KCmw026aG/7hh+pnzwZYwvHl+1/WNC0laLXbofe3
	 d8p5ChEBASdHxS4/Tf+T0IoqI43lY8fQoquEntPUdibZ35e+w69nt099nZN+jILX3k
	 w+Gllr/BMY6DRhIKWQnY4IkZCO+Yekgp7dreESC+dmpGBHX+UfWzMK6PPzJFYrCLyZ
	 jn6Sj3bu+iIVQ==
Date: Tue, 10 Jun 2025 11:34:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <aEh6xO14wDSCFUDr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I've updated the perf-tools-next to v6.16-rc1 and found a build error
like below on alpine linux 3.18.

  In file included from bench/futex.c:6:
  /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
     88 | struct prctl_mm_map {
        |        ^~~~~~~~~~~~
  In file included from bench/futex.c:5:
  /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
    134 | struct prctl_mm_map {
        |        ^~~~~~~~~~~~
  make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1

git bisect says it's the first commit introduced the failure.

commit 60035a3981a7f9d965df81a48a07b94e52ccd54f
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Apr 16 18:29:19 2025 +0200

    tools/perf: Allow to select the number of hash buckets
    
    Add the -b/ --buckets argument to specify the number of hash buckets for
    the private futex hash. This is directly passed to
        prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, buckets, immutable)
    
    and must return without an error if specified. The `immutable' is 0 by
    default and can be set to 1 via the -I/ --immutable argument.
    The size of the private hash is verified with PR_FUTEX_HASH_GET_SLOTS.
    If PR_FUTEX_HASH_GET_SLOTS failed then it is assumed that an older
    kernel was used without the support and that the global hash is used.
    
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lore.kernel.org/r/20250416162921.513656-20-bigeasy@linutronix.de

Thanks,
Namhyung

