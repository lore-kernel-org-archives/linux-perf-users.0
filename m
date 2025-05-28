Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99028C2B3
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457327; cv=none; b=LjYIU6DDKV5Pw6sZ+nM2awZjSywP2L6XGSKPErjlcn0rOkPZLSrj8c7Xfwzp/wjiEpgBgt+JzeteFMCM0VHAhs85DVvc13sSUNIIbK2XnrpPb8yZaiwhzRYiR2CdMA0vmP9Bt8VTUbs2OmyCpnJOWfHi073WrACkrJEM1UZMBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457327; c=relaxed/simple;
	bh=bNwVIjro2hm2W/uPvcuRGNXSIOJ1ZT5+JyjzWLDylcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7u/tWnUIlSlBn+xIFSnnNWGLcfTqWPPOPg9XnjqFmCa9akGUqvNtg/9tQI2qKnTAKiTs1kkUmoewBfKoQN4Sxm7cYBCoicJbFPxVN9o0zJOCvp3laXUm2y0F3gHuYhsqIxQVADiPBDh1gJuTW/aNP9I6jHamB/k/5u+DwbaMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdrPj5M5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdrPj5M5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F7BC4CEED;
	Wed, 28 May 2025 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748457327;
	bh=bNwVIjro2hm2W/uPvcuRGNXSIOJ1ZT5+JyjzWLDylcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdrPj5M5B2hoMHxdg5LHLBcmb6v8+oNRhnW5+4rcjFdU+8jzVTLku+oTmemMsoH9s
	 3PgymRWsj6XoG7u8AYmJ2+viTVVBBIpADLmVr84r+H7+YPyry4ONTKR+laZklXj6nf
	 MaP98VKpT2U8KrZ6bANCn336K0J4yaRbclCQcIOStZfm3L4nhESLF/BFlJZaur7wut
	 Hf0QO3Srh4bKme0v2WGe5QqpVJgkPcNuwrvLUdtWMg/GE8N0k7TUBaXQv8FG1mPhc4
	 CIxC/vRj931hmxF5jOrRLG7aU/lRAy6u2qAf7wgbDyRTOLMwCk9AEzKfU7fSnMvKsH
	 yB7QgR6NQ5N/g==
Date: Wed, 28 May 2025 15:35:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, mpetlan@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf trace: always print return value for syscalls with
 set errpid
Message-ID: <aDdXbJijYfgyGEQ4@x1>
References: <20250403160411.159238-2-ashelat@redhat.com>
 <aCogx3jPtKTQOPa0@google.com>
 <CA+G8DhK05FPgdLhN0LVYsDUTsJou4x4BxqycbPweGYgL_b4_VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G8DhK05FPgdLhN0LVYsDUTsJou4x4BxqycbPweGYgL_b4_VQ@mail.gmail.com>

On Tue, May 27, 2025 at 12:34:34PM -0400, Anubhav Shelat wrote:
>    Every time I ran perf trace I saw that the return value for only
>    set_robust_list and rseq was empty, even though while stepping through
>    the code the return value was 0. So I do think that these are the right
>    syscalls.
>    The cause of the problem is that no thread id is returned, so the logic
>    skips printing the return value. The change ensures the return value

Well:

RETURN VALUE
       The set_robust_list() and get_robust_list() system calls return zero when the operation is successful, an error code otherwise.

and rset return -errno on failure, so they are both not returning a pid
and should print errno when less than zero.

>    always gets printed. Another solution would be to set errpid to false
>    for both set_robust_list and rseq.

Can you please send a new patch with this? please add a Fixes tag as
well, for these two csets:

⬢ [acme@toolbx perf-tools-next]$ git blame tools/perf/builtin-trace.c  | grep -E '"(rseq|set_robust_list)"'
0c1019e3463b263a8 (Arnaldo Carvalho de Melo    2024-09-11 16:34:16 -0300 1351) 	{ .name	    = "rseq",	    .errpid = true,
1de5b5dcb8353f365 (Arnaldo Carvalho de Melo    2024-09-11 17:10:33 -0300 1375) 	{ .name	    = "set_robust_list",	    .errpid = true,
⬢ [acme@toolbx perf-tools-next]$ 

My mistake, that was a copy'n'paste error, those '.errpid = true'
shouldn't be there, as you noticed.

The first patch from you is also valid, but due to a different reason,
as Namhyung pointed out.

So I'm applying it now.

- Arnaldo

>    Best, Anubhav

>    On Sun, May 18, 2025 at 2:03 PM Namhyung Kim <[1]namhyung@kernel.org>
>    wrote:
> 
>      On Thu, Apr 03, 2025 at 12:04:12PM -0400, Anubhav Shelat wrote:
>      > Currently some syscalls that have errpid set to true do not print
>      a
>      > return value in perf trace. The syscalls that were consistently
>      > observed were set_robust_list and rseq. This is because perf
>      cannot find
>      > their child process. This change ensures that the return value is
>      always
>      > printed.
>      >
>      > Before:
>      >      0.256 ( 0.001 ms): set_robust_list(head: 0x7f09c77dba20, len:
>      24)                        =
>      >      0.259 ( 0.001 ms): rseq(rseq: 0x7f09c77dc0e0, rseq_len: 32,
>      sig: 1392848979)             =
>      > After:
>      >      0.270 ( 0.002 ms): set_robust_list(head: 0x7f0bb14a6a20, len:
>      24)                        = 0
>      >      0.273 ( 0.002 ms): rseq(rseq: 0x7f0bb14a70e0, rseq_len: 32,
>      sig: 1392848979)             = 0
> 
>      I'm ok with the change but I'm not sure if they are right syscalls.
>      It
>      seems neither of syscalls return a thread id.
> 
>      Thanks,
>      Namhyung
> 
>      >
>      > Signed-off-by: Anubhav Shelat <[2]ashelat@redhat.com>
>      > ---
>      >  tools/perf/builtin-trace.c | 2 +-
>      >  1 file changed, 1 insertion(+), 1 deletion(-)
>      >
>      > diff --git a/tools/perf/builtin-trace.c
>      b/tools/perf/builtin-trace.c
>      > index 6ac51925ea42..c192f0219b2b 100644
>      > --- a/tools/perf/builtin-trace.c
>      > +++ b/tools/perf/builtin-trace.c
>      > @@ -3005,8 +3005,8 @@ errno_print: {
>      >       else if (sc->fmt->errpid) {
>      >               struct thread *child =
>      machine__find_thread(trace->host, ret, ret);
>      >
>      > +             fprintf(trace->output, "%ld", ret);
>      >               if (child != NULL) {
>      > -                     fprintf(trace->output, "%ld", ret);
>      >                       if (thread__comm_set(child))
>      >                               fprintf(trace->output, " (%s)",
>      thread__comm_str(child));
>      >                       thread__put(child);
>      > --
>      > 2.48.1
>      >
> 
> References
> 
>    1. mailto:namhyung@kernel.org
>    2. mailto:ashelat@redhat.com
