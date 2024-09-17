Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE004A29;
	Tue, 17 Sep 2024 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610528; cv=none; b=YOAXhPHLFnS6AekkzzgUy1LCeimAnk7xOLyUKM0eidth5aTk/NMPnUarEd4ywseEsRBmVp+FZ2PCm3ZOsUjSLkzIsEmqPWY8C8o3bTSRQB9TvxyKuxruHRPzLTtraFT4YgaL8gdODS7umaXPAO9UtvYBmD2I5sTxy9BnrfzaA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610528; c=relaxed/simple;
	bh=do4qyqz/PtdWBnG3IGcs3YsE0L6uWW7WkOckvCuvZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+ImvZV3GsRlL9bSIN5bQ1wW6PDAe1tg+2N/pLQ9rm/1c//YqH1GHbIx7RYfBBR+gAovzaZIvXvN2tbPjRSkriCsEdY//6+P2qQn8BpHJM8lrRfEqiUL3NIxcIuJ0Z6GdKWPTZ/gJ4DiPE/R5Q1JC215g1ZKrQ3qEB+njpCyEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drmccPS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drmccPS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12241C4CEC5;
	Tue, 17 Sep 2024 22:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726610528;
	bh=do4qyqz/PtdWBnG3IGcs3YsE0L6uWW7WkOckvCuvZxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drmccPS6Gkbz33PpbK/I5ByXrQxAavkgzRa4l8ErAm4roRYHuFONOiZTLSazslxIN
	 KT4gY93gXJGFbKnymFAnWio3CvAGhnicoL1bmuznmSYA5chv1+xJRMzhkALtJ1kp6A
	 NpFI0xsLN/To3eZeCBfqUj9uuCtp84Z81KRBdZ1rVrrueBpLfBoR0KipwKETH8aj/C
	 Ww4VJ1VxRPHE8WkCO+itqpQMt2uZ1iSe2KwIu3mVxSBia/xQSM4jegPL7hcCSc1pZL
	 8OdCiU5LZIYvOhu5hJKolnwAS3VyfNSkdhOdeHBfmlR1L2WY4lrp9HwDOlGQVvuqI2
	 NXTEJaf/diiVw==
Date: Tue, 17 Sep 2024 15:01:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 05/11] perf/x86: Use user_unwind interface
Message-ID: <Zun8VdrLmWwPsVnu@google.com>
References: <daf3f59e0d14ee11b45ad6735b8a211a3c7534dc.1726268190.git.jpoimboe@kernel.org>
 <202409161428.3cc6c1e1-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202409161428.3cc6c1e1-oliver.sang@intel.com>

Hello,

On Mon, Sep 16, 2024 at 02:48:35PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_kernel/unwind/user.c" on:
> 
> commit: 164c5ae4072303c9eb4e263115a5e70d5a3cc052 ("[PATCH v2 05/11] perf/x86: Use user_unwind interface")
> url: https://github.com/intel-lab-lkp/linux/commits/Josh-Poimboeuf/unwind-Introduce-generic-user-space-unwinding-interface/20240914-070619
> base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
> patch link: https://lore.kernel.org/all/daf3f59e0d14ee11b45ad6735b8a211a3c7534dc.1726268190.git.jpoimboe@kernel.org/
> patch subject: [PATCH v2 05/11] perf/x86: Use user_unwind interface
> 
> in testcase: fsmark
> version: fsmark-x86_64-2628be5-1_20240224
> with following parameters:
> 
> 	iterations: 1x
> 	nr_threads: 64t
> 	disk: 1BRD_48G
> 	fs: xfs
> 	filesize: 4M
> 	test_size: 24G
> 	sync_method: NoSync
> 	cpufreq_governor: performance
> 
> 
> 
> compiler: gcc-12
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409161428.3cc6c1e1-oliver.sang@intel.com
> 
> 
> [   53.036370][    C3] ------------[ cut here ]------------
> [   53.036374][    C3] kernel BUG at kernel/unwind/user.c:39!

I also noticed this and the following patch would fix it.

Thanks,
Namhyung


diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 3a7b14cf522b4139..3c8f1deb6d34ec37 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -80,8 +80,10 @@ int user_unwind_start(struct user_unwind_state *state,
 	case USER_UNWIND_TYPE_SFRAME:
 		if (!sframe_possible)
 			return -EINVAL;
+		state->type = type;
 		break;
 	case USER_UNWIND_TYPE_FP:
+		state->type = type;
 		break;
 	default:
 		return -EINVAL;
