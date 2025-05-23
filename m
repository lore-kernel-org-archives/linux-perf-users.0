Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735052F24;
	Fri, 23 May 2025 01:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965464; cv=none; b=lY6CEDlpuIcJhwFo8NgzlrPvA/9/sRHaQhR/OUQFTgRN+4H8HypFZyL/6+COzBkuxOz9cCzJHKqiKmjXBpTw3KN99ZPGaj/vQA/g7rzlDhZOwsrO6wCBnBQW9Ufo9Nre2nPPPJLE7Qcg+3bIyvTbzY4DuhlodBq6tCmA+Lx+Sfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965464; c=relaxed/simple;
	bh=0EIX5Ihdog051yQjS6Y5Ob1scxl4e5ORYOE0J6bNv1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6EqXx3x7vAoaei0IQilyjFCCEPAA3QZAIn4cVdkxr/p6VCxT8ssSzo/GwUFdE9kc+gVvnax7Ca0ngHQtyXzWkElkuIHGxt+O0sCDuiCnVNZsgccewJPE+WvjL52GfolIs5wIkfHj6Jmwu3rVR/ovuV53XJlyOxzDweYGyu61Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjslkHMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjslkHMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C079C4CEE4;
	Fri, 23 May 2025 01:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747965463;
	bh=0EIX5Ihdog051yQjS6Y5Ob1scxl4e5ORYOE0J6bNv1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjslkHMK3MnsAcO453nUOfUeDe/Z3UoTCOjluiFvLwpzgRQGJ35OaA7BiQyzN8bz5
	 Xts9PNSDEkLVNv/fjCzIo59TAaOp824RiYQpYNjBigm4cjZEfJUQwZMhDYlwsFw5U1
	 0wXJgfXTcE63qAVlrDSGtE9dbUmNkrM8XiDiQjTe+FSHBxYJOWN1f4FuT9g5RhYJk2
	 PdM0/g9DpF2hOVPYCh8u58djTsRn4vzW6VAB3oKX28dAKLxmuiCxhQ5JMdA5392UeX
	 Hi2XyIIzeyJkVagaAZmyD/dYy+8EZTfp4H2o34XrR+ggGRnBYP+HT0rxerRtkdSZuF
	 H8ljno/33jaXw==
Date: Thu, 22 May 2025 22:57:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aC_WFRe_4HjVPUrM@x1>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <aC_Vn95vYqcXul03@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC_Vn95vYqcXul03@x1>

On Thu, May 22, 2025 at 10:55:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Mar 31, 2025 at 06:27:59PM +0100, Leo Yan wrote:
> > The test might fail on the Arm64 platform with the error:
> > 
> >   perf test -vvv "Track with sched_switch"
> >   Missing sched_switch events
> > 
> > The issue is caused by incorrect handling of timestamp comparisons. The
> > comparison result, a signed 64-bit value, was being directly cast to an
> > int, leading to incorrect sorting for sched events.
> > 
> > Fix this by explicitly returning 0, 1, or -1 based on whether the result
> > is zero, positive, or negative.
> > 
> > Fixes: d44bc5582972 ("perf tests: Add a test for tracking with sched_switch")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> How can I reproduce this?
> 
> Testing on a rpi5, 64-bit debian, this test passes:
> 
> root@raspberrypi:~# uname -a
> Linux raspberrypi 6.12.25+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.25-1+rpt1 (2025-04-30) aarch64 GNU/Linux
> root@raspberrypi:~# perf test -vvv "Track with sched_switch" |& tail -50
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> cycles event
> sched_switch: cpu: 3 prev_tid 208750 next_tid 0
> sched_switch: cpu: 2 prev_tid 0 next_tid 195941
> sched_switch: cpu: 2 prev_tid 195941 next_tid 208748
> sched_switch: cpu: 2 prev_tid 208748 next_tid 0
> sched_switch: cpu: 3 prev_tid 0 next_tid 208750
> sched_switch: cpu: 3 prev_tid 208750 next_tid 34
> sched_switch: cpu: 3 prev_tid 34 next_tid 0
> sched_switch: cpu: 0 prev_tid 0 next_tid 208750
> sched_switch: cpu: 0 prev_tid 208750 next_tid 21
> sched_switch: cpu: 0 prev_tid 21 next_tid 0
> sched_switch: cpu: 1 prev_tid 0 next_tid 208750
> sched_switch: cpu: 1 prev_tid 208750 next_tid 24
> sched_switch: cpu: 1 prev_tid 24 next_tid 0
> sched_switch: cpu: 2 prev_tid 0 next_tid 208750
> sched_switch: cpu: 2 prev_tid 208750 next_tid 29
> sched_switch: cpu: 3 prev_tid 0 next_tid 208750
> sched_switch: cpu: 2 prev_tid 29 next_tid 0
> sched_switch: cpu: 3 prev_tid 208750 next_tid 34
> sched_switch: cpu: 3 prev_tid 34 next_tid 0
> sched_switch: cpu: 0 prev_tid 0 next_tid 208750
> sched_switch: cpu: 1 prev_tid 0 next_tid 208750
> sched_switch: cpu: 2 prev_tid 0 next_tid 208750
> sched_switch: cpu: 3 prev_tid 0 next_tid 208750
> 507 events recorded
> ---- end(0) ----
> 109: Track with sched_switch                                         : Ok
> root@raspberrypi:~#

