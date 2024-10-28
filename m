Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C7190664
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131387; cv=none; b=LaO6cN6nTcE+VmWA9ugItpdR/taj69VeZe7ZPNMuSXNXmcV2oSvo/khVlWVirNhhY8Z3mibrZFXiLOR8olfRK2w9xhaczYElSnmuLEHgb9aU7PLb4Qd4XtZIOX2v/+IDIIeae48/Yu73LKOwrLtSNz27cG8WYGwfEq9mK53e45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131387; c=relaxed/simple;
	bh=ZYUSOO2Nd0Kgy3Q3WrqVvCV+6tw1rMi4LljcnPwbRuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnVhR7L1xDYNVoHt+zjKIUNYwieWEUppIzLC5NRgOeZjSwxKApEbtYBwghG2Ry/pNKh2ZXDydADFaZ5S/x15vyYwhyyhQ0Dqj1ClEG7AuJVN7Hq95XmJt53S5A0lD8YotCsbVKwKNmR4wUiyDm34PH5a2zOHxh8wJKyfaY9NAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r00AfGWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r00AfGWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DD9C4CEC3;
	Mon, 28 Oct 2024 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730131387;
	bh=ZYUSOO2Nd0Kgy3Q3WrqVvCV+6tw1rMi4LljcnPwbRuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r00AfGWoSRf63qISQY7ShuI2HkKdt0FddRcUnoKetLOgap8s6c4P5bbKj5+vZ4Z1h
	 Cj9/o5JIVi4vJMzVOTJKi82LDxxqO1vI8GqDAkXjyoqlTmviRmtKhrCiiNDRkomM56
	 FWkP2bcAiAl0yHjUzZx8m28LfCYV/KN7IdvuiG/xE97vKB3BQLJSf95Op3twRk4gVN
	 XxBgivgfUI39wpGmSOEn9M6pDRvyGiPIPDpqmUdlw27n3J47ujCDC1Vqy9PD6Kq/Po
	 IsY+dU/Ibni6XH85CyLD1aRjXfDDbvHAxH3kigCmpvSjRmL9cHGaKgk/HNfZeYLR9a
	 /3k7dohq3q1IA==
Date: Mon, 28 Oct 2024 13:03:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Can perf drop libunwind support
Message-ID: <Zx-1tx0eH19iBpjy@x1>
References: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>

On Wed, Oct 23, 2024 at 02:57:05PM -0700, Ian Rogers wrote:
> Hi,
> 
> perf wants to build with BPF support these days. libbpf has a
> dependency on libelf, part of elfutils. libdw is also part of elfutils
> and amongst other things provides unwinding support. My understanding
> is libdw unwinding is used by perf in preference to libunwind when
> present. My suspicion is that libunwind is being feature tested,
> linked against but then seldom or never used. Given this could perf
> drop libunwind support in order to simplify the code base?

Probably Jiri remembers the reasons for us to have support for both,
IIRC libunwind was a bit more mature at the time and so we decided to
have both and when some broken behaviour appears we try the other one,
in the process trying to fix the one wioth a problem?

Adding Frederic as well, this is when we started to use libunwind:

commit 6a40cd90f5deb6dec322eeb54587ae55a934db2c
Author: Jiri Olsa <jolsa@redhat.com>
Date:   Tue Aug 7 15:20:44 2012 +0200

    perf tools: Add libunwind dependency for DWARF CFI unwinding
    
    Adding libunwind to be linked with perf if available. It's required
    for the to get dwarf cfi unwinding support.
    
    Also building perf with the dwarf call frame informations by default,
    so that we can unwind callchains in perf itself.
    
    Adding LIBUNWIND_DIR Makefile variable allowing user to specify
    the directory with libunwind to be linked. This is used for
    debug purposes.
    
    Signed-off-by: Jiri Olsa <jolsa@redhat.com>
    Original-patch-by: Frederic Weisbecker <fweisbec@gmail.com>


There is a long discussion on tests, etc on the cover letter for that
series:

https://lore.kernel.org/all/1344345647-11536-11-git-send-email-jolsa@redhat.com/T/#m0121f16278e049a2fe510c4c37884832e3c1f41d


And then later Jiri added support for libdw's unwinder:

commit 5ea8415407a76c4a85ac971ec82d110161cd77f1
Author: Jiri Olsa <jolsa@redhat.com>
Date:   Wed Feb 19 16:52:57 2014 +0100

    perf tools: Add libdw DWARF post unwind support
    
    Adding libdw DWARF post unwind support, which is part of
    elfutils-devel/libdw-dev package from version 0.158.
    
    The new code is contained in unwin-libdw.c object, and implements
    unwind__get_entries unwind interface function.
    
    New Makefile variable NO_LIBDW_DWARF_UNWIND was added to control its
    compilation, and is marked as disabled now.  It's factored with the rest
    of the Makefile unwind build code in the next patch.
    
    Arch specific code was added for x86.
    
    Signed-off-by: Jiri Olsa <jolsa@redhat.com>
    Cc: Corey Ashford <cjashfor@linux.vnet.ibm.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Jean Pihet <jean.pihet@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Link: http://lkml.kernel.org/r/1392825179-5228-5-git-send-email-jolsa@redhat.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

But I couldn't find a discussion about why we decided to keep both, some
more investigation would be interesting to see if there are systems that
are better supported using libunwind than with libdw.

- Arnaldo
 
> Possible savings:
>  - remove libunwind's 8 feature tests
>  - removal of 10 arch or not libunwind C files in perf
>  - removal of libunwind #ifdef-ed code throughout common files.
> 
> Thanks,
> Ian
