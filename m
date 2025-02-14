Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667392AF16;
	Fri, 14 Feb 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561429; cv=none; b=qiJ81vqdJ/TJ5bPbH19Oi8+kNUr1YIAR5xSzZTyYGg3Gm4oOHxx7D4ANWUbmsj+AdBhutGUGaX2ZVDBmJD0+cvcxTJaX58EKHP3tMAVaXCQ5XcOs1sQ0dgGzlYBW3I8/TnjO+E1IN7Ffc1FBC7gZgkvNm9stGQSMFaFrSP50zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561429; c=relaxed/simple;
	bh=F0tGgRziuPNODndhIDji7sRp7N/y/msfVksKcfxLxRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uCPsBVPTWXNg3PM8p9y7XFwj3Ty8NtfZAygHEpkDj/+IWMoX4/9jlhMaQzIDacdrfvDE8Ld+/OMe5H7ZUj9Ziw1vft72A7MZfWWcsfJD/97EHIxlNH6StNEVqoYXUIro5qS/4tjneiLG3FHKF4G7H9JWgyAsOAZ98F5H/LO0fkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6lPxNki; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6lPxNki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561427; x=1771097427;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=F0tGgRziuPNODndhIDji7sRp7N/y/msfVksKcfxLxRU=;
  b=a6lPxNkiSI0BRmJqD6XqI5tktmlVd/GJnH74Ceyg7ZK6NjDqzA79gD9l
   ldUg7i4kU7vpbVZIiEvcivNhqM7Cul2uJZ+Rgvrp8cmdxKo26CLvQ6NFI
   9CGCvCOBszP/VD9o9aNqAkX/te6pAQEvugKCXVzi6pA8AmtFCNFMk/cnu
   0cLAjiWZtW3keO5qLI8tVZKVy+TLqS4+/tnjYmSGDhDiOkwFNMbK+1ttO
   MqhTIa9x/OJoNtpbSOVXE7NCp4Idk56X6Jxy7xDc4GuQdDzqOKkJFjN3q
   JKL52J9mJYBeyA0IK27D1a744RLNlaguPU7DmPwt+EZyjo86g1tc98yNM
   A==;
X-CSE-ConnectionGUID: nRAXW+hWSA287iTCDL8wUQ==
X-CSE-MsgGUID: sqsv249rR6md/bLhghIW7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40180736"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40180736"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:30:26 -0800
X-CSE-ConnectionGUID: N2kny59SSUOP4RIL1qwX+Q==
X-CSE-MsgGUID: /SJLuol+TR6Vraq4rW2APw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113504652"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa006.jf.intel.com with ESMTP; 14 Feb 2025 11:30:27 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 2D9803010C8; Fri, 14 Feb 2025 11:30:26 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  linux-perf-users@vger.kernel.org,  Adrian Hunter
 <adrian.hunter@intel.com>,  "Liang, Kan" <kan.liang@linux.intel.com>,
  James Clark <james.clark@linaro.org>,  Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>,  linux-kernel@vger.kernel.org,  Chaitanya S
 Prakash <chaitanyas.prakash@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Mark
 Rutland <mark.rutland@arm.com>,  Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1] tools: perf: support .gnu_debugdata for symbols
In-Reply-To: <20250213190542.3249050-2-stephen.s.brennan@oracle.com> (Stephen
	Brennan's message of "Thu, 13 Feb 2025 11:05:38 -0800")
References: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
	<20250213190542.3249050-2-stephen.s.brennan@oracle.com>
Date: Fri, 14 Feb 2025 11:30:26 -0800
Message-ID: <871pw0gw8d.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>  	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 66fd1249660a3..e578b7d406a69 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -6,6 +6,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> +#include <lzma.h>

This needs some ifdefs in case lzma.h is not available?

-Andi
