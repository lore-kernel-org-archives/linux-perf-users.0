Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296838D41A;
	Sun, 30 Aug 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788095450; cv=none; b=KmIfgEyAZtQ4AchpwGXYC6+VP82KPOedd3aZwpWmq6OYbfZYvaOxdjApF+6o22pXwFwCLNaqZdMkrEEPwwOhKHj2UfJFEH3RM7yZ2ySi44a8VvmT3eo2I9JvPJQTBTHJpuYZJtL5E/Oj1422wxk6iDiD2jDnJJrUSUwc3fK0Fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788095450; c=relaxed/simple;
	bh=RdktVl9rJSg1dc4gnDF4+2Olbs7dpFV3Gp/zOMfl7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQAI/9MqXrVTK66vmdavVE/quLUMnLN/gds0cKRJftPHDzA860MY2FxAlcxznNg3Xbxipgww3lb1EdrBCGDwMZXPVVFBViTcF8WU0xarnUV3uOQ6I6l70+zJuSGBM4j03d5fybzzcS0Rlpf7PgUupcLoCBOu1zXHs2JjUg7LQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsIbgX3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsIbgX3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BFD1F000E9;
	Sun, 30 Aug 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788095448;
	bh=kjIBYKqjca5AJtwNJFjuYlFco4j1jiJIOswjnyir5Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VsIbgX3X2WaXH/SrvByDwvtIU7lhvKjUGtg89fgulyel8V48/lfZg8McK9C1XAuxK
	 58wr290cNK8CfDnKq4x8WaUs40WIPNBflW8StXFg35IkIK9I94bniOAq10ak6drVzl
	 p+ohUO3Y9epbrZw2/NdYHqeupalN+NTMSmqZjoC9HiXSMKaBtGx7jPfPX/sPhTgpXw
	 bB+y747G3UZ1HLiLfV6i1uiAPI8+361oMC9719lgebqSzjdmiwMVfasmPHHnJ4enrA
	 WI9btRB4o46ZLdeVpcZC6tZWO1wsTPtqDIeFCFsItVF6MXkN4/edrldzLfIGjxcvcR
	 bQJMTaPDfHqxw==
Date: Sun, 30 Aug 2026 10:10:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, tlipcon@google.com,
	eranian@google.com
Subject: Re: [PATCH] perf symbol: Do not use debug file as the binary type
Message-ID: <apQr1UOHdI9f0IqU@x2>
References: <20260825062345.115073-1-adrian.hunter@intel.com>
 <apCR1kJMBbdDC8B3@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCR1kJMBbdDC8B3@google.com>

On Thu, Aug 27, 2026 at 12:36:54PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Aug 25, 2026 at 09:23:45AM +0300, Adrian Hunter wrote:
> > dso__load() sets the binary type of a DSO to the type of the first symbol
> > source found. For a DSO with a separate debug file linked via
> > .gnu-debuglink, that is DSO_BINARY_TYPE__DEBUGLINK, which makes
> > dso__get_filename() return the name of the debug file instead of the file
> > that was actually executed.
> > 
> > Consumers that need to read instruction bytes, such as Intel PT decoding
> > in 'perf script', then read from the debug file and produce wrong
> > instructions.
> > 
> > Prefer DSO_BINARY_TYPE__BUILD_ID_CACHE, and otherwise
> > DSO_BINARY_TYPE__SYSTEM_PATH_DSO, over debug-only types, which restores
> > the behaviour of using a file that contains the executed instructions.
> > 
> > This is a workaround. Properly separating the binary file used for
> > instructions from the file used for debug symbols is left for later.
> > 
> > Example:
> > 
> >  Create a shared object with a separate .gnu_debuglink debug file. Note
> >  that 'objcopy --only-keep-debug' leaves .text as NOBITS, so instructions
> >  read from the debug file are zeros:
> > 
> >   # cat > foo.c << EOF
> >   unsigned long foo_work(unsigned long n)
> >   {
> >         unsigned long s = 0;
> > 
> >         for (unsigned long i = 0; i < n; i++)
> >                 s = s * 31 + i;
> >         return s;
> >   }
> >   EOF
> >   # cat > main.c << EOF
> >   #include <stdio.h>
> >   unsigned long foo_work(unsigned long n);
> >   int main(void)
> >   {
> >         printf("%lu\n", foo_work(1000));
> >         return 0;
> >   }
> >   EOF
> >   # gcc -g -O2 -shared -fPIC -o libfoo.so foo.c
> >   # gcc -g -O2 -o main main.c -L. -lfoo -Wl,-rpath,'$ORIGIN'
> >   # objcopy --only-keep-debug libfoo.so libfoo.so.debug
> >   # objcopy --strip-debug libfoo.so
> >   # objcopy --add-gnu-debuglink=libfoo.so.debug libfoo.so
> >   # perf record -e intel_pt//u ./main
> > 
> >  Note that branch samples must be requested, because it is the resolving
> >  of the branch target symbol that causes dso__load() to be called, and
> >  hence the binary type to be set, before the decoder walks the code.
> >  With '--itrace=e' alone, nothing loads symbols for libfoo.so, the binary
> >  type is left as DSO_BINARY_TYPE__NOT_FOUND, the correct file is read
> >  anyway, and no errors are reported either way.
> > 
> >  Before:
> > 
> >   # perf.before script --itrace=be 2>&1 | grep "instruction trace error"
> >    instruction trace error type 1 time 2350.467489498 cpu 9 pid 75634 tid 75634 ip 0x77d48480718f code 6: Trace doesn't match instruction
> >    instruction trace error type 1 time 2350.467489832 cpu 9 pid 75634 tid 75634 ip 0x77d484807341 code 6: Trace doesn't match instruction
> >    instruction trace error type 1 time 2350.467496412 cpu 9 pid 75634 tid 75634 ip 0x5b4de37a8074 code 6: Trace doesn't match instruction
> >    instruction trace error type 1 time 2350.467593393 cpu 9 pid 75634 tid 75634 ip 0x77d4848070d0 code 6: Trace doesn't match instruction
> >    instruction trace error type 1 time 2350.467593954 cpu 9 pid 75634 tid 75634 ip 0x77d4848075a8 code 6: Trace doesn't match instruction
> >    instruction trace error type 1 time 2350.467595728 cpu 9 pid 75634 tid 75634 ip 0x77d4848324de code 6: Trace doesn't match instruction
> >   6 instruction trace errors
> > 
> >  After:
> > 
> >   # perf script --itrace=be 2>&1 | grep "instruction trace error"
> >   #
> > 
> > Fixes: 5363c306787c8 ("perf symbol: Set binary_type of dso when loading")
> > Reported-by: Todd Lipcon <tlipcon@google.com>
> > Closes: https://lore.kernel.org/all/CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com/
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks for the patch and a test case.
> 
> Arnaldo, I can take this to the perf-tools tree for v7.3.

Ok!

- Arnaldo
