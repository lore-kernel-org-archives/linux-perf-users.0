Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE83074AE;
	Mon,  9 Mar 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078719; cv=none; b=s0OGekl1Zw9o1tdgf7IzsfqnAbkE9ec49WmEvXASucjUT9ErB33Te7rPoMVew8mnGez2OEzW0K+OVZ15ViLZ9EPtvSP1YvfdtBlJRJvgsvgIbu+GRcpYcHrDDAoXzUqzGZrbgAVBirZ4APDIgXoomSIKo9vXKTOb1wJFHLQcMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078719; c=relaxed/simple;
	bh=Vvvd3Xz6K1enwmOhCrCFbQLzR0Pk4XlMswFXf0leHIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmHQGrZLj1xIpJWHUAxug0eql32WI8pUYxWwYoXnhW8N5alPrk7XxHUGjVwLfFaqhil15IyCG1PRnKfUQAATRaOiMyixZnblJ/Gy35Q+jV6rdTx5tDbffbOgyUdxklJBLdHFdKB8i1num9FeAKYdyWeK/+EXwQ5dsBSAm74CtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxhGXLtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxhGXLtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED250C4CEF7;
	Mon,  9 Mar 2026 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078718;
	bh=Vvvd3Xz6K1enwmOhCrCFbQLzR0Pk4XlMswFXf0leHIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SxhGXLtwLmIPPU8/unVXnxTa8uEVOrR7zulXA+QvYY5EHfeMBdmHOf2GFkzNC6dxO
	 r9rRKuFVHTRBd4WIjgc49hVC0+LWz40MXnsjo6YXpo8HBlQ6xDJA2nvbgMwtwPqF0s
	 sMC+WW3tmbCMBtprRVCtcxgV4h6qBDXOrTLO+2tDNu2b1+f5pBgA/NpiBorBpI4uJw
	 UeZH4lBFjzw/ggs2UzgHm79c461ShMkscuIRGIE2U1dWdJmLCcaiCVM6q06t2ydJPq
	 n5CUd6w07VCGM3IoLtyrVYG3YiLKJ2iID3tX3o3n5AactTFxyrveF/A02ZeXiDHTQg
	 N6L4fadBlIN4Q==
Message-ID: <90efa38a-8ff1-4a3f-8ed4-08985df383a4@kernel.org>
Date: Mon, 9 Mar 2026 17:51:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/30] bpftool: Avoid adding EXTRA_CFLAGS to
 HOST_CFLAGS
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>
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
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-1-6477808123b7@arm.com>
 <CAP-5=fUaowg5c5GRVrTATCbkFrRa8WUyp3_h3O_6t2Vy4rBsmQ@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAP-5=fUaowg5c5GRVrTATCbkFrRa8WUyp3_h3O_6t2Vy4rBsmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-03-09 10:40 UTC-0700 ~ Ian Rogers <irogers@google.com>
> On Sun, Mar 8, 2026 at 9:46 AM Leo Yan <leo.yan@arm.com> wrote:
>>
>> Prepare for future changes where EXTRA_CFLAGS may include flags not
>> applicable to the host compiler.
>>
>> Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
>> CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  tools/bpf/bpftool/Makefile | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 519ea5cb8ab1c0ee31acc67fc5f96b40e21005c2..3e7d8359e1b2a81a29a47544be8539e3b191a0e8 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -81,6 +81,12 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
>>  ifneq ($(BPFTOOL_VERSION),)
>>  CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
>>  endif
>> +
>> +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
>> +# including flags that are not applicable to the host compiler.
>> +HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
>> +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>> +
>>  ifneq ($(EXTRA_CFLAGS),)
>>  CFLAGS += $(EXTRA_CFLAGS)
>>  endif
>> @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
>>  LDFLAGS += $(EXTRA_LDFLAGS)
>>  endif
>>
>> -HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
>> -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>>  HOST_LDFLAGS := $(LDFLAGS)
> 
> This isn't an issue with the patch but AI code review is noting that
> "LDFLAGS += $(EXTRA_LDFLAGS)" happens above, and then here,
> "HOST_LDFLAGS := $(LDFLAGS)". This means something like
> EXTRA_LDFLAGS="--sysroot=/my/target" in the build would cause the host
> ld to pick up the --sysroot flag and probably break host builds which
> likely use the host `bpftool` when cross-compiling (perf's build
> should use the host `bpftool`). If the HOST_LDFLAGS were set to
> LDFLAGS before EXTRA_LDFLAGS are appended, this would not be an issue.


I noticed it when reviewing, but if the HOST_LDFLAGS were set before
EXTRA_LDFLAGS, we wouldn't be able to pass additional HOST_LDFLAGS via
any "EXTRA_..." variable, which would look inconsistent with how
bpftool's Makefile handles the HOST_CFLAGS. I suppose the right fix
would be to move HOST_LDFLAGS before EXTRA_LDFLAGS as you (and the AI)
suggest, but also to add a HOST_EXTRALDFLAGS to it? Although I've not
heard of any use case for passing different ld flags when
cross-compiling bpftool, yet.

Quentin
