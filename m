Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360E34BA56;
	Mon, 12 Jan 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236663; cv=none; b=EGVbjVIjL3912GDBqcqXgNjK79XJl3Ff2ccrmIZdvk9MdKQmABsjbG00mbF9il3He18S1lzqxcj8XvPBHUFAy6xmLnCjkpH6zEj1WfpLdX7sZy2vYl4TPjcoI+ISuOXlzEbVwUEKa3k7TWqeVGCuJ6ascYeNWrwAoZppJsCDvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236663; c=relaxed/simple;
	bh=fnfFypMptK9nR/ENG+mPzO2KwNInH7zg0MNxfXuPPtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fuv9KiE9xhLCTZbmjW5jGFCG2LmOPB7vclKBZv0ofPaM49W946Tn832d0Rb8CPGc/jBkLACWSiQwSweLlDFhSS2sBbHb1QR9HVcPJb1leytWhB6uCfj3/uJz8vTW+dIZLmm+xYB3KQ4nsI1qkMLJqolWqo8LJr9Kchlm5RJS5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgOUCd6V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgOUCd6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768236661; x=1799772661;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fnfFypMptK9nR/ENG+mPzO2KwNInH7zg0MNxfXuPPtU=;
  b=CgOUCd6VW9mJ903rEG5rCtnNFpcBHFJT1eXQKGPj2zaI9gbacajbTcUl
   imsjEkWGAfr6ywywOgUwaTkEnNLrJNdRlhX77T7be8puMnqk9Z7VbCmPH
   f73/QBlvVjkPySLQarbVWEPFrcmpFuY07TuL7TIixTO3WjE/AxA5mvQRT
   qzKKJ/CJZvTSoTwresa6V/h1mgyNODV1tQWjHaDO+SkHqTe02229bR9ta
   eKefArza+ZP+RBruoJAiICLVvMPXQ5ef8cwwUTjt+go+zVrCLDEPXzqH+
   b7CzOWF61d/hX4xK4oR8j7nVGsMpoJCG6g+eNrVhd1lSgbZkYg0IWOWjQ
   w==;
X-CSE-ConnectionGUID: Nf4V+xGIQA6H40fZYxKorg==
X-CSE-MsgGUID: Go1gkgJiT5qUf74eueXn/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73144478"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73144478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 08:51:00 -0800
X-CSE-ConnectionGUID: Fv8UnYvNRT6BrKFH0vXztQ==
X-CSE-MsgGUID: RuOYQtVaQJCUUYymhoVEHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="203292499"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa006.jf.intel.com with ESMTP; 12 Jan 2026 08:51:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id E2AA1302315; Mon, 12 Jan 2026 08:50:58 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung Kim
 <namhyung@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Adrian Hunter
 <adrian.hunter@intel.com>,  James Clark <james.clark@linaro.org>,  Thomas
 Falcon <thomas.falcon@intel.com>,  Thomas Richter <tmricht@linux.ibm.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add procfs based memory and network tool events
In-Reply-To: <20260104011738.475680-1-irogers@google.com> (Ian Rogers's
	message of "Sat, 3 Jan 2026 17:17:36 -0800")
References: <20260104011738.475680-1-irogers@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 12 Jan 2026 08:50:58 -0800
Message-ID: <871pju4vwt.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Rogers <irogers@google.com> writes:

> Add events for memory use and network activity based on data readily
> available in /prod/pid/statm, /proc/pid/smaps_rollup and
> /proc/pid/net/dev. For example the network usage of chrome processes
> on a system may be gathered with:
> ```
> $ perf stat -e
> net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_carrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo,net_tx_packets
> -p $(pidof -d, chrome) -I 1000

But AFAIK that's for the complete network name space, not just the
process, thus highly misleading in perf context because the scope
is incompatible.

-Andi
