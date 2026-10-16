Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AB24DCF9;
	Fri, 16 Oct 2026 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118719; cv=none; b=p7SqTFKRTUpREuRRaXWgtWoqZnJUAMHuFWV4TTKW4RYRWH9xKqo+IB4sdvN9vgX6MzLLb9ECJBEIKxkUyX4BYi264i4oXEyuPxLDUEx+IRVYO1KOABc7QCGbk+DWqvqOFURSCiShPOVcAPtS8I1v8hOP6zQsT6or9nJsFv41e9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118719; c=relaxed/simple;
	bh=I7+ilmraSUzrcNxZh6aozdurxXD2/t/E4qtyy+eo2ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSpJAeSnPuCysP2YipVMpDnO76UDmnNeWT+YskLH1xgxqVXTdH3dGtikFHCu+U9ZC3imWllrKrVp/3IsMWRsC8EsQj6tmRcn9CkmU3Q+CHOvI0D47SItpJCrMrZzujSYtzP/cXaPi/twcAJcTNRc6Nc3pMJWnNFTFHkGuTY38Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl89BIlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl89BIlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1575B1F000C4;
	Fri, 16 Oct 2026 02:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118718;
	bh=BlIAy6HWo/kXDgbJZFG7yiw+GQkZq+GDaDT/QL7WkBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tl89BIltyTTokDGzdufyAZ6ob3g3JEU0o48X8/1H668RQXcWWw7OyRyyFBGX9KKmP
	 CB0g0F7rY0BdBYqGSSVNQ0edFTZVri+fs5HG5A29Q+MGETD88WePbAp43yNZ1YYtrm
	 xFwBOW+dErAYs7zf89loNyvCHLzTsqky9GyIrhHtRG874k9RbroVxl/uzoOZj2Cp2U
	 /rHTmN0fZiq/y8+Rvq/fuPNdqpHRy2KWcE2ISDosSi2wZx9a7CvXQy92Jxrz4y1Yl7
	 4Ekl6DvhUxkCNbgOWwQ2jkBa0DhXhOR1I2gh4qczpQ9lk0Kla0a3dVmrGT2DTDEEjY
	 Y4gnHIBvLxR1g==
Date: Thu, 15 Oct 2026 22:45:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] tools: build kernel selftests in tools_build
Message-ID: <atGPvKj_8pq2VPzh@laps>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-5-sashal@kernel.org>
 <8ee33f00-bd8f-4cf2-90c4-2961f443af60@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ee33f00-bd8f-4cf2-90c4-2961f443af60@t-8ch.de>

On Tue, Oct 13, 2026 at 10:41:00PM +0200, Thomas Weißschuh wrote:
>On 2026-10-11 19:36:43-0400, Sasha Levin wrote:
>> Add a "Kernel selftests" sub-menu with one entry per selftests directory
>> that builds with only a C library and does not write into the source
>> tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
>> pointing at the UAPI headers installed in the object tree, but by its own
>> make, so the selected ones build in parallel. Selftests whose Makefile
>> does not use KHDR_INCLUDES still build against the C library's copy of
>> the UAPI headers.
>>
>> The selftests do not track header dependencies, so a selftest is built
>> again from scratch when its own directory, a header or makefile any
>> selftest may share, or a kernel source it includes directly (the vDSO
>> test includes the architecture's vDSO code) is newer than its last
>> build.
>>
>> Selftests that need libraries beyond the C library, a vmlinux with BTF,
>> or a sanitizer runtime are left out for now.
>>
>> Assisted-by: LLM
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  tools/Kconfig         | 239 ++++++++++++++++++++++++++++++++++++++++++
>>  tools/Makefile.kbuild | 100 ++++++++++++++++++
>>  2 files changed, 339 insertions(+)
>
>(...)
>
>> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
>> index 62fd494253eca..c31347258d0a9 100644
>> --- a/tools/Makefile.kbuild
>> +++ b/tools/Makefile.kbuild
>> @@ -92,6 +92,106 @@ PHONY += perf
>>  perf: FORCE
>>  	$(call build,$(outdir)/perf,-C $(toolsdir)/perf -f Makefile.perf O=$(outdir)/perf $(perf-flags) $(perf-flags-y),,TOOLS_BUILD_PERF)
>
>(...)
>
>> +# Unlike tools/build, the selftests do not track header dependencies. A
>> +# selftest is built again from scratch when its own directory, a header or
>> +# makefile any selftest may share, or a kernel source it includes directly
>> +# is newer than its last build.
>> +selftest-shared := $(outdir)/selftests/.shared
>> +selftest-extra-vDSO := $(abs_srctree)/arch/$(SRCARCH)
>
>Can we not fix the selftests to properly track header dependencies?
>That has been an annoyance of mine for quite some time.
>It would also get rid of a whole bunch of hackery here.

Ugh... I suppose? The current check is also incomplete: it misses headers
outside the paths it watches, such as include/linux/annotate.h, which the vDSO
test pulls in, or tools/arch/x86/include/uapi, used by ir and proc.

I'll see if I can fix it up... 

-- 
Thanks,
Sasha
