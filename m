Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95630388E62;
	Fri, 15 May 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874495; cv=none; b=YWAy+zDsAE3w+rZFphPSVZ4MLVOjpsynfgLa5ptfz4wYkVNt11r4NhF/HBKneQxSrI03Im0SzW4USvOt14g4UYui8zT78T+fCgPkrMpULtB9pQIZwJYi76cyz6DRhLrSczjbnC04lsvmnnV9WqA1b527tuNUUe02zn5UA37huuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874495; c=relaxed/simple;
	bh=2IEyOw6Z8HJDTQVQ25UoBE85/dz6zn8voxPel+zo1l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFSdozXilS+2Ku/qUMhikV8jFfutDQz75aFTBkhU9ImvPIzCSi7/onRWfG2zxaaGVpIbIHP1a+AbI9N7g1B254cIGp8nE6X5hkuPlzk93IgzHqVwCHclHNLeUX6INaIITbkbfJ6gk8IqolYlHfxOxCK9PFeRY8z75A9pF3Iuub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PomqFIK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PomqFIK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8038BC4AF09;
	Fri, 15 May 2026 19:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874492;
	bh=2IEyOw6Z8HJDTQVQ25UoBE85/dz6zn8voxPel+zo1l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PomqFIK1bhI4K3qLhPE97EcIH0XGqk/HKaoduQUAY4JdvtJUv0x9EWF38d+sCywu7
	 N8KGTe+YYo9aFrouqdUmHyKh5XOV2ktJZ43Bhj6SaJ704HwxzlULdzqlelCX6kiMMd
	 vD72CZAgFuf+Ic5zAi/HpQT8R20B8Y3rUn7rbPXp8UPaMd+D2vbvgWSYvy3gjsG1Sp
	 fxFyb/ZMvLCk9j2F5YZZrPi+KV+EvQaYoe8RaZluMpMX6i869PQZiF9Mhm3XiSrL8P
	 wsfWPo88YTUOPl+p4P639jniztvT80BMmF6RWrBIOWaRxpZgkrD8QmHP89GozFCWpV
	 5HdROghXGDEbg==
Date: Fri, 15 May 2026 12:48:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, alex@ghiti.fr,
	alexandre.chartre@oracle.com, andrii@kernel.org,
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu,
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com,
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com,
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org,
	leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com,
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me,
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com,
	tglozar@redhat.com, thomas.falcon@intel.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v4 12/14] perf build: Prefix SCRIPTS with output
 directory to fix continuous rebuilds
Message-ID: <agd4ehtRHi1VbvQ7@google.com>
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
 <20260515173852.1378571-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515173852.1378571-13-irogers@google.com>

On Fri, May 15, 2026 at 10:38:49AM -0700, Ian Rogers wrote:
> In Makefile.perf, ALL_PROGRAMS includes SCRIPTS (perf-archive,
> perf-iostat). However, unlike PROGRAMS and DLFILTERS, SCRIPTS was not
> prefixed with $(OUTPUT).

Looks like a bug.

Thanks,
Namhyung

> 
> During out-of-tree builds (or when O= is specified), Make checked for the
> unprefixed target 'tools/perf/perf-archive'. Since the actual script was
> installed into $(OUTPUT)perf-archive, Make concluded the target was
> missing and continuously re-executed the script installation rule on every
> single incremental build.
> 
> Prefix SCRIPTS with $(OUTPUT) and update the static pattern rule to ensure
> Kbuild correctly tracks generated script prerequisites during incremental
> builds.
> 
> Tested-by: James Clark <james.clark@linaro.org>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b8a81c9749a8..fc92d6ceac5b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -405,7 +405,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
>  # Use the detected configuration
>  -include $(OUTPUT).config-detected
>  
> -SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
> +SCRIPTS = $(addprefix $(OUTPUT),$(patsubst %.sh,%,$(SCRIPT_SH)))
>  
>  PROGRAMS += $(OUTPUT)perf
>  
> @@ -592,8 +592,8 @@ $(GTK_IN): FORCE prepare
>  $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
>  	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
>  
> -$(SCRIPTS) : % : %.sh
> -	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
> +$(SCRIPTS) : $(OUTPUT)% : %.sh
> +	$(QUIET_GEN)$(INSTALL) '$<' '$@'
>  
>  $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
>  	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
