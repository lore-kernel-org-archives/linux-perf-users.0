Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6A598C0F;
	Wed,  9 Sep 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989457; cv=none; b=qpLy9gKuVqBCcttLc4XtguzuQo4eTsxVSjpf1LedSpEEdT7QhW6yEcCKw+NoQjU+SbZD1yYc/hid/kLIGNOXSGavlOX5+/9ck3y+ZUduejc6B3NHoFEcPOeu+BSWK/8H02JVGpgceoHF7x5j2DjVKF9aP3Ux30di1lWFHU9k+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989457; c=relaxed/simple;
	bh=UfC6MEvRc16mwfed3YIjKcoOA107yrAQuEpZ/k9Zo3o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tIqYM80dr19F6Vuxq8hkNTrRSTb5jZVSeu9uvqnj4GTf/WdY4fAfVnv95z+85DfL5/u9oWjivBNoitgrEJF2GzzWMcD3gTLfVr/ikJnmK24C4eljRmos6Q/QFNh/5vVde/MtRLurDVWe7u3jsanXTBZR53yByghGJnnG667oNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWV+IN14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWV+IN14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C31D1F000FF;
	Wed,  9 Sep 2026 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989442;
	bh=77yrapoG5qaYhSIgOM5ohmmEJHRfZ59JcREcil7ZLms=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kWV+IN14TGztOJhMiFGPTOjUT2oqFIuAbKCVAQMqqgAF7jY6yL8k9dLQSo/WS7XEU
	 qjiBHzFDVJEL4S93fZmdLr3XPjOEoIWGzG/rQX8JHmE6Y+9w0HVR32eVOxr6UH3++w
	 ae+W/c4rGNse6v2q8wRHo3bgRpRtJrWi9BZTHx61yK1tpQ6kX+pYS9j/0DIWo/SsyA
	 8tm6158t+DgHzhhDQ/49hyNbW3WHb2vPmJgZGtHvn1yTIJOdNUTpg2b4l7FecLj+K7
	 UvCsv+9U4TtqAab2E2yPLpRskZCW86OhDp2wuGoY4AEfqC5yAL27gsHbWSLULh+kH3
	 84HT2UyaUKy6A==
Content-Type: multipart/mixed; boundary="===============3615248356960929090=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <823e2efca0056494a3baf703f2d29991a1c7d1500f931684a8086c87394f18ae@mail.kernel.org>
In-Reply-To: <20260909204122.1993010-5-irogers@google.com>
References: <20260909204122.1993010-5-irogers@google.com>
Subject: Re: [PATCH v2 4/4] objtool: Add explicitly sequenced -lzstd to libopcodes fallback
From: bot+bpf-ci@kernel.org
To: irogers@google.com,qmo@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,jpoimboe@kernel.org,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,terrelln@fb.com,dsterba@suse.com,tglozar@redhat.com,costa.shul@redhat.com,mjeanson@efficios.com,9erthalion6@gmail.com,leo.yan@arm.com,linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 21:30:40 +0000 (UTC)

--===============3615248356960929090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 1f030996083bc0f6f03bca8dc04fe12feb66957d
> Author: Ian Rogers <irogers@google.com>
> Date:   Wed Sep 9 13:41:22 2026 -0700
>
>     objtool: Add explicitly sequenced -lzstd to libopcodes fallback
>
>     Distributions like Fedora currently ship a statically compiled binutils
>     libbfd (an intrinsic dependency of libopcodes) that internally utilizes
>     zstd to decompress sections.
>
>     Because objtool resolves host dependencies sequentially via a manual HOSTCC
>     shell loop, build failures will occur (e.g. undefined reference to
>     'ZSTD_decompress') unless the loop probes for it.
>
>     Add the '-lopcodes -lbfd -liberty -lz -lzstd' combination to the fallback
>     chain, assuring successful compilation on hosts packaging static binutils.

This isn't a bug, but could the changelog say the new candidate mirrors the
existing -lz fallback (and note it is untested, as the cover letter does)
rather than stating it assures a successful build?

>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Assisted-by: Antigravity:gemini-3.1-pro
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index a4484fd22a96..141b957c566b 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -88,7 +88,8 @@ LIBOPCODES_LIBS := $(shell \
>  	for libs in "-lopcodes" \
>  		    "-lopcodes -lbfd" \
>  		    "-lopcodes -lbfd -liberty" \
> -		    "-lopcodes -lbfd -liberty -lz"; do \
> +		    "-lopcodes -lbfd -liberty -lz" \
> +		    "-lopcodes -lbfd -liberty -lz -lzstd"; do \
>  		echo 'extern void disassemble_init_for_target(void *);' \
>  		     'int main(void) { disassemble_init_for_target(0); return 0; }' | \
>  			$(HOSTCC) -xc - -o /dev/null $$libs 2>/dev/null && \

This isn't a bug, but should the comment above the loop also mention libzstd,
so the documented dependency list still matches the candidates below it? The
comment currently says "libbfd, libiberty, and sometimes libz" but the new
candidate includes libzstd as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34404437407
--===============3615248356960929090==--
