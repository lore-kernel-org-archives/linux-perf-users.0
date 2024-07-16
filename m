Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD01DDF5;
	Tue, 16 Jul 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144523; cv=none; b=PBNi8Bscw+itXPgLd8EwJgZrRa1XcdmeNx/YwhWV63f6HsaWhO4VetgxYny4Mx0fwknPcwY4TT6NXFMTc7fGGr0ugnMfKdOv6lHZMfejqlsGWGfLTUGLaGgiUtPGcQxfHIf0xM7jz64dXPgrEDgkhkGrefTfP4p5wq9/XZwdyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144523; c=relaxed/simple;
	bh=YDRfs8TeH7tguac1ZOsghS+/wUkkP+SkbqwvhONt+QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mydCwueidazWI5QYZX98W/mwea0Bx2WKD64x+tlCSxVghBmICjzR10M2p1l2NRpVIBbeHmsWsDxoTRWlAQB9xfoc+zEH5uFbdeodltDGzz9n37R0bTksFKD56LH+Fw4PTU22ZrLJOreneccMk2cghMDrNknJZ4hStMXs36Jnlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA3051063;
	Tue, 16 Jul 2024 08:42:25 -0700 (PDT)
Received: from [10.1.34.31] (PF4Q20KV.arm.com [10.1.34.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3403F766;
	Tue, 16 Jul 2024 08:41:58 -0700 (PDT)
Message-ID: <88887095-fd7d-4428-b96f-27e18b547b2c@arm.com>
Date: Tue, 16 Jul 2024 16:41:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Ian Rogers <irogers@google.com>, llvm@lists.linux.dev
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
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
 <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
 <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
 <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com>
 <CAP-5=fU=LguHNi861L4gmgZWXrrgZtG1w5cdw7hXDxnfWyJyMQ@mail.gmail.com>
 <a17e6701-4195-4132-8518-fe4b10403f7e@arm.com>
 <CAP-5=fVi8RJVokVBQtin8xSAq7uxN=GB7zcC4OiT=SzqWB+V0w@mail.gmail.com>
 <0c20b4b7-c1f6-4c0e-9f89-a99c25555640@arm.com>
 <CAP-5=fVvg=5SE29_SUW0MWmLADL477vpP2DBid2kKZ8kNqxXiA@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fVvg=5SE29_SUW0MWmLADL477vpP2DBid2kKZ8kNqxXiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/2024 4:05 PM, Ian Rogers wrote:

[...]

>>> I'm not sure how we detect
>>> in the build that we're using clang, I suspect there is an approach in
>>> a different kernel Makefile/Build that already tackles this but my
>>> quick searching didn't yield anything - perhaps the change would be
>>> better suited to the location the CROSS_COMPILE prefix is added to
>>> gcc.
>>
>> Should we follow up the steps in the Documentation/kbuild/llvm.rst?
>> The document uses the flag 'LLVM=1' for selecting LLVM/Clang.
> 
> Fix clang-built-linux email to llvm@lists.linux.dev
> 
> I'm not sure as the kernel build and the tools build differ in certain
> ways. Perhaps look at the selftests build to see what they do, as they
> are under tools and share the build files.

Okay. thanks for suggestion.

Leo
