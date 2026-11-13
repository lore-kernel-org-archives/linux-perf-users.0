Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567572;
	b=Sowt9RwvnJCQMnca7CjpKzE5oTgZA3+2McpC5fZS41NDTFZZ2Tx+pajFn8QRZlxOSTmS
	 C8TGre94RYVq8/bYW+TYeyr40TqtTpzM7boeuTe8HOhdBwFFKjb16uKk7sw+gmIGtvNpD
	 4m771Pdr3Z/6lb6jDSHNGYgG00xt8QDPHrUozqRo9XXGHNMp7FxJ8Nb8N00HYUlnMo8As
	 wYhQteIdnUghxxmt5x5C+a85bjS6py5xSO1bBWkRN1COvmTHwIwtN+DHrsXu/HfXE34M4
	 gwQprwCNvNFwwAygWhUEG2IhdAnkZ7/55R4TNISVW82RpziVGisqvmj4bKoG5LpowFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567572;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=oo7RjrzXgo/CEjpliqz3gqGyxd1KPs7Uh1SXdbTUxR0=;
	b=UBD66G2z/VATEiJdqPV7k0nkf5CMp2Wtg/ZDyzyT8Zy7iPtezza12/d7Tk2gQhlNhild
	 k0DPcpu+VDU3a0HxPrV50nxMvV6mb2oN46AnjYzh4UiO+8oirAXp7Np2Zg+lXNWcv6if5
	 Jh5T0Lm2nBxuqu2Bq/IzZwxJ0GXusorYbQrgdq5NzCSqjRO+tFlZmM9Ckt37IoV3qNyj0
	 +b7+UQ5KQHU06Zu7MQBEA+gdlZPQSSUKw8u0f4JkNCLNcVIUk/IDXnZEAmwLSoLkVxn5Y
	 cZMNcaRyw4ErKA4ip1LVOKfulh38fe7BSAhUSIuprzuwplYIH54SqJsnRczWspZ1+WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eHdmZKVl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91A8606A339;
	Fri, 13 Nov 2026 10:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B91A8606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eHdmZKVl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9DE1C0A;
	Fri, 13 Nov 2026 02:59:28 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C858E3F673;
	Fri, 13 Nov 2026 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794567571; bh=XUZhmq3u2xNG1YGicKKUsCPDU/uHI8M/joODV72JgGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHdmZKVlUeRxbO1js0VxizZUUCi7kGK+xvO/6P5sh6DJZKnORb99eLSQS/SQghozh
	 ktmmK0lqA7D3BO5kICPE1q4y7Jf8241rP8coqLJZp9JJ52aQ6jw7jbkOOwJMXtJgi4
	 tJDI3pvxprJULRN9Te+ZFfeWCxGLIRRfLB1jHb1s=
Date: Fri, 13 Nov 2026 10:59:28 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
Message-ID: <20261113105928.GN9176@e132581.arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
 <CAP-5=fUMwOb6Gj+5DOu9-yNmthDz5ghAqrzmZ4ACX0g+9WB59w@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUMwOb6Gj+5DOu9-yNmthDz5ghAqrzmZ4ACX0g+9WB59w@mail.gmail.com>

Hi Ian,

On Thu, Nov 12, 2026 at 11:07:55PM -0800, Ian Rogers wrote:

[...]

> Hi Leo,
> 
> After commit 9648f9fc3525 ("perf cs-etm: Synthesize exception entries
> separately from branches") in perf-tools-next, perf's build-test
> (`make -C tools/perf O=/tmp/build CORESIGHT=1`, i.e. `make_with_coresight_O`)
> with GCC 15.2.0 (`gcc (Debian 15.2.0-14) 15.2.0`, `-O3`) fails with:
> 
>   In function ‘cs_etm__t32_instr_size’,
>       inlined from ‘cs_etm__instr_size’ at util/cs-etm.c:1390:10,
>       inlined from ‘cs_etm__copy_insn’ at util/cs-etm.c:1572:21:
>   util/cs-etm.c:1381:28: error: ‘instrBytes’ may be used uninitialized
>  [-Werror=maybe-uninitialized]
>    1381 |         return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>             |                  ~~~~~~~~~~^~~
>   util/cs-etm.c: In function ‘cs_etm__copy_insn’:
>   util/cs-etm.c:1372:12: note: ‘instrBytes’ declared here
>    1372 |         u8 instrBytes[2];
>             |            ^~~~~~~~~~
> 
> The uninitialized `instrBytes` in cs_etm__t32_instr_size() is actually
> pre-existing from commit a7ee4d625ede ("perf cs-etm: Support for ARM
> A32/T32 instruction sets in CoreSight trace"): cs_etm__frontend_mem_access()
> (via __cs_etm__mem_access()) can return 0 without writing to instrBytes
> when thread__find_map(), map__dso(), or dso__data_read_offset() fails.
> The changes around cs_etm__copy_insn() in this patch just shifted GCC's
> -O3 inlining enough for it to inline __cs_etm__mem_access() and spot the
> uninitialized read of instrBytes[1].
> 
> Zero-initializing `u8 instrBytes[2] = {};` (similar to instr16/instr32 in
> cs_etm__is_svc_instr()) or checking that cs_etm__frontend_mem_access() read
> ARRAY_SIZE(instrBytes) bytes before inspecting instrBytes[1] should fix it.

See the series to fix the issue:
https://lore.kernel.org/linux-perf-users/20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com/T/#mcbc1b4ce7284c9575b273d504354ac733bcf39aa

Thanks for sharing the log and analysis.
