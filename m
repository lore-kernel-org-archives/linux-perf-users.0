Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F461B0F23;
	Sun,  7 Dec 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765140269; cv=none; b=Nx3L2tph+TwGdxHLuwsaQ/WfBrUxZASK5e5Y2VgmbZZMXl0LmT9Lt6v3ePMuchDVPZM7tKFxvKZv9Ttv1c4anxj5hZnyurNv3JWr6a5Wc3Fn41go51lhiba1qkiYYs88Xf5b/meRJatkiqiQT3Rp4QoYuVXeh9RTsi6DfyHJXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765140269; c=relaxed/simple;
	bh=0/IR7NFuibvHSDcb6+7bADiUb9ww/Q0iDkItnty5WFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RooT71v/jMf7LwmqCBzsk6eNC/v6OZTW9knOMnmLz/k5YqnWJZiJ4keyRRb1KdOM/p5lhkFJqEtOV7MNXhdFVxI7lc0Cg+iPgFolzm3gLsU8n+pVcGa14u9SY+RSmWY4a93eZRCr4iknYqHiqBgsGqiABErlcNiRvYzZ9LYn1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1pSqSW2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1pSqSW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765140268; x=1796676268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/IR7NFuibvHSDcb6+7bADiUb9ww/Q0iDkItnty5WFw=;
  b=h1pSqSW21+Fg+V1J6DS0FPQflansDWJZLWHxnQf2Xh6w+tEIuXuxRNi9
   0D3idW2ZQK1I1RE6E2U4lF+nBWf3YC3hJcIzt7vOfXin0NyT9qt/9Vg5X
   wuRgIGa+uXxNBBh5uOR0srwY/JhiTGC5gHptXwQ/cDtorqgGWM5KcluxE
   QUjgPLdsevRxY3C8pOOv/oT3NXx5Hbnp9ghkiKaExK7etUfoq9hTOJTpC
   vgoZmwWPxi26C5s46Cer1uVvNeE1oKtssWpWenTamP7sAOstiDqyShAHx
   ZKYqioCZDJD8kabc3+b4rTb66w1rFuX+bkq+b7Eqa04I937njv/fFmo84
   w==;
X-CSE-ConnectionGUID: ce5CA/79Q+axlpMUq35D3g==
X-CSE-MsgGUID: d97trK+GRWG8XoB+g4EDPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="77413576"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="77413576"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 12:44:28 -0800
X-CSE-ConnectionGUID: oKtSUiwaRUmxtbG2rxufCw==
X-CSE-MsgGUID: kCh5To28TZuEbJ3ppazQVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="199939907"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 12:44:27 -0800
Date: Sun, 7 Dec 2025 12:44:26 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 16/19] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
Message-ID: <aTXnKl2oCmrp11eq@tassilo>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>
 <20251205123940.GY2528459@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205123940.GY2528459@noisy.programming.kicks-ass.net>

On Fri, Dec 05, 2025 at 01:39:40PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:57PM +0800, Dapeng Mi wrote:
> > When two or more identical PEBS events with the same sampling period are
> > programmed on a mix of PDIST and non-PDIST counters, multiple
> > back-to-back NMIs can be triggered.
> 
> This is a hardware defect -- albeit a fairly common one.

Actually I disagree on that. PEBS is essentially a shared memory
protocol between two asynchronous agents. To prevent this you would need a
locking protocol somehow for the memory, otherwise the sender (PEBS) has
no way to know that the PMI handler is finished reading the memory
buffers.

So it cannot know that the second event was already parsed, and
has to send the second PMI just in case.

It didn't happen with the legacy PEBS because it always 
collapsed multiple counters into one, but that was really a race
too.

-Andi
