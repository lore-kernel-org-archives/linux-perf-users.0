Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5C45027;
	Thu, 12 Dec 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998603; cv=none; b=bRSHJSWXpU30gtmGxED4mgA6JC1jVE+7BNEz6gCvIf1cXxIHzkrhZR5VP+KrmkAT0lw3RJU4Ikv0I8iJ8yONXa4ahnupTSqmiEGPhCQnBxJ4BI8PDu4CNtZP3v3+iX7yKl31ElwIXWb3C99epkOHUSOzCvqqIzMWmeNH02l+/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998603; c=relaxed/simple;
	bh=lKnDgtHDup6CgJWh4ENsKoIzhSCtFgX7+1cLUc1h4x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHFqRmolWU1o9EXLBAHh5qPFZIpp4ZrQ7CNvh7q4U5WgxCDhMR3WwWhOEpwgMQ/uZf3mtxfVy5pe0fOch40P3nOKZqdwoE+YZYUkTG0frFiIbokAbFXnUTazHqHxRf+qxqqrdZJDti+faV+EInhDo+GfxizbXFJ9AeJhMJoQGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLYfBNxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLYfBNxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39302C4CECE;
	Thu, 12 Dec 2024 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733998603;
	bh=lKnDgtHDup6CgJWh4ENsKoIzhSCtFgX7+1cLUc1h4x8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VLYfBNxJZ69yN7Bdj+ifHgfe3BAtplB93aa8SbVOQDpIk9w3fspA9hHgHH5TbFNz5
	 0H7J/7VVUK+rAepZK5RkueMpPqZ0Dp+OsbVG9haXu5wtFoLg/TjUByM4suCIiPrDYS
	 mjC76UbF6ZM2x9/0oLLwrW+h/oMWwL8Ya26zbQdtVaNdC+dOFTvY9yDtDETcl0MNrG
	 8Zm4EVYMWhj3M9l7xf997A/QDfyTZg6oHX68ID3vufpV0dJWoX280+9I1tjqhkHKQL
	 +a60MbF3s6BSSWsoKikBpYx/op1AhtfX+he+VHBqIvd1c+SNxovgBkcMxPZ7XsaadP
	 KKLK49tJ/2KHQ==
Message-ID: <c63063b3-b2cc-43af-b026-98c992e9bbf3@kernel.org>
Date: Thu, 12 Dec 2024 10:16:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools build feature: Don't set feature-libcap=1 if
 libcap-devel isn't available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>
References: <20241211224509.797827-1-acme@kernel.org>
 <20241211224509.797827-3-acme@kernel.org>
 <CAP-5=fWqBrw1SuY8ue2X_xOv=yStPANM9NGUBkeo+_s2O=bKTA@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAP-5=fWqBrw1SuY8ue2X_xOv=yStPANM9NGUBkeo+_s2O=bKTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-12-11 20:25 UTC-0800 ~ Ian Rogers <irogers@google.com>
> On Wed, Dec 11, 2024 at 2:45 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> libcap isn't tested in the tools/build/feature/test-all.c fast path
>> feature detection process, so don't set it as available if test-all
>> manages to build.
>>
>> There are other users of this feature detection mechanism, and they
>> explicitely ask for libcap to be tested, so are not affected by this
>> patch, for instance, with this patch in place:
>>
>>   $ make -C tools/bpf/bpftool/ clean
>>   <SNIP>
>>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
>>   ⬢ [acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool/
>>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
>>
>>   Auto-detecting system features:
>>   ...                         clang-bpf-co-re: [ on  ]
>>   ...                                    llvm: [ on  ]
>>   ...                                  libcap: [ on  ]
>>   ...                                  libbfd: [ on  ]
>>   ...                             libelf-zstd: [ on  ]
>>   <SNIP>
>>     LINK    bpftool
>>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
>>   $
>>   $ sudo rpm -e libcap-devel
>>   $ make -C tools/bpf/bpftool/
>>   <SNIP>
>>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
>>
>>   Auto-detecting system features:
>>   ...                         clang-bpf-co-re: [ on  ]
>>   ...                                    llvm: [ on  ]
>>   ...                                  libcap: [ OFF ]
>>   ...                                  libbfd: [ on  ]
>>   ...                             libelf-zstd: [ on  ]
>>
>>   $
>>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: James Clark <james.clark@linaro.org>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Quentin Monnet <qmo@kernel.org>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks Arnaldo for checking the bpftool build :)
Quentin
