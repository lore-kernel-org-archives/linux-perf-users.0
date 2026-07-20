Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D03D093B;
	Mon, 20 Jul 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536773; cv=none; b=E9drvmzlI//E4M9Fs2d8X8jLYZ+gqsYsMeMNj7L0rL2XFygByX1yyadi0MtJUeqGJ2CQF9SEpcc5hTDlrdw025SGwlIdLCwpw+ccprzTgceJ7qQER1skgqd0hhpyGfRI8wE8XlFyWTS7BZYsou71TCiK26GY1uKFIy9G7ELuAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536773; c=relaxed/simple;
	bh=FaeBZsFhBAAgF0Wu7YC3HCkkDJg3fT1vhq8aeI7OmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdD6xKUr8aFRdRVWICbsc6+AiDQdGdQ0BOJTGMedGgVfEZV8Tm0fKu0remkCskeXMuiOGRA8bevotoLBqqLRh234I190cwSqoDb8OK2EUslL+Gx3Mlx3oQOD+FmH3O0B6B4X2mz9P35bXYrVh7KCtTQZSthvgApPTfxsjPlsWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwOFK/J4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwOFK/J4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784536771; x=1816072771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaeBZsFhBAAgF0Wu7YC3HCkkDJg3fT1vhq8aeI7OmUM=;
  b=fwOFK/J4ix2ah5AE+9s7p5sM1Jv/RAXj9doM1SVHPuNyJKIazwPu7aO4
   ibeMx7yJTG5y9fCspH+CYOKH2HnzV9KW1u0udMUzdqKkKLwaR+7XvC9dU
   RcId//WZFkHZjLXDdBHewfbdNEaZ7kzb8nKQucjBaZ4fypD8UTwOi+2Rh
   fM+7wCkX7L4nCFZNjUmke8oReroucg9dgqoml3eJ2Msc7MP8haSsosvDs
   maUhvFkvm+R5rejjNK+6KaaNPjcyBGiRDeCAAYQaTqSNnPZJmW7De6X/Z
   j9TE90lvwFIVp5xXhTrpgeAPOkMEA3VyBV6EUPAc/270ySgPnDDplIoui
   g==;
X-CSE-ConnectionGUID: kB4s26cNTyiRMJRVHqOAmA==
X-CSE-MsgGUID: 9WHH31V2QOiEqXmTUGyLQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85310905"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85310905"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:39:30 -0700
X-CSE-ConnectionGUID: W0cNPmqvQ0ah93Qn6xWruA==
X-CSE-MsgGUID: YrAP6W6aS4GgXapBRRrYTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="259396999"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 01:39:25 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH v3 00/14] perf c2c: add a function view
Date: Mon, 20 Jul 2026 16:39:24 +0800
Message-ID: <20260720083924.2735509-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <alsH9PFMljK5eUEJ@z2>
References: <alsH9PFMljK5eUEJ@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thanks a lot for the detailed suggestions -- agreed on both points, and I
wanted to get your thoughts on the reworked layout before sending the next
version.

> I think it's more like "code-address" view rather than "function" view.
> How about organizing the output something like below?
>
>   L1:  function
>   L2:  cache line
>   L3:  shared functions

You're right that keying level 1 on the code address made it read like a
"code-address view". I plan to rework it so every level that names a
function aggregates all of that function's code addresses into a single
entry, together with the per-level indentation you described.

For the lower levels I first tried the cacheline-then-functions layout you
suggested:

  L1: function
  L2: cache line
  L3: sharing functions

but on real data we hit one problem: when the level-1 function touches many
cache lines, the same contending function shows up under many of those
level-2 cache lines. To find out which function modifies the line the most
-- the one most worth fixing -- we then have to aggregate that function's
writes across all those cache lines ourselves, which is the same manual
work the cache line view already leaves to us.

So I am considering putting the contending function at level 2 and the
cache line at level 3 instead:

  L1: function            (reads the line and pays the HITM penalty)
  L2: contending function (writes/modifies the line, causing the HITM)
  L3: the shared cache lines

For example, expanding dequeue_pushable_task and its writers:

  Cycles  Store
       %  count  Function / Contending function / Cache line
  ------------------------------------------------------------
  - 16.54%   419  - [k] dequeue_pushable_task
             145      - [k] pull_rt_task
             145            0xff2d0082809da080
             139      - [k] enqueue_pushable_task
              70            0xff2d00a2071f9640
              69            0xff2d0082809da000
             133      - [k] cpupri_set
             133            0xff2d0082809da080

Here enqueue_pushable_task contends over two cache lines, but it stays a
single level-2 row with its total (139) shown, and the individual cache
lines are underneath -- so the top writers are ranked directly, with no
manual summing.

The key difference from the earlier version is that the code addresses and
function offsets are no longer shown at level 1 and level 2. Those made the
view read like a code-address view; instead the main view keeps only the
concise, at-a-glance information (which function pays, which function it
contends with, and the cache lines involved), and the detailed code
addresses / offsets stay in the per-cacheline detail view ('d').

Once we settle on the layout, I'll send the updated version for review.

Thanks,
Jiebin
