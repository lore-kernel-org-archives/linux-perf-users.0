Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D318C16B;
	Mon, 15 Jul 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054895; cv=none; b=nc3ByLsam2Wp8UQU5gE969fgDUhogcN6kQ0TS480rlcJcNKhsL3AUhnE9fYBPGDnQ2Kqo791ifXtmOuuOZUM7tDkoHtZojALltlY6Sp8wJ4jcwM22fygGPVRjn0/p3aj6YeibXitVpKGJtwZTc7lwQeASl1Q/73KGItOinyX2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054895; c=relaxed/simple;
	bh=U1aBvv3wr6glJU3qobi5YsfFu1yk3nu2bFhvuMZ6aU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpZdZrk1RbpbSrXcBiVCOXR1MmN9GJbB/8EUvAScmofIKzKR9C82F9TkMetba4YA32ZPOA79o65kYWnDqqdJ3YPmbiwoHPwDBXlVfhjp0CsbZFJvqRLa0l5SzUb2pEz5TmNNDOTpJs4777JjNgx+/0BB4BtaCe3281btJ2NkWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 936EAFEC;
	Mon, 15 Jul 2024 07:48:38 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2AB33F766;
	Mon, 15 Jul 2024 07:48:10 -0700 (PDT)
Message-ID: <b58e3d55-5fa2-451a-8196-b5a031805946@arm.com>
Date: Mon, 15 Jul 2024 15:48:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building
 document
To: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Changbin Du
 <changbin.du@huawei.com>, amadio@gentoo.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-8-leo.yan@arm.com> <ZpC3-p0kG7dGkp_5@google.com>
 <3b16778b-f825-42a2-b53d-17c9b8c22a52@arm.com>
 <83301e3e-e049-4af4-9f0b-29bdfc201543@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <83301e3e-e049-4af4-9f0b-29bdfc201543@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/12/24 14:38, James Clark wrote:

[...]

>> Given the test result, my conclusion is the doc for Android cross building
>> is not useful for a long while. If we really want to support it, I would
>> like to suggest to take a separate task for fixing LLVM / Clang cross
>> compilation.
> 
> We could replace the entire contents of the file with something like
> "Android NDK compilation deprecated -- no longer supported". It might
> help someone in being able to recover the history of the file by leaving
> in some keywords. If you delete it it becomes very unlikely that the
> history will be found by someone trying to get it working again.

A specific Android version has corresponding Linux kernels. It is likely
developers can find what they want, as they should work on an relative
old kernel source tree.

Given Namhyung and you both are concerned for removing the doc, I have
followed the suggestion, respined this patch and sent sepearately [1],
as this patch is not really related to cross building fix.

Thanks,
Leo

[1] 
https://lore.kernel.org/linux-perf-users/20240715143342.52236-1-leo.yan@arm.com/T/#u
