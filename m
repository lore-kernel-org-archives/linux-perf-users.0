Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713753526E
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366703; cv=none; b=czY0q+GfQ40mIjxG2FaILCoBaB7wKdeJcccoJSVblwKQe63UbS34jY074TX5X3d7+mR7UO7rUd/MSdHdfB5djy+OifkmftJGfWA7ySZ1I6/KFOZ1vY1LM3wWog6hqILaRFTo7ixNscdSDJwlfCaJxUR/lZIy0wADP4LIOTzJgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366703; c=relaxed/simple;
	bh=g5l6DPMapMAuxJuwVbpVEp3+VWwG07Afb3X2juxiIQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE8gItR38WcV9I7+vvo/3HrDjuIcQH+S6+yfBtA5zyi5LOHW4lGE60JUhkrCXk1MuJYIjd/0NxuJxX5yc1kODa5Ue6EGmmdkJvirx1AlChdzfkXsnSuYdL/6CKnYyLTP0zo/eljJwhVQo0SEmiiGriETmNvtXmA5FWF14++ol7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/iF/CC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/iF/CC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951BFC4CEC7;
	Tue,  8 Oct 2024 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728366702;
	bh=g5l6DPMapMAuxJuwVbpVEp3+VWwG07Afb3X2juxiIQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/iF/CC0OK2nZz/wniwg1xOOPmj3WGvd26/APTiEEJxCWLnDtRkW2AgTCOiL/ogeJ
	 97+On8sM+gZCteFHvyrJHMWeIJ0mRvyQ6UQyxCVRh9Q0NSHVfuviLCDi0Drg9Jpica
	 pJSCD4YZWRo/R6/dz+gD54JnDoyv1YXu3KIORdaPHmhfrK4v+cCv+EnE5j4JfotI8D
	 2z8RscjfW7I1rBfx7EihbA5pbjwaX+3CpKN2tDO/qKBqfi0a3/SHROYuSwMGu8y5yF
	 0S45l7mUO8d6QjwppC6NC5zpth5fZZ9EB1/Umg+Sgnyb6RX4J8CGe8Gralt3RhiFxl
	 TA7aWlGvD1nfA==
Date: Mon, 7 Oct 2024 22:51:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
Message-ID: <ZwTIbRbAX2EX31X8@google.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <cover.1725667397.git.scclevenger@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725667397.git.scclevenger@os.amperecomputing.com>

Hello,

Sorry for the long delay.  But can you please explain your problem in
more detail?  Showing ELF program (or section) header would be helpful
as well.

Is the problem when the text mapping has non-zero pgoff only?  Is the
kernel symbols working correctly?  Or is it just the Python script
broken?

Thanks,
Namhyung

On Mon, Sep 09, 2024 at 03:30:02PM -0600, Steve Clevenger wrote:
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
> Steve Clevenger (4):
>   Add dso__is_pie call to identify ELF PIE
>   Force MAPPING_TYPE__IDENTIY for PIE
>   Add map pgoff to python dictionary based on MAPPING_TYPE
>   Adjust objdump start/end range per map pgoff parameter
> 
>  .../scripts/python/arm-cs-trace-disasm.py     | 17 ++++--
>  tools/perf/util/map.c                         |  4 +-
>  .../scripting-engines/trace-event-python.c    | 13 +++-
>  tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
>  tools/perf/util/symbol.h                      |  1 +
>  5 files changed, 86 insertions(+), 10 deletions(-)
> 
> -- 
> 2.44.0
> 
