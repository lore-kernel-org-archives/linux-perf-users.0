Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1996F06A;
	Thu, 13 Jun 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294347; cv=none; b=CldYAaV7TCcbSaTIPwt79ZEQhrlNDIzggPRosN/nOKieXUmzwxi49+kTjeEDVqinNDc2uFmZPZ46RCGYWKrUDoqZDujnGvZ8QkAGP8aoltRtqRmOKP74ndbGgn4bnuPJpTmQPCdH2Ku+h0QalYJsaS88Pnu1ErEBcbzwK3+tacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294347; c=relaxed/simple;
	bh=M76704BSEUAkeCif4VQf1h7Y/MDSkPbNp+i1iYIwML0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cl4tuRPERutTZtm7BPY/CUmBUNfDFSrckr5Gd9tBrQlaHdjzPy4/fxzFctuoahhd/Lmyyzpaw8NsSee7R649ZkHQh1RNmdp3KouIUNj4B/mgKUfVZkTaFYyNVTy2RJ/K8xwqAAW1YYUjuf6oGFqsoxVMLIfsKLzICWaaaBzWKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6MDHW85; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6MDHW85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718294346; x=1749830346;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=M76704BSEUAkeCif4VQf1h7Y/MDSkPbNp+i1iYIwML0=;
  b=W6MDHW851UCS+cUkM8jHpRdDPM2MmThqFT2VAm1ott/qa/jCfdF5GNZZ
   5B61N4CS6NBErSF5xuLFzdZexnSVakgbaZkvvMxPN/sHAEF1X9l/qLZTj
   C///j+3bS6REcmf87ShR3nrZ82RT/w0jflQ4OncGpsK7rcyIkDe9k29Dr
   kj4NegliMh99495DKmWrKZ5yzF2GS4TFVmxiUztJ0j5Gh55ZuLqYQuMbd
   x0h0nSOyAyTGXfn/pq4PwtHyWTQHtH9zlVpPaq9ecPgVS4YNL2XXQQVlQ
   z6UYduAkBBJXomf9LtnUkym83U+04l8AZmxO4ozc+XlhwjrI3GE6Ix4rd
   A==;
X-CSE-ConnectionGUID: Dgh9aGgCT4uz8P/MpAcRQg==
X-CSE-MsgGUID: FgWPyUf8Sr2Tb9mUFdEqcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15256986"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="15256986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 08:59:05 -0700
X-CSE-ConnectionGUID: y76LoGonTeGeGuRfWkgG3Q==
X-CSE-MsgGUID: h6JawP/dSYaoeuVyQENLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="77658574"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa001.jf.intel.com with ESMTP; 13 Jun 2024 08:59:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id EA8A63059BA; Thu, 13 Jun 2024 08:59:04 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org,  syzkaller@googlegroups.com,
  harrisonmichaelgreen@gmail.com
Subject: Re: WARNING in __perf_event_overflow
In-Reply-To: <CAJg=8jzsPbjKkKmZudMvFJDnmBHhRrZqPLACs4NibLNdga02MQ@mail.gmail.com>
	(Marius Fleischer's message of "Tue, 11 Jun 2024 12:59:35 -0700")
References: <CAJg=8jzsPbjKkKmZudMvFJDnmBHhRrZqPLACs4NibLNdga02MQ@mail.gmail.com>
Date: Thu, 13 Jun 2024 08:59:04 -0700
Message-ID: <874j9wkf5j.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marius Fleischer <fleischermarius@gmail.com> writes:

> ======================================================
> description: WARNING in __perf_event_overflow
> affected file: kernel/events/core.c
> kernel version: 5.15.159
> kernel commit: 83655231580bc07485a4ac2a6c971c3a175dd27d

That's a really old kernel version. Does it reproduce on something recent?

> git tree: upstream
> kernel config: attached
> crash reproducer: attached


-Andi
