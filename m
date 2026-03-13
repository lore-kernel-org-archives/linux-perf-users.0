Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FC3B8931;
	Fri, 13 Mar 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418060; cv=none; b=dhMdBSaSK8qv2kelqi3+hyHKSFb0Riu6xpx+Omh0HMQJ6a7Rp5WSbdKY2Re/lM48HUSRKU6Lnb51/kcLDnPOrCiOAQF/vxslaIt/GWsHqz/pbjHIqS2rWbP3J81Avc7RxAkfnW+NfLk6dUuKvl7oHNkaQuyciQ8iHDJ+rsrB+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418060; c=relaxed/simple;
	bh=feZUlarptZPrYxvImHDUNpleH6LT/h6P2Am574Gwy78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VknwBD7bmp9VhXfK80iI87nEXnzUWURI3htOZiLmQYapnZPKDZdFFv4n2fqYVtYnm/YnjEEO/jaQE4TS6alRr0QVKsJK8/w3R6UAESwyDsL9AdpUSKiPPJyZ64AGGauscqjvLNTEG/c8NVt8d0uuiE9eSozr30mLj1L57EzMvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxPtlYeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxPtlYeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595E0C19425;
	Fri, 13 Mar 2026 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773418059;
	bh=feZUlarptZPrYxvImHDUNpleH6LT/h6P2Am574Gwy78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YxPtlYeAu4fkddIcE0Pe4G3DZNznWFpSd9tZclLayJmwjl0c12ZPiMAogDbEMdecK
	 S1YmNtxYURFH1Ow1Zr3Owhh15Im1ym4zlSGStsOSimLf9fmJNk03K3OC47iiPI0Tdh
	 1guM8JWZ7+aOJmQjdbUOWrsz5pkJCTrNbha/1mm1254hUEu3L8Dd0c+IkA4HdpfFTZ
	 Kzv4mrSEyKzrT0njYf7vV9YxvpCE1LqLd63B8dSHQHWzmcnAgQvMCTvX0jUDYpIbUm
	 IxDr00empqPAp4cjE7XVwVhbxCxCo8gvyqW93Nx4Hjb5cj/jkoICP7wCk4Um8skQV3
	 UczgN7U2Nphow==
Message-ID: <cdc75030-e750-42ad-a068-55abe3a10d82@kernel.org>
Date: Fri, 13 Mar 2026 16:07:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/30] bpftool: Avoid adding EXTRA_CFLAGS to
 HOST_CFLAGS
To: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>,
 Qinxin Xia <xiaqinxin@huawei.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Kent Gibson <warthog618@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>,
 Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
 <CAP-5=fUOYsnbB4B0khUetRWOFMtHuO6_ESG30b1ZW01n_-gt6g@mail.gmail.com>
 <20260313155600.GP4153946@e132581.arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260313155600.GP4153946@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-03-13 15:56 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> On Thu, Mar 12, 2026 at 10:19:01AM -0700, Ian Rogers wrote:
>> On Wed, Mar 11, 2026 at 1:30 AM Leo Yan <leo.yan@arm.com> wrote:
>>>
>>> Prepare for future changes where EXTRA_CFLAGS may include flags not
>>> applicable to the host compiler.
>>>
>>> Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
>>> CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.
>>>
>>> Acked-by: Quentin Monnet <qmo@kernel.org>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>  tools/bpf/bpftool/Makefile | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>> index 519ea5cb8ab1c0ee31acc67fc5f96b40e21005c2..3e7d8359e1b2a81a29a47544be8539e3b191a0e8 100644
>>> --- a/tools/bpf/bpftool/Makefile
>>> +++ b/tools/bpf/bpftool/Makefile
>>> @@ -81,6 +81,12 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
>>>  ifneq ($(BPFTOOL_VERSION),)
>>>  CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
>>>  endif
>>> +
>>> +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
>>> +# including flags that are not applicable to the host compiler.
>>> +HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
>>> +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>>> +
>>>  ifneq ($(EXTRA_CFLAGS),)
>>>  CFLAGS += $(EXTRA_CFLAGS)
>>>  endif
>>> @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
>>>  LDFLAGS += $(EXTRA_LDFLAGS)
>>>  endif
>>>
>>> -HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
>>> -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>>>  HOST_LDFLAGS := $(LDFLAGS)
>>
>> Should HOST_LDFLAGS be similarly moved? Otherwise, it seems target
>> flags in EXTRA_LDFLAGS will be added for the host.
> 
> Though this series is irrelevant to LDFLAGS, I am fine to move
> HOST_LDFLAGS together.


If we move the HOST_LDFLAGS earlier so that they no longer receive the
EXTRA_LDFLAGS, then we lose the possibility to use any EXTRA variable to
pass additional flags to HOST_LDFLAGS. So OK to move, but maybe add a
"HOST_LDFLAGS += $(HOST_EXTRALDFLAGS)" to it for consistency with the
processing of HOST_CFLAGS?

Quentin