Further info:

acme@raspberrypi:~/git/perf-tools-next $ readelf -wi ~/bin/perf | head -40
Contents of the .debug_info section:

  Compilation Unit @ offset 0:
   Length:        0x79b (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0
   Pointer Size:  8
 <0><c>: Abbrev Number: 22 (DW_TAG_compile_unit)
    <d>   DW_AT_producer    : (indirect string, offset: 0x9401): GNU C99 12.2.0 -mlittle-endian -mabi=lp64 -ggdb3 -std=gnu99 -fPIC -fasynchronous-unwind-tables
    <11>   DW_AT_language    : 12	(ANSI C99)
    <12>   DW_AT_name        : (indirect line string, offset: 0): fd/array.c
    <16>   DW_AT_comp_dir    : (indirect line string, offset: 0xb): /home/acme/git/perf-tools-next/tools/lib/api
    <1a>   DW_AT_low_pc      : 0xf80a0
    <22>   DW_AT_high_pc     : 0x650
    <2a>   DW_AT_stmt_list   : 0
    <2e>   DW_AT_macros      : 0
 <1><32>: Abbrev Number: 9 (DW_TAG_typedef)
    <33>   DW_AT_name        : (indirect string, offset: 0x44a1): size_t
    <37>   DW_AT_decl_file   : 2
    <38>   DW_AT_decl_line   : 214
    <39>   DW_AT_decl_column : 23
    <3a>   DW_AT_type        : <0x3e>
 <1><3e>: Abbrev Number: 5 (DW_TAG_base_type)
    <3f>   DW_AT_byte_size   : 8
    <40>   DW_AT_encoding    : 7	(unsigned)
    <41>   DW_AT_name        : (indirect string, offset: 0x137b): long unsigned int
 <1><45>: Abbrev Number: 23 (DW_TAG_pointer_type)
    <46>   DW_AT_byte_size   : 8
 <1><47>: Abbrev Number: 24 (DW_TAG_base_type)
    <48>   DW_AT_byte_size   : 4
    <49>   DW_AT_encoding    : 5	(signed)
    <4a>   DW_AT_name        : int
 <1><4e>: Abbrev Number: 5 (DW_TAG_base_type)
    <4f>   DW_AT_byte_size   : 1
    <50>   DW_AT_encoding    : 8	(unsigned char)
    <51>   DW_AT_name        : (indirect string, offset: 0x18e6): unsigned char
 <1><55>: Abbrev Number: 5 (DW_TAG_base_type)
    <56>   DW_AT_byte_size   : 2
    <57>   DW_AT_encoding    : 7	(unsigned)
acme@raspberrypi:~/git/perf-tools-next $
