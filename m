Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87E1A303C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144920; cv=none; b=bbyc+Ehnt8w8K8LjM5ccMforWIwBJICqGVJT68NB35CYZ/01D8n1UVspPRtTIyWHGoMu505OZYHsdPhSThYJhronRRcb2/eb687EX7ZWSBntFNWYRni5GvPMMrLLGwrhXSjOOB6SG0KKfNBpFWPp1eYzYXD1vMHpYiYIAQX8U0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144920; c=relaxed/simple;
	bh=2tQ9EbsjgluWrv2hPOhzsdoBAvP8wO8eIJ7FHjdiNuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFcf3+XYKgTjriYmCp4sw6YjvTeYQZB7mRe1miI1AtVAV6FGQ7g7j3p1YUofEbjdeQqO0QS3PKiBXhdGfz4v7Bgs97IhUh/t7Ul5akbaHqqd2f6RjVkQewQfqA+pGAWpFcKNzfSFjhsaosnWh8d9zVHnFDHCCI0R0KZdUdJw8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZzDxoi5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZzDxoi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2325C4CEC3;
	Thu, 12 Sep 2024 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726144919;
	bh=2tQ9EbsjgluWrv2hPOhzsdoBAvP8wO8eIJ7FHjdiNuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZzDxoi5y4TuwOv/HoLEFi56O0Ge1bg7Up5dFJzZpRjTbxZStvXu9NMNAUwEDKorz
	 NkZqc/DslooWOx2ajwX5u2CsDp74BdW83sNqWWdemasTFBdwZaQy4DqNJU42fSAfOA
	 PnFFs0Qh0SmRDSYDzoTw/OnVMpA6znyKwy44qUnmwbfqCgf7ZHzwwzyf3uySBghzW3
	 T/9wSoV9XhFgQGuOuEQMbtX8FfmCJH+nlYQnhZEEfVXHOeyvC5/RBm+BS2mi1ScXhY
	 PlW6Lmhh1CGr7uTOm4zY3zBj4aYgTjO1P+Oloc0MZT+9Gk4toLuknbu/uqY5QzaJuO
	 jJRKwD9Zz8KnQ==
Date: Thu, 12 Sep 2024 09:41:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	namhyung@kernel.org
Subject: Re: [PATCH v1 01/10] perf: Avoid buffer overflow in python register
 interface
Message-ID: <ZuLhk6yGrr2HET6d@x1>
References: <20240905015300.2124798-1-ak@linux.intel.com>
 <20240905015300.2124798-2-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905015300.2124798-2-ak@linux.intel.com>

On Wed, Sep 04, 2024 at 06:50:09PM -0700, Andi Kleen wrote:
> Running a script that processes PEBS records gives buffer overflows
> in valgrind. The problem is that the allocation of the register
> string doesn't include the terminating 0 byte. Fix this. I also replaced
> the very magic "28" with a more reasonable larger buffer that should
> fit all registers. There's no need to conserve memory here.

I applied this one already.

But you used the wrong list address, perf-tools-users@vger, I'm fixing
this up now to linux-perf-users@vger so that the message reaches the
mailing list.

I waited a bit for reviewers but then realized the problem with the list
address when trying to use b4 to fetch it from lore :-\

- Arnaldo
 
> ==2106591== Memcheck, a memory error detector
> ==2106591== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
> ==2106591== Using Valgrind-3.22.0 and LibVEX; rerun with -h for copyright info
> ==2106591== Command: ../perf script -i tcall.data gcov.py tcall.gcov
> ==2106591==
> ==2106591== Invalid write of size 1
> ==2106591==    at 0x713354: regs_map (trace-event-python.c:748)
> ==2106591==    by 0x7134EB: set_regs_in_dict (trace-event-python.c:784)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
> ==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
> ==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
> ==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
> ==2106591==
> ==2106591== Invalid read of size 1
> ==2106591==    at 0x484B6C6: strlen (vg_replace_strmem.c:502)
> ==2106591==    by 0x555D494: PyUnicode_FromString (unicodeobject.c:1899)
> ==2106591==    by 0x7134F7: set_regs_in_dict (trace-event-python.c:786)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
> ==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
> ==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
> ==2106591==
> ==2106591== Invalid write of size 1
> ==2106591==    at 0x713354: regs_map (trace-event-python.c:748)
> ==2106591==    by 0x713539: set_regs_in_dict (trace-event-python.c:789)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
> ==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
> ==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
> ==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
> ==2106591==
> ==2106591== Invalid read of size 1
> ==2106591==    at 0x484B6C6: strlen (vg_replace_strmem.c:502)
> ==2106591==    by 0x555D494: PyUnicode_FromString (unicodeobject.c:1899)
> ==2106591==    by 0x713545: set_regs_in_dict (trace-event-python.c:791)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
> ==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
> ==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
> ==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
> ==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
> ==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
> ==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
> ==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
> ==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
> ==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
> ==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
> ==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
> ==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
> ==2106591==
> 73056 total, 29 ignored
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  .../perf/util/scripting-engines/trace-event-python.c  | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 6971dd6c231f..d7183134b669 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -762,6 +762,8 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
>  	}
>  }
>  
> +#define MAX_REG_SIZE 128
> +
>  static int set_regs_in_dict(PyObject *dict,
>  			     struct perf_sample *sample,
>  			     struct evsel *evsel)
> @@ -769,14 +771,7 @@ static int set_regs_in_dict(PyObject *dict,
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  	const char *arch = perf_env__arch(evsel__env(evsel));
>  
> -	/*
> -	 * Here value 28 is a constant size which can be used to print
> -	 * one register value and its corresponds to:
> -	 * 16 chars is to specify 64 bit register in hexadecimal.
> -	 * 2 chars is for appending "0x" to the hexadecimal value and
> -	 * 10 chars is for register name.
> -	 */
> -	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
> +	int size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
>  	char *bf = malloc(size);
>  	if (!bf)
>  		return -1;
> -- 
> 2.45.2
