Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78B1CEAA0;
	Tue,  5 Nov 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799515; cv=none; b=mxN2HI3JytJ8nehIzsRV9QbC9loaKb5W/b07BpVfrr6pQAN7kV38K2V2wDmZ5Z67WkjXB5LzXf7/zWOefsr6JNrrrQUyZY74fFP080lut241/W/sfIuIsK2S1eUZUTHUwCJo4mKzvPaGeFHy4k8c3605W3evQw1xn4hSqcNGp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799515; c=relaxed/simple;
	bh=fDEL/N20Y3umuzye8IqIHpB66G3yZ2uEyV6rkwYaOdI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Viayqo5SxFaFlkM/o+ZKrRrpFlklPxraA/wNS/vsz9UtkUFlMdoKqYMG4bly7UGwt27TCtIR2CuZMVLSHfldYg+o8peQ6dFBnSzEP6BybuaX+dFjl4gdb+6QtwfHL9cMiYaUAywPoNEYKq2ZQ42RGYF5TZybmHlkXAECJuYC9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u08gASRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u08gASRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EBAC4CED0;
	Tue,  5 Nov 2024 09:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730799514;
	bh=fDEL/N20Y3umuzye8IqIHpB66G3yZ2uEyV6rkwYaOdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u08gASRaKMDZlBGs3GDZaXMZIdYw4nE4aLrBzZFvYsvOvLPWuC9Ns2Wx297BGjsOO
	 W2OZXd6siGHsa/0XZVxcH0jBPET9yUooo6kHtfUKspmGD6Ea7MVRyDKm7xxuJVt5CR
	 n158z1uTPBPitswnTQtr3IX6jTteQdzrnI+r6MAsVW9n9SyC2Ka2VRyILASu3tWKob
	 gFFiQuvwtjm+qgbKtutQN0a8livEcaAleE3t5FMgKkIDuzMWNCDFBk58wFzfNkgqWK
	 Hr6Oa/iYP2qPuDnpfDb309S6lw0dVts6XO5xZRGP47361BTPFcw9kCy17WmklQKBfP
	 QImXUggSGobCA==
Date: Tue, 5 Nov 2024 18:38:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ian Rogers
 <irogers@google.com>, Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf-probe: Improbe non-C language support
Message-Id: <20241105183832.331db8547b5ec8ddeaabdc66@kernel.org>
In-Reply-To: <ZykppTmCLGqP9nGi@x1>
References: <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
	<ZykYwHifTM6niEmG@x1>
	<ZykppTmCLGqP9nGi@x1>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 17:08:05 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Mon, Nov 04, 2024 at 03:56:00PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 05, 2024 at 01:17:08AM +0900, Masami Hiramatsu (Google) wrote:
> > > Hi,
> 
> I also now noticed that the cover letter subject has a typo, it should
> be "Improve", not "Improbe" :-)

Lol, good catch! My finger learned that the next character of "pro" is "b".

Thank you,

