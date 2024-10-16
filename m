Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98518BC23
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101114; cv=none; b=ssP752jYHhuAAFfnYpWELgYUgDgPOAJDn76kHHaKj0oSvVLBO7vZ6WXiHkNgOBe+aoN3YEKspEDmm7F2PIQDJfXsjVs3wFaoZERexk4JMYXiXGybTxkFR/XwIp4+BfgEHLhi51rZUDhXhjQ49nskTVfYbawHjCasIcx04O/ZtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101114; c=relaxed/simple;
	bh=Q/rMGnUiexOywnQsnS70I2iihXeyPYW5rsx865r2iTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWs1kaFL57x/R++P3YfIQqNOLeNgvrLmvMFbmPfo7fZsJ9Dfn1P34r9Mi619dnOe7TYhtbCVm0aTviWyUpDF8WtqumrFJQ2kzd1Qnzl2qZcse3k3xE9DuXRndJssuas0/j5blmjP61+qUbRJcZKH547u9MkRICt6L27pe7LeGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLdhG/3e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLdhG/3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F58C4CEC5;
	Wed, 16 Oct 2024 17:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729101114;
	bh=Q/rMGnUiexOywnQsnS70I2iihXeyPYW5rsx865r2iTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLdhG/3e7pb2KU5XrNDBrK7GRfbIWXXRVJ+JcD+G4rSAmvXIgjBh/d/zOt1w8e8e3
	 2mn8Aohvan/5kUM0uV0zArl5yXY8zU78PLf/nGSd5uv+iY+JnNWMY5BB7WTvfxw2+z
	 DLvw9CnEn9NTcBf8gHLWIcfITKK2NIniXIpJ9gOQKlLdevqWZM1X97UjoGeowHnoaQ
	 YSFYftfZMnOYQdqHBatH169Z7ytsEnrHIpOX35XWH+51s4RagpYg0xdgDTeLfqDLb1
	 QaoTXj0Hw7MnwJl7Rq+t+UQkNXA1jy+EA+eKZnmQrvhbcdTxssl3NhM97joGFYuRl6
	 CC7ts1XTh3NaA==
Date: Wed, 16 Oct 2024 10:51:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>, leo.yan@arm.com
Cc: james.clark@linaro.org, mike.leach@linaro.org, suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V9 0/2] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
Message-ID: <Zw_9ONdBzZER6zek@google.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>

Hello,

On Fri, Oct 11, 2024 at 11:17:10AM -0600, Steve Clevenger wrote:
> Changes in V9:
>   - Removed V8 patch files 1/4 and 2/4.
>   - Modified set_sym_in_dict (trace-event-python.c) to add map_pgoff
>     in dictionary as-is without regard to MAPPING_IDENTITY. This patch
>     file is now patch 2/2.

I think the previous version had Leo's Reviewed-by tag.  

Leo, can you confirm if it still holds?

Thanks,
Namhyung

> 
> Changes in V8:
>   - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
>     string.
>   - Remove map_pgoff integer conversion in dso not found print
>     message.
> 
> Changes in V7:
>   - In arm-cs-trace-disasm.py, fix print message core dump resulting
>     from mixed type arithmetic.
>   - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
>     CS_ETM_TRACE_ON message is changed to print only in verbose mode.
>   - Removed verbose mode only notification for start_addr/stop_addr
>     outside of dso address range.
> 
> Changes in V6:
>   - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
>     map_pgoff to start/end address for dso not found message.
>   - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
>     by Leo Yan in V4 and V5.
> 
> Changes in V5:
>   - In symbol-elf.c, branch to exit_close label if open file.
>   - In trace_event_python.c, correct indentation. set_sym_in_dict
>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>     match local naming.
> 
> Changes in V4:
>   - In trace-event-python.c, fixed perf-tools-next merge problem.
> 
> Changes in V3:
>   - Rebased to linux-perf-tools branch.
>   - Squash symbol-elf.c and symbol.h into same commit.
>   - In map.c, merge dso__is_pie() call into existing if statement.
>   - In arm-cs-trace-disasm.py, remove debug artifacts.
> 
> Changes in V2:
>   - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
>     checks per Leo Yan review.
>   - Updated mailing list distribution.
> 
> Steve Clevenger (2):
>   Add map_pgoff to python dictionary
>   Adjust objdump start/end address per map_pgoff parameter
> 
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
>  .../util/scripting-engines/trace-event-python.c  |  9 ++++++---
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> -- 
> 2.44.0
> 
