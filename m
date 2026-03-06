Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FFF35AC2B;
	Fri,  6 Mar 2026 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791557; cv=none; b=FL79R5Fu/BO22p32ZRqFeswDpqvH/0wVM/Z1L2yCMD7VrwetcIPQU9agqFu/d8PVpyfC8XjmWd+2v3zNY/VfivVh8rC03SjDM9gi01EgwnXjlzakecDn3WKR7wD/pj8DurjppdySJukkJQkWZkC1Ze1xNn+r6G7vnbKNrCt+X18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791557; c=relaxed/simple;
	bh=4mDtf74g6e0FeWidSdm2KVQMbBrJo1er3rg5QHEyWtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnS+h1oIETn6cFd+f4A9wnsRJYseHpaj8q/BDctM1XSdU273HdZbIAFcL6mlZr5lxh4WO3EqVO3gGRm8WnKCYUOK/tSkPTKtdE87OLt1NmCmGDNlk5a+BHTJvYU6O6lq0j2cmghc7gr++9AU/3RzN6BjmhhmMplIurbCcD98wH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71722497;
	Fri,  6 Mar 2026 02:05:41 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B58F3F694;
	Fri,  6 Mar 2026 02:05:47 -0800 (PST)
Date: Fri, 6 Mar 2026 10:05:45 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 fyi] tools headers: Update the syscall tables and
 unistd.h, to support the new 'rseq_slice_yield' syscall
Message-ID: <20260306100545.GK1098637@e132581.arm.com>
References: <aanmUizWVEcq6nw5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanmUizWVEcq6nw5@x1>

On Thu, Mar 05, 2026 at 05:23:46PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
>     diff -u tools/scripts/syscall.tbl scripts/syscall.tbl

Arm64 directly uses tools/scripts/syscall.tbl, I can confirm that this
patch works for Arm64 after updating tools/scripts/syscall.tbl.

Note, tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl is not
synchronized.  This is fine for me, as perf generates the syscall array
using tools/perf/arch/arm/entry/syscalls/syscall.tbl instead.  We can
consider to remove tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
as it is not used in perf, but this is not in this patch's scope.

For Arm and Arm64:

Reviewed-by: Leo Yan <leo.yan@arm.com>