> 
> - Arnaldo
>   
> > > Here is a series of patches for perf probe to improve non-C language
> > > (e.g. Rust, Go) support.
> >  
> > > The non-C symbols are demangled style in debuginfo, e.g. golang stores
> >  
> > > ----
> > > $ ./perf probe -x /work/go/example/outyet/main -F main*
> > > main.(*Server).ServeHTTP
> > > main.(*Server).ServeHTTP.Print.func1
> > > main.(*Server).poll
> > > ...
> > > -----
> > 
> > I presented about this last year:
> > 
> > https://tracingsummit.org/ts/2023/bpf-non-c/
> > https://tracingsummit.org/ts/2023/files/Trying_to_use_uprobes_and_BPF_on_non-C_userspace.pdf
> > https://www.youtube.com/watch?v=RDFRy1vWyHg&feature=youtu.be
> > 
> > So trying to do some of the things I did while playing with golang, and
> > with your patches applied, I only had to cope with a minor clash with a
> > patch by Ian Rogers that is present on perf-tools-next, related to:
> > 
> >         char buf[MAX_EVENT_NAME_LEN];
> > 
> > That in your patch expects the old 64 hard coded value, which will
> > appear in the my tests:
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -x main -F github*counter*
> > github.com/prometheus/client_golang/prometheus.(*counter).Add
> > github.com/prometheus/client_golang/prometheus.(*counter).AddWithExemplar
> > github.com/prometheus/client_golang/prometheus.(*counter).Collect
> > github.com/prometheus/client_golang/prometheus.(*counter).Desc
> > github.com/prometheus/client_golang/prometheus.(*counter).Describe
> > github.com/prometheus/client_golang/prometheus.(*counter).Inc
> > github.com/prometheus/client_golang/prometheus.(*counter).Write
> > github.com/prometheus/client_golang/prometheus.(*counter).updateExemplar
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -x main -F github*counter*
> > 
> > Then trying to add for all those:
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -d *:*
> > "*:*" does not hit any event.
> >   Error: Failed to delete events.
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -l
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus#
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -x main github*counter*
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > snprintf() failed: -7; the event name 'github_com_prometheus_client_golang_prometheus_counter_AddWithExemplar' is too long
> >   Hint: Set a shorter event with syntax "EVENT=PROBEDEF"
> >         EVENT: Event name (max length: 64 bytes).
> >   Error: Failed to add events.
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus#
> > 
> > But:
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -l
> >   probe_main:github_com_prometheus_client_golang_prometheus_counter_Desc (on github.com/prometheus/client_golang/prometheus.(*counter).Des>
> > (END)
> > 
> > That pager thing looks odd as well, since there is just one line in the
> > output...
> > 
> > So it failed to do all those, added just one, maybe state that some were
> > added but from the problematic one onwards it stopped? Or try all of
> > them and just state the ones that couldn't be added?
> > 
> > I.e. something like:
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -x main -F github*counter* | while read probename ; do perf probe -x main $probename ; done
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > Failed to find debug information for address 0x3287e0
> > Probe point 'github.com/prometheus/client_golang/prometheus.(*counter).Add' not found.
> >   Error: Failed to add events.
> > snprintf() failed: -7; the event name 'github_com_prometheus_client_golang_prometheus_counter_AddWithExemplar' is too long
> >   Hint: Set a shorter event with syntax "EVENT=PROBEDEF"
> >         EVENT: Event name (max length: 64 bytes).
> >   Error: Failed to add events.
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > Failed to find debug information for address 0x33ab40
> > Probe point 'github.com/prometheus/client_golang/prometheus.(*counter).Collect' not found.
> >   Error: Failed to add events.
> > Error: event "github_com_prometheus_client_golang_prometheus_counter_Desc" already exists.
> >  Hint: Remove existing event by 'perf probe -d'
> >        or force duplicates by 'perf probe -f'
> >        or set 'force=yes' in BPF source.
> >   Error: Failed to add events.
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > Failed to find debug information for address 0x33aba0
> > Probe point 'github.com/prometheus/client_golang/prometheus.(*counter).Describe' not found.
> >   Error: Failed to add events.
> > Added new event:
> >   probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc (on github.com/prometheus/client_golang/prometheus.(*counter).Inc in /home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc -aR sleep 1
> > 
> > Added new event:
> >   probe_main:github_com_prometheus_client_golang_prometheus_counter_Write (on github.com/prometheus/client_golang/prometheus.(*counter).Write in /home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe_main:github_com_prometheus_client_golang_prometheus_counter_Write -aR sleep 1
> > 
> > snprintf() failed: -7; the event name 'github_com_prometheus_client_golang_prometheus_counter_updateExemplar' is too long
> >   Hint: Set a shorter event with syntax "EVENT=PROBEDEF"
> >         EVENT: Event name (max length: 64 bytes).
> >   Error: Failed to add events.
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus#
> > 
> > In the end we get:
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf probe -l
> >   probe_main:github_com_prometheus_client_golang_prometheus_counter_Desc (on github.com/prometheus/client_golang/prometheus.(*counter).Desc@prometheus/counter.go in /home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >   probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc (on github.com/prometheus/client_golang/prometheus.(*counter).Inc@prometheus/counter.go in /home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >   probe_main:github_com_prometheus_client_golang_prometheus_counter_Write (on github.com/prometheus/client_golang/prometheus.(*counter).Write@prometheus/counter.go in /home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus#
> > 
> > That also explains the pager kicking in: I had to reduce font size in my
> > xterm (gnome-terminal really) and then the perf pager wasn't used (no
> > (END) at the last line waiting for me to press 'q').
> > 
> > The ones that got installed are working:
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf trace -e probe_main:*
> >      0.000 main/616840 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> >   1001.043 main/616926 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> >   1001.080 main/616926 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> >   4000.994 main/616926 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> > ^Croot@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# perf trace -e probe_main:*/max-stack=8/
> >      0.000 main/616926 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> >                                        github.com/prometheus/client_golang/prometheus.(*counter).Inc (/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >                                        runtime.goexit.abi0 (/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >      0.030 main/616926 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> >                                        github.com/prometheus/client_golang/prometheus.(*counter).Inc (/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >                                        runtime.goexit.abi0 (/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >   3000.166 main/616840 probe_main:github_com_prometheus_client_golang_prometheus_counter_Inc(__probe_ip: 7506464)
> >                                        github.com/prometheus/client_golang/prometheus.(*counter).Inc (/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> >                                        runtime.goexit.abi0 (/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus/main)
> > ^Croot@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus#
> > 
> > I'll test this some more later/tomorrow, just wanted to give this first
> > reaction, thanks for working on this!
> > 
> > Btw, some more info about the environment (fedora 40):
> > 
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus# readelf -wi main | head -20
> > Contents of the .debug_info section:
> > 
> >   Compilation Unit @ offset 0:
> >    Length:        0x506 (32-bit)
> >    Version:       4
> >    Abbrev Offset: 0
> >    Pointer Size:  8
> >  <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
> >     <c>   DW_AT_name        : google.golang.org/protobuf/internal/strs
> >     <35>   DW_AT_language    : 22	(Go)
> >     <36>   DW_AT_stmt_list   : 0
> >     <3a>   DW_AT_low_pc      : 0x667c40
> >     <42>   DW_AT_ranges      : 0
> >     <46>   DW_AT_comp_dir    : .
> >     <48>   DW_AT_producer    : Go cmd/compile go1.22.7; regabi
> >     <68>   Unknown AT value: 2905: strs
> >  <1><6d>: Abbrev Number: 5 (DW_TAG_subprogram)
> >     <6e>   DW_AT_name        : google.golang.org/protobuf/internal/strs.isASCIILower
> >     <a4>   DW_AT_inline      : 1	(inlined)
> >     <a5>   DW_AT_decl_line   : 188
> > root@x1:/home/acme/git/libbpf-bootstrap/examples/c/tests/prometheus#
> > 
> > - Arnaldo
> >  
> > > And Rust stores
> > > -----
> > > $ ./perf probe -x /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3 -F cro3::cmd::servo*
> > > cro3::cmd::servo::run
> > > cro3::cmd::servo::run::CALLSITE
> > > cro3::cmd::servo::run::CALLSITE::META
> > > cro3::cmd::servo::run_control
> > > -----
> > > 
> > > These symbols are not parsed correctly because it looks like a file name or
> > > including line numbers (`:` caused it.) So, I decided to introduce the changes
> > > 
> > >  - filename MUST start from '@'. (so it is able to distinguish the filename
> > >    and the function name)
> > >  - Fix to allow backslash to escape to --lines option.
> > >  - Introduce quotation mark support.
> > >  - Replace non-alnum character to '_' for event name (for non-C symbols).
> > > 
> > > With these changes, we can run -L (--lines) on golang;
> > > 
> > > ------
> > > $ perf probe -x goexample/hello/hello -L \"main.main\"
> > > <main.main@/work/goexample/hello/hello.go:0>
> > >       0  func main() {
> > >                 // Configure logging for a command-line program.
> > >       2         log.SetFlags(0)
> > >       3         log.SetPrefix("hello: ")
> > > 
> > >                 // Parse flags.
> > >       6         flag.Usage = usage
> > >       7         flag.Parse()
> > > ------
> > > 
> > > And Rust
> > > ------
> > > $ perf probe -x cro3 -L \"cro3::cmd::servo::run_show\"
> > > <run_show@/work/cro3/src/cmd/servo.rs:0>
> > >       0  fn run_show(args: &ArgsShow) -> Result<()> {
> > >       1      let list = ServoList::discover()?;
> > >       2      let s = list.find_by_serial(&args.servo)?;
> > >       3      if args.json {
> > >       4          println!("{s}");
> > > ------
> > > 
> > > And event name are created automatically like below;
> > > 
> > > $ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
> > > p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040
> > > 
> > > $ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
> > > p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530
> > > 
> > > We still need some more work, but these shows how perf-probe can work
> > > with other languages.
> > > 
> > > Thank you,
> > > 
> > > ---
> > > 
> > > Masami Hiramatsu (Google) (4):
> > >       perf-probe: Fix to ignore escaped characters in --lines option
> > >       perf-probe: Require '@' prefix for filename always
> > >       perf-probe: Introduce quotation marks support
> > >       perf-probe: Replace unacceptable characters when generating event name
> > > 
> > > 
> > >  tools/perf/util/probe-event.c  |  136 ++++++++++++++++++++++------------------
> > >  tools/perf/util/probe-finder.c |    3 +
> > >  tools/perf/util/string.c       |  100 +++++++++++++++++++++++++++++
> > >  tools/perf/util/string2.h      |    2 +
> > >  4 files changed, 180 insertions(+), 61 deletions(-)
> > > 
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
