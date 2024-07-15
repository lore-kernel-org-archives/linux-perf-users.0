Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61B139CF7;
	Mon, 15 Jul 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074248; cv=none; b=cDY5rCrj7zCnJnaKUhvNF3F9xsmDfY+61mVIK7Re9jW6qc4LxcwIhmo0zYwVsSO4YxbTcWxSrJHpBy1s27f6Mf373Cs4tGMPinTIHF6XqG55wxija1UGR/JixKQ53ewKqATPHWedPOYqKg/7tsbooufnfpojcRI7rZKcHSrcAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074248; c=relaxed/simple;
	bh=J2tGqQwGsrUqg37HTVQt+Pq4ADkfEKo5+MKC+tWIGTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDO75knNH4WIoQy+9CQJMW2SUhu1FiVNTA/ygUN9T02iESU6kj0EBlj/TsivFn4lwHvtChW4PQnAbewmz1jgkweQOAFSIGuFoaNGRPQFRkIZZuTMq07BkSgPLcQFW73qxFhfRx08xCABbwOdP7IVHGK8SVV7DvR39KWaqFQXqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E67A2FEC;
	Mon, 15 Jul 2024 13:11:10 -0700 (PDT)
Received: from [10.57.10.251] (unknown [10.57.10.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764173F73F;
	Mon, 15 Jul 2024 13:10:43 -0700 (PDT)
Message-ID: <8aca17e0-23fe-4b5c-9209-ff8ef1463314@arm.com>
Date: Mon, 15 Jul 2024 21:10:35 +0100
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
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
 <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/2024 8:44 PM, Ian Rogers wrote:

[...]

> So we're cross-compiling in bazel, so it is a different set up than
> the makefiles - I'm happy to work to share the bazel set up if other
> people care. I'm having a play to see if I can get the Makefile
> working, my first attempts are clearly mixing x86 code into the
> supposedly arm64 build, which would appear to be more of a build
> system rather than code problem.

Thanks!

I don't have knowledge for Bazel build system, but it surprised me a bit that
the build system doesn't use the makefiles in Perf.

I think it is the right way to fix makefiles in Perf for cross building with
LLVM/Clang. I would like hold on the Android document updating - once the
building is fixed, we will have better knowledge for building perf on Android.

Thanks,
Leo
