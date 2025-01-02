Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19D1B6D04
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jan 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841947; cv=none; b=UnRPCzv84B9wilLFIoicWEE0j0IbqVNnqh8UWl7M68KwRM9awUPFljU5gkw/yVmDtgNB1Xf57aZGCpoU+lPVVnzMqTziTD1pYquP9wgkD4wFK/7juapBT/ur4n7UsXZQwINXu5qpmZqKzhuD9rtKiIOyX6MmgKWMfzIXBPywRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841947; c=relaxed/simple;
	bh=C+B7cJEjJp4YNmF+xUZSUV1qdZ+4xB+vC3WEc/TXa7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAOt22WBckknXVR0Fozsd2uU/t14IwAleFt3mVDaY9N0z1JGA9kQ++u3os3rpNkCtPpanUiCugXnr48A093ikxVkrVL6YA6hlqqOrfKWAi/WC2rkNM68KCYPeRrUWoy193wx+dmAySSr/QGS2MByUUs0SE5ncuzM7hbAW2WX7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkhtc84J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkhtc84J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF4C4CED6;
	Thu,  2 Jan 2025 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735841945;
	bh=C+B7cJEjJp4YNmF+xUZSUV1qdZ+4xB+vC3WEc/TXa7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkhtc84JEEzRRRlZHOpz34abnKSSI999mLDN84Xq9rQp9IKG8fXtap47ghw4K8441
	 jtYKBcJ5oX9yRxt5KQt6KMNq2woJp6Qlk49O0b9TKe3f5+8OOU/6kP1aGI3msvS3wX
	 ibcZqrvKSl9LFjQP7GBWoIwU6JQ5QahPSdmZ9Q6I+T1fhQz4aHhZZCdm8GJvuk7JzD
	 a1xpi4qlsFvDUAVA5ld1kgd/P/D6efmthlOW1gEh0+dIZARYvdNQA629FKW87UNldu
	 kFMRzdxB1i532uaztgatqiCBmDWjPIRFyP3vZgmeNemBXs11TFB4EnotZxsluVpB96
	 5hu0N6CIlBqog==
Date: Thu, 2 Jan 2025 15:19:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
Message-ID: <Z3bYltoidQpqtyJ_@x1>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
 <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>

On Thu, Jan 02, 2025 at 03:41:17PM +0100, Christophe Leroy wrote:
> Le 26/12/2024 à 16:51, Arnaldo Carvalho de Melo a écrit :
> > On Tue, Dec 17, 2024 at 02:18:07PM +0000, James Clark wrote:
> > > On 16/12/2024 7:01 am, Christophe Leroy wrote:
> > > > I noticed with 6.12 LTS Kernel that perf top and perf record/report
> > > > don't display kernel symbols anymore, instead it displays the raw
> > > > address with [unknown] as object.

> > > > After bisect I see that the problem appears with commit 659ad3492b91
> > > > ("perf maps: Switch from rbtree to lazily sorted array for addresses").
> > > You might want to try applying 0b90dfda222e3 as it claims to fix this
> > > commit. I doubt that will fix your issue but it's worth being sure.
> > > There was also another fix recently that could be related: 23c44f6c83
> > > Did you try the perf-tools-next branch? Maybe something that's already fixed
> > > needs to be backported.

> > Right, I tried reproducing this on perf-tools-next and couldn't, so
> > please test it there.
 
> I tested it again on latest perf-tools-next (ed60738a9b7e ("perf stat:
> Document and clarify outstate members")) and still have the same problem,
> all kernel symbols appear as [unknown]:
 
>    PerfTop:    4163 irqs/sec  kernel:28.3%  exact:  0.0% lost: 0/0 drop:
> 0/14199 [4000Hz cpu-clock:ppp],  (all, 1 CPU)

So this seems to be on a virt environment? Or have you explicitely used
'-e cpu-clock:ppp'?

Also can you please run with -v or with -vv to see if we can get some
more clues?

Maybe it is somehow not able to read kallsyms or find a suitable
vmlinux?

Also what distro is this?

I did one more test, this time using --stdio on a raspberry pi and
explicitely using '-e cycles:ppp' to get as close to your report as I
could:

root@raspberrypi:~# uname -a
Linux raspberrypi 6.6.51+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.51-1+rpt3 (2024-10-08) armv7l GNU/Linux
root@raspberrypi:~# ~acme/bin/perf --version
perf version 6.13.rc2.ged60738a9b7e
root@raspberrypi:~# timeout 5s ~acme/bin/perf top -e cpu-cycles:ppp --stdio
   PerfTop:     926 irqs/sec  kernel:79.8%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-cycles:ppp],  (all, 4 CPUs)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    12.08%  perf              [.] io__get_char
     8.54%  perf              [.] kallsyms__parse
     5.35%  perf              [.] __symbols__insert
     3.87%  [kernel]          [k] module_get_kallsym
     3.74%  [kernel]          [k] default_idle_call
     3.69%  perf              [.] io__get_hex
     3.50%  [kernel]          [k] kallsyms_expand_symbol.constprop.0
     3.21%  perf              [.] rb_next
     2.84%  [kernel]          [k] format_decode
     2.53%  [kernel]          [k] number
     2.29%  [kernel]          [k] vsnprintf
     2.07%  libc.so.6         [.] __libc_calloc
     1.96%  libc.so.6         [.] strchr
     1.76%  [kernel]          [k] string
     1.47%  perf              [.] symbol__new
     1.42%  perf              [.] dso__load_sym_internal
     1.36%  libarmmem-v7l.so  [.] strlen
     1.26%  [kernel]          [k] memcpy
     1.15%  libc.so.6         [.] _int_malloc
     1.00%  perf              [.] strlist__node_cmp
     0.93%  perf              [.] rb_insert_color
     0.91%  [kernel]          [k] update_iter
     0.82%  perf              [.] eprintf
     0.80%  perf              [.] rblist__find
     0.79%  libc.so.6         [.] memset
     0.74%  perf              [.] map__process_kallsym_symbol
     0.73%  [kernel]          [k] finish_task_switch
     0.69%  perf              [.] veprintf
     0.57%  [kernel]          [k] strscpy
     0.55%  perf              [.] perf_hpp__is_dynamic_entry
     0.49%  libelf-0.188.so   [.] gelf_getsym
     0.48%  [kernel]          [k] seq_printf
     0.48%  libelf-0.188.so   [.] gelf_getphdr
     0.46%  libc.so.6         [.] strcmp
     0.45%  [kernel]          [k] memset
     0.40%  [kernel]          [k] s_show
     0.40%  [kernel]          [k] pointer
     0.37%  [kernel]          [k] seq_read_iter
     0.35%  perf              [.] hist_entry__cmp
root@raspberrypi:~#
