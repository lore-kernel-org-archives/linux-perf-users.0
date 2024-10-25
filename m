Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2720D4F4;
	Fri, 25 Oct 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877625; cv=none; b=g0yiTu0IYF3dds2M1Wd2yEQuJL3MnZEu+PN7D/u9ERYEgVMfKCmnXXhvGrSvCrj7CsYUlX00YZ527bMrZRrW3iEoJsxux2GCnj60fvpwUShY77kShQQNYz0vEAaPzkq0E1UnATZoztVgPwbQGcYNwVuk4Kg8R0F06BvH4z0gDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877625; c=relaxed/simple;
	bh=HyF/YCizGPVdnb5e2YDOf1fLAIz4O0Pgn8cJi8jL3i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncjPU5kEtWWi5zhPDUSUFvTJiBfAfaWL1N6Do40B4XrfJfIvWqznBeWefUBNxMmP/s32TH1rsxYQlhS3LumjNW9FG8ZCuGBpOd1v9W7TzTRXNNPd8LmDotBsIKS5rMntZkKkGyCYunFlCLCYzJeTUhqCCrMYkCg8yyYbqzm9ya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C51C339;
	Fri, 25 Oct 2024 10:34:09 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E83D03F71E;
	Fri, 25 Oct 2024 10:33:38 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:33:30 +0100
From: Leo Yan <leo.yan@arm.com>
To: Graham Woodward <graham.woodward@arm.com>
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	jolsa@kernel.org, irogers@google.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Message-ID: <20241025173330.GD359792@e132581.arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>

On Fri, Oct 25, 2024 at 03:30:05PM +0100, Graham Woodward wrote:
> 
> Currently the --itrace=b will only show branch-misses but this change
> allows perf to synthesize branches as well.
> 
> The change also incorporates the ability to display the target
> addresses when specifying the addr field if the instruction is a branch.

Tested for this series:

  # perf record -e arm_spe_0/branch_filter=1,load_filter=1/u \
      -- ./false_sharing.exe 1

  # perf script --itrace=i10ib  -F,+addr,+flags
    false_sharing.e  880532 [005] 1852579.389533:          1                                    branch:   jmp                       ffff91beb224     ffff91beb220 __GI___tunables_init+0x40 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389538:          1                                    branch:   jmp                       ffff91bec318     ffff91bec314 _dl_next_ld_env_entry+0x24 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389620:          1                                    branch:   jmp                       ffff91be0f14     ffff91be0f10 _dl_new_object+0x168 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389802:          1                                    branch:   jmp                       ffff91be2cf0     ffff91be2cec _dl_map_object_deps+0x3f4 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389802:         10                              instructions:   jmp                       ffff91be2cf0     ffff91be2cec _dl_map_object_deps+0x3f4 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389824:          1                                    branch:   br miss                   ffff91bee4e4     ffff91bee4e0 strcmp+0xa0 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389849:          1                                    branch:   jmp                       ffff91be1868     ffff91be1880 _dl_relocate_object+0x4a8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389858:          1                                    branch:   jmp                       ffff91be1868     ffff91be1880 _dl_relocate_object+0x4a8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389861:          1                                    branch:   jmp                       ffff91be1c20     ffff91be1bcc _dl_relocate_object+0x7f4 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389875:         10                              instructions:                                        0     ffff91bdfe38 _dl_lookup_symbol_x+0x58 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389876:          1                                    branch:   jmp                       ffff91bdf3a8     ffff91bdf434 do_lookup_x+0x114 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389879:          1                                    branch:   jmp                       ffff91be18ec     ffff91be18e8 _dl_relocate_object+0x510 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389886:          1                                    branch:   jmp                       ffff91bee440     ffff91bdf2dc check_match+0x154 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389890:          1                                    branch:   jmp                       ffff91bdfed4     ffff91bdfed0 _dl_lookup_symbol_x+0xf0 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389893:         10                              instructions:                                        0     ffff91be1974 _dl_relocate_object+0x59c (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389894:          1                                    branch:   jmp                       ffff91bdf3f4     ffff91bdf3f0 do_lookup_x+0xd0 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
    false_sharing.e  880532 [005] 1852579.389906:          1                                    branch:   jmp                       ffff91bdfea4     ffff91bdfe90 _dl_lookup_symbol_x+0xb0 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)

  # perf test "Check Arm SPE"
  114: Check Arm SPE trace data recording and synthesized samples      : Ok
  115: Check Arm SPE doesn't hang when there are forks                 : Ok

Tested-by: Leo Yan <leo.yan@arm.com>
