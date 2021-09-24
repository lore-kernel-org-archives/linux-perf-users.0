Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10670C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6226124B
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbhIXSzM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhIXSzM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 14:55:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C8DC61241;
        Fri, 24 Sep 2021 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632509618;
        bh=HruFkRlruI3SA2YWxa1uOXIg2FOBJWsIAbQdkNVsclw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfO2E95sz37VoXgEJb0VicOBlEzpeL9kPwbLmKgK73sibjQ1K2z1ES3fZppSbOw3Y
         O3mJCtbTC8IV+aI0/8MqjBodZNP65TVzC6RCO9d62CRzNjKidmvCgfaw7LZQno30Pq
         3rgnyyVTtVpuYwhyyY006Y4HGB7hampEQvBBWIVEnpGckAGMnHbObSjrIaq3MokcHi
         uIEZUZFAYXvFME7wwpiXvnIJUxJIfNbERor1YPeC8JHnLiqoXZ2eO9QRKL3pVjI7RN
         J9aeXej5jEKksXFfSrDN7Ar3UFIH+5yechs2gI84iSmJLqBL3KlzEZgsO+hW0AnYTd
         Vhj0hN1NkZZGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92F46410A1; Fri, 24 Sep 2021 15:53:35 -0300 (-03)
Date:   Fri, 24 Sep 2021 15:53:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Fix flaky test 'Object code reading'
Message-ID: <YU4er4mzHfa4+7Jg@kernel.org>
References: <20210906152238.3415467-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906152238.3415467-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 06, 2021 at 04:22:38PM +0100, James Clark escreveu:
> This test occasionally fails on aarch64 when a sample is taken in
> free@plt and it fails with "Bytes read differ from those read by
> objdump". This is because that symbol is near a section boundary in the
> elf file. Despite the -z option to always output zeros, objdump uses
> bfd_map_over_sections() to iterate through the elf file so it doesn't
> see outside of the sections where these zeros are and can't print them.
> 
> For example this boundary proceeds free@plt in libc with a gap of 48
> bytes between .plt and .text:
> 
>   objdump -d -z --start-address=0x23cc8 --stop-address=0x23d08 libc-2.30.so
> 
>   libc-2.30.so:     file format elf64-littleaarch64
> 
>   Disassembly of section .plt:
> 
>   0000000000023cc8 <*ABS*+0x7fd00@plt+0x8>:
>      23cc8:	91018210 	add	x16, x16, #0x60
>      23ccc:	d61f0220 	br	x17
> 
>   Disassembly of section .text:
> 
>   0000000000023d00 <abort@@GLIBC_2.17-0x98>:
>      23d00:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
>      23d04:	910003fd 	mov	x29, sp
> 
> Taking a sample in free@plt is very rare because it is so small, but the
> test can be forced to fail almost every time on any platform by linking
> the test with a shared library that has a single empty function and
> calling it in a loop.
> 
> The fix is to zero the buffers so that when there is a jump in the
> addresses output by objdump, zeros are already filled in between.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/code-reading.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 9866cddebf23..9b4a765e4b73 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -229,8 +229,8 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  			    struct thread *thread, struct state *state)
>  {
>  	struct addr_location al;
> -	unsigned char buf1[BUFSZ];
> -	unsigned char buf2[BUFSZ];
> +	unsigned char buf1[BUFSZ] = {0};
> +	unsigned char buf2[BUFSZ] = {0};
>  	size_t ret_len;
>  	u64 objdump_addr;
>  	const char *objdump_name;
> -- 
> 2.28.0

-- 

- Arnaldo
