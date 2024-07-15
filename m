Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B97BF9EC;
	Mon, 15 Jul 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071916; cv=none; b=seUh2eGXpEjpdl+KA0PCewpXfwv7MtuoKLySXV90pLPOIwcqnvbj4ZTiRq+dOwVPVBWjzmsxibtPpGLWcpYkmyUYuG8kAM+7ao3xufNP0I0IHQUyC/B4ZO/5eKVPv0KqpI2Cl+54B7C3rPUoo97wzPiZ0jl5D/d01QfJuWp+Clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071916; c=relaxed/simple;
	bh=H/LlZMv0vkZe4USaGdJRqblruNiOzAe5CBF5AZINWhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOHWOi/BchI+kD2HVJ4I15+9ZhlCE4jcZH2hz546m3pY3NSkuNm/cx1AV+MWrlkFkSr3ToPMq282PLX1Pjw+qxp98Y8ULc00upicuJzmVUEiEbwO4eC0zmfinYGu5Uk19zJeb74Swyjpaqfuqq9ZOtP2MLgTDueFWnTT6FCtnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1EF6FEC;
	Mon, 15 Jul 2024 12:32:17 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1403F766;
	Mon, 15 Jul 2024 12:31:50 -0700 (PDT)
Message-ID: <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
Date: Mon, 15 Jul 2024 20:31:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715143342.52236-1-leo.yan@arm.com>
 <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ian,

On 7/15/24 18:17, Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 7:34 AM Leo Yan <leo.yan@arm.com> wrote:
> [snip]
>> +Android NDK compilation is deprecated and no longer supported.
> 
> I think this is objectively worse than just removing the file. It is
> likely the perf tool can build with clang/LLVM, I do it every day

Just curious, are you using LLVM/clang for cross building (e.g. build
aarch64 target on x86_64 host) or just native building?

Clang/LLVM is a natively cross-compiler [1], I installed Clang-15 in the
offical package on Ubuntu, but I failed to do cross compilation with it:

   make ARCH=arm64 LLVM=-15 VF=1 DEBUG=1 -C tools/perf

> and the special case for Android is likely more about the libc (aka
> bionic) which gradually over time has been becoming more full fat -
> perhaps we need to carry somethings in tools/include for missing
> definitions, but we build with musl and that's a PITA in this regard,
> we've also been reducing the tools/include dependencies for perf trace
> beauty support. We don't use ifuncs in the perf tool (Android's
> linker/loader historically hasn't supported these) and the weak symbol
> games should be okay and something I aspire to make less in the perf
> tool over time. As Android uses Linux then it should work and should
> be supported.

Let us drop this patch.

Thanks,
Leo

[1] https://clang.llvm.org/docs/CrossCompilation.html
