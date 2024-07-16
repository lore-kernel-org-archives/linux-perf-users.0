Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4919AD85;
	Tue, 16 Jul 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137793; cv=none; b=ktuddwUglplZbmmYnWA/S6ZcY4tXLpn6WDm7LQa3dp+1/aarmFt2915J4+MkoujVZCCzNoxuCNrdg6Nsv/HYGB0/bJsDQteMojtHlv3J9MbFmKhuFP15AQA/gWhIOpwAYJ/l+WD/Oe4kvtykhjYtw/myGwfokaLk40OvpyQWYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137793; c=relaxed/simple;
	bh=hjq+HrXaifh2bOJJKxUdxktVT46Dj0YJp3PF85VTb/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5kDgqbKMV8tW5PMV1hrXM9FVCQqpUE88W9BDqXtuKDuByK05AP43o04VfBQdgATncONLNntpSlP6b5Y8sShjlPxqLYQhb+qUwpYKp1GNcmz28VqqfZGFgXJeG1HlcGSkjY7chMC1ktuexPKy3IcM6EDih6Dfa2e+OzC8hRqiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1611063;
	Tue, 16 Jul 2024 06:50:16 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72AC73F762;
	Tue, 16 Jul 2024 06:49:49 -0700 (PDT)
Message-ID: <0c20b4b7-c1f6-4c0e-9f89-a99c25555640@arm.com>
Date: Tue, 16 Jul 2024 14:49:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Ian Rogers <irogers@google.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>
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
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fVi8RJVokVBQtin8xSAq7uxN=GB7zcC4OiT=SzqWB+V0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/16/24 14:30, Ian Rogers wrote:
> On Tue, Jul 16, 2024 at 3:06 AM Leo Yan <leo.yan@arm.com> wrote:

[...]

>> Thanks for correcting. Now I even can build successfully with the Clang
>> from Android NDK with an additional flag 'NO_DEMANGLE=1'. Though we still
>> need to disable several modules for passing the building, but we are on the
>> right way.
>>
>> Would you like to continue a formal fixing or you want me to follow up?
> 
> +clang-built-linux
> 
> If you could follow up it would be great!

Okay, I will look into it.

> I'm not sure how we detect
> in the build that we're using clang, I suspect there is an approach in
> a different kernel Makefile/Build that already tackles this but my
> quick searching didn't yield anything - perhaps the change would be
> better suited to the location the CROSS_COMPILE prefix is added to
> gcc.

Should we follow up the steps in the Documentation/kbuild/llvm.rst?
The document uses the flag 'LLVM=1' for selecting LLVM/Clang.

Thanks,
Leo

> The only thing the change to Makefile.config is doing is
> injecting the --target option. I'm not sure anything more is not
> working for me on my laptop with this approach compared to cross
> compiling with gcc, but as you say going in the right direction is
> worth it anyway.
> 
> Thanks,
> Ian
