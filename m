Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90A3C553D;
	Wed, 11 Mar 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219735; cv=none; b=oS9BeJNexqDbg8kHl6ndElqmGgi8P5wu+bNPLdrwhAmtGkAlFymY15n/pWV1y+ju8z8mofglGBeqrQimwXkOd1qc+s4w/7X4weF2CVBbLjRREuUVylC/LIkxSm3ajL0cdO9NLpLVLGFUNB5vhGqINhPAiscwIDoNzDmME8b4A70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219735; c=relaxed/simple;
	bh=TgPeQ4e/omI8XDsH8vHgKd+kHDz1IvHHcdNPYPwy95g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O4skeglgs8HVWBswtY8fKQnTkILHtmWOfpIJN4D7mKUarxMGmQaL6MdkOZB1ubVcQh3xFDW/sImER7nMTA3hF04ZtDHpHn5ob+C6veBTV+8BPX+SNfE1g6V66W2+DtgBcDIp7oNy8Dor1rAk403G9URjqhIcILiG07oK7u8bMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4gegN5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4gegN5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96D3C4CEF7;
	Wed, 11 Mar 2026 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773219734;
	bh=TgPeQ4e/omI8XDsH8vHgKd+kHDz1IvHHcdNPYPwy95g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G4gegN5LQ2I68ICOzOISh+4ibgqG8lj5224Zb2OzEs/KbBhB7mpnHNws78YD38V1K
	 q+PcqzYkOZ4umMp0ZzJ6zo4dDKmyIcIPLX8KqkgZ8550cfre7iRERiO0cAVX4TZ8CV
	 ZatRcS/QWsW0cws7G4vNYVtt2bRhvxGoX2coi03wwHlNankByUWRGZiPIicqegc5ql
	 rEthHABws8QE6pXSJbpl1cL2jPmhIKSVh8To/GEvvYnzk7ciwoOEK10TfnB+PFSeKH
	 T87tKINU/NeD7j69DaTTx5lyntnEu5pXpNWC71o9NlWjVFPyF3Xn8CvrBu5fnHp4a5
	 M6ph8Y7OvUFgA==
Content-Type: multipart/mixed; boundary="===============6467356410034622491=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00482d80980f713b27b422ec1ea2d17d0f1daed19243b597c5954e470cc09c92@mail.kernel.org>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-6-9e35bdb99cb3@arm.com>
References: <20260311-tools_build_fix_zero_init-v4-6-9e35bdb99cb3@arm.com>
Subject: Re: [PATCH v4 06/30] libbpf: Remove duplicate $(CLANG_CROSS_FLAGS)
From: bot+bpf-ci@kernel.org
To: leo.yan@arm.com,acme@kernel.org,irogers@google.com,namhyung@kernel.org,james.clark@linaro.org,kees@kernel.org,qmo@kernel.org,nathan@kernel.org,nsc@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,rafael@kernel.org,daniel.lezcano@kernel.org,rui.zhang@intel.com,lukasz.luba@arm.com,peterz@infradead.org,mingo@redhat.com,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,adrian.hunter@intel.com,mhiramat@kernel.org,wbg@kernel.org,baohua@kernel.org,xiaqinxin@huawei.com,brgl@kernel.org,warthog618@gmail.com,kys@microsoft.com,haiyangz@microsoft.com,wei.liu@kernel.org,decui@microsoft.com,longli@microsoft.com,jic23@kernel.org,dlechner@baylibre.com,nuno.sa@analog.com,andy@kernel.org,akpm@linux-foundation.org,w@1wt.eu,linux@weissschuh.net,jpoimboe@kernel.org,robert.moore@intel.com,lenb@kernel.org,srinivas.pandruvada@linux.intel.com,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,broonie@kernel.org,rostedt@goodmis.org,gmonaco@redhat.com,shuah@kernel.org,jikos@kernel.org,bentiss@kernel.org
Cc: linux-kbuild@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,bpf@vger.kernel.org,linux-perf-users@vger.kernel.org,leo.yan@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 09:02:13 +0000 (UTC)

--===============6467356410034622491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 168140f8e646..b1fbd0211c5e 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -84,7 +84,6 @@ override CFLAGS += -Werror -Wall
>  override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
> -override CFLAGS += $(CLANG_CROSS_FLAGS)

At this commit, doesn't this removal lose CLANG_CROSS_FLAGS entirely
from the libbpf build?

The libbpf Makefile includes Makefile.include at the top, which does
append CLANG_CROSS_FLAGS to CFLAGS. But then the libbpf Makefile
overwrites CFLAGS with :=

    CFLAGS := -g -O2

which destroys everything Makefile.include appended. The removed line
above was the only thing that re-added the cross-compile flags after
that overwrite.

The next commit in the series (233d70853154 "libbpf: Initialize CFLAGS
before including Makefile.include") fixes this by moving the CFLAGS
initialization before the include, so Makefile.include's addition
survives. But at this commit, cross-compilation with Clang appears
broken.

Could these two patches be squashed or reordered so that the
initialization move comes first?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22943905432
--===============6467356410034622491==--
