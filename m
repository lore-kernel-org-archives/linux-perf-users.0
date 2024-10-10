Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A610E3
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728519658; cv=none; b=iCdWy/gaEh8jqVhpIoO3QLQZndEAx+i9hUNR9sKgIzVsp+qcLr5DbqYupAOB9F0KoidaKT7Ck6BJ2RDaj7wuRY8LOzUfAhzrARm0w9GSWI94duGiPb767TGuuVGp0O1VAXeQLqVkidUFjJMMvUlLKxSyAHLNIpqLvjMePRp7w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728519658; c=relaxed/simple;
	bh=l2Deo3o2w1tBXjqDxnBRlgacYtlr0u3W1yFT+EJ/aNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGbAnS81tqkKbYFswHw0gQhY1SvjJFPc4W8cI8DQcNmzFveTLbU+tLNnnAa1bDCxG0XJtZ8iVn1L1Zo1sgEAAb/jjne8TmdDDKVAqvmOhIWK1pQtThK/xeyozCLn+JcBphWqtqxAHvN0lCBf1wjy6t3oC/uwDDtRXsHX0XYeOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StskLDfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StskLDfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D5DC4CEC3;
	Thu, 10 Oct 2024 00:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728519657;
	bh=l2Deo3o2w1tBXjqDxnBRlgacYtlr0u3W1yFT+EJ/aNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StskLDfZQWVnT1wCFe+I+G++Zrag51P1qAiUZ0VMDelXfTA7bOXywCR5Qkt0XCEjP
	 q0/1RaSUrFBxy/TuguBuuPzP77cMLCklCwG2Jt26/dVXOdFvNChYWrCKx0HWAdWkeF
	 f92voG9f/jXKIss07EtfcL0easXZtSdCT5m+M5Ulc+QRu/AL38/FV2+itQUgRQQGhk
	 mlcihUcC4WDRYancNhO0TUsfikJ3HISvDGZUQhH7yIivyjLrnec6Z0kwHynCy8vBTy
	 xPBZ4aEP/6DjkhuFSXGVfBP3pSKZQ9XZHGRCpP7yPA1BBaXWtRbmw/aQv679fJzzvt
	 YSK9Fa4Fb4k4g==
Date: Wed, 9 Oct 2024 17:20:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Steve Clevenger <scclevenger@os.amperecomputing.com>,
	james.clark@linaro.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
Message-ID: <Zwcd52bq3AqetafI@google.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <ZwTIbRbAX2EX31X8@google.com>
 <c2b1d122-83e5-4392-9009-2d22e59aa14a@os.amperecomputing.com>
 <ZwWdhvud5f7tRxkW@google.com>
 <b484a69a-534f-4274-a000-94edf4d2521d@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b484a69a-534f-4274-a000-94edf4d2521d@arm.com>

On Wed, Oct 09, 2024 at 04:24:29PM +0100, Leo Yan wrote:
> Hi Namhyung,
> 
> On 10/8/2024 10:00 PM, Namhyung Kim wrote:
> 
> [...]
> 
> > On Tue, Oct 08, 2024 at 11:24:45AM -0700, Steve Clevenger wrote:
> >>
> >> Hello Namhyung,
> >>
> >> Sorry your question is so late. I don't include the ELF headers here,
> >> but the problem can be seen with a perf.data packet dump of user
> >> instruction trace capture. The problem is with the non-zero pgoff. The
> >> arm-cs-trace-disasm.py script was never passed pgoff information to
> >> adjust the start/end disassemble range passed to objdump. This patch
> >> distributes the fix between perf and the arm-cs-trace-disasm.py script.
> >>
> >> Here's a brief excerpt from an e-mail I sent to James Clark describing
> >> the patch before I submitted it.
> > 
> > Oh, is it applied to the coresight tree already?
> 
> No.
> 
> > I don't think I got> any notification for that.  Please make sure to notify
> perf maintainers
> > (and hopefullly to get Ack's) when you touch non-coresight part of the
> > code.
> > 
> > Also I think we need to clarify how to route coresight tool patches.  I
> > thought they are going through the perf-tools tree.  But it doesn't seem
> > to be the case?
> 
> AFAIK, in most cases, Arm patches for the perf will be picked up via
> perf-tools tree, including this patch series.

Ok, I was confused and thought it was applied there.

Thanks,
Namhyung

> 
> [...]
> >> Fedora 39:
> >>
> >> 4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
> >> 18229/18229: [0xffffa5512000(0x1d000) @ 0x10000 103:04 161 4093340249]:
> >> r-xp /usr/lib/ld-linux-aarch64.so.1
> >>
> >> 4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
> >> 18229/18229: [0xffffa554f000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> >> 4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
> >> 18229/18229: [0xaaaade7e0000(0xb000) @ 0x10000 103:04 536876423
> >> 421616320]: r-xp /usr/bin/dd
> >> 4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
> >> 18229/18229: [0xffffa5360000(0x11f000) @ 0x30000 103:04 536873199
> >> 2415801053]: r-xp /usr/lib64/libc.so.6
> >>
> >> The arm-cs-trace-disasm.py script never gets to see the text offset into
> >> the dso binaries, so has no opportunity to adjust the start/end address
> >> range passed to objdump. This wasn’t a problem on Fedora 37 and below
> >> since there’s no start/end adjustment for a zero text offset. On Fedora
> >> 38/39 distros, the instruction trace shows unconditional branch
> >> instructions which do not branch to the target address, the clearest
> >> indication of trouble.
> > 
> > Ok, thanks for sharing this.  I'm ok with exposing pgoff to the python
> > script itself.  But I'd like to make sure if it works correctly with
> > PIEs that have non-zero page offsets in other places (probably ok).
> 
> Fair point. The 'pgoff' is exposed from the kernel's VMA info, it is a runtime
> value after the DSO loading. After set the MAPPING_TYPE__IDENTITY type for PIE
> DSO, the 'pgoff' will be ignored in both the perf tool (see map__map_ip()) and
> the script.
> 
> Sorry that I missed this part when reviewed the change. I understood Steve
> have verified the script result. Seems to me, the critical question is kernel
> has an offset for PIE DSO but why ignore it in the tool.
> 
> @Steve, if you have more info, could you explain a bit what is the reason for
> ignoring pgoff for PIE DSO?
> 
> Thanks,
> Leo
